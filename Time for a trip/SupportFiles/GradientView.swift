//
//  Gradient.swift
//  Time for a trip
//
//  Created by Руслан Магомедов on 11.06.2022.
//

import UIKit

final class GradientView: UIView {
    // Предварительный набросок
    private let startColor: UIColor?
    private let endColor: UIColor?
    private let gradientLayer = CAGradientLayer()

    init(startColor: UIColor?, endColor: UIColor?) {
        self.startColor = startColor
        self.endColor = endColor
        super.init(frame: .zero)
        setupGradient()

    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        gradientLayer.frame = self.bounds
    }

    public func setupGradient(){
        self.layer.addSublayer(gradientLayer)
        gradientLayer.colors = [startColor!.cgColor, endColor!.cgColor]
    }



}
