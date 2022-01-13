//
//  ProfileViewController.swift
//  ITCCKuldipTest
//
//  Created by Kuldip Mac on 12/01/22.
//

import UIKit
import MaterialComponents.MaterialTextControls_OutlinedTextAreas
import MaterialComponents.MaterialTextControls_OutlinedTextFields
import DropDown

class ProfileViewController: UIViewController {
 
    //MARK: Golbal Varibale Declare
    @IBOutlet weak var txtFirstName: MDCOutlinedTextField!
    @IBOutlet weak var txtLastName: MDCOutlinedTextField!
    @IBOutlet weak var txtEmail: MDCOutlinedTextField!
    @IBOutlet weak var txtConfirmEmail: MDCOutlinedTextField!
    @IBOutlet weak var txtGender: MDCOutlinedTextField!
    @IBOutlet weak var txtDOB: MDCOutlinedTextField!
    @IBOutlet weak var txtPassword: MDCOutlinedTextField!
    @IBOutlet weak var txtConfirmPassword: MDCOutlinedTextField!
    @IBOutlet weak var txtSelectUserRole: MDCOutlinedTextField!
    var aryGender: [String] = ["Male","Female","Other"]
    var arySelectUserType: [String] = ["Person with a Disability","Community Member","Disability Adovcate","Carer","Support worker","Support Coordinator","Bussiness Representive"]
    let dropDownGender = DropDown()
    let dropDownSelectUserType = DropDown()
    @IBOutlet weak var btnTerm: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
       
        textViewSetupMethod()
        
    }
    
    //MARK: TextFiled Setup
    func textViewSetupMethod()  {
        txtFirstName.label.text = "First Name"
        txtFirstName.placeholder = ""
        txtLastName.label.text = "Last Name"
        txtLastName.placeholder = ""
        txtEmail.label.text = "Email "
        txtEmail.placeholder = ""
        txtConfirmEmail.label.text = "Confirm Email"
        txtConfirmEmail.placeholder = ""
        txtGender.label.text = "Gender"
        txtGender.placeholder = ""
        txtDOB.label.text = "Date of Birth"
        txtDOB.placeholder = ""
        txtPassword.label.text = "Password"
        txtPassword.placeholder = ""
        txtConfirmPassword.label.text = "Confirm Password"
        txtConfirmPassword.placeholder = ""
        txtSelectUserRole.label.text = "Selected User Type/ Role"
        txtSelectUserRole.placeholder = ""
        btnTerm.setImage(UIImage.init(named: "Squre_UnFill"), for: .normal)
       btnTerm.setImage(UIImage.init(named: "Squre_Fill"), for: .selected)
        btnTerm.addTarget(self, action: #selector(self.toggleCheckboxSelection), for: .touchUpInside)
         
    }
    //MARK: Button Action
    @objc func toggleCheckboxSelection() {
        btnTerm.isSelected = !btnTerm.isSelected
    }
    @IBAction func actionGender(_ sender: UIButton) {
        dropDownGender.dataSource = aryGender
        dropDownGender.anchorView = txtGender
        dropDownGender.backgroundColor = .white
        dropDownGender.show()
        dropDownGender.selectionAction = { [weak self] (index: Int, item: String) in
        guard let _ = self else { return }
        
        self?.txtGender.text = "\(item)"
      }
    }
    @IBAction func actionSelectuser(_ sender: UIButton) {
        dropDownSelectUserType.dataSource = arySelectUserType
        dropDownSelectUserType.anchorView = txtSelectUserRole
        dropDownSelectUserType.backgroundColor = .white
        dropDownSelectUserType.show()
        dropDownSelectUserType.selectionAction = { [weak self] (index: Int, item: String) in
        guard let _ = self else { return }
        
        self?.txtSelectUserRole.text = "\(item)"
      }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
