{
  version = "0.0.0";
  timestamp = "2025-01-09T18:59:28Z";

  sources = {
    "x86_64-linux" = {
      url = "https://github.com/foundry-rs/foundry/releases/download/nightly/foundry_nightly_linux_amd64.tar.gz";
      sha256 = "sha256-0QiQ1yVOUBv4p2UwzAQcMYpebVV6iC3QQQcx22v8/m8=";
    };
    "aarch64-linux" = {
      url = "https://github.com/foundry-rs/foundry/releases/download/nightly/foundry_nightly_linux_arm64.tar.gz";
      sha256 = "0mym0f44rgfl9s3986npbms5pq4w18mdglf8x8wirvmcgilvxar0";
    };
    "x86_64-darwin" = {
      url = "https://github.com/foundry-rs/foundry/releases/download/nightly/foundry_nightly_darwin_amd64.tar.gz";
      sha256 = "066mmzfslp4cmzj3zihzckdydgjn5d0qr5nsifb2wyy37gmipj5f";
    };
    "aarch64-darwin" = {
      url = "https://github.com/foundry-rs/foundry/releases/download/nightly/foundry_nightly_darwin_arm64.tar.gz";
      sha256 = "1dc6033rkl1r63csxzkvhmbkk2y844zg7f8s906432a512cgrq4z";
    };
  };
}
