import UIKit
import SnapKit

class PlayerCell: UICollectionViewCell {
    
    private var titleLabel = UILabel()
    private var valueLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureCell(title: String, value: String) {
        titleLabel.text = title
        valueLabel.text = value
        
        contentView.layer.cornerRadius = 8
        contentView.layer.masksToBounds = true
        contentView.backgroundColor = UIColor(red: 36/255, green: 54/255, blue: 66/255, alpha: 1)
    }
    
    private func setupView() {
        setTitle()
        setValue()
    }
    
    func setTitle() {
        contentView.addSubview(titleLabel)
        titleLabel.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        titleLabel.textColor = UIColor(red: 226/255, green: 241/255, blue: 231/255, alpha: 1)
        titleLabel.textAlignment = .left
    }
    
    func setValue(){
        contentView.addSubview(valueLabel)
        valueLabel.font = UIFont.systemFont(ofSize: 16)
        valueLabel.textColor = UIColor(red: 226/255, green: 241/255, blue: 231/255, alpha: 1)
        valueLabel.textAlignment = .center
    }
    
    private func setConstraints() {
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(contentView.safeAreaLayoutGuide).offset(8)
            make.left.equalTo(contentView.safeAreaLayoutGuide).offset(8)
        }
        
        valueLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom)
            make.centerX.equalTo(contentView.safeAreaLayoutGuide)
        }
    }
}
