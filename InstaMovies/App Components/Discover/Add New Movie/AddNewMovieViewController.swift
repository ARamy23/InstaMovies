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
    }
    
    @IBAction func chooseAPosterImage(_ sender: Any) {
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        
        let photoGalleryAction: (String, UIAlertAction.Style, ((UIAlertAction) -> Void)?) = (title: "Gallery", style: .default, handler: { (_) in
            self.imagePicker.sourceType = .photoLibrary
            self.present(self.imagePicker, animated: true, completion: nil)
        })
        
        let cameraAction: (String, UIAlertAction.Style, ((UIAlertAction) -> Void)?) = (title: "Camera", style: .default, handler: { (_) in
            self.imagePicker.sourceType = .camera
            self.present(self.imagePicker, animated: true, completion: nil)
        })
        
        let cancelAction: (String, UIAlertAction.Style, ((UIAlertAction) -> Void)?) = (title: "Cancel", style: .cancel, handler: nil)
        router.alert(title: "Choose Poster Source", message: "", actions: [photoGalleryAction,
                                                                           cameraAction,
                                                                           cancelAction])
    }
    
    @IBAction func saveMovie(_ sender: Any) {
        viewModel.movieTitle.value = movieTitleTextField.text
        viewModel.movieOverview.value = overviewTextView.text
        viewModel.date.value = "\(datePicker.date)"
        viewModel.moviePoster.value = posterImageView.image
        viewModel.save()
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func dismiss(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
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
