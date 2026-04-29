class Mdqy < Formula
  desc "jq for markdown: query and transform Markdown with a hybrid selector and jq DSL"
  homepage "https://github.com/pawelb0/mdqy"
  version "0.1.3"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/pawelb0/mdqy/releases/download/v0.1.3/mdqy-aarch64-apple-darwin.tar.xz"
      sha256 "dde653464aef7e1c72e75727de8c4478807e310649a68909d96b50d41f5630b8"
    end
    if Hardware::CPU.intel?
      url "https://github.com/pawelb0/mdqy/releases/download/v0.1.3/mdqy-x86_64-apple-darwin.tar.xz"
      sha256 "154ae88b00e9b8c9b017d1894efed739258fd482a50480c578fa54412e28227f"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/pawelb0/mdqy/releases/download/v0.1.3/mdqy-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "d6b995292d15ebbc2828e4c2eeeddb364ccac8e30ef4c8f58357352cb22c67ae"
    end
    if Hardware::CPU.intel?
      url "https://github.com/pawelb0/mdqy/releases/download/v0.1.3/mdqy-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "519aa5c11c7dce31acfbfb4aba8161e50da3b5fdc05e1655ac4efe5ae6a04be1"
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
