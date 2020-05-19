Return-Path: <SRS0=GWJJ=7B=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_BL,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26A35C433E0
	for <selinux@archiver.kernel.org>; Tue, 19 May 2020 15:15:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EE169207FB
	for <selinux@archiver.kernel.org>; Tue, 19 May 2020 15:15:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MmUSZmY2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728994AbgESPPJ (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 19 May 2020 11:15:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728925AbgESPPJ (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 19 May 2020 11:15:09 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EDB9C08C5C0
        for <selinux@vger.kernel.org>; Tue, 19 May 2020 08:15:09 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id z1so47603pfn.3
        for <selinux@vger.kernel.org>; Tue, 19 May 2020 08:15:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=V1lzHlYoMQYHFk+iu36/3GMJyBtIafnmYSFTE2JNxZE=;
        b=MmUSZmY2it/j86OpyW8VluxzrktIAeIIQi7yBeMWdaA1zQwXrkW/e94dzDGnaB3B+f
         egqFohetAa132t4MvuGu6qdxkhO7SiltyVqykiAcXnsQRN3RagfQ51WoxZJZeRY3Ccg4
         tgIjK0FvHvj6EwWqW10r6N2AE0AbVb3oY4Q+7I1QSqT/KCUR3+hU9yF86j6G1Zh5Fz+P
         kEfG4xO5NYEB6hOb5a7F9sRDPYza2ei1PI3BPLM+kX2dHOWGoZ/0kp7Xso3DwQWq/n21
         xGqC3JbZOfMUFJvOvN59tNp1kS6IMLD9+BIGx/VeDNTS3KqWlro1jGRG0BV6RQKt++62
         EoFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=V1lzHlYoMQYHFk+iu36/3GMJyBtIafnmYSFTE2JNxZE=;
        b=U6pZ2KzG0Qn7hU5kRuO1U2HOw+PGbWGQss5Z7JhfyTTZcoF7LEkM4Hz7rfeVa06PWi
         JCzmVwri6gXa9QzqCBc5CjWEb9ugtQUK8WseHaElMZ1nEKCczOvjc88PKxks/zrYKOn7
         38Gqb1GOTwiQ5ZenVyj6zP1h/fJHazC1e0WPkTEL4qADwr2i9jo6Bmdnu2pT39zLCpWd
         d+oW9PktgmuUxRMu4b9d63yjEa431Wh3P/6LpP+S+fzQavpzL9PgpXMLlhJv19gUFtRu
         p5iOuqJtZ4Q4rokM9vnnGWqpQatuaXXkDtjGaedhlMXE3V2QC2IifJdfSEYXULDxgGQL
         lcZQ==
X-Gm-Message-State: AOAM531u/lxFVmWk1WcHc8CmlAd9tpDSmBSfcb4bZ8/Qs2liUMBhH+vX
        L9HiffFW0IcnJ9+3iz5RSS+TVf7cVac=
X-Google-Smtp-Source: ABdhPJxsg9bRi7WYXzIMPxAFmvqtLVZ0BxpLCuMErp38bYKkd11fsZCR4IJhnfR9wByNQndjQqabxA==
X-Received: by 2002:a65:678c:: with SMTP id e12mr1909925pgr.375.1589901308172;
        Tue, 19 May 2020 08:15:08 -0700 (PDT)
Received: from localhost.localdomain ([134.134.139.83])
        by smtp.gmail.com with ESMTPSA id i12sm2354655pjk.37.2020.05.19.08.15.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2020 08:15:07 -0700 (PDT)
From:   bill.c.roberts@gmail.com
X-Google-Original-From: william.c.roberts@intel.com
To:     selinux@vger.kernel.org
Cc:     William Roberts <william.c.roberts@intel.com>
Subject: [PATCH] ci: run SE Linux kernel test suite
Date:   Tue, 19 May 2020 10:14:57 -0500
Message-Id: <20200519151457.31618-2-william.c.roberts@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200519151457.31618-1-william.c.roberts@intel.com>
References: <20200519151457.31618-1-william.c.roberts@intel.com>
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

From: William Roberts <william.c.roberts@intel.com>

The current CI runs the userspace tooling and librariers against
policy files, but cannot test against an SE Linux enabled kernel. Thus,
some tests are not being done in the CI. Travis, unfortunately only
provides Ubuntu images, so in order to run against a modern distro with
SE Linux in enforcing mode, we need to launch a KVM with something like
Fedora.

This patch enables this support by launching a Fedora32 Cloud Image with
the selinux userspace library passed on from the travis clone, it then
builds and replaces the current selinux bits on the Fedora image and
runs the SE Linux testsuite.

Signed-off-by: William Roberts <william.c.roberts@intel.com>
---
 .travis.yml                      |   8 +++
 scripts/ci/README.md             |   8 +++
 scripts/ci/fedora-test-runner.sh |  79 +++++++++++++++++++++
 scripts/ci/travis-kvm-setup.sh   | 113 +++++++++++++++++++++++++++++++
 4 files changed, 208 insertions(+)
 create mode 100644 scripts/ci/README.md
 create mode 100755 scripts/ci/fedora-test-runner.sh
 create mode 100755 scripts/ci/travis-kvm-setup.sh

diff --git a/.travis.yml b/.travis.yml
index c36e721a5e1d..63a856672f9b 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -34,6 +34,14 @@ matrix:
       env: PYVER=python3.8 RUBYLIBVER=2.7 LINKER=gold
     - compiler: clang
       env: PYVER=python3.8 RUBYLIBVER=2.7 LINKER=bfd
+  include:
+    - compiler: gcc
+      env: TRAVIS_RUN_KVM=true
+      install:
+        - skip
+      before_script:
+        - skip
+      script: scripts/ci/travis-kvm-setup.sh
 
 # Use Travis-CI Ubuntu 18.04 Bionic Beaver, "full image" variant
 sudo: required
diff --git a/scripts/ci/README.md b/scripts/ci/README.md
new file mode 100644
index 000000000000..04a134a438c2
--- /dev/null
+++ b/scripts/ci/README.md
@@ -0,0 +1,8 @@
+# Continuous Integration Scripts
+
+The scripts under `scripts/ci` are designed specifically
+for the Travis CI system. While nothing prevents you
+from mimicking that environment and using them locally,
+they are not applicable for general consumption. Any
+thing in this directory should never be considered as
+a stable API.
diff --git a/scripts/ci/fedora-test-runner.sh b/scripts/ci/fedora-test-runner.sh
new file mode 100755
index 000000000000..8d4b1bf7b8f5
--- /dev/null
+++ b/scripts/ci/fedora-test-runner.sh
@@ -0,0 +1,79 @@
+#!/usr/bin/env bash
+
+set -ev
+
+# CI Debug output if things go squirrely.
+getenforce
+id -Z
+nproc
+pwd
+
+dnf install -y \
+    git \
+    audit-libs-devel \
+    bison \
+    bzip2-devel \
+    CUnit-devel \
+    diffutils \
+    flex \
+    gcc \
+    gettext \
+    glib2-devel \
+    make \
+    libcap-devel \
+    libcap-ng-devel \
+    pam-devel \
+    pcre-devel \
+    xmlto \
+    python3-devel \
+    ruby-devel \
+    swig \
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
+    kernel-devel \
+    quota \
+    xfsprogs-devel \
+    libuuid-devel \
+    kernel-devel-$(uname -r) \
+    kernel-modules-$(uname -r)
+
+#
+# Move to selinux code and build
+#
+cd ~/selinux
+
+# Show HEAD commit for sanity checking
+git log -1
+
+#
+# Build and replace userspace components
+#
+# Note: You can't use parallel builds here (make -jX), you'll end up
+# with race conditions that manifest like:
+# semanage_store.lo: file not recognized: file format not recognized
+#
+make LIBDIR=/usr/lib64 SHLIBDIR=/lib64 install install-pywrap relabel
+
+#
+# Get the selinux testsuite, but don't clone it in ~/selinux, move to ~
+# first.
+#
+cd ~
+git clone --depth=1 https://github.com/SELinuxProject/selinux-testsuite.git
+cd selinux-testsuite
+
+#
+# Run the test suite
+#
+make test
diff --git a/scripts/ci/travis-kvm-setup.sh b/scripts/ci/travis-kvm-setup.sh
new file mode 100755
index 000000000000..19287fd21642
--- /dev/null
+++ b/scripts/ci/travis-kvm-setup.sh
@@ -0,0 +1,113 @@
+#!/usr/bin/env bash
+
+set -ev
+
+TEST_RUNNER="scripts/ci/fedora-test-runner.sh"
+
+#
+# Travis gives us 7.5GB of RAM and two cores:
+# https://docs.travis-ci.com/user/reference/overview/
+#
+MEMORY=4096
+VCPUS=2
+
+# Install these here so other builds don't have to wait on these deps to download and install
+sudo apt-get install qemu-kvm libvirt-bin virtinst bridge-utils cpu-checker libguestfs-tools
+
+sudo usermod -a -G kvm,libvirt,libvirt-qemu $USER
+
+# Verify that KVM is working, useful if Travis every changes anything.
+kvm-ok
+
+sudo systemctl enable libvirtd
+sudo systemctl start libvirtd
+
+# Set up a key so we can ssh into the VM
+ssh-keygen -N "" -f "$HOME/.ssh/id_rsa"
+
+#
+# Get the Fedora Cloud Image, It is a base image that small and ready to go, extract it and modify it with virt-sysprep
+#  - https://alt.fedoraproject.org/en/verify.html
+cd $HOME
+wget https://download.fedoraproject.org/pub/fedora/linux/releases/32/Cloud/x86_64/images/Fedora-Cloud-Base-32-1.6.x86_64.raw.xz
+
+# Verify the image
+curl https://getfedora.org/static/fedora.gpg | gpg --import
+wget https://getfedora.org/static/checksums/Fedora-Cloud-32-1.6-x86_64-CHECKSUM
+gpg --verify-files *-CHECKSUM
+sha256sum --ignore-missing -c *-CHECKSUM
+
+# Extract the image
+unxz -T0 Fedora-Cloud-Base-32-1.6.x86_64.raw.xz
+
+# Search is needed for $HOME so virt service can access the image file.
+chmod a+x $HOME
+
+#
+# Modify the virtual image to:
+#   - Enable a login, we just use root
+#   - Enable passwordless login
+#     - Force a relabel to fix labels on ssh keys
+#
+sudo virt-sysprep -a "$HOME/Fedora-Cloud-Base-32-1.6.x86_64.raw" \
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
+  --disk "$HOME/Fedora-Cloud-Base-32-1.6.x86_64.raw" \
+  --import --noautoconsole
+
+#
+# Here comes the tricky part, we have to figure out when the VM comes up AND we need the ip address for ssh. So we
+# can check the net-dhcp leases, for our host. We have to poll, and we will poll for up 3 minutes in 6 second
+# intervals, so 30 poll attempts (0-29 inclusive). I don't know of a better way to do this.
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
+    ipaddy=$(grep fedoravm dhcp-leases.txt | awk {'print $5'} | cut -d'/' -f 1-1)
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
+    echo "ipaddy zero length, exiting with error 1"
+    exit 1
+fi
+
+#
+# Great we have a host running, ssh into it. We specify -o so
+# we don't get blocked on asking to add the servers key to
+# our known_hosts.
+#
+ssh -o StrictHostKeyChecking=no "root@$ipaddy" "/root/selinux/$TEST_RUNNER"
+
+exit 0
-- 
2.17.1

