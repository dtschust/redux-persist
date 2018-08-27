#!/bin/sh

echo "Verifying that assets are built and committed before pushing..."

# Build all distribution assets
npm run build > /dev/null 2> /dev/null

# Add build assets
git add ./es ./lib ./dist

# Check for changes in the build directories
git diff-index --quiet HEAD ./es ./lib ./dist

noChanges=$?

if [ $noChanges -eq 0 ]
then
	echo "Verification complete. Pushing now"
	exit 0
else
	# Commit build assets only, do not commit any staged changes in any other directories
	git commit -m"Build assets" --quiet -- es lib dist
	echo "\033[1;31mError: new assets built and committed. Please push again, it will work this time. You'd think I could do it for you, but it's surprisingly complicated. Just hit up and enter please. I love you.\033[0m"
	exit 1
fi