{ lib
, buildPythonPackage
, isPy27
, fetchPypi
, imageio-ffmpeg
, numpy
, pillow
, psutil
, pytestCheckHook
, tifffile
}:

buildPythonPackage rec {
  pname = "imageio";
  version = "2.12.0";
  disabled = isPy27;

  src = fetchPypi {
    sha256 = "c416dd68328ace8536ff333cbb8927954036be56e201fed416e53e8f95e08a6c";
    inherit pname version;
  };

  propagatedBuildInputs = [
    imageio-ffmpeg
    numpy
    pillow
  ];

  checkInputs = [
    psutil
    pytestCheckHook
    tifffile
  ];

  preCheck = ''
    export IMAGEIO_USERDIR="$TMP"
    export IMAGEIO_NO_INTERNET="true"
    export HOME="$(mktemp -d)"
  '';

  disabledTests = [
    # tries to pull remote resources, even with IMAGEIO_NO_INTERNET
    "test_png_remote"
    # needs git history
    "test_mvolread_out_of_bytes"
    "test_imiter"
    "test_memory_size"
    "test_legacy_write_empty"
  ];

  disabledTestPaths = [
    "tests/test_pillow.py"
  ];

  meta = with lib; {
    description = "Library for reading and writing a wide range of image, video, scientific, and volumetric data formats";
    homepage = "http://imageio.github.io/";
    license = licenses.bsd2;
  };
}
