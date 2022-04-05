//
//  BookmarkCollectionViewCell.swift
//  Translate
//
//  Created by Terry on 2022/04/05.
//

import SnapKit
import UIKit

final class BookmarkCollectionViewCell: UICollectionViewCell {
    static let identifier = "BookmarkCollectionViewCell"
    
    private var sourceBookmarkTextStackView: BookmarkTextStackView!
    private var targetBookmarkTextStackView: BookmarkTextStackView!
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        stackView.spacing = 16
        stackView.layoutMargins = UIEdgeInsets(top: 16.0, left: 16.0, bottom: 16.0, right: 16.0) //스택뷰 자체의 인셋 설정
        stackView.isLayoutMarginsRelativeArrangement = true

        return stackView
    }()
    
    func setup(from bookmark: Bookmark){
        backgroundColor = .systemBackground
        layer.cornerRadius = 12.0
        
        sourceBookmarkTextStackView = BookmarkTextStackView(language: bookmark.sourceLanguage,
                                                            text: bookmark.sourceText,
                                                            type: .source)
        
        targetBookmarkTextStackView = BookmarkTextStackView(language: bookmark.translatedLanguage,
                                                            text: bookmark.translatedText,
                                                            type: .target)
        
        // 북마크의 셀 재사용에 버그가 있을 수 도 있어 subView의 Cell들을 찾아서 삭제 후 다시 cell을 밑에서 subView에 추가
        stackView.subviews.forEach{ $0.removeFromSuperview() }
        
        [sourceBookmarkTextStackView, targetBookmarkTextStackView]
            .forEach{
                stackView.addArrangedSubview($0)
            }
        
        
        addSubview(stackView)
        stackView.snp.makeConstraints{
            $0.edges.equalToSuperview()
            $0.width.equalTo(UIScreen.main.bounds.size.width - 32.0)
        }
    }
}
