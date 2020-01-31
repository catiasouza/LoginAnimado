//
//  LoginView.swift
//  LoginAnimadoSnapKit
//
//  Created by Catia Miranda de Souza on 31/01/20.
//  Copyright © 2020 Catia Miranda de Souza. All rights reserved.
//


import UIKit
import SnapKit

class LoginView: UIView {
    
    // MARK: Properties
    
    let containerViewBGColor = UIColor(red: 167.0/255.0, green: 177.0/255.0, blue: 180.0/255.0, alpha: 1.0)
    
    let innerViewBGColor = UIColor(red: 190.0/255.0, green: 195.0/255, blue: 198.0/255.0, alpha: 1.0)
    
    let containerViewHeight: CGFloat = 192.0
    
    let textfieldHeight: CGFloat = 44.0
    
    let topInnerViewHeight: CGFloat = 24.0
    
    let bottomInnerViewHeight: CGFloat = 36.0
    
    let connectButtonWidth: CGFloat = 120.0
    
    var viewContainer: UIView! // view centro da tela
    
    var viewTop: UIView!       //rotulo do titulo
    
    var viewBottom: UIView!    //view do botao conectar
    
    var txtEmail: UITextField!   //campo email
    
    var txtPassword: UITextField!   //campo senha
    
    var btnConnect: UIButton!      //botao
    
    var activityIndicator: UIActivityIndicatorView!   // Um indicador de atividade
    
    
    var centerYConstraint: Constraint!
    
    
     
        @objc func revertLoginView() {
            txtEmail.snp.remakeConstraints { (make) in
                make.top.equalTo(viewTop.snp.bottom).offset(16)
                make.left.equalTo(viewContainer).offset(8)
                make.right.equalTo(viewContainer).offset(-8)
                make.height.equalTo(textfieldHeight)
            }
            
            txtPassword.snp.remakeConstraints { (make) in
                make.top.equalTo(txtEmail.snp.bottom).offset(8.0)
                make.left.equalTo(txtEmail)
                make.right.equalTo(txtEmail)
                make.height.equalTo(textfieldHeight)
            }
            
            activityIndicator.snp.updateConstraints { (make) in
                make.centerY.equalTo(viewContainer).offset(-containerViewHeight/2 - 20)
            }
            
            self.setNeedsLayout()
            
            UIView.animate(withDuration: 0.5, animations: {
                self.layoutIfNeeded()
            }) { (finished) in
                if finished {
                    self.timer.invalidate()
                    self.timer = nil
                    
                    self.isAnimating = false
                }
            }
        }
        
        var timer: Timer!
        
        var isAnimating = false
        
        
        
        
        // MARK: Initialization
        
        init() {
            super.init(frame: CGRect.zero)
            NotificationCenter.default.addObserver(self, selector: #selector(self.handleKeyboardWillShow(notification:)), name: .UIKeyboardWillShow, object: nil)
            NotificationCenter.default.addObserver(self, selector: #selector(self.handleKeyboardDidHide(notification:)), name: .UIKeyboardDidHide, object: nil)
           
            setupContainerView()
             setupTitle()
            setupTextFields()
            setupBottonView()
            setupActivityIndicator()
            
            
        }
        
        
        required init?(coder aDecoder: NSCoder) {
            super.init(coder: aDecoder)
            
           
        }
        
        
        
        // MARK: Custom Methods
        
        func setupContainerView(){
            viewContainer = UIView()  //Inicialize a exibição do contêiner.
            self.addSubview(viewContainer) //Adicione-o à vista principal como uma subvisão
            viewContainer.snp.makeConstraints { (make) in
                make.left.equalTo(self).offset(40).priority(750)
                make.right.equalTo(self).offset(-40).priority(750)
                make.width.lessThanOrEqualTo(500)
                make.centerX.equalTo(self)
                //SUBSTITUIDA por self.centeryConsatraint...para realizar animacao
                //make.centerY.equalTo(self)
                
                
                self.centerYConstraint = make.centerY.equalTo(self).constraint
                make.height.equalTo(containerViewHeight)
            }
            //cor de fundo do container
            viewContainer.backgroundColor = containerViewBGColor
            viewContainer.layer.cornerRadius = 8.0
            viewContainer.clipsToBounds = true
            
        }
        
        func setupTitle(){
            viewTop = UIView()
            viewContainer.addSubview(viewTop)
            viewTop.backgroundColor = innerViewBGColor
            
            viewTop.snp.makeConstraints { (make) in
                make.leading.equalTo(viewContainer)
                make.top.equalTo(viewContainer)
                make.right.equalTo(viewContainer)
                make.height.equalTo(topInnerViewHeight)
            }
            //CRIA A LABEL
            let lblTitle = UILabel()
            viewTop.addSubview(lblTitle)
            
            //TEXTO DA LABEL
            lblTitle.text = "LOGIN"
            
            //TEXTO BRANCO
            lblTitle.textColor = UIColor.white
            
            lblTitle.backgroundColor = UIColor.clear
            
            //FONT
            lblTitle.font = UIFont(name: "Futura-bold", size: 17.0)
            
            lblTitle.snp.makeConstraints { (make) in
                make.edges.equalTo(viewTop).inset(UIEdgeInsetsMake(0.0, 16.0, 0.0,  0.0))
            }
        }
        
        func setupTextFields(){
            
            txtEmail = UITextField()
            viewContainer.addSubview(txtEmail)
            
            //Defina self como o delegate do campo de texto
            txtEmail.delegate = self
            
            txtEmail.placeholder = "Email"
            
            txtEmail.borderStyle = .none
            
            txtEmail.backgroundColor = UIColor.white
            
            txtEmail.keyboardType = .emailAddress
            
            txtEmail.returnKeyType = .next
            
            txtEmail.autocapitalizationType = .none
            
            txtEmail.snp.makeConstraints { (make) in
                make.top.equalTo(viewTop.snp.bottom)
                make.left.equalTo(viewContainer).offset(8)
                make.right.equalTo(viewContainer).offset(-8)
                make.height.equalTo(textfieldHeight)
                
            }
            txtPassword = UITextField()
            viewContainer.addSubview(txtPassword)
            
            txtPassword.delegate = self
            txtPassword.placeholder = "Password"
            txtPassword.borderStyle = .none
            txtPassword.backgroundColor = UIColor.white
            txtPassword.autocapitalizationType = .none
            
            txtPassword.returnKeyType = .done
            txtPassword.isSecureTextEntry = true
            
            txtPassword.snp.makeConstraints { (make) in
                make.top.equalTo(txtEmail.snp.bottom).offset(8.0)
                make.left.equalTo(txtEmail)
                make.right.equalTo(txtEmail)
                make.height.equalTo(textfieldHeight)
                
                
            }
            
        }
        func setupBottonView(){
            
            viewBottom = UIView()
            viewContainer.addSubview(viewBottom)
            
            viewBottom.backgroundColor = innerViewBGColor
            
            viewBottom.snp.makeConstraints { (make) in
                make.left.equalTo(viewContainer)
                make.right.equalTo(viewContainer)
                make.bottom.equalTo(viewContainer)
                make.height.equalTo(bottomInnerViewHeight)
            }
            //Inicialize o botão Connect
            btnConnect = UIButton(type: .custom)
            viewBottom.addSubview(btnConnect)
            
            btnConnect.setTitle("CONNECT", for: .normal)
            //COR DO TEXTO
            btnConnect.setTitleColor(UIColor.white, for: .normal)
            //Defina a cor cinza claro como a cor do texto do botão quando destacada
            btnConnect.setTitleColor(UIColor.lightGray, for: .highlighted)
            btnConnect.backgroundColor = UIColor.orange
            btnConnect.titleLabel?.font = UIFont(name: "Futura", size: 15.0)
            //METODO QUE DEVE SER ACIONADO QD TOCADO
            btnConnect.addTarget(self, action: #selector(self.connect), for: .touchUpInside)
            
            btnConnect.snp.makeConstraints { (make) in
                make.top.equalTo(viewBottom)
                make.right.equalTo(viewBottom)
                make.bottom.equalTo(viewBottom)
                make.width.equalTo(connectButtonWidth)
            }
            
        }
        //ANIMACAO
        func setupActivityIndicator(){
            activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.whiteLarge)
            viewContainer.addSubview(activityIndicator)
            
            activityIndicator.color = UIColor.orange
            activityIndicator.startAnimating()
            
            activityIndicator.snp.makeConstraints { (make) in
                make.centerX.equalTo(viewContainer)
                make.centerY.equalTo(viewContainer).offset(-containerViewHeight/2 - 20)
                make.width.equalTo(40)
                make.height.equalTo(self.activityIndicator.snp.width)
            }
        }
        
        
        @objc func connect() {
            if isAnimating{
                return
            }
            txtEmail.snp.remakeConstraints { (make) in
                make.top.equalTo(viewTop.snp.bottom).offset(16)
                make.left.equalTo(viewContainer.snp.right)
                make.width.equalTo(txtEmail.snp.width)
                make.height.equalTo(textfieldHeight)
            }
            
            txtPassword.snp.remakeConstraints { (make) in
                make.right.equalTo(viewContainer.snp.left)
                make.top.equalTo(txtEmail.snp.bottom).offset(8.0)
                make.width.equalTo(txtPassword.snp.width)
                make.height.equalTo(textfieldHeight)
            }
            activityIndicator.snp.updateConstraints { (make) in
                make.centerY.equalTo(viewContainer)
            }
            self.setNeedsLayout()
            
            UIView.animate(withDuration: 0.5, animations: {
                self.layoutIfNeeded()
            }) { (finished) in
                if finished{
                    self.timer = Timer.scheduledTimer(timeInterval: 3.0, target: self, selector: #selector(self.revertLoginView), userInfo: nil, repeats: false)
                    
                }
            }
            self.isAnimating = true
        }
        
        
         
        //VERIFICA SE O VALOR HEIGHT E MAIOR QUE Y DO PONTO DE ORIGIN DO TECLADO
        @objc func handleKeyboardWillShow(notification: Notification) {
            if let userInfo = notification.userInfo as? Dictionary<String, Any> {
                if let keyboardFrameValue = userInfo[UIKeyboardFrameEndUserInfoKey] as? NSValue {
                    let keyboardFrame = keyboardFrameValue.cgRectValue
                    
                    let containerViewOriginPlusHeight = viewContainer.frame.origin.y + viewContainer.frame.height
                    
                    if containerViewOriginPlusHeight > keyboardFrameValue.cgRectValue.origin.y{
                        let overlappedSpace = containerViewOriginPlusHeight - keyboardFrame.origin.y
                        
                        centerYConstraint.update(offset: -overlappedSpace)
                        self.setNeedsLayout()
                        UIView.animate(withDuration: 0.4, animations: {
                            self.layoutIfNeeded()
                        })
                    }
                }
            }
        }
        
        @objc func handleKeyboardDidHide(notification: Notification) {
            centerYConstraint.update(offset: 0.0)
            self.setNeedsLayout()
            
            UIView.animate(withDuration: 0.4, animations: {
                self.layoutIfNeeded()
            })
        }
    }


    extension LoginView: UITextFieldDelegate{
        func textFieldShouldReturn(_ textField: UITextField) -> Bool {
            if textField == txtEmail{
                txtPassword.becomeFirstResponder()
            }else{
                txtPassword.resignFirstResponder()
            }
            return true
        }
        
    }
