class Crondrop < Formula
  desc "Desktop eye-drop reminder app with a CLI-first workflow"
  homepage "https://github.com/AlTosterino/crondop"
  license "MIT"
  version "0.1.6"

  on_macos do
    depends_on arch: :arm64
    url "https://github.com/AlTosterino/crondop/releases/download/v0.1.6/crondrop-macos-aarch64.tar.gz"
    sha256 "d0cf1762d189c0203381a2a7adde787e5e46fa6d7869c067a5c77e4783d01eac"
  end

  on_linux do
    url "https://github.com/AlTosterino/crondop/releases/download/v0.1.6/crondrop-linux-x86_64.tar.gz"
    sha256 "43b4d575c16bfc3e550a274a07858079e9edf81baf0c5cb7ce95f08baa48b85a"
  end

  def install
    binary = Dir["crondrop", "*/crondrop"].find { |path| File.file?(path) }
    odie "crondrop binary not found in release archive" unless binary

    bin.install binary => "crondrop"

    readme = Dir["README-packaging.md", "*/README-packaging.md"].find { |path| File.file?(path) }
    doc.install readme if readme

    summary = Dir["SPEC.md", "SUMMARY.MD", "*/SPEC.md", "*/SUMMARY.MD"].find { |path| File.file?(path) }
    doc.install summary if summary

    plist = Dir["com.crondrop.plist", "*/com.crondrop.plist"].find { |path| File.file?(path) }
    prefix.install plist if OS.mac? && plist

    desktop = Dir["crondrop.desktop", "*/crondrop.desktop"].find { |path| File.file?(path) }
    prefix.install desktop if OS.linux? && desktop
  end

  test do
    assert_match "A friendly CLI-first eye drop reminder", shell_output("#{bin}/crondrop --help")
  end
end
