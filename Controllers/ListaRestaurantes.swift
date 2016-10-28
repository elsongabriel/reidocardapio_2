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

//var categoriaSelecionada : Categoria!
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
    @IBOutlet var noItensFound: UIImageView!
    
    var myActivityIndicator = UIActivityIndicatorView()
    var listaRestaurantes : [Restaurante]!
    var sortPos = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        listaRestaurantes = [Restaurante]()
//        categoriaSelecionada = Categoria()
        restauranteSelecionado = Restaurante()
//        categoriaSelecionada.setId(-1)
//        categoriaSelecionada.setDescricao("")
        
        myTableView.delegate = self
        myTableView.dataSource = self
        
        iniciarComponentes()
    }
    
    func iniciarComponentes(){
        myActivityIndicator = UIActivityIndicatorView(frame: CGRectMake(0,0,50,50))
        myActivityIndicator.center = self.view.center
        myActivityIndicator.hidesWhenStopped = true
        myActivityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.Gray
        self.view.addSubview(myActivityIndicator)
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
    
    override func viewDidAppear(animated: Bool) {
        carregarRestaurantes()//-1)//categoriaSelecionada.getId())
    }
    
    func carregarRestaurantes(){ //value: Int){
        self.activityInSwitch(true)
        
        let urlWBS = NSURL(string:"http://egcservices.com.br/webservices/ios/cardapio/listar_rests.php")!
        let request = NSMutableURLRequest(URL:urlWBS)
        request.HTTPMethod = "POST"
        request.timeoutInterval = 10
        
//        let body = NSMutableData()
//        let boundary = "Boundary-\(NSUUID().UUIDString)"
//        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
//        body.appendString("--\(boundary)\r\n")
//        body.appendString("Content-Disposition: form-data; name=\"categoria\"\r\n\r\n")
//        body.appendString("\(value)\r\n")
//        body.appendString("--\(boundary)\r\n")
//        request.HTTPBody = body as NSData
        
        let task = NSURLSession.sharedSession().dataTaskWithRequest(request) { data, response, error in
            
            if(error != nil){
                print("error = \(error!)")
                self.activityInSwitch(false)
                
                if error!.code == 1005{
                    
                    let alert = UIAlertController(title: "Problemas na Conexão", message: "Ocorreu um problema ao tentar conectar com o servidor!", preferredStyle:UIAlertControllerStyle.Alert)
                    alert.addAction(UIAlertAction(title: "Continuar", style: UIAlertActionStyle.Default, handler: nil))
                    self.presentViewController(alert, animated: true, completion: nil)
                }else{
                
                    let alert = UIAlertController(title: "Aconteceu um Erro!", message: "Por favor, tente novamente!", preferredStyle:UIAlertControllerStyle.Alert)
                    alert.addAction(UIAlertAction(title: "Continuar", style: UIAlertActionStyle.Default, handler: nil))
                    self.presentViewController(alert, animated: true, completion: nil)
                }
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
                                
                                let id = Int(result["id"] as! String)!
                                let nome = result["nome"] as! String
                                let end = result["endereco"] as! String
                                let email = result["email"] as! String
                                let tel1 = result["telefone1"] as! String
                                let tel2 = result["telefone2"] as! String
                                
                                let pre = result["preco_minimo"] as! String
                                let tmp = result["tempo_medio"] as! String
                                let img = result["imagem"] as! String
                                
                                let lt = result["latitude"] as! String
                                let ln = result["longitude"] as! String
                                let k = result["km_permitidos"] as! String
                                
                                rest.setId(id)
                                rest.setNome(nome)
                                rest.setEndereco(end)
                                rest.setEmail(email)
                                rest.setTelefone1(tel1)
                                rest.setTelefone2(tel2)
                                
                                rest.setPrecoMin(pre)
                                rest.setTempoMedio(tmp)
                                rest.setImagem(img)
                                
                                rest.setLatitude(lt)
                                rest.setLongitude(ln)
                                rest.setKms(k)
                                
                                self.listaRestaurantes.append(rest)
                            }
                            
                            self.noItensFound.hidden = true
                            self.myTableView.hidden = false
                            self.myTableView.reloadData()
                            self.activityInSwitch(false)
                        }else{
                            self.noItensFound.hidden = false
                            self.myTableView.hidden = true
                            self.myTableView.reloadData()
//                            print("não trouxe rests")
                            self.activityInSwitch(false)
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
            self.lblQtdRestsEncontrados.hidden = false
            self.lblInfoRestsEncontrados.hidden = false
            self.lblQtdRestsEncontrados.text = "\(listaRestaurantes.count)"
            self.lblInfoRestsEncontrados.text = "restaurantes com delivery na sua localização"
        }else{
            self.lblQtdRestsEncontrados.hidden = true
            self.lblInfoRestsEncontrados.text = "Não foram encontrados restaurantes próximo a você, que pena :/"
        }
        return listaRestaurantes.count
    }
    
     func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("mycell", forIndexPath: indexPath) as! restCell
       
        let name = listaRestaurantes[indexPath.row].getNome()
        let cat = "Minhas categorias"
        let info = "Minhas informações"
        
        //carrega a imagem
        let url = NSURL(string: "\(listaRestaurantes[indexPath.row].getImagem())")!
        let task = NSURLSession.sharedSession().dataTaskWithURL(url) { data, response, error in
            
            if(error != nil){
                self.activityInSwitch(false)
                print("error = \(error!)")
                return
            }
            
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                if data != nil{
                    cell.img.image = UIImage(data: data!)
                }
            })
        }
        task.resume()
        
        //cell.img.image = img
        cell.restName.text = name
        cell.restCat.text = cat
        cell.restInfo.text = info
        
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
        var isFind = false
        for item in listaRestaurantes{
            if item.getNome().containsString(txt){
                isFind = true
                print("achou restaurante: \(item.getNome())")
                break
            }
        }
        
        if (!isFind){
            print("não achou nada")
        }
    }
    
    /* SEM USO
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
    }*/
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        restauranteSelecionado = self.listaRestaurantes[indexPath.row]
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
