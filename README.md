# 📦 Order Management App

## 🚀 Overview

#### The Order Management App is a Flutter-based application that allows users to create and submit orders step by step. It includes customer info, package details, payment selection, and review screens. The app follows Clean Architecture, Bloc for state management, and GoRouter for navigation.

[📹 Watch Demo](https://www.loom.com/share/9ced8b8caeaa42748e74493955434989)

# 🎯 Features
#### ✅ Multi-Step Order Creation (Customer Info → Package Details → Payment → Review & Submit)
#### ✅ Payment Method Selection (Credit Card, Cash on Delivery, Pay Later)
#### ✅ State Management using Bloc (Cubit)
#### ✅ Pagination & Validation for Forms
#### ✅ Dark Mode & Responsive UI

# 🏗 Project Structure
#### 📂 lib/
#### ┣ 📂 core/ (Global utilities, constants, helpers)
###### ┃ ┣ 📂 routes/ (GoRouter setup for navigation)

###### ┃ ┣ 📂 theme/ (Custom themes & colors)
#### ┣ 📂 features/order/ (Main feature module)
###### ┃ ┣ 📂 data/ (Repositories & Data Sources)

###### ┃ ┃ ┣ 📂 models/ (Data models for order and payment)

###### ┃ ┣ 📂 domain/ (Business logic & use cases)

###### ┃ ┣ 📂 presentation/ (UI & State Management)

###### ┃ ┃ ┣ 📂 screens/ (Customer Info, Payment, Review, etc.)

###### ┃ ┃ ┣ 📂 widgets/ (Reusable UI components)

###### ┃ ┃ ┣ 📂 cubit/ (OrderCubit for state management)

┣ 📜 main.dart (Entry point of the app

# 🛠 Technologies Used

#### Flutter (Latest Stable)

#### Bloc (Cubit) for State Management

#### GoRouter for Navigation

#### Lottie for Animations
