echo "::group::Cloning repositories"
git clone https://github.com/OmniBlocks/scratch-gui --depth=1
git clone https://github.com/OmniBlocks/scratch-vm --depth=1
git clone https://github.com/OmniBlocks/scratch-blocks --depth=1
echo "::endgroup::"

echo "::group::Fetching version from scratch-gui"
cd scratch-gui
# Fetch tags since --depth=1 doesn't include them
git fetch --tags --depth=1
if git describe --tags --abbrev=0 >/dev/null 2>&1; then
    export APP_VERSION=$(git describe --tags --abbrev=0)
else
    export APP_VERSION="v0.5.8-alpha"  # fallback
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

echo "::group::Build scratch-vm"
cd scratch-vm
npm ci
cd ..
echo "::endgroup::"

echo "::group::Build scratch-gui"
cd scratch-gui
npm ci
npm link ../scratch-vm
npm link ../scratch-blocks
echo "🚀 Building with APP_VERSION=$APP_VERSION"
# Explicitly pass APP_VERSION to npm
APP_VERSION="$APP_VERSION" npm run build
echo "::endgroup::"
