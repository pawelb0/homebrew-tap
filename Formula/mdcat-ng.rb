class MdcatNg < Formula
  desc "Cat for markdown: show markdown documents in terminals"
  homepage "https://github.com/pawelb0/mdcat-ng"
  version "0.2.1"
  license "MPL-2.0"

  on_macos do
    on_arm do
      url "https://github.com/pawelb0/mdcat-ng/releases/download/mdcat-ng-#{version}/mdcat-ng-#{version}-aarch64-apple-darwin.tar.gz"
      sha256 "d8fe481f148c803f95550528e3b8f9e38b64146a3edc1b6a29d3374397228940"
    end
    on_intel do
      url "https://github.com/pawelb0/mdcat-ng/releases/download/mdcat-ng-#{version}/mdcat-ng-#{version}-x86_64-apple-darwin.tar.gz"
      sha256 "eef9dbaa347dd4b89b5b34fa9f91896f48eb1191274d2f855f349913b1a4e371"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/pawelb0/mdcat-ng/releases/download/mdcat-ng-#{version}/mdcat-ng-#{version}-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "2758519044ea937d1637c425e70e219a5fe865dcda078205f7d3e946cdd306bf"
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
