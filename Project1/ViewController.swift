//
//  ViewController.swift
//  Project1
//
//  Created by Matheus  Torres on 10/06/24.
//

import UIKit

class ViewController: UITableViewController {
    var pictures = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Habilita large titles no meu app na lista
        navigationController?.navigationBar.prefersLargeTitles = true
        title = "Avengers List"

        let fm = FileManager.default
        let path = Bundle.main.resourcePath!
        let items = try! fm.contentsOfDirectory(atPath: path)
        
        for item in items {
            if item.hasPrefix("avengers") {
                pictures.append(item)
                pictures.sort()
            }
        }
        
        print(pictures)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pictures.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Picture", for: indexPath)
        cell.textLabel?.text = formatFileName(pictures[indexPath.row])
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // 1: Tenta carregar o "Detail" view controller e typecasting para DetailViewController
        if let vc = storyboard?.instantiateViewController(withIdentifier: "Detail") as? DetailViewController {
            // 2: Sucesso! Define sua propriedade selectedImage
            vc.selectedImage = pictures[indexPath.row]

            // 3: Agora empurre-o para o navigation controller
            navigationController?.pushViewController(vc, animated: true)
        }
    }

    func formatFileName(_ fileName: String) -> String {
        var formattedName = fileName.replacingOccurrences(of: "avengers_", with: "")
        formattedName = formattedName.replacingOccurrences(of: ".Jpg", with: "")
        formattedName = formattedName.replacingOccurrences(of: ".jpeg", with: "")
        formattedName = formattedName.replacingOccurrences(of: "-", with: " ")
        formattedName = formattedName.capitalized
        return formattedName
    }
}
