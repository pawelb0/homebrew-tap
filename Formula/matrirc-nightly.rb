class MatrircNightly < Formula
  desc "Local IRC server that bridges to a Matrix homeserver (nightly)"
  homepage "https://github.com/pawelb0/matrirc"
  version "0.3.0-nightly.20261005021134.8586af8"
  license "GPL-3.0-or-later"

  # Not linked by default: stable matrirc owns bin/matrirc.
  # Switch with: brew link --overwrite matrirc-nightly
  keg_only "it conflicts with the stable matrirc formula"

  on_macos do
    on_arm do
      url "https://github.com/pawelb0/matrirc/releases/download/nightly/matrirc-aarch64-apple-darwin.tar.xz"
      sha256 "a7d33534c31ad99c23df333450e7588d7302ea5ad80a2bffda2b2741dedb4a02"
    end
    on_intel do
      url "https://github.com/pawelb0/matrirc/releases/download/nightly/matrirc-x86_64-apple-darwin.tar.xz"
      sha256 "a6f9f999727f1f7224672986a75868340f6c70a784c3836c9b4b0c35ef60e2e8"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/pawelb0/matrirc/releases/download/nightly/matrirc-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "1c1cd4e7ae865294044e3815ac7be783a1b54e5bc1f1499776f25186471db697"
    end
  end

  def install
    bin.install "matrirc"
  end

  test do
    system bin/"matrirc", "--version"
  end
end
