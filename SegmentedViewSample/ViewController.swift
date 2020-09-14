//
//  ViewController.swift
//  SegmentedViewSample
//
//  Created by jinhyuk on 2020/09/14.
//  Copyright © 2020 jinhyuk. All rights reserved.
//

import UIKit

class ViewController: UIViewController, JHSegmentedViewDelegate {

    
    @IBOutlet weak var JHSeg: JHSegmentedView!

    let labelTop: UILabel = UILabel()
    let labelBottom: UILabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        JHSeg.delegate = self
        
        labelTop.textAlignment = .center
        labelTop.textColor = .black
        labelTop.text = "인덱스"
        labelTop.font.withSize(50)
        labelTop.backgroundColor = .white
        self.view.addSubview(labelTop)
        
        labelBottom.textAlignment = .center
        labelBottom.textColor = .red
        labelBottom.text = "0"
        labelBottom.font.withSize(50)
        labelBottom.backgroundColor = .green
        self.view.addSubview(labelBottom)

        labelTop.translatesAutoresizingMaskIntoConstraints = false
        labelTop.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 15).isActive = true
        labelTop.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -15).isActive = true
        labelTop.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 100).isActive = true
        labelTop.bottomAnchor.constraint(equalTo: labelBottom.topAnchor, constant: 0).isActive = true
        
        labelBottom.translatesAutoresizingMaskIntoConstraints = false
        labelBottom.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 15).isActive = true
        labelBottom.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -15).isActive = true
        labelBottom.topAnchor.constraint(equalTo: labelTop.bottomAnchor, constant: 0).isActive = true
        labelBottom.heightAnchor.constraint(equalTo: labelTop.heightAnchor, multiplier: 2).isActive = true
        
        self.view.layoutIfNeeded()
        
    }
    
    func didTapIndex(index: Int) {
        print("화면 인덱스: \(index)")
        self.labelBottom.text = String(index)
    }


}

