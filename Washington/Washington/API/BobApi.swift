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
    case sourceDetail(sourceId: String)//详情列表
    case sources(sourceId: SourcesCategoryName)//首页列表
}


enum SourcesCategoryName: String {
    case baobaoXue = "baobaoxueAd"
    case tangshiqimeng = "tangshiqimeng"
    case tangAd = "TangAd"
    case tangshiqimeng23 = "tangshiqimeng23"
    case tangshiqimeng56 = "tangshiqimeng56"
}

extension BobApi: TargetType {
    var sampleData: Data { return "".data(using: String.Encoding.utf8)! }
    var headers: [String : String]? { return ["Content-type" : "application/json"]}
    
    var baseURL: URL { return URL(string: "http://hope.wuqiongda8888.com")! }

    var path: String {
        switch self {
        case .sourceDetail: return "source/sourceDetails"
        case .sources: return "source/sources"
        }
    }
    
    var method: Moya.Method { return .post }

    
    var task: Task {
        var parmeters: [String : Any] = [:]
        switch self {
        case .sourceDetail(let sourceId):
            parmeters["sourceId"] = sourceId
        case .sources(sourceId: let sourceId):
            parmeters["categoryName"] = sourceId.rawValue
        }
        return .requestParameters(parameters: parmeters, encoding: JSONEncoding.default)
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
            guard let returnData = try? result.value?.bob_mapModel(BobResponseData<T>.self) else {
                completion(nil)
                return
            }
            completion(returnData.data)
        })
    }
}

extension Response {
    func bob_mapModel<T: HandyJSON>(_ type: T.Type) throws -> T {
        let jsonString = String(data: data, encoding: .utf8)
        
        guard let model = JSONDeserializer<T>.deserializeFrom(json: jsonString) else {
            throw MoyaError.jsonMapping(self)
        }
        return model
    }
   
    
    func bob_mapModelArray<T: HandyJSON>(_ type: T.Type) throws -> [T?] {
        let jsonString = String(data: data, encoding: .utf8)
        
        guard let modelArray = [T].deserialize(from: jsonString) else {
            throw MoyaError.jsonMapping(self)
        }
        return modelArray
    }
}
