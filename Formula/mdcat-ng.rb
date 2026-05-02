class MdcatNg < Formula
  desc "Cat for markdown: show markdown documents in terminals"
  homepage "https://github.com/pawelb0/mdcat-ng"
  version "0.2.2"
  license "MPL-2.0"

  on_macos do
    on_arm do
      url "https://github.com/pawelb0/mdcat-ng/releases/download/mdcat-ng-#{version}/mdcat-ng-#{version}-aarch64-apple-darwin.tar.gz"
      sha256 "4b34035db0f82a7c8dc47d48e724cf7886c7cfa38af6982c15d62576aca343f1"
    end
    on_intel do
      url "https://github.com/pawelb0/mdcat-ng/releases/download/mdcat-ng-#{version}/mdcat-ng-#{version}-x86_64-apple-darwin.tar.gz"
      sha256 "73c2832899cb14bd8c535c416e552c758451ae98ca5cca9f3e1c78813a7c2298"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/pawelb0/mdcat-ng/releases/download/mdcat-ng-#{version}/mdcat-ng-#{version}-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "05d73acda508336301ab02fd9943dd45a1c808ada468fb039de1c56c8b9eef5d"
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
