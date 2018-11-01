import UIKit

import Alamofire
import SDWebImage

class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    //  Tạo mảng chứa dữ liệu
    var ArrHero = [Hero]()
    
    func getDataForArrFromJson()
    {
        //  Dùng thư viện Alamofire
        Alamofire.request("https://api.opendota.com/api/heroStats").responseJSON
        { (response) in
                //  Lấy Json Data
                guard let JsonData: [[String : Any]] = response.result.value as? [[String : Any]] else
                {
                    print("Nil"); return
                }
                //  Thêm dữ liệu vào mảng
                for item in JsonData
                {
                    guard let hero = Hero(JsonData: item) else { return }
                    self.ArrHero.append(hero)
                }
            DispatchQueue.main.async {
                self.collecView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getDataForArrFromJson()
        
        collecView.dataSource = self
        collecView.delegate = self
    }

    @IBOutlet weak var collecView: UICollectionView!
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return ArrHero.count
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let CollecCell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollecCell", for: indexPath) as? CollecCellCustom else { return UICollectionViewCell() }
        
        let hero = ArrHero[indexPath.row]
        
        CollecCell.imgHinh.sd_setImage(with: hero.url, completed: nil)
        
        return CollecCell
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (UIScreen.main.bounds.size.width - 3 * 10) / 5
        let height = width
        return CGSize(width: width, height: height)
    }
}


