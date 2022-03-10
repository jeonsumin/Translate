//
//  translate.swift
//  Translate
//
//  Created by Terry on 2022/03/10.
//

import UIKit
import SnapKit

class translateViewController: UIViewController {
    //MARK: - Properties
    private lazy var sourceLanguageButton: UIButton = {
        let button = UIButton()
        button.setTitle("한국어", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 15.0, weight: .semibold)
        button.setTitleColor(.label, for: .normal)
        button.backgroundColor = .systemBackground
        button.layer.cornerRadius = 9.0
        
        return button
    }()
    
    private lazy var targetLanguageButton: UIButton = {
        let button = UIButton()
        button.setTitle("영어", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 15.0, weight: .semibold)
        button.setTitleColor(.label, for: .normal)
        button.backgroundColor = .systemBackground
        button.layer.cornerRadius = 9.0
        
        return button
    }()
    
    private lazy var buttonStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.distribution = .fillEqually
        stackView.spacing = 8.0
        
        [
            sourceLanguageButton
            ,targetLanguageButton
        ].forEach{ stackView.addArrangedSubview($0)}
        
        return stackView
    }()
    
    private lazy var resultBaseView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        
        return view
    }()
    
    
    private lazy var resultlabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 23.0, weight: .bold)
        label.textColor = UIColor.mainTintColor
        label.text = "Hello"
        label.numberOfLines = 0
        
        return label
    }()
    
    private lazy var bookmarkButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "bookmark"), for: .normal)
        
        return button
    }()
    
    private lazy var copyButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "doc.on.doc"), for: .normal)
        
        return button
    }()
    
    private lazy var sourceLabelBaseButton: UIView = {
        let view = UIView()
        view.backgroundColor = .systemBackground
        
        let guesture = UITapGestureRecognizer(target: self, action: #selector(didTapSourceLabelBaseButton))
        view.addGestureRecognizer(guesture)
        
        return view
    }()
    
    private lazy var sourceLabel: UILabel = {
        let label = UILabel()
        label.text = "번역할 내용을 입력하세요."
        label.textColor = .tertiaryLabel
        //TODO: sourceLabel에 입력값이 추가 되면, placeholder 스타일 해제
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 23.0, weight: .semibold)
        
        return label
    }()
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        UIConfigue()
    }
}


//MARK: - Event
private extension translateViewController {
    @objc func didTapSourceLabelBaseButton(){
        let viewController = SourceTextViewController(delegate: self)
        present(viewController, animated: true, completion: nil)
    }
}

extension translateViewController: SourceTextViewControllerDelegate {
    func didEnterText(_ sourceText: String) {
        if sourceText == "" { return }
        
        sourceLabel.text = sourceText
        sourceLabel.textColor = .label
    }
    
    
}

//MARK: - Private Function
private extension translateViewController {
    func UIConfigue(){
        view.backgroundColor = .secondarySystemBackground
        [
            buttonStackView,
            resultBaseView,
            resultlabel,
            bookmarkButton,
            copyButton,
            sourceLabelBaseButton,
            sourceLabel,
        ].forEach{view.addSubview($0)}
        
        //16.0 등 많이 사용하는 것들은 따로 정의 하여 사용
        
        let defaultSpacing: CGFloat = 16.0
        
        buttonStackView.snp.makeConstraints{
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.leading.trailing.equalToSuperview().inset(defaultSpacing)
            $0.height.equalTo(50)
        }
        
        resultBaseView.snp.makeConstraints{
            $0.leading.trailing.equalToSuperview()
            $0.top.equalTo(buttonStackView.snp.bottom).offset(defaultSpacing)
            $0.bottom.equalTo(bookmarkButton.snp.bottom).offset(defaultSpacing)
        }
        
        resultlabel.snp.makeConstraints{
            $0.leading.equalTo(resultBaseView.snp.leading).inset(24.0)
            $0.trailing.equalTo(resultBaseView.snp.trailing).inset(24.0)
            $0.top.equalTo(resultBaseView.snp.top).inset(24.0)
        }
        
        bookmarkButton.snp.makeConstraints{
            $0.leading.equalTo(resultlabel.snp.leading)
            $0.top.equalTo(resultlabel.snp.bottom).offset(24.0)
            $0.width.height.equalTo(40)
        }
        copyButton.snp.makeConstraints{
            $0.leading.equalTo(bookmarkButton.snp.trailing).inset(8.0)
            $0.top.equalTo(bookmarkButton.snp.top)
            $0.width.height.equalTo(40)
        }
        
        sourceLabelBaseButton.snp.makeConstraints{
            $0.leading.trailing.equalToSuperview()
            $0.top.equalTo(resultBaseView.snp.bottom).offset(defaultSpacing)
            $0.bottom.equalToSuperview()
        }
        sourceLabel.snp.makeConstraints{
            $0.leading.equalTo(sourceLabelBaseButton.snp.leading).inset(24.0)
            $0.trailing.equalTo(sourceLabelBaseButton.snp.trailing).inset(24.0)
            $0.top.equalTo(sourceLabelBaseButton.snp.top).inset(24.0)
        }
    }
}
