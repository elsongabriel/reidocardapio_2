//
//  InformacaoRest.swift
//  reidocardapio
//
//  Created by Bruno Rocha on 26/10/16.
//  Copyright © 2016 Bruno Rocha. All rights reserved.
//

import UIKit

class InformacaoRest: UIViewController {
    
    @IBOutlet var img: UIImageView!
    @IBOutlet var progress: UIActivityIndicatorView!
    @IBOutlet var nomeRest: UILabel!
    @IBOutlet var categRest: UILabel!
    @IBOutlet var formasPgtoRest: UILabel!
    @IBOutlet var horariosRest: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(animated: Bool) {
        activityInSwitch(true)
        
        //carrega a imagem
        let url = NSURL(string: "\(restauranteSelecionado.getImagem())")!
        let task = NSURLSession.sharedSession().dataTaskWithURL(url) { data, response, error in
            
            if(error != nil){
                self.activityInSwitch(false)
                print("error = \(error!)")
                return
            }
            
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                if data != nil{
                    self.activityInSwitch(false)
                    self.img.image = UIImage(data: data!)
                }
            })
        }
        task.resume()
        
        nomeRest.text = restauranteSelecionado.getNome()
        categRest.text = restauranteSelecionado.getCategoria()
        formasPgtoRest.text = restauranteSelecionado.getAvaliacoes()
        horariosRest.text = restauranteSelecionado.getAvaliacoes()
    }
    
    func activityInSwitch(ligar:Bool){
        if (ligar){
            self.progress.startAnimating()
//            UIApplication.sharedApplication().beginIgnoringInteractionEvents()
        }else{
            self.progress.stopAnimating()
//            UIApplication.sharedApplication().endIgnoringInteractionEvents()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
