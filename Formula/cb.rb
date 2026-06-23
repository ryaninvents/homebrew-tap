class Cb < Formula
  desc "Disposable git worktree manager"
  homepage "https://github.com/ryaninvents/compare-branch"
  version "0.2.0"
  license "MIT"

  depends_on "git"

  on_macos do
    on_arm do
      url "https://github.com/ryaninvents/compare-branch/releases/download/v0.2.0/cb-v0.2.0-macos-arm64.tar.gz"
      sha256 "5e4dce952f3d6765dca02815419381e0da54d6013bdfb25d56ed1a764d11ad7d"
    end
    on_intel do
      url "https://github.com/ryaninvents/compare-branch/releases/download/v0.2.0/cb-v0.2.0-macos-x86_64.tar.gz"
      sha256 "1871be41ceccfddaf9f54f730ecb0c45937ade744d36a684b720af0e5bdcf5d1"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/ryaninvents/compare-branch/releases/download/v0.2.0/cb-v0.2.0-linux-arm64.tar.gz"
      sha256 "ffbb37e8af83863ee952620f94b9fb4dbf3b01a3d5c663f912e6071778a0c9cf"
    end
    on_intel do
      url "https://github.com/ryaninvents/compare-branch/releases/download/v0.2.0/cb-v0.2.0-linux-x86_64.tar.gz"
      sha256 "b9f806f54a9f9524d8261d7966f4948c3589c0e64195721a963971b0db82865e"
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
