//
//  BobVideoFileManager.swift
//  Washington
//
//  Created by chenxingchen on 2021/6/21.
//

import UIKit
import HandyJSON

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
    case null = "其他"
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
    case green = "格林"
    case yiqianlingyi = "一千零一夜"
    case guliguli = "咕力咕力"
    case hali = "哈利"
    case keyi = "可一"
    case huohuotu = "火火兔"
    case landi = "蓝迪"
    case chaojifeixia = "超级飞侠"
    case xiaozhupeiqi = "小猪佩奇"
    case zhuzhuxia = "猪猪侠"
    case xiongchumo = "熊出没"
    case xiaomabaoli = "小马宝莉"
    case bianxingijngche = "变形警车"
    case wangwangdadui = "汪汪大队"
    case maohelaoshu = "猫和老鼠"
    case daomeixiong = "倒霉熊"
    case xiaojiaoya = "小脚丫"
    
}


struct BobVideoFileModel {
    var type: BobVideoType
    var fileName: String
    var set: BobVideoSet
    var setName: String = ""
}

class BobVideoFileManager {
    static let shared = BobVideoFileManager()
    let videoSetJsonNames = ["古诗词", "儿歌", "故事集"]
    
    
    
    public func loadFile() {
        let models = files.compactMap {[weak self] (m) -> [BobVideoModel]? in
            guard let self = self else {return nil}
            
            guard let d = self.loadWithJsonWithFileName(m.fileName) else {
                return nil
            }
            
            let jsonString = String(data: d, encoding: .utf8)
            
            guard let modelArray = [BobVideoModel].deserialize(from: jsonString) else {
                return nil
            }
            
            guard let ms: [BobVideoModel] = modelArray.filter({ (model) -> Bool in
                return model != nil
            }) as? [BobVideoModel] else {
                return nil
            }
            
            return ms
        }
        
        print(models)
//        files.compactMap { (model) -> [BobVideoModel]？ in
//            guard let data = loadWithJsonWithFileName(model.fileName) else {
//                return nil
//            }
//        }
        //        { (model) -> [BobVideoModel]？ in
        //            guard let data = loadWithJsonWithFileName(model.fileName) else {
        //                return nil
        //            }
        //        }
        
        
    }
    
    private func loadWithJsonWithFileName(_ fileName: String) -> Data? {
        guard let path = Bundle.main.path(forResource: fileName, ofType: "json") else { return nil }
        let url = URL(fileURLWithPath: path)
        do {
            let localData = try Data(contentsOf: url)
            return localData
        } catch let error {
            print(error)
        }
        
        return nil
    }
    
    let files: [BobVideoFileModel] = [
        BobVideoFileModel(type: .qianziwen, fileName: "dula_qianziwen", set: .dula, setName: "嘟拉千字文"),
        BobVideoFileModel(type: .dizigui, fileName: "qingbao_dizigui", set: .qingbao, setName: "亲宝弟子规"),
        BobVideoFileModel(type: .baijiaxin, fileName: "dula_baijiaxing", set: .dula, setName: "嘟拉百家姓"),
        BobVideoFileModel(type: .guoxue, fileName: "xionghaizi_Guoxue", set: .xionghaizi, setName: "熊孩子国学"),
        BobVideoFileModel(type: .guoxue, fileName: "mengbao_Guoxue", set: .mengbao, setName: "萌宝国学"),
        BobVideoFileModel(type: .yingyuerge, fileName: "maoxiaoshuai_enErGe", set: .maoxiaoshuai, setName: "猫小帅英语儿歌"),
        BobVideoFileModel(type: .yingyuerge, fileName: "beilehu_enErGe", set: .beilehu, setName: "贝乐虎英语儿歌"),
        BobVideoFileModel(type: .yingyuerge, fileName: "baobao84_enErGe", set: .baobao84, setName: "宝宝巴士英语儿歌"),
        BobVideoFileModel(type: .yingyuerge, fileName: "xionghaizi_enErGe", set: .xionghaizi, setName: "熊孩子英语儿歌"),
        BobVideoFileModel(type: .yingyuerge, fileName: "mengbao_enErGe", set: .mengbao, setName: "萌宝英语儿歌"),
        BobVideoFileModel(type: .gushi, fileName: "baobao84_huiben_strory", set: .baobao84, setName: "宝宝巴士绘本故事"),
        BobVideoFileModel(type: .gushi, fileName: "ruiqi88_story", set: .ruiqi88, setName: "瑞奇宝宝故事集"),
        BobVideoFileModel(type: .tonghuagushi, fileName: "maoxiaoshuai_tonghua_story", set: .maoxiaoshuai, setName: "猫小帅童话故事"),
        BobVideoFileModel(type: .gushi, fileName: "beilehu_story", set: .beilehu, setName: "贝乐虎故事集"),
        BobVideoFileModel(type: .gushi, fileName: "xionghaizi_story", set: .xionghaizi, setName: "熊孩子故事集"),
        BobVideoFileModel(type: .yuyangushi, fileName: "maoxiaoshuai_yuyan_story", set: .maoxiaoshuai, setName: "猫小帅寓言故事"),
        BobVideoFileModel(type: .tonghuagushi, fileName: "leduomeng_tonghua_story", set: .leduomeng, setName: "乐多梦童话故事"),
        BobVideoFileModel(type: .gushi, fileName: "beiwa_story", set: .beiwa, setName: "贝瓦故事"),
        BobVideoFileModel(type: .chengyugushi, fileName: "maoxiaoshuai_chengyu_story", set: .maoxiaoshuai, setName: "猫小帅成语故事"),
        BobVideoFileModel(type: .tonghuagushi, fileName: "liankejiazu_tonghua_story", set: .qiankejiazu, setName: "仱可家族童话故事"),
        BobVideoFileModel(type: .tonghuagushi, fileName: "world_tonghua_story", set: .world, setName: "世界童话故事"),
        BobVideoFileModel(type: .jindiangushi, fileName: "zhongguo_jingdian_story", set: .zhongguo, setName: "中国经典故事"),
        BobVideoFileModel(type: .chengyugushi, fileName: "zhongguo_chengyu_story", set: .zhongguo, setName: "中国成语故事"),
        BobVideoFileModel(type: .chengyugushi, fileName: "beilehu_huiben_story", set: .beilehu, setName: "贝乐虎绘本故事"),
        BobVideoFileModel(type: .gushi, fileName: "dula_story", set: .dula, setName: "嘟拉故事集"),
        BobVideoFileModel(type: .tonghuagushi, fileName: "green_tonghua_story", set: .green, setName:  "格林童话故事"),
        BobVideoFileModel(type: .tonghuagushi, fileName: "1001_shenghua_story", set: .yiqianlingyi, setName: "一千零一夜"),
        BobVideoFileModel(type: .erge, fileName: "maoxiaoshaui_erge", set: .maoxiaoshuai, setName: "猫小帅儿歌"),
        BobVideoFileModel(type: .erge, fileName: "beilehu_erge", set: .beilehu, setName: "贝乐虎儿歌"),
        BobVideoFileModel(type: .erge, fileName: "baobao84_jingdian_erge", set: .baobao84, setName: "宝宝巴士经典儿歌"),
        BobVideoFileModel(type: .erge, fileName: "guliguli_erge", set: .guliguli, setName: "咕力咕力儿歌"),
        BobVideoFileModel(type: .erge, fileName: "hali_erge", set: .hali, setName: "哈利儿歌"),
        BobVideoFileModel(type: .erge, fileName: "keyi_erge", set: .keyi, setName: "可一儿歌"),
        BobVideoFileModel(type: .erge, fileName: "huohuotu_erge", set: .huohuotu, setName: "火火兔儿歌"),
        BobVideoFileModel(type: .erge, fileName: "landi_erge", set: .landi, setName: "蓝迪儿歌"),
        BobVideoFileModel(type: .erge, fileName: "xionghaizi_erge", set: .xionghaizi, setName: "熊孩子儿歌"),
        BobVideoFileModel(type: .erge, fileName: "mengbao_erge", set: .mengbao, setName: "萌宝儿歌"),
        BobVideoFileModel(type: .erge, fileName: "baobao84_jianbihua_erge", set: .baobao84, setName: "宝宝巴士简笔画儿歌"),
        BobVideoFileModel(type: .erge, fileName: "baobao84_hanzi1_erge", set: .baobao84, setName: "宝宝巴士汉字儿歌第一季"),
        BobVideoFileModel(type: .erge, fileName: "baobao84_hanzi2_erge", set: .baobao84, setName: "宝宝巴士汉字儿歌第二季"),
        BobVideoFileModel(type: .donghuapian, fileName: "chaojifeixia3_cartoon", set: .chaojifeixia, setName: "超级飞侠3"),
        BobVideoFileModel(type: .donghuapian, fileName: "chaojifeixia6_cartoon", set: .chaojifeixia, setName: "超级飞侠6"),
        BobVideoFileModel(type: .donghuapian, fileName: "chaojifeixia2_cartoon", set: .chaojifeixia, setName: "超级飞侠2"),
        BobVideoFileModel(type: .donghuapian, fileName: "xiaozhupeiqi_cartoon", set: .xiaozhupeiqi, setName: "小猪佩奇"),
        BobVideoFileModel(type: .donghuapian, fileName: "zhuzhuxia_cartoon", set: .zhuzhuxia, setName: "猪猪侠"),
        BobVideoFileModel(type: .donghuapian, fileName: "xiongchumo_duiduipeng_cartoon", set: .xiongchumo, setName: "熊出没对对碰"),
        BobVideoFileModel(type: .donghuapian, fileName: "xiongchumo_lianliankan_cartoon", set: .xiongchumo, setName: "熊出没连连看"),
        BobVideoFileModel(type: .donghuapian, fileName: "xiaomabaoli_cartoon", set: .xiaomabaoli, setName: "小马宝莉"),
        BobVideoFileModel(type: .donghuapian, fileName: "bianxingjingche_cartoon", set: .xiaomabaoli, setName: "变形警车"),
        BobVideoFileModel(type: .donghuapian, fileName: "chaojifeixia1_cartoon", set: .xiaomabaoli, setName: "超级飞侠3"),
        BobVideoFileModel(type: .donghuapian, fileName: "xiyangyang_cartoon", set: .xiaomabaoli, setName: "喜洋洋"),
        BobVideoFileModel(type: .donghuapian, fileName: "ruiqibaobao_cartoon", set: .ruiqi88, setName: "瑞奇宝宝卡通"),
        BobVideoFileModel(type: .donghuapian, fileName: "wangwangdadui1_cartoon", set: .wangwangdadui, setName: "汪汪大队"),
        BobVideoFileModel(type: .donghuapian, fileName: "maohelaoshu1_cartoon", set: .maohelaoshu, setName: "猫和老鼠1"),
        BobVideoFileModel(type: .donghuapian, fileName: "maohelaoshu2_cartoon", set: .maohelaoshu, setName: "猫和老鼠2"),
        BobVideoFileModel(type: .donghuapian, fileName: "daomeixiong1_cartoon", set: .daomeixiong, setName: "倒霉熊1"),
        BobVideoFileModel(type: .donghuapian, fileName: "daomeixiong2_cartoon", set: .daomeixiong, setName: "倒霉熊2"),
        BobVideoFileModel(type: .sanzijing, fileName: "beilehu_sanzijing", set: .beilehu, setName: "贝乐虎三字经"),
        BobVideoFileModel(type: .sanzijing, fileName: "story_sanzijing", set: .null, setName: "三字经故事集"),
        BobVideoFileModel(type: .sanzijing, fileName: "guoxue_sanzijing", set: .zhongguo, setName: "国学三字经"),
        BobVideoFileModel(type: .sanzijing, fileName: "normal_sanzijing", set: .null, setName: "三字经"),
        BobVideoFileModel(type: .gushiwen, fileName: "beilehu_poem", set: .beilehu, setName: "贝乐虎古诗"),
        BobVideoFileModel(type: .gushiwen, fileName: "beiwa_poem", set: .beiwa, setName: "贝瓦古诗"),
        BobVideoFileModel(type: .gushiwen, fileName: "qingbao_poem", set: .qingbao, setName: "亲宝古诗"),
        BobVideoFileModel(type: .gushiwen, fileName: "mengbao_poem", set: .mengbao, setName: "萌宝古诗"),
        BobVideoFileModel(type: .gushiwen, fileName: "xiaojiaoya_poem", set: .xiaojiaoya, setName: "小脚丫古诗"),
        BobVideoFileModel(type: .gushiwen, fileName: "xiaolu_poem", set: .null, setName: "小鹿古诗"),
        BobVideoFileModel(type: .gushiwen, fileName: "aishanggushi_poem", set: .null, setName: "爱上古诗"),
        BobVideoFileModel(type: .gushiwen, fileName: "dongdong_poem", set: .null, setName: "东东古诗"),
        BobVideoFileModel(type: .gushiwen, fileName: "aixuexi_poem", set: .null, setName: "爱学习古诗"),
        BobVideoFileModel(type: .gushiwen, fileName: "other_poem", set: .null, setName: "古诗词"),
        BobVideoFileModel(type: .gushiwen, fileName: "mimitegongdui_poem", set: .null, setName: "迷你特工队古诗"),
        BobVideoFileModel(type: .gushiwen, fileName: "baobao84_poem", set: .baobao84, setName: "宝宝巴士古诗"),
        BobVideoFileModel(type: .gushiwen, fileName: "maoxiaoshuai_poem", set: .maoxiaoshuai, setName: "猫小帅古诗词"),
        BobVideoFileModel(type: .gushiwen, fileName: "dula_poem", set: .dula, setName: "嘟啦古诗词"),
        BobVideoFileModel(type: .gushiwen, fileName: "huohuotu_poem", set: .huohuotu, setName: "火火兔古诗词"),
        BobVideoFileModel(type: .gushiwen, fileName: "zhixiang_poem", set: .null, setName: "智象古诗词"),
    ]
    
    
}
