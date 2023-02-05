//
//  Design.swift
//  Flash Chat iOS13
//
//  Created by Berkin Koca on 3.02.2023.
//  Copyright © 2023 Angela Yu. All rights reserved.
//

import UIKit
struct NavigationDesign {
    func navigationSetting(naviController: UIViewController){
         let theColourWeAreUsing = UIColor(named: K.BrandColors.yellow)
         let contrastColour = UIColor.darkGray
        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.configureWithOpaqueBackground()
        navBarAppearance.titleTextAttributes = [.foregroundColor: contrastColour]
        navBarAppearance.largeTitleTextAttributes = [.foregroundColor: contrastColour]
        navBarAppearance.backgroundColor = theColourWeAreUsing
        naviController.navigationItem.standardAppearance = navBarAppearance
        naviController.navigationItem.scrollEdgeAppearance = navBarAppearance
    }
}
