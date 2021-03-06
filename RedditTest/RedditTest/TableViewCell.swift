//
//  TableViewCell.swift
//  RedditTest
//
//  Created by Fabio Bermudez on 29/08/16.
//  Copyright © 2016 Fabio Bermudez. All rights reserved.
//

import UIKit


class TableViewCell: UITableViewCell {
    
    //MARK: - Private Properties
    
    private weak var delegateTableViewCell : ThumbnailInteractionDelegate?
    private var feedItemModelView : FeedItemModelView?

    //MARK: - IBOutlets
  
    @IBOutlet weak var tittleLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var commentQtyLabel: UILabel!
    @IBOutlet weak var thumbnailImageView: UIImageView!
    @IBOutlet weak var activityView: UIActivityIndicatorView!

    //MARK: - Cell

    func initCell() {
        tittleLabel.text = ""
        authorLabel.text = ""
        dateLabel.text = ""
        commentQtyLabel.text = ""
        thumbnailImageView.image = UIImage(named:"imageBack")
        self.activityView.stopAnimating()
        self.selectionStyle = .none
        self.selectedBackgroundView = nil
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.initCell()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.initCell()
    }
    
    func setModel(_ model : FeedItemModelView, delegate : ThumbnailInteractionDelegate) {
        feedItemModelView = model
        delegateTableViewCell = delegate
        tittleLabel.text = model.tittle
        authorLabel.text = model.author
        commentQtyLabel.text = model.num_comments
        dateLabel.text = model.date
        if let image = model.image {
            self.thumbnailImageView.image = image
        } else {
            self.activityView.startAnimating()
            do {
                try self.feedItemModelView?.getImage(callBackClosure: { [weak self] (image : UIImage?) in
                    if let selfInstance = self {
                        DispatchQueue.main.async(execute: {
                            if let image = image {
                                selfInstance.thumbnailImageView.image = image
                            }
                            selfInstance.activityView.stopAnimating()
                        })
                    }
                })
            } catch  {
                self.activityView.stopAnimating()
            }
        }
    }
    
    @IBAction func thumbnailTouched(_ sender: AnyObject) {
        guard let delegate = delegateTableViewCell else { return }
        guard let model = feedItemModelView else { return }
        delegate.thumbnailTouched(model)
    }
    
}
