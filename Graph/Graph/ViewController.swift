//
//  ViewController.swift
//  Graph
//
//  Created by Mac House on 7/1/19.
//  Copyright © 2019 myself. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    //Chỉ hỗ trợ portrait
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }
    
    let scrollView = ScrollView()
    
    //Khởi tạo TextField
    let inputFunctionField: UITextField = {
        let field = UITextField()
        field.translatesAutoresizingMaskIntoConstraints = false
        field.placeholder = "Enter function"
        field.backgroundColor = UIColor(red:0.95, green:0.95, blue:0.95, alpha:1.0)
        field.layer.cornerRadius = 6
        let leftLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 35, height: 40))
        leftLabel.text = " y =   "
        leftLabel.textColor = .black
        field.leftView = leftLabel
        field.leftViewMode = .always
        field.autocapitalizationType = UITextAutocapitalizationType.none
        field.autocorrectionType = UITextAutocorrectionType.no
        field.smartQuotesType = UITextSmartQuotesType.no
        field.keyboardType = UIKeyboardType.alphabet
        return field
    }()
    
    let label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = UIColor(red:0.65, green:0.95, blue:0.95, alpha:1.0)
        label.textColor = .black
        label.textAlignment = .center
        label.isHidden = true
        return label
    }()
    
    //Khởi tạo các nút điều chỉnh độ zoom
    let zoomInButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .blue
        button.setImage(UIImage(named: "Zoom_in"), for: .normal)
        return button
    }()
    
    let zoomOutButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setBackgroundImage(UIImage(named: "Zoom_out"), for: .normal)
        return button
    }()
    
    let compressXButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = UIColor(red:0.80, green:0.70, blue:0.27, alpha:1.0)
        button.layer.cornerRadius = 10
        button.setTitle("Compress horizontally", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        button.titleLabel?.numberOfLines = 2
        button.titleLabel?.lineBreakMode = .byWordWrapping
        button.titleLabel?.textAlignment = .center
        return button
    }()
    
    let stretchXButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = UIColor(red:0.30, green:0.55, blue:0.37, alpha:1.0)
        button.layer.cornerRadius = 10
        button.setTitle("Stretch horizontally", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        button.titleLabel?.numberOfLines = 2
        button.titleLabel?.lineBreakMode = .byWordWrapping
        button.titleLabel?.textAlignment = .center
        return button
    }()
    
    let compressYButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = UIColor(red:0.59, green:0.21, blue:0.07, alpha:1.0)
        button.layer.cornerRadius = 10
        button.setTitle("Compress vertically", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        button.titleLabel?.numberOfLines = 2
        button.titleLabel?.lineBreakMode = .byWordWrapping
        button.titleLabel?.textAlignment = .center
        return button
    }()
    
    let stretchYButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = UIColor(red:0.66, green:0.60, blue:0.77, alpha:1.0)
        button.layer.cornerRadius = 10
        button.setTitle("Stretch vertically", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        button.titleLabel?.numberOfLines = 2
        button.titleLabel?.lineBreakMode = .byWordWrapping
        button.titleLabel?.textAlignment = .center
        return button
    }()
    
    let defaultButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = UIColor(red:0.09, green:0.00, blue:0.45, alpha:1.0)
        button.layer.cornerRadius = 10
        button.setTitle("Return to default", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        button.titleLabel?.numberOfLines = 2
        button.titleLabel?.lineBreakMode = .byWordWrapping
        button.titleLabel?.textAlignment = .center
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidLayoutSubviews() {
        //Gán hành động cho các nút
        zoomInButton.addTarget(scrollView, action: #selector(scrollView.zoomIn), for: .touchUpInside)
        zoomOutButton.addTarget(scrollView, action: #selector(scrollView.zoomOut), for: .touchUpInside)
        compressXButton.addTarget(scrollView, action: #selector(scrollView.compressX), for: .touchUpInside)
        stretchXButton.addTarget(scrollView, action: #selector(scrollView.stretchX), for: .touchUpInside)
        compressYButton.addTarget(scrollView, action: #selector(scrollView.compressY), for: .touchUpInside)
        stretchYButton.addTarget(scrollView, action: #selector(scrollView.stretchY), for: .touchUpInside)
        defaultButton.addTarget(scrollView, action: #selector(scrollView.returnDefault), for: .touchUpInside)
        
        inputFunctionField.addTarget(self, action: #selector(read), for: .editingDidEndOnExit)
        inputFunctionField.addTarget(self, action: #selector(moveUp), for: .touchDown)
        
        //Vẽ các trục ban đầu
        scrollView.drawAxes()
        scrollView.drawOnXAxis()
        scrollView.drawOnYAxis()

        layout()
    }
    
    //Layout
    func layout() {
        view.addSubview(scrollView)
        scrollView.frame = view.frame
        view.addSubview(zoomInButton)
        view.addSubview(zoomOutButton)
        view.addSubview(compressXButton)
        view.addSubview(stretchXButton)
        view.addSubview(compressYButton)
        view.addSubview(stretchYButton)
        view.addSubview(defaultButton)
        view.addSubview(inputFunctionField)
        view.addSubview(label)
        
        inputFunctionField.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20).isActive = true
        inputFunctionField.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 5).isActive = true
        inputFunctionField.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -5).isActive = true
        inputFunctionField.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        label.bottomAnchor.constraint(equalTo: inputFunctionField.topAnchor).isActive = true
        label.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        label.widthAnchor.constraint(equalToConstant: 90).isActive = true
        label.heightAnchor.constraint(equalToConstant: 35).isActive = true
        
        zoomInButton.topAnchor.constraint(equalTo: view.topAnchor, constant: view.safeAreaInsets.top).isActive = true
        zoomInButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: view.safeAreaInsets.left).isActive = true
        zoomInButton.widthAnchor.constraint(equalToConstant: 35).isActive = true
        zoomInButton.heightAnchor.constraint(equalToConstant: 35).isActive = true
        
        zoomOutButton.topAnchor.constraint(equalTo: view.topAnchor, constant: view.safeAreaInsets.top).isActive = true
        zoomOutButton.leftAnchor.constraint(equalTo: zoomInButton.rightAnchor, constant: 5).isActive = true
        zoomOutButton.widthAnchor.constraint(equalToConstant: 35).isActive = true
        zoomOutButton.heightAnchor.constraint(equalToConstant: 35).isActive = true
        
        compressXButton.topAnchor.constraint(equalTo: zoomInButton.bottomAnchor, constant: 5).isActive = true
        compressXButton.leftAnchor.constraint(equalTo: zoomInButton.leftAnchor).isActive = true
        compressXButton.rightAnchor.constraint(equalTo: zoomOutButton.rightAnchor).isActive = true
        compressXButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        stretchXButton.topAnchor.constraint(equalTo: compressXButton.bottomAnchor, constant: 5).isActive = true
        stretchXButton.leftAnchor.constraint(equalTo: zoomInButton.leftAnchor).isActive = true
        stretchXButton.rightAnchor.constraint(equalTo: zoomOutButton.rightAnchor).isActive = true
        stretchXButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        compressYButton.topAnchor.constraint(equalTo: stretchXButton.bottomAnchor, constant: 5).isActive = true
        compressYButton.leftAnchor.constraint(equalTo: zoomInButton.leftAnchor).isActive = true
        compressYButton.rightAnchor.constraint(equalTo: zoomOutButton.rightAnchor).isActive = true
        compressYButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        stretchYButton.topAnchor.constraint(equalTo: compressYButton.bottomAnchor, constant: 5).isActive = true
        stretchYButton.leftAnchor.constraint(equalTo: zoomInButton.leftAnchor).isActive = true
        stretchYButton.rightAnchor.constraint(equalTo: zoomOutButton.rightAnchor).isActive = true
        stretchYButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        defaultButton.topAnchor.constraint(equalTo: stretchYButton.bottomAnchor, constant: 5).isActive = true
        defaultButton.leftAnchor.constraint(equalTo: zoomInButton.leftAnchor).isActive = true
        defaultButton.rightAnchor.constraint(equalTo: zoomOutButton.rightAnchor).isActive = true
        defaultButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
    }
    
    //Di chuyển TextField lên để bàn phím không che mất
    @objc func moveUp() {
        inputFunctionField.transform = CGAffineTransform.init(translationX: 0, y: -285)
        label.isHidden = true
    }
    
    //Hàm xử lí khi có người nhập xong
    @objc func read() {
        //Đưa TextField về chỗ cũ
        inputFunctionField.transform = CGAffineTransform.identity
        let funcText = scrollView.drawGraph(function: inputFunctionField.text!, color: .blue)
        label.isHidden = false
        if funcText == "Error" {
            label.text = "Invalid"
        }
        else { label.text = "Valid" }
        scrollView.redraw()
    }
    
}

