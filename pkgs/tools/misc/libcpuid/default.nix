{ lib, stdenv, fetchFromGitHub, autoreconfHook }:

stdenv.mkDerivation rec {
  pname = "libcpuid";
  version = "0.6.1";

  src = fetchFromGitHub {
    owner = "anrieff";
    repo = "libcpuid";
    rev = "v${version}";
    sha256 = "sha256-KxG06a56XPa34IJGAJbBeHUKkCEba+R7HOSosTCwQKU=";
  };

  nativeBuildInputs = [ autoreconfHook ];

  meta = with lib; {
    homepage = "http://libcpuid.sourceforge.net/";
    description = "A small C library for x86 CPU detection and feature extraction";
    license = licenses.bsd2;
    maintainers = with maintainers; [ orivej artuuge ];
    platforms = platforms.x86;
  };
}
