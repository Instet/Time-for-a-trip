//
//  TicketsTableViewCell.swift
//  Time for a trip
//
//  Created by Руслан Магомедов on 13.06.2022.
//

import UIKit

class TicketsTableViewCell: UITableViewCell {

    var callback: (() -> ())?

    private lazy var labelStartCity: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .bold)
        return label
    }()

    private lazy var startCityCode: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12, weight: .light)
        return label
    }()

    private lazy var labelEndCity: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .bold)
        return label
    }()

    private lazy var endCityCodeLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12, weight: .light)
        return label
    }()

    private lazy var startDate: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .regular)
        return label
    }()

    private lazy var endDate: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .regular)
        return label
    }()

    private lazy var price: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20, weight: .semibold)
        label.textAlignment = .center
        label.textColor = .systemRed
        return label
    }()

    private lazy var likesButtom: UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(likeAction), for: .touchUpInside)
        return button
    }()


    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    private func setupConstraints() {
        contentView.addSubviews(labelStartCity, startCityCode, labelEndCity, endCityCodeLabel,
                                startDate, endDate, price, likesButtom)

        NSLayoutConstraint.activate([
            labelStartCity.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            labelStartCity.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),

            startCityCode.leadingAnchor.constraint(equalTo: labelStartCity.leadingAnchor),
            startCityCode.topAnchor.constraint(equalTo: labelStartCity.bottomAnchor, constant: 1),

            labelEndCity.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            labelEndCity.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),

            endCityCodeLabel.leadingAnchor.constraint(equalTo: labelEndCity.leadingAnchor),
            endCityCodeLabel.bottomAnchor.constraint(equalTo: labelEndCity.topAnchor, constant: -1),

            startDate.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            startDate.topAnchor.constraint(equalTo: labelStartCity.topAnchor),

            endDate.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            endDate.bottomAnchor.constraint(equalTo: labelEndCity.bottomAnchor),

            price.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            price.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),

            likesButtom.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            likesButtom.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10)


        ])
    }

    func configCell(_ ticket: Ticket) {

        let formated = DateFormatedCustom()
        labelStartCity.text = ticket.startCity
        startCityCode.text = ticket.startCityCode.uppercased()

        labelEndCity.text = ticket.endCity
        endCityCodeLabel.text = ticket.endCityCode.uppercased()

        startDate.text = "Туда: \(formated.formatedDate(data: ticket.startDate, format: "dd.MM"))"
        endDate.text = "Обратно: \(formated.formatedDate(data: ticket.endDate, format: "dd.MM"))"

        price.text = "Цена: \(ticket.price) руб."
        
        if !ticket.isLiked {
            likesButtom.setImage(UIImage(systemName: "suit.heart", withConfiguration: UIImage.SymbolConfiguration.init(pointSize: 30, weight: .semibold))?.withTintColor(.gray, renderingMode: .alwaysOriginal), for: .normal)
        } else {
            likesButtom.setImage(UIImage(systemName: "suit.heart.fill", withConfiguration: UIImage.SymbolConfiguration.init(pointSize: 30, weight: .semibold))?.withTintColor(.systemRed, renderingMode: .alwaysOriginal), for: .normal)

        }

    }

    @objc func likeAction() {
        callback?()
    }

}
