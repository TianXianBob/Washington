//
//  BobVideoFileManager.swift
//  Washington
//
//  Created by chenxingchen on 2021/6/21.
//

import UIKit

enum BobVideoType: String {
    case qianziwen = "千字文"
    case dizigui = "弟子规"
    case baijiaxin = "百家姓"
    case guoxue = "国学"
    case yingyuerge = "英语儿歌"
    case gushi = "故事"
    case tonghuagushi = "童话故事"
    case yuyangushi = "寓言故事"
    case chengyugushi = "成语故事"
    case huibengushi = "绘本故事"
    case jindiangushi = "经典故事"
    case erge = "儿歌"
    case donghuapian = "动画片"
    case sanzijing = "三字经"
    case gushiwen = "古诗文"
}

enum BobVideoSet: String {
    case dula = "嘟拉"
    case qingbao = "亲宝"
    case xionghaizi = "熊孩子"
    case mengbao = "萌宝"
    case maoxiaoshuai = "猫小帅"
    case beilehu = "贝乐虎"
    case baobao84 = "宝宝巴士"
    case yienzhuangyuan = "伊恩庄园"
    case ruiqi88 = "瑞奇宝宝"
    case leduomeng = "乐多梦"
    case beiwa = "贝瓦"
    case qiankejiazu = "仱可家族"
    case world = "世界"
    case zhongguo = "中国"
}

struct BobVideoFileModel {
    var type: BobVideoType
    var fileName: String
    var set: BobVideoSet
}

class BobVideoFileManager: NSObject {
    static let shared = BobVideoFileManager()
    
    let files: [BobVideoFileModel] = [
        BobVideoFileModel(type: .qianziwen, fileName: "dula_qianziwen", set: .dula),
        BobVideoFileModel(type: .dizigui, fileName: "qingbao_dizigui", set: .qingbao),
        BobVideoFileModel(type: .baijiaxin, fileName: "dula_baijiaxing", set: .dula),
        BobVideoFileModel(type: .guoxue, fileName: "xionghaizi_Guoxue", set: .xionghaizi),
        BobVideoFileModel(type: .guoxue, fileName: "mengbao_Guoxue", set: .mengbao),
        BobVideoFileModel(type: .yingyuerge, fileName: "maoxiaoshuai_enErGe", set: .maoxiaoshuai),
        BobVideoFileModel(type: .yingyuerge, fileName: "beilehu_enErGe", set: .beilehu),
        BobVideoFileModel(type: .yingyuerge, fileName: "baobao84_enErGe", set: .baobao84),
        BobVideoFileModel(type: .yingyuerge, fileName: "xionghaizi_enErGe", set: .xionghaizi),
        BobVideoFileModel(type: .yingyuerge, fileName: "mengbao_enErGe", set: .mengbao),
        BobVideoFileModel(type: .gushi, fileName: "baobao84_huiben_strory", set: .baobao84),
        BobVideoFileModel(type: .gushi, fileName: "ruiqi88_story", set: .ruiqi88),
        BobVideoFileModel(type: .tonghuagushi, fileName: "maoxiaoshuai_tonghua_story", set: .maoxiaoshuai),
        BobVideoFileModel(type: .gushi, fileName: "beilehu_story", set: .beilehu),
        BobVideoFileModel(type: .gushi, fileName: "xionghaizi_story", set: .xionghaizi),
        BobVideoFileModel(type: .yuyangushi, fileName: "maoxiaoshuai_yuyan_story", set: .maoxiaoshuai),
        BobVideoFileModel(type: .tonghuagushi, fileName: "leduomeng_tonghua_story", set: .leduomeng),
        BobVideoFileModel(type: .gushi, fileName: "beiwa_story", set: .beiwa),
        BobVideoFileModel(type: .chengyugushi, fileName: "maoxiaoshuai_chengyu_story", set: .maoxiaoshuai),
        BobVideoFileModel(type: .tonghuagushi, fileName: "liankejiazu_tonghua_story", set: .qiankejiazu),
        BobVideoFileModel(type: .tonghuagushi, fileName: "world_tonghua_story", set: .world),
        BobVideoFileModel(type: .jindiangushi, fileName: "zhongguo_jingdian_story", set: .zhongguo),
        BobVideoFileModel(type: .chengyugushi, fileName: "zhongguo_chengyu_story", set: .zhongguo),
        BobVideoFileModel(type: .chengyugushi, fileName: "beilehu_huiben_story", set: .beilehu),
    ]
    
    
}
