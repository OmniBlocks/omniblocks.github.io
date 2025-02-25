echo "::group::Cloning repositories"
git clone https://github.com/OmniBlocks/scratch-gui --depth=1
git clone https://github.com/OmniBlocks/scratch-vm --depth=1
git clone https://github.com/OmniBlocks/scratch-blocks --depth=1
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
npm run build
echo "::endgroup::"
