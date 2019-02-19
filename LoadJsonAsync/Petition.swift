//
//  Petition.swift
//  LoadJsonAsync
//
//  Created by Sprinthub on 13/02/2019.
//  Copyright © 2019 Sprinthub Mobile. All rights reserved.
//

import Foundation


struct Petition: Codable {
    var title: String
    var body: String
    var signatureCount: Int
}
