class MonkLang < Formula
  desc "A minimalist, readable, and performant programming language"
  homepage "https://github.com/monkfromearth/monk-lang"
  version "0.0.5"
  
  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/monkfromearth/monk-lang/releases/download/v#{version}/monk-v#{version}-darwin-x64.tar.gz"
      sha256 "[0;31m[ERROR][0m Could not find SHA256 for monk-v0.0.5-darwin-x64.tar.gz in checksums"
    else
      url "https://github.com/monkfromearth/monk-lang/releases/download/v#{version}/monk-v#{version}-darwin-arm64.tar.gz"
      sha256 "[0;31m[ERROR][0m Could not find SHA256 for monk-v0.0.5-darwin-arm64.tar.gz in checksums"
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/monkfromearth/monk-lang/releases/download/v#{version}/monk-v#{version}-linux-x64.tar.gz"
      sha256 "[0;31m[ERROR][0m Could not find SHA256 for monk-v0.0.5-linux-x64.tar.gz in checksums"
    else
      url "https://github.com/monkfromearth/monk-lang/releases/download/v#{version}/monk-v#{version}-linux-arm64.tar.gz"
      sha256 "[0;31m[ERROR][0m Could not find SHA256 for monk-v0.0.5-linux-arm64.tar.gz in checksums"
    end
  end

  license "MIT"

  def install
    # The binary is simply named "monk" in the tarball
    bin.install "monk"
  end

  test do
    system "#{bin}/monk", "--version"
    
    # Test basic functionality
    (testpath/"hello.monk").write <<~EOS
      const message = "Hello, Homebrew!"
      show(message)
    EOS
    
    output = shell_output("#{bin}/monk run #{testpath}/hello.monk")
    assert_match "Hello, Homebrew!", output
  end

  def caveats
    <<~EOS
      Monk Lang has been installed!

      Get started:
        monk repl                    # Start interactive REPL
        monk run script.monk         # Run a Monk script
        monk --help                  # View all options

      Documentation: https://github.com/monkfromearth/monk-lang
      Examples: https://github.com/monkfromearth/monk-lang/tree/main/examples
    EOS
  end
end
