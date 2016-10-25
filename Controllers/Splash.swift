//
//  ViewController.swift
//  reidocardapio
//
//  Created by Bruno Rocha on 27/09/16.
//  Copyright © 2016 Bruno Rocha. All rights reserved.
//

import UIKit

class Splash: UIViewController {
    
    @IBOutlet weak var lblSemConexao : UILabel!
    var myActivityIndicator = UIActivityIndicatorView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        lblSemConexao.hidden = true
        iniciarComponentes()
    }
    
    func iniciarComponentes(){
        myActivityIndicator = UIActivityIndicatorView(frame: CGRectMake(0,0,50,50))
        myActivityIndicator.center = self.view.center
        myActivityIndicator.hidesWhenStopped = true
        myActivityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.Gray
        self.view.addSubview(myActivityIndicator)
    }
    
    override func viewDidAppear(animated: Bool) {
        activityInSwitch(true)
        
        if Utilities.isConnectedToNetwork() {
//            sleep(2)
            carregarDadosWeb()
        }
        else{
            lblSemConexao.hidden = false
            activityInSwitch(false)
        }
    }
    
    func activityInSwitch(ligar:Bool){
        if (ligar){
            self.myActivityIndicator.startAnimating()
            UIApplication.sharedApplication().beginIgnoringInteractionEvents()
        }else{
            self.myActivityIndicator.stopAnimating()
            UIApplication.sharedApplication().endIgnoringInteractionEvents()
        }
    }

    func carregarDadosWeb() {
        let urlWBS = NSURL(string:"http://egcservices.com.br/webservices/ios/cardapio/listar_bairros.php")!
        let request = NSMutableURLRequest(URL:urlWBS)
        request.HTTPMethod = "POST"
        
        let task = NSURLSession.sharedSession().dataTaskWithRequest(request) { data, response, error in
            
            if(error != nil){
                self.activityInSwitch(false)
                //print("error = \(error!)")
                self.exibirAlert("Aconteceu um Erro!", msg: "Por favor, tente novamente!", btn: "Continuar")
                return
            }
            
            do{
                let myJSON = try NSJSONSerialization.JSONObjectWithData(data!, options: .MutableContainers) as? NSDictionary
                
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    
                    if let parseJSON = myJSON {
                        let results = parseJSON["bairros"] as! NSArray
                        if (results.count > 0){
                            for result in results {
                                let r = result["bairro"] as! String
                                listaBairrosWeb.append(r)
                            }
                            
                            if (listaBairrosWeb.count == results.count){
                                self.carregarCategoriasWeb()
                            }else{
                                self.exibirAlert("Aconteceu um Erro!", msg: "Por favor, tente novamente!", btn: "Continuar")
                                self.carregarDadosWeb()
                            }
                            
                        }else{
                            self.exibirAlert("Aconteceu um Erro!", msg: "Por favor, tente novamente!", btn: "Continuar")
                            self.carregarDadosWeb()
                        }
                    }
                })
                
            }catch{ }
        }
        task.resume()
    }
    
    func carregarCategoriasWeb() {
        let urlWBS = NSURL(string:"http://egcservices.com.br/webservices/ios/cardapio/listar_categorias.php")!
        let request = NSMutableURLRequest(URL:urlWBS)
        request.HTTPMethod = "POST"
        
        let task = NSURLSession.sharedSession().dataTaskWithRequest(request) { data, response, error in
            
            if(error != nil){
                self.activityInSwitch(false)
                self.exibirAlert("Aconteceu um Erro!", msg: "Por favor, tente novamente!", btn: "Continuar")
                return
            }
            
            do{
                let myJSON = try NSJSONSerialization.JSONObjectWithData(data!, options: .MutableContainers) as? NSDictionary
                
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    
                    if let parseJSON = myJSON {
                        let results = parseJSON["categorias"] as! NSArray
                        if (results.count > 0){
                            for result in results {
                                let r = result["descricao"] as! String
                                listaCategoriasWeb.append(r)
                            }
                            
                            if (listaCategoriasWeb.count == results.count){
                                self.activityInSwitch(false)
                                self.performSegueWithIdentifier("principal", sender: self)
                            }else{
                                self.exibirAlert("Aconteceu um Erro!", msg: "Por favor, tente novamente!", btn: "Continuar")
                                self.carregarDadosWeb()
                            }
                            
                        }else{
                            self.exibirAlert("Aconteceu um Erro!", msg: "Por favor, tente novamente!", btn: "Continuar")
                            self.carregarDadosWeb()
                        }
                    }
                })
                
            }catch{ }
        }
        task.resume()
    }

    
    func exibirAlert(t:String, msg:String, btn:String){
        let alert = UIAlertController(title: t, message: msg, preferredStyle:UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: btn, style: UIAlertActionStyle.Default, handler: nil))
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
}

