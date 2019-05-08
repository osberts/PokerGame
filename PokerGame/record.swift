//
//  record.swift
//  PokerGame
//
//  Created by User21 on 2019/5/8.
//  Copyright © 2019 app. All rights reserved.
//

import UIKit

class record: UIViewController {
    var nameText:String = " "

    @IBOutlet weak var point: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        point.text = nameText
        // Do any additional setup after loading the view.
    }
    


    @IBAction func back(_ sender: UIButton) {
        dismiss(animated: false)
    }
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }


}
