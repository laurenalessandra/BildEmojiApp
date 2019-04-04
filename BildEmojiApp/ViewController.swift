//
//  ViewController.swift
//  BildEmojiApp
//
//  Created by Lauren Simon on 4/3/19.
//  Copyright © 2019 Lauren Simon. All rights reserved.
//

import UIKit
import Photos
import CoreLocation

class ViewController: UIViewController, UINavigationControllerDelegate {

    @IBOutlet weak var tableHeight: NSLayoutConstraint!
    var imagePicker = UIImagePickerController()
    var images = [Photo]()
    var locationManager = CLLocationManager()
    var currentLocation = CLLocation()
    @IBOutlet weak var tableView: UITableView!
    var state = "photos"
    var emojis = ["😊","😬","😍","😝","😎","😫","😢"]
    @IBOutlet weak var emojiButton: UIButton!
    @IBOutlet weak var photoButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        switch state {
        case "photos": tableHeight.constant = CGFloat(images.count*100)
        case "emojis": tableHeight.constant = CGFloat(emojis.count*50)
        default: tableHeight.constant = 0
        }
    }
    
    @IBAction func addImagePressed(_ sender: UIBarButtonItem) {
        switch state {
        case "photos":
            if UIImagePickerController.isSourceTypeAvailable(.camera) {
                locationManager.startUpdatingLocation()
                imagePicker.sourceType = .camera
                imagePicker.delegate = self
                present(imagePicker, animated: true, completion: nil)
            } else {
                BasicAlert().showAlert(title: "No Camera Available", message: "There is no camera available on this device.", action: "Okay", view: self)
            }
        case "emojis":
            TextFieldAlert().showAlert(title: "Add Emoji", message: "Add an emoji to your list", action: "Okay", view: self) { result in
                if result != "" {
                    self.emojis.append(result)
                    self.tableHeight.constant = CGFloat(self.emojis.count*50)
                    self.tableView.reloadData()
                }
            }
        default:
            self.tableHeight.constant = 0
            self.tableView.reloadData()
        }
    }
    
    @IBAction func fotosPressed(_ sender: UIButton) {
        state = "photos"
        photoButton.setTitleColor(UIColor.blue, for: .normal)
        emojiButton.setTitleColor(UIColor.lightGray, for: .normal)
        tableHeight.constant = CGFloat(images.count*100)
        tableView.reloadData()
    }
    
    @IBAction func emojiPressed(_ sender: UIButton) {
        state = "emojis"
        emojiButton.setTitleColor(UIColor.blue, for: .normal)
        photoButton.setTitleColor(UIColor.lightGray, for: .normal)
        tableHeight.constant = CGFloat(emojis.count*50)
        tableView.reloadData()
    }
}
extension ViewController: UIImagePickerControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
        let meta = info[UIImagePickerController.InfoKey.mediaMetadata] as? NSDictionary
        let data = meta?.object(forKey: "{TIFF}") as? NSDictionary

        GeoDecoder().decode(location: currentLocation) { result in
            self.images.append(Photo(photo: image, location: result, date: data?.object(forKey: "DateTime") as! String))
            self.tableHeight.constant = CGFloat(self.images.count*100)
            self.tableView.reloadData()
        }
        locationManager.stopUpdatingLocation()
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        locationManager.stopUpdatingLocation()
        dismiss(animated: true, completion: nil)
    }
}

extension ViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status{
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .authorizedAlways, .authorizedWhenInUse:
            locationManager.requestLocation()
        case .restricted, .denied:
            BasicAlert().showAlert(title: "Location services denied", message: "It may be that parental controls are restricting location use in this app", action: "Okay", view: self)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let current = locations.last {
            self.currentLocation = current
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch state {
        case "photos":  return images.count
        case "emojis":  return emojis.count
        default:        return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        switch state {
        case "photos":
            cell.textLabel?.text = "\(images[indexPath.row].location),  \(DateTimeFormatter().formatDate(date: images[indexPath.row].date))"
            cell.imageView?.image = images[indexPath.row].photo
        case "emojis":
            cell.textLabel?.text = emojis[indexPath.row]
            cell.imageView?.image = nil
        default:
            cell.textLabel?.text = ""
            cell.imageView?.image = nil
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch state {
        case "photos":  return 100
        case "emojis":  return 50
        default:  return 0
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = DetailViewController()
        switch state {
        case "photos":  vc.content = images[indexPath.row].date
        case "emojis":  vc.content = emojis[indexPath.row]
        default: vc.content = ""
        }
        self.navigationController?.pushViewController(vc, animated: true)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension UITextField {
    override open var textInputMode: UITextInputMode? {
        for keyboard in UITextInputMode.activeInputModes {
            if keyboard.primaryLanguage == "emoji" {
                return keyboard
            }
        }
        return nil
    }
}



