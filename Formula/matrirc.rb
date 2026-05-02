class Matrirc < Formula
  desc "Local IRC server that bridges to a Matrix homeserver"
  homepage "https://github.com/pawelb0/matrirc"
  version "0.2.8"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/pawelb0/matrirc/releases/download/v0.2.8/matrirc-aarch64-apple-darwin.tar.xz"
      sha256 "85c83cc1e14cdac8383d848e6fe2b7d8a2fca638da5bd4a0e1d1ecd37d2320c9"
    end
    if Hardware::CPU.intel?
      url "https://github.com/pawelb0/matrirc/releases/download/v0.2.8/matrirc-x86_64-apple-darwin.tar.xz"
      sha256 "e94afb7776f871755c3f6f73ae531c23400d487664c606f9fbd8c82315b0e69e"
    end
  end
  if OS.linux? && Hardware::CPU.intel?
    url "https://github.com/pawelb0/matrirc/releases/download/v0.2.8/matrirc-x86_64-unknown-linux-gnu.tar.xz"
    sha256 "0623c50ca027845a4d1e28c5c43f16ec8eeb38a36e9d8bd14012dbe45ad29056"
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
