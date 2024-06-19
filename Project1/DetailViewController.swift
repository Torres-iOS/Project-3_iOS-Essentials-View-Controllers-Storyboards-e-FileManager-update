//
//  DetailViewController.swift
//  Project1
//
//  Created by Matheus Torres on 10/06/24.
//

import UIKit

class DetailViewController: UIViewController {
    @IBOutlet var imageView: UIImageView!
    
    var selectedImage: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Não deixa os títulos ficarem grandes
        navigationItem.largeTitleDisplayMode = .never

        if let imageToLoad = selectedImage {
            // Formata o nome do arquivo
            let heroName = formatFileName(imageToLoad)
            
            // Define o título formatado
            title = heroName
            
            navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareTapped))
            

            // Carrega a imagem
            imageView.image = UIImage(named: imageToLoad)
        }
    }
    
    func formatFileName(_ fileName: String) -> String {
        var formattedName = fileName.replacingOccurrences(of: "avengers_", with: "")
        formattedName = formattedName.replacingOccurrences(of: "-", with: " ")
        formattedName = formattedName.capitalized
        return formattedName
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // Se algo não estiver dentro do navigation controller, o hidesBarsOnTap não faz nada
        navigationController?.hidesBarsOnTap = true
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        // Se algo não estiver dentro do navigation controller, o hidesBarsOnTap não faz nada
        navigationController?.hidesBarsOnTap = false
    }
    
    @objc func shareTapped(){
        guard let image = imageView.image?.jpegData(compressionQuality: 0.8) else {
            print("Não foi encontrado uma imagem")
            return
        }
        
        let vc = UIActivityViewController(activityItems: [image], applicationActivities: [])
        vc.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
        present(vc, animated: true)
    }
}
