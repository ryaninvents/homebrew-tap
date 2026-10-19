class Cb < Formula
  desc "Disposable git worktree manager"
  homepage "https://github.com/ryaninvents/compare-branch"
  version "0.7.1"
  license "MIT"

  depends_on "git"

  on_macos do
    on_arm do
      url "https://github.com/ryaninvents/compare-branch/releases/download/v0.7.1/cb-v0.7.1-macos-arm64.tar.gz"
      sha256 "4fc53e7a57ab745a7477f19cde34c4721e0bc470cf77ec7de27dc10e34fce1a0"
    end
    on_intel do
      url "https://github.com/ryaninvents/compare-branch/releases/download/v0.7.1/cb-v0.7.1-macos-x86_64.tar.gz"
      sha256 "e6965552d2cdbba42f81e8bc742e95783cd5d59969c902919330b1b0d6c4fd99"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/ryaninvents/compare-branch/releases/download/v0.7.1/cb-v0.7.1-linux-arm64.tar.gz"
      sha256 "bba094a856e36c64ec966871c9261e48813dcb384133b38589ac690afe676c55"
    end
    on_intel do
      url "https://github.com/ryaninvents/compare-branch/releases/download/v0.7.1/cb-v0.7.1-linux-x86_64.tar.gz"
      sha256 "aed12247afd54665d2f789efbda3c30046da4f65ddeb02fc87c028b13e4a15d3"
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
