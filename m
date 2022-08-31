Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7771ECAAD4
	for <selinux@archiver.kernel.org>; Wed, 31 Aug 2022 15:34:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231672AbiHaPeo (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 31 Aug 2022 11:34:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231393AbiHaPen (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 31 Aug 2022 11:34:43 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C48DC32CD
        for <selinux@vger.kernel.org>; Wed, 31 Aug 2022 08:34:42 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id se27so21426245ejb.8
        for <selinux@vger.kernel.org>; Wed, 31 Aug 2022 08:34:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date;
        bh=uNY3sqsDg2hL+X55XlDnLBTral/6QIHvsssX2WOBMeY=;
        b=FNSwU/skaIZIgDexoC578v0Dia46l9XSXvdacJNhgM+f8t2rsD/c4X7MkrGvw45sLa
         0GPzj/I3mMceBwLz59nJPnl3WGmOtV4QR2TyQeK4cgVX8XMt19yJVoHtan+k4A4smxYD
         8YLNfD2mBJ+ltRWb6AOA7mbkrN1843PfegX0f/oeRwTSvPdskXPmCuHiA6rtc5136gWf
         DgNnLGVbqp1v01I/y5nGHpRw/DB6dhVMqNHHohPMr73QFE25YSdjZMH3zup9mbQ69QHW
         u0XCp9ufHszzjiVaYSzJpn9C3vV+9kfgke2G4kbqHmkaRPQB7cyaKLIG+Z9RNlCDo66V
         Hm9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date;
        bh=uNY3sqsDg2hL+X55XlDnLBTral/6QIHvsssX2WOBMeY=;
        b=HRPldadqMzUTnjz+A91juofKnJiTb0Wc8EDc88ZFqi9MPFg2cKfR+jdUok2wOwOJ/9
         N73RyuyPmzFz64ZM/Fb77p3EWQQ9BQBrNXXMow3bJ89or08Qq1NQzN4E4XTQE3OZBbo9
         1PkVyLtzMffJOWaa0SwUr/L+1x+dW2XRlcvC+z5MAHtCHtDTyPuKgdVQ0OSJASRnfuuG
         BfVRmT5C1gGuHklTYrM5P627BrI3ylso+vsliFYn3d6w8yNOX7HEUT+HHs25Et6nukky
         mYRG/+DTVKX2zT7lyyprYDBcQlZJVujGTXq/rF/irwf/TW8UEbll8CfdtBInYFcWFtSW
         BQBw==
X-Gm-Message-State: ACgBeo0OYdb5LpP2W7fTL9EscnBaWyf6DzYUvxU5i7xs3rdBCdottnV5
        3A/Bc+IiuILwZ4eJZswc2rsttzity3tFeg==
X-Google-Smtp-Source: AA6agR5GYIJ/k/Hzha/9gHLRLI0ttuTGorqzAjWnSRWzjwqDhUyxyWqhTob+W2XJcrhrFDtCNTTS3w==
X-Received: by 2002:a17:906:58c9:b0:730:bc01:fd5f with SMTP id e9-20020a17090658c900b00730bc01fd5fmr20211491ejs.504.1661960080941;
        Wed, 31 Aug 2022 08:34:40 -0700 (PDT)
Received: from debianHome.localdomain (dynamic-077-000-086-221.77.0.pool.telefonica.de. [77.0.86.221])
        by smtp.gmail.com with ESMTPSA id b9-20020aa7d489000000b0043d7b19abd0sm9265771edr.39.2022.08.31.08.34.40
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Aug 2022 08:34:40 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [PATCH v2] tests/secretmem: add test
Date:   Wed, 31 Aug 2022 17:34:32 +0200
Message-Id: <20220831153432.710929-1-cgzones@googlemail.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Add test for memfd_secret(2) anonymous inodes check added in 6.0 via
2bfe15c52612 ("mm: create security context for memfd_secret inodes").

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
v2:
   - print mmap failures to stdout, since they are expected when
     mapping with PROT_EXEC
---
 .github/workflows/checks.yml |  4 ++
 Vagrantfile                  | 10 +++--
 policy/Makefile              |  4 ++
 policy/test_secretmem.te     | 33 ++++++++++++++
 tests/Makefile               |  5 +++
 tests/secretmem/.gitignore   |  1 +
 tests/secretmem/Makefile     |  5 +++
 tests/secretmem/secretmem.c  | 83 ++++++++++++++++++++++++++++++++++++
 tests/secretmem/test         | 39 +++++++++++++++++
 9 files changed, 180 insertions(+), 4 deletions(-)
 create mode 100644 policy/test_secretmem.te
 create mode 100644 tests/secretmem/.gitignore
 create mode 100644 tests/secretmem/Makefile
 create mode 100644 tests/secretmem/secretmem.c
 create mode 100755 tests/secretmem/test

diff --git a/.github/workflows/checks.yml b/.github/workflows/checks.yml
index 714bb49..ae81925 100644
--- a/.github/workflows/checks.yml
+++ b/.github/workflows/checks.yml
@@ -38,6 +38,10 @@ jobs:
         run: vagrant up
       - name: Wait for the machine to come up if rebooting
         run: while ! vagrant ssh -- true; do sleep 1; done
+      - name: Show Vagrant VM details
+        run: |
+          vagrant ssh -- uname -a
+          vagrant ssh -- cat /proc/cmdline
       - name: Run SELinux testsuite
         run: vagrant ssh -- sudo make -C /root/testsuite test
       - name: Check unwanted denials
diff --git a/Vagrantfile b/Vagrantfile
index f73586c..6f7675f 100644
--- a/Vagrantfile
+++ b/Vagrantfile
@@ -37,15 +37,12 @@ Vagrant.configure("2") do |config|
   when 'default'
     dnf_opts = ''
     kernel_pkgs = 'kernel-devel-"$(uname -r)" kernel-modules-"$(uname -r)"'
-    reboot_cmd = ''
   when 'latest'
     dnf_opts = ''
     kernel_pkgs = 'kernel-devel kernel-modules'
-    reboot_cmd = 'reboot'
   when 'secnext'
     dnf_opts = '--nogpgcheck --releasever rawhide --repofrompath kernel-secnext,https://repo.paul-moore.com/rawhide/x86_64'
     kernel_pkgs = 'kernel-devel kernel-modules'
-    reboot_cmd = 'reboot'
   else
     print("Invalid KERNEL_TYPE '#{ENV['KERNEL_TYPE']}'")
     abort
@@ -93,7 +90,12 @@ EOF
       jfsutils \
       dosfstools \
       #{kernel_pkgs}
+
     #{extra_commands}
-    #{reboot_cmd}
+
+    # for secretmem test
+    grubby --update-kernel=ALL --args=secretmem.enable=1
+
+    reboot
 SCRIPT
 end
diff --git a/policy/Makefile b/policy/Makefile
index b6f2f32..403802b 100644
--- a/policy/Makefile
+++ b/policy/Makefile
@@ -162,6 +162,10 @@ ifeq (x$(DISTRO),$(filter x$(DISTRO),xRHEL4 xRHEL5 xRHEL6))
 TARGETS:=$(filter-out test_overlayfs.te test_mqueue.te test_ibpkey.te, $(TARGETS))
 endif
 
+ifeq ($(shell grep -q anon_inode $(POLDEV)/include/support/all_perms.spt && echo true),true)
+TARGETS += test_secretmem.te
+endif
+
 all: build
 
 expand_check:
diff --git a/policy/test_secretmem.te b/policy/test_secretmem.te
new file mode 100644
index 0000000..357f41d
--- /dev/null
+++ b/policy/test_secretmem.te
@@ -0,0 +1,33 @@
+#################################
+#
+# Policy for testing secretmem operations
+#
+
+# Private type for secret memory
+type test_secretmem_inode_t;
+
+# Domain not allowed to create secret memory
+type test_nocreate_secretmem_t;
+testsuite_domain_type_minimal(test_nocreate_secretmem_t)
+
+# Domain allowed to create secret memory with the own domain type
+type test_create_secretmem_t;
+testsuite_domain_type_minimal(test_create_secretmem_t)
+allow test_create_secretmem_t self:anon_inode create;
+
+# Domain allowed to create secret memory with the own domain type and allowed to map WX
+type test_create_wx_secretmem_t;
+testsuite_domain_type_minimal(test_create_wx_secretmem_t)
+allow test_create_wx_secretmem_t self:anon_inode create;
+allow test_create_wx_secretmem_t self:process execmem;
+
+# Domain not allowed to create secret memory via a type transition to a private type
+type test_nocreate_transition_secretmem_t;
+testsuite_domain_type_minimal(test_nocreate_transition_secretmem_t)
+type_transition test_nocreate_transition_secretmem_t test_nocreate_transition_secretmem_t:anon_inode test_secretmem_inode_t "[secretmem]";
+
+# Domain allowed to create secret memory via a type transition to a private type
+type test_create_transition_secretmem_t;
+testsuite_domain_type_minimal(test_create_transition_secretmem_t)
+type_transition test_create_transition_secretmem_t test_create_transition_secretmem_t:anon_inode test_secretmem_inode_t "[secretmem]";
+allow test_create_transition_secretmem_t test_secretmem_inode_t:anon_inode create;
diff --git a/tests/Makefile b/tests/Makefile
index 8abd438..b50cbc6 100644
--- a/tests/Makefile
+++ b/tests/Makefile
@@ -145,6 +145,11 @@ SUBDIRS += vsock_socket
 endif
 endif
 
+# memfd_secret(2) is available since 5.14, but only confined since 6.0
+ifneq ($(shell ./kvercmp $$(uname -r) 6.0),-1)
+SUBDIRS += secretmem
+endif
+
 ifeq ($(DISTRO),RHEL4)
     SUBDIRS:=$(filter-out bounds dyntrace dyntrans inet_socket mmap nnp_nosuid overlay unix_socket, $(SUBDIRS))
 endif
diff --git a/tests/secretmem/.gitignore b/tests/secretmem/.gitignore
new file mode 100644
index 0000000..17e1c19
--- /dev/null
+++ b/tests/secretmem/.gitignore
@@ -0,0 +1 @@
+secretmem
diff --git a/tests/secretmem/Makefile b/tests/secretmem/Makefile
new file mode 100644
index 0000000..c27d5f0
--- /dev/null
+++ b/tests/secretmem/Makefile
@@ -0,0 +1,5 @@
+TARGETS=secretmem
+
+all: $(TARGETS)
+clean:
+	rm -f $(TARGETS)
diff --git a/tests/secretmem/secretmem.c b/tests/secretmem/secretmem.c
new file mode 100644
index 0000000..0d541ee
--- /dev/null
+++ b/tests/secretmem/secretmem.c
@@ -0,0 +1,83 @@
+#include <errno.h>
+#include <stdbool.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <unistd.h>
+
+#include <sys/mman.h>
+#include <sys/syscall.h>
+
+#ifndef __NR_memfd_secret
+# define __NR_memfd_secret 447
+#endif
+
+#define TEXT "Hello World!\nHello World!\nHello World!\nHello World!\nHello World!\nHello World!\n"
+
+static int _memfd_secret(unsigned long flags)
+{
+	return syscall(__NR_memfd_secret, flags);
+}
+
+int main(int argc, const char *argv[])
+{
+	long page_size;
+	int fd, flags;
+	char *mem;
+	bool check = (argc == 2 && strcmp(argv[1], "check") == 0);
+	bool wx = (argc == 2 && strcmp(argv[1], "wx") == 0);
+
+	page_size = sysconf(_SC_PAGESIZE);
+	if (page_size <= 0) {
+		fprintf(stderr, "failed to get pagesize, got %ld:  %s\n", page_size,
+			strerror(errno));
+		return EXIT_FAILURE;
+	}
+
+	fd = _memfd_secret(0);
+	if (fd < 0) {
+		printf("memfd_secret() failed:  %s\n", strerror(errno));
+		if (check && errno != ENOSYS)
+			return EXIT_SUCCESS;
+
+		return EXIT_FAILURE;
+	}
+
+	if (check)
+		return EXIT_SUCCESS;
+
+	if (ftruncate(fd, page_size) < 0) {
+		fprintf(stderr, "ftruncate failed:  %s\n", strerror(errno));
+	}
+
+	flags = PROT_READ | PROT_WRITE;
+	if (wx)
+		flags |= PROT_EXEC;
+
+	mem = mmap(NULL, page_size, flags, MAP_SHARED, fd, 0);
+	if (mem == MAP_FAILED || !mem) {
+		printf("unable to mmap secret memory:  %s\n", strerror(errno));
+		close(fd);
+		return EXIT_FAILURE;
+	}
+
+	close(fd);
+
+	memcpy(mem, TEXT, sizeof TEXT);
+
+	if (memcmp(mem, TEXT, sizeof TEXT) != 0) {
+		fprintf(stderr, "data not synced (1)\n");
+		munmap(mem, page_size);
+		return EXIT_FAILURE;
+	}
+
+	if (strlen(mem) + 1 != sizeof TEXT) {
+		fprintf(stderr, "data not synced (2)\n");
+		munmap(mem, page_size);
+		return EXIT_FAILURE;
+	}
+
+	munmap(mem, page_size);
+
+	return EXIT_SUCCESS;
+}
diff --git a/tests/secretmem/test b/tests/secretmem/test
new file mode 100755
index 0000000..d17d423
--- /dev/null
+++ b/tests/secretmem/test
@@ -0,0 +1,39 @@
+#!/usr/bin/perl
+
+use Test::More;
+
+BEGIN {
+    $basedir = $0;
+    $basedir =~ s|(.*)/[^/]*|$1|;
+
+    $result =
+      system "runcon -t test_nocreate_secretmem_t $basedir/secretmem check";
+    if ( $result ne 0 ) {
+        plan skip_all => "memfd_secret(2) not available";
+    }
+    else {
+        plan tests => 6;
+    }
+}
+
+$result = system "runcon -t test_nocreate_secretmem_t $basedir/secretmem";
+ok( $result >> 8 eq 1 );
+
+$result = system "runcon -t test_create_secretmem_t $basedir/secretmem";
+ok( $result eq 0 );
+
+$result = system "runcon -t test_create_secretmem_t $basedir/secretmem wx";
+ok( $result >> 8 eq 1 );
+
+$result = system "runcon -t test_create_wx_secretmem_t $basedir/secretmem wx";
+ok( $result >> 8 eq 1 );
+
+$result =
+  system "runcon -t test_nocreate_transition_secretmem_t $basedir/secretmem";
+ok( $result >> 8 eq 1 );
+
+$result =
+  system "runcon -t test_create_transition_secretmem_t $basedir/secretmem";
+ok( $result eq 0 );
+
+exit;
-- 
2.37.2

