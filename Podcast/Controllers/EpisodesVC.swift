//
//  EpisodesVC.swift
//  Podcast
//
//  Created by MARC on 5/6/20.
//  Copyright © 2020 MARC. All rights reserved.
//

import UIKit

class EpisodesVC: UITableViewController {
    
    var episode: [Episode] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()

    }
    
    func setupTableView() {
        let nib = UINib(nibName: "EpisodeCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: cellID.episodeCellID)
        tableView.removeExcellCell()
        tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        
        let indicatorView = UIActivityIndicatorView(style: .large)
        indicatorView.color = .darkGray
        indicatorView.startAnimating()
        
        let label = UILabel()
        label.textAlignment = .center
        label.text = "Plase wait while we search."
        label.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        label.textColor = .systemPurple
                
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.addArrangedSubview(indicatorView)
        stackView.addArrangedSubview(label)
        
        return stackView
    }
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return episode.isEmpty ? 100 : 0
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return episode.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID.episodeCellID, for: indexPath) as! EpisodeCell
        cell.episode = episode[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 170
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let episodes = episode[indexPath.row]
        let rootView = UIApplication.shared.windows.first?.rootViewController as! RootViewController
        rootView.maximizePlayer(episode: episodes)
    }


}
