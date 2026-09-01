class Cb < Formula
  desc "Disposable git worktree manager"
  homepage "https://github.com/ryaninvents/compare-branch"
  version "0.5.0"
  license "MIT"

  depends_on "git"

  on_macos do
    on_arm do
      url "https://github.com/ryaninvents/compare-branch/releases/download/v0.5.0/cb-v0.5.0-macos-arm64.tar.gz"
      sha256 "f6923647e8a478eeea3146bf9f6a9a8a3b59a5bae2501d587635f3185bce6eb2"
    end
    on_intel do
      url "https://github.com/ryaninvents/compare-branch/releases/download/v0.5.0/cb-v0.5.0-macos-x86_64.tar.gz"
      sha256 "9f0395d1b9c84c7ed28a88c5d9fa9cbea6df235b956ccda1a954b6c3400f20fd"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/ryaninvents/compare-branch/releases/download/v0.5.0/cb-v0.5.0-linux-arm64.tar.gz"
      sha256 "716bfe2312781a46088da7f0d0807e732ae9250f90a336b56c3d6253672751b5"
    end
    on_intel do
      url "https://github.com/ryaninvents/compare-branch/releases/download/v0.5.0/cb-v0.5.0-linux-x86_64.tar.gz"
      sha256 "399033ec4b61dbda5d6ced48a5f3311255341aefaf3dfa15e1797ead7faf1511"
    end
  end

  def install
    bin.install "cb-bin"
    # Sourced wrapper functions (the cb() shell function) live under share/cb.
    pkgshare.install "shell/cb.zsh", "shell/cb.bash"
    # Completion: zsh onto fpath, bash into bash_completion.d.
    zsh_completion.install "completions/_cb"
    bash_completion.install "completions/cb.bash" => "cb"
    # Man pages. Homebrew puts share/man on MANPATH automatically, so `man cb`
    # works with no extra setup — unlike shell integration, this needs no
    # caveat.
    man1.install "man/cb.1"
    man5.install "man/cb-config.5"
    man7.install "man/cb-review.7"
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
