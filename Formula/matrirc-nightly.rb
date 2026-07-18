class MatrircNightly < Formula
  desc "Local IRC server that bridges to a Matrix homeserver (nightly)"
  homepage "https://github.com/pawelb0/matrirc"
  version "0.3.0-nightly.20260718161733.f3df588"
  license "GPL-3.0-or-later"

  # Not linked by default: stable matrirc owns bin/matrirc.
  # Switch with: brew link --overwrite matrirc-nightly
  keg_only "it conflicts with the stable matrirc formula"

  on_macos do
    on_arm do
      url "https://github.com/pawelb0/matrirc/releases/download/nightly/matrirc-aarch64-apple-darwin.tar.xz"
      sha256 "b891d6576629bbb1adf164d0e6f0b765e774b5ebc19473b46e560e25820be823"
    end
    on_intel do
      url "https://github.com/pawelb0/matrirc/releases/download/nightly/matrirc-x86_64-apple-darwin.tar.xz"
      sha256 "4956441429afa70f8a08e96d0c3df98ee379864430ffe3d0f7fb248cb19fce77"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/pawelb0/matrirc/releases/download/nightly/matrirc-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "cbcf0ade8052a97d0c9aebd2a31a278a35f79891f977ea05aa45e57b5f8d91d4"
    end
  end

  def install
    bin.install "matrirc"
  end

  test do
    system bin/"matrirc", "--version"
  end
end
