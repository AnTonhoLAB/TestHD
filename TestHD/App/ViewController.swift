//
//  ViewController.swift
//  TestHD
//
//  Created by George Gomes on 20/11/23.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var AlbumsTableView: UITableView!
    
    private let service: ServiceProtocol
    private let viewModel: AlbumViewModelProtocol
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        
        service = Service()
        viewModel = AlbumViewModel(service: service)
        
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        service = Service()
        viewModel = AlbumViewModel(service: service)
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.AlbumsTableView.dataSource = self
        
        Task  {
            await viewModel.callAlbums()
            self.AlbumsTableView.reloadData()
        }
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.albums.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "AlbumCell", for: indexPath) as? AlbumCell else { return UITableViewCell()}

        cell.titleLabel.text = viewModel.albums[indexPath.row].title
        Task {
            let urlString = viewModel.albums[indexPath.row].thumbnailUrl
            let dataImage = try await viewModel.callImageFrom(urlString: urlString)
            cell.AlbumImage.image = UIImage(data: dataImage)
        }
        
        return cell
    }
}

