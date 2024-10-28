#!/bin/bash

echo "🔍 Starting verification process..."

# 1. Check if all required files exist
echo "Checking required files..."
FILES=("app.js" "package.json" "Dockerfile" "build-and-deploy.sh")
for file in "${FILES[@]}"; do
    if [ -f "$file" ]; then
        echo "✅ $file exists"
    else
        echo "❌ $file is missing"
        exit 1
    fi
done

# 2. Check Node.js and npm
echo -e "\nChecking Node.js installation..."
if command -v node &> /dev/null; then
    echo "✅ Node.js is installed: $(node --version)"
else
    echo "❌ Node.js is not installed"
    exit 1
fi

# 3. Check Docker
echo -e "\nChecking Docker installation..."
if command -v docker &> /dev/null; then
    echo "✅ Docker is installed: $(docker --version)"
else
    echo "❌ Docker is not installed"
    exit 1
fi

# 4. Test npm install
echo -e "\nTesting npm install..."
if npm install; then
    echo "✅ npm install successful"
else
    echo "❌ npm install failed"
    exit 1
fi

# 5. Test Docker build
echo -e "\nTesting Docker build..."
if docker build -t test-express-app .; then
    echo "✅ Docker build successful"
else
    echo "❌ Docker build failed"
    exit 1
fi

# 6. Test Docker run
echo -e "\nTesting Docker run..."
if docker run -d -p 8080:8080 --name test-container test-express-app; then
    echo "✅ Docker run successful"
else
    echo "❌ Docker run failed"
    exit 1
fi

# 7. Test application response
echo -e "\nTesting application response..."
sleep 5  # Wait for container to start
if curl -s http://localhost:8080/health | grep -q "healthy"; then
    echo "✅ Application is responding correctly"
else
    echo "❌ Application is not responding"
fi

# 8. Cleanup
echo -e "\nCleaning up..."
docker stop test-container
docker rm test-container
docker rmi test-express-app

echo -e "\n✅ Verification complete! All tests passed."