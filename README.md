# SkyClad 📱

A modern iOS cryptocurrency portfolio management application built with SwiftUI, featuring real-time portfolio tracking, exchange functionality, and comprehensive transaction management.

## 🏗️ Project Structure

```
SkyClad/
├── SkyClad/
│   ├── App/
│   │   ├── Info.plist                 # App configuration and metadata
│   │   └── SkyCladApp.swift          # Main app entry point
│   │
│   ├── System/
│   │   ├── APIs/                      # Core API interfaces
│   │   │   ├── ComponentAPI.swift     # Component communication protocol
│   │   │   ├── NavigationAPI.swift    # Navigation management
│   │   │   └── TransactionAPI.swift   # Transaction operations
│   │   │
│   │   ├── Components/                # Reusable UI components
│   │   │   ├── Buttons/
│   │   │   │   ├── SCActionButton.swift    # Primary action buttons
│   │   │   │   └── SCPillButton.swift      # Pill-shaped secondary buttons
│   │   │   ├── Cards/
│   │   │   │   ├── SCAssetCard.swift       # Individual asset display cards
│   │   │   │   ├── SCExchangeCard.swift    # Exchange operation cards
│   │   │   │   ├── SCPortfolioCard.swift   # Portfolio summary cards
│   │   │   │   └── SCTransactionCard.swift # Transaction history cards
│   │   │   ├── Charts/
│   │   │   │   └── SCPortfolioTrendChart.swift # Portfolio performance charts
│   │   │   ├── NavBars/
│   │   │   │   └── BottomNavBar.swift      # Bottom navigation bar
│   │   │   ├── Pickers/
│   │   │   │   └── SCSegmentedPicker.swift # Segmented control picker
│   │   │   ├── Shapes/
│   │   │   │   └── RoundedCorners.swift    # Custom rounded corner shapes
│   │   │   └── Toggles/
│   │   │       └── SCToggle.swift          # Custom toggle switches
│   │   │
│   │   ├── Features/                  # Main app features
│   │   │   ├── Exchange/
│   │   │   │   ├── ExchangeView.swift      # Cryptocurrency exchange interface
│   │   │   │   └── ExchangeViewModel.swift # Exchange business logic
│   │   │   ├── Home/
│   │   │   │   ├── HomeView.swift          # Main dashboard view
│   │   │   │   └── HomeViewModel.swift     # Home screen logic
│   │   │   ├── PortfolioDashboard/
│   │   │   │   ├── PortfolioDashboardView.swift    # Portfolio overview
│   │   │   │   └── PortfolioDashboardViewModel.swift # Portfolio logic
│   │   │   └── TransactionsSummary/
│   │   │       ├── TransactionsSummaryView.swift   # Transaction history
│   │   │       └── TransactionSummaryViewModel.swift # Transaction logic
│   │   │
│   │   ├── Services/                  # Business logic services
│   │   │   └── ExchangeService.swift       # Cryptocurrency exchange operations
│   │   │
│   │   └── UI/                        # UI assets and utilities
│   │       ├── Assets/                 # App icons, images, and colors
│   │       │   ├── Assets.xcassets/     # Xcode asset catalog
│   │       │   └── [Various asset files]
│   │       ├── Fonts/                  # Custom typography
│   │       │   ├── GeistMono-VariableFont.ttf  # Monospace font
│   │       │   ├── Inter-VariableFont.ttf      # Primary font
│   │       │   └── SCFont.swift               # Font management
│   │       └── Utilities/              # UI helper extensions
│   │           ├── CGFloat+Extensions.swift    # Dimension utilities
│   │           ├── Color+Extentions.swift      # Color management
│   │           ├── Font+Extensions.swift       # Typography utilities
│   │           └── FontWeight+Extensions.swift # Font weight management
│   │
│   └── SkyClad.xcodeproj/             # Xcode project file
```

## 🚀 Features

### 📊 Portfolio Dashboard
- Real-time portfolio value tracking
- Asset allocation visualization
- Performance trend charts
- Portfolio summary cards

### 💱 Exchange Interface
- Cryptocurrency trading functionality
- Real-time exchange rates
- Transaction execution
- Order management

### 📈 Transaction Management
- Complete transaction history
- Transaction categorization
- Performance analytics
- Export capabilities

### 🎨 Modern UI/UX
- Clean, minimalist design
- Dark/light mode support
- Smooth animations
- Responsive layouts

## 🛠️ Technical Stack

- **Framework**: SwiftUI
- **Architecture**: MVVM (Model-View-ViewModel)
- **Language**: Swift 5.0+
- **Platform**: iOS 14.0+
- **Design**: Custom component library

## 🎯 Key Components

### Buttons
- **SCActionButton**: Primary action buttons with customizable styles
- **SCPillButton**: Secondary pill-shaped buttons for less prominent actions

### Cards
- **SCAssetCard**: Displays individual cryptocurrency assets with current value and change
- **SCExchangeCard**: Shows exchange operations and rates
- **SCPortfolioCard**: Portfolio summary with total value and performance
- **SCTransactionCard**: Transaction details with timestamps and amounts

### Navigation
- **BottomNavBar**: Custom bottom navigation with smooth transitions
- **SCSegmentedPicker**: Segmented control for filtering and selection

### Charts
- **SCPortfolioTrendChart**: Interactive charts showing portfolio performance over time

## 🔧 Setup & Installation

1. **Prerequisites**
   - Xcode 14.0 or later
   - iOS 14.0+ deployment target
   - macOS 12.0 or later

2. **Installation**
   ```bash
   # Clone the repository
   git clone [repository-url]
   cd SkyClad
   
   # Open in Xcode
   open SkyClad.xcodeproj
   ```

3. **Build & Run**
   - Select your target device or simulator
   - Press `Cmd + R` to build and run
   - The app will launch on your selected device

## 📱 App Architecture

The app follows the **MVVM (Model-View-ViewModel)** architecture pattern:

- **Views**: SwiftUI views that handle UI presentation
- **ViewModels**: Business logic and data management
- **Models**: Data structures and business entities
- **Services**: External API interactions and data processing
- **Components**: Reusable UI components for consistency

## 🎨 Design System

### Typography
- **Primary Font**: Inter (Variable font for flexibility)
- **Monospace**: Geist Mono (For numerical data and code)
- **Custom Font Management**: Centralized font handling through `SCFont.swift`

### Colors
- **Accent Color**: Primary brand color
- **Background Colors**: Light and dark theme support
- **Asset Colors**: Custom color sets for different states

### Components
- **Consistent Spacing**: Standardized margins and padding
- **Rounded Corners**: Custom corner radius utilities
- **Shadows & Elevation**: Material design principles

## 🔄 State Management

The app uses SwiftUI's built-in state management with:
- `@State` for local view state
- `@StateObject` for view model instances
- `@ObservedObject` for observed view models
- `@Environment` for app-wide settings

## 📊 Data Flow

1. **User Interaction** → View triggers action
2. **View Model** → Processes business logic
3. **Service Layer** → Handles API calls and data processing
4. **Data Update** → View automatically updates via SwiftUI binding

## 🚧 Development Guidelines

### Code Style
- Follow Swift naming conventions
- Use meaningful variable and function names
- Implement proper error handling
- Add comprehensive documentation

### Component Development
- Create reusable components in the `Components/` directory
- Follow the `SC` prefix naming convention
- Implement proper accessibility features
- Test on multiple device sizes

### Testing
- Unit tests for ViewModels
- UI tests for critical user flows
- Test on both light and dark themes
- Verify accessibility compliance

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 📞 Support

For support and questions:
- Create an issue in the repository
- Contact the development team
- Check the documentation

---

**SkyClad** - Your trusted cryptocurrency portfolio companion 📱✨ 
