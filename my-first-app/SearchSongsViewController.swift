//
//  SearchSongsViewController.swift
//  my-first-app
//
//  Created by user146790 on 12/1/18.
//  Copyright © 2018 user146790. All rights reserved.
//

import UIKit

class SearchSongsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    var songsArray: [Song] = []
    weak var delegate: ViewController!

    @IBOutlet var searchTextField: UITextField!
    @IBOutlet var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func searchSong(sender: UIButton) {
        print("searching...")
        
        if let query = self.searchTextField?.text {
            if query.count > 4 {
                print("Now really searching with", query)
                retrieveSongsByTerm(searchTerm: query)
            }
        }
    }

    @IBAction func addFav(sender: UIButton) {
        print("Selected index ")
        self.delegate.songsArray.append(songsArray[sender.tag])
    }

    @IBAction func playSample(sender: UIButton) {
        let preview = songsArray[sender.tag].previewURL
        print("preview " + preview!)
        PlayAudio.getInstance().playSound(with: preview)
    }
    
    func retrieveSongsByTerm(searchTerm: String) {
        let apiKey = "ODc5YzhmZTMtNjkwNy00ZmUwLTk2YjgtZGFiMTg5YzcwYmE1"
        let type = "track"
        var components = URLComponents()
        components.scheme = "https"
        components.host = "api.napster.com"
        components.path = "/v2.2/search/verbose"
        components.queryItems = [
            URLQueryItem(name: "apikey", value: apiKey),
            URLQueryItem(name: "query", value: searchTerm),
            URLQueryItem(name: "type", value: type)
        ]
        
        let url = components.url!
        HTTPHandler.getJson(urlString: url.absoluteString, completionHandler: parseDataIntoSongs)
    }
    
    func parseDataIntoSongs(data: Data?) -> Void {
        if let data = data {
            let object = JSONParser.parse(data: data)
            if let object = object {
                let data = object["search"]!["data"] as! [String: AnyObject]
                self.songsArray = SongDataProcessor.mapJsonToSongs(object: data, key: "tracks")
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let songcell = tableView.dequeueReusableCell(withIdentifier: "resultcell", for: indexPath) as! CustomTableViewCell
        
        let index: Int = indexPath.row
        songcell.nameSongLabel?.text = songsArray[index].name
        songcell.artistNameLabel?.text = songsArray[index].artistName
        songcell.albumNameLabel?.text = songsArray[index].albumName
        songcell.playButton?.tag = index
        songcell.favButton?.tag = index
        
        // let actionImage = UIImage.imageFromSystemBarButton(UIBarButtonItem.SystemItem.play)
        // songcell.playButton.setImage(actionImage, for: .normal)

        return songcell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return songsArray.count
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
