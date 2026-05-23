class Mcpal < Formula
  desc "mcpal — CLI for the Model Context Protocol."
  homepage "https://pawelb0.github.io/mcpal/"
  version "0.3.1"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/pawelb0/mcpal/releases/download/v0.3.1/mcpal-aarch64-apple-darwin.tar.xz"
      sha256 "0b36958205ae9a4003a0ebc2ce51df1b6ef88d1b8a7500aa1d226fa3b2c18218"
    end
    if Hardware::CPU.intel?
      url "https://github.com/pawelb0/mcpal/releases/download/v0.3.1/mcpal-x86_64-apple-darwin.tar.xz"
      sha256 "5cd8a943818c1813f64ad697fac77a9b5e92d13431faf5b07078752d9b10a1c1"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/pawelb0/mcpal/releases/download/v0.3.1/mcpal-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "aadd244208f4ef11dcbe2f93fc70f5383110fdda6aed488c3ed625330b615877"
    end
    if Hardware::CPU.intel?
      url "https://github.com/pawelb0/mcpal/releases/download/v0.3.1/mcpal-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "660849f18b979c09a3c889d8c0c4b5d1402c20d0919c530218f519d73c7a85ab"
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
