{
  version ? "1.98.1.0",
  url ? "https://github.com/esp-rs/rust-build/releases/download/v${version}/rust-src-${version}.tar.xz",
  hash ? "sha256-wZ5aQKYl32SEVKlyovsvMDFE1CcEraeHzco6D1nKDMw=",

  lib,
  stdenv,
  fetchurl,
  zlib,
}:
stdenv.mkDerivation rec {
  pname = "esp-rust-src";
  inherit version;

  src = fetchurl {
    inherit url hash;
  };

  installPhase = ''
    patchShebangs install.sh
    CFG_DISABLE_LDCONFIG=1 ./install.sh --prefix=$out

    rm $out/lib/rustlib/{components,install.log,manifest-*,rust-installer-version,uninstall.sh} || true
  '';
  dontStrip = true;
}
