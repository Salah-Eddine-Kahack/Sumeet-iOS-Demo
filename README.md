# Sumeet 🤝

Sumeet is an iOS application built as part of a technical exercise. Its purpose is to fetch and display random user data, with features such as infinite scrolling, offline support, and detailed contact views. The idea behind the app is to connect with others and discover people from around the world.

## 📸 Screenshots

### 🧑‍🤝‍🧑 Contact List
![Contact List (Light)](https://i.postimg.cc/520jtMwj/IMG-6148.png)
![Contact List (Dark)](https://i.postimg.cc/rFqKv4s1/IMG-6147.png)

### 🧾 Contact Detail
![Contact Detail (Light)](https://i.postimg.cc/3RpkHC2B/IMG-6150.png)
![Contact Detail (Dark)](https://i.postimg.cc/zXpV5fH9/IMG-6149.png)

## 📱 Features

- Fetches 10 random users per API call from [randomuser.me](https://randomuser.me/)
- Infinite scroll to continuously load more users
- Manual refresh support
- Cache management: Displays the last successfully fetched list at launch
- Tap on a user to access a detailed view of all their attributes
- Built entirely programmatically, no Storyboards or XIBs

## ⚙️ Tech Stack & Decisions

- **Language**: Swift, Combine
- **UI**: UIKit (fully programmatic, no Storyboards or SwiftUI)
- **Networking**: `URLSession`
- **Third-Party Libraries**: 
  - [Kingfisher](https://github.com/onevcat/Kingfisher): Used for asynchronous image loading and caching. It simplifies handling remote images while improving performance and responsiveness.

## 🚧 Project Constraints

This project was developed under the following constraints:

- Written in **Swift**
- **No Storyboards** or **XIBs**
- **SwiftUI** was **not** allowed
- Use of third-party libraries was allowed (with justification)

## 🚀 Getting Started

1. Clone the repository:
   ```bash
   git clone https://github.com/Salah-Eddine-Kahack/Sumeet-iOS-Demo.git
2. Open the project:
    - Open `Sumeet-iOS-Demo.xcodeproj` in Xcode.

3. Build & Run:
    - Select an iPhone simulator or device.
    - Hit `Cmd + R` to build and run the app.
    - Requires Xcode 16, Swift 6, and iOS 16.0+.

## 🙏 Thanks

This project was created as a technical exercise but turned into something I genuinely enjoyed building. Thanks to the reviewers for taking the time to go through the code, and to the team behind [randomuser.me](https://randomuser.me/) for the simple and fun API.

If you're checking this repo out, feel free to leave feedback, open issues, or just say hi! 👋
