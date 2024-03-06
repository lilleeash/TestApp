//
//  View.swift
//  TestApp
//
//  Created by Darya Zhitova on 01.03.2024.
//

import UIKit

// верстка приложения - констреинты

// SwiftUI - ... сегодня не об этом
// UIKit - вершина UI фреймворков
// CoreAnimation/CA - на уровень выше, чем CoreGraphycs
// CoreGraphycs/CG - на уровень выше, чем OpenGl
// OpenGl - самый низний уровень, с ios 8 -> Metal

final class View: UIView {
    
    private enum CoreImageFilters: String {
        case transferEffect = "CIPhotoEffectTransfer"
        case blur = "CIGaussianBlur"
        case sRGBToneCurveToLinear = "CISRGBToneCurveToLinear"
    }
    
    private enum Constants {
        static let padding: CGFloat = 16
        static let viewHeight: CGFloat = 350
        static let viewWidth: CGFloat = 350
        static let spacing: CGFloat = 75
    }
    
    private var view1: UIView = {
        let view = UIView()
        view.backgroundColor = .blue
        view.layer.shadowRadius = 10
        view.layer.shadowOpacity = 0.7
        view.layer.shadowOffset = CGSizeMake(5, 5)
        view.layer.shadowColor = UIColor.blue.cgColor
        view.layer.cornerRadius = 20
        view.layer.borderWidth = 5
        view.layer.borderColor = UIColor.cyan.cgColor
        return view
    }()
    
    private let imageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleToFill
        view.backgroundColor = .lightGray
        return view
    }()
    
    private var context = CIContext()
    
    init() {
        super.init(frame: .zero)
        backgroundColor = .white
        addSubviews()
        setUpConstraints()
        imageView.image = UIImage(named: "Image")
        imageView.image = setFilter(with: .transferEffect)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}

// MARK: - Private Extension
private extension View {
    
    private func addSubviews() {
        // добавляем элементы на основную UIView
        [imageView].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            addSubview($0)
        }
    }
    
    private func setUpConstraints() {
        
        NSLayoutConstraint.activate([
            imageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            imageView.widthAnchor.constraint(equalToConstant: Constants.viewWidth),
            imageView.heightAnchor.constraint(equalToConstant: Constants.viewHeight)
        ])
    }
    
    private func setFilter(with title: CoreImageFilters) -> UIImage? {
        guard let image = imageView.image else { return nil }
        let filter = CIFilter(name: title.rawValue)
        let inputCIImage = CIImage(image: image)
        
        filter?.setValue(inputCIImage, forKey: kCIInputImageKey)
        
        guard let outputImage = filter?.outputImage else { return nil }
        
        guard let cgImage = context
            .createCGImage(outputImage, from: outputImage.extent) else { return nil }
        
        return UIImage(cgImage: cgImage)
    }
    
}



// верстка приложения - при помощи фреймов
//final class View: UIView {
//
//    let subview: UIView = UIView(frame: CGRect(x: 50, y: 50, width: 100, height: 200))
//    let subview2: UIView = UIView(frame: CGRect(x: 50, y: 50, width: 25, height: 67))
//
//    init() {
//        super.init(frame: .zero)
//        backgroundColor = .white
//        subview.backgroundColor = .blue
//        subview2.backgroundColor = .red
//
//        addSubview(subview2)
//        addSubview(subview)
//    }
//
//    required init?(coder: NSCoder) {
//        super.init(coder: coder)
//    }
//}
