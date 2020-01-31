//
//  ViewController.swift
//  LoginAnimadoSnapKit
//
//  Created by Catia Miranda de Souza on 31/01/20.
//  Copyright © 2020 Catia Miranda de Souza. All rights reserved.
//

import UIKit
import SnapKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let loginView = LoginView()
        view.addSubview(loginView)
        loginView.snp.makeConstraints { (make) in
            //            make.left.equalTo(self.view)
            //            make.top.equalTo(self.view)
            //            make.right.equalTo(self.view)
            //            make.bottom.equalTo(self.view)
            
            //  tornando as bordas iguais a do pai em apenas uma linha
            make.edges.equalTo(self.view)
            
        }
        
    }
    
}

