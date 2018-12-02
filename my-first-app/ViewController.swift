//
//  ViewController.swift
//  my-first-app
//
//  Created by user146790 on 12/1/18.
//  Copyright © 2018 user146790. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    var songsArray: [Song] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "searchSongsSegue" {
            print("Yes it is")
            let controller = segue.destination as! SearchSongsViewController
            controller.delegate = self
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print("cellForRowAt")
        let songcell = tableView.dequeueReusableCell(withIdentifier: "songcell", for: indexPath) as! CustomTableViewCell
        
        let index: Int = indexPath.row
        songcell.nameSongLabel?.text = songsArray[index].name
        songcell.artistNameLabel?.text = songsArray[index].artistName
        
        return songcell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return songsArray.count
    }

}

