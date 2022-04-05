//
//  SourceTextViewController.swift
//  Translate
//
//  Created by Terry on 2022/03/10.
//

import UIKit
import SnapKit

//델리게이트 프로토콜
protocol SourceTextViewControllerDelegate: AnyObject {
    func didEnterText(_ sourceText: String)
}

final class SourceTextViewController: UIViewController {
    
    //MARK: - Properties
    private let placeholderText = "번역할 내용을 입력해 주세요."
    
    private weak var delegate: SourceTextViewControllerDelegate?
    
    private lazy var textView: UITextView = {
        let textView = UITextView()
        textView.text = placeholderText
        textView.textColor = .secondaryLabel
        textView.font = .systemFont(ofSize: 18.0, weight: .semibold)
        textView.returnKeyType = .done
        textView.delegate = self
        
        return textView
    }()
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        UIConfige()
    }
    
    init(delegate: SourceTextViewControllerDelegate? ){
        self.delegate = delegate
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
extension SourceTextViewController: UITextViewDelegate {
    // 글 작성이 시작되었을때 호출
    func textViewDidBeginEditing(_ textView: UITextView) {
        guard textView.textColor == .secondaryLabel else { return }
        
        textView.text = nil
        textView.textColor = .label
    }
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        guard text == "\n" else { return true }
        
        //델리게이트를 통해 번역할 내용 담기 
        delegate?.didEnterText(textView.text)
        dismiss(animated: true)
        
        return true
    }
}


private extension SourceTextViewController {
    func UIConfige(){
        view.backgroundColor = .systemBackground
        view.addSubview(textView)
        
        textView.snp.makeConstraints{
            $0.edges.equalToSuperview().inset(16.0)
        }
    }
}
