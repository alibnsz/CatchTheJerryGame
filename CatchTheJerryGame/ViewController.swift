//  ViewController.swift
//  CatchTheJerryGame
//  Created by Mehmet Ali Bunsuz on 29.06.2024.

import UIKit

// Ana ViewController sınıfı, UIViewController'dan türetilmiş
class ViewController: UIViewController {
    
    // Oyun skorunu tutan değişken
    var score = 0
    // Sayaç için kullanılan Timer
    var timer = Timer()
    // Geri sayım için kullanılan sayaç
    var counter = 0
    // Görselleri tutan dizi
    var jerryArray = [UIImageView]()
    // Jerry'yi gizlemek için kullanılan Timer
    var hideTimer = Timer()
    // En yüksek skoru tutan değişken
    var highScore = 0
    
    // Zamanı göstermek için UILabel
    @IBOutlet weak var timeLabel: UILabel!
    // Skoru göstermek için UILabel
    @IBOutlet weak var scoreLabel: UILabel!
    // En yüksek skoru göstermek için UILabel
    @IBOutlet weak var highScoreLabel: UILabel!
    // Jerry resimlerini tanımlama
    @IBOutlet weak var jerry1: UIImageView!
    @IBOutlet weak var jerry2: UIImageView!
    @IBOutlet weak var jerry3: UIImageView!
    @IBOutlet weak var jerry4: UIImageView!
    @IBOutlet weak var jerry5: UIImageView!
    @IBOutlet weak var jerry6: UIImageView!
    @IBOutlet weak var jerry7: UIImageView!
    @IBOutlet weak var jerry8: UIImageView!
    @IBOutlet weak var jerry9: UIImageView!
    
    // View yüklendiğinde çalışacak olan fonksiyon
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Skor etiketini güncelleme
        scoreLabel.text = "Score: \(score)"
        
        // UserDefaults'tan kaydedilen en yüksek skoru çekme
        let storedHighScore = UserDefaults.standard.object(forKey: "highscore")
        
        // Eğer kaydedilen skor yoksa en yüksek skoru 0 olarak ayarla
        if storedHighScore == nil {
            highScore = 0
            highScoreLabel.text = "Highscore: \(highScore)"
        }
        // Eğer kaydedilen skor varsa, onu en yüksek skor olarak ayarla
        if let newScore = storedHighScore as? Int {
            highScore = newScore
            highScoreLabel.text = "Highscore: \(highScore)"
        }
        
        // Jerry resimlerinin kullanıcı etkileşimine izin verilmesi
        jerry1.isUserInteractionEnabled = true
        jerry2.isUserInteractionEnabled = true
        jerry3.isUserInteractionEnabled = true
        jerry4.isUserInteractionEnabled = true
        jerry5.isUserInteractionEnabled = true
        jerry6.isUserInteractionEnabled = true
        jerry7.isUserInteractionEnabled = true
        jerry8.isUserInteractionEnabled = true
        jerry9.isUserInteractionEnabled = true
        
        // Her bir Jerry resmine tıklama tanıyıcı ekleme
        let gestureRecognizer1 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let gestureRecognizer2 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let gestureRecognizer3 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let gestureRecognizer4 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let gestureRecognizer5 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let gestureRecognizer6 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let gestureRecognizer7 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let gestureRecognizer8 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let gestureRecognizer9 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        
        // Tıklama tanıyıcılarını resimlere ekleme
        jerry1.addGestureRecognizer(gestureRecognizer1)
        jerry2.addGestureRecognizer(gestureRecognizer2)
        jerry3.addGestureRecognizer(gestureRecognizer3)
        jerry4.addGestureRecognizer(gestureRecognizer4)
        jerry5.addGestureRecognizer(gestureRecognizer5)
        jerry6.addGestureRecognizer(gestureRecognizer6)
        jerry7.addGestureRecognizer(gestureRecognizer7)
        jerry8.addGestureRecognizer(gestureRecognizer8)
        jerry9.addGestureRecognizer(gestureRecognizer9)
        
        // Jerry resimlerini diziye ekleme
        jerryArray = [jerry1, jerry2, jerry3, jerry4, jerry5, jerry6, jerry7, jerry8, jerry9]
        
        // Başlangıç sayacı değeri
        counter = 10
        // Sayaç etiketini güncelleme
        timeLabel.text = "\(counter)"
        
        // Timer'ı başlatma (her saniye geri sayım)
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(countDown), userInfo: nil, repeats: true)
        // Jerry'yi gizlemek için Timer (her 0.5 saniyede bir)
        hideTimer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(hideJerry), userInfo: nil, repeats: true)
        
        // İlk olarak Jerry'yi gizle
        hideJerry()
    }
    
    // Jerry'yi gizleme fonksiyonu
    @objc func hideJerry() {
        // Tüm Jerry resimlerini gizle
        for jerry in jerryArray {
            jerry.isHidden = true
        }
        
        // Skor en yüksek skordan büyükse, en yüksek skoru güncelle
        if self.score > self.highScore {
            self.highScore = self.score
            highScoreLabel.text = "Highscore: \(self.highScore)"
            UserDefaults.standard.set(self.highScore, forKey: "highscore")
        }
        
        // Rastgele bir Jerry resmi seç ve göster
        let random = Int(arc4random_uniform(UInt32(jerryArray.count - 1)))
        jerryArray[random].isHidden = false
    }
    
    // Skoru artırma fonksiyonu
    @objc func increaseScore() {
        // Skoru bir artır
        score += 1
        // Skor etiketini güncelle
        scoreLabel.text = "Score: \(score)"
    }
    
    // Geri sayım fonksiyonu
    @objc func countDown() {
        // Sayacı bir azalt
        counter -= 1
        // Sayaç etiketini güncelle
        timeLabel.text = "\(counter)"
        
        // Sayaç sıfıra ulaştığında
        if counter == 0 {
            // Timer'ları durdur
            timer.invalidate()
            hideTimer.invalidate()
            
            // Tüm Jerry resimlerini gizle
            for jerry in jerryArray {
                jerry.isHidden = true
            }
            
            // Zaman doldu uyarısı oluştur
            let alert = UIAlertController(title: "Time's up", message: "Do you want to play again", preferredStyle: UIAlertController.Style.alert)
            // Tamam butonu ekle
            let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.cancel, handler: nil)
            // Tekrar oyna butonu ekle
            let replayButton = UIAlertAction(title: "Replay", style: UIAlertAction.Style.default) { (UIAlertAction) in
                // Skoru sıfırla
                self.score = 0
                self.scoreLabel.text = "Score: \(self.score)"
                // Sayacı başlangıç değerine döndür
                self.counter = 10
                self.timeLabel.text = String(self.counter)
                
                // Timer'ları yeniden başlat
                self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.countDown), userInfo: nil, repeats: true)
                self.hideTimer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(self.hideJerry), userInfo: nil, repeats: true)
            }

            // Uyarıya butonları ekle
            alert.addAction(okButton)
            alert.addAction(replayButton)
            // Uyarıyı göster
            self.present(alert, animated: true, completion: nil)
        }
    }
}
