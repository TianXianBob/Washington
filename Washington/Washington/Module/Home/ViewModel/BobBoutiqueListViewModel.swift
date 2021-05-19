//
//  BobBoutiqueListViewModel.swift
//  Washington
//
//  Created by bob on 2021/5/12.
//

import Foundation
import HandyJSON

class BobBoutiqueListViewModel {
    typealias BoutiqueCallBack = ([ComicListModel]?) -> Void
    
    let sectionInfoModels = [
        ComicListModel(comicType: .none, canedit: false, sortId: 0, titleIconUrl: nil, newTitleIconUrl: nil, description: nil, itemTitle: "强力推荐作品", argCon: 0, argName: "强力推荐作品", argValue: 0, argType: 0, comics: nil, maxSize: 0, canMore: true, hasMore: true, spinnerList: nil, defaultParameters: nil, page: 0),
        ComicListModel(comicType: .none, canedit: false, sortId: 0, titleIconUrl: nil, newTitleIconUrl: nil, description: nil, itemTitle: "古诗词", argCon: 0, argName: "古诗词", argValue: 0, argType: 0, comics: nil, maxSize: 0, canMore: true, hasMore: true, spinnerList: nil, defaultParameters: nil, page: 0),
        ComicListModel(comicType: .none, canedit: false, sortId: 0, titleIconUrl: nil, newTitleIconUrl: nil, description: nil, itemTitle: "故事集", argCon: 0, argName: "故事集", argValue: 0, argType: 0, comics: nil, maxSize: 0, canMore: true, hasMore: true, spinnerList: nil, defaultParameters: nil, page: 0),
        ComicListModel(comicType: .none, canedit: false, sortId: 0, titleIconUrl: nil, newTitleIconUrl: nil, description: nil, itemTitle: "儿歌", argCon: 0, argName: "儿歌", argValue: 0, argType: 0, comics: nil, maxSize: 0, canMore: true, hasMore: true, spinnerList: nil, defaultParameters: nil, page: 0),
        
    ]
    
    func getListJsonData(with fileName: String) -> [[String : Any]]? {
        guard let p = Bundle.main.path(forResource: fileName, ofType: "json") else {
            return nil
        }
        
        guard FileManager.default.fileExists(atPath: p) else {
            return nil
        }
        
        let url = URL(fileURLWithPath: p)
        
        var json: [[String : Any]]?
        do {
            let data = try Data(contentsOf: url)
            guard let d = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [[String : Any]] else {
                return nil
            }
            
            json = d
        } catch let error {
            print("读取本地数据出现错误!",error)
        }
        
        
        return json
    }

    func getSectionDatas(with key: String) -> [ComicModel]? {
        guard let json = getListJsonData(with: key) else {
            return nil
        }
        
        guard let jsonData = try? JSONSerialization.data(withJSONObject: json, options: JSONSerialization.WritingOptions()) else {
            return nil
        }
        
        let jsonStr = String(data: jsonData, encoding: String.Encoding(rawValue: String.Encoding.utf8.rawValue))
        
        guard let models = JSONDeserializer<HomeListModel>.deserializeModelArrayFrom(json: jsonStr) else {
            return nil
        }
        
        
        let comicModels = models.compactMap { (l) -> ComicModel? in
            guard let listModel = l else {
                return nil
            }
            
            return ComicModel.init(comicId: listModel.rid, comic_id: listModel.rid, cate_id: listModel.rid, name: listModel.sourceName, title: listModel.sourceName, itemTitle: nil, subTitle: nil, author_name: nil, author: nil, cover: listModel.iconUrl, wideCover: nil, content: "\(listModel.totalNumber)", description: listModel.description, short_description: listModel.description, affiche: nil, tag: nil, tags: nil, group_ids: nil, theme_ids: nil, url: nil, read_order: 0, create_time: 0, last_update_time: 0, deadLine: 0, new_comic: false, chapter_count: 0, cornerInfo: 0, linkType: 0, specialId: 0, specialType: 0, argName: nil, argValue: 0, argCon: listModel.rid, flag: 0, conTag: 0, isComment: false, is_vip: false, isExpired: false, canToolBarShare: true, ext: nil)
        }
        
        return comicModels
    }
    
    
    func loadData(_ callback: @escaping BoutiqueCallBack) {
        //        Bob_ApiProvider.bob_request(.sources(sourceId: .baobaoXue), model: [HomeListModel].self) { (data) in
        //            callback(data)
        //        }
        //
        let datas = self.sectionInfoModels.compactMap() { (listModel) -> ComicListModel? in
            var mutableListModel = listModel
            guard let key = listModel.itemTitle else {
                return nil
            }
            
            guard let models = getSectionDatas(with: key) else {
                return nil
            }
            
            mutableListModel.comics = models
            return mutableListModel
        }
        
        callback(datas)
    }
}
