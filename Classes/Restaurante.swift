//
//  Restaurante.swift
//  reidocardapio
//
//  Created by Bruno Rocha on 13/10/16.
//  Copyright © 2016 Bruno Rocha. All rights reserved.
//

import Foundation

public class Restaurante{
    
    private var id : Int!
    private var nome: String!
    private var imagem: String!
    private var cidade: String!
    private var bairro: String!
    private var endereco: String!
    
    private var categoria: String!
    private var tempoMedio: String!
    private var precoMin: String!
    private var avaliacoes: String!
    
    //configs
    private var latitude : String!
    private var longitude: String!
    private var kms : String!
    
    
    func getId() -> Int{
        return self.id
    }
    
    func setId(id: Int){
        self.id = id
    }
    
    func getNome() -> String{
        return self.nome
    }
    
    func setNome(nome :String){
        self.nome = nome
    }
    
    func getImagem() -> String{
        return self.imagem
    }
    
    func setImagem(img :String){
        self.imagem = img
    }
    
    func getCidade() -> String{
        return self.cidade
    }
    
    func setCidade(cidade: String){
        self.cidade = cidade
    }
    
    func getBairro() -> String{
        return self.bairro
    }
    
    func setBairro(bairro: String){
        self.bairro = bairro
    }
    
    func getEndereco() -> String{
        return self.endereco
    }
    
    func setEndereco(endereco :String){
        self.endereco = endereco
    }
    
    func getCategoria() -> String{
        return self.categoria
    }
    
    func setCategoria(cat :String){
        self.categoria = cat
    }
    
    func getTempoMedio() -> String{
        return self.tempoMedio
    }
    
    func setTempoMedio(tempoMedio: String){
        self.tempoMedio = tempoMedio
    }
    
    func getPrecoMin() -> String{
        return self.precoMin
    }
    
    func setPrecoMin(precoMin: String){
        self.precoMin = precoMin
    }
    
    func getAvaliacoes() -> String{
        return self.avaliacoes
    }
    
    func setAvaliacoes(avaliacoes: String){
        self.avaliacoes = avaliacoes
    }
    
    func getLatitude() -> String{
        return self.latitude
    }
    
    func setLatitude(lat: String){
        self.latitude = lat
    }
    
    func getLongitude() -> String{
        return self.longitude
    }
    
    func setLongitude(lon: String){
        self.longitude = lon
    }
    
    func getKms() -> String{
        return self.kms
    }
    
    func setKms(kms: String){
        self.kms = kms
    }
}