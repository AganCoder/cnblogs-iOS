//
//  SideViewController.swift
//  CnBlogs-iOS
//
//  Created by enjoy on 2019/11/4.
//  Copyright © 2019 rsenjoyer. All rights reserved.
//

import UIKit

extension SideViewController {
    static func make() -> SideViewController {
        return UIStoryboard.main.instantiateViewController(withIdentifier: "SideViewController") as! SideViewController
    }
}

class SideViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView! {
        didSet {
            self.tableView.delegate = self
            self.tableView.dataSource = self
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

}

extension SideViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = indexPath.row == 0 ? "NickNameCell" : "TitleCell"
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
        
        return cell
    }
        
}

extension SideViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        debugPrint("\(indexPath)")
            
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return indexPath.row == 0 ? 66 : 44
    }
    
}
