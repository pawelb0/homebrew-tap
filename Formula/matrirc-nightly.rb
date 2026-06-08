class MatrircNightly < Formula
  desc "Local IRC server that bridges to a Matrix homeserver (nightly)"
  homepage "https://github.com/pawelb0/matrirc"
  version "0.3.0-nightly.20260608002647.695cec0"
  license "GPL-3.0-or-later"

  # Not linked by default: stable matrirc owns bin/matrirc.
  # Switch with: brew link --overwrite matrirc-nightly
  keg_only "it conflicts with the stable matrirc formula"

  on_macos do
    on_arm do
      url "https://github.com/pawelb0/matrirc/releases/download/nightly/matrirc-aarch64-apple-darwin.tar.xz"
      sha256 "459ec36a79acf25c5b17796b96ab7ab7f8e21e31c1aa067aae8444f254359a57"
    end
    on_intel do
      url "https://github.com/pawelb0/matrirc/releases/download/nightly/matrirc-x86_64-apple-darwin.tar.xz"
      sha256 "b4372c7027553ef1261ed551cc73777d1aeb57e43971a1321f209b094b5eaf26"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/pawelb0/matrirc/releases/download/nightly/matrirc-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "935b2706aec2be47a86ec1e26d261c61f4f16aff89ace22f81d401be7b3b1428"
    end
  end

  def install
    bin.install "matrirc"
  end

  test do
    system bin/"matrirc", "--version"
  end
end
