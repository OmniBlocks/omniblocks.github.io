set -euo pipefail

echo "::group::Cloning repository"
git clone https://github.com/OmniBlocks/monorepo --depth=1
cd monorepo
echo "::endgroup::"

echo "::group::Building"
pnpm i --shamefully-hoist
cd scratch-gui
ROOT=/ NODE_ENV=production pnpm build
echo "::endgroup::"
