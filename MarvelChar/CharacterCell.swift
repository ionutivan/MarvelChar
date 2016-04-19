//
//  CharacterCell.swift
//  MarvelChar
//
//  Created by Ionut IVAN on 18/04/2016.
//  Copyright © 2016 Ionut IVAN. All rights reserved.
//

import UIKit

class CharacterCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBOutlet weak var nameLabel: UILabel!
    
    struct ViewData {
        let name: String
        init(character: MarvelCharacter) {
            name = character.name
        }
    }
    
    var data: ViewData? {
        didSet {
            if let data = data {
                nameLabel.text = data.name
            }
        }
    }
    
}
