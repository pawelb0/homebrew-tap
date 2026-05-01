class Mdqy < Formula
  desc "jq for markdown: query and transform Markdown with a hybrid selector and jq DSL"
  homepage "https://github.com/pawelb0/mdqy"
  version "0.1.4"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/pawelb0/mdqy/releases/download/v0.1.4/mdqy-aarch64-apple-darwin.tar.xz"
      sha256 "9cfd1208160252e585b876341c9069676c21cfc4ae234e08157363358ab7110d"
    end
    if Hardware::CPU.intel?
      url "https://github.com/pawelb0/mdqy/releases/download/v0.1.4/mdqy-x86_64-apple-darwin.tar.xz"
      sha256 "5509151d624506a9ec762506591422533aa6b1fb55653fe0758ec0bae5746356"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/pawelb0/mdqy/releases/download/v0.1.4/mdqy-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "0863133a10e2a93a4dbf712c5c9d2f68e7ce088faf060339c5278d6cbf7e1149"
    end
    if Hardware::CPU.intel?
      url "https://github.com/pawelb0/mdqy/releases/download/v0.1.4/mdqy-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "54bab15675f9ea6ed379f434a90dfb65af645a573a55851aeb4f7cc35d57bed2"
    end
  end
  license "MPL-2.0"

  BINARY_ALIASES = {
    "aarch64-apple-darwin":      {},
    "aarch64-unknown-linux-gnu": {},
    "x86_64-apple-darwin":       {},
    "x86_64-pc-windows-gnu":     {},
    "x86_64-unknown-linux-gnu":  {},
  }.freeze

  def target_triple
    cpu = Hardware::CPU.arm? ? "aarch64" : "x86_64"
    os = OS.mac? ? "apple-darwin" : "unknown-linux-gnu"

    "#{cpu}-#{os}"
  end

  def install_binary_aliases!
    BINARY_ALIASES[target_triple.to_sym].each do |source, dests|
      dests.each do |dest|
        bin.install_symlink bin/source.to_s => dest
      end
    end
  end

  def install
    bin.install "mdqy" if OS.mac? && Hardware::CPU.arm?
    bin.install "mdqy" if OS.mac? && Hardware::CPU.intel?
    bin.install "mdqy" if OS.linux? && Hardware::CPU.arm?
    bin.install "mdqy" if OS.linux? && Hardware::CPU.intel?

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
