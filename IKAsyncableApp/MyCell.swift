//
//  MyCell.swift
//
//  Created by Ian Keen on 1/09/2015.
//  Copyright (c) 2015 Mustard. All rights reserved.
//

import UIKit

class MyCell : UITableViewCell, IKAsyncable {
    @IBOutlet private var imgView: UIImageView!
    
    private var url: String!
    func setup(url: String) {
        self.url = url
    }
    
    func ikAsyncOperation() -> IKAsyncOperationClosure {
        return { success, failure in
            if
                let url = NSURL(string: self.url),
                let data = NSData(contentsOfURL: url),
                let image = UIImage(data: data) {
                    success(image)
                    
            } else {
                failure(NSError(domain: "domain", code: 0, userInfo: [NSLocalizedDescriptionKey: "IMAGE"]))
            }
        }
    }
    func ikAsyncOperationState(state: IKAsyncOperationState) {
        self.imgView.image = nil
        
        let color: UIColor
        switch state {
        case .InProgress:
            color = .yellowColor()
        case .Complete(let result):
            self.imgView.image = result as? UIImage
            color = .whiteColor()
        case .Failed:
            color = .redColor()
        }
        
        self.backgroundColor = color
    }
}
