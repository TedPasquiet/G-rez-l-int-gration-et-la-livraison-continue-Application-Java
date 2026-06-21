#!/bin/bash

# Script to run Java tests and generate JUnit XML report for GitLab CI

# Check that java is installed
if ! command -v java &>/dev/null; then
    echo "Error: java is not installed"
    exit 1
fi

# Check that gradlew exists
if [ ! -f "./gradlew" ]; then
    echo "Error: gradlew not found"
    exit 1
fi

# Make gradlew executable
chmod +x ./gradlew

# Clean previous test results
rm -rf test-results

# Run tests with Gradle
./gradlew clean test
TEST_EXIT_CODE=$?

# Copy JUnit reports to test-results folder
# Gradle generates JUnit XML reports in build/test-results/test/
mkdir -p test-results
cp -r build/test-results/test/. test-results/

# Exit with the test exit code so GitLab CI knows if tests passed or failed
exit $TEST_EXIT_CODE
