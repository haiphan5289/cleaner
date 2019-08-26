//
//  AllContacts.swift
//  app_cleaner
//
//  Created by HaiPhan on 8/24/19.
//  Copyright © 2019 HaiPhan. All rights reserved.
//

import UIKit
import SnapKit
import Contacts
import ContactsUI

class AllContacts: UIViewController {

    var btRight: UIButton!
    var btSearch: UISearchBar!
    let modeText = ModelText()
    var txtFieldSearch: UITextField!
    var topSearchBar: Constraint?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = FunctionAll.share.BackGroundColor(typeColor: .backgroudnNavigation)
        implementCode()
    }
    
    func implementCode(){
        self.setupNavigation(text: "Contacs", isPhotoDetail: false)
        setupSelectBt()
        setupSearchBar()
        
    }
    
    //lấy phone number của contacts
    func fetchPhoneNumbers(){
        var text = self.findContacts()
        var mobiles = [CNPhoneNumber]()
        print(text[0])
        for i in text {
            for num in i.phoneNumbers {
                let numVal = num.value as! CNPhoneNumber
                if num.label == CNLabelPhoneNumberMobile {
                    mobiles.append(numVal)
                }
            }
        }
        print(mobiles[0].stringValue)
    }
    
    //lấy contacts của devices
    func findContacts () -> [CNContact]{
        
        let keysToFetch = [CNContactFormatter.descriptorForRequiredKeys(for: .fullName),CNContactPhoneNumbersKey] as [Any]
        let fetchRequest = CNContactFetchRequest(keysToFetch: keysToFetch as! [CNKeyDescriptor])
        var contacts = [CNContact]()
        CNContact.localizedString(forKey: CNLabelPhoneNumberiPhone)
        fetchRequest.mutableObjects = true
        fetchRequest.unifyResults = true
        fetchRequest.sortOrder = .userDefault
        
        let contactStoreID = CNContactStore().defaultContainerIdentifier()
        do {
            
            try CNContactStore().enumerateContacts(with: fetchRequest) { ( contact, stop) -> Void in
                if contact.phoneNumbers.count > 0 {
                    contacts.append(contact)
                }
                
            }
        } catch let e as NSError {
            print(e.localizedDescription)
        }
        
        return contacts
        
    }
    
    func setupSearchBar(){
        guard let size = navigationController?.navigationBar.frame else { return }
        btSearch = UISearchBar()
        //màu backgrounf cho searhbar
        btSearch.barTintColor = FunctionAll.share.BackGroundColor(typeColor: .backgroudnNavigation)
        btSearch.layer.borderColor = FunctionAll.share.BackGroundColor(typeColor: .backgroudnNavigation).cgColor
        btSearch.layer.borderWidth = 1
//        btSearch.placeholder = modeText.txtSearch
        //setup & Config txtSearchBar
        txtFieldSearch = btSearch.value(forKey: "_searchField") as! UITextField
        txtFieldSearch.backgroundColor = FunctionAll.share.BackGroundColor(typeColor: .SearchBarColor)
        txtFieldSearch.textColor = UIColor.white
        txtFieldSearch.text = modeText.txtSearch
        self.view.addSubview(btSearch)
        
        btSearch.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.height.equalTo(50)
            self.topSearchBar = make.top.equalToSuperview().offset(size.height + 20).constraint
        }
        
        btSearch.delegate = self


    }
    
    func setupSelectBt(){
        btRight = self.setupClearButton(title: "Select")
    }

}
extension AllContacts: UISearchBarDelegate{
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        //chỉnh khoảng cách top của searchbar
        self.topSearchBar?.update(offset: 20)
        UIView.animate(withDuration: 0.5) {
            self.view.layoutIfNeeded()

        }
        //Hide navigation
        self.navigationController?.navigationBar.isHidden = true
        //sadjust txtFieldSearch = nil
        txtFieldSearch.text = nil
        //Show button Cancel
        btSearch.setShowsCancelButton(true, animated: true)
        //setup & Config button Cancel
        if let cancelButton = searchBar.value(forKey: "cancelButton") as? UIButton {
            cancelButton.setTitle("Cancel", for: .normal)
            cancelButton.setTitleColor(UIColor.white, for: .normal)
//            cancelButton.setAttributedTitle(<your_nsattributedstring>, forState: <UIControlState>)
        }
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        //hide navigation
        self.navigationController?.navigationBar.isHidden = false
        //setup again top search bar
        guard let size = navigationController?.navigationBar.frame else { return }
        self.topSearchBar?.update(offset: size.height + 20)
        UIView.animate(withDuration: 0.5) {
            self.view.layoutIfNeeded()
        }
        btSearch.setShowsCancelButton(false, animated: true)
        //delete icon focus
        btSearch.endEditing(true)
        txtFieldSearch.text = modeText.txtSearch
    }
}
