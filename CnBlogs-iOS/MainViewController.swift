//
//  MainViewController.swift
//  CnBlogs-iOS
//
//  Created by enjoy on 2019/11/3.
//  Copyright © 2019 rsenjoyer. All rights reserved.
//

import UIKit
import Blog
import Login
import Common
import Compose

extension UIStoryboard {
    static var main: UIStoryboard {
        return UIStoryboard(name: "Main", bundle: nil)
    }
}

public enum ModuleComponent: CaseIterable {
    
    case login
    case blog
    case news
    case knowledge
    case compose
    case problem
    
    var title: String {
        switch self {
        case .blog:
            return "博客"
        case .news:
            return "新闻"
        case .knowledge:
            return "知识库"
        case .compose:
            return "闪存"
        case .problem:
            return "博问"
        case .login:
            return "登录"
        }
    }
    
//    var feature: Feature {
//        return LoginFeature.self
//    }
    
//    var associatedViewController: UIViewController {
//
//    }
    
//    var feature: Feature.Type {
//        return LoginFeature.self
        
//        switch self {
//        case .blog:
//            return
//        default:
//            <#code#>
//        }
//    }
    
}




class MainViewController: UIViewController {
    
    var pageViewController: UIPageViewController! {
        didSet {
            pageViewController.delegate = self
            pageViewController.dataSource = self
        }
    }
    
    var controllers: [UIViewController] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
                                
        let blog = ComposeViewController()
        let vc1 = UIViewController()
        vc1.view.backgroundColor = .blue
        
        let vc2 = UIViewController()
        vc2.view.backgroundColor = .blue
        
        controllers = [blog, vc1, vc2]
                
        configPageViewController()
        
        let edgePanGesture = UIScreenEdgePanGestureRecognizer(target: self, action: #selector(MainViewController.screenEdgePanGestureDidRecognize(gesture:)))
        edgePanGesture.edges = .left
        self.view.addGestureRecognizer(edgePanGesture)
    }
    
    @IBAction func login(_ sender: Any) {
        RouterService.shared.navigate(toFeature: LoginFeature.self, fromView: self)
    }
    
    private func configPageViewController() {
        for view in self.pageViewController.view.subviews where view is UIScrollView {
            if let scrollView = view as? UIScrollView {
                scrollView.isScrollEnabled = false
            }
        }
        self.pageViewController.setViewControllers([controllers.first!], direction: .forward, animated: false, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let identifier = segue.identifier else { return }
        
        switch identifier {
        case "pageViewControllerIdentifier":
            guard let destination = segue.destination as? UIPageViewController else { return }
            self.pageViewController = destination
            
        default:
            break
        }
        
    }
    
    @objc func screenEdgePanGestureDidRecognize(gesture: UIScreenEdgePanGestureRecognizer) {
        let sideViewController = SideViewController.make()
        present(sideViewController, animated: true, completion: nil)
        
    }
}


extension MainViewController: UIPageViewControllerDataSource {
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let index = controllers.firstIndex(of: viewController), let vc = controllers.object(at: index - 1) else {
            return nil
        }
        return vc
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let index = controllers.firstIndex(of: viewController), let vc = controllers.object(at: index + 1) else {
            return nil
        }
        return vc
        
    }
}

extension MainViewController: UIPageViewControllerDelegate {
    
    public func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        
//        guard completed, let lastViewController = pageViewController.viewControllers?.last as? AnyProgrammeViewController, let index = self.viewControllers.firstIndex(where: { $0.type == lastViewController.type })  else { return }
//
//        self.segmentedControl.selectedSegmentIndex = index
    }
}

