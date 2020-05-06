//
//  TableView+ext.swift
//  Podcast
//
//  Created by MARC on 5/5/20.
//  Copyright © 2020 MARC. All rights reserved.
//

import UIKit

extension UITableView {
    func removeExcellCell() {
        tableFooterView = UIView(frame: .zero)
    }
}
