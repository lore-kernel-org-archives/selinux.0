Return-Path: <SRS0=J0Ra=BR=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B424C433DF
	for <selinux@archiver.kernel.org>; Fri,  7 Aug 2020 13:26:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6BB892086A
	for <selinux@archiver.kernel.org>; Fri,  7 Aug 2020 13:26:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TMh9Zjl5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726038AbgHGN07 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 7 Aug 2020 09:26:59 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:23803 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725893AbgHGN06 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 7 Aug 2020 09:26:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1596806813;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=cpa1q2BZo7GVqyxsNSRjs/aS/H0z5EBeOZOOmbY2O/4=;
        b=TMh9Zjl5+02ZVG/5/LpiHV7QIerWCYvLLl3Oyo8QltyKa/UCwKzW1VJdACjnq7hpninyw8
        n+uy2DasDjMiIX9tMDvjiEsOWjU3mVFqa12EaO0EOQlN+eKOPwYdIYEh7GFmGe8PHnU7SW
        gobxc7VPO4FHAr1JHI0rNNQxEkYMFqo=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-312-XbzsRo9IMUa38rquLdzjpA-1; Fri, 07 Aug 2020 09:26:49 -0400
X-MC-Unique: XbzsRo9IMUa38rquLdzjpA-1
Received: by mail-ed1-f71.google.com with SMTP id l5so740557eds.16
        for <selinux@vger.kernel.org>; Fri, 07 Aug 2020 06:26:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cpa1q2BZo7GVqyxsNSRjs/aS/H0z5EBeOZOOmbY2O/4=;
        b=FHwPh4GqkOn93hxAuOK0H0PtKktuw22uHkz20nJBH0mO6O8L1Edr/kqehShbCcPvpm
         NgMRSFlNBWDPbJci4W9WIKUw9T26v8f5U6JsjHeK/1jck4js0/M/C9kjX/CDeMytD+QX
         YPGK2v6rgaiKFCnrls+bTeqHzbIGwDZ9COL5Utq8Y8GVTLwEwmEDY43QYhfGSC4UXlOc
         yh5T1Drb8C6ggy6EZNQ62dEYkAdMXySMzOWGcQPmG0a793WuTnptwXMN9XcDLVVwm9Hy
         BArZzjmH5v5lqTYguettFsIEhLfFsPTQnnI/C1+iOXr8I/NIqM2lnuCTVA8WT48kAO9t
         Irqg==
X-Gm-Message-State: AOAM532BO22YE4FzXgJXVVmqEwnyKnEIgFrFrykdQmg/a3ZdDVXW1lvs
        h21LF+st9JxDD7id8xN3jsfBkT74/x7DkJNBmOOKlXmpOyvKUIbQRZpZneVSJN/3PSL7OO0BRz2
        DEJ84+etRM35T/35s4A==
X-Received: by 2002:a17:906:7155:: with SMTP id z21mr9930239ejj.282.1596806807712;
        Fri, 07 Aug 2020 06:26:47 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwSr+t/6tOdxPLt6xyYcwGtoqwC1O9fJKrVotkpwZxokRyIpmCEh5DfFKGt7+wXysDeQ4cvRw==
X-Received: by 2002:a17:906:7155:: with SMTP id z21mr9930209ejj.282.1596806807329;
        Fri, 07 Aug 2020 06:26:47 -0700 (PDT)
Received: from omos.redhat.com ([2a02:8308:b13f:2100:8a6a:ec88:3ed7:44b3])
        by smtp.gmail.com with ESMTPSA id os4sm3372952ejb.117.2020.08.07.06.26.46
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2020 06:26:46 -0700 (PDT)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     selinux@vger.kernel.org
Subject: [PATCH testsuite] travis: run the full testsuite on a Fedora VM
Date:   Fri,  7 Aug 2020 15:26:40 +0200
Message-Id: <20200807132640.1787455-1-omosnace@redhat.com>
X-Mailer: git-send-email 2.26.2
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

The CI currently uses a F32 VM image which comes with a 5.6.6 kernel.
Eventually we might want to run on a more recent kernel/userspace, but
even this is already a big improvement over the old CI approach.

One downside is that with this patch we lose the test build against
refpolicy, but it shouldn't be too hard to add testing on a Debian VM
with refpolicy later on.

[1] https://github.com/SELinuxProject/selinux/commit/562d6d15272420542bf65da328bc5300219fce76

Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
---
 .travis.yml                         |  65 ++++-----------
 travis-ci/LICENSE                   |   5 ++
 travis-ci/enable-policy.sh          |  10 ---
 travis-ci/run-kvm-test.sh           | 122 ++++++++++++++++++++++++++++
 travis-ci/run-testsuite.sh          |  55 +++++++++++++
 travis-ci/setup-policy-fedora.sh    |  33 --------
 travis-ci/setup-policy-refpolicy.sh |  21 -----
 7 files changed, 198 insertions(+), 113 deletions(-)
 create mode 100644 travis-ci/LICENSE
 delete mode 100644 travis-ci/enable-policy.sh
 create mode 100755 travis-ci/run-kvm-test.sh
 create mode 100755 travis-ci/run-testsuite.sh
 delete mode 100644 travis-ci/setup-policy-fedora.sh
 delete mode 100644 travis-ci/setup-policy-refpolicy.sh

diff --git a/.travis.yml b/.travis.yml
index ae08c66..3cc5e03 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -2,30 +2,20 @@ language: c
 
 dist: bionic
 
+env: FEDORA_MAJOR="32" FEDORA_MINOR="1.6"
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
@@ -33,37 +23,14 @@ before_install:
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
index 0000000..614de6b
--- /dev/null
+++ b/travis-ci/run-kvm-test.sh
@@ -0,0 +1,122 @@
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
+if [ -z "$FEDORA_MAJOR" ] || [ -z "$FEDORA_MINOR" ]; then
+    echo "$0: FEDORA_MAJOR and FEDORA_MINOR must be set!" 1>&2
+    exit 1
+fi
+
+BASE_URL="https://download.fedoraproject.org/pub/fedora/linux/releases"
+IMAGE_BASE_NAME="Fedora-Cloud-Base-$FEDORA_MAJOR-$FEDORA_MINOR.x86_64"
+IMAGE_URL="$BASE_URL/$FEDORA_MAJOR/Cloud/x86_64/images/$IMAGE_BASE_NAME.raw.xz"
+CHECK_URL="$BASE_URL/$FEDORA_MAJOR/Cloud/x86_64/images/Fedora-Cloud-$FEDORA_MAJOR-$FEDORA_MINOR-x86_64-CHECKSUM"
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
+wget "$IMAGE_URL"
+
+# Verify the image
+curl "$GPG_URL" | gpg --import
+wget "$CHECK_URL"
+gpg --verify-files ./*-CHECKSUM
+sha256sum --ignore-missing -c ./*-CHECKSUM
+
+# Extract the image
+unxz -T0 "$IMAGE_BASE_NAME.raw.xz"
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
+sudo virt-sysprep -a "$IMAGE_BASE_NAME.raw" \
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
+  --disk "$IMAGE_BASE_NAME.raw" \
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
index 0000000..7c2c560
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
+# Get the selinux testsuite, but don't clone it in selinux git directory, move to $HOME
+# first.
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

