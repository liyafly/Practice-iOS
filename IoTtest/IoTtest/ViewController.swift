//
//  ViewController.swift
//  IoTtest
//
//  Created by 李亚非 on 2018/3/20.
//  Copyright © 2018年 李亚非. All rights reserved.
//

import Cocoa
import SQLite
import Charts


class ViewController: NSViewController{
    var temptDataArray = [Int64]()
  
    @IBOutlet weak var max: NSTextField!
    
    @IBOutlet weak var min: NSTextField!
    
    @IBOutlet weak var tableView: NSTableView!
    
    @IBOutlet weak var endDate: NSDatePicker!
    
    @IBOutlet weak var starDate: NSDatePicker!
    
    @IBOutlet weak var lineChartView: LineChartView!
    
   
    override func viewDidLoad() {
        super.viewDidLoad()
//        IOtest()
//        DataBaseIO()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.reloadData()
        

        tableView.tableColumns[0].identifier = NSUserInterfaceItemIdentifier(rawValue: "tempts")
        var temptsSortDescriptor = NSSortDescriptor(key: "tempts", ascending: true)
        tableView.tableColumns[0].sortDescriptorPrototype = temptsSortDescriptor
        
        
        
        // Do any additional setup after loading the view.
    }
    override open func viewWillAppear()
    {
        self.lineChartView.animate(xAxisDuration: 0.0, yAxisDuration: 2.0)
    }

    @IBAction func tijiao(_ sender: NSButton){
 
        temptDataArray = []
        let path = "/Users/liyafei/db.sqlite3"
        let db = try! Connection(path, readonly: true)

        let date1 = starDate.dateValue

        let date2 = endDate.dateValue

        for tempts in try! db.prepare(tempt.filter(date1...date2 ~= time)){
     
            temptDataArray.append(tempts[temperature])
        }

        tableView.reloadData()

       
    }
    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }

    @IBAction func sort(_ sender: NSButton) {

        temptDataArray = temptDataArray.sorted()
        
        tableView.reloadData()
    }
    
    @IBAction func DES(_ sender: NSButton) {
        temptDataArray = temptDataArray.sorted(by: >)
        tableView.reloadData()
    }
    
    @IBAction func chartsDataIoT(_ sender: NSButton) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyyMMdd"
        
        var lineChartData = [ChartDataEntry]()
        var set1 = LineChartDataSet()
        var dataSets = [LineChartDataSet]()
       
        let path = "/Users/liyafei/db.sqlite3"
        let db = try! Connection(path, readonly: true)
        
        let date1 = starDate.dateValue
    
        let date2 = endDate.dateValue
       
//tempt.select(tempt[*], time.distinct.count).group(time).filter(date1...date2 ~= time)
        for tempts in try! db.prepare(tempt.select(tempt[*], temperature.max).group(time).filter(date1...date2 ~= time)){
            let timeDate1 = dateFormatter.string(from: tempts[time])
            let timedate2 = StrToInt(str: timeDate1)
            print(timedate2)
            lineChartData.append(ChartDataEntry(x: Double(timedate2), y: Double(tempts[temperature])))

        }

        set1 = LineChartDataSet(values: lineChartData, label: "DataSet 1")

        dataSets.append(set1)
        let data = LineChartData(dataSets: dataSets)

        self.lineChartView.xAxis.labelPosition = .bottom
        self.lineChartView.data = data

    }
    
    
}
extension ViewController:  NSTableViewDataSource {
    func numberOfRows(in tableView: NSTableView) -> Int {
        return temptDataArray.count
    }
    func tableView(_ tableView: NSTableView, sortDescriptorsDidChange oldDescriptors: [NSSortDescriptor]) {

         temptDataArray = temptDataArray.sorted()
        tableView.reloadData()
    }
    
}
    
extension ViewController:  NSTableViewDelegate{

    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        let cell = tableView.makeView(withIdentifier: tableView.tableColumns[0].identifier, owner: self) as? NSTableCellView

        
        if temptDataArray[row] <= StrToInt(str: max.stringValue) && temptDataArray[row] >= StrToInt(str: min.stringValue) {
            cell?.textField?.stringValue = String(describing: temptDataArray[row])
            cell?.textField?.textColor = NSColor.blue
        }else {
            cell?.textField?.stringValue = String(describing: temptDataArray[row])
            cell?.textField?.textColor = NSColor.black
        }
        return cell
        
    }
}
