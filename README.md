# Final Project : StackOverflow

## Main Requirements
- [ ] Build stack overflow clone using Swift 5.0.

- [x] Must be able to search in real time, ie each character should trigger a search.
- [ ] MVVM
- [ ] Should support lazy loading if required.
- [ ] Should support pagination.
- [ ] User can save favorite questions.
- [x] Should use swiftLint and get warnings under 20. (tip use SwiftLint from the very start and don’t let the errors pile up.)
- [ ] Should be able to upvote or downvote a question.
- [ ] Should be able to post a question with HTTP POST.
- [ ] Should be able to view answers for questions and sort it.
- [ ] Should be able to post answers to other’s questions.
- [ ] Of course there is CoreData, the app should work in offline mode. Unit test every ViewModel file.
- [ ] FaceId auth/ touch Id, should allow user to re-login without re- entering credentials.
- [ ] Able to export a favorite question to safari/ open a link using WebView.
- [ ] Encrypt stored password.
- [ ] Should show checkmark for the best answer.
- [x] Should contain a URLBuilder class.
- [x] Avoid pods if possible, no penalty if you do use it.
- [ ] UI/UX as close to the real website as possible.
- [ ] Should support dark mode and light mode.

## Extra Credit :
- [ ] Huge bonus for fully programmatic project.
- [ ] Should be able to look at favorite questions on Apple Watch. Perfect iPadOS and MacOS UI.
- [ ] At least 1 UI test.
- [ ] Could contain animations.
- [ ] Use an objective-C Class with a bridging header.
- [ ] Should include sounds and haptics.


# Notes on API use
* https://api.stackexchange.com/2.2/answers/59741612?order=desc&filter=!b1MMEAHHviRpJX&sort=activity&site=stackoverflow

* https://api.stackexchange.com/2.2/questions?fromdate=86400&filter=!9Z(-wwYGT&sort=activity&todate=1579117336&order=desc&site=stackoverflow
