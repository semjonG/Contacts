//
//  ViewController.swift
//  Contacts
//
//  Created by mac on 18.08.2021.
//

import UIKit

class ViewController: UIViewController {
    
    private var contacts = [ContactProtocol] ()
    
    private func loadContacts() {
        contacts.append(Contact(title: "Jhonny CIA", phone: "09112001"))
        contacts.append(Contact(title: "Ivan KGB", phone: "89150001945"))
        contacts.append(Contact(title: "James MI6", phone: "007"))
        contacts.sort{ $0.title < $1.title }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        loadContacts()
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
//        действия удаления
        let actionDelete = UIContextualAction(style: .destructive, title: "Удалить") { _,_,_ in
//            удаляем контакт
            self.contacts.remove(at: indexPath.row)
//            заново формируем табличное представление
            tableView.reloadData()
        }
//        формируем экземпляр, описывающие действия
        let actions = UISwipeActionsConfiguration(actions: [actionDelete])
        return actions
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contacts.count
    }
    
    private func configure (cell: inout UITableViewCell, for indexPath: IndexPath) {
        var configuration = cell.defaultContentConfiguration()
//        имя контакта
        configuration.text = contacts[indexPath.row].title
        
//        номер телефона контакта
        configuration.secondaryText = contacts[indexPath.row].phone
        cell.contentConfiguration = configuration
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell: UITableViewCell
        
//        производим попытку загрузки переиспользуемой ячейки
        if let reuseCell = tableView.dequeueReusableCell(withIdentifier: "MyCell") {
           
            print("используем старую ячейку для строки с индексом \(indexPath.row)")
            
            cell = reuseCell
            
        } else {
            print("создаем новую ячейку для строки с индексом \(indexPath.row)")
            cell = UITableViewCell(style: .default, reuseIdentifier: "MyCell")
        }
        
        configure(cell: &cell, for: indexPath)
        return cell
    }
}
