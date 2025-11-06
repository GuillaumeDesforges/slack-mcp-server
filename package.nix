{
  lib,
  buildGoModule,
}:

buildGoModule rec {
  pname = "slack-mcp-server";
  version = "unstable-2025-11-06";

  src = ./.;

  vendorHash = "sha256-yaN8J6Of/EFQW1d8Kl5gNM0o/AcLyKEAq7dN+IX45GU=";

  subPackages = [ "cmd/slack-mcp-server" ];

  ldflags = [
    "-s"
    "-w"
    "-X github.com/korotovsky/slack-mcp-server/pkg/version.Version=${version}"
    "-X github.com/korotovsky/slack-mcp-server/pkg/version.BuildTime=1970-01-01T00:00:00Z"
  ];

  meta = with lib; {
    description = "Model Context Protocol (MCP) server for Slack Workspaces";
    homepage = "https://github.com/korotovsky/slack-mcp-server";
    license = licenses.mit;
    maintainers = [ ];
    mainProgram = "slack-mcp-server";
  };
}
