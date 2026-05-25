class Mcpal < Formula
  desc "mcpal — CLI for the Model Context Protocol."
  homepage "https://pawelb0.github.io/mcpal/"
  version "0.4.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/pawelb0/mcpal/releases/download/v0.4.0/mcpal-aarch64-apple-darwin.tar.xz"
      sha256 "88517a10d8b0f3ef7ae737960fbef4273a90c44ad3131fffbfd483025904a0b6"
    end
    if Hardware::CPU.intel?
      url "https://github.com/pawelb0/mcpal/releases/download/v0.4.0/mcpal-x86_64-apple-darwin.tar.xz"
      sha256 "4a65bb3b8d7757c68c4a0cc5670d052b5d586940242dce6c90c45583a1d9a22d"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/pawelb0/mcpal/releases/download/v0.4.0/mcpal-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "82c7a6a7efe21e82b754c360c1508e68cb1bab127278aee1784bb02a5d9ea1ef"
    end
    if Hardware::CPU.intel?
      url "https://github.com/pawelb0/mcpal/releases/download/v0.4.0/mcpal-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "c57525302cae3927355797237625325c35be50d0c0b25bc5556328787a752b24"
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
