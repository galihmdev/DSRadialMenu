//
//  ViewController.swift
//  DSRadialMenu
//
//  Created by Dan Sessions on 03/06/2015.
//  Copyright (c) 2015 Daniel Sessions. All rights reserved.
//

import UIKit
import DSRadialMenu

class ViewController: UIViewController {

    @IBOutlet weak var radialMenu: DSRadialMenu!
    @IBOutlet weak var centerButton: UIButton!
    
    typealias MenuItem = (title: String, position: DSRadialMenu.MenuItemPosition)
    
    let menuItemSize = CGSize(width: 65, height: 65)

    @IBAction func tappedOpenOrClose(_ sender: UIButton) {
        switch radialMenu.state {
        case .closed:
            radialMenu.open()
            centerButton.setTitle("Close", for: UIControl.State())
        case .open:
            radialMenu.close()
            centerButton.setTitle("Open", for: UIControl.State())
        }
    }
    
    @IBAction func tappedAddMenuItem(_ sender: UIButton) {
        if let nextPostion = radialMenu.nextMenuItemPosition() {
            let title = String(nextPostion.rawValue)
            //addMenuItem(MenuItem(title, nextPostion))
            addMenuItemView(MenuItem(title, nextPostion))
        } else {
            print("No more room!")
        }
    }
    
    @IBAction func tappedRemoveMenuItem(_ sender: UIButton) {
        if let lastPosition = radialMenu.menuItems.last?.position {
            radialMenu.removeMenuItem(lastPosition)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupMenu()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        addMenuItems()
    }

    func addMenuItems() {
        let menuItems = [
            MenuItem("2", .twoOClock),
            MenuItem("4", .fourOClock),
            MenuItem("5", .fiveOClock),
            MenuItem("10", .tenOClock)
        ]
        for menuItem in menuItems {
            addMenuItem(menuItem)
            //addMenuItemView(menuItem)
        }
    }

    func addMenuItem(_ menuItem: MenuItem) {
        let button: RoundButton = radialMenu.addMenuItem(menuItem.title, position: menuItem.position, size: menuItemSize)
        setupButton(button)
    }
    
    func addMenuItemView(_ menuItem: MenuItem) {
        let stackview = sampleViewContentStackView(for: menuItemSize, title: menuItem.title)
        let stackviewSize = stackview.systemLayoutSizeFitting(menuItemSize, withHorizontalFittingPriority: .defaultHigh, verticalFittingPriority: .defaultLow)
        var stackviewFrame = stackview.frame
        stackviewFrame.size.height = stackviewSize.height
        stackview.frame = stackviewFrame
        
        
        let view: DSItemView = radialMenu.addMenuItemView(menuItem.title, position: menuItem.position, size: CGSize(width: menuItemSize.width, height: stackviewSize.height))
        setupView(view, menuItem: menuItem)
        view.addSubview(stackview)
        view.sendSubviewToBack(stackview)

        /*
        let view: DSItemView = radialMenu.addMenuItemView(menuItem.title, position: menuItem.position, size: menuItemSize)
        setupView(view, menuItem: menuItem)
         */
    }

    func setupButton(_ button: RoundButton) {
        button.cornerRadius = menuItemSize.width / 2
        button.titleLabel?.font = centerButton.titleLabel!.font.withSize(15)
        button.backgroundColor = UIColor.red
        button.titleLabel?.lineBreakMode = .byWordWrapping
        button.setTitleColor(UIColor.white, for: UIControl.State())
    }
    
    func sampleViewContentStackView(for size: CGSize, title: String) -> UIStackView {
        let stackview = UIStackView(frame: CGRect(x: 0, y: 0, width: size.width, height: size.height))
        stackview.axis = .vertical
        stackview.distribution = .fill
        stackview.spacing = 5.0
        stackview.isUserInteractionEnabled = false
        
        let imageviewContainer = UIView(frame: CGRect(x: ((stackview.bounds.width-(40))/2),
                                                      y: 0,
                                                      width: 40,
                                                      height: 40))
        imageviewContainer.backgroundColor = UIColor.red
        let arrangedSubview1 = UIView()
        arrangedSubview1.addSubview(imageviewContainer)
        imageviewContainer.translatesAutoresizingMaskIntoConstraints = false
        imageviewContainer.topAnchor.constraint(equalTo: imageviewContainer.superview!.topAnchor, constant: 0).isActive = true
        imageviewContainer.bottomAnchor.constraint(equalTo: imageviewContainer.superview!.bottomAnchor, constant: 0).isActive = true
        imageviewContainer.centerXAnchor.constraint(equalTo: imageviewContainer.superview!.centerXAnchor).isActive = true
        imageviewContainer.widthAnchor.constraint(equalToConstant: 40).isActive = true
        imageviewContainer.heightAnchor.constraint(equalToConstant: 40).isActive = true
        stackview.addArrangedSubview(arrangedSubview1)
        stackview.setNeedsLayout()
        stackview.layoutIfNeeded()
        
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 11.0)
        label.text = title
        label.textAlignment = .center
        label.textColor = UIColor.black
        label.numberOfLines = 0
        //label.sizeToFit()
        //label.sizeToFit()
        let arrangedSubview2 = UIView()
        arrangedSubview2.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.topAnchor.constraint(equalTo: label.superview!.topAnchor, constant: 0).isActive = true
        label.bottomAnchor.constraint(equalTo: label.superview!.bottomAnchor, constant: 0).isActive = true
        label.leadingAnchor.constraint(equalTo: label.superview!.leadingAnchor, constant: 0).isActive = true
        label.trailingAnchor.constraint(equalTo: label.superview!.trailingAnchor, constant: 0).isActive = true
        label.heightAnchor.constraint(greaterThanOrEqualToConstant: 0).isActive = true
        stackview.addArrangedSubview(arrangedSubview2)
        stackview.setNeedsLayout()
        stackview.layoutIfNeeded()
        
        return stackview
    }
    
    func setupView(_ view: DSItemView, menuItem: MenuItem) {
        /*
        view.cornerRadius = menuItemSize.width / 2
        view.backgroundColor = UIColor.red
         */
        
        //view.backgroundColor = UIColor.green
    }
 
    func setupMenu() {
        radialMenu.delegate = self
        radialMenu.distanceFromCenter = 150
    }
    
}

extension ViewController: DSRadialMenuDelegate {

    func menuItemTapped(_ menuItem: DSRadialMenu.MenuItem) {
        print("Tapped menu item at position \(menuItem.position.rawValue)")
    }
    
}
