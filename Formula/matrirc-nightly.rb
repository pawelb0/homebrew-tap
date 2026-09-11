class MatrircNightly < Formula
  desc "Local IRC server that bridges to a Matrix homeserver (nightly)"
  homepage "https://github.com/pawelb0/matrirc"
  version "0.3.0-nightly.20260911165359.b20829b"
  license "GPL-3.0-or-later"

  # Not linked by default: stable matrirc owns bin/matrirc.
  # Switch with: brew link --overwrite matrirc-nightly
  keg_only "it conflicts with the stable matrirc formula"

  on_macos do
    on_arm do
      url "https://github.com/pawelb0/matrirc/releases/download/nightly/matrirc-aarch64-apple-darwin.tar.xz"
      sha256 "f36afaf4401c26732048a462ba481810f073e8f02023dd2c40c8718f66fc529e"
    end
    on_intel do
      url "https://github.com/pawelb0/matrirc/releases/download/nightly/matrirc-x86_64-apple-darwin.tar.xz"
      sha256 "35daf328acfd079737a75aa83840580ddaaa8017e36265f711c3de60c07431ca"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/pawelb0/matrirc/releases/download/nightly/matrirc-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "572b02e86a4da97db71ea1d221a15c92a0b1e90e186f8d2d78813b9909bf51b1"
    end
  end

  def install
    bin.install "matrirc"
  end

  test do
    system bin/"matrirc", "--version"
  end
end
