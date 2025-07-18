class MonkLang < Formula
  desc "A minimalist, readable, and performant programming language"
  homepage "https://github.com/monkfromearth/monk-lang"
  version "0.0.5"
  
  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/monkfromearth/monk-lang/releases/download/v#{version}/monk-v#{version}-darwin-x64.tar.gz"
      sha256 "50b6ffa4166b87f0bb85057c2f0eba6aad213e4ad4ce9b417d906354d849d0d0"
    else
      url "https://github.com/monkfromearth/monk-lang/releases/download/v#{version}/monk-v#{version}-darwin-arm64.tar.gz"
      sha256 "8830dfff1da997281307044b1e9346c367ba885aab58849a6db8ca0cfaae4838"
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/monkfromearth/monk-lang/releases/download/v#{version}/monk-v#{version}-linux-x64.tar.gz"
      sha256 "ff42794a172446499784e090fb8081424fe0c759b1a619029aa2e7d664047f10"
    else
      url "https://github.com/monkfromearth/monk-lang/releases/download/v#{version}/monk-v#{version}-linux-arm64.tar.gz"
      sha256 "68583c58008cb592b8804a47f2e66f2d6f2effb4ad735fd73e9d0bce9fd2772b"
    end
  end

  license "MIT"

  def install
    # The binary name format in the tarball
    bin.install "monk-#{os}-#{Hardware::CPU.arch}" => "monk"
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