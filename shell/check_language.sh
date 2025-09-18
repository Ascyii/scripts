#!/bin/bash

# List programming languages based on common installation paths

echo "Programming languages installed on your system:"

# Check if Python is installed
if command -v python3 &>/dev/null; then
	echo "- Python"
fi

# Check if Ruby is installed
if command -v ruby &>/dev/null; then
	echo "- Ruby"
fi

# Check if Node.js is installed
if command -v node &>/dev/null; then
	echo "- Node.js"
fi

# Check if Java is installed
if command -v java &>/dev/null; then
	echo "- Java"
fi

# Check if Go is installed
if command -v go &>/dev/null; then
	echo "- Go"
fi

# Check if PHP is installed
if command -v php &>/dev/null; then
	echo "- PHP"
fi

# Check if Rust is installed
if command -v rustc &>/dev/null; then
	echo "- Rust"
fi

# Check if C compiler is installed (GCC)
if command -v gcc &>/dev/null; then
	echo "- C"
fi

# Check if C++ compiler is installed (g++)
if command -v g++ &>/dev/null; then
	echo "- C++"
fi

# Add more checks for other languages as needed

echo "End of list."
