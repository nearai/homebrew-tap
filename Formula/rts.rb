# Rendered by scripts/release/render-formula.sh in the release workflow and
# committed to nearai/homebrew-tap as Formula/rts.rb. Do not edit the tap copy.
class Rts < Formula
  desc "Launcher for sandboxed opencode sessions on mvm microVMs"
  homepage "https://github.com/nearai/nearai-red-sandbox"
  url "https://github.com/nearai/nearai-red-sandbox/releases/download/v0.1.6/rts-0.1.6-aarch64-apple-darwin.tar.gz"
  sha256 "a49a7a6af9eacbdc2fcbfa9f8a4180eec630438dfed2446ba6d3940b789ebaa1"
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
