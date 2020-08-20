Return-Path: <SRS0=r9sn=B6=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3AA3C433E1
	for <selinux@archiver.kernel.org>; Thu, 20 Aug 2020 08:45:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 990882173E
	for <selinux@archiver.kernel.org>; Thu, 20 Aug 2020 08:45:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="T/8YlPw8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726825AbgHTIpP (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 20 Aug 2020 04:45:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:48552 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726809AbgHTIpB (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 20 Aug 2020 04:45:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1597913098;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aUKSZlrorsUk9vxGyhKmG/K6Ij258cS1uyNTD5KokRA=;
        b=T/8YlPw8gdx/HGf9D2jHt4Xf+6f89F70qTby+L1Z0BKjeZoAJ6wXA2bZTHBd+9Owq+KDBU
        jTfJ2AlU3O3GtvkMpAyxlLb3yZCMyW8vrJapMamWRsunX7FN/CV8+yqBlW2N+z5rpRx9gr
        lrJ/5kmXiBr9i+Hm8bPbV2FJPfG75d8=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-191-2QuKM0U4OhS6K7X9CuWMog-1; Thu, 20 Aug 2020 04:44:53 -0400
X-MC-Unique: 2QuKM0U4OhS6K7X9CuWMog-1
Received: by mail-wr1-f69.google.com with SMTP id m7so396436wrb.20
        for <selinux@vger.kernel.org>; Thu, 20 Aug 2020 01:44:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aUKSZlrorsUk9vxGyhKmG/K6Ij258cS1uyNTD5KokRA=;
        b=DI3hVzxiVIi/vakxGEnaHexYsjDNdZ8TCWKntVVrgDfCPufGs+I0t4Tv/i24I6/tOT
         v13Ty9AtMV0iAWo63IJNrGLj8ooDeMjHFDIPzq3ho8n4WtJ8TFcBcE4RILJVa9NZh1pr
         frE/oIjgEb/pH4YdKJDQ50ARn2yYsdj/J1ecfy1fPpwzi0HOuTvJvHJmQ4raFER1dGUt
         hby0KUd/tnfRaiNwphGwqVFqfIrIVl7oZEkSf5sHIqgiIbgCAkSDGdAAwcgc8gO8g+hp
         Lml/OSXmhjXvzRQct3G6enLpVELo8yvE1Vzgb9YpGzvpNjEQZguQKp1aYiOZdXTefXYf
         q2WA==
X-Gm-Message-State: AOAM532yzNq31jY3vJIL2hB62ekS7RnYHUkcJRJ6hmrmqobyfK6QJB1c
        lJy/EZuB+KWq+k+etQYTBobmngthMMJ9jiYSAXqilj6hIhZmZ7UNH2gUEO6x6XtbaDeoLre6xX5
        Omu3Eckx4JRBXqsswrA==
X-Received: by 2002:a5d:42c2:: with SMTP id t2mr2067092wrr.396.1597913092082;
        Thu, 20 Aug 2020 01:44:52 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxlVVNpdp4B13x2R+xtbca98Js8WsynfZiQ5ZJdQs8QMPLCzR5Y2jCvPUG7c0MLbgenUd7Z8Q==
X-Received: by 2002:a5d:42c2:: with SMTP id t2mr2067051wrr.396.1597913091527;
        Thu, 20 Aug 2020 01:44:51 -0700 (PDT)
Received: from omos.redhat.com ([2a02:8308:b103:4000:e83d:a4fb:e589:6902])
        by smtp.gmail.com with ESMTPSA id o66sm3110856wmb.27.2020.08.20.01.44.50
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Aug 2020 01:44:50 -0700 (PDT)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     selinux@vger.kernel.org
Subject: [PATCH testsuite v3 2/2] travis: run the full testsuite on a Fedora VM
Date:   Thu, 20 Aug 2020 10:44:47 +0200
Message-Id: <20200820084447.1030353-3-omosnace@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200820084447.1030353-1-omosnace@redhat.com>
References: <20200820084447.1030353-1-omosnace@redhat.com>
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

