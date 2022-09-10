//
//  ViewController.swift
//  vaccine
//
//  Created by MAC BOOK PRO 2013 EARLY on 2022/09/05.
//

import UIKit
import Alamofire
import Charts

class ViewController: UIViewController {

    @IBOutlet weak var vaccineLabel1: UILabel!
    @IBOutlet weak var vaccineLabel2: UILabel!
    @IBOutlet weak var vaccineLabel3: UILabel!
    @IBOutlet weak var vaccineLabel4: UILabel!
    @IBOutlet weak var pieChartView : PieChartView!
    @IBOutlet weak var dateLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        dateLabel.text = formatter.string(from: Date())
        self.alamofireVaccineInfo(completionHandler: { [weak self] result in
            guard let self = self else { return }
            switch result {
            case let .success(result):
                self.setValueRootViewLabels(vaccineInfos: result.korea)
                let vaccineInfosList = self.makeVaccineInfosList(cityVaccineInfos: result)
                self.setChartView(vaccineInfosList: vaccineInfosList)
            case let .failure(error):
                let alert = UIAlertController(title: "에러", message: "\(error)", preferredStyle: UIAlertController.Style.alert)
                let ok = UIAlertAction(title: "OK", style: .default, handler: nil)
                alert.addAction(ok)
                self.present(alert, animated: true, completion: nil)
            }
        })
    }
    
    //차트에 전국 데이터를 보여주기 위해 만든 리스트
    func makeVaccineInfosList(cityVaccineInfos: CityVaccineInfos) -> [VaccineInfos] {
        return [
            cityVaccineInfos.seoul,
            cityVaccineInfos.busan,
            cityVaccineInfos.daegu,
            cityVaccineInfos.incheon,
            cityVaccineInfos.gwangju,
            cityVaccineInfos.daejeon,
            cityVaccineInfos.ulsan,
            cityVaccineInfos.sejong,
            cityVaccineInfos.gyeonggi,
            cityVaccineInfos.gangwon,
            cityVaccineInfos.chungbuk,
            cityVaccineInfos.jeonbuk,
            cityVaccineInfos.chungnam,
            cityVaccineInfos.jeonnam,
            cityVaccineInfos.gyeongbuk,
            cityVaccineInfos.gyeongnam,
            cityVaccineInfos.jeju,
        ]
    }
    
    func getString(_ num : Int)->String {
        var ret = "\(num)"
        if ret.count <= 3 { return ret }
        var idx = ret.count - 3
        while idx > 0 {
            ret.insert(",", at: ret.index(ret.startIndex, offsetBy: idx))
            idx -= 3
        }
        return ret
    }
    
    //초기화면에 전국 신규 접종자 보여주기
    func setValueRootViewLabels(vaccineInfos: VaccineInfos) {
        vaccineLabel1.text = getString(vaccineInfos.vaccine_1.vaccine_1_new)
        vaccineLabel2.text = getString(vaccineInfos.vaccine_2.vaccine_2_new)
        vaccineLabel3.text = getString(vaccineInfos.vaccine_3.vaccine_3_new)
        vaccineLabel4.text = getString(vaccineInfos.vaccine_4.vaccine_4_new)
    }
    
    func setChartView(vaccineInfosList: [VaccineInfos]) {
        self.pieChartView.delegate = self
        let entries = vaccineInfosList.compactMap({ vaccineInfos -> PieChartDataEntry? in
            return PieChartDataEntry(
                value: Double(
                    vaccineInfos.vaccine_1.vaccine_1_new
                        + vaccineInfos.vaccine_2.vaccine_2_new
                        + vaccineInfos.vaccine_3.vaccine_3_new
                        + vaccineInfos.vaccine_4.vaccine_4_new
                ),
                label: vaccineInfos.countryNm,
                data: vaccineInfos
            )
        })
        let dataSet = PieChartDataSet(entries: entries, label: "백신 신규 접종 현황")
        dataSet.sliceSpace = 1
        dataSet.entryLabelColor = .black
        dataSet.xValuePosition = .outsideSlice
        dataSet.valueTextColor = .black
        dataSet.valueLinePart1OffsetPercentage = 0.8
        dataSet.valueLinePart1Length = 0.2
        dataSet.valueLinePart2Length = 0.3
        
        dataSet.colors = ChartColorTemplates.vordiplom()
          + ChartColorTemplates.joyful()
          + ChartColorTemplates.colorful()
          + ChartColorTemplates.liberty()
          + ChartColorTemplates.pastel()
          + ChartColorTemplates.material()
        self.pieChartView.data = PieChartData(dataSet: dataSet)
        self.pieChartView.spin(duration: 0.3, fromAngle: pieChartView.rotationAngle, toAngle: pieChartView.rotationAngle + 80)
    }
    
    //Alamofire를 통해 굿바이 코로나 api 요청
    func alamofireVaccineInfo(completionHandler: @escaping (Result<CityVaccineInfos, Error>) -> Void) {
        let url = "https://api.corona-19.kr/korea/vaccine/"
        let param = [ "serviceKey" : Bundle.main.apiKey ]
        AF.request(url, method: .get, parameters: param).responseData(completionHandler: { response in
            switch response.result {
                case let .success(data):
                    do {
                        let decoder = JSONDecoder()
                        let result = try decoder.decode(CityVaccineInfos.self, from: data)
                        completionHandler(.success(result))
                    }
                    catch {
                        completionHandler(.failure(error))
                    }
                case let .failure(error):
                    completionHandler(.failure(error))
            }
        })
    }
}

extension ViewController : ChartViewDelegate {
    func chartValueSelected(_ chartView: ChartViewBase, entry: ChartDataEntry, highlight: Highlight) {
        guard let localVaccineInfosTableViewController =
                self.storyboard?.instantiateViewController(identifier: "LocalVaccineInfosTableViewController") as? LocalVaccineInfosTableViewController else { return }
        guard let vaccineInfos = entry.data as? VaccineInfos else {
            return
        }
        localVaccineInfosTableViewController.vaccineInfos = vaccineInfos
        self.navigationController?.pushViewController(localVaccineInfosTableViewController, animated: true)
    }
}
