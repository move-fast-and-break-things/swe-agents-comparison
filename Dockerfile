FROM node:18.20.4

# DISCLAIMER! This is insecure. The image is intended for local use only.
# Do not push the built image anywhere public.
ARG GITHUB_TOKEN
ENV GITHUB_TOKEN=$GITHUB_TOKEN

WORKDIR /root

RUN apt-get update && apt-get install -y git

# Clone the Aibyss repo
RUN git clone https://$GITHUB_TOKEN@github.com/move-fast-and-break-things/aibyss.git aibyss
RUN cd aibyss && git reset --hard b4e58b232fb002f07ab305104c790c267dddb0e0
RUN cd aibyss && npm ci

# Install Claude Code
RUN apt-get update && apt-get install -y gh ripgrep pipx
RUN npm install -g @anthropic-ai/claude-code@0.2.35

# Install Aider
RUN apt-get update && apt-get install -y pipx
RUN pipx ensurepath
RUN pipx install aider-chat==0.75.0
