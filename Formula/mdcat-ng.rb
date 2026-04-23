class MdcatNg < Formula
  desc "Cat for markdown: show markdown documents in terminals"
  homepage "https://github.com/pawelb0/mdcat-ng"
  url "https://github.com/pawelb0/mdcat-ng/archive/refs/tags/mdcat-ng-0.2.0.tar.gz"
  sha256 "0000000000000000000000000000000000000000000000000000000000000000"
  license "MPL-2.0"
  head "https://github.com/pawelb0/mdcat-ng.git", branch: "main"

  depends_on "rust" => :build
  uses_from_macos "curl"

  def install
    system "cargo", "install", *std_cargo_args(path: ".")
    generate_completions_from_executable(bin/"mdcat", "--completions", shells: [:bash, :zsh, :fish])
    generate_completions_from_executable(bin/"mdless", "--completions", shells: [:bash, :zsh, :fish])
  end

  test do
    output = pipe_output("#{bin}/mdcat", "# Hello\n")
    assert_match "Hello", output
  end
end
