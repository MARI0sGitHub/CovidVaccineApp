//
//  LocalVaccineInfosTableViewController.swift
//  vaccine
//
//  Created by MAC BOOK PRO 2013 EARLY on 2022/09/07.
//

import UIKit

class LocalVaccineInfosTableViewController: UITableViewController {
    @IBOutlet weak var vaccine1all: UITableViewCell!
    @IBOutlet weak var vaccine1new: UITableViewCell!
    @IBOutlet weak var vaccine1old: UITableViewCell!
    @IBOutlet weak var vaccine2all: UITableViewCell!
    @IBOutlet weak var vaccine2new: UITableViewCell!
    @IBOutlet weak var vaccine2old: UITableViewCell!
    @IBOutlet weak var vaccine3all: UITableViewCell!
    @IBOutlet weak var vaccine3new: UITableViewCell!
    @IBOutlet weak var vaccine3old: UITableViewCell!
    @IBOutlet weak var vaccine4all: UITableViewCell!
    @IBOutlet weak var vaccine4new: UITableViewCell!
    @IBOutlet weak var vaccine4old: UITableViewCell!
    
    var vaccineInfos : VaccineInfos?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setTableView()
    }
    
    func getString(_ num : Int)->String {
        var ret = "\(num)"
        if ret.count <= 3 { return ret }
        var idx = ret.count - 3
        while idx > 0 {
            ret.insert(",", at: ret.index(ret.startIndex, offsetBy: idx))
            idx -= 3
        }
        return ret
    }
  
    func setTableView() {
        guard let infos = vaccineInfos else {
            return
        }
        title = infos.countryNm
        vaccine1all.detailTextLabel?.text = getString(infos.vaccine_1.vaccine_1)
        vaccine1new.detailTextLabel?.text = getString(infos.vaccine_1.vaccine_1_new)
        vaccine1old.detailTextLabel?.text = getString(infos.vaccine_1.vaccine_1_old)
        
        vaccine2all.detailTextLabel?.text = getString(infos.vaccine_2.vaccine_2)
        vaccine2new.detailTextLabel?.text = getString(infos.vaccine_2.vaccine_2_new)
        vaccine2old.detailTextLabel?.text = getString(infos.vaccine_2.vaccine_2_old)
        
        vaccine3all.detailTextLabel?.text = getString(infos.vaccine_3.vaccine_3)
        vaccine3new.detailTextLabel?.text = getString(infos.vaccine_3.vaccine_3_new)
        vaccine3old.detailTextLabel?.text = getString(infos.vaccine_3.vaccine_3_old)
        
        vaccine4all.detailTextLabel?.text = getString(infos.vaccine_4.vaccine_4)
        vaccine4new.detailTextLabel?.text = getString(infos.vaccine_4.vaccine_4_new)
        vaccine4old.detailTextLabel?.text = getString(infos.vaccine_4.vaccine_4_old)
    }
}
