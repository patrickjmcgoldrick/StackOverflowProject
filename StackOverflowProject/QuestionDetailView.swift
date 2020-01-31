//
//  QuesionDetailView.swift
//  StackOverflowProject
//
//  Created by dirtbag on 1/30/20.
//  Copyright © 2020 dirtbag. All rights reserved.
//

import UIKit

class QuestionDetailView: UIView {

    var viewModel: QuestionDetailViewModel?
    let urlBuilder = URLBuilder()
    
    // MARK: Init UI
    var tableView: UITableView = {
        let tableview = UITableView()
        tableview.translatesAutoresizingMaskIntoConstraints = false
        return tableview
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        assertionFailure("init(coder:) has not been implemented")
    }
    
    func setupView() {
        addSubview(tableView)
        
        tableView.dataSource = self
        tableView.register(QuestionTableViewCell.self, forCellReuseIdentifier: "QuestionCell")
        tableView.register(AnswerTableViewCell.self, forCellReuseIdentifier: "AnswerCell")
        tableView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor).isActive = true
    }
}

// MARK: Table View Data Source
extension QuestionDetailView: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if viewModel?.answers.count == 0 {
            return 1
        } else {
            return 2
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            if let post = viewModel?.question {
                return post.title
            } else {
                return "Question:"
            }
        } else {
            return "\(String(describing: viewModel?.answers.count)) Answers"
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if section == 0 {
            return 1
        } else {
            return viewModel?.answers.count ?? 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            return getQuestionCell(indexPath: indexPath)
        } else {
            return getAnswerCell(indexPath: indexPath)
        }
    }
    
    // MARK: Question Cell
    func getQuestionCell(indexPath: IndexPath) -> UITableViewCell {
        
        guard let post = viewModel?.question else { return UITableViewCell() }
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "QuestionCell") as? QuestionTableViewCell
            else { return UITableViewCell() }
        cell.tag = 0
        cell.updateDelegate = self
        cell.lblBody.text = post.body.html2String
        cell.lblScore.text = post.score.description
        if post.upvoted {
            cell.btnUpVote.imageView?.image = UIImage(imageLiteralResourceName: "up")
        } else {
            cell.btnUpVote.imageView?.image = UIImage(imageLiteralResourceName: "up_grey")
        }
        if post.downvoted {
            cell.btnDownVote.imageView?.image = UIImage(imageLiteralResourceName: "down")
        } else {
            cell.btnDownVote.imageView?.image = UIImage(imageLiteralResourceName: "down_grey")
        }
        if post.favorited {
            cell.btnFavorited.imageView?.image = UIImage(imageLiteralResourceName: "star")
        } else {
            cell.btnFavorited.imageView?.image = UIImage(imageLiteralResourceName: "star_empty")
        }
        return cell
    }
    
    // MARK: Answer Cell
    func getAnswerCell(indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "AnswerCell") as? AnswerTableViewCell
            else { return UITableViewCell() }
        
        guard let answer = viewModel?.answers[indexPath.row] else { return UITableViewCell() }
        // add one (1) to tag so we know which are answers
        cell.tag = indexPath.row + 1
        cell.updateDelegate = self
        cell.lblBody.text = answer.body
        cell.lblScore.text = answer.score.description
        if answer.upvoted {
            cell.btnUpVote.imageView?.image = UIImage(imageLiteralResourceName: "up")
        } else {
            cell.btnUpVote.imageView?.image = UIImage(imageLiteralResourceName: "up_grey")
        }
        if answer.downvoted {
            cell.btnDownVote.imageView?.image = UIImage(imageLiteralResourceName: "down")
        } else {
            cell.btnDownVote.imageView?.image = UIImage(imageLiteralResourceName: "down_grey")
        }
        if answer.is_accepted {
            cell.imgAccepted.image = UIImage(imageLiteralResourceName: "checkmark")
        } else {
            cell.imgAccepted.image = nil
        }
        
        return cell
    }
}

// MARK: Question / Answer Update Delegate
extension QuestionDetailView: UpdateDelegate {
    
    func updateUpvote(row: Int) {
        
        var tempUrlString: String?
        if row == 0 {
            guard let question = viewModel?.question else { return }
            let upVoted = question.upvoted
            let questionId = question.question_id
            if upVoted {
                tempUrlString = urlBuilder.undoUpVoteQuestion(questionId)
            } else {
                tempUrlString = urlBuilder.upVoteQuestion(questionId)
            }
        } else {
            guard let answer = viewModel?.answers[row - 1] else { return }
            let upVoted = answer.upvoted
            let answerId = answer.answer_id
            if upVoted {
                tempUrlString = urlBuilder.undoUpVoteAnswer(answerId)
            } else {
                tempUrlString = urlBuilder.upVoteAnswer(answerId)
            }
        }
        guard let urlString = tempUrlString else { return }
        if row == 0 { // Qustion
            viewModel?.updateQuestionData(urlString) {
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        } else {
            viewModel?.updateAnswerData(urlString, row: row - 1) {
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
    }
    
    func updateDownvote(row: Int) {
        var tempUrlString: String?
        if row == 0 {
            guard let question = viewModel?.question else { return }
            let downVoted = question.downvoted
            let questionId = question.question_id
            if downVoted {
                tempUrlString = urlBuilder.undoDownVoteQuestion(questionId)
            } else {
                tempUrlString = urlBuilder.downVoteQuestion(questionId)
            }
        } else {
            guard let answer = viewModel?.answers[row - 1] else { return }
            let downVoted = answer.downvoted
            let answerId = answer.answer_id
            if downVoted {
                tempUrlString = urlBuilder.undoDownVoteAnswer(answerId)
            } else {
                tempUrlString = urlBuilder.downVoteAnswer(answerId)
            }
        }
        guard let urlString = tempUrlString else { return }
        if row == 0 { // Question
            viewModel?.updateQuestionData(urlString) {
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        } else { // Answer
            viewModel?.updateAnswerData(urlString, row: row - 1) {
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
    }
    
    // must be row 0, Question
    func updateFavorite() {
        guard let question = viewModel?.question else { return }
        let favorite = question.favorited
        let questionId = question.question_id
        var tempUrlString: String?
        if favorite {
            tempUrlString = urlBuilder.undoFavoriteQuestion(questionId)
        } else {
            tempUrlString = urlBuilder.favoriteQuestion(questionId)
        }
        guard let urlString = tempUrlString else { return }
        viewModel?.updateQuestionData(urlString) {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
}
