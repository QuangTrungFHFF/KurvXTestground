//
//  ScanningViewController.swift
//  KurvX testground
//
//  Created by Trung Tran on 15.03.22.
//

import UIKit

class ScanningViewController: UIViewController {
    
    let names = ["KurvX 1",
                 "KurvX 2",
                 "KurvX 3"]
    
    private var kurvxManager: KurvxBLEPeripheralManager?
    

    @IBOutlet weak var scannedPeripheralsTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        kurvxManager = KurvxBLEPeripheralManager.shared
        
        scannedPeripheralsTableView.delegate = self
        scannedPeripheralsTableView.dataSource = self

        // Do any additional setup after loading the view.
    }
    
    @IBAction func scanButtonPressed(_ sender: UIButton) {
        kurvxManager?.discoverDevices()
        print("You tapped scan!")
    }
    
    

}

extension ScanningViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("You tapped me!")
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension ScanningViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return names.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "KurvxItemCell", for: indexPath)
        cell.textLabel?.text = "Hello World \(indexPath.row)"
        cell.detailTextLabel?.text = names[indexPath.row]
        return cell
        
    }
}
