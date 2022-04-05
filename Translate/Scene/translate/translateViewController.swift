//
//  translateViewController.swift
//  Translate
//
//  Created by Terry on 2022/03/10.
//

import UIKit
import SnapKit

class translateViewController: UIViewController {
    //MARK: - Properties
    private var sourceLanguage: Language = .ko
    private var targetLanguage: Language = .en
    
    
    private lazy var sourceLanguageButton: UIButton = {
        let button = UIButton()
        button.setTitle(sourceLanguage.title, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 15.0, weight: .semibold)
        button.setTitleColor(.label, for: .normal)
        button.backgroundColor = .systemBackground
        button.layer.cornerRadius = 9.0
        
        button.addTarget(self, action: #selector(didTapSourceLanguageButton), for: .touchUpInside)
        
        return button
    }()
    
    private lazy var targetLanguageButton: UIButton = {
        let button = UIButton()
        button.setTitle(targetLanguage.title, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 15.0, weight: .semibold)
        button.setTitleColor(.label, for: .normal)
        button.backgroundColor = .systemBackground
        button.layer.cornerRadius = 9.0
        
        button.addTarget(self, action: #selector(didTapTargetLanguageButton), for: .touchUpInside)
        
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
        button.addTarget(self, action: #selector(didTapBookmakrButton), for: .touchUpInside)
        return button
    }()
    
    private lazy var copyButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "doc.on.doc"), for: .normal)
        button.addTarget(self, action: #selector(didTapCopyButton), for: .touchUpInside)
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
        TranslatorManager().translate(from: "안녕하세요") {
            
            print(" 🏵 \($0)")
        }
    }
}


//MARK: - Event
private extension translateViewController {
    
    
    @objc func didTapSourceLabelBaseButton(){
        let viewController = SourceTextViewController(delegate: self)
        present(viewController, animated: true, completion: nil)
    }
    
    //북마크 버튼
    @objc func didTapBookmakrButton(){
        guard let sourceText = sourceLabel.text,
              let translatedText = resultlabel.text,
              bookmarkButton.imageView?.image == UIImage(systemName: "bookmark") //bookmark.fill == 북마크가 된 상태
        else { return }
        bookmarkButton.setImage(UIImage(systemName: "bookmark.fill"),
                                for: .normal)
        
        let currentBookmarks: [Bookmark] = UserDefaults.standard.boockmarks
        let newBookmark = Bookmark(sourceLanguage: sourceLanguage,
                                   translatedLanguage: targetLanguage,
                                   sourceText: sourceText,
                                   translatedText: translatedText)
        UserDefaults.standard.boockmarks = [newBookmark] + currentBookmarks
        
        print(UserDefaults.standard.boockmarks)
        
        //User Default에 저장하는 타이밍
        
    }
    
    //복사 버튼 이벤트
    @objc func didTapCopyButton(){
        
        UIPasteboard.general.string = resultlabel.text
    }
}

extension translateViewController: SourceTextViewControllerDelegate {
    func didEnterText(_ sourceText: String) {
        if sourceText == "" { return }
        
        sourceLabel.text = sourceText
        sourceLabel.textColor = .label
        
        //새로운 sourceLabel에 새로운 값이 들어 왔을때 북마크 버튼 초기화
        bookmarkButton.setImage(UIImage(systemName: "bookmark"), for: .normal)
    }
    
    
}

//MARK: - Private Function
private extension translateViewController {
    
    @objc func didTapSourceLanguageButton(){
        didTapLanguageButton(type: .source)
    }
    @objc func didTapTargetLanguageButton(){
        didTapLanguageButton(type: .target)
    }
    
    func didTapLanguageButton(type: Type){
        let alertController = UIAlertController(title: nil,
                                                message: nil,
                                                preferredStyle: .actionSheet)
        
        Language.allCases.forEach{ language in
            let action = UIAlertAction(title: language.title,
                                       style: .default) { [weak self] _ in
                switch type {
                case .source:
                    self?.sourceLanguage = language
                    self?.sourceLanguageButton.setTitle(language.title, for: .normal)
                case .target:
                    self?.targetLanguage = language
                    self?.targetLanguageButton.setTitle(language.title, for: .normal)
                }
            }
            alertController.addAction(action)
        }
        let cancelAction = UIAlertAction(title: "취소하기",
                                         style: .cancel,
                                         handler: nil)
        alertController.addAction(cancelAction)
        present(alertController, animated: true)
    }
    
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
