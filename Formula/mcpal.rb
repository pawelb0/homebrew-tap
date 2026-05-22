class Mcpal < Formula
  desc "mcpal — CLI for the Model Context Protocol."
  homepage "https://pawelb0.github.io/mcpal/"
  version "0.3.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/pawelb0/mcpal/releases/download/v0.3.0/mcpal-aarch64-apple-darwin.tar.xz"
      sha256 "42deea2985987057458f1b270fb02cb620686496325b4a20a6a8c8d07e9d0a05"
    end
    if Hardware::CPU.intel?
      url "https://github.com/pawelb0/mcpal/releases/download/v0.3.0/mcpal-x86_64-apple-darwin.tar.xz"
      sha256 "d7e27c83f4dc1b680ebe31cbb7984ad9152a70d4d7aa1427edd574fa3bb44d62"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/pawelb0/mcpal/releases/download/v0.3.0/mcpal-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "ee903ccafa48750242156b9cdca745cbf13048a3e666a4a478f984c6d27776d0"
    end
    if Hardware::CPU.intel?
      url "https://github.com/pawelb0/mcpal/releases/download/v0.3.0/mcpal-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "5fa783d684007e451b8995276b82a86d39360f0b5b2d5ffc84f2da28259715b5"
    end
  end
  license "MIT"

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
    bin.install "mcpal" if OS.mac? && Hardware::CPU.arm?
    bin.install "mcpal" if OS.mac? && Hardware::CPU.intel?
    bin.install "mcpal" if OS.linux? && Hardware::CPU.arm?
    bin.install "mcpal" if OS.linux? && Hardware::CPU.intel?

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
