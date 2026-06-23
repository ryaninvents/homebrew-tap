class Cb < Formula
  desc "Disposable git worktree manager"
  homepage "https://github.com/ryaninvents/compare-branch"
  version "0.1.0"
  license "MIT"

  depends_on "git"

  on_macos do
    on_arm do
      url "https://github.com/ryaninvents/compare-branch/releases/download/0.1.0/cb-0.1.0-macos-arm64.tar.gz"
      sha256 "7efd020cea79353ff801f640720b42118b0fde8df2fa0980f5a4867be3304404"
    end
    on_intel do
      url "https://github.com/ryaninvents/compare-branch/releases/download/0.1.0/cb-0.1.0-macos-x86_64.tar.gz"
      sha256 "8f5d23b9807d55a1bf2756e22b38e03172ba9ad4f655acca754ac0938bf9ef9b"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/ryaninvents/compare-branch/releases/download/0.1.0/cb-0.1.0-linux-arm64.tar.gz"
      sha256 "3182435261c22a64252aff7f6deb66bb888d1c963d66ca3db6d732947703852c"
    end
    on_intel do
      url "https://github.com/ryaninvents/compare-branch/releases/download/0.1.0/cb-0.1.0-linux-x86_64.tar.gz"
      sha256 "6f5ed9f04cf348083e756f37c85529175974b98954169f84481cb9497813b3b3"
    end
  end

  def install
    bin.install "cb-bin"
  end

  def caveats
    <<~CAVEATS
      cb is driven by a shell function that fronts cb-bin (needed for `cb cd`,
      `cb exit`, and `cb done`). Add the integration to your shell rc:
        eval "$(cb-bin init zsh)"    # ~/.zshrc
        eval "$(cb-bin init bash)"   # ~/.bashrc
    CAVEATS
  end

  test do
    assert_match "cb", shell_output("#{bin}/cb-bin init zsh")
  end
end
