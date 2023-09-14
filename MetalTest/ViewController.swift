//
//  ViewController.swift
//  MetalTest
//
//  Created by Maochun on 2023/9/13.
//

import UIKit
import Metal

class ViewController: UIViewController {

    lazy var img2DButton:  UIButton = {
        
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setBackgroundColor(color: UIColor(red: 0x23/255, green: 0x6A/255, blue: 0xF9/255, alpha: 1), forState: .normal)
        btn.setBackgroundColor(color: UIColor.gray, forState: .selected)
        btn.layer.cornerRadius = 10
        btn.setTitle(NSLocalizedString("Show 2D", comment: ""), for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 29, weight: .bold)
        btn.titleLabel?.textAlignment = .center
        btn.addTarget(self, action: #selector(show2DAction), for: .touchUpInside)
        btn.isEnabled = true
        btn.alpha = 1.0
        
        self.view.addSubview(btn)
        NSLayoutConstraint.activate([
            
            btn.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerYAnchor, constant: -36),
            btn.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 20),
            btn.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -20),
            btn.heightAnchor.constraint(equalToConstant: 60)
            
        ])
       
        return btn
    }()
    
    lazy var img3DButton:  UIButton = {
        
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setBackgroundColor(color: UIColor(red: 0x23/255, green: 0x6A/255, blue: 0xF9/255, alpha: 1), forState: .normal)
        btn.setBackgroundColor(color: UIColor.gray, forState: .selected)
        btn.layer.cornerRadius = 10
        btn.setTitle(NSLocalizedString("Show 3D", comment: ""), for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 29, weight: .bold)
        btn.titleLabel?.textAlignment = .center
        btn.addTarget(self, action: #selector(show3DAction), for: .touchUpInside)
        btn.isEnabled = true
        btn.alpha = 1.0
        
        self.view.addSubview(btn)
        NSLayoutConstraint.activate([
            
            btn.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerYAnchor, constant: 36),
            btn.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 20),
            btn.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -20),
            btn.heightAnchor.constraint(equalToConstant: 60)
            
        ])
       
        return btn
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        _ = self.img2DButton
        _ = self.img3DButton

    }
    
    @objc func show2DAction(){
        let vc = Draw2DViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func show3DAction(){
        let vc = Draw3DViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}

