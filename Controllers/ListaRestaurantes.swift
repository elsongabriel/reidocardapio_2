//
//  ListaRestaurantes.swift
//  reidocardapio
//
//  Created by Bruno Rocha on 13/10/16.
//  Copyright © 2016 Bruno Rocha. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit

var categoriaSelecionada : Categoria!
var restauranteSelecionado : Restaurante!

extension NSMutableData {
    
    func appendString(string: String) {
        let data = string.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: true)
        appendData(data!)
    }
}

class ListaRestaurantes: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var lblQtdRestsEncontrados: UILabel!
    @IBOutlet weak var lblInfoRestsEncontrados: UILabel!
    @IBOutlet var myTableView: UITableView!
    
    var listaRestaurantes : [Restaurante]!
    var sortPos = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        listaRestaurantes = [Restaurante]()
        categoriaSelecionada = Categoria()
        restauranteSelecionado = Restaurante()
        categoriaSelecionada.setId(-1)
        categoriaSelecionada.setDescricao("")
        
        myTableView.delegate = self
        myTableView.dataSource = self
        
        carregarRestaurantes()
    }
    
    override func viewDidAppear(animated: Bool) {
        if categoriaSelecionada.getId() != -1 {
            print("cat selecionada: \(categoriaSelecionada.getDescricao())")
        }
    }
    
    func carregarRestaurantes(){
        let urlWBS = NSURL(string:"http://egcservices.com.br/webservices/ios/cardapio/listar_rests.php")!
        let request = NSMutableURLRequest(URL:urlWBS)
        request.HTTPMethod = "POST"
        
        let task = NSURLSession.sharedSession().dataTaskWithRequest(request) { data, response, error in
            
            if(error != nil){
                print("error = \(error!)")
                
                let alert = UIAlertController(title: "Aconteceu um Erro!", message: "Por favor, tente novamente!", preferredStyle:UIAlertControllerStyle.Alert)
                alert.addAction(UIAlertAction(title: "Continuar", style: UIAlertActionStyle.Default, handler: nil))
                self.presentViewController(alert, animated: true, completion: nil)
                
                return
            }
            
            do{
                let myJSON = try NSJSONSerialization.JSONObjectWithData(data!, options: .MutableContainers) as? NSDictionary
                
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    
                    if let parseJSON = myJSON {
                        self.listaRestaurantes = [Restaurante]()
                        let results = parseJSON["restaurantes"] as! NSArray
                        
                        if (results.count > 0){
                            for result in results {
                                let rest = Restaurante()
                                
                                let i = Int(result["id"] as! String)!
                                let n = result["nome"] as! String
                                let e = result["endereco"] as! String
                                let lt = result["latitude"] as! String
                                let ln = result["longitude"] as! String
                                let k = result["km_permitidos"] as! String
                                
                                rest.setId(i)
                                rest.setNome(n)
                                rest.setEndereco(e)
                                
                                rest.setLatitude(lt)
                                rest.setLongitude(ln)
                                rest.setKms(k)
                                
                                self.listaRestaurantes.append(rest)
                            }
                            
                            self.myTableView.reloadData()
                            
                        }else{
                            print("não trouxe rests")
                        }
                        
                    }
                })
                
            }catch{ }
        }
        task.resume()
        
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if listaRestaurantes.count > 0{
            self.lblQtdRestsEncontrados.text = "\(listaRestaurantes.count)"
            self.lblQtdRestsEncontrados.hidden = false
            self.lblInfoRestsEncontrados.hidden = false
            self.lblInfoRestsEncontrados.text = "restaurantes com delivery na sua localização"
        }else{
            self.lblQtdRestsEncontrados.hidden = true
            self.lblInfoRestsEncontrados.text = "Não foram encontrados restaurantes próximo a você, que pena :/ "
        }
        return listaRestaurantes.count
    }
    
     func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("mycell", forIndexPath: indexPath)
        
        cell.textLabel?.text = listaRestaurantes[indexPath.row].getNome()
        
        return cell
    }
    
    var myTxt = UITextField()
    @IBAction func procurar(sender: AnyObject) {
        let alert = UIAlertController(title: "Pesquise seu restaurante favorito", message: "", preferredStyle: .Alert)
        
        alert.addTextFieldWithConfigurationHandler { (txt:UITextField) in
            txt.placeholder = "Digite o nome do restaurante"
            self.myTxt = txt
        }
        
        alert.addAction(UIAlertAction(title: "ok", style: UIAlertActionStyle.Default, handler: {(action) -> Void in
            self.procurarPorTxt(self.myTxt.text!)
        }))
        
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    func procurarPorTxt(txt : String){
        for item in listaRestaurantes{
            if item.getNome().containsString(txt){
                print("achou restaurante: \(item.getNome())")
                break
            }
        }
        print("não achou nada")
    }
    
    @IBAction func ordenar(sender: AnyObject) {
        
        let alert = UIAlertController(title: title, message: "Como você prefere?", preferredStyle:UIAlertControllerStyle.ActionSheet)
        
        alert.addAction(UIAlertAction(title: "Mais próximos", style: UIAlertActionStyle.Default, handler: { (action) -> Void in
            print("mostrar mais próximos")
        }))
        alert.addAction(UIAlertAction(title: "Alfabeticamente", style: UIAlertActionStyle.Default, handler: { (action) -> Void in
            if self.sortPos == 0 {
                self.listaRestaurantes.sortInPlace({ $0.getNome() < $1.getNome() })
                self.sortPos = 1
            }else{
                self.listaRestaurantes.sortInPlace({ $0.getNome() > $1.getNome() })
                self.sortPos = 0
            }
            self.myTableView.reloadData()
        }))
        alert.addAction(UIAlertAction(title: "Cancelar", style: UIAlertActionStyle.Cancel, handler: nil))
        
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {

        let cell = tableView.cellForRowAtIndexPath(indexPath)!
        cell.accessoryType = .Checkmark
        restauranteSelecionado.setNome(cell.textLabel!.text!)
        
        print("rest sel: \(restauranteSelecionado.getNome())")
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
