# DentalFlow - Dental Clinic Management System

## 🦷 Overview

DentalFlow is a production-ready, modern Dental Clinic Management System built with Flutter. It provides a comprehensive solution for managing dental clinics with support for multiple user roles, appointments, patient records, and financial tracking.

## ✨ Features

### Multi-Platform Support
- ✅ Web (Windows, macOS, Linux)
- ✅ Mobile (Android, iOS)
- ✅ Tablet Support
- ✅ Responsive Design

### Technology Stack
- **Framework**: Flutter 3.x
- **Backend**: Supabase
- **UI**: Material 3
- **State Management**: GetX
- **Architecture**: Clean Architecture + MVVM
- **Localization**: Arabic (RTL) & English
- **Theme**: Light & Dark Mode
- **Null Safety**: ✅

### User Roles

#### 1. Admin
- Manage doctors and secretaries
- User account management
- Reset passwords
- View all appointments and patients
- Statistics and reporting
- Database backup/restore
- Clinic settings

#### 2. Doctor
- View personal appointments
- Manage medical records
- Add diagnosis and treatment
- Upload X-rays and photos
- Schedule follow-ups
- Mark visits as completed

#### 3. Secretary
- View all doctor schedules
- Create and manage appointments
- Check-in patients
- Search appointments
- Mark absences

### Core Features
- 🔐 Secure Authentication
- 📋 Patient Management
- 📅 Appointment Scheduling
- 🏥 Medical Records
- 💰 Financial Management
- 📊 Reports & Analytics
- 🔔 Notifications
- 🔍 Global Search
- 📱 Responsive UI
- 🌙 Dark/Light Mode
- 🌐 Arabic & English Support

## 📁 Project Structure

```
dentalflow/
├── lib/
│   ├── main.dart
│   ├── config/
│   │   ├── theme/
│   │   │   └── app_theme.dart
│   │   ├── localization/
│   │   │   └── app_localization.dart
│   │   └── routes/
│   │       └── app_routes.dart
│   ├── core/
│   │   └── services/
│   │       └── supabase_service.dart
│   ├── data/
│   │   ├── models/
│   │   │   ├── user_model.dart
│   │   │   ├── patient_model.dart
│   │   │   ├── appointment_model.dart
│   │   │   ├── medical_record_model.dart
│   │   │   └── financial_record_model.dart
│   │   └── repositories/
│   │       ├── auth_repository.dart
│   │       ├── patient_repository.dart
│   │       └── appointment_repository.dart
│   ├── domain/
│   │   ├── entities/
│   │   └── usecases/
│   ├── presentation/
│   │   ├── pages/
│   │   │   ├── splash/
│   │   │   │   └── splash_screen.dart
│   │   │   └── auth/
│   │   │       └── login_screen.dart
│   │   ├── controllers/
│   │   └── widgets/
│   │       └── common/
│   │           ├── app_card.dart
│   │           └── empty_state.dart
│   └── utils/
├── assets/
│   ├── images/
│   ├── animations/
│   ├── icons/
│   └── fonts/
├── pubspec.yaml
└── README.md
```

## 🚀 Getting Started

### Prerequisites
- Flutter 3.x installed
- Dart SDK 3.x
- Supabase account

### Installation

1. **Clone the repository**
```bash
git clone https://github.com/haider-3321/dentalflow.git
cd dentalflow
```

2. **Install dependencies**
```bash
flutter pub get
```

3. **Configure Supabase**
   - Go to `lib/core/services/supabase_service.dart`
   - Update `supabaseUrl` and `supabaseAnonKey` with your Supabase credentials

4. **Run the app**
```bash
flutter run
```

## 🔧 Configuration

### Supabase Setup

Create the following tables in your Supabase project:

```sql
-- Users table
CREATE TABLE users (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  username TEXT UNIQUE NOT NULL,
  email TEXT UNIQUE NOT NULL,
  phone TEXT,
  first_name TEXT,
  last_name TEXT,
  role TEXT NOT NULL CHECK (role IN ('admin', 'doctor', 'secretary')),
  status TEXT NOT NULL DEFAULT 'active' CHECK (status IN ('active', 'inactive', 'suspended')),
  specialization TEXT,
  license TEXT,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP
);

-- Patients table
CREATE TABLE patients (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  full_name TEXT NOT NULL,
  age INTEGER NOT NULL,
  gender TEXT NOT NULL CHECK (gender IN ('male', 'female')),
  phone TEXT NOT NULL,
  email TEXT,
  address TEXT,
  blood_type TEXT,
  chronic_diseases JSONB,
  allergies JSONB,
  current_medications JSONB,
  emergency_contact TEXT,
  emergency_phone TEXT,
  notes TEXT,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP
);

-- Appointments table
CREATE TABLE appointments (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  patient_id UUID NOT NULL REFERENCES patients(id) ON DELETE CASCADE,
  doctor_id UUID NOT NULL REFERENCES users(id) ON DELETE CASCADE,
  date DATE NOT NULL,
  time TIME NOT NULL,
  duration INTEGER NOT NULL,
  reason TEXT NOT NULL,
  status TEXT NOT NULL DEFAULT 'booked' CHECK (status IN ('booked', 'confirmed', 'checkedIn', 'withDoctor', 'completed', 'cancelled', 'noShow')),
  notes TEXT,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP
);

-- Medical Records table
CREATE TABLE medical_records (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  patient_id UUID NOT NULL REFERENCES patients(id) ON DELETE CASCADE,
  appointment_id UUID NOT NULL REFERENCES appointments(id) ON DELETE CASCADE,
  doctor_id UUID NOT NULL REFERENCES users(id),
  visit_date DATE NOT NULL,
  diagnosis TEXT,
  treatment TEXT,
  prescription TEXT,
  notes TEXT,
  image_urls JSONB,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP
);

-- Financial Records table
CREATE TABLE financial_records (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  appointment_id UUID NOT NULL REFERENCES appointments(id) ON DELETE CASCADE,
  patient_id UUID NOT NULL REFERENCES patients(id) ON DELETE CASCADE,
  treatment_cost DECIMAL(10, 2) NOT NULL,
  paid_amount DECIMAL(10, 2) NOT NULL,
  remaining_amount DECIMAL(10, 2) NOT NULL,
  payment_method TEXT NOT NULL CHECK (payment_method IN ('cash', 'card', 'check', 'transfer')),
  date_time TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  notes TEXT
);
```

## 🎨 Theming

The app uses Material 3 design system with automatic light/dark theme switching.

**Customize theme colors in:**
- `lib/config/theme/app_theme.dart`

Primary colors can be modified:
```dart
static const Color primaryColor = Color(0xFF1976D2);
static const Color secondaryColor = Color(0xFF00ACC1);
```

## 🌍 Localization

Supports English and Arabic (RTL) languages. Add translations in:
- `lib/config/localization/app_localization.dart`

To change app language:
```dart
// English
GetStorage().write('language', 'en');

// Arabic
GetStorage().write('language', 'ar');
```

## 📱 Responsive Design

The UI automatically adapts to:
- **Mobile** devices (< 600dp width)
- **Tablets** (600-900dp width)
- **Desktop** (> 900dp width)

## 🔐 Security Considerations

- ✅ Use environment variables for sensitive credentials
- ✅ Enable Row Level Security (RLS) in Supabase
- ✅ Validate all inputs on client and server
- ✅ Use HTTPS for all API calls
- ✅ Implement proper password hashing
- ✅ Secure sensitive data storage
- ✅ Regular security audits

## 📦 Build & Distribution

### Android
```bash
flutter build apk --release
flutter build appbundle --release
```

### iOS
```bash
flutter build ios --release
```

### Web
```bash
flutter build web --release
```

### Windows
```bash
flutter build windows --release
```

### macOS
```bash
flutter build macos --release
```

## 🤝 Contributing

Contributions are welcome! Please follow the guidelines:

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## 📄 License

This project is licensed under the MIT License - see the LICENSE file for details.

## 📞 Support

For support:
- Email: support@dentalflow.com
- Create an issue in the repository
- Check existing issues for solutions

## 🗓️ Roadmap

- [ ] Payment integration (Stripe, Paypal)
- [ ] SMS appointment reminders
- [ ] Email notifications
- [ ] Advanced analytics dashboard
- [ ] Mobile app optimization
- [ ] Offline-first mode
- [ ] Video consultation feature
- [ ] AI-powered diagnostics
- [ ] Multi-clinic support
- [ ] Inventory management

## 📚 Documentation

- [Flutter Documentation](https://flutter.dev/docs)
- [Supabase Documentation](https://supabase.com/docs)
- [GetX Documentation](https://github.com/jonataslaw/getx/wiki)
- [Material 3 Design](https://m3.material.io/)

---

**Made with ❤️ by DentalFlow Team**

*Last updated: 2024*
