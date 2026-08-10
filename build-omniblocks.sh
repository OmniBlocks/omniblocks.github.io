set -euo pipefail
 
echo "::group::Cloning repository"
git clone https://github.com/OmniBlocks/monorepo --depth=1
cd monorepo
echo "::endgroup::"
 
echo "::group::Building"
echo "::group::Installing dependencies"
pnpm i --shamefully-hoist --no-frozen-lockfile 
echo "::endgroup::"

echo "::group::Building editor"
cd scratch-gui
ROOT=/ NODE_ENV=production pnpm build
cd ..
echo "::endgroup::"

echo "::group::Building extensions gallery"
cd extensions
pnpm build
cd ..
echo "::endgroup::"

echo "::group::Adding gallery to Pages artifact"
mkdir -p scratch-gui/build/extensions
cp -a extensions/build/. scratch-gui/build/extensions/
echo "::endgroup::"
