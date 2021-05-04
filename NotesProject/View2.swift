import UIKit

enum Attributes: String {
    case title
    case image
    case subtitle
    case button
    case alert
}

class DLWidgetView: UIView {
    private var stateN = 0
    private var data: LayoutModel? {
        didSet {
            if let data = data {
                setFrameData(stateInfo: data.states[stateN], data: data.viewModel[stateN])
            }
        }
    }
    
    private lazy var titleLabel: UILabel = {
        let titleLabel = UILabel(frame: CGRect(x: viewWidth/3,
                                          y: 0.0,
                                          width: viewWidth/3,
                                          height: viewHeight/3))
        titleLabel.numberOfLines = 1
        titleLabel.textColor = .red
        titleLabel.font = .boldSystemFont(ofSize: 20.0)
        titleLabel.text = "i dont exist"
        return titleLabel
    }()

    private lazy var subtitleLabel: UILabel = {
        let label = UILabel(frame: CGRect(x: viewWidth/3,
                                          y: viewWidth/3,
                                          width: viewWidth/3,
                                          height: viewHeight/3))
        label.numberOfLines = 2
        label.font = .boldSystemFont(ofSize: 20.0)
        return label
    }()
    
    private lazy var alertText: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.font = .boldSystemFont(ofSize: 20.0)
        label.textColor = .red
        return label
    }()
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private lazy var button: UIButton = {
        let button = UIButton()
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpView()
//        backgroundColor = .gray
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}

private extension DLWidgetView {
    func setUpView() {
        addSubview(imageView)
        addSubview(titleLabel)
        addSubview(subtitleLabel)
    }
    
    var viewWidth: CGFloat {
        bounds.width
    }
    
    var viewHeight: CGFloat {
        bounds.height
    }
    
    func setFrameData(stateInfo: [String],
                      data: LayoutModel.ViewModel) {
        
            for item in stateInfo {
                switch item {
                case Attributes.title.rawValue:
                    
                    
                    DispatchQueue.main.async {
//                        let height = data.title.height(withConstrainedWidth: self.viewWidth/3,
//                                                       font: .boldSystemFont(ofSize: 20.0))
                        self.backgroundColor = .gray
                        
//                        self.titleLabel.frame.size.height = height
                        self.titleLabel.text = "data.title"
                        self.titleLabel.setNeedsLayout()
                        self.titleLabel.layoutIfNeeded()
                        
                    }
                case Attributes.subtitle.rawValue:
                    break
                case Attributes.image.rawValue:
                    break
                case Attributes.alert.rawValue:
                    break
                case Attributes.button.rawValue:
                    break
                default:
                    break
                }
            }
        }
    
}

extension DLWidgetView {
    func configView(data: LayoutModel, stateNumber: Int) {
        stateN = stateNumber
        self.data = data
    }
}
