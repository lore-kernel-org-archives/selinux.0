Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-23.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92D4AC433E6
	for <selinux@archiver.kernel.org>; Fri, 22 Jan 2021 10:31:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 432B9239EF
	for <selinux@archiver.kernel.org>; Fri, 22 Jan 2021 10:31:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727211AbhAVKba (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 22 Jan 2021 05:31:30 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:55980 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727823AbhAVK3d (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 22 Jan 2021 05:29:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611311275;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ITPmTZ0A2Vw/dzX/FbZP9GuLoZ76GpLByjJ9T49UaL8=;
        b=L4qNhDiI2/3PKd760O9Dq6OswfD5+e6XY+Vcv+Eii1mRKNOG5qjqw8h7iyWK326HPH+3BG
        ZPJMw3VzWbaCHazUyOcuBKPyFPysPxIfdlJnmtO1atgDVIqz6QRQdR+CrBrVvyyQyOCidK
        XFcVX+DYDgs0x0qqbHhH6XywFGhP7XY=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-213-qYO-ps4OPt2FVQN9nLJeNw-1; Fri, 22 Jan 2021 05:27:52 -0500
X-MC-Unique: qYO-ps4OPt2FVQN9nLJeNw-1
Received: by mail-ed1-f71.google.com with SMTP id a26so2716585edx.8
        for <selinux@vger.kernel.org>; Fri, 22 Jan 2021 02:27:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ITPmTZ0A2Vw/dzX/FbZP9GuLoZ76GpLByjJ9T49UaL8=;
        b=JaE0AgkWcMI7pq0DMJQW/k2qDgJGSZyTybPQg6SVox7oOyB6cuDJ2rpaeQ2ukk4NCb
         dVZefwnolSL7G5BYJCNifwOLq3vY1qdG96iB/vE4BAZ5mBLSVrnklxko3svmoEMyGAbL
         37mNvRHiYAdvSc/IY4phArFE6ACi7i3qgD0WbSbFdUWQuq/g9oKbS8mxGiL7DvE7vAw2
         VpwuOp4oNGjn4H7xwl5m/AAcVWl3ODZe1vlzYsxfwNrZnpouxFOWuRjsMh/E5GyMD8vT
         3LAueVG3UTy7xOH4sQcJhV1okxC9bU8Lxi7Fr45ahe6veMvnvw0YS4BSAgZ/mkbXisL/
         ZXHw==
X-Gm-Message-State: AOAM533kZC5+IoKKVFy4QxEzxFu2XTFkChTurDPFGpWGszIw1OOydDXP
        VEEm3sl4vDA9x5CisW1USg0T9naGJSYJ1vQrwTGZGfzw5V7jIpwOqx/NmijhkqMlEZGz4sNohg5
        +A/dtEQltwJ80K5INrTixI6ARPIhFVmVCPn/fvlByGyBcZ30ujA7+DjMw/Bf+npUjPqh78A==
X-Received: by 2002:a17:907:175c:: with SMTP id lf28mr2551570ejc.110.1611311270627;
        Fri, 22 Jan 2021 02:27:50 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwuWF98c7JVCWqJzwX9SVSRnB3rLA7OhnnIfnO8oc0O32ZmgFME3B2fRrWnaCb5RVzNfpgnmw==
X-Received: by 2002:a17:907:175c:: with SMTP id lf28mr2551561ejc.110.1611311270339;
        Fri, 22 Jan 2021 02:27:50 -0800 (PST)
Received: from omos.redhat.com ([2a02:8308:b105:dd00:277b:6436:24db:9466])
        by smtp.gmail.com with ESMTPSA id z1sm5047556edm.89.2021.01.22.02.27.49
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Jan 2021 02:27:49 -0800 (PST)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     selinux@vger.kernel.org
Subject: [PATCH testsuite 2/2] Migrate CI to GH Actions
Date:   Fri, 22 Jan 2021 11:27:48 +0100
Message-Id: <20210122102748.38776-3-omosnace@redhat.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210122102748.38776-1-omosnace@redhat.com>
References: <20210122102748.38776-1-omosnace@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

As discovered by Nicholas Iooss [1], GH Actions now supports
HW-accelerated Linux VMs at least on macOS runners [2], so we can
finally migrate the CI away from Travis.

The new check uses Vagrant to provision the Fedora VM, as this is the
simplest way to get it to work on macOS. Unfortunately there is no
Rawhide image provided in the official Vagrant repos, so for now the
testsuite is run only on Fedora 33. I'd like to add Rawhide in the
future, but let's start with the low-hanging fruit.

[1] https://github.com/SELinuxProject/selinux/commit/316a4f89dd502d6f2b072f76af16de320c1cf673
[2] https://github.com/actions/virtual-environments/issues/433#issuecomment-618872784

Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
---
 .github/workflows/checks.yml |  27 +++++++
 .travis.yml                  |  40 ----------
 Vagrantfile                  |  65 ++++++++++++++++
 travis-ci/LICENSE            |   5 --
 travis-ci/run-kvm-test.sh    | 141 -----------------------------------
 travis-ci/run-testsuite.sh   |  58 --------------
 6 files changed, 92 insertions(+), 244 deletions(-)
 create mode 100644 .github/workflows/checks.yml
 delete mode 100644 .travis.yml
 create mode 100644 Vagrantfile
 delete mode 100644 travis-ci/LICENSE
 delete mode 100755 travis-ci/run-kvm-test.sh
 delete mode 100755 travis-ci/run-testsuite.sh

diff --git a/.github/workflows/checks.yml b/.github/workflows/checks.yml
new file mode 100644
index 0000000..e1e383f
--- /dev/null
+++ b/.github/workflows/checks.yml
@@ -0,0 +1,27 @@
+name: checks
+on: [push, pull_request]
+jobs:
+  style-check:
+    runs-on: ubuntu-latest
+    container:
+      image: fedora:latest
+    steps:
+      - run: sudo dnf install -y astyle perltidy findutils git-core
+      - uses: actions/checkout@v2
+      - run: tools/check-syntax -f && git diff --exit-code
+  fedora-test:
+    runs-on: macos-latest
+    env:
+      FEDORA_VERSION: 33
+    steps:
+      - uses: actions/checkout@v2
+      # macOS sometimes allows symlinks to have permissions other than 777,
+      # so change all symlink perms to match the Linux convention. Otherwise
+      # the rsync run by Vagrant will complain that it can't copy over the
+      # perms.
+      - name: Fix symlink permissions
+        run: find . -type link -exec chmod -h 777 \{\} \;
+      - name: Create a Vagrant VM
+        run: vagrant up
+      - name: Run SELinux testsuite
+        run: vagrant ssh -- sudo make -C /root/testsuite test
diff --git a/.travis.yml b/.travis.yml
deleted file mode 100644
index cba7462..0000000
--- a/.travis.yml
+++ /dev/null
@@ -1,40 +0,0 @@
-language: c
-
-dist: bionic
-
-env:
-  matrix:
-    - FEDORA_KIND="releases" FEDORA_MAJOR="33"
-    - FEDORA_KIND="development" FEDORA_MAJOR="rawhide"
-
-addons:
-  apt:
-    packages:
-      - astyle
-      - qemu-kvm
-      - libvirt-bin
-      - virtinst
-      - bridge-utils
-      - libguestfs-tools
-      - cpu-checker
-      - netcat
-
-before_install:
-  # FYI: known good with HEAD at 8551fc60fc515cd290ba38ee8c758c1f4df52b56
-  - git clone https://github.com/perltidy/perltidy.git perltidy
-  - |
-    (cd perltidy &&
-     perl Makefile.PL &&
-     make PREFIX=/usr/local &&
-     sudo make install PREFIX=/usr/local)
-  - sudo usermod -a -G kvm,libvirt,libvirt-qemu "$USER"
-  # Verify that KVM is working, useful if Travis ever changes anything.
-  - kvm-ok
-  - sudo systemctl enable libvirtd
-  - sudo systemctl start libvirtd
-  # Set up a key so we can ssh into the VM
-  - ssh-keygen -N "" -f "$HOME/.ssh/id_rsa"
-
-script:
-  - tools/check-syntax -f && git diff --exit-code
-  - bash travis-ci/run-kvm-test.sh travis-ci/run-testsuite.sh
diff --git a/Vagrantfile b/Vagrantfile
new file mode 100644
index 0000000..c305fce
--- /dev/null
+++ b/Vagrantfile
@@ -0,0 +1,65 @@
+# -*- mode: ruby -*-
+# vi: set ft=ruby :
+# Vagrant configuration file which creates a virtual machine that can run the
+# test suite.
+#
+# To create a new virtual machine:
+#
+#    FEDORA_VERSION=33 vagrant up
+#
+# To launch tests (for example after modifications have been made):
+#
+#    vagrant rsync && vagrant ssh -- sudo make -C /root/testsuite test
+#
+# To destroy the virtual machine (for example to start again from a clean environment):
+#
+#    vagrant destroy
+
+# All Vagrant configuration is done below. The "2" in Vagrant.configure
+# configures the configuration version (we support older styles for
+# backwards compatibility). Please don't change it unless you know what
+# you're doing.
+Vagrant.configure("2") do |config|
+  config.vm.box = "fedora/#{ENV['FEDORA_VERSION']}-cloud-base"
+  config.vm.synced_folder ".", "/vagrant", disabled: true
+  config.vm.synced_folder ".", "/root/testsuite", type: "rsync",
+    # need to disable '--copy-links', which is in rsync__args by default
+    rsync__args: ["-vzra", "--delete"]
+
+  config.vm.provider "virtualbox" do |v|
+    v.memory = 4096
+  end
+  config.vm.provider "libvirt" do |v|
+    v.memory = 4096
+  end
+
+  config.vm.provision :shell, inline: <<SCRIPT
+    dnf install -y \
+      --allowerasing \
+      --skip-broken \
+      make \
+      perl-Test \
+      perl-Test-Harness \
+      perl-Test-Simple \
+      perl-lib \
+      selinux-policy-devel \
+      gcc \
+      libselinux-devel \
+      net-tools \
+      netlabel_tools \
+      nftables \
+      iptables \
+      lksctp-tools-devel \
+      attr \
+      libbpf-devel \
+      keyutils-libs-devel \
+      quota \
+      xfsprogs-devel \
+      libuuid-devel \
+      e2fsprogs \
+      jfsutils \
+      dosfstools \
+      kernel-devel-"$(uname -r)" \
+      kernel-modules-"$(uname -r)"
+SCRIPT
+end
diff --git a/travis-ci/LICENSE b/travis-ci/LICENSE
deleted file mode 100644
index 1f95d26..0000000
--- a/travis-ci/LICENSE
+++ /dev/null
@@ -1,5 +0,0 @@
-Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
-
-The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
-
-THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
diff --git a/travis-ci/run-kvm-test.sh b/travis-ci/run-kvm-test.sh
deleted file mode 100755
index 81c57ff..0000000
--- a/travis-ci/run-kvm-test.sh
+++ /dev/null
@@ -1,141 +0,0 @@
-#!/usr/bin/env bash
-# SPDX-License-Identifier: MIT
-
-# Based on SELinux userspace CI scripts from:
-# https://github.com/SELinuxProject/selinux
-
-set -ex
-
-TEST_RUNNER="$1"
-
-if [ -z "$TEST_RUNNER" ]; then
-    echo "$0: expected script to be run on the command line!" 1>&2
-    exit 1
-fi
-
-#
-# Variables for controlling the Fedora Image version and download URLs.
-#
-if [ -z "$FEDORA_KIND" ] || [ -z "$FEDORA_MAJOR" ]; then
-    echo "$0: FEDORA_KIND and FEDORA_MAJOR must be set!" 1>&2
-    exit 1
-fi
-
-BASE_URL="https://download.fedoraproject.org/pub/fedora/linux/$FEDORA_KIND/$FEDORA_MAJOR/Cloud/x86_64/images"
-GPG_URL="https://getfedora.org/static/fedora.gpg"
-
-#
-# Travis gives us 7.5GB of RAM and two cores:
-# https://docs.travis-ci.com/user/reference/overview/
-#
-MEMORY=4096
-VCPUS="$(nproc)"
-
-#
-# Get the Fedora Cloud Image, It is a base image that small and ready to go, extract it and modify it with virt-sysprep
-#  - https://alt.fedoraproject.org/en/verify.html
-cd "$HOME"
-wget -r -nd -np -l 1 -H -e robots=off -A "*.raw.xz,*-CHECKSUM" "$BASE_URL"
-latest_image="$(ls -1q *.raw.xz | tail -n 1)"
-if [ -z "$latest_image" ]; then
-    echo "$0: no image file downloaded!" 1>&2
-    exit 1
-fi
-
-# Verify the image (skip GPG for unsigned rawhide images)
-if [ "$FEDORA_KIND" != "development" ]; then
-    curl "$GPG_URL" | gpg --import
-    gpg --verify-files ./*-CHECKSUM
-fi
-sha256sum --ignore-missing -c ./*-CHECKSUM
-
-# Extract the image
-unxz -T0 "$latest_image"
-latest_image="${latest_image%.xz}"
-
-# Search is needed for $HOME so virt service can access the image file.
-chmod a+x "$HOME"
-
-#
-# Modify the virtual image to:
-#   - Enable a login, we just use root
-#   - Enable passwordless login
-#     - Force a relabel to fix labels on ssh keys
-#
-sudo virt-sysprep -a "$latest_image" \
-  --root-password password:123456 \
-  --hostname fedoravm \
-  --append-line '/etc/ssh/sshd_config:PermitRootLogin yes' \
-  --append-line '/etc/ssh/sshd_config:PubkeyAuthentication yes' \
-  --mkdir /root/.ssh \
-  --upload "$HOME/.ssh/id_rsa.pub:/root/.ssh/authorized_keys" \
-  --chmod '0600:/root/.ssh/authorized_keys' \
-  --run-command 'chown root:root /root/.ssh/authorized_keys' \
-  --copy-in "$TRAVIS_BUILD_DIR:/root" \
-  --network \
-  --selinux-relabel
-
-#
-# Now we create a domain by using virt-install. This not only creates the domain, but runs the VM as well
-# It should be ready to go for ssh, once ssh starts.
-#
-sudo virt-install \
-  --name fedoravm \
-  --memory $MEMORY \
-  --vcpus $VCPUS \
-  --disk "$latest_image" \
-  --import --noautoconsole
-
-#
-# Here comes the tricky part, we have to figure out when the VM comes up AND we need the ip address for ssh. So we
-# can check the net-dhcp leases, for our host. We have to poll, and we will poll for up to 3 minutes in 6 second
-# intervals, so 30 poll attempts (0-29 inclusive).
-#
-# We have a full reboot + relabel, so first sleep gets us close
-#
-sleep 30
-for i in $(seq 0 29); do
-    echo "loop $i"
-    sleep 6s
-    # Get the leases, but tee it so it's easier to debug
-    sudo virsh net-dhcp-leases default | tee dhcp-leases.txt
-
-    # get our ipaddress
-    ipaddy="$(grep fedoravm dhcp-leases.txt | awk '{print $5}' | cut -d'/' -f 1-1)"
-    if [ -n "$ipaddy" ]; then
-        # found it, we're done looking, print it for debug logs
-        echo "ipaddy: $ipaddy"
-        break
-    fi
-    # it's empty/not found, loop back and try again.
-done
-
-# Did we find it? If not die.
-if [ -z "$ipaddy" ]; then
-    echo "$0: ipaddy zero length, exiting with error 1" 1>&2
-    exit 1
-fi
-
-#
-# Great we have a host running, ssh into it. We specify -o so
-# we don't get blocked on asking to add the servers key to
-# our known_hosts. Also, we need to forward the project directory
-# so forks know where to go.
-#
-
-# Check if kernel-modules-$(uname -r) can be installed from repos,
-# otherwise update kernel and reboot.
-if ! echo "dnf -q info --available kernel-modules-\$(uname -r)" | \
-    ssh -o StrictHostKeyChecking=no -q "root@$ipaddy"
-then
-    ssh -tt -o StrictHostKeyChecking=no -o LogLevel=QUIET "root@$ipaddy" \
-        dnf update -y kernel-core
-
-    sudo virsh reboot fedoravm
-    sleep 5
-    while ! nc -w 10 -z "$ipaddy" 22; do sleep 0.5s; done
-fi
-
-# And run the testsuite.
-project_dir="$(basename "$TRAVIS_BUILD_DIR")"
-ssh -tt -o StrictHostKeyChecking=no -o LogLevel=QUIET "root@$ipaddy" "SELINUX_DIR=/root/$project_dir /root/$project_dir/$TEST_RUNNER"
diff --git a/travis-ci/run-testsuite.sh b/travis-ci/run-testsuite.sh
deleted file mode 100755
index bd9073c..0000000
--- a/travis-ci/run-testsuite.sh
+++ /dev/null
@@ -1,58 +0,0 @@
-#!/usr/bin/env bash
-# SPDX-License-Identifier: MIT
-
-# Based on SELinux userspace CI scripts from:
-# https://github.com/SELinuxProject/selinux
-
-set -ex
-
-# CI Debug output if things go squirrely.
-getenforce
-id -Z
-nproc
-pwd
-
-# Turn off enforcing for the setup to prevent any weirdness from breaking
-# the CI.
-setenforce 0
-
-dnf install -y \
-    --allowerasing \
-    --skip-broken \
-    make \
-    perl-Test \
-    perl-Test-Harness \
-    perl-Test-Simple \
-    perl-lib \
-    selinux-policy-devel \
-    gcc \
-    libselinux-devel \
-    net-tools \
-    netlabel_tools \
-    nftables \
-    iptables \
-    lksctp-tools-devel \
-    attr \
-    libbpf-devel \
-    keyutils-libs-devel \
-    quota \
-    xfsprogs-devel \
-    libuuid-devel \
-    e2fsprogs \
-    jfsutils \
-    dosfstools \
-    kernel-devel-"$(uname -r)" \
-    kernel-modules-"$(uname -r)"
-
-#
-# Move to the selinux testsuite directory.
-#
-cd "$HOME/selinux-testsuite"
-
-# The testsuite must be run in enforcing mode
-setenforce 1
-
-#
-# Run the test suite
-#
-make test
-- 
2.29.2

