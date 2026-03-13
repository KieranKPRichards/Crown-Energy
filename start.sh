#!/bin/bash
echo "============================================"
echo " Crown Energy Meter Reporting Application"
echo "============================================"
echo

# Find Python 3
PYTHON=""
for cmd in python3 python; do
    if command -v "$cmd" &> /dev/null; then
        ver=$("$cmd" --version 2>&1)
        if echo "$ver" | grep -q "Python 3"; then
            PYTHON="$cmd"
            break
        fi
    fi
done

if [ -z "$PYTHON" ]; then
    echo "ERROR: Python 3 is not installed."
    echo "Install with: brew install python3 (Mac) or sudo apt install python3 (Linux)"
    exit 1
fi
echo "Using: $($PYTHON --version)"

# Create virtual environment if it doesn't exist
if [ ! -d "venv" ]; then
    echo "Creating virtual environment..."
    $PYTHON -m venv venv
fi

# Activate virtual environment
source venv/bin/activate

# Install dependencies
echo "Installing dependencies..."
pip install -r requirements.txt --quiet

echo
echo "Starting application..."
echo "Open your browser to: http://localhost:5000"
echo
python app.py
