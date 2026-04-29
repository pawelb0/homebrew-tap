class Mdqy < Formula
  desc "jq for markdown: query and transform Markdown with a hybrid selector and jq DSL"
  homepage "https://github.com/pawelb0/mdqy"
  version "0.1.2"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/pawelb0/mdqy/releases/download/v0.1.2/mdqy-aarch64-apple-darwin.tar.xz"
      sha256 "b3e89156bb85ff572bb7340582077c5215d54d2fec09e1031022ff536d651cdf"
    end
    if Hardware::CPU.intel?
      url "https://github.com/pawelb0/mdqy/releases/download/v0.1.2/mdqy-x86_64-apple-darwin.tar.xz"
      sha256 "f084393809836edf402a7dc2fbdc590b658b20aa0860265067081c57fc3c419c"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/pawelb0/mdqy/releases/download/v0.1.2/mdqy-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "a3a9963a0a961a9628c0965f1d3f313c4fe2471f597a66dc1d665924c69fd0c2"
    end
    if Hardware::CPU.intel?
      url "https://github.com/pawelb0/mdqy/releases/download/v0.1.2/mdqy-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "8e44259b70a104ef473d9fe66428de66d659412ec15fc733e91324c162764204"
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
