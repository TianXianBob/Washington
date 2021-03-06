//
//  BobSearchViewController.swift
//  Washington
//
//  Created by Bob on 2021/11/10.
//  Copyright © 2021年 None. All rights reserved.
//

import UIKit
import Moya

class BobSearchViewController: BobBaseViewController {
    private let vm = BobBoutiqueListViewModel()
    private var currentRequest: Cancellable?
    
    private var hotItems = [SearchItemModel]()
    private var hotModels = [ComicModel]()
    private var relative: [ComicModel]?
    private var comicLists = [ComicListModel]()
//    private var comics: [ComicModel]?
    private var comics = [ComicModel]()
    private lazy var searchHistory: [String]! = {
        return UserDefaults.standard.value(forKey: String.searchHistoryKey) as? [String] ?? [String]()
    }()
    
    private lazy var searchBar: UITextField = {
        let sr = UITextField()
        sr.backgroundColor = UIColor.white
        sr.textColor = UIColor.gray
        sr.tintColor = UIColor.darkGray
        sr.font = UIFont.systemFont(ofSize: 15)
        sr.placeholder = "输入视频名称/关键词"

        sr.layer.cornerRadius = 15
        sr.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: 15))
        sr.leftViewMode = .always
        sr.clearButtonMode = .whileEditing
        sr.returnKeyType = .search
        sr.delegate = self
        NotificationCenter.default.addObserver(self, selector: #selector(textFiledTextDidChange(noti:)), name: UITextField.textDidChangeNotification, object: sr)
        return sr
    }()
    
    private lazy var historyTableView: UITableView = {
        let tw = UITableView(frame: CGRect.zero, style: .grouped)
        tw.delegate = self
        tw.dataSource = self
        tw.register(headerFooterViewType: USearchTHead.self)
        tw.register(cellType: BobBaseTableViewCell.self)
        tw.register(headerFooterViewType: BobSearchTFoot.self)
        return tw
    }()
    
    
    lazy var searchTableView: UITableView = {
        let sw = UITableView(frame: CGRect.zero, style: .grouped)
        sw.delegate = self
        sw.dataSource = self
        sw.register(headerFooterViewType: USearchTHead.self)
        sw.register(cellType: BobBaseTableViewCell.self)
        return sw
    }()
    
    lazy var resultTableView: UITableView = {
        let rw = UITableView(frame: CGRect.zero, style: .grouped)
        rw.delegate = self
        rw.dataSource = self
        rw.register(cellType: UComicTCell.self)
        return rw
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadHistory()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    private func loadHistory() {
        historyTableView.isHidden = false
        searchTableView.isHidden = true
        resultTableView.isHidden = true

        vm.loadData {[weak self] data in
            guard let self = self else { return }
            
            guard let m = data else {
                // 请求失败
                return
            }
            self.comicLists = m
            var newArray = [ComicModel]()
            for sets in m {
                if let comics = sets.comics, comics.count > 0 {
                    newArray.append(comics[0])
                }
                
                if let comics = sets.comics, comics.count > 1 {
                    newArray.append(comics[1])
                }
            }
            self.hotItems = newArray.map { model in
                return SearchItemModel(comic_id: model.comicId, name: model.name, bgColor: nil)
            }
            
            self.hotModels = newArray
//            self.comicLists = m
            self.historyTableView.reloadData()
        }
        
    }
    
    private func searchRelative(_ text: String) {
        if text.count > 0 {
            historyTableView.isHidden = true
            searchTableView.isHidden = false
            resultTableView.isHidden = true
            
            _search(text) { models in
                self.relative = models
                self.searchTableView.reloadData()
            }
            
        } else {
            historyTableView.isHidden = false
            searchTableView.isHidden = true
            resultTableView.isHidden = true
        }
    }
    
    private func searchResult(_ text: String) {
        if text.count > 0 {
            historyTableView.isHidden = true
            searchTableView.isHidden = true
            resultTableView.isHidden = false
            searchBar.text = text
//            ApiLoadingProvider.request(UApi.searchResult(argCon: 0, q: text), model: SearchResultModel.self) { (returnData) in
//                self.comics = returnData?.comics
//                self.resultTableView.reloadData()
//            }
            
            
        } else {
            historyTableView.isHidden = false
            searchTableView.isHidden = true
            resultTableView.isHidden = true
        }
    }
    
    private func updateLocalData(_ text: String) {
        if text.count == 0 {
            return
        }
        let defaults = UserDefaults.standard
        var histoary = defaults.value(forKey: String.searchHistoryKey) as? [String] ?? [String]()
        histoary.removeAll([text])
        histoary.insertFirst(text)
        
        searchHistory = histoary
        historyTableView.reloadData()
        
        defaults.set(searchHistory, forKey: String.searchHistoryKey)
        defaults.synchronize()
    }
    
    private func _search(_ text:String, _ callback: ([ComicModel]) -> ()) {
        var results = [ComicModel]()
        for comicList in comicLists {
            guard let comics = comicList.comics else {
                continue
            }
            let result: [ComicModel] = comics.filter({ m in
                if m.title?.containsIgnoringCase(find: text) ?? false || m.name?.containsIgnoringCase(find: text) ?? false  {
                   return true
               } else {
                   return false
               }
           })
            
            results += result
        }
        
        callback(results)
    }

    
    override func configUI() {
        view.addSubview(historyTableView)
        historyTableView.snp.makeConstraints { $0.edges.equalTo(self.view.usnp.edges) }
        
        view.addSubview(searchTableView)
        searchTableView.snp.makeConstraints { $0.edges.equalTo(self.view.usnp.edges) }
        
        
        view.addSubview(resultTableView)
        resultTableView.snp.makeConstraints { $0.edges.equalTo(self.view.usnp.edges) }
    }
    
    override func configNavigationBar() {
        super.configNavigationBar()
        searchBar.frame = CGRect(x: 0, y: 0, width: UScreenWidth - 50, height: 30)
        navigationItem.titleView = searchBar
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: nil,
                                                           style: .plain,
                                                           target: nil,
                                                           action: nil)
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "取消",
                                                            target: self,
                                                            action: #selector(cancelAction))
    }
    
    @objc private func cancelAction() {
        searchBar.resignFirstResponder()
        navigationController?.popViewController(animated: true)
    }

}

extension BobSearchViewController: UITextFieldDelegate {
    
    @objc func textFiledTextDidChange(noti: Notification) {
        guard let textField = noti.object as? UITextField,
            let text = textField.text else { return }
        searchRelative(text)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return textField.resignFirstResponder()
    }
}

extension BobSearchViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if tableView == historyTableView {
            return 2
        } else {
            return 1
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == historyTableView {
            return section == 0 ? (searchHistory?.prefix(5).count ?? 0) : 0
        } else if tableView == searchTableView {
            return relative?.count ?? 0
        } else {
            return comics.count
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if tableView == resultTableView {
            return 180
        } else {
            return 44
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == historyTableView {
            let cell = tableView.dequeueReusableCell(for: indexPath, cellType: BobBaseTableViewCell.self)
            cell.textLabel?.text = searchHistory?[indexPath.row]
            cell.textLabel?.textColor = UIColor.darkGray
            cell.textLabel?.font = UIFont.systemFont(ofSize: 13)
            cell.separatorInset = .zero
            return cell
        } else if tableView == searchTableView {
            let cell = tableView.dequeueReusableCell(for: indexPath, cellType: BobBaseTableViewCell.self)
            cell.textLabel?.text = relative?[indexPath.row].name
            cell.textLabel?.textColor = UIColor.darkGray
            cell.textLabel?.font = UIFont.systemFont(ofSize: 13)
            cell.separatorInset = .zero
            return cell
        } else if tableView == resultTableView {
            let cell = tableView.dequeueReusableCell(for: indexPath, cellType: UComicTCell.self)
            cell.model = comics[indexPath.row]
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(for: indexPath, cellType: BobBaseTableViewCell.self)
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView == historyTableView {
            searchBar.text = searchHistory[indexPath.row]
            searchRelative(searchHistory[indexPath.row])
        } else if tableView == searchTableView {
            if let r = relative {
                let m = r[indexPath.row]
                let vc = BobComicDetailViewController(comicid: m.comicId, comic: m)
                navigationController?.pushViewController(vc, animated: true)
                updateLocalData(m.title ?? "")
            }
            
            
        } else if tableView == resultTableView {
            let m = comics[indexPath.row]
            let vc = BobComicDetailViewController(comicid: m.comicId, comic: m)
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if tableView == historyTableView {
            return 44
        } else if tableView == searchTableView {
            return comics.count > 0 ? 44 : CGFloat.leastNormalMagnitude
        } else {
            return CGFloat.leastNormalMagnitude
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if tableView == historyTableView {
            let head = tableView.dequeueReusableHeaderFooterView(USearchTHead.self)
            head?.titleLabel.text = section == 0  ? "看看你都搜过什么" : "大家都在搜"
            head?.moreButton.setImage(section == 0 ? UIImage(named: "search_history_delete") : UIImage(named: "search_keyword_refresh"), for: .normal)
            head?.moreButton.isHidden = section == 0 ? (searchHistory.count == 0) : true
            head?.moreActionClosure { [weak self] in
                if section == 0 {
                    self?.searchHistory?.removeAll()
                    self?.historyTableView.reloadData()
                    UserDefaults.standard.removeObject(forKey: String.searchHistoryKey)
                    UserDefaults.standard.synchronize()
                }
            }
            return head
        } else if tableView == searchTableView {
            let head = tableView.dequeueReusableHeaderFooterView(USearchTHead.self)
            head?.titleLabel.text = "找到相关的漫画 \(comics.count ) 本"
            head?.moreButton.isHidden = true
            return head
        } else {
            return nil
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if tableView == historyTableView {
            return section == 0 ? 10 : tableView.frame.height - 44
        } else {
            return CGFloat.leastNormalMagnitude
        }
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        if tableView == historyTableView && section == 1 {
            let foot = tableView.dequeueReusableHeaderFooterView(BobSearchTFoot.self)
            foot?.data = hotItems
            foot?.didSelectIndexClosure{ [weak self] (index, model) in
                guard let self = self else { return }
                
                let comicModel = self.hotModels[index]
                let vc = BobComicDetailViewController(comicid: comicModel.comic_id, comic: comicModel)
                self.navigationController?.pushViewController(vc, animated: true)
            }
            return foot
        } else {
            return nil
        }
    }
}



