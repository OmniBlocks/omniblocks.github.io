echo "::group::Cloning repository"
git clone https://github.com/UltiBlocks/scratch-gui --depth=1
echo "::endgroup::"
echo "::group::Install scratch-gui"
cd scratch-gui
npm ci
echo "::endgroup::"
echo "::group::Build scratch-gui"
npm run build
echo "::endgroup::"
