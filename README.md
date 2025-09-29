# SuperBlink Lab 2 - HiFive1 RevB LED Control Project

![RISC-V](https://img.shields.io/badge/RISC--V-32bit-blue)
![PlatformIO](https://img.shields.io/badge/PlatformIO-Compatible-orange)
![License](https://img.shields.io/badge/License-MIT-green)

## 🔗 Repository
**GitHub**: [https://github.com/JEER11/SuperBlink-lab2-.git](https://github.com/JEER11/SuperBlink-lab2-.git)

## 📋 Overview
This project implements LED control functionality for the HiFive1 RevB board using RISC-V assembly and C programming. The program cycles through RGB LEDs creating a "super blink" pattern.

## 🏗️ Project Structure
```
Lab2/
├── platformio.ini          # PlatformIO configuration
├── Makefile               # Alternative build system
├── src/
│   ├── main.c            # Main program - cycles through RGB LEDs
│   ├── header.h          # Function declarations and constants
│   ├── gpio.c            # C implementation of GPIO functions
│   ├── gpio.S            # Assembly implementation of GPIO functions
│   ├── GPIO.inc          # GPIO register definitions
│   └── memoryMap.inc     # Memory map definitions
├── include/
├── lib/
└── test/
```

## ⚡ Functionality
The program implements the following features:

### 🔧 GPIO Setup (`setupGPIO()`)
- Configures RGB LED pins as outputs
- Initializes all LEDs to OFF state

### 💡 LED Control (`setLED(color, state)`)
- Controls individual LEDs (Red, Blue, Green)
- **Parameters**: color (LED mask), state (ON/OFF)
- **Returns**: 0 on success, -1 on error

### ⏱️ Delay Function (`delay(milliseconds)`)
- Provides timing delays using the MTIME register
- **Parameter**: delay time in milliseconds

### 🌈 Main Program
- Cycles through **Green → Blue → Red** LEDs
- Each LED stays on for **200ms**, then off for **200ms**
- Continues indefinitely until an error occurs

## 🔌 Hardware Definitions
| Component | GPIO Pin | Hex Value |
|-----------|----------|-----------|
| **Red LED** | 22 | `0x400000` |
| **Blue LED** | 21 | `0x200000` |
| **Green LED** | 19 | `0x080000` |

| Memory Map | Address |
|------------|---------|
| **GPIO Base** | `0x10012000` |
| **MTIME** | `0x0200BFF8` |

## 🚀 Building the Project

### Using PlatformIO (Recommended)
```bash
# Build the project
pio run

# Build and upload to board
pio run --target upload
```

### Using Makefile (Alternative)
```bash
# Build the project
make

# Clean build files
make clean
```

## 📦 Requirements
- **Hardware**: HiFive1 RevB development board
- **Software**: PlatformIO or RISC-V GNU toolchain
- **SDK**: Freedom E SDK (included with PlatformIO sifive platform)

## 🔧 Implementation Notes
- Two implementations provided: **C** (`gpio.c`) and **Assembly** (`gpio.S`)
- C implementation is used by default
- Memory-mapped I/O for GPIO control
- MTIME register for precise timing delays

## 📄 License
This project is open source and available under the [MIT License](LICENSE).

## 🤝 Contributing
Feel free to submit issues and enhancement requests!

---
**Developed for RISC-V embedded systems programming**