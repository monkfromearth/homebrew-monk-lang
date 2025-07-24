class MonkLang < Formula
  desc "A minimalist, readable, and performant programming language"
  homepage "https://github.com/monkfromearth/monk-lang"
  version "0.0.6"
  
  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/monkfromearth/monk-lang/releases/download/v#{version}/monk-v#{version}-darwin-x64.tar.gz"
      sha256 "7578fcbb08fd7f9d5efe60e9fbafa219ffe769e225dc0834690313298d7df12b"
    else
      url "https://github.com/monkfromearth/monk-lang/releases/download/v#{version}/monk-v#{version}-darwin-arm64.tar.gz"
      sha256 "23f2ca349801b301c37d6490ed9e577c12e8d8e947838089cac99e931a0c0422"
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/monkfromearth/monk-lang/releases/download/v#{version}/monk-v#{version}-linux-x64.tar.gz"
      sha256 "fa19174702b882308db0f9679e87d24dfea7399f29ec0f0f0640e26e94cf1185"
    else
      url "https://github.com/monkfromearth/monk-lang/releases/download/v#{version}/monk-v#{version}-linux-arm64.tar.gz"
      sha256 "e5c885dad96c6de3d1ae473b48706fb62dbfff67e9e1b24369637ba81f5dc30e"
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
