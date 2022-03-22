//
//  ScanningViewController.swift
//  KurvX testground
//
//  Created by Trung Tran on 15.03.22.
//

import UIKit
import CoreBluetooth

class ScanningViewController: UIViewController {
    
    
    private var discoveredKurvxs = [ScannedKurvX]()
    
    private var kurvxManager: KurvxBLEPeripheralManager?
    
    @IBOutlet weak var startScanButton: UIButton!
    @IBOutlet weak var stopScanButton: UIButton!
    @IBOutlet weak var scannedPeripheralsTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        kurvxManager = KurvxBLEPeripheralManager.shared
        kurvxManager?.kurvxDiscoveringDelegate = self
        
        scannedPeripheralsTableView.delegate = self
        scannedPeripheralsTableView.dataSource = self

        // Do any additional setup after loading the view.
    }
    
    @IBAction func scanButtonPressed(_ sender: UIButton) {
        kurvxManager?.discoverDevices()
        
        print("You tapped scan!")
    }
    
    //MARK: Scanning
    
    private func addKurvxToDiscoveredList(didDiscover peripheral: CBPeripheral, serial serialNumber: String, model modelNumber: String, rssi: Int64){
        if !isKurvxAlreadyInList(kurvx: peripheral){
            let kurvx = ScannedKurvX(didDiscover: peripheral, withSerial: serialNumber, withModel: modelNumber, withRSSI: rssi)
            self.discoveredKurvxs.append(kurvx)
        }
    }
    
    private func isKurvxAlreadyInList(kurvx peripheral: CBPeripheral)->Bool{
        for discoveredKurvx in discoveredKurvxs {
            if(discoveredKurvx.peripheral.identifier == peripheral.identifier){
                return true
            }
        }
        return false
    }

}

extension ScanningViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("You tapped the table!")
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension ScanningViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return discoveredKurvxs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "KurvxItemCell", for: indexPath)
        cell.textLabel?.text = discoveredKurvxs[indexPath.row].peripheral.name
        cell.detailTextLabel?.text = discoveredKurvxs[indexPath.row].serialNumber
        return cell
    }
}

extension ScanningViewController: KurvxDiscoveringDelegate{
    func onKurvxDiscovered(didDiscover peripheral: CBPeripheral, withSerial serialNumber: String, withModel modelNumber: String, withRSSI rssi: Int64) {
        addKurvxToDiscoveredList(didDiscover: peripheral, serial: serialNumber, model: modelNumber, rssi: rssi)
        DispatchQueue.main.async {
            self.scannedPeripheralsTableView.reloadData()
        }
        
    }
}
