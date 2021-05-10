//
//  BobModel.swift
//  Washington
//
//  Created by bob on 2021/5/7.
//

import HandyJSON

struct RecommandListModel: HandyJSON {
    var addTime: String?
    var iconName: String?
    var iconUrl: String?
    var isDeleted: Bool = false
    var modifyTime: String?
    var number: Int = 0
    var playUrl: Int = 0
    var serverNextPage: String?
    var rid: Int = 0
    var sourceId: Int = 0
}
