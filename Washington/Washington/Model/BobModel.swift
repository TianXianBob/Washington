//
//  BobModel.swift
//  Washington
//
//  Created by bob on 2021/5/7.
//

import HandyJSON

struct ContentListModel: HandyJSON, Equatable {
    var addTime: String?
    var iconName: String?
    var iconUrl: String?
    var isDeleted: Bool = false
    var modifyTime: String?
    var number: Int = 0
    var playUrl: String?
    var serverNextPage: String?
    var rid: Int = 0
    var sourceId: Int = 0
}

struct BobVideoModel: HandyJSON {
    var addTime: String?
    var iconName: String?
    var iconUrl: String?
    var playUrl: String?
    var rid: Int = 0
    var sourceId: Int = 0
}





struct HomeListModel: HandyJSON {
    var addTime: String?
    var description: String?
    var iconUrl: String?
    var isDeleted: Bool = false
    var modifyTime: String?
    var remark: String?
    var playUrl: Int = 0
    var serverNextPage: String?
    var sourceName: String?
    var rid: Int = 0
    var status: String?
    var tag: String?
    var totalNumber: Int = 0
    var type: String?
}

struct BobResponseData<T: HandyJSON>: HandyJSON {
    var code: Int = 0
    var data: T?
    var message: String = ""
}

struct BobReturnData<T: HandyJSON>: HandyJSON {
    var returnData: T?
}

extension Array: HandyJSON {
    
}


