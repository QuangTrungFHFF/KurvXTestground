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
    

    @IBOutlet weak var scannedPeripheralsTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scannedPeripheralsTableView.delegate = self
        scannedPeripheralsTableView.dataSource = self

        // Do any additional setup after loading the view.
    }
    
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

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
