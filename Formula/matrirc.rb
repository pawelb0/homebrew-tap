class Matrirc < Formula
  desc "Local IRC server that bridges to a Matrix homeserver"
  homepage "https://github.com/pawelb0/matrirc"
  version "0.2.9"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/pawelb0/matrirc/releases/download/v0.2.9/matrirc-aarch64-apple-darwin.tar.xz"
      sha256 "c60a8b444e9e805c7d61cce58fa58ac37d44eb0ac115b4354ca16f0e223a850d"
    end
    if Hardware::CPU.intel?
      url "https://github.com/pawelb0/matrirc/releases/download/v0.2.9/matrirc-x86_64-apple-darwin.tar.xz"
      sha256 "13cb5ae2ed66efb3efc2dcd1ba8ad2ef538a0146166f2e04cedf105ea9835922"
    end
  end
  if OS.linux? && Hardware::CPU.intel?
    url "https://github.com/pawelb0/matrirc/releases/download/v0.2.9/matrirc-x86_64-unknown-linux-gnu.tar.xz"
    sha256 "81cecc90c9c4992b9571a1e8b04a71582d539a64b3722838e6cb8fe330e968d3"
  end
  license "GPL-3.0-or-later"

  BINARY_ALIASES = {
    "aarch64-apple-darwin":     {},
    "x86_64-apple-darwin":      {},
    "x86_64-unknown-linux-gnu": {},
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
    bin.install "matrirc" if OS.mac? && Hardware::CPU.arm?
    bin.install "matrirc" if OS.mac? && Hardware::CPU.intel?
    bin.install "matrirc" if OS.linux? && Hardware::CPU.intel?

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
