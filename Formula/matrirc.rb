class Matrirc < Formula
  desc "Local IRC server backed by Matrix"
  homepage "https://github.com/pawelb0/matrirc"
  version "0.2.7"
  license "GPL-3.0-or-later"
  head "https://github.com/pawelb0/matrirc.git", branch: "main"

  on_macos do
    on_arm do
      url "https://github.com/pawelb0/matrirc/releases/download/v#{version}/matrirc-#{version}-aarch64-apple-darwin.tar.gz"
      sha256 "ecacbc695eb24110b427110abe09465207c4d41911e6490331139f149af23621"
    end
    on_intel do
      url "https://github.com/pawelb0/matrirc/releases/download/v#{version}/matrirc-#{version}-x86_64-apple-darwin.tar.gz"
      sha256 "05d07924cd67c30afeb57fc68f0e7793d807fa9a3cf81871f47faedb0f2b5e06"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/pawelb0/matrirc/releases/download/v#{version}/matrirc-#{version}-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "bd7c69a64e9ca4ee4f122fc0eedfb856f9c3357a5a111b311dd602aa41c13f12"
    end
  end

  def install
    bin.install "matrirc"
  end

  test do
    assert_match "matrirc", shell_output("#{bin}/matrirc --help")
  end
end
