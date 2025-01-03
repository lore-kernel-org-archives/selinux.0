Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 722B54C7C
	for <selinux@vger.kernel.org>; Fri,  3 Jan 2025 10:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735898534; cv=none; b=S0EOOI/coZuddRw9yPh7wr8EPM45vwFarSbvHU+aqqjyc/sCQZ/RsAmp1qB3COO0K5K1LmTLENeaYhMvbzntwXtMVxe//hO5mtMWnSuaxNYPPNL5BUA09QeJzUGH/dU0MPmb7ZXOWxLpfyrTUbhRfVVu59ot9giuC9QsGTdvR5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735898534; c=relaxed/simple;
	bh=kGzrhsDxsH/B7IWZwVquyyVckF33w8koVpShUkDRvSc=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D+oL0O1YCnsxbqecsEZYHn/4ps6Z6VHLJbtG34lU3wJXbnRNzLvTCEYegkb+7cA3G5z9Cy5nQVGRFcFbISIxwdadX76O++COHvQ7c/ceIguWB0TwRPxtvIRDVGAW3kOBJkxAajN+eGVslVAUcW4DKc4UQALE9CG1DVAMuV28PVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TG/E0rNl; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TG/E0rNl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1735898530;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=O6YdC2IQUNwO96Mn/xfUBnhvIKnpe4MpUL0cTtjsXlo=;
	b=TG/E0rNl7JXici/BKEHnHsmU3GKQXAjATvIPeMAw8nnriZWlS+TglqSoDyp0qClBK49pCL
	m9Jy/UgK/lXrR5DeAtnBfEolWML5g5u6BQ1wP+XG4KgTPu2qkazfOBz8udta3BsWCXE/36
	iB2D0+gUVKWAa7i61Cp/op4rOoHKiPE=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-675-tqT6t1Q4PdeW3zqKgZGhpw-1; Fri, 03 Jan 2025 05:02:08 -0500
X-MC-Unique: tqT6t1Q4PdeW3zqKgZGhpw-1
X-Mimecast-MFC-AGG-ID: tqT6t1Q4PdeW3zqKgZGhpw
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4361c040ba8so29607615e9.1
        for <selinux@vger.kernel.org>; Fri, 03 Jan 2025 02:02:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735898527; x=1736503327;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O6YdC2IQUNwO96Mn/xfUBnhvIKnpe4MpUL0cTtjsXlo=;
        b=Vr+pmU4CVtrb+gExzeDBabGgPfTOURZNNdtCtawBAjoMpsT2hoxIdw5y53l//62YZN
         VdC1ddNRfPLNGbcSbhKDMKlbdRq/6hjOS5Uo9M4I5N36yraR9P/0SD65mfSelNtDP8Zw
         QQJu3oPAWCDqMJ+A8ly+/oaywg33OyqV1mPYFdSt8l4c/yTkPQDqhYP88M3fkm9QJ6hS
         vnMPhpvbdYQW+1NCrwzeYAlTbk1Ja4eq7wPPtxmiIsPEVVgmPfLBSSxtaWCfp/d8H0qv
         wQvWBc6XXhbx7fkzL6zV8N9l2HRjZDTxml0sdrmK+7neHDL98L72iJDsS5tK4BLDFYCO
         7cjQ==
X-Gm-Message-State: AOJu0YxExoz7qRo0GXGRQso8BTdQkBz4K7cL4DtKnKEq6J1gmkriSORi
	iwQBJ5W+KOkToVZZtjZgcBJz0ZAxGYtgZDDMdMH6sfVvy+CeYDUyuPodbmgOZQN+IaB1atuf00t
	88LabQR/835nNFfeseE5LnRqMdW5Wp9zRtv8yVZai33ESnBptFkJAy+3aKPLqfEwhCFSMN/vgoO
	/JvXFr9Hi2AcPTH2A8mrKM9YOYbZzKheCap7asy3M=
X-Gm-Gg: ASbGncsLPVNPo3A+nKlyNxq+EoVPv2chFUAOeOtLKoKPGIYMthErbDig0bSOtmyTgbG
	93mEAFJ6pp9n9ErqxRh+oOF/AVj66ppnPcT5+QOEyIkc023fapAJFqgxVpNON/qNy+PPD85UIOU
	LcewS2dXzauDYyO7h1bEi/U/q9NtPLgfOs+t4rFp4otApbIS/1qPAN2CPkePjBijCQtBI7SPw1s
	tqFmx6tYG9w/LMON2EZm2U1+16S0NCzmb0QFawUVMT/cWtzuou6QxT9+DLT012knJSZG6nD
X-Received: by 2002:a05:600c:3110:b0:434:fa24:b84a with SMTP id 5b1f17b1804b1-43668b499e0mr356527985e9.25.1735898526977;
        Fri, 03 Jan 2025 02:02:06 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEPF7Zuxpc4+5Ly1nC9d8XL2WfeSd7sTYf7log9JpPYfcpb6Ay5Fd06FPncyRpRCIXgcKHZTw==
X-Received: by 2002:a05:600c:3110:b0:434:fa24:b84a with SMTP id 5b1f17b1804b1-43668b499e0mr356527265e9.25.1735898526202;
        Fri, 03 Jan 2025 02:02:06 -0800 (PST)
Received: from localhost.localdomain ([2a02:8308:b104:2c00:7718:da55:8b6:8dcc])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43656af6d02sm519175535e9.1.2025.01.03.02.02.05
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jan 2025 02:02:05 -0800 (PST)
From: Ondrej Mosnacek <omosnace@redhat.com>
To: selinux@vger.kernel.org
Subject: [PATCH userspace 1/4] ci: use Testing Farm for running the testsuite
Date: Fri,  3 Jan 2025 11:02:00 +0100
Message-ID: <20250103100203.32580-2-omosnace@redhat.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250103100203.32580-1-omosnace@redhat.com>
References: <20250103100203.32580-1-omosnace@redhat.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Due to issues with the MacOS + Vagrant setup, selinux-testsuite has
migrated its CI to Testing Farm [1][2], so let's use it for running the
testsuite here, too.

We can import the test definitions from the testsuite repo and just add
a setup "test" at the beginning that builds and installs the userspace
from git.

[1] https://testing-farm.io/
[2] https://github.com/SELinuxProject/selinux-testsuite/commit/d75675eb0da2906780557ec8cd139d328c81777e

Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
---
 .fmf/version                       |   1 +
 .github/workflows/tf_testsuite.yml |  17 ++++
 .github/workflows/vm_testsuite.yml |  22 -----
 scripts/ci/.gitignore              |   1 -
 scripts/ci/LICENSE                 |   5 --
 scripts/ci/README.md               |   8 --
 scripts/ci/Vagrantfile             |  48 -----------
 scripts/ci/fedora-test-runner.sh   | 100 ----------------------
 scripts/ci/travis-kvm-setup.sh     | 130 -----------------------------
 tmt/plans.fmf                      |  48 +++++++++++
 10 files changed, 66 insertions(+), 314 deletions(-)
 create mode 100644 .fmf/version
 create mode 100644 .github/workflows/tf_testsuite.yml
 delete mode 100644 .github/workflows/vm_testsuite.yml
 delete mode 100644 scripts/ci/.gitignore
 delete mode 100644 scripts/ci/LICENSE
 delete mode 100644 scripts/ci/README.md
 delete mode 100644 scripts/ci/Vagrantfile
 delete mode 100755 scripts/ci/fedora-test-runner.sh
 delete mode 100755 scripts/ci/travis-kvm-setup.sh
 create mode 100644 tmt/plans.fmf

diff --git a/.fmf/version b/.fmf/version
new file mode 100644
index 00000000..d00491fd
--- /dev/null
+++ b/.fmf/version
@@ -0,0 +1 @@
+1
diff --git a/.github/workflows/tf_testsuite.yml b/.github/workflows/tf_testsuite.yml
new file mode 100644
index 00000000..7e3993d3
--- /dev/null
+++ b/.github/workflows/tf_testsuite.yml
@@ -0,0 +1,17 @@
+name: Run SELinux testsuite in Testing Farm
+
+on: [push, pull_request]
+
+jobs:
+  tf_testsuite:
+    runs-on: ubuntu-latest
+    strategy:
+      fail-fast: false
+      matrix:
+        arch: [x86_64, aarch64]
+    steps:
+      - name: Schedule test on Testing Farm
+        uses: sclorg/testing-farm-as-github-action@main
+        with:
+          api_key: ${{ secrets.TESTING_FARM_API_TOKEN }}
+          arch: ${{ matrix.arch }}
diff --git a/.github/workflows/vm_testsuite.yml b/.github/workflows/vm_testsuite.yml
deleted file mode 100644
index b96d58a5..00000000
--- a/.github/workflows/vm_testsuite.yml
+++ /dev/null
@@ -1,22 +0,0 @@
-name: Run SELinux testsuite in a virtual machine
-
-on: [push, pull_request]
-
-jobs:
-  vm_testsuite:
-
-    # Use VirtualBox+vagrant on macOS, as described in https://github.com/actions/virtual-environments/issues/433
-    runs-on: macos-12
-
-    steps:
-    - uses: actions/checkout@v4
-
-    - name: Create Vagrant VM
-      run: |
-        cd scripts/ci
-        vagrant up
-
-    - name: Run SELinux testsuite in the VM
-      run: |
-        cd scripts/ci
-        vagrant ssh -- ./run-selinux-test.sh
diff --git a/scripts/ci/.gitignore b/scripts/ci/.gitignore
deleted file mode 100644
index a977916f..00000000
--- a/scripts/ci/.gitignore
+++ /dev/null
@@ -1 +0,0 @@
-.vagrant/
diff --git a/scripts/ci/LICENSE b/scripts/ci/LICENSE
deleted file mode 100644
index 1f95d26c..00000000
--- a/scripts/ci/LICENSE
+++ /dev/null
@@ -1,5 +0,0 @@
-Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
-
-The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
-
-THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
diff --git a/scripts/ci/README.md b/scripts/ci/README.md
deleted file mode 100644
index 04a134a4..00000000
--- a/scripts/ci/README.md
+++ /dev/null
@@ -1,8 +0,0 @@
-# Continuous Integration Scripts
-
-The scripts under `scripts/ci` are designed specifically
-for the Travis CI system. While nothing prevents you
-from mimicking that environment and using them locally,
-they are not applicable for general consumption. Any
-thing in this directory should never be considered as
-a stable API.
diff --git a/scripts/ci/Vagrantfile b/scripts/ci/Vagrantfile
deleted file mode 100644
index f3c90b71..00000000
--- a/scripts/ci/Vagrantfile
+++ /dev/null
@@ -1,48 +0,0 @@
-# -*- mode: ruby -*-
-# vi: set ft=ruby :
-# Vagrant configuration file which creates a virtual machine that can run the
-# test suite using fedora-test-runner.sh, in an environment similar to the one
-# used for automated continuous integration tests (GitHub Actions)
-#
-# To create a new virtual machine:
-#
-#    vagrant up --provision
-#
-# To launch tests (for example after modifications to libsepol, libselinux... are made):
-#
-#    vagrant rsync && echo ./run-selinux-test.sh | vagrant ssh
-#
-# To destroy the virtual machine (for example to start again from a clean environment):
-#
-#    vagrant destroy
-
-# Create a helper script in the VM to run the testsuite as root from a clean environment
-$script = <<SCRIPT
-cat > /home/vagrant/run-selinux-test.sh << EOF
-#/bin/sh
-set -e -v
-
-# Run the tests
-sudo /root/selinux/scripts/ci/fedora-test-runner.sh
-echo 'All tests passed :)'
-EOF
-chmod +x /home/vagrant/run-selinux-test.sh
-SCRIPT
-
-# All Vagrant configuration is done below. The "2" in Vagrant.configure
-# configures the configuration version (we support older styles for
-# backwards compatibility). Please don't change it unless you know what
-# you're doing.
-Vagrant.configure("2") do |config|
-  config.vm.box = "fedora/39-cloud-base"
-  config.vm.synced_folder "../..", "/root/selinux"
-
-  config.vm.provider "virtualbox" do |v|
-     v.memory = 4096
-  end
-  config.vm.provider "libvirt" do |v|
-     v.memory = 4096
-  end
-
-  config.vm.provision :shell, inline: $script
-end
diff --git a/scripts/ci/fedora-test-runner.sh b/scripts/ci/fedora-test-runner.sh
deleted file mode 100755
index 331b9ec7..00000000
--- a/scripts/ci/fedora-test-runner.sh
+++ /dev/null
@@ -1,100 +0,0 @@
-#!/usr/bin/env bash
-# SPDX-License-Identifier: MIT
-set -ev
-
-#
-# We expect this to be set in the environment, but if it's not, most selinux projects
-# just have the same name as upstream, so choose that.
-#
-export SELINUX_DIR="${SELINUX_DIR:-/root/selinux}"
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
-dnf clean all -y
-dnf install -y \
-    --allowerasing \
-    --skip-broken \
-    git \
-    audit-libs-devel \
-    bison \
-    bzip2-devel \
-    CUnit-devel \
-    diffutils \
-    flex \
-    gcc \
-    gettext \
-    glib2-devel \
-    make \
-    libcap-devel \
-    libcap-ng-devel \
-    pam-devel \
-    pcre2-devel \
-    xmlto \
-    python3-devel \
-    ruby-devel \
-    swig \
-    perl-Test \
-    perl-Test-Harness \
-    perl-Test-Simple \
-    selinux-policy-devel \
-    gcc \
-    libselinux-devel \
-    net-tools \
-    netlabel_tools \
-    iptables \
-    lksctp-tools-devel \
-    attr \
-    libbpf-devel \
-    keyutils-libs-devel \
-    kernel-devel \
-    quota \
-    xfsprogs-devel \
-    libuuid-devel \
-    e2fsprogs \
-    jfsutils \
-    dosfstools \
-    rdma-core-devel \
-    kernel-devel-"$(uname -r)" \
-    kernel-modules-"$(uname -r)"
-
-#
-# Move to selinux code and build
-#
-cd "$SELINUX_DIR"
-
-# Show HEAD commit for sanity checking
-git config --global --add safe.directory "$SELINUX_DIR"
-git log --oneline -1
-
-#
-# Build and replace userspace components
-#
-make clean distclean
-make -j"$(nproc)" LIBDIR=/usr/lib64 SHLIBDIR=/lib64 install
-make -j"$(nproc)" LIBDIR=/usr/lib64 SHLIBDIR=/lib64 install-pywrap
-make -j"$(nproc)" LIBDIR=/usr/lib64 SHLIBDIR=/lib64 relabel
-
-#
-# Get the selinux testsuite, but don't clone it in selinux git directory, move to $HOME
-# first.
-#
-cd "$HOME"
-rm -rf selinux-testsuite
-git clone --depth=1 https://github.com/SELinuxProject/selinux-testsuite.git
-cd selinux-testsuite
-
-# The testsuite must be run in enforcing mode
-setenforce 1
-
-#
-# Run the test suite
-#
-make test
diff --git a/scripts/ci/travis-kvm-setup.sh b/scripts/ci/travis-kvm-setup.sh
deleted file mode 100755
index 997ef73f..00000000
--- a/scripts/ci/travis-kvm-setup.sh
+++ /dev/null
@@ -1,130 +0,0 @@
-#!/usr/bin/env bash
-# SPDX-License-Identifier: MIT
-set -ev
-
-TEST_RUNNER="scripts/ci/fedora-test-runner.sh"
-
-#
-# Variables for controlling the Fedora Image version and download URLs.
-#
-if [ -z "$FEDORA_MAJOR" ] || [ -z "$FEDORA_MINOR" ]; then
-    echo "$0: FEDORA_MAJOR and FEDORA_MINOR must be set!" 1>&2
-    exit 1
-fi
-
-BASE_URL="https://download.fedoraproject.org/pub/fedora/linux/releases"
-IMAGE_BASE_NAME="Fedora-Cloud-Base-$FEDORA_MAJOR-$FEDORA_MINOR.x86_64"
-IMAGE_URL="$BASE_URL/$FEDORA_MAJOR/Cloud/x86_64/images/$IMAGE_BASE_NAME.raw.xz"
-CHECK_URL="$BASE_URL/$FEDORA_MAJOR/Cloud/x86_64/images/Fedora-Cloud-$FEDORA_MAJOR-$FEDORA_MINOR-x86_64-CHECKSUM"
-GPG_URL="https://getfedora.org/static/fedora.gpg"
-
-#
-# Travis gives us 7.5GB of RAM and two cores:
-# https://docs.travis-ci.com/user/reference/overview/
-#
-MEMORY=4096
-VCPUS="$(nproc)"
-
-# Install these here so other builds don't have to wait on these deps to download and install
-sudo apt-get update
-sudo apt-get install qemu-kvm libvirt-bin virtinst bridge-utils cpu-checker libguestfs-tools
-
-sudo usermod -a -G kvm,libvirt,libvirt-qemu "$USER"
-
-# Verify that KVM is working, useful if Travis ever changes anything.
-kvm-ok
-
-sudo systemctl enable libvirtd
-sudo systemctl start libvirtd
-
-# Set up a key so we can ssh into the VM
-ssh-keygen -N "" -f "$HOME/.ssh/id_rsa"
-
-#
-# Get the Fedora Cloud Image, It is a base image that small and ready to go, extract it and modify it with virt-sysprep
-#  - https://alt.fedoraproject.org/en/verify.html
-cd "$HOME"
-wget "$IMAGE_URL"
-
-# Verify the image
-curl "$GPG_URL" | gpg --import
-wget "$CHECK_URL"
-gpg --verify-files ./*-CHECKSUM
-sha256sum --ignore-missing -c ./*-CHECKSUM
-
-# Extract the image
-unxz -T0 "$IMAGE_BASE_NAME.raw.xz"
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
-sudo virt-sysprep -a "$IMAGE_BASE_NAME.raw" \
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
-  --disk "$IMAGE_BASE_NAME.raw" \
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
-    echo "ipaddy zero length, exiting with error 1"
-    exit 1
-fi
-
-#
-# Great we have a host running, ssh into it. We specify -o so
-# we don't get blocked on asking to add the servers key to
-# our known_hosts. Also, we need to forward the project directory
-# so forks know where to go.
-#
-project_dir="$(basename "$TRAVIS_BUILD_DIR")"
-ssh -tt -o StrictHostKeyChecking=no -o LogLevel=QUIET "root@$ipaddy" "SELINUX_DIR=/root/$project_dir /root/$project_dir/$TEST_RUNNER"
-
-exit 0
diff --git a/tmt/plans.fmf b/tmt/plans.fmf
new file mode 100644
index 00000000..89f041f2
--- /dev/null
+++ b/tmt/plans.fmf
@@ -0,0 +1,48 @@
+/ci:
+  summary: Run the testsuite with userspace from git
+  # Environment for the testsuite setup
+  environment:
+    STS_ROOT_DOMAIN: unconfined_t
+    STS_KERNEL: latest
+  discover:
+    - how: shell
+      tests:
+        - name: /prepare-selinux-userspace
+          summary: Build and install SELinux userspace from git
+          order: 0
+          duration: 10m
+          require:
+            - audit-libs-devel
+            - bison
+            - bzip2-devel
+            - CUnit-devel
+            - diffutils
+            - flex
+            - gcc
+            - gettext
+            - glib2-devel
+            - make
+            - libcap-devel
+            - libcap-ng-devel
+            - pam-devel
+            - pcre2-devel
+            - python3-devel
+            - python3-pip
+            - python3-setuptools
+            - python3-wheel
+            - swig
+            - xmlto
+          test: |
+            set -ex
+
+            # Build and replace userspace components
+            make clean distclean
+            make -j"$(nproc)" LIBDIR=/usr/lib64 SHLIBDIR=/lib64 install
+            make -j"$(nproc)" LIBDIR=/usr/lib64 SHLIBDIR=/lib64 install-pywrap
+            make -j"$(nproc)" LIBDIR=/usr/lib64 SHLIBDIR=/lib64 relabel
+    - how: fmf
+      url: https://github.com/SELinuxProject/selinux-testsuite
+      ref: main
+      filter: tag:-ci & tag:-nfs
+  execute:
+    how: tmt
-- 
2.47.1

