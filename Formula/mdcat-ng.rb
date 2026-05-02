class MdcatNg < Formula
  desc "Cat for markdown: show markdown documents in terminals"
  homepage "https://github.com/pawelb0/mdcat-ng"
  version "0.2.3"
  license "MPL-2.0"

  on_macos do
    on_arm do
      url "https://github.com/pawelb0/mdcat-ng/releases/download/mdcat-ng-#{version}/mdcat-ng-#{version}-aarch64-apple-darwin.tar.gz"
      sha256 "26afcf7145174186b2ee28dbe5574faf7d35a3d64f0c797d830f6475bcc4760b"
    end
    on_intel do
      url "https://github.com/pawelb0/mdcat-ng/releases/download/mdcat-ng-#{version}/mdcat-ng-#{version}-x86_64-apple-darwin.tar.gz"
      sha256 "8a982d7719990f852ef0fc3cb097e21d795841b119eec5b2d0b1a3fefd9ed985"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/pawelb0/mdcat-ng/releases/download/mdcat-ng-#{version}/mdcat-ng-#{version}-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "31c708d5f231b2e94f7dd938a672f3248df9ea99efaab2cf1456073301e5d029"
    end
  end

  def install
    bin.install "mdcat", "mdless"
    doc.install "README.md", "CHANGELOG.md"
  end

  test do
    assert_match "Hello", pipe_output("#{bin}/mdcat", "# Hello\n")
  end
end
