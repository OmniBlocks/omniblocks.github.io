echo "::group::Cloning repository"
git clone https://github.com/OmniBlocks/monorepo --depth=1
echo "::endgroup::"

echo "::group::Building"
pnpm i
cd scratch-gui
echo "🚀 Building with APP_VERSION=$APP_VERSION"
# Explicitly pass APP_VERSION to npm
ROOT=/ NODE_ENV=production pnpm build
echo "::endgroup::"
