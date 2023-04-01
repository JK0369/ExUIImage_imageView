//
//  ViewController.swift
//  ExButton
//
//  Created by 김종권 on 2023/04/01.
//

import UIKit

class ViewController: UIViewController {
    private let button: UIButton = {
        let button = UIButton()
        
        // 3. 이미지 크기 줄여서 사용
        let imageSize = CGSize(width: 100, height: 100)
        let resizedImage = UIImage(named: "img")?.resize(targetSize: imageSize)
        
        button.imageView?.contentMode = .scaleToFill
        button.setImage(resizedImage, for: .normal)
        button.setTitle("button", for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        button.setTitleColor(.blue, for: .highlighted)
        button.addTarget(self, action: #selector(tapButton), for: .touchUpInside)
        button.backgroundColor = .lightGray
        button.layer.cornerRadius = 12
        button.clipsToBounds = true
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.black.cgColor
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(button)
        NSLayoutConstraint.activate([
            button.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            button.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
        ])
        
        // 1. 간격 5로 설정 (button 전체 크기 증가됨)
        button.contentEdgeInsets = .init(top: 5, left: 5, bottom: 5, right: 5)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setSpacingImageViewAndTitleLabel(spacing: 16)
    }

    private func setSpacingImageViewAndTitleLabel(spacing: CGFloat) {
        // 2. 이미지와 라벨사이의 간격 설정
        let titleLabelWidth = button.titleLabel?.frame.width ?? 0
        guard titleLabelWidth > 0 else { return }
        button.imageEdgeInsets = .init(top: 0, left: 0, bottom: 0, right: titleLabelWidth + spacing)
        button.titleEdgeInsets = .init(top: 0, left: spacing, bottom: 0, right: 0)
    }
    
    @objc
    private func tapButton() {
        print("tap!")
        button.layoutIfNeeded()
        button.sizeToFit()
    }
}

extension UIImage {
    func resize(targetSize: CGSize) -> UIImage? {
        let newRect = CGRect(x: 0, y: 0, width: targetSize.width, height: targetSize.height).integral
        UIGraphicsBeginImageContextWithOptions(newRect.size, true, 0)
        guard let context = UIGraphicsGetCurrentContext() else { return nil }
        context.interpolationQuality = .high
        draw(in: newRect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage
    }
}
