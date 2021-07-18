//
//  BobRecommendListViewController.swift
//  Washington
//
//  Created by chenxingchen on 2021/6/15.
//

import UIKit

class BobRecommendListViewController: BobBaseViewController {

    private let tableView = UITableView(frame: .zero, style: .grouped)
    private let vm = BobRecommendListViewModel()
    private let identify = "BobRecommendVideoTableViewCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()

    }
    
}


extension BobRecommendListViewController {
    private func setup() {
        view.backgroundColor = .white
        
        do {
            tableView.separatorStyle = .none
            tableView.backgroundColor = .white
            tableView.delegate = self
            tableView.dataSource = self
            tableView.register(BobRecommendVideoTableViewCell.self, forCellReuseIdentifier: identify)
            view.addSubview(tableView)
            tableView.snp.makeConstraints { make in
                make.edges.equalToSuperview()
            }
        }
    }
}

extension BobRecommendListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return vm.models.count
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: identify) as? BobRecommendVideoTableViewCell else {
            return .init()
        }
        
        return cell
    }
    
    
}

extension BobRecommendListViewController: UITableViewDelegate {
    
}
