//
//  PlayerVC.swift
//  Podcast
//
//  Created by MARC on 5/10/20.
//  Copyright © 2020 MARC. All rights reserved.
//

import UIKit
import AVKit

class PlayerVC: UIView {
    
    var episode: Episode! {
        didSet {
            miniPlayerDescription.text = episode.description?.withoutHtml
            episodeLabel.text = episode.description?.withoutHtml
            author.text = episode.author
            episodeImage.layer.cornerRadius = 8
            episodeImage.layer.masksToBounds = true
            guard let url = URL(string: episode.imageURL ?? "") else { return }
            episodeImage.sd_setImage(with: url, completed: nil)
            miniPlayerImage.sd_setImage(with: url, completed: nil)
            playPodcast()
        }
    }
    
    let player: AVPlayer = {
        let avPlayer = AVPlayer()
        avPlayer.automaticallyWaitsToMinimizeStalling = false
        return avPlayer
    }()
    
    
//MARK:- OUTLETS
    @IBOutlet var author: UILabel!
    @IBOutlet var episodeLabel: UILabel!
    @IBOutlet var currentTimeSlider: UISlider!
    @IBOutlet var currentTimeLabel: UILabel!
    @IBOutlet var totalTimeLabel: UILabel!
    @IBOutlet var volumeControlSlider: UISlider!
    @IBOutlet var miniPLayerView: UIView!
    
    @IBOutlet var maximizedPlayerStackView: UIStackView!
    @IBOutlet var miniPlayerStackView: UIStackView!
    @IBOutlet var miniPlayerDescription: UILabel!
    @IBOutlet var miniPlayerImage: UIImageView!
    
    @IBOutlet var forwardMini: UIButton! {
        didSet {
            forwardMini.transform = CGAffineTransform(scaleX: 0.7, y: 0.7)
        }
    }
    
    
    @IBOutlet var miniPlay: UIButton! {
        didSet{
            miniPlay.transform = CGAffineTransform(scaleX: 0.6, y: 0.6)
        }
    }
    
    
    @IBAction func miniPlayerPlay(_ sender: Any) {
        playPause()
    }
    @IBAction func miniPlayerForward(_ sender: Any) {
        forwardOrRewind(value: 15)
    }
    
    
    
    
    @IBAction func rewind(_ sender: Any) {
        forwardOrRewind(value: -15)
    }
    
    @IBAction func forward(_ sender: Any) {
        forwardOrRewind(value: 15)
    }

    
    @IBAction func volumeController(_ sender: Any) {
        player.volume = volumeControlSlider.value
    }
    
    
    private func forwardOrRewind(value: Int64) {
        let fifteenSeconds = CMTimeMake(value: value, timescale: 1)
        let seeking = CMTimeAdd(player.currentTime(), fifteenSeconds)
        player.seek(to: seeking)
    }
    
    @IBAction func trackTimeSlider(_ sender: Any) {
        let percentage = currentTimeSlider.value
        guard let duration = player.currentItem?.duration else { return }
        let durationInSeconds = CMTimeGetSeconds(duration)
        
        let seekTimeInSeconds = Float64(percentage) * durationInSeconds
        let seekTime = CMTimeMakeWithSeconds(seekTimeInSeconds, preferredTimescale: 1)
        player.seek(to: seekTime)
        
    }
    
    
    @IBOutlet var episodeImage: UIImageView! {
        didSet {
            shrinkImage()
        }
    }
    
   static func initNib() -> PlayerVC {
        return Bundle.main.loadNibNamed("PlayerView", owner: self, options: nil)?.first as! PlayerVC
    }
    
    private func getPodcastCurrentTime() {
        let interval = CMTimeMake(value: 1, timescale: 2)
        player.addPeriodicTimeObserver(forInterval: interval, queue: .main) { [weak self] (time) in
            guard let self = self else { return }
            self.currentTimeLabel.text = time.toDisplayCMTime()
            self.totalTimeLabel.text = self.player.currentItem?.duration.toDisplayCMTime()
            self.currentTimeSliderPoadcast()
        }
    }
    
    func currentTimeSliderPoadcast() {
        let currentTimeSeconds = CMTimeGetSeconds(player.currentTime())
        let durationSeconds = CMTimeGetSeconds(player.currentItem?.duration ?? CMTimeMake(value: 1, timescale: 1))
        let percentage = currentTimeSeconds / durationSeconds
        currentTimeSlider.value = Float(percentage)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        getPodcastCurrentTime()
        
        let time = CMTimeMake(value: 1, timescale: 3)
        let times = [NSValue(time: time)]
        player.addBoundaryTimeObserver(forTimes: times, queue: .main) { [weak self] in
            guard let self = self  else { return }
            self.enlargeImage()
        }
        
        addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tapMaximize)))
    }
    
    @objc func tapMaximize() {
        let rootview = UIApplication.shared.windows.first?.rootViewController as! RootViewController
        rootview.maximizePlayer(episode: nil)
    }
    
    
    @IBOutlet var playOrPause: UIButton! {
        didSet {
            playOrPause.setImage(#imageLiteral(resourceName: "pause"), for: .normal)
            playOrPause.addTarget(self, action: #selector(playPause), for: .touchUpInside)
            
        }
    }
    
    @objc func playPause() {
        if player.timeControlStatus == .paused {
            player.play()
            playOrPause.setImage(#imageLiteral(resourceName: "pause"), for: .normal)
            miniPlay.setImage(#imageLiteral(resourceName: "pause"), for: .normal)
            enlargeImage()
        } else {
            player.pause()
            playOrPause.setImage(#imageLiteral(resourceName: "play"), for: .normal)
            miniPlay.setImage(#imageLiteral(resourceName: "play"), for: .normal)
            shrinkImage()
        }
    }
    
    @IBAction func dismiss(_ sender: Any) {
        let application = UIApplication.shared.windows.first?.rootViewController as! RootViewController
        application.minimizePlayer()
    }
    
    private func playPodcast() {
        guard let url = URL(string: episode.streamURL ?? "") else { return }
        let playerItem = AVPlayerItem(url: url)
        player.replaceCurrentItem(with: playerItem)
        player.play()
    }
    
    private func enlargeImage() {
        UIView.animate(withDuration: 0.75, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 1, options: .curveEaseIn, animations: {
            self.episodeImage.transform = .identity
        })
    }
    
    private func shrinkImage(){
        UIView.animate(withDuration: 0.75, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 1, options: .curveEaseIn, animations: {
            let scale: CGFloat = 0.8
            self.episodeImage.transform = CGAffineTransform(scaleX: scale, y: scale)
        })
    }
    
    
    
}
