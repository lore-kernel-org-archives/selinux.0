Return-Path: <SRS0=GpsN=BV=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82225C433E0
	for <selinux@archiver.kernel.org>; Tue, 11 Aug 2020 08:46:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 55EA2206B2
	for <selinux@archiver.kernel.org>; Tue, 11 Aug 2020 08:46:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KoxoDlDs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728224AbgHKIqK (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 11 Aug 2020 04:46:10 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:47646 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728326AbgHKIqI (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 11 Aug 2020 04:46:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1597135566;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aUKSZlrorsUk9vxGyhKmG/K6Ij258cS1uyNTD5KokRA=;
        b=KoxoDlDsHrqvaK+QAcFUgu7OrexOnvHXVmzIAMv3cBU5M3pjCg5+MZ+3PF5sn+BjJ7xf6m
        Roie8KpQrwCtw9fMaY/92mx/L1DlD76flY1i8wqSITtM3ls38CXsFJ1svTh6VspjPD/306
        9gm+KfEn4ScgZ13K+3HasZ70rNRKv68=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-199-ekH4EcnzM4Ce8nNJ_QpY2Q-1; Tue, 11 Aug 2020 04:46:01 -0400
X-MC-Unique: ekH4EcnzM4Ce8nNJ_QpY2Q-1
Received: by mail-wm1-f69.google.com with SMTP id a5so604119wmj.5
        for <selinux@vger.kernel.org>; Tue, 11 Aug 2020 01:46:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aUKSZlrorsUk9vxGyhKmG/K6Ij258cS1uyNTD5KokRA=;
        b=VnyycoVDev7Xk32igqu5xoaWX+ZRB8oV7ImPwNNkQrrvdVO/IOBXBXufIelwuj+ZQK
         GU3eO5rL1vPZbBl2DsUGQ2PW0zZE3v2W9272531LudoNwjRu2iTJzHlxD5ADmNFlK0ds
         +NZ0kfrcXJb5Mm7/pI+g0YlYDNX7ZGbECbki7eMTFW1TUxH4A9mh5LD9OaV8bEYAtVO7
         qRbVUJWJbobIo2ZuCICuiSg+Eddw5hzV5RF0mjTJK/cg7EFRL8Fd0D3mHve3DyT/oIll
         ncgFpTUjutXRfyXd7+0kGqJCLIseiWQMWGfRpnb/GP7f+2NpgKK2q9ePkhrY3Tk1939D
         J1MA==
X-Gm-Message-State: AOAM532SYEECUPiwIuXDck9lsUB1Ms6STkVL2yDMlWBQ+FLssgIhB5lh
        Zfkr9GKU1EMbsyWTjbWS6tNer61ys8szE/UE+gy6cLhWM917hl8V+0nH5L6bgHJxtNYlySu9Y17
        zSdQU9FVCNlIj4yio6A==
X-Received: by 2002:adf:9361:: with SMTP id 88mr30948702wro.403.1597135560310;
        Tue, 11 Aug 2020 01:46:00 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy1563MDjvcHZKfJS4kd1g8WRjpUWM7d3nBvfUekEyTo+miW8tvJq3FollJjfXcAAdOsy7RRA==
X-Received: by 2002:adf:9361:: with SMTP id 88mr30948663wro.403.1597135559737;
        Tue, 11 Aug 2020 01:45:59 -0700 (PDT)
Received: from omos.redhat.com ([2a02:8308:b13f:2100:8a6a:ec88:3ed7:44b3])
        by smtp.gmail.com with ESMTPSA id a11sm27674310wrq.0.2020.08.11.01.45.58
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Aug 2020 01:45:58 -0700 (PDT)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     selinux@vger.kernel.org
Subject: [PATCH testsuite v2 2/2] travis: run the full testsuite on a Fedora VM
Date:   Tue, 11 Aug 2020 10:45:55 +0200
Message-Id: <20200811084555.105374-3-omosnace@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200811084555.105374-1-omosnace@redhat.com>
References: <20200811084555.105374-1-omosnace@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

This patch removes the old hackery to test-build the testsuite and
replaces it with scripts that run the full testsuite on a Fedora VM. The
scripts are based on William Roberts' work on SELinux userspace CI [1],
which does a similar thing.

This patch enables testing on Fedora 32 (the image ships with kernel
5.6.6) and Rawhide nightly images (with kernels close to mainline).
Switching to other versions can be controlled via CI environment
variables.

One downside is that with this patch we lose the test build against
refpolicy, but it shouldn't be too hard to add testing on a Debian VM
with refpolicy later on.

[1] https://github.com/SELinuxProject/selinux/commit/562d6d15272420542bf65da328bc5300219fce76

Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
---
 .travis.yml                         |  68 +++++----------
 travis-ci/LICENSE                   |   5 ++
 travis-ci/enable-policy.sh          |  10 ---
 travis-ci/run-kvm-test.sh           | 124 ++++++++++++++++++++++++++++
 travis-ci/run-testsuite.sh          |  55 ++++++++++++
 travis-ci/setup-policy-fedora.sh    |  33 --------
 travis-ci/setup-policy-refpolicy.sh |  21 -----
 7 files changed, 203 insertions(+), 113 deletions(-)
 create mode 100644 travis-ci/LICENSE
 delete mode 100644 travis-ci/enable-policy.sh
 create mode 100755 travis-ci/run-kvm-test.sh
 create mode 100755 travis-ci/run-testsuite.sh
 delete mode 100644 travis-ci/setup-policy-fedora.sh
 delete mode 100644 travis-ci/setup-policy-refpolicy.sh

diff --git a/.travis.yml b/.travis.yml
index ae08c66..9488807 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -2,30 +2,23 @@ language: c
 
 dist: bionic
 
+env:
+  matrix:
+    - FEDORA_KIND="releases" FEDORA_MAJOR="32"
+    - FEDORA_KIND="development" FEDORA_MAJOR="rawhide"
+
 addons:
   apt:
     packages:
       - astyle
-      - libselinux1-dev
-      - libsctp-dev
-      - libaudit-dev
-      - libcap-dev
-      - libdbus-glib-1-dev
-      - xmlto
-      - xfslibs-dev
-      - uuid-dev
-
-cache:
-  directories:
-    - selinux-policy
-    - container-selinux
-    - refpolicy
+      - qemu-kvm
+      - libvirt-bin
+      - virtinst
+      - bridge-utils
+      - libguestfs-tools
+      - cpu-checker
 
 before_install:
-  # install headers for module_load test
-  - sudo apt-get install linux-headers-$(uname -r)
-  - export LIBRARY_PATH=/usr/local/lib
-  - export LD_LIBRARY_PATH=/usr/local/lib
   # FYI: known good with HEAD at 8551fc60fc515cd290ba38ee8c758c1f4df52b56
   - git clone https://github.com/perltidy/perltidy.git perltidy
   - |
@@ -33,37 +26,14 @@ before_install:
      perl Makefile.PL &&
      make PREFIX=/usr/local &&
      sudo make install PREFIX=/usr/local)
-  # install libbpf from sources
-  - git clone https://github.com/libbpf/libbpf
-  - (cd libbpf/src && make PREFIX=/usr/local)
-  - (cd libbpf/src && sudo make install PREFIX=/usr/local)
-  # install keyutils from sources
-  - git clone https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/keyutils.git
-  - KEYUTILS_OPTS=""
-  - KEYUTILS_OPTS+="BINDIR=/usr/local/bin SBINDIR=/usr/local/sbin "
-  - KEYUTILS_OPTS+="LIBDIR=/usr/local/lib USRLIBDIR=/usr/local/lib "
-  - KEYUTILS_OPTS+="INCLUDEDIR=/usr/local/include "
-  - KEYUTILS_OPTS+="SHAREDIR=/usr/local/share/keyutils MANDIR=/usr/local/share/man"
-  - (cd keyutils && make $KEYUTILS_OPTS)
-  - (cd keyutils && sudo make install $KEYUTILS_OPTS)
-  # install SELinux userspace from source
-  - git clone https://github.com/SELinuxProject/selinux
-  - (cd selinux && sudo make install PREFIX=/usr/local SHLIBDIR=/usr/local/lib)
-  # install Fedora policy and refpolicy
-  - bash travis-ci/setup-policy-fedora.sh
-  - bash travis-ci/setup-policy-refpolicy.sh
-  # establish a fake "selinuxfs" mount (policy/Makefile just greps for selinuxfs)
-  - mkdir -p /tmp/fake-selinuxfs/policy_capabilities
-  - echo 1 > /tmp/fake-selinuxfs/policy_capabilities/extended_socket_class
-  - mkdir -p /tmp/fake-selinuxfs/initial_contexts
-  - echo system_u:system_r:kernel_t:s0 > /tmp/fake-selinuxfs/initial_contexts/kernel
-  - echo 999 >/tmp/fake-selinuxfs/policyvers
+  - sudo usermod -a -G kvm,libvirt,libvirt-qemu "$USER"
+  # Verify that KVM is working, useful if Travis ever changes anything.
+  - kvm-ok
+  - sudo systemctl enable libvirtd
+  - sudo systemctl start libvirtd
+  # Set up a key so we can ssh into the VM
+  - ssh-keygen -N "" -f "$HOME/.ssh/id_rsa"
 
 script:
   - tools/check-syntax -f && git diff --exit-code
-  - |
-    bash travis-ci/enable-policy.sh targeted &&
-    make SELINUXFS=/tmp/fake-selinuxfs PREFIX=/usr/local POLDEV=/usr/share/selinux/targeted
-  - |
-    bash travis-ci/enable-policy.sh refpolicy &&
-    make SELINUXFS=/tmp/fake-selinuxfs PREFIX=/usr/local POLDEV=/usr/share/selinux/refpolicy
+  - bash travis-ci/run-kvm-test.sh travis-ci/run-testsuite.sh
diff --git a/travis-ci/LICENSE b/travis-ci/LICENSE
new file mode 100644
index 0000000..1f95d26
--- /dev/null
+++ b/travis-ci/LICENSE
@@ -0,0 +1,5 @@
+Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
+
+The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
+
+THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
diff --git a/travis-ci/enable-policy.sh b/travis-ci/enable-policy.sh
deleted file mode 100644
index ae53fbe..0000000
--- a/travis-ci/enable-policy.sh
+++ /dev/null
@@ -1,10 +0,0 @@
-#!/bin/bash
-
-set -e
-
-# create a dummy /etc/selinux/config
-sudo mkdir -p /etc/selinux
-sudo tee /etc/selinux/config >/dev/null <<EOF
-SELINUX=disabled
-SELINUXTYPE=$1
-EOF
diff --git a/travis-ci/run-kvm-test.sh b/travis-ci/run-kvm-test.sh
new file mode 100755
index 0000000..70fcf08
--- /dev/null
+++ b/travis-ci/run-kvm-test.sh
@@ -0,0 +1,124 @@
+#!/usr/bin/env bash
+# SPDX-License-Identifier: MIT
+
+# Based on SELinux userspace CI scripts from:
+# https://github.com/SELinuxProject/selinux
+
+set -ex
+
+TEST_RUNNER="$1"
+
+if [ -z "$TEST_RUNNER" ]; then
+    echo "$0: expected script to be run on the command line!" 1>&2
+    exit 1
+fi
+
+#
+# Variables for controlling the Fedora Image version and download URLs.
+#
+if [ -z "$FEDORA_KIND" ] || [ -z "$FEDORA_MAJOR" ]; then
+    echo "$0: FEDORA_KIND and FEDORA_MAJOR must be set!" 1>&2
+    exit 1
+fi
+
+BASE_URL="https://download.fedoraproject.org/pub/fedora/linux/$FEDORA_KIND/$FEDORA_MAJOR/Cloud/x86_64/images"
+GPG_URL="https://getfedora.org/static/fedora.gpg"
+
+#
+# Travis gives us 7.5GB of RAM and two cores:
+# https://docs.travis-ci.com/user/reference/overview/
+#
+MEMORY=4096
+VCPUS="$(nproc)"
+
+#
+# Get the Fedora Cloud Image, It is a base image that small and ready to go, extract it and modify it with virt-sysprep
+#  - https://alt.fedoraproject.org/en/verify.html
+cd "$HOME"
+wget -r -nd -np -l 1 -H -e robots=off -A "*.raw.xz,*-CHECKSUM" "$BASE_URL"
+if [ $(ls -1q *.raw.xz | wc -l) -ne 1 ]; then
+    echo "$0: too many image files downloaded!" 1>&2
+    exit 1
+fi
+
+# Verify the image (skip GPG for unsigned rawhide images)
+if [ "$FEDORA_KIND" != "development" ]; then
+    curl "$GPG_URL" | gpg --import
+    gpg --verify-files ./*-CHECKSUM
+fi
+sha256sum --ignore-missing -c ./*-CHECKSUM
+
+# Extract the image
+unxz -T0 *.raw.xz
+
+# Search is needed for $HOME so virt service can access the image file.
+chmod a+x "$HOME"
+
+#
+# Modify the virtual image to:
+#   - Enable a login, we just use root
+#   - Enable passwordless login
+#     - Force a relabel to fix labels on ssh keys
+#
+sudo virt-sysprep -a *.raw \
+  --root-password password:123456 \
+  --hostname fedoravm \
+  --append-line '/etc/ssh/sshd_config:PermitRootLogin yes' \
+  --append-line '/etc/ssh/sshd_config:PubkeyAuthentication yes' \
+  --mkdir /root/.ssh \
+  --upload "$HOME/.ssh/id_rsa.pub:/root/.ssh/authorized_keys" \
+  --chmod '0600:/root/.ssh/authorized_keys' \
+  --run-command 'chown root:root /root/.ssh/authorized_keys' \
+  --copy-in "$TRAVIS_BUILD_DIR:/root" \
+  --network \
+  --selinux-relabel
+
+#
+# Now we create a domain by using virt-install. This not only creates the domain, but runs the VM as well
+# It should be ready to go for ssh, once ssh starts.
+#
+sudo virt-install \
+  --name fedoravm \
+  --memory $MEMORY \
+  --vcpus $VCPUS \
+  --disk *.raw \
+  --import --noautoconsole
+
+#
+# Here comes the tricky part, we have to figure out when the VM comes up AND we need the ip address for ssh. So we
+# can check the net-dhcp leases, for our host. We have to poll, and we will poll for up to 3 minutes in 6 second
+# intervals, so 30 poll attempts (0-29 inclusive).
+#
+# We have a full reboot + relabel, so first sleep gets us close
+#
+sleep 30
+for i in $(seq 0 29); do
+    echo "loop $i"
+    sleep 6s
+    # Get the leases, but tee it so it's easier to debug
+    sudo virsh net-dhcp-leases default | tee dhcp-leases.txt
+
+    # get our ipaddress
+    ipaddy="$(grep fedoravm dhcp-leases.txt | awk '{print $5}' | cut -d'/' -f 1-1)"
+    if [ -n "$ipaddy" ]; then
+        # found it, we're done looking, print it for debug logs
+        echo "ipaddy: $ipaddy"
+        break
+    fi
+    # it's empty/not found, loop back and try again.
+done
+
+# Did we find it? If not die.
+if [ -z "$ipaddy" ]; then
+    echo "$0: ipaddy zero length, exiting with error 1" 1>&2
+    exit 1
+fi
+
+#
+# Great we have a host running, ssh into it. We specify -o so
+# we don't get blocked on asking to add the servers key to
+# our known_hosts. Also, we need to forward the project directory
+# so forks know where to go.
+#
+project_dir="$(basename "$TRAVIS_BUILD_DIR")"
+ssh -tt -o StrictHostKeyChecking=no -o LogLevel=QUIET "root@$ipaddy" "SELINUX_DIR=/root/$project_dir /root/$project_dir/$TEST_RUNNER"
diff --git a/travis-ci/run-testsuite.sh b/travis-ci/run-testsuite.sh
new file mode 100755
index 0000000..c19b961
--- /dev/null
+++ b/travis-ci/run-testsuite.sh
@@ -0,0 +1,55 @@
+#!/usr/bin/env bash
+# SPDX-License-Identifier: MIT
+
+# Based on SELinux userspace CI scripts from:
+# https://github.com/SELinuxProject/selinux
+
+set -ex
+
+# CI Debug output if things go squirrely.
+getenforce
+id -Z
+nproc
+pwd
+
+# Turn off enforcing for the setup to prevent any weirdness from breaking
+# the CI.
+setenforce 0
+
+dnf clean all -y
+dnf install -y \
+    --allowerasing \
+    --skip-broken \
+    make \
+    perl-Test \
+    perl-Test-Harness \
+    perl-Test-Simple \
+    perl-lib \
+    selinux-policy-devel \
+    gcc \
+    libselinux-devel \
+    net-tools \
+    netlabel_tools \
+    iptables \
+    lksctp-tools-devel \
+    attr \
+    libbpf-devel \
+    keyutils-libs-devel \
+    quota \
+    xfsprogs-devel \
+    libuuid-devel \
+    kernel-devel-"$(uname -r)" \
+    kernel-modules-"$(uname -r)"
+
+#
+# Move to the selinux testsuite directory.
+#
+cd "$HOME/selinux-testsuite"
+
+# The testsuite must be run in enforcing mode
+setenforce 1
+
+#
+# Run the test suite
+#
+make test
diff --git a/travis-ci/setup-policy-fedora.sh b/travis-ci/setup-policy-fedora.sh
deleted file mode 100644
index a07c990..0000000
--- a/travis-ci/setup-policy-fedora.sh
+++ /dev/null
@@ -1,33 +0,0 @@
-#!/bin/bash
-
-set -ex
-
-if ! [ -d selinux-policy/.git ]; then
-	git clone --recursive https://github.com/fedora-selinux/selinux-policy
-else
-	git -C selinux-policy fetch origin
-	git -C selinux-policy/policy/modules/contrib fetch origin
-fi
-git -C selinux-policy checkout origin/rawhide
-git -C selinux-policy/policy/modules/contrib checkout origin/rawhide
-
-if ! [ -d container-selinux/.git ]; then
-	git clone https://github.com/containers/container-selinux.git
-	for f in container.if container.te; do
-		ln -s ../../../../container-selinux/$f \
-			selinux-policy/policy/modules/contrib/$f
-	done
-else
-	git -C container-selinux fetch origin
-fi
-git -C container-selinux checkout origin/master
-
-cd selinux-policy
-
-grep -q refpolicy build.conf && sed -i 's/refpolicy/targeted/' build.conf
-
-make -j`nproc --all` BINDIR=/usr/local/bin SBINDIR=/usr/local/sbin
-sudo make install install-headers
-
-# workaround for different Makefile location in Fedora RPMs
-sudo ln -s include/Makefile /usr/share/selinux/targeted/Makefile
diff --git a/travis-ci/setup-policy-refpolicy.sh b/travis-ci/setup-policy-refpolicy.sh
deleted file mode 100644
index d63e7e4..0000000
--- a/travis-ci/setup-policy-refpolicy.sh
+++ /dev/null
@@ -1,21 +0,0 @@
-#!/bin/bash
-
-set -ex
-
-if ! [ -d refpolicy/.git ]; then
-	git clone https://github.com/SELinuxProject/refpolicy
-else
-	git -C refpolicy fetch origin
-fi
-
-cd refpolicy
-
-git checkout origin/master
-
-make conf
-
-make -j`nproc --all` BINDIR=/usr/local/bin SBINDIR=/usr/local/sbin
-sudo make install install-headers
-
-# workaround for different Makefile location in Fedora RPMs
-sudo ln -s include/Makefile /usr/share/selinux/refpolicy/Makefile
-- 
2.26.2

