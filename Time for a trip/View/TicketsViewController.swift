//
//  TicketsViewController.swift
//  Time for a trip
//
//  Created by Руслан Магомедов on 12.06.2022.
//

import UIKit

class TicketsViewController: UIViewController {

    private var urlString = "https://travel.wildberries.ru/statistics/v1/cheap"

    private let networkManager = NetwokManager()

    static var arrayTickets: [Ticket] = []


     var tableViewTickets: UITableView = {
        let tableView = UITableView(frame: .zero, style: .insetGrouped)
        return tableView
    }()

    private let searchController = UISearchController(searchResultsController: nil)


    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupSearchBar()
        NotificationCenter.default.addObserver(self, selector: #selector(reloadTable), name: Notification.Name("update"), object: nil)

    }

    @objc func reloadTable() {
        tableViewTickets.reloadData()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationController?.navigationItem.largeTitleDisplayMode = .never
    }


    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupTableView()
        setupConstraints()
        networkManager.fetchData(urlString: urlString) { [weak self] result in
            switch result {
            case .success(let tickets):
                for value in tickets.data {
                    TicketsViewController.arrayTickets.append(Ticket(startCity: value.startCity,
                                                startCityCode: value.startCityCode,
                                                endCity: value.endCity,
                                                endCityCode: value.endCityCode,
                                                startDate: value.startDate,
                                                endDate: value.endDate,
                                                price: value.price,
                                                searchToken: value.searchToken,
                                                isLiked: false))
                }
                DispatchQueue.main.async {
                    self?.tableViewTickets.reloadData()
                }
            case .failure(let error):
                print("error", error)
            }
        }

    }

    @objc func reloadTicketsTable() {
        tableViewTickets.reloadData()
    }



    private func setupSearchBar() {
        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search"
        navigationItem.searchController = searchController
        definesPresentationContext = true
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationItem.largeTitleDisplayMode = .always

    }

    private func setupConstraints() {
        view.addSubviews(tableViewTickets)
        NSLayoutConstraint.activate([
            tableViewTickets.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableViewTickets.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableViewTickets.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableViewTickets.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }

    private func setupTableView() {
        tableViewTickets.delegate = self
        tableViewTickets.dataSource = self
        tableViewTickets.register(TicketsTableViewCell.self,
                                  forCellReuseIdentifier: String(describing: TicketsTableViewCell.self))

    }


}

// MARK: - UITableViewDelegate

extension TicketsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 5
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        let detailTicket = DetailTicketViewController(ticket: TicketsViewController.arrayTickets[indexPath.section])
        navigationController?.pushViewController(detailTicket, animated: false)
    }



}

// MARK: - UITableViewDataSource

extension TicketsViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }


    func numberOfSections(in tableView: UITableView) -> Int {
        tableView.sectionHeaderHeight = .leastNonzeroMagnitude
        return TicketsViewController.arrayTickets.count
    }


    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableViewTickets.dequeueReusableCell(withIdentifier: String(describing: TicketsTableViewCell.self), for: indexPath) as! TicketsTableViewCell
        cell.configCell(TicketsViewController.arrayTickets[indexPath.section])
        cell.callback = { 
            if TicketsViewController.arrayTickets[indexPath.section].isLiked{
                TicketsViewController.arrayTickets[indexPath.section].isLiked = false
                tableView.reloadData()
            } else {
                TicketsViewController.arrayTickets[indexPath.section].isLiked = true
                tableView.reloadData()
            }

        }
        return cell
    }

}

// MARK: - UISearchResultsUpdating

extension TicketsViewController: UISearchResultsUpdating {

    func updateSearchResults(for searchController: UISearchController) {

        // here is some code
    }

}

// MARK: - UISearchBarDelegate

extension TicketsViewController: UISearchBarDelegate {

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print(searchText)

        // here is some code

    }
}
