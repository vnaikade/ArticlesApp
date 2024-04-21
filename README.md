# Image Grid Project in Swift

## Overview
This project demonstrates a Swift-based application that implements a 3-column square image grid. The grid displays images with center-cropping, and asynchronous image loading is utilized to fetch images from a given API. The project includes a caching mechanism for efficient image retrieval and robust error handling to manage potential issues during image loading.

## Table of Contents
1. [Getting Started](#getting-started)
2. [Installation](#installation)
3. [Usage](#usage)
4. [Key Features](#key-features)
5. [Caching Strategy](#caching-strategy)
6. [Error Handling](#error-handling)

## Getting Started
To get started with this project, ensure that you have the necessary development environment set up. The project is developed using Swift and requires Xcode for iOS development.

### Prerequisites
- Xcode (latest version recommended)
- Swift (latest version compatible with your Xcode version)
- Internet connection (for fetching images from the API)

### Installation
To install and run the project locally, follow these steps:

1. Clone the repository to your local machine:
   ```bash
   git clone https://github.com/vnaikade/ArticlesApp.git

2. open image-grid-project.xcodeproj
3. Build and run the project on a simulator or connected device

### Usage
The project displays a 3-column square image grid that fetches images from an API asynchronously. The user can scroll through at least 100 images. The images are loaded and cached in memory and disk for efficient retrieval.

### Key Features
- 3-Column Square Image Grid: Images are displayed in a scrollable grid with center-cropping.
- Asynchronous Image Loading: Images are fetched from an API asynchronously to improve performance.
- Caching: A caching mechanism is used to store images in memory and on disk for faster retrieval.
- Error Handling: The application gracefully handles network errors and image loading failures.

### Caching Strategy
The project implements a caching mechanism to improve image retrieval efficiency. The caching strategy includes:
- Memory Cache: Images are cached in memory for quick access.
- Disk Cache: Images are cached on disk for persistent storage and to reduce network requests.

### Error Handling
The application includes robust error handling to manage potential issues during image loading. When a network error occurs, or an image fails to load, the app displays informative error messages or placeholders.
