//
//  DetailTicketViewController.swift
//  Time for a trip
//
//  Created by Руслан Магомедов on 13.06.2022.
//

import UIKit

class DetailTicketViewController: UIViewController {

    var ticket: Ticket


    private lazy var tokenTicket: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .light)
        return label
    }()

    private lazy var departureLabel: UILabel = {
        let label = UILabel()
        label.text = "Вылет из:"
        label.font = .systemFont(ofSize: 15, weight: .regular)
        return label
    }()

    private lazy var departureDateLabel: UILabel = {
        let label = UILabel()
        label.text = "Дата отправления:"
        label.font = .systemFont(ofSize: 15, weight: .regular)
        return label
    }()

    private lazy var arrivalDateLabel: UILabel = {
        let label = UILabel()
        label.text = "Дата возвращения:"
        label.font = .systemFont(ofSize: 15, weight: .regular)
        return label
    }()


    private lazy var arrivalLabel: UILabel = {
        let label = UILabel()
        label.text = "Прибытие в:"
        label.font = .systemFont(ofSize: 15, weight: .regular)
        return label
    }()

    private lazy var labelStartCity: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15, weight: .regular)
        return label
    }()

    private lazy var startCityCode: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 25, weight: .semibold)
        return label
    }()

    private lazy var departureAir: UIImageView = {
        let view = UIImageView()
        view.tintColor = .systemGray3
        view.image = UIImage(systemName: "airplane.departure", withConfiguration: UIImage.SymbolConfiguration(pointSize: 25))
        return view
    }()

    private lazy var arrivalAir: UIImageView = {
        let view = UIImageView()
        view.tintColor = .systemGray3
        view.image = UIImage(systemName: "airplane.arrival", withConfiguration: UIImage.SymbolConfiguration(pointSize: 25))
        return view
    }()

    private lazy var labelEndCity: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15, weight: .regular)
        return label
    }()

    private lazy var endCityCodeLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 25, weight: .semibold)
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

    init(ticket: Ticket) {
        self.ticket = ticket
        super.init(nibName: nil, bundle: nil)
        checkIsLiked()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupConstraints()
        configDetailTicket()
    }

    private func setupConstraints() {

        view.addSubviews(tokenTicket, departureLabel, departureAir, startCityCode, labelStartCity, departureDateLabel, arrivalLabel, arrivalAir, endCityCodeLabel, labelEndCity, arrivalDateLabel, startDate, endDate, price, likesButtom)

        NSLayoutConstraint.activate([
            tokenTicket.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            tokenTicket.centerXAnchor.constraint(equalTo: view.centerXAnchor),

            departureLabel.topAnchor.constraint(equalTo: tokenTicket.bottomAnchor, constant: 10),
            departureLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            departureDateLabel.centerYAnchor.constraint(equalTo: departureLabel.centerYAnchor),
            departureDateLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            

            startDate.leadingAnchor.constraint(equalTo: departureDateLabel.leadingAnchor),
            startDate.topAnchor.constraint(equalTo: departureDateLabel.bottomAnchor, constant: 10),

            departureAir.leadingAnchor.constraint(equalTo: departureLabel.leadingAnchor),
            departureAir.topAnchor.constraint(equalTo: departureLabel.bottomAnchor, constant: 5),
            startCityCode.leadingAnchor.constraint(equalTo: departureAir.trailingAnchor, constant: 2),
            startCityCode.centerYAnchor.constraint(equalTo: departureAir.centerYAnchor),

            labelStartCity.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            labelStartCity.topAnchor.constraint(equalTo: startCityCode.bottomAnchor, constant: 5),

            arrivalLabel.leadingAnchor.constraint(equalTo: departureLabel.leadingAnchor),
            arrivalLabel.topAnchor.constraint(equalTo: labelStartCity.bottomAnchor, constant: 30),

            arrivalAir.leadingAnchor.constraint(equalTo: arrivalLabel.leadingAnchor),
            arrivalAir.topAnchor.constraint(equalTo: arrivalLabel.bottomAnchor, constant: 5),
            endCityCodeLabel.leadingAnchor.constraint(equalTo: arrivalAir.trailingAnchor, constant: 2),
            endCityCodeLabel.centerYAnchor.constraint(equalTo: arrivalAir.centerYAnchor),

            labelEndCity.leadingAnchor.constraint(equalTo: arrivalAir.leadingAnchor),
            labelEndCity.topAnchor.constraint(equalTo: endCityCodeLabel.bottomAnchor, constant: 5),

            arrivalDateLabel.leadingAnchor.constraint(equalTo: departureDateLabel.leadingAnchor),
            arrivalDateLabel.centerYAnchor.constraint(equalTo: arrivalLabel.centerYAnchor),
            arrivalDateLabel.trailingAnchor.constraint(equalTo: departureDateLabel.trailingAnchor),

            endDate.leadingAnchor.constraint(equalTo: arrivalDateLabel.leadingAnchor),
            endDate.topAnchor.constraint(equalTo: arrivalDateLabel.bottomAnchor, constant: 10),
            price.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            price.topAnchor.constraint(equalTo: labelEndCity.bottomAnchor, constant: 20),

            likesButtom.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            likesButtom.centerYAnchor.constraint(equalTo: price.centerYAnchor)

        ])
    }

    private func configDetailTicket() {
        let dateFormated = DateFormatedCustom()
        tokenTicket.text = "Билет №: \(ticket.searchToken)"
        startCityCode.text = ticket.startCityCode.uppercased()
        labelStartCity.text = ticket.startCity
        endCityCodeLabel.text = ticket.endCityCode.uppercased()
        labelEndCity.text = ticket.endCity
        startDate.text = dateFormated.formatedDate(data: ticket.startDate, format: "E, dd MMMM")
        endDate.text = dateFormated.formatedDate(data: ticket.endDate, format: "E, dd MMMM")
        price.text = "Цена: \(ticket.price) руб."




    }

    @objc private func likeAction() {
        ticket.isLiked.toggle()
        guard let value = TicketsViewController.arrayTickets.firstIndex(where: {$0.searchToken == ticket.searchToken}) else { return }
        TicketsViewController.arrayTickets[value] = ticket
        NotificationCenter.default.post(name: Notification.Name("update"), object: nil)
        checkIsLiked()

    }


    private func checkIsLiked() {
        if !ticket.isLiked {
            likesButtom.setImage(UIImage(systemName: "suit.heart", withConfiguration: UIImage.SymbolConfiguration.init(pointSize: 30, weight: .semibold))?.withTintColor(.gray, renderingMode: .alwaysOriginal), for: .normal)
        } else {
            likesButtom.setImage(UIImage(systemName: "suit.heart.fill", withConfiguration: UIImage.SymbolConfiguration.init(pointSize: 30, weight: .semibold))?.withTintColor(.systemRed, renderingMode: .alwaysOriginal), for: .normal)
        }
    }
    


}
