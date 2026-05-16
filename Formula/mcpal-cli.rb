class McpalCli < Formula
  desc "mcpal — CLI for the Model Context Protocol."
  homepage "https://pawelb0.github.io/mcpal/"
  version "0.1.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/pawelb0/mcpal/releases/download/v0.1.0/mcpal-cli-aarch64-apple-darwin.tar.xz"
      sha256 "5ed7d5caeb89355ec336793848bad5ef895f5e0bee346433a6e35344ccbfe87d"
    end
    if Hardware::CPU.intel?
      url "https://github.com/pawelb0/mcpal/releases/download/v0.1.0/mcpal-cli-x86_64-apple-darwin.tar.xz"
      sha256 "0a719b1b74ca5ccc93a5e63124efb4a98aecf292bd4f7f69c306b084e7874403"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/pawelb0/mcpal/releases/download/v0.1.0/mcpal-cli-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "edbf2904710712b909be995abfe5cc42dee3c9621107185228d60ad02d979f55"
    end
    if Hardware::CPU.intel?
      url "https://github.com/pawelb0/mcpal/releases/download/v0.1.0/mcpal-cli-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "3c85ea1816d3ff7c84c33f84095ff7cd5bf1b1ce8609a323c05e6b02f60e7c2f"
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
