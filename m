Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-21.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43C10C64E7B
	for <selinux@archiver.kernel.org>; Thu,  3 Dec 2020 08:16:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ECF6D21D1A
	for <selinux@archiver.kernel.org>; Thu,  3 Dec 2020 08:16:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388189AbgLCIQV (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 3 Dec 2020 03:16:21 -0500
Received: from mx1.polytechnique.org ([129.104.30.34]:55517 "EHLO
        mx1.polytechnique.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387501AbgLCIQV (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 3 Dec 2020 03:16:21 -0500
Received: from localhost.localdomain (85-168-38-217.rev.numericable.fr [85.168.38.217])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by ssl.polytechnique.org (Postfix) with ESMTPSA id AE765561249;
        Thu,  3 Dec 2020 09:15:38 +0100 (CET)
From:   Nicolas Iooss <nicolas.iooss@m4x.org>
To:     selinux@vger.kernel.org
Cc:     Petr Lautrbach <plautrba@redhat.com>,
        William Roberts <bill.c.roberts@gmail.com>
Subject: [PATCH v2 1/1] scripts/ci: add configuration for a Vagrant virtual machine
Date:   Thu,  3 Dec 2020 09:15:12 +0100
Message-Id: <20201203081512.8385-1-nicolas.iooss@m4x.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AV-Checked: ClamAV using ClamSMTP at svoboda.polytechnique.org (Thu Dec  3 09:15:39 2020 +0100 (CET))
X-Org-Mail: nicolas.iooss.2010@polytechnique.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Using Vagrant makes reproducing and debugging CI issues easier: after
"vagrant up", a test virtual machine is up and running, and ready to run
"fedora-test-runner.sh". In order to make using this VM even easier, a
helper script, "run-selinux-test.sh" is created inside and instructions
on how to use it are documented at the beginning of Vagrantfile.

Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>
---
 scripts/ci/.gitignore            |  1 +
 scripts/ci/Vagrantfile           | 48 ++++++++++++++++++++++++++++++++
 scripts/ci/fedora-test-runner.sh |  2 ++
 3 files changed, 51 insertions(+)
 create mode 100644 scripts/ci/.gitignore
 create mode 100644 scripts/ci/Vagrantfile

diff --git a/scripts/ci/.gitignore b/scripts/ci/.gitignore
new file mode 100644
index 000000000000..a977916f6583
--- /dev/null
+++ b/scripts/ci/.gitignore
@@ -0,0 +1 @@
+.vagrant/
diff --git a/scripts/ci/Vagrantfile b/scripts/ci/Vagrantfile
new file mode 100644
index 000000000000..d7c7bb39896d
--- /dev/null
+++ b/scripts/ci/Vagrantfile
@@ -0,0 +1,48 @@
+# -*- mode: ruby -*-
+# vi: set ft=ruby :
+# Vagrant configuration file which creates a virtual machine that can run the
+# test suite using fedora-test-runner.sh, in an environment similar to the one
+# used for automated continuous integration tests (Travis-CI)
+#
+# To create a new virtual machine:
+#
+#    vagrant up --provision
+#
+# To launch tests (for example after modifications to libsepol, libselinux... are made):
+#
+#    vagrant rsync && echo ./run-selinux-test.sh | vagrant ssh
+#
+# To destroy the virtual machine (for example to start again from a clean environment):
+#
+#    vagrant destroy
+
+# Create a helper script in the VM to run the testsuite as root from a clean environment
+$script = <<SCRIPT
+cat > /home/vagrant/run-selinux-test.sh << EOF
+#/bin/sh
+set -e -v
+
+# Run the tests
+sudo /root/selinux/scripts/ci/fedora-test-runner.sh
+echo 'All tests passed :)'
+EOF
+chmod +x /home/vagrant/run-selinux-test.sh
+SCRIPT
+
+# All Vagrant configuration is done below. The "2" in Vagrant.configure
+# configures the configuration version (we support older styles for
+# backwards compatibility). Please don't change it unless you know what
+# you're doing.
+Vagrant.configure("2") do |config|
+  config.vm.box = "fedora/33-cloud-base"
+  config.vm.synced_folder "../..", "/root/selinux"
+
+  config.vm.provider "virtualbox" do |v|
+     v.memory = 4096
+  end
+  config.vm.provider "libvirt" do |v|
+     v.memory = 4096
+  end
+
+  config.vm.provision :shell, inline: $script
+end
diff --git a/scripts/ci/fedora-test-runner.sh b/scripts/ci/fedora-test-runner.sh
index be2cb7d8a5f5..f817499b54ae 100755
--- a/scripts/ci/fedora-test-runner.sh
+++ b/scripts/ci/fedora-test-runner.sh
@@ -75,6 +75,7 @@ git log --oneline -1
 #
 # Build and replace userspace components
 #
+make clean distclean
 make -j"$(nproc)" LIBDIR=/usr/lib64 SHLIBDIR=/lib64 install
 make -j"$(nproc)" LIBDIR=/usr/lib64 SHLIBDIR=/lib64 install-pywrap
 make -j"$(nproc)" LIBDIR=/usr/lib64 SHLIBDIR=/lib64 relabel
@@ -84,6 +85,7 @@ make -j"$(nproc)" LIBDIR=/usr/lib64 SHLIBDIR=/lib64 relabel
 # first.
 #
 cd "$HOME"
+rm -rf selinux-testsuite
 git clone --depth=1 https://github.com/SELinuxProject/selinux-testsuite.git
 cd selinux-testsuite
 
-- 
2.29.2

