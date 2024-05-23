//
//  TabBarController.swift
//  Jumpit
//
//  Created by YOUJIM on 5/16/24.
//

import UIKit

import Then

final class TabBarController: UITabBarController {
    
    
    // MARK: - Properties
    
    private let homeViewController: HomeViewController = HomeViewController().then {
        $0.tabBarItem.title = "홈"
        $0.tabBarItem.image = .icnHomeNormal
        $0.tabBarItem.selectedImage = .icnHomeSelected
    }
    
    private let employViewController: EmployViewController = EmployViewController().then {
        $0.tabBarItem.title = "개발자 채용"
        $0.tabBarItem.image = .icnEmploymentNormal
    }
    
    private let passnoteViewController: PassnoteViewController = PassnoteViewController().then {
        $0.tabBarItem.title = "합격족보"
        $0.tabBarItem.image = .icnPassnoteNormal
    }
    
    private let resumeViewController: ResumeViewController = ResumeViewController().then {
        $0.tabBarItem.title = "이력서"
        $0.tabBarItem.image = .icnResumeNormal
        $0.tabBarItem.selectedImage = .icnResumeSelected
    }
    
    private let applyViewController: ApplyViewController = ApplyViewController().then {
        $0.tabBarItem.title = "지원현황"
        $0.tabBarItem.image = .icnApplyNormal
    }
    
    private let logoImageBarButtonItem: UIBarButtonItem = UIBarButtonItem().then {
        $0.image = .imgLogo.withRenderingMode(.alwaysOriginal)
    }
    
    private let alarmBarButtonItem: UIBarButtonItem = UIBarButtonItem().then {
        $0.image = .icnAlarm
        $0.tintColor = .black
    }
    
    private let myBarButtonItem: UIBarButtonItem = UIBarButtonItem().then {
        $0.image = .icnMy
        $0.tintColor = .black
    }
    
    private let rightSpacerBarButtonItem: UIBarButtonItem = UIBarButtonItem().then {
        $0.width = 14
        $0.isEnabled = false
    }
    
    
    // MARK: - LifeCycles

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setNavigationBar()
        setTabBar()
    }
    
    
    // MARK: - Functions
    
    private func setNavigationBar() {
        [
            homeViewController, employViewController, passnoteViewController, resumeViewController, applyViewController
        ].forEach {
            $0.navigationItem.setLeftBarButton(logoImageBarButtonItem, animated: true)
            $0.navigationItem.setRightBarButtonItems([rightSpacerBarButtonItem, myBarButtonItem, alarmBarButtonItem], animated: true)
        }
    }
    
    private func setTabBar() {
        self.tabBar.tintColor = .black
        
        setViewControllers([
            UINavigationController(rootViewController: homeViewController),
            UINavigationController(rootViewController: employViewController),
            UINavigationController(rootViewController: passnoteViewController),
            UINavigationController(rootViewController: resumeViewController),
            UINavigationController(rootViewController: applyViewController)
        ], animated: true)
    }
}
