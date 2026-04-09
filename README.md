# 🔥 Firebase Setup for Flutter (Auth + Firestore)

Dokumentasi ini menjelaskan cara setup Firebase pada project Flutter dari awal hingga siap digunakan, termasuk:

* Firebase Core
* Firebase Authentication
* Cloud Firestore

---

## 📌 Prasyarat

Pastikan sudah terinstall:

* Flutter SDK
* Node.js (untuk install Firebase CLI)
* Akun Firebase

---

## 🚀 1. Install Firebase CLI (via NPM)

```bash
npm install -g firebase-tools
```

Login ke Firebase:

```bash
firebase login
```

---

## ⚙️ 2. Install FlutterFire CLI

```bash
dart pub global activate flutterfire_cli
```

---

## 🔥 3. Hubungkan Firebase ke Project Flutter

Jalankan di root project Flutter:

```bash
flutterfire configure
```

Langkah ini akan:

* Menghubungkan project ke Firebase
* Membuat file konfigurasi:

```
lib/firebase_options.dart
```

---

## 📦 4. Install Dependency Flutter

Tambahkan ke `pubspec.yaml`:

```yaml
dependencies:
  flutter:
    sdk: flutter

  firebase_core: ^3.15.2
  firebase_auth: ^5.3.3
  cloud_firestore: ^5.6.12
```

Kemudian jalankan:

```bash
flutter pub get
```

---

## 🔌 5. Inisialisasi Firebase

Edit file `main.dart`:

```dart
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}
```

---

## 🔐 6. Setup Authentication

1. Buka Firebase Console
2. Pilih project
3. Masuk ke **Authentication → Sign-in Method**
4. Aktifkan:

   * Email/Password

---

## 🗄️ 7. Setup Firestore Database

1. Masuk ke **Firestore Database**
2. Klik **Create Database**
3. Pilih **Start in Test Mode**
4. Pilih region

---

## 💻 8. Contoh Penggunaan

### ✅ Register User

```dart
import 'package:firebase_auth/firebase_auth.dart';

Future<void> register(String email, String password) async {
  await FirebaseAuth.instance.createUserWithEmailAndPassword(
    email: email,
    password: password,
  );
}
```

---

### ✅ Login User

```dart
Future<void> login(String email, String password) async {
  await FirebaseAuth.instance.signInWithEmailAndPassword(
    email: email,
    password: password,
  );
}
```

---

### ✅ Tambah Data ke Firestore

```dart
import 'package:cloud_firestore/cloud_firestore.dart';

Future<void> addUser() async {
  await FirebaseFirestore.instance.collection('users').add({
    'name': 'Kensa',
    'age': 20,
  });
}
```

---

### ✅ Ambil Data dari Firestore

```dart
Future<void> getUsers() async {
  var data = await FirebaseFirestore.instance.collection('users').get();

  for (var doc in data.docs) {
    print(doc.data());
  }
}
```

---

## ⚠️ Troubleshooting

### ❌ Firebase belum diinisialisasi

**Error:**

```
Firebase has not been initialized
```

**Solusi:**
Pastikan:

```dart
await Firebase.initializeApp();
```

---

### ❌ File konfigurasi tidak ditemukan

Pastikan sudah menjalankan:

```bash
flutterfire configure
```

---

### ❌ Permission Firestore ditolak

Gunakan rule sementara (untuk testing):

```js
allow read, write: if true;
```

> ⚠️ Jangan gunakan di production

---

### ❌ Error setelah setup

Coba jalankan:

```bash
flutter clean
flutter pub get
```

---

## 🧠 Catatan Penting

* Flutter **tidak menggunakan NPM** untuk dependency
* NPM hanya digunakan untuk install Firebase CLI
* Gunakan FlutterFire CLI untuk konfigurasi otomatis

---

## 📁 Struktur Project (Disarankan)

```
lib/
 ├── firebase_options.dart
 ├── services/
 │    ├── auth_service.dart
 │    └── firestore_service.dart
 ├── screens/
 └── main.dart
```

---

## 🎯 Kesimpulan

Dengan mengikuti langkah di atas, project Flutter kamu sudah terhubung dengan Firebase dan siap menggunakan:

* Authentication
* Firestore Database

---

## ✨ Author

Dibuat untuk kebutuhan pembelajaran dan ujian berbasis repository.
