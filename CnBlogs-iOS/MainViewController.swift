//
//  MainViewController.swift
//  CnBlogs-iOS
//
//  Created by enjoy on 2019/11/3.
//  Copyright © 2019 rsenjoyer. All rights reserved.
//

import UIKit

extension UIStoryboard {
    static var main: UIStoryboard {
        return UIStoryboard(name: "Main", bundle: nil)
    }
}

class MainViewController: UIViewController {
    
    var pageViewController: UIPageViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()

    }
    
    private func setupUI() {
        self.pageViewController.setViewControllers([BlogViewController.make()], direction: .forward, animated: false, completion: nil)//        self.pageViewController.viewControllers = [BlogViewController.make()]
//        let controller =  as UIViewController
    
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let identifier = segue.identifier else { return }
        
        switch identifier {
        case "pageViewControllerIdentifier":
            guard let destination = segue.destination as? UIPageViewController else { return }
            destination.delegate = self
            destination.dataSource = self
            self.pageViewController = destination
            
        default:
            break
        }
        
    }
}

extension MainViewController: UIPageViewControllerDataSource {
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        return BlogViewController.make()
//        return self.pageViewController.viewControllers?.first
//        guard let conntroller = viewController as? AnyProgrammeViewController, let index = self.viewControllers.firstIndex(where: { $0.type == conntroller.type }) else { return nil }
//        return self.viewControllers.object(at: index - 1)
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        return BlogViewController.make()
//        guard let controller = viewController as? AnyProgrammeViewController, let index = self.viewControllers.firstIndex(where: { $0.type == controller.type }) else { return nil }
//
//        return self.viewControllers.object(at: index+1)
    }
}

extension MainViewController: UIPageViewControllerDelegate {
    
    public func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        
//        guard completed, let lastViewController = pageViewController.viewControllers?.last as? AnyProgrammeViewController, let index = self.viewControllers.firstIndex(where: { $0.type == lastViewController.type })  else { return }
//
//        self.segmentedControl.selectedSegmentIndex = index
    }
}

