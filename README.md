# 📝 Flutter Notes App

A simple yet powerful notes app built with **Flutter**, using **GetX** for state management and routing, **Sqflite** for local data storage, and **GetStorage** for theme preferences. This app allows users to create, edit, delete, and search notes, and supports dark mode.

---

## ✨ Features

- 📒 Create, Read, Update, and Delete (CRUD) notes
- 🔍 Search through notes in real-time
- 🗂️ Sort notes by title or last updated
- 🌓 Light and Dark mode toggle
- 💾 Local storage using SQLite via `sqflite`
- ⚡️ Fast state management and routing using GetX
- 🗃️ Persistent theme using GetStorage

---

## 📦 Dependencies

| Package            | Description                            |
|--------------------|----------------------------------------|
| `get`              | State management and routing           |
| `sqflite`          | SQLite database for persistent storage |
| `path_provider`    | Path access for SQLite DB              |
| `get_storage`      | Persistent local key-value storage     |

---

## 📁 Folder Structure
<pre lang="markdown">
lib/
├── app/
│ ├── bindings/ # Dependency injection
│ ├── controllers/ # GetX Controllers
│ ├── data/
│ │ ├── models/ # Note model
│ │ └── services/ # SQLite service
│ ├── routes/ # AppPages (GetX routing)
│ ├── screens/ # HomeScreen and NoteScreen
│ ├── services/ # Theme service
│ └── themes/ # Light and dark themes
├── main.dart # App entry point
</pre>
