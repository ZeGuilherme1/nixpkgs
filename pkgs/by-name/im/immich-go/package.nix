{ lib, buildGoModule, fetchFromGitHub, nix-update-script, testers, immich-go }:
buildGoModule rec {
  pname = "immich-go";
  version = "0.14.1";

  src = fetchFromGitHub {
    owner = "simulot";
    repo = "immich-go";
    rev = "${version}";
    hash = "sha256-TibDbA4rrr9+WmKAyd3CQ0lxFFv3v/A2HO6Iu66mgFM=";
  };

  vendorHash = "sha256-nOJJz5KEXqxl3tP1Q12Cb/fugtxR67RjzH6khKg3ppE=";

  # options used by upstream:
  # https://github.com/simulot/immich-go/blob/0.13.2/.goreleaser.yaml
  ldflags = [
    "-s"
    "-w"
    "-extldflags=-static"
    "-X main.version=${version}"
    "-X main.commit=${version}"
    "-X main.date=unknown"
  ];

  passthru = {
    updateScript = nix-update-script { };
    tests.versionTest = testers.testVersion {
      package = immich-go;
      command = "immich-go -h";
      version = version;
    };
  };

  meta = {
    description = "Immich client tool for bulk-uploads";
    longDescription = ''
      Immich-Go is an open-source tool designed to streamline uploading
      large photo collections to your self-hosted Immich server.
    '';
    homepage = "https://github.com/simulot/immich-go";
    mainProgram = "immich-go";
    license = lib.licenses.agpl3Only;
    maintainers = with lib.maintainers; [ kai-tub ];
    changelog = "https://github.com/simulot/immich-go/releases/tag/${version}";
  };
}
