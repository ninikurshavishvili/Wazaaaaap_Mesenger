# Wazaaaaap - iOS Application Project Report

## Overview

Wazaaaaap is a dynamic iOS application developed using **SwiftUI**, following the **MVVM architectural pattern**. The app aims to provide users with a simple and fast chat experience through registration and authorization systems, featuring an interactive design and user-friendly functionality.

---
## Key Features

### **Authorization (LoginView)**

- Users can log in using their email and password.
- Google account login is supported.

### **Registration (SignUpView)**

- Allows users to create a new account.
- Includes standard fields: name, email, and password.

### **Chat Page (ChatView)**

- A shared chat room where all authenticated users can interact.
- Users can react to messages.

### **Profile Page (ProfileView)**

- Users can update their name.
- Profile picture upload functionality.

---

## Technical Details

### **Technologies Used**

- **Framework**: SwiftUI  
- **Architectural Pattern**: MVVM  
- **Resource Management**: Firebase Authentication and Realtime Database  
- **Development Tool**: Xcode 16  

---

## Project Structure

### **Helpers & Extensions**
- `Color+Extension.swift`: Manages custom colors.  
- `Fonts.swift`: Handles custom font configurations.  

### **Managers**
- `AuthManager.swift`: Manages user authentication logic.  
- `DatabaseManager.swift`: Handles database interactions.  

### **Presenters**
#### **Chat Page**
- `ChatViewModel.swift`: ViewModel for chat functionalities.  
- `Message.swift`: Defines message model.  
- `ChatView.swift`: Main view for the chat interface.  
- `MessageView.swift`: Subview for displaying individual messages.  

#### **Launch Page**
- `LaunchScreenView.swift`: Initial launch screen of the app.  

#### **Login Page**
- `LoginView.swift`: Login interface.  
- `LoginViewModel.swift`: Handles login logic.  

#### **Profile Page**
- `ProfileView.swift`: Profile interface.  
- `ProfileViewModel.swift`: Handles profile-related logic.  

#### **Sign-Up Page**
- `SignUpView.swift`: Registration interface.  
- `SignUpViewModel.swift`: Handles registration logic.  
- `UserModel.swift`: Defines the user data model.  
