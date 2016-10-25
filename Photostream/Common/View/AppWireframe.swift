//
//  AppWireframe.swift
//  Photostream
//
//  Created by Mounir Ybanez on 03/08/2016.
//  Copyright © 2016 Mounir Ybanez. All rights reserved.
//

import UIKit

class AppWireframe: RootWireframeInterface {
    
    func showRoot(with viewController: UIViewController, in window: UIWindow) {
        let nav = UINavigationController(rootViewController: viewController)
        nav.setNavigationBarHidden(true, animated: false)
        window.rootViewController = nav
    }

    func navigateCommentsModule(_ viewController: UIViewController, shouldComment: Bool) {
        let wireframe = CommentWireframe()
        wireframe.appWireframe = self
        wireframe.navigateCommentInterfaceFromViewController(viewController, shouldComment: shouldComment)
    }
}
