echo "::group::Cloning repositories"
git clone https://github.com/UltiBlocks/scratch-gui --depth=1
git clone https://github.com/UltiBlocks/scratch-vm --depth=1
git clone https://github.com/UltiBlocks/scratch-blocks --depth=1
echo "::endgroup::"
echo "::group::Build scratch-blocks"
cd scratch-blocks
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
