//
//  AddNewMovieViewController.swift
//  InstaMovies
//
//  Created by Ahmed Ramy on 12/18/18.
//  Copyright © 2018 Ahmed Ramy. All rights reserved.
//

import UIKit

class AddNewMovieViewController: BaseViewController {
    
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var movieTitleTextField: UITextField!
    @IBOutlet weak var overviewTextView: RoundedTextView!
    @IBOutlet weak var datePicker: UIDatePicker!
    
    var viewModel: AddNewMovieViewModel!
    
    let imagePicker = UIImagePickerController()
    
    override func initialize() {
        super.initialize()
        overviewTextView.delegate = self
        viewModel.router = self.router
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        self.view.endEditing(true)
    }
    
    @IBAction func chooseAPosterImage(_ sender: Any) {
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        
        let photoGalleryAction: (String, UIAlertAction.Style, ((UIAlertAction) -> Void)?) = (title: "Gallery", style: .default, handler: { (_) in
            self.imagePicker.sourceType = .photoLibrary
            self.present(self.imagePicker, animated: true, completion: nil)
        })
        
        let cancelAction: (String, UIAlertAction.Style, ((UIAlertAction) -> Void)?) = (title: "Cancel", style: .cancel, handler: nil)
        
        router.alert(title: "Choose Poster Source", message: "", actions: [photoGalleryAction, cancelAction])
    }
    
    @IBAction func saveMovie(_ sender: Any) {
        viewModel.movieTitle.value = movieTitleTextField.text
        viewModel.movieOverview.value = overviewTextView.text
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let dateString = dateFormatter.string(from: datePicker.date)
        viewModel.date.value = dateString
        viewModel.moviePoster.value = posterImageView.image
        viewModel.saveMovie()
        
    }
    
    @IBAction func dismiss(_ sender: Any) {
        router.dismiss()
    }
}

extension AddNewMovieViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let pickedImage = info[.originalImage] as? UIImage {
            self.posterImageView.contentMode = .scaleAspectFit
            self.posterImageView.image = pickedImage
        }
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion:nil)
    }
}

extension AddNewMovieViewController: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        guard let textView = textView as? RoundedTextView else { return }
        if textView.text.count > 0 {
            textView.placeholderColor = .clear
        } else {
            textView.placeholderColor = .lightGray
        }
        textView.setNeedsDisplay()
        textView.setNeedsLayout()
    }
}
