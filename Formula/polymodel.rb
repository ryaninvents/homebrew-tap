class Polymodel < Formula
  desc "Merge multiple LLMs into one OpenAI-compatible model"
  homepage "https://github.com/ryaninvents/polymodel"
  url "https://github.com/ryaninvents/polymodel/releases/download/v0.2.0/ryaninvents-polymodel-0.2.0.tgz"
  version "0.2.0"
  sha256 "ce7b820e65f557c6261ab855ee7783965cd1c0c8b308f785f05d8f3c35333485"
  license "MIT"

  depends_on "node@24"

  def install
    system "npm", "install", *std_npm_args
    # The CLI's shebang is `env node`; the wrapper makes it run on node@24
    # rather than whichever node is first on the user's (or launchd's) PATH.
    libexec.glob("bin/*").each do |executable|
      (bin/executable.basename).write_env_script executable, PATH: "#{Formula["node@24"].opt_bin}:$PATH"
    end
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
