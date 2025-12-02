echo "::group::Cloning repositories"
git clone https://github.com/OmniBlocks/scratch-gui --depth=1
git clone https://github.com/OmniBlocks/scratch-blocks --depth=1
echo "::endgroup::"

echo "::group::Fetching version from scratch-gui"
cd scratch-gui
# Fetch all tags
git fetch --tags --unshallow 2>/dev/null || git fetch --tags
# Get the latest tag by version sort (not by reachability)
if git tag -l 'v*' >/dev/null 2>&1; then
    export APP_VERSION=$(git tag | sort -V | tail -n1)
else
    export APP_VERSION="v0.6.0-alpha"
fi
echo "Using version: $APP_VERSION"
cd ..
echo "::endgroup::"

echo "::group::Build scratch-blocks"
cd scratch-blocks
git branch developBuilds
npm ci
cd ..
echo "::endgroup::"

echo "::group::Build scratch-gui"
cd scratch-gui
npm ci
npm link ../scratch-blocks
echo "🚀 Building with APP_VERSION=$APP_VERSION"
# Explicitly pass APP_VERSION to npm
APP_VERSION="$APP_VERSION" NODE_ENV=production npm run build
echo "::endgroup::"
