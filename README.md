# moodtracker

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
# Mood Tracker App

A simple Flutter app to track daily mood, view mood history, and get insights — built with Flutter and Firebase.

---

## ✨ Features

* User authentication (email/password)
* Log mood once per day (with optional note)
* View mood history in list form
* See mood insights (mood counts, trends)
* Firebase Firestore integration

---

## 🚀 Setup

1. **Clone the repository:**

   ```bash
   git clone https://github.com/sarvesh560/flutterapp.git
   cd flutterapp
   ```

2. **Install dependencies:**

   ```bash
   flutter pub get
   ```

3. **Firebase Setup:**

    * Go to [Firebase Console](https://console.firebase.google.com/)
    * Create a new project
    * Add Android and/or iOS apps
    * Download `google-services.json` and place it in `/android/app/`
    * (Optional) For iOS, download `GoogleService-Info.plist` and add to your Xcode project

4. **Run the app:**

   ```bash
   flutter run
   ```

---

## 🧩 Project Structure & Logic

* Uses **Firestore** for mood entries.

* User mood data structure:

  ```json
  {
    "mood": "Happy",
    "note": "Had a great day!",
    "timestamp": "2025-06-20T08:30:00Z"
  }
  ```

* Firestore Structure:

  ```
  users (collection)
    |
    --> uid (document)
          |
          --> moods (subcollection)
                  --> YYYY-MM-DD (document)
  ```

* Screens:

    * `AuthenticationScreen` (Login / SignUp)
    * `MoodEntryScreen`
    * `MoodHistoryScreen`
    * `MoodInsightsScreen`

---

## ⚖️ Trade-offs & Limitations

* Only **1 mood entry per day** — to simplify UX
* Basic mood insights — room for richer visualizations
* No offline mode — needs internet connection
* No advanced profile / customization yet
* Password reset feature not yet implemented

---

## 🌟 Future Improvements

* Add Dark Mode
* Add Notifications (daily mood reminder)
* Improve charting with better insights
* Enable edit/delete mood entries
* Support exporting data (CSV/JSON)

---

## 📝 License

This project is licensed under the MIT License — see the [LICENSE](LICENSE) file for details.

---

## 🙏 Acknowledgements

* Flutter
* Firebase (Auth + Firestore)
* Community Packages

---

By,

Sarvesh M
