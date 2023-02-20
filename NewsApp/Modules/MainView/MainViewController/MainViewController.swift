//
//  MainViewController.swift
//  NewsApp
//
//  Created by Dastan on 12/2/23.
//

import UIKit
import SnapKit

class MainViewController: ViewController {
    
    private lazy var typeTextField: UITextField = {
        let t = UITextField()
        t.backgroundColor = .clear
        t.attributedPlaceholder = NSAttributedString(
            string: "Какую новость хотели бы увидеть?",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor(red: 0.184, green: 0.525, blue: 0.976, alpha: 1)])
        t.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: 0))
        t.textColor = .black
        t.leftViewMode = .always
        t.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        t.layer.cornerRadius = 8
        t.layer.borderWidth = 1
        t.layer.masksToBounds = true
        t.layer.borderColor = UIColor(red: 0.184, green: 0.525, blue: 0.976, alpha: 1).cgColor
        
        t.addTarget(self, action: #selector(typedTextField), for: .editingDidEnd)
        
        t.delegate = self
        
        return t
    }()
    
    @objc func typedTextField() {
        if let text = typeTextField.text {
            if text != "" {
                print("first:", text)
                searchButton.setTitleColor(UIColor(red: 0.184, green: 0.525, blue: 0.976, alpha: 1), for: .normal)
                searchButton.layer.borderColor = UIColor(red: 0.184, green: 0.525, blue: 0.976, alpha: 1).cgColor
            } else if text == ""{
                searchButton.layer.borderColor = UIColor.systemGray.cgColor
                searchButton.setTitleColor(UIColor.systemGray, for: .normal)
            }
        }
    }
    
    let network = NetworkManager.shared
    
    private lazy var searchButton: UIButton = {
        let s = UIButton()
        s.layer.borderColor = UIColor.systemGray.cgColor
        s.setTitle("Поиск", for: .normal)
        s.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .light)
        s.setTitleColor(UIColor.systemGray, for: .normal)
        
        s.backgroundColor = .clear
        s.layer.cornerRadius = 8
        s.layer.borderWidth = 1
        
        s.addTarget(self, action: #selector(searchButtonTapped), for: .touchUpInside)
        
        return s
    }()
    
    @objc func searchButtonTapped() {
        var newText = ""
        if let text = typeTextField.text {
            if text != "" {
                newText = text
                let nextVC = NewsViewController(searchNewsText: newText)
                navigationController?.pushViewController(nextVC, animated: true)
            }
        }

    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.navigationBar.backgroundColor = .clear
    }
    
    override func setupSubviews() {
        view.addSubview(typeTextField)
        view.addSubview(searchButton)
    }
    
    override func setupConstraints() {
        typeTextField.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(250)
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview().offset(-20)
            $0.height.equalTo(50)
        }
        
        searchButton.snp.makeConstraints {
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-50)
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview().offset(-20)
            $0.height.equalTo(50)
        }
    }
    

}

extension MainViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        typeTextField.resignFirstResponder()
        if let text = typeTextField.text {
            if text != "" {
                
            }
        }
        return true
    }
}
