//
//  MainViewController.swift
//  CnBlogs-iOS
//
//  Created by enjoy on 2019/11/3.
//  Copyright © 2019 rsenjoyer. All rights reserved.
//

import UIKit
import Common
import Compose
import Home
import Login

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
}


class MainViewController: UIPageViewController {
                
    private var controllers: [UIViewController]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        delegate = self
        dataSource = self
        view.backgroundColor = .white
                                    
        configPageViewController()
        
        let edgePanGesture = UIScreenEdgePanGestureRecognizer(target: self, action: #selector(MainViewController.screenEdgePanGestureDidRecognize(gesture:)))
        edgePanGesture.edges = .left
        
        self.view.addGestureRecognizer(edgePanGesture)
    }
    
    private func configPageViewController() {
        
        let blog = UINavigationController(rootViewController: LoginViewController())
        let blog1 = UINavigationController(rootViewController: UIViewController())
        
        controllers = [blog, blog1]
        
        for view in view.subviews where view is UIScrollView {
            if let scrollView = view as? UIScrollView {
                scrollView.isScrollEnabled = false
            }
        }
        
        if let first = controllers.first {
            setViewControllers([first], direction: .forward, animated: false, completion: nil)
        }
    }
    
    @IBAction func login(_ sender: Any) {
        RouterService.shared.navigate(toFeature: LoginFeature.self, fromView: self)
    }
        
    @objc func screenEdgePanGestureDidRecognize(gesture: UIScreenEdgePanGestureRecognizer) {
        
        guard self.presentedViewController == nil else { return }
        let sideViewController = SideViewController.make()
        sideViewController.transitioningDelegate = self
        sideViewController.modalPresentationStyle = .custom

        present(sideViewController, animated: true, completion: nil)

    }
}

extension MainViewController: UIViewControllerTransitioningDelegate {

    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return nil
    }

    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return nil
    }

    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        return nil
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

