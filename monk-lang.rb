class MonkLang < Formula
  desc "A minimalist, readable, and performant programming language"
  homepage "https://github.com/monkfromearth/monk-lang"
  version "0.0.5"
  
  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/monkfromearth/monk-lang/releases/download/v#{version}/monk-v#{version}-darwin-x64.tar.gz"
      sha256 "fffc9815fc266965f648b2d0744ce10d32b696b976d3f50b76e5ae505b9d73e2"
    else
      url "https://github.com/monkfromearth/monk-lang/releases/download/v#{version}/monk-v#{version}-darwin-arm64.tar.gz"
      sha256 "00ac81ea5d23bf8832db2ac4a0808aa66b4a7680e808942c31a67061580f6a4c"
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/monkfromearth/monk-lang/releases/download/v#{version}/monk-v#{version}-linux-x64.tar.gz"
      sha256 "5760244613f71b10101b801c6353a77d0e1d045b8efd798faf7a3f6dc738ef65"
    else
      url "https://github.com/monkfromearth/monk-lang/releases/download/v#{version}/monk-v#{version}-linux-arm64.tar.gz"
      sha256 "6d22446e61d9127350911d386c39ede2f3021461b216b98f24440322ec7dd089"
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
        monk --help          # Show help
        monk repl            # Start interactive REPL
        monk run script.monk # Run a Monk script

      Example:
        echo 'show("Hello, World!")' > hello.monk
        monk run hello.monk

      Documentation: https://github.com/monkfromearth/monk-lang
    EOS
  end

  private

  def os
    if OS.mac?
      "darwin"
    elsif OS.linux?
      "linux"
    else
      raise "Unsupported operating system"
    end
  end
end 