# Rendered by scripts/release/render-formula.sh in the release workflow and
# committed to nearai/homebrew-tap as Formula/rts.rb. Do not edit the tap copy.
class Rts < Formula
  desc "Launcher for sandboxed opencode sessions on mvm microVMs"
  homepage "https://github.com/nearai/nearai-red-sandbox"
  url "https://github.com/nearai/nearai-red-sandbox/releases/download/v0.1.0/rts-0.1.0-aarch64-apple-darwin.tar.gz"
  sha256 "104e514db8005096cb5bddf86071f119cad4286c5e63717b295dd3dd3f3ae928"
  license "Apache-2.0"

  depends_on arch: :arm64
  depends_on :macos

  def install
    prefix.install "bin", "libexec", "share"
  end

  def caveats
    <<~EOS
      Run this once to fetch mvm v0.22.0, opencode v2.2.2 and the guest image,
      each pinned by digest (Homebrew's sandbox forbids writing to your home
      directory during install):
        rts setup

      `brew uninstall rts` removes only the keg. For a full removal, also delete:
        ~/.local/mvm/v0.22.0
        ~/.local/share/nearai-red-sandbox
      The second holds opencode and, unless sessionsDir is configured, your
      sessions.
    EOS
  end

  test do
    assert_match "rts #{version}", shell_output("#{bin}/rts --version")
    system bin/"rts", "setup", "--check", "--offline"
  end
end
