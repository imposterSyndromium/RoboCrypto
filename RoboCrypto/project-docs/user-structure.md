# RoboCrypto - User Flow & Project Structure

## User Journey
1. **Entry Point**
   - App launch
   - Initial data loading
   - Splash screen (if implemented)

2. **Main Navigation**
   - List of cryptocurrencies
   - Search functionality
   - Filtering options

3. **Detail View Flow**
   - Select cryptocurrency
   - View detailed information
   - Interact with charts
   - Access additional resources

4. **Data Interaction**
   - View real-time updates
   - Expand/collapse descriptions
   - Access external links
   - View statistics

## Data Flow
1. **Data Sources**
   - API endpoints
   - Local cache
   - User preferences

2. **Processing**
   - Data parsing
   - Format conversion
   - Error handling
   - Cache management

3. **Presentation**
   - UI updates
   - Animation handling
   - State management
   - Error display

## Project Structure
```
RoboCrypto/
├── Assets.xcassets/           # App assets and images
├── Core/                      # Core application features
│   ├── Components/           # Reusable UI components
│   ├── Details/              # Coin detail views and view models
│   ├── Home/                 # Home screen views and view models
│   ├── Launch/               # Launch screen and initial setup
│   └── Settings/             # Settings views and view models
├── Extensions/               # Swift extensions
│   ├── ColorTheme.swift      # Custom color theming
│   ├── Date.swift           # Date formatting utilities
│   ├── Double.swift         # Number formatting utilities
│   ├── String.swift         # String manipulation utilities
│   └── UIApplication.swift  # App-level utilities
├── Models/                   # Data models
│   ├── CoinModel.swift      # Main cryptocurrency model
│   ├── CoinDetailModel.swift # Detailed coin information
│   ├── MarketDataModel.swift # Market data and statistics
│   ├── StatisticModel.swift  # Statistical data model
│   └── PortfolioContainer.xcdatamodeld/ # Core Data model
├── Preview Content/          # SwiftUI preview assets
├── Services/                 # Data and business services
│   ├── CoinDataService.swift      # Coin data management
│   ├── CoinDetailDataService.swift # Detailed coin data
│   ├── CoinImageService.swift     # Coin image handling
│   ├── MarketDataService.swift    # Market data retrieval
│   └── PortfolioDataService.swift # Portfolio management
├── Utilities/                # Utility classes and helpers
└── RoboCryptoApp.swift      # App entry point
```

## Component Relationships
1. **Views**
   - DetailView (main detail screen)
   - ChartView (price visualization)
   - CoinImageView (coin icon display)
   - StatisticView (metric display)
   - HomeView (main list screen)
   - SettingsView (app configuration)

2. **ViewModels**
   - DetailViewModel (coin detail business logic)
   - HomeViewModel (list and search functionality)
   - SettingsViewModel (user preferences)
   - PortfolioViewModel (portfolio management)

3. **Models**
   - CoinModel (core cryptocurrency data)
   - CoinDetailModel (detailed coin information)
   - MarketDataModel (market statistics)
   - StatisticModel (metric calculations)
   - Portfolio (user portfolio data)

4. **Services**
   - CoinDataService (coin data management)
   - CoinDetailDataService (detailed information)
   - CoinImageService (image handling)
   - MarketDataService (market data)
   - PortfolioDataService (portfolio operations)

5. **Extensions**
   - ColorTheme (custom theming)
   - Date (date formatting)
   - Double (number formatting)
   - String (text manipulation)
   - UIApplication (app utilities) 