# Game Shop E-Commerce Flutter App

A complete Flutter e-commerce application for gaming products with Supabase backend.

## Features

- 🔐 User Authentication (Login/Register)
- 🏪 Product Catalog with Categories
- 🛒 Shopping Cart
- 📦 Order Management
- 👤 User Profile
- 🎨 Modern UI with Material Design 3

## Prerequisites

- Flutter SDK (3.10.4 or higher)
- Dart SDK
- Supabase account
- Android Studio / VS Code
- Android/iOS Emulator or Physical Device

## Setup Instructions

### 1. Install Dependencies

```bash
flutter pub get
```

### 2. Supabase Setup

The app is already configured with Supabase credentials. However, you'll need to set up your Supabase database with the following tables:

#### Profiles Table
```sql
CREATE TABLE profiles (
  id UUID REFERENCES auth.users PRIMARY KEY,
  email TEXT NOT NULL,
  name TEXT,
  avatar_url TEXT,
  phone TEXT,
  address TEXT,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);
```

#### Products Table
```sql
CREATE TABLE products (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  name TEXT NOT NULL,
  description TEXT,
  price DECIMAL(10, 2) NOT NULL,
  category TEXT NOT NULL,
  images TEXT[] DEFAULT '{}',
  rating DECIMAL(3, 2) DEFAULT 0,
  review_count INTEGER DEFAULT 0,
  is_featured BOOLEAN DEFAULT false,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);
```

#### Orders Table
```sql
CREATE TABLE orders (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  user_id UUID REFERENCES auth.users NOT NULL,
  total_amount DECIMAL(10, 2) NOT NULL,
  status TEXT DEFAULT 'pending',
  shipping_address TEXT,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);
```

#### Order Items Table
```sql
CREATE TABLE order_items (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  order_id UUID REFERENCES orders NOT NULL,
  product_id UUID REFERENCES products NOT NULL,
  quantity INTEGER NOT NULL,
  price DECIMAL(10, 2) NOT NULL,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);
```

### 3. Add Sample Products

You can add sample products to your database:

```sql
INSERT INTO products (name, description, price, category, images, rating, review_count, is_featured)
VALUES 
  ('God of War Ragnarök', 'Epic action-adventure game', 59.99, 'Action', ARRAY['https://example.com/gow.jpg'], 4.8, 1250, true),
  ('Elden Ring', 'Open-world RPG masterpiece', 59.99, 'RPG', ARRAY['https://example.com/elden.jpg'], 4.9, 2100, true),
  ('Spider-Man 2', 'Superhero action game', 69.99, 'Action', ARRAY['https://example.com/spiderman.jpg'], 4.7, 980, true),
  ('FIFA 24', 'Football simulation', 49.99, 'Sports', ARRAY['https://example.com/fifa.jpg'], 4.5, 750, false);
```

### 4. Run the App

```bash
flutter run
```

## Project Structure

```
lib/
├── app/
│   └── app.dart                    # Main app configuration with routing
├── core/
│   ├── models/
│   │   ├── product.dart           # Product model
│   │   └── user.dart              # User model
│   └── services/
│       └── supabase_service.dart  # Supabase service layer
├── features/
│   ├── auth/
│   │   └── presentation/
│   │       ├── bloc/              # Authentication BLoC
│   │       └── screens/           # Auth screens
│   ├── cart/
│   │   └── presentation/
│   │       ├── bloc/              # Cart BLoC
│   │       └── screens/           # Cart screen
│   ├── order/
│   │   └── presentation/
│   │       └── screens/           # Order screens
│   └── product/
│       └── presentation/
│           ├── screens/           # Product screens
│           └── widgets/           # Product widgets
├── shared/
│   └── widgets/                   # Shared UI widgets
└── main.dart                      # App entry point
```

## Key Technologies

- **State Management**: BLoC Pattern (flutter_bloc)
- **Backend**: Supabase (Authentication & Database)
- **Routing**: GoRouter
- **UI**: Material Design 3
- **Fonts**: Google Fonts

## Common Issues & Solutions

### Issue: App shows blank screen
**Solution**: This was the main issue - the app wasn't using the proper BLoC providers. The fixed `main.dart` now uses the `App` widget which includes all necessary BLoC providers.

### Issue: Authentication not working
**Solution**: Make sure your Supabase project is properly configured and the profiles table exists.

### Issue: Products not loading
**Solution**: Add sample products to your Supabase products table.

## Environment Variables

The app currently uses hardcoded Supabase credentials. For production, you should:

1. Create a `.env` file:
```
SUPABASE_URL=your_supabase_url
SUPABASE_ANON_KEY=your_anon_key
```

2. Use flutter_dotenv to load environment variables

## Testing

Run tests with:
```bash
flutter test
```

## Build for Production

### Android
```bash
flutter build apk --release
```

### iOS
```bash
flutter build ios --release
```

## What Was Fixed

The main issue was in `main.dart`:
- **Before**: Used a basic MaterialApp without BLoC providers
- **After**: Uses the App widget which includes MultiBlocProvider with AuthBloc and CartBloc

This ensures the SplashScreen and all other screens can access the authentication state.

## Contributing

Feel free to submit issues and pull requests!

## License

This project is for educational purposes.