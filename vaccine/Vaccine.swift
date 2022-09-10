//
//  Vaccine.swift
//  vaccine
//
//  Created by MAC BOOK PRO 2013 EARLY on 2022/09/06.
//

import Foundation

struct CityVaccineInfos : Codable {
    let korea: VaccineInfos
    let seoul: VaccineInfos
    let busan: VaccineInfos
    let daegu: VaccineInfos
    let incheon: VaccineInfos
    let gwangju: VaccineInfos
    let daejeon: VaccineInfos
    let ulsan: VaccineInfos
    let sejong: VaccineInfos
    let gyeonggi: VaccineInfos
    let gangwon: VaccineInfos
    let chungbuk: VaccineInfos
    let chungnam: VaccineInfos
    let jeonbuk: VaccineInfos
    let jeonnam: VaccineInfos
    let gyeongbuk: VaccineInfos
    let gyeongnam: VaccineInfos
    let jeju: VaccineInfos
}

struct VaccineInfos : Codable {
    let countryNm : String
    let vaccine_1 : Vaccine1
    let vaccine_2 : Vaccine2
    let vaccine_3 : Vaccine3
    let vaccine_4 : Vaccine4
}

struct Vaccine1 : Codable{
    let vaccine_1 : Int
    let vaccine_1_new : Int
    let vaccine_1_old : Int
}

struct Vaccine2 : Codable {
    let vaccine_2 : Int
    let vaccine_2_new : Int
    let vaccine_2_old : Int
}

struct Vaccine3 : Codable {
    let vaccine_3 : Int
    let vaccine_3_new : Int
    let vaccine_3_old : Int
}

struct Vaccine4 : Codable {
    let vaccine_4 : Int
    let vaccine_4_new : Int
    let vaccine_4_old : Int
}
