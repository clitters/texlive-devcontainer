FROM mcr.microsoft.com/vscode/devcontainers/base:debian

ENV PATH=$PATH:/usr/local/texlive/bin/x86_64-linux:/usr/local/texlive/bin/aarch64-linux

COPY texlive.profile /tmp/

RUN apt-get update -qq \
    && apt-get install -y fontconfig texlive \
    && rm -rf /var/lib/apt/lists/* \
    && apt-get clean

USER vscode

RUN update-tlmgr-latest.sh --update \
    && tlmgr init-usertree \
    && tlmgr option repository http://mirror.ctan.org/systems/texlive/tlnet \
    && tlmgr update --self --all 
