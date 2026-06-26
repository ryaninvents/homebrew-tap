class Cb < Formula
  desc "Disposable git worktree manager"
  homepage "https://github.com/ryaninvents/compare-branch"
  version "0.3.0"
  license "MIT"

  depends_on "git"

  on_macos do
    on_arm do
      url "https://github.com/ryaninvents/compare-branch/releases/download/v0.3.0/cb-v0.3.0-macos-arm64.tar.gz"
      sha256 "41b5aea850c065fc135c96f31ccc59995b061fd9d3922498d5f318595db76f9e"
    end
    on_intel do
      url "https://github.com/ryaninvents/compare-branch/releases/download/v0.3.0/cb-v0.3.0-macos-x86_64.tar.gz"
      sha256 "e6c10cf387f405d6a993813313476fc1738f6581a870f756f6e20499484517eb"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/ryaninvents/compare-branch/releases/download/v0.3.0/cb-v0.3.0-linux-arm64.tar.gz"
      sha256 "d6063ba105f8772b2ecf38506fe30032d803d50cd4b7e13a977b5cf2c1b060cc"
    end
    on_intel do
      url "https://github.com/ryaninvents/compare-branch/releases/download/v0.3.0/cb-v0.3.0-linux-x86_64.tar.gz"
      sha256 "bc1436e8c2aa58b94df28b03f01b54a8169754b7f637307222ab37e51ec68486"
    end
  end

  def install
    bin.install "cb-bin"
    # Sourced wrapper functions (the cb() shell function) live under share/cb.
    pkgshare.install "shell/cb.zsh", "shell/cb.bash"
    # Completion: zsh onto fpath, bash into bash_completion.d.
    zsh_completion.install "completions/_cb"
    bash_completion.install "completions/cb.bash" => "cb"
  end

  def caveats
    <<~CAVEATS
      cb is driven by a shell function that fronts cb-bin (needed for `cb cd`,
      `cb exit`, and `cb done`). Source the integration from your shell rc:
        source "#{opt_share}/cb/cb.zsh"    # ~/.zshrc
        source "#{opt_share}/cb/cb.bash"   # ~/.bashrc
      Tab-completion is installed automatically (zsh requires Homebrew's
      site-functions on your fpath; see `brew completions`).
    CAVEATS
  end

  test do
    assert_match "cb", shell_output("#{bin}/cb-bin init zsh")
  end
end
