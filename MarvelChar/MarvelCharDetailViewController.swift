//
//  MarvelCharDetailViewController.swift
//  MarvelChar
//
//  Created by Ionut IVAN on 19/04/2016.
//  Copyright © 2016 Ionut IVAN. All rights reserved.
//

import UIKit
import Kingfisher

class MarvelCharDetailViewController: UIViewController {
    
    @IBOutlet weak var closeButton: UIButton!
    @IBOutlet weak var heroImage: UIImageView!
    @IBOutlet weak var heroNameLabel: UILabel!
    @IBOutlet weak var summaryLabel: UILabel!
    @IBOutlet weak var detailButton: UIButton!
    @IBOutlet weak var wikiButton: UIButton!
    @IBOutlet weak var comicsButton: UIButton!
    
    let marvelCharacter: MarvelCharacter

    init(marvelCharacter: MarvelCharacter) {
        self.marvelCharacter = marvelCharacter
        super.init(nibName: "MarvelCharDetailViewController", bundle: .mainBundle())
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        preconditionFailure("MarvelCharDetailViewController must me initialised with a character")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        heroNameLabel.text = marvelCharacter.name
        if let url = NSURL(string:marvelCharacter.thumbnail.description) {
            heroImage.kf_setImageWithURL(url)
        }
        summaryLabel.text = marvelCharacter.summary
        let time = Int(NSDate().timeIntervalSince1970)
        let path = String(format:Constant.Endpoint.characterDetail.rawValue, marvelCharacter.id)
        let resource = Resource<MarvelCharacter>(path: path,
                                method: .GET,
                                requestParameters: ["apikey":Constant.apiPublicKey.rawValue,
                                    "ts": time,
                                    "hash":marvelHash(Constant.apiPublicKey.rawValue,
                                        timeStamp: time,
                                        privateKey:Constant.apiPrivateKey.rawValue)],
                                headers: ["Content-Type": "application/json"], parse: marvelCharacter.addDetails)
        let failure: ErrorType -> () = { e in }
        resource.loadAsynchronous(failure: failure) { [weak self] character in
            guard let urls = character.details?.characterURLs else {
                return
            }
            dispatch_async(dispatch_get_main_queue()) {
                for url in urls {
                    switch url {
                    case .Detail(_):
                        self?.detailButton.hidden = false
                    case .ComicLink(_):
                        self?.comicsButton.hidden = false
                    case .Wiki(_):
                        self?.wikiButton.hidden = false
                    }
                }
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func closeView(button: UIButton) {
        presentingViewController?.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func goToHeroDetail(button: UIButton) {
        guard let characterURLs = marvelCharacter.details?.characterURLs else {
            return
        }
        for url in characterURLs {
            if case .Detail(let urlToOpen) = url {
                guard let urlToOpen = NSURL(string:urlToOpen) else {
                    return
                }
                UIApplication.sharedApplication().openURL(urlToOpen)
            }
        }
        
    }
    
    @IBAction func goToHeroWiki(button: UIButton) {
        guard let characterURLs = marvelCharacter.details?.characterURLs else {
            return
        }
        for url in characterURLs {
            if case .Wiki(let urlToOpen) = url {
                guard let urlToOpen = NSURL(string:urlToOpen) else {
                    return
                }
                UIApplication.sharedApplication().openURL(urlToOpen)
            }
        }
    }
    
    @IBAction func goToHeroComics(button: UIButton) {
        guard let characterURLs = marvelCharacter.details?.characterURLs else {
            return
        }
        for url in characterURLs {
            if case .ComicLink(let urlToOpen) = url {
                guard let urlToOpen = NSURL(string:urlToOpen) else {
                    return
                }
                UIApplication.sharedApplication().openURL(urlToOpen)
            }
        }
    }
}
