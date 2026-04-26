class Matrirc < Formula
  desc "Local IRC server backed by Matrix"
  homepage "https://github.com/pawelb0/matrirc"
  version "0.2.6"
  license "GPL-3.0-or-later"
  head "https://github.com/pawelb0/matrirc.git", branch: "main"

  on_macos do
    on_arm do
      url "https://github.com/pawelb0/matrirc/releases/download/v#{version}/matrirc-0.2.5-aarch64-apple-darwin.tar.gz"
      sha256 "c8434d8d0599c02693b227bb6ba2e0295f54d3d4d68e12eb8dc7a7869defc18c"
    end
    on_intel do
      url "https://github.com/pawelb0/matrirc/releases/download/v#{version}/matrirc-0.2.5-x86_64-apple-darwin.tar.gz"
      sha256 "7ac081da89c60917d0acc100d2803a368513ea3bf77194500f0200277589db51"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/pawelb0/matrirc/releases/download/v#{version}/matrirc-0.2.5-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "cdba9d8506ceacd13ca2c736e8f08007c45e6b941ea317b9ab6a15a4bb48bf96"
    end
  end

  def install
    bin.install "matrirc"
  end

  test do
    assert_match "matrirc", shell_output("#{bin}/matrirc --help")
  end
end
