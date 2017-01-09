//
//  ProfileEditPresenter.swift
//  Photostream
//
//  Created by Mounir Ybanez on 07/01/2017.
//  Copyright © 2017 Mounir Ybanez. All rights reserved.
//

import UIKit

protocol ProfileEditPresenterInterface: BaseModulePresenter, BaseModuleInteractable {
    
    var updateData: ProfileEditData! { set get }
    var displayItems: [ProfileEditDisplayItem] { set get }
}

class ProfileEditPresenter: ProfileEditPresenterInterface {

    typealias ModuleView = ProfileEditScene
    typealias ModuleInteractor = ProfileEditInteractorInput
    typealias ModuleWireframe = ProfileEditWireframeInterface
    
    weak var view: ModuleView!
    var interactor: ModuleInteractor!
    var wireframe: ModuleWireframe!
    
    var displayItems = [ProfileEditDisplayItem]()
    var updateData: ProfileEditData! = ProfileEditDataItem() {
        didSet {
            displayItems.removeAll()
            
            var item = ProfileEditDisplayItem()
            item.infoLabelText = "Username"
            item.infoEditText = updateData.username
            displayItems.append(item)
            
            item.clear()
            item.infoLabelText = "First Name"
            item.infoEditText = updateData.firstName
            displayItems.append(item)
            
            item.clear()
            item.infoLabelText = "Last Name"
            item.infoEditText = updateData.lastName
            displayItems.append(item)
            
            item.clear()
            item.infoLabelText = "Bio"
            item.infoDetailText = updateData.bio
            displayItems.append(item)
        }
    }
}

extension ProfileEditPresenter: ProfileEditModuleInterface {
    
    var displayItemCount: Int {
        return displayItems.count
    }
    
    func exit() {
        var property = WireframeExitProperty()
        property.controller = view.controller
        wireframe.exit(with: property)
    }
    
    func viewDidLoad() {
        view.showProfile(with: updateData)
    }
    
    func uploadAvatar(with image: UIImage) {
        let imageData = UIImageJPEGRepresentation(image, 1.0)
        var uploadData = FileServiceImageUploadData()
        uploadData.data = imageData
        interactor.uploadAvatar(data: uploadData)
    }
    
    func updateProfile() {
        var editData = UserServiceProfileEditData()
        editData.avatarUrl = updateData.avatarUrl
        editData.bio = updateData.bio
        editData.firstName = updateData.firstName
        editData.lastName = updateData.lastName
        editData.username = updateData.username
        interactor.updateProfile(data: editData)
    }
    
    func set(bio: String) {
        updateData.bio = bio
    }
    
    func set(lastName: String) {
        updateData.lastName = lastName
    }
    
    func set(username: String) {
        updateData.username = username
    }
    
    func set(firstName: String) {
        updateData.firstName = firstName
    }
    
    func displayItem(at index: Int) -> ProfileEditDisplayItem? {
        guard displayItems.isValid(index) else {
            return nil
        }
        
        return displayItems[index]
    }
}

extension ProfileEditPresenter: ProfileEditInteractorOutput {
    
    func didUpdate(data: ProfileEditData) {
        updateData = data
        view.didUpdate(with: nil)
    }
    
    func didUpdate(error: UserServiceError) {
        view.didUpdate(with: error.message)
    }
    
    func didUplaodAvatar(url: String) {
        updateData.avatarUrl = url
        view.didUpload(with: nil)
    }
    
    func didUploadAvatar(progress: Progress) {
        view.didUploadWith(progress: progress)
    }
    
    func didUplaodAvatar(error: FileServiceError) {
        view.didUpload(with: error.message)
    }
}