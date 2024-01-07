//
//  WebService.swift
//  BemLembrado
//
//  Created by Vinicius Wessner on 07/11/23.
//

import Foundation

enum WebService {
    
    enum Endpoint: String{
        case base = "https://habitplus-api.tiagoaguiar.co"
        //create user
        case postUsers = "/users"
        //update user
        case updateUser = "/users/%d"
        //users info
        case fetchUsers = "/users/me"
        //login
        case login = "/auth/login"
        //refresh token
        case refreshToken = "/auth/refresh-token"
        //lista dos meus habitos
        case habits = "/users/me/habits"
        //buscar valor do habito
        case habitValues = "/users/me/habits/%d/values"
    }
    
    enum NetworkError {
        case badRequest
        case notFound
        case unauthorized
        case internalServerError
    }
    
    enum Method: String {
        case get
        case post
        case put
        case delete
    }
    
    enum Result {
        case success(Data)
        case failure(NetworkError, Data?)
    }
    
    enum ContentType: String {
        case json = "application/json"
        case formUrl = "application/x-www-form-urlencoded"
    }
    
    
    private static func completeUrl(path: String) -> URLRequest? {
        guard let url = URL(string: "\(Endpoint.base.rawValue)\(path)") else {return nil}
        return URLRequest(url: url)
        
    }
        
    public static func call(path: String,
                            method: Method,
                             contentType: ContentType,
                             data: Data?,
                             completion: @escaping (Result) -> Void){
        
        
        guard var urlRequest = completeUrl(path: path) else { return }
        
        _ = LocalDataSource.shared.getUserAuth()
          .sink { userAuth in
            if let userAuth = userAuth {
              urlRequest.setValue("\(userAuth.tokenType) \(userAuth.idToken)", forHTTPHeaderField: "Authorization")
            }
            
            urlRequest.httpMethod = method.rawValue
            urlRequest.setValue("application/json", forHTTPHeaderField: "accept")
            urlRequest.setValue(contentType.rawValue, forHTTPHeaderField: "Content-Type")
            urlRequest.httpBody = data
                
                let task = URLSession.shared.dataTask(with: urlRequest){data, response, error in
                    //roda em background
                    guard let data = data, error == nil else {
                        print(error)
                        completion(.failure(.internalServerError, nil))
                        return
                    }
                    
                    if let r = response as? HTTPURLResponse{
                        switch r.statusCode {
                        case 400:
                            completion(.failure(.badRequest, data))
                            break
                        case 401:
                            completion(.failure(.unauthorized, data))
                            break
                        case 200:
                            completion(.success(data))
                        default:
                            break
                        }
                    }
                    
                    print(String(data: data, encoding: .utf8))
                    print("response\n")
                    print(response)
                    
                    
                }
                
                task.resume()
            }
       
        
    }
    // funcao que busca a lista de tarefas
    public static func call(path: Endpoint,
                                          method: Method = .get,
                                           completion: @escaping (Result) -> Void) {
        call(path: path.rawValue, method: method, contentType: .json, data: nil, completion: completion)
    }
    
    //call json
    public static func call<T: Encodable>(path: Endpoint,
                                          method: Method = .get,
                                           body: T,
                                           completion: @escaping (Result) -> Void) {
        
        guard let jsonData = try? JSONEncoder().encode(body) else {return}
        call(path: path.rawValue, method: method, contentType: .json, data: jsonData, completion: completion)
    }
    
    //call json que espera uma string (usando para detalhes da tarefa)
    public static func call<T: Encodable>(path: String,
                                          method: Method = .get,
                                           body: T,
                                           completion: @escaping (Result) -> Void) {
        
        guard let jsonData = try? JSONEncoder().encode(body) else {return}
        call(path: path, method: method, contentType: .json, data: jsonData, completion: completion)
    }
    
    
    //call formdata login
    public static func call(path: Endpoint,
                            method: Method = .post,
                             params: [URLQueryItem],
                             completion: @escaping (Result) -> Void) {
        
        guard let urlRequest = completeUrl(path: path.rawValue) else {return}
        guard let absoluteURL = urlRequest.url?.absoluteString else {return}
        var components = URLComponents(string: absoluteURL)
        components?.queryItems = params
        
        call(path: path.rawValue,
             method: method,
             contentType: .formUrl,
             data: components?.query?.data(using: .utf8),
             completion: completion)

    }
    
    

    
}

