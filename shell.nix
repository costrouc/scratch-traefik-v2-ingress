{ pkgs ? import <nixpkgs> { } }:

pkgs.mkShell {
  buildInputs = [
    pkgs.minikube
    pkgs.kubectl
    pkgs.terraform
  ];
}
