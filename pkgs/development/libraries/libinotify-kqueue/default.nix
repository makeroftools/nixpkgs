{ lib, stdenv, fetchzip, autoreconfHook }:

stdenv.mkDerivation rec {
  pname = "libinotify-kqueue";
  version = "20180201";

  src = fetchzip {
    url = "https://github.com/libinotify-kqueue/libinotify-kqueue/archive/${version}.tar.gz";
    sha256 = "0dkh6n0ghhcl7cjkjmpin118h7al6i4vlkmw57vip5f6ngr6q3pl";
  };

  nativeBuildInputs = [ autoreconfHook ];

  doCheck = true;
  checkFlags = [ "test" ];

  meta = with lib; {
    description = "Inotify shim for macOS and BSD";
    homepage = "https://github.com/libinotify-kqueue/libinotify-kqueue";
    license = licenses.mit;
    maintainers = with maintainers; [ yana ];
    platforms = with platforms; darwin ++ freebsd ++ netbsd ++ openbsd;
  };
}
