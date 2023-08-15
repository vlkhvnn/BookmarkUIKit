import UIKit
import SnapKit

class OnboardingScreen : UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        
        let imageView = UIImageView()
        let image = UIImage(named: "image8")
        imageView.image = image
        imageView.frame = CGRect(x: 0, y: 0, width: 400, height: 600)
        
        
        let button = UIButton()
        button.setTitle("", for: .normal)
        button.backgroundColor = .white
        button.layer.cornerRadius = 16
        button.addTarget(self, action: #selector(nextButtonTapped), for: .touchUpInside)
        
        
        let buttonLabel = UILabel()
        buttonLabel.text = "Let's start collecting"
        buttonLabel.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        buttonLabel.textAlignment = .center
        buttonLabel.font = UIFont(name: "SFProText-Medium", size: 16)
        button.addSubview(buttonLabel)
        
        
        let saveText = UILabel()
        saveText.text = "Save all interesting links in one app"
        saveText.textColor = .white
        saveText.textAlignment = .left
        saveText.font = UIFont.systemFont(ofSize: 36, weight: .semibold)
        saveText.numberOfLines = 0
        
        
        let labelStackView = UIStackView(arrangedSubviews: [saveText, button])
        labelStackView.axis = .vertical
        labelStackView.spacing = 24
        
        [imageView, labelStackView].forEach {
            view.addSubview($0)
        }
        
        labelStackView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
            make.bottom.equalToSuperview().inset(50)
        }
        
        button.snp.makeConstraints { make in
            make.height.equalTo(58)
        }
        
        buttonLabel.snp.makeConstraints { make in
            make.edges.equalToSuperview() // Center the label inside the button
        }
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
    
    @objc func nextButtonTapped() {
        print("Button is tapped")
        let nextViewController = UINavigationController(rootViewController: MainScreen())
        nextViewController.modalPresentationStyle = .fullScreen
        navigationController?.present(nextViewController, animated: true)
        UserDefaults.standard.set(true, forKey: "onboardingCompleted")
    }
}
