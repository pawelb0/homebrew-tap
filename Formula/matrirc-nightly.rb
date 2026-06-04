class MatrircNightly < Formula
  desc "Local IRC server that bridges to a Matrix homeserver (nightly)"
  homepage "https://github.com/pawelb0/matrirc"
  version "0.3.0-nightly.20260604095920.d33af66"
  license "GPL-3.0-or-later"

  # Not linked by default: stable matrirc owns bin/matrirc.
  # Switch with: brew link --overwrite matrirc-nightly
  keg_only "it conflicts with the stable matrirc formula"

  on_macos do
    on_arm do
      url "https://github.com/pawelb0/matrirc/releases/download/nightly/matrirc-aarch64-apple-darwin.tar.xz"
      sha256 "89b88a9b161e1b5f4b2eed4e1902489352e8538b9e330edb7f6bca25e5235d51"
    end
    on_intel do
      url "https://github.com/pawelb0/matrirc/releases/download/nightly/matrirc-x86_64-apple-darwin.tar.xz"
      sha256 "83ea3801549047a43ea2512248aff358c1ce2b6a3ce5017ef9752f77ea984d36"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/pawelb0/matrirc/releases/download/nightly/matrirc-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "0893b922aec0f934c78038b255dd6becc93c2256e59900347b4989511457c94f"
    end
  end

  def install
    bin.install "matrirc"
  end

  test do
    system bin/"matrirc", "--version"
  end
end
