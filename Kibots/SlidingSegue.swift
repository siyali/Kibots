//
//  SlidingSegue.swift
//  Kibots
//
//  Created by Siya Li on 6/1/18.
//  Copyright © 2018 kibots. All rights reserved.
//

import UIKit

class SlidingSegue: UIStoryboardSegue {
    override func perform() {
//        let src = source
//        let dst = destination
//        let slide_view = destination.view
//
//        src.view.addSubview(slide_view!)
//        //slide_view?.transform = CGAffineTransform.init(translationX: <#T##CGFloat#>, y: <#T##CGFloat#>)
//        slide_view?.transform=CGAffineTransform.init(translationX: src.view.frame.size.width, y:0)
//
//        UIView.animate(withDuration: 0.25,
//                                   delay: 0.0,
//                                   options: .curveEaseInOut,
//                                   animations: {
//                                    dst.view.transform=CGAffineTransform.identity
//        }, completion: {success in
//            src.present(dst, animated: false, completion: nil)
//            slide_view?.removeFromSuperview()
//        })
        
        let src = source
        let dst = destination
        

        src.view.superview?.addSubview(dst.view)
        //slide_view?.transform = CGAffineTransform.init(translationX: <#T##CGFloat#>, y: <#T##CGFloat#>)
        dst.view.transform = CGAffineTransform.init(translationX: src.view.frame.size.width, y:0)

        UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseInOut, animations: {
            dst.view.transform = CGAffineTransform.identity
        }, completion: {success in
            dst.view.removeFromSuperview()
            src.present(dst, animated: false, completion: nil)
           
           // dst.loadView()
            //slide_view?.removeFromSuperview()
        })
    }
    func sliding(){
        let toViewController = self.destination
        let fromViewController = self.source
        
        let containerView = fromViewController.view.superview
        let originalCenter = fromViewController.view.center
        
        toViewController.view.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
        toViewController.view.center = originalCenter
        
        containerView?.addSubview(toViewController.view)
        
        UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseOut, animations: {
            toViewController.view.transform = CGAffineTransform.identity
        }, completion: { success in
            fromViewController.present(toViewController, animated: false, completion: nil)
        })
        
    }
}
