//
//  BobApi.swift
//  Washington
//
//  Created by bob on 2021/5/7.
//

import Moya
import HandyJSON
import MBProgressHUD

//MARK: 无loading请求
let Bob_ApiProvider = MoyaProvider<BobApi>(requestClosure: timeoutClosure)
//MARK: 有loading请求
let Bob_ApiLoadingProvider = MoyaProvider<BobApi>(requestClosure: timeoutClosure, plugins: [LoadingPlugin])

//MARK: API定义
enum BobApi {
    case sourceDetail(sourceId: SourceDeatail)//详情列表
   
}

enum SourceDeatail: String {
    case beilehu_gushi = "2"
    case beiwa_tangshi = "18"
}

extension BobApi: TargetType {
    var sampleData: Data { return "".data(using: String.Encoding.utf8)! }
    var headers: [String : String]? { return nil }
    
    var baseURL: URL { return URL(string: "http://hope.wuqiongda8888.com")! }

    var path: String {
        switch self {
        case .sourceDetail: return "source/sourceDetails"
        }
    }
    
    var method: Moya.Method { return .post }

    
    var task: Task {
        var parmeters: [String : Any] = [:]
        switch self {
        case .sourceDetail(let sourceId):
            parmeters["sourceId"] = sourceId    
        }
        
        return .requestParameters(parameters: parmeters, encoding: URLEncoding.default)
    }
}

//MARK: 统一请求封装
extension MoyaProvider {
    @discardableResult
    open func bob_request<T: HandyJSON>(_ target: Target,
                                    model: T.Type,
                                    completion: ((_ returnData: T?) -> Void)?) -> Cancellable? {
        
        return request(target, completion: { (result) in
            guard let completion = completion else { return }
            guard let returnData = try? result.value?.mapModel(ResponseData<T>.self) else {
                completion(nil)
                return
            }
            completion(returnData.data?.returnData)
        })
    }
}
