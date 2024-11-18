# Base Image
FROM debian:bullseye

# Arguments for non-root user and vcpkg root
ARG USERNAME=vscode
ARG VCPKG_ROOT=/usr/local/vcpkg
ARG DEBIAN_FRONTEND=noninteractive

# Install development tools and dependencies
RUN apt-get update && apt-get install -y \
    build-essential \
    cmake \
    cppcheck \
    valgrind \
    clang \
    lldb \
    llvm \
    gdb \
    git \
    curl \
    wget \
    unzip \
    zip \
    tar \
    sudo && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

# Create a non-root user
RUN useradd -ms /bin/bash ${USERNAME} && \
    echo "${USERNAME} ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/${USERNAME} && \
    chmod 0440 /etc/sudoers.d/${USERNAME}

# Set up vcpkg
ENV VCPKG_ROOT=${VCPKG_ROOT}
ENV PATH="${PATH}:${VCPKG_ROOT}"
RUN git clone https://github.com/microsoft/vcpkg.git ${VCPKG_ROOT} && \
    ${VCPKG_ROOT}/bootstrap-vcpkg.sh && \
    ${VCPKG_ROOT}/vcpkg integrate install

# Set working directory and switch to non-root user
WORKDIR /workspaces
USER ${USERNAME}
