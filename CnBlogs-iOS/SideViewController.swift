//
//  SideViewController.swift
//  CnBlogs-iOS
//
//  Created by enjoy on 2019/11/4.
//  Copyright © 2019 rsenjoyer. All rights reserved.
//

import UIKit
import Login
import Common


protocol SideViewControllerDelegate: NSObjectProtocol {
    func sideViewController(vc: SideViewController, didSelectedItem item: ModuleComponent)
}

public enum CellComponent: String {
    case logged
    case unlogged
    case home
    case knowledge
    case problem
    case setting
}

extension SideViewController {
    static func make() -> SideViewController {
        return UIStoryboard.main.instantiateViewController(withIdentifier: "SideViewController") as! SideViewController
    }
}

class SideViewController: UIViewController {
    
    var dataSoruce: [CellComponent] {
        return [.logged, .unlogged, .home, .knowledge, .problem, .setting]
    }
    
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
        return self.dataSoruce.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = indexPath.row == 0 ? "Cell" : "Cell"
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
        cell.textLabel?.text = "Login"
        
        return cell 
    }
        
}

extension SideViewController: UITableViewDelegate {
        
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        RouterService.shared.navigate(toFeature: LoginFeature.self, fromView: self)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return indexPath.row == 0 ? 66 : 44
    }
    
}
