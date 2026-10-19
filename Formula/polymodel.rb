class Polymodel < Formula
  desc "Merge multiple LLMs into one OpenAI-compatible model"
  homepage "https://github.com/ryaninvents/polymodel"
  url "https://github.com/ryaninvents/polymodel/releases/download/v0.1.0/ryaninvents-polymodel-0.1.0.tgz"
  version "0.1.0"
  sha256 "9acee9a8498bb68427708b2beb11487bd88ce96b0c4ec7404bc000e305414600"
  license "MIT"

  depends_on "node"

  def install
    # devEngines pins the exact Node used to develop polymodel with
    # onFail=error, which would make npm refuse to pack against Homebrew's node.
    pkg = JSON.parse(File.read("package.json"))
    pkg.delete("devEngines")
    File.write("package.json", JSON.pretty_generate(pkg))

    system "npm", "install", *std_npm_args
    bin.install_symlink libexec.glob("bin/*")
  end

  def caveats
    <<~EOS
      Run `polymodel setup` to choose providers and store API keys before
      starting the service.
    EOS
  end

  service do
    run [opt_bin/"polymodel", "serve"]
    keep_alive true
    log_path var/"log/polymodel.log"
    error_log_path var/"log/polymodel.log"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/polymodel --version")
  end
end
