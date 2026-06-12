class Mcpal < Formula
  desc "mcpal — CLI for the Model Context Protocol."
  homepage "https://pawelb0.github.io/mcpal/"
  version "0.4.3"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/pawelb0/mcpal/releases/download/v0.4.3/mcpal-aarch64-apple-darwin.tar.xz"
      sha256 "7b0e94c4a35a1270f53db918c9dd72581a2b35cb68b9fb6aa125b312b4066fd2"
    end
    if Hardware::CPU.intel?
      url "https://github.com/pawelb0/mcpal/releases/download/v0.4.3/mcpal-x86_64-apple-darwin.tar.xz"
      sha256 "3f8fc5cf2604953f732b5e31bfd0dc3c37302add56adb5ae6591c42a6e94f9b3"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/pawelb0/mcpal/releases/download/v0.4.3/mcpal-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "feabd011e7dc4ec6010d63cf193f23e5d13bca1f1f01e7cbb260b81c8e092a78"
    end
    if Hardware::CPU.intel?
      url "https://github.com/pawelb0/mcpal/releases/download/v0.4.3/mcpal-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "9104950b078cb8c38538b115ea4c1793867efeeb1928aa58cebac300eae5c285"
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
