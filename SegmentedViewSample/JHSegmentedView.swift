//
//  JHSegmentedView.swift
//  SegmentedViewSample
//
//  Created by jinhyuk on 2020/09/14.
//  Copyright © 2020 jinhyuk. All rights reserved.
//

import UIKit

protocol JHSegmentedViewDelegate {
    func didTapIndex(index: Int)
}

@IBDesignable class JHSegmentedView: UIView {

    private lazy var buttons:[UIButton] = [self.createSegmentButtion(), self.createSegmentButtion(), self.createSegmentButtion()]
    
    lazy var stackView: UIStackView = UIStackView(arrangedSubviews: [])
    
    private var buttonTitles: [String] = ["Button", "Button", "Button"]
    private var buttonImages: [UIImage] = [UIImage(), UIImage(), UIImage()]
    private var buttonSelectImages: [UIImage] = [UIImage(), UIImage(), UIImage()]
    
    private var currentIndex: Int = 0
    
    var delegate: JHSegmentedViewDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setUpView()
    }
    
    func createSegmentButtion() -> UIButton {
        let button = UIButton(type: .custom)
        button.titleLabel?.font = UIFont(name: "HelveticaNeue-Bold", size: 14)
        button.imageEdgeInsets = UIEdgeInsets(top: 0, left: -15, bottom: 0, right: 0)
        
        return button
    }
    
    func setUpView() {
        self.buttonTitles = [leftText, middleText, rightText]
        self.buttonImages = [leftImage, middleImage, rightImage]
        self.buttonSelectImages = [leftImageSelected, middleImageSelected, rightImageSelected]
        
        var x = 0
        for button in buttons {
            button.setTitle("", for: .normal)
            x += 1
            button.addTarget(self, action: #selector(self.tapButton(sender:)), for: .touchUpInside)
            button.sizeToFit()
            self.addSubview(button)
            
            stackView.addArrangedSubview(button)
        }
        self.addSubview(slideView)
        
        stackView.axis = .horizontal
        stackView.distribution = .fillProportionally
        stackView.alignment = .fill
        
        self.addSubview(stackView)
        
        stackView.translatesAutoresizingMaskIntoConstraints.toggle()
        stackView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        stackView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        stackView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        stackView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true

    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.setUpFirestSelection()
        
    }
    
    lazy var slideView: UIView = {
        var view = UIView(frame: CGRect.zero)
        view.backgroundColor = self.selectedBackgroundColor
        return view
    }()
    
    @IBInspectable var selectedBackgroundColor:UIColor = UIColor.blue {
        didSet {
            self.slideView.backgroundColor = selectedBackgroundColor
        }
    }
    @IBInspectable var selectedTextColor:UIColor = UIColor.white
    
    @IBInspectable var startingIndex: Int = 0 {
        didSet{
            self.currentIndex = startingIndex
        }
    }
    
    func setUpFirestSelection() {
           
        let index = self.currentIndex
        let newButton = self.buttons[index]
        newButton.setTitle(self.buttonTitles[index], for: .normal)
        newButton.setImage(self.buttonSelectImages[index], for: .normal)

        self.stackView.layoutIfNeeded()
        self.slideView.frame = newButton.frame
        self.slideView.layer.cornerRadius = self.slideView.frame.height/2.0
        
        self.currentIndex = index
        
    }
    
    func didSelectButton(at index: Int) {
        let oldButton = self.buttons[self.currentIndex]

        let newButton = self.buttons[index]

        newButton.alpha = 0.0
        
        delegate?.didTapIndex(index: index)
        
        oldButton.setImage(self.buttonImages[self.currentIndex], for: .normal)
        newButton.setImage(self.buttonSelectImages[index], for: .normal)
        
        
        UIView.animate(withDuration: 0.1) {
            oldButton.setTitle("", for: .normal)
            newButton.setTitle(self.buttonTitles[index], for: .normal)
            self.stackView.layoutIfNeeded()
            self.layoutIfNeeded()
            newButton.alpha = 1.0
        }
        
        UIView.animate(withDuration: 0.2, delay: 0, options: [], animations: {
            self.slideView.frame = newButton.frame
            self.currentIndex = index
            self.layoutIfNeeded()
        }, completion: nil)


        self.currentIndex = index
    }
    
    @objc func tapButton(sender: UIButton!) {
        switch sender {
        case buttons[0]:
            didSelectButton(at: 0)
            break
        case buttons[1]:
            didSelectButton(at: 1)
            break
        case buttons[2]:
            didSelectButton(at: 2)
            break
        default:
            break
        }
    }
    
    
    
    @IBInspectable var leftText: String = "Button" {
        didSet {
            self.buttonTitles[0] = leftText
            if self.currentIndex == 0 {
                self.buttons[0].setTitle(leftText, for: .normal)
            }
        }
    }
    
    @IBInspectable var middleText: String = "Button" {
        didSet {
            self.buttonTitles[1] = middleText
            if self.currentIndex == 1 {
                self.buttons[1].setTitle(middleText, for: .normal)
            }
        }
    }
    
    @IBInspectable var rightText: String = "Button" {
        didSet {
            self.buttonTitles[2] = rightText
            if self.currentIndex == 2 {
                self.buttons[2].setTitle(rightText, for: .normal)
            }
        }
    }
    
    @IBInspectable var leftImage: UIImage = UIImage() {
        didSet {
            self.buttons[0].setImage(leftImage, for: .normal)
            self.buttonImages[0] = leftImage
        }
    }

    @IBInspectable var middleImage: UIImage = UIImage() {
        didSet {
            self.buttons[1].setImage(middleImage, for: .normal)
            self.buttonImages[1] = middleImage
        }
    }

    @IBInspectable var rightImage: UIImage = UIImage() {
        didSet {
            self.buttons[2].setImage(rightImage, for: .normal)
            self.buttonImages[2] = rightImage
        }
    }

    @IBInspectable var leftImageSelected: UIImage = UIImage() {
        didSet {
            self.buttonSelectImages[0] = leftImageSelected
        }
    }

    @IBInspectable var middleImageSelected: UIImage = UIImage() {
        didSet {
            self.buttonSelectImages[1] = middleImageSelected
        }
    }

    @IBInspectable var rightImageSelected: UIImage = UIImage() {
        didSet {
            self.buttonSelectImages[2] = rightImageSelected
        }
    }
}


