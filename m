Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42EEA22FDEC
	for <selinux@vger.kernel.org>; Mon, 10 Nov 2025 14:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762784120; cv=none; b=Tz1oZQXANUDiCgxJIWqsAvmo7SW4EThvGq7yRH0pLivMkNuH/bKle4jtYlv0PoQkMcaGXxsiQeyjZTshe33R/UjVInksA4NWFTyh9WoIMMc67Eic0GMjhSZbYDGDwAheM623wC7pDM31GA3BkgLMk0eA55238rN4sOdo6iPSqmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762784120; c=relaxed/simple;
	bh=LoN9HJHx6sp3ElAT982ydL3IkqBkdn68OTBWgsBq4gU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=G36zOyDj8Wj+wgsMVHDOITwEAXJUa9Mi9LMnK+qn1tPN6nghzIOXuWeWjq4wpNki3mhf3w2l19kTr45xu1vSTgVw8LKwOH3KcYIOWhD6+kXSbGCns9hgPNFHUYKOrJo7orYR+IFnzHOFZolBIhGuE8hpf4wQXJLHrCQwf9EeCXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hd1XCb6q; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hd1XCb6q"
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-8823fa3bd95so12828976d6.1
        for <selinux@vger.kernel.org>; Mon, 10 Nov 2025 06:15:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762784116; x=1763388916; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cy0pwofEFImHAwSpCHwFRhlV7ucjT5kVqq4iOooiZXk=;
        b=hd1XCb6qaeyO2vEJqt2/Lwpgr9pW9dVTqHA/8TdP3HhbEIki43D+q0IVs+569e+/2t
         KJp7xi9N6+0NFy3KTBpuwr4PDTKiRBpM55uaUKCdNx2ZHcLzLADL882yk9wnJiw9Q2xL
         1nD29wNlwOTHT61ywH37lPBe61F6GZbrEB0tM0t2GVJWC267Skm5e6PZa8qKYVQIE9iD
         cU/7++UA/qWZoK2fk3YV2TDx05IY/0VpWLwmkhpqYV8zWM/Vshtn16vDHUbivlwSWklT
         1gesM4EqGogvbCd7UpofaOdj3n0gp9MLVnnoLlYv+EJRNdhWYpTB5hQPOnTHniBqRL7y
         M+Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762784116; x=1763388916;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cy0pwofEFImHAwSpCHwFRhlV7ucjT5kVqq4iOooiZXk=;
        b=CCEbGSf+4/k3Sw3SMA2fEus7128O+fZNjQW5IQl0Jfojq4DUt01Xgkp4hxeC683qkS
         Z0epiY6DQyQci2CBb3H09/efQF2cBoFTmEY87wVdXjpltflc8m439lP+UMWxZceR3DJU
         i0Y48vsBAkorpPQS2T8pm7u9uXaOTw5+jNuvtGlaNoLEGurA+xb45OVNcLOnN9cNhNT6
         8nP9M4mTcLHqdlnHdNe56fDDbq8mBnvh6ejvtLd6s5EMRJ9eTYN2ka1iI/hsY2owzXrP
         Fan3iZZcTiyIZJO0laiQRW0mWJHOkaQE/RI3uzS2YSDxz+DOhwxYDi1VbLHsAZ1B5vKq
         BlKQ==
X-Gm-Message-State: AOJu0YylEoqIJeKSl+kLt3FnXmKGphsoIWLe/GppopjsQBUM+jwX5FV7
	fHvSwQmnXlVMzNT+sUw7uJnYeO7+zI88tQFJsB8jSwWiRxvMJQL6NF1tsAO0hg==
X-Gm-Gg: ASbGncu9jFatruEWVej8VZVQj8vFAD3lg5W+gigVokLdVKYtvNFb8dsZnIWhjm6r5lL
	5CFexWY8L/TR/CCPKdBjD9XQOx2qL0eAMZVgNNFFr1dicFjHTL9QIGV7kqFSwQiTMcO3JFhjnAw
	dgXUsvsJOy4oGvVp1CK0ylqe2fCsHZLL1bdAlbmshq+Un2c2x60VR6fkRVpoLzJbz37Zl5AfWLc
	FbebmpIxp77fibsOR82irWYRgZIK1th5spIQBeMFwM62zlA704alTnkrRJ1/Hy9rU1LrvBWjSR+
	5KKevYhZUSrhPsbrvDZA/R5II3PzHN7ZhOJOwhDelpnb5Up5iulkmFoDeXWTrCEKgp1u2O0r44k
	PTHxTt4QTCYQMSpXpWyiUOLKGQOkCDZ3MJIl/EciiED08vQr9BftNZa4Fe1zk9/AnKtjH2fog0J
	qvRYXiIPq9t1Vb4shJmYAhMC/BCfjh4Am1czSj5zQE9FN08qLquIFAbIzLdilyFrkjryP2yzcvL
	VYtcthq5NjonZg=
X-Google-Smtp-Source: AGHT+IEgtVw5cfTM5tx7QiaBVox04cOUHg+/oQZpYwpP3ypMrWsiOy/zSYaGHmoX88HdIzA3vhLKHA==
X-Received: by 2002:a0c:f108:0:b0:880:4cfb:ab5c with SMTP id 6a1803df08f44-88237976b5amr89702996d6.11.1762784111228;
        Mon, 10 Nov 2025 06:15:11 -0800 (PST)
Received: from fedora (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-88238b8ed14sm51754676d6.51.2025.11.10.06.15.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Nov 2025 06:15:10 -0800 (PST)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: paul@paul-moore.com,
	omosnace@redhat.com,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH testsuite v2] Add tests for io_uring
Date: Mon, 10 Nov 2025 09:11:24 -0500
Message-ID: <20251110141123.51580-2-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.51.1
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

iouring.c is a lightly modified copy of the one from:
    https://github.com/linux-audit/audit-testsuite

Only minimal changes were made to allow iouring.c to work within the
selinux-testsuite; more could be done to specialize it for the
selinux-testsuite, including using libselinux rather than hand-rolling
its own custom functions, but not sure if it is better to keep them as
close as possible for future joint evolution or let them diverge.

The audit-testsuite only appears to exercise the "iouring t1" test
case; for the selinux-testsuite, a test script and test policy were
created to exercise allowed and denied cases for each of the io_uring
{ override_creds sqpoll } permissions and for each of the anon_inode
permissions required for the io_uring anon inodes to execute:
1. iouring t1 without any provided exec context, i.e. child process
   runs in same context as the parent process,
2. iouring t1 with a provided exec context, i.e. child process runs in
   a different context from the parent process, and
3. iouring sqpoll.

To avoid a tight coupling on Fedora policy, which defines a default
type transition on io_uring anon_inodes to a single type for all
domains, the test policy is written using the minimal testsuite domain
type interface so that the test domains are not associated with the
domain attribute and can therefore have their own unique type
transitions defined for testing purposes.

Since the base policy on recent Fedora includes the base set of
io_uring permissions, the conditional guards in the policy and
tests Makefiles simply test for the definition of the io_uring
class in the policy support files to determine whether to enable
the test policy and tests to run.

This change does not include tests for the later additions to the
io_uring class for cmd and allowed, which were added to subsequent
kernel versions. The allowed permission does not yet appear to be
defined in either Fedora policy or refpolicy, so testing that
permission would require a modified base module. Such tests should
be added in a future change.

This change also does not explicitly test that io_uring operations on
files, sockets, etc are subject to the usual SELinux permission checks
for such objects in the appropriate subject context. Tests for these
should likewise be added in a future change.

Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
v2 addresses feedback from Ondrej Mosnacek <omosnace@redhat.com>,
including updating tmt/tests.fmf, the README.md Debian list,
and adding --pid $$ < /dev/null to the secon commands to avoid
a dependency on having a terminal.
 
 README.md                 |   5 +-
 policy/Makefile           |   4 +
 policy/test_io_uring.te   | 138 +++++++++
 tests/Makefile            |   4 +
 tests/io_uring/.gitignore |   2 +
 tests/io_uring/Makefile   |   7 +
 tests/io_uring/iouring.c  | 622 ++++++++++++++++++++++++++++++++++++++
 tests/io_uring/test       |  84 +++++
 tmt/tests.fmf             |   1 +
 9 files changed, 866 insertions(+), 1 deletion(-)
 create mode 100644 policy/test_io_uring.te
 create mode 100644 tests/io_uring/.gitignore
 create mode 100644 tests/io_uring/Makefile
 create mode 100644 tests/io_uring/iouring.c
 create mode 100755 tests/io_uring/test

diff --git a/README.md b/README.md
index 1a1b621..0338964 100644
--- a/README.md
+++ b/README.md
@@ -64,6 +64,7 @@ similar dependencies):
 * btrfs-progs _(used by the btrfs filesystem tests)_
 * nftables _(used by inet_socket and sctp tests if ver >= 9.3 for secmark testing )_
 * rdma-core-devel _(to build the `ibpkey` test program)_
+* liburing-devel _(to build the `iouring` test program)_
 
 On a modern Fedora system you can install these dependencies with the
 following command (NOTE: On Fedora 32 and below you need to remove
@@ -92,6 +93,7 @@ following command (NOTE: On Fedora 32 and below you need to remove
 		dosfstools \
 		btrfs-progs \
 		rdma-core-devel \
+		liburing-devel \
 		kernel-devel-$(uname -r) \
 		kernel-modules-$(uname -r)
 
@@ -141,7 +143,8 @@ command:
 		btrfs-progs \
 		nftables \
 		netlabel-tools \
-		libibverbs-dev
+		libibverbs-dev \
+		liburing-dev
 
 On Debian prior to version 11 (bullseye) you need to build and install netlabel_tools manually:
 
diff --git a/policy/Makefile b/policy/Makefile
index 520f891..17bb80d 100644
--- a/policy/Makefile
+++ b/policy/Makefile
@@ -197,6 +197,10 @@ ifeq ($(shell grep -q firmware_load $(POLDEV)/include/support/all_perms.spt && \
 TARGETS += test_file_load.te
 endif
 
+ifeq ($(shell grep -q io_uring $(POLDEV)/include/support/all_perms.spt && echo true),true)
+TARGETS += test_io_uring.te
+endif
+
 all: build
 
 expand_check:
diff --git a/policy/test_io_uring.te b/policy/test_io_uring.te
new file mode 100644
index 0000000..ad12846
--- /dev/null
+++ b/policy/test_io_uring.te
@@ -0,0 +1,138 @@
+#################################
+#
+# Policy for testing io_uring
+#
+
+#
+# Common type for POSIX shared memory created by the test program.
+#
+type test_io_uring_tmpfs_t;
+files_type(test_io_uring_tmpfs_t)
+
+#
+# Common type for test files created by the tests program.
+#
+type test_io_uring_test_file_t;
+files_type(test_io_uring_test_file_t)
+
+#
+# Common io_uring testsuite domain rules
+#
+# Parameter:
+# 1. domain prefix (without _t) to allow declaring derived types
+#
+define(`testsuite_io_uring_domain', `
+#
+# Inherit the minimal set of testsuite domain rules.
+# We must NOT use testsuite_domain_type() here because Fedora
+# policy defines its own io_uring type transition for all domains,
+# which we can not override otherwise.
+#
+testsuite_domain_type_minimal($1_t)
+
+#
+# Since we are not associating the domain attribute, we have to
+# explicitly allow any permissions typically allowed via it, like fork.
+#
+allow $1_t self:process fork;
+
+#
+# Define a per-domain type for any io_uring anon inodes created
+# by this domain. We use per-domain types so we can distinguish
+# parent-created from child-created io_urings. No allow rules
+# here though - see individual test domains below.
+#
+type $1_io_uring_t;
+type_transition $1_t self:anon_inode $1_io_uring_t "[io_uring]";
+
+#
+# Label any POSIX shared memory created by this domain with
+# a common type and allow access for testing.
+#
+fs_tmpfs_filetrans($1_t, test_io_uring_tmpfs_t, file)
+allow $1_t test_io_uring_tmpfs_t:file { create unlink open read write getattr map };
+
+#
+# Label any test files created by this domain with
+# a common type and allow access for testing.
+#
+filetrans_pattern($1_t, test_file_t, test_io_uring_test_file_t, file);
+allow $1_t test_io_uring_test_file_t:file { create open read write getattr unlink };
+')
+
+# Domain with all the permissions required for the t1 test (parent+child)
+type test_io_uring_t;
+testsuite_io_uring_domain(test_io_uring)
+allow test_io_uring_t test_io_uring_io_uring_t:anon_inode { create map read write };
+allow test_io_uring_t self:io_uring override_creds;
+
+# Domain with the permissions required for the t1 test except override_creds
+type test_io_uring_no_override_t;
+testsuite_io_uring_domain(test_io_uring_no_override)
+allow test_io_uring_no_override_t test_io_uring_no_override_io_uring_t:anon_inode { create map read write };
+
+# Domain with the permissions required for the t1 test except anon_inode read write
+type test_io_uring_no_readwrite_t;
+testsuite_io_uring_domain(test_io_uring_no_readwrite)
+allow test_io_uring_no_readwrite_t test_io_uring_no_readwrite_io_uring_t:anon_inode { create map  };
+allow test_io_uring_no_readwrite_t self:io_uring override_creds;
+
+# Domain with the permissions required for the t1 test except anon_inode map
+type test_io_uring_no_map_t;
+testsuite_io_uring_domain(test_io_uring_no_map)
+allow test_io_uring_no_map_t test_io_uring_no_map_io_uring_t:anon_inode { create read write };
+allow test_io_uring_no_map_t self:io_uring override_creds;
+
+# Domain with the permissions required for the t1 test except anon_inode create
+type test_io_uring_no_create_t;
+testsuite_io_uring_domain(test_io_uring_no_create)
+allow test_io_uring_no_create_t test_io_uring_no_create_io_uring_t:anon_inode { map read write };
+allow test_io_uring_no_create_t self:io_uring override_creds;
+
+# Domain with all the permissions required for the t1 parent process only
+type test_io_uring_parent_t;
+testsuite_io_uring_domain(test_io_uring_parent)
+allow test_io_uring_parent_t test_io_uring_parent_io_uring_t:anon_inode { create map read write };
+
+# Domain with all the permissions required by the t1 child process only
+type test_io_uring_child_t;
+testsuite_io_uring_domain(test_io_uring_child)
+spec_domtrans_pattern(test_io_uring_parent_t, test_file_t, test_io_uring_child_t)
+allow test_io_uring_parent_t test_io_uring_child_t:process { noatsecure rlimitinh siginh };
+allow test_io_uring_child_t test_io_uring_parent_io_uring_t:anon_inode { map read write };
+allow test_io_uring_child_t test_io_uring_parent_t:io_uring override_creds;
+
+# Domain with the permissions required by the t1 child process except override_creds
+type test_io_uring_child_no_override_t;
+testsuite_io_uring_domain(test_io_uring_child_no_override)
+spec_domtrans_pattern(test_io_uring_parent_t, test_file_t, test_io_uring_child_no_override_t)
+allow test_io_uring_parent_t test_io_uring_child_no_override_t:process { noatsecure rlimitinh siginh };
+allow test_io_uring_child_no_override_t test_io_uring_parent_io_uring_t:anon_inode { map read write };
+
+# Domain with the permissions required by the t1 child process except anon_inode map
+type test_io_uring_child_no_map_t;
+testsuite_io_uring_domain(test_io_uring_child_no_map)
+spec_domtrans_pattern(test_io_uring_parent_t, test_file_t, test_io_uring_child_no_map_t)
+allow test_io_uring_parent_t test_io_uring_child_no_map_t:process { noatsecure rlimitinh siginh };
+allow test_io_uring_child_no_map_t test_io_uring_parent_io_uring_t:anon_inode { read write };
+allow test_io_uring_child_no_map_t test_io_uring_parent_t:io_uring override_creds;
+
+# Domain with the permissions required by the t1 child process except anon_inode read write
+type test_io_uring_child_no_readwrite_t;
+testsuite_io_uring_domain(test_io_uring_child_no_readwrite)
+spec_domtrans_pattern(test_io_uring_parent_t, test_file_t, test_io_uring_child_no_readwrite_t)
+allow test_io_uring_parent_t test_io_uring_child_no_readwrite_t:process { noatsecure rlimitinh siginh };
+allow test_io_uring_child_no_readwrite_t test_io_uring_parent_io_uring_t:anon_inode map;
+allow test_io_uring_child_no_readwrite_t test_io_uring_parent_t:io_uring override_creds;
+
+# Domain with all the permissions required for the sqpoll test
+type test_io_uring_sqpoll_t;
+testsuite_io_uring_domain(test_io_uring_sqpoll)
+allow test_io_uring_sqpoll_t test_io_uring_sqpoll_io_uring_t:anon_inode { create map read write };
+allow test_io_uring_sqpoll_t self:io_uring { override_creds sqpoll };
+
+# Domain with the permissions required for the sqpoll test except for io_uring sqpoll
+type test_io_uring_no_sqpoll_t;
+testsuite_io_uring_domain(test_io_uring_no_sqpoll)
+allow test_io_uring_no_sqpoll_t test_io_uring_no_sqpoll_io_uring_t:anon_inode { create map read write };
+allow test_io_uring_no_sqpoll_t self:io_uring override_creds;
diff --git a/tests/Makefile b/tests/Makefile
index f002389..6df220c 100644
--- a/tests/Makefile
+++ b/tests/Makefile
@@ -163,6 +163,10 @@ ifeq ($(shell [ -d /sys/fs/selinux/class/memfd_file ] && grep -q 1 $(SELINUXFS)/
 SUBDIRS += memfd
 endif
 
+ifeq ($(shell grep -q io_uring $(POLDEV)/include/support/all_perms.spt && echo true),true)
+SUBDIRS += io_uring
+endif
+
 ifeq ($(DISTRO),RHEL4)
     SUBDIRS:=$(filter-out bounds dyntrace dyntrans inet_socket mmap nnp_nosuid overlay unix_socket, $(SUBDIRS))
 endif
diff --git a/tests/io_uring/.gitignore b/tests/io_uring/.gitignore
new file mode 100644
index 0000000..1b0b3df
--- /dev/null
+++ b/tests/io_uring/.gitignore
@@ -0,0 +1,2 @@
+iouring
+iouring.out
diff --git a/tests/io_uring/Makefile b/tests/io_uring/Makefile
new file mode 100644
index 0000000..5afc756
--- /dev/null
+++ b/tests/io_uring/Makefile
@@ -0,0 +1,7 @@
+TARGETS=iouring
+
+LDLIBS+=-luring
+
+all: $(TARGETS)
+clean:
+	rm -f $(TARGETS) iouring.out
diff --git a/tests/io_uring/iouring.c b/tests/io_uring/iouring.c
new file mode 100644
index 0000000..d5f9cbc
--- /dev/null
+++ b/tests/io_uring/iouring.c
@@ -0,0 +1,622 @@
+/*
+ * Copied from
+ * https://github.com/linux-audit/audit-testsuite/tree/main/tests/io_uring
+ * with the minimal changes required to make it work as part of the
+ * selinux-testsuite.
+ *
+ * io_uring test tool to exercise LSM/SELinux and audit kernel code paths
+ * Author: Paul Moore <paul@paul-moore.com>
+ *
+ * Copyright (c) 2021 Microsoft Corporation <paulmoore@microsoft.com>
+ *
+ * At the time this code was written the best, and most current, source of info
+ * on io_uring seemed to be the liburing sources themselves (link below).  The
+ * code below is based on the lessons learned from looking at the liburing
+ * code.
+ *
+ * -> https://github.com/axboe/liburing
+ *
+ * The liburing LICENSE file contains the following:
+ *
+ * Copyright 2020 Jens Axboe
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a copy
+ * of this software and associated documentation files (the "Software"), to
+ * deal in the Software without restriction, including without limitation the
+ * rights to use, copy, modify, merge, publish, distribute, sublicense, and/or
+ * sell copies of the Software, and to permit persons to whom the Software is
+ * furnished to do so, subject to the following conditions:
+ *
+ *  The above copyright notice and this permission notice shall be included in
+ *  all copies or substantial portions of the Software.
+ *
+ *  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ *  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ *  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
+ *  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
+ *  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
+ *  FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
+ *  DEALINGS IN THE SOFTWARE.
+ *
+ */
+
+/*
+ * BUILDING:
+ *
+ * gcc -o <binary> -g -O0 -luring -lrt <source>
+ *
+ * RUNNING:
+ *
+ * The program can be run using the following command lines:
+ *
+ *  % prog sqpoll
+ * ... this invocation runs the io_uring SQPOLL test.
+ *
+ *  % prog t1
+ * ... this invocation runs the parent/child io_uring sharing test.
+ *
+ *  % prog t1 <domain>
+ * ... this invocation runs the parent/child io_uring sharing test with the
+ * child process run in the specified SELinux domain.
+ *
+ */
+
+#include <stdlib.h>
+#include <stdio.h>
+#include <errno.h>
+#include <string.h>
+#include <fcntl.h>
+#include <unistd.h>
+#include <sys/mman.h>
+#include <sys/stat.h>
+#include <sys/wait.h>
+
+#include <liburing.h>
+#include <libgen.h>
+
+struct urt_config {
+	struct io_uring ring;
+	struct io_uring_params ring_params;
+	int ring_creds;
+};
+
+#define URING_ENTRIES				8
+#define URING_SHM_NAME				"/iouring_test"
+
+int selinux_state = -1;
+#define SELINUX_CTX_MAX				4096
+char selinux_ctx[SELINUX_CTX_MAX] = "\0";
+
+char uring_path[PATH_MAX];
+
+/**
+ * Display an error message and exit
+ * @param msg the error message
+ *
+ * Output @msg to stderr and exit with errno as the exit value.
+ */
+void fatal(const char *msg)
+{
+	const char *str = (msg ? msg : "unknown");
+	int save_errno = errno; // save before any potential reset below
+
+	if (!save_errno) {
+		save_errno = 1;
+		fprintf(stderr, "%s: unknown error\n", msg);
+	} else
+		perror(str);
+
+	shm_unlink(URING_SHM_NAME);
+
+	if (save_errno < 0)
+		exit(-save_errno);
+	exit(save_errno);
+}
+
+/**
+ * Determine if SELinux is enabled and set the internal state
+ *
+ * Attempt to read from /proc/self/attr/current and determine if SELinux is
+ * enabled, store the current context/domain in @selinux_ctx if SELinux is
+ * enabled.  We avoid using the libselinux API in order to increase portability
+ * and make it easier for other LSMs to adopt this test.
+ */
+int selinux_enabled(void)
+{
+	int fd = -1;
+	ssize_t ctx_len;
+	char ctx[SELINUX_CTX_MAX];
+
+	if (selinux_state >= 0)
+		return selinux_state;
+
+	/* attempt to get the current context */
+	fd = open("/proc/self/attr/current", O_RDONLY);
+	if (fd < 0)
+		goto err;
+	ctx_len = read(fd, ctx, SELINUX_CTX_MAX - 1);
+	if (ctx_len <= 0)
+		goto err;
+	close(fd);
+
+	/* save the current context */
+	ctx[ctx_len] = '\0';
+	strcpy(selinux_ctx, ctx);
+
+	selinux_state = 1;
+	return selinux_state;
+
+err:
+	if (fd >= 0)
+		close(fd);
+
+	selinux_state = 0;
+	return selinux_state;
+}
+
+/**
+ * Return the current SELinux domain or "DISABLED" if SELinux is not enabled
+ *
+ * The returned string should not be free()'d.
+ */
+const char *selinux_current(void)
+{
+	int rc;
+
+	rc = selinux_enabled();
+	if (!rc)
+		return "DISABLED";
+
+	return selinux_ctx;
+}
+
+/**
+ * Set the SELinux domain for the next exec()'d process
+ * @param ctx the SELinux domain
+ *
+ * This is similar to the setexeccon() libselinux API but we do it manually to
+ * help increase portability and make it easier for other LSMs to adopt this
+ * test.
+ */
+int selinux_exec(const char *ctx)
+{
+	int fd = -1;
+	ssize_t len;
+
+	if (!ctx)
+		return -EINVAL;
+
+	fd = open("/proc/self/attr/exec", O_WRONLY);
+	if (fd < 0)
+		return -errno;
+	len = write(fd, ctx, strlen(ctx) + 1);
+	close(fd);
+
+	return len;
+}
+
+/**
+ * Setup the io_uring
+ * @param ring the io_uring pointer
+ * @param params the io_uring parameters
+ * @param creds pointer to the current process' registered io_uring personality
+ *
+ * Create a new io_uring using @params and return it in @ring with the
+ * registered personality returned in @creds.  Returns 0 on success, negative
+ * values on failure.
+ */
+int uring_setup(struct io_uring *ring,
+		struct io_uring_params *params, int *creds)
+{
+	int rc;
+
+	/* call into liburing to do the setup heavy lifting */
+	rc = io_uring_queue_init_params(URING_ENTRIES, ring, params);
+	if (rc < 0)
+		fatal("io_uring_queue_init_params");
+
+	/* register our creds/personality */
+	rc = io_uring_register_personality(ring);
+	if (rc < 0)
+		fatal("io_uring_register_personality()");
+	*creds = rc;
+	rc = 0;
+
+	printf(">>> io_uring created; fd = %d, personality = %d\n",
+	       ring->ring_fd, *creds);
+
+	return rc;
+}
+
+/**
+ * Import an existing io_uring based on the given file descriptor
+ * @param fd the io_uring's file descriptor
+ * @param ring the io_uring pointer
+ * @param params the io_uring parameters
+ *
+ * This function takes an io_uring file descriptor in @fd as well as the
+ * io_uring parameters in @params and creates a valid io_uring in @ring.
+ * Returns 0 on success, negative values on failure.
+ */
+int uring_import(int fd, struct io_uring *ring, struct io_uring_params *params)
+{
+	memset(ring, 0, sizeof(*ring));
+	ring->flags = params->flags;
+	ring->features = params->features;
+	ring->ring_fd = fd;
+	ring->enter_ring_fd = fd;
+
+	ring->sq.ring_sz = params->sq_off.array +
+			   params->sq_entries * sizeof(unsigned);
+	ring->cq.ring_sz = params->cq_off.cqes +
+			   params->cq_entries * sizeof(struct io_uring_cqe);
+
+	ring->sq.ring_ptr = mmap(NULL, ring->sq.ring_sz, PROT_READ | PROT_WRITE,
+				 MAP_SHARED | MAP_POPULATE, fd,
+				 IORING_OFF_SQ_RING);
+	if (ring->sq.ring_ptr == MAP_FAILED)
+		fatal("import mmap(ring)");
+
+	ring->cq.ring_ptr = mmap(0, ring->cq.ring_sz, PROT_READ | PROT_WRITE,
+				 MAP_SHARED | MAP_POPULATE,
+				 fd, IORING_OFF_CQ_RING);
+	if (ring->cq.ring_ptr == MAP_FAILED) {
+		ring->cq.ring_ptr = NULL;
+		goto err;
+	}
+
+	ring->sq.khead = ring->sq.ring_ptr + params->sq_off.head;
+	ring->sq.ktail = ring->sq.ring_ptr + params->sq_off.tail;
+	ring->sq.kring_mask = ring->sq.ring_ptr + params->sq_off.ring_mask;
+	ring->sq.kring_entries = ring->sq.ring_ptr +
+				 params->sq_off.ring_entries;
+	ring->sq.ring_mask = *ring->sq.kring_mask;
+	ring->sq.ring_entries = *ring->sq.kring_entries;
+	ring->sq.kflags = ring->sq.ring_ptr + params->sq_off.flags;
+	ring->sq.kdropped = ring->sq.ring_ptr + params->sq_off.dropped;
+	ring->sq.array = ring->sq.ring_ptr + params->sq_off.array;
+
+	ring->sq.sqes = mmap(NULL,
+			     params->sq_entries * sizeof(struct io_uring_sqe),
+			     PROT_READ | PROT_WRITE, MAP_SHARED | MAP_POPULATE,
+			     fd, IORING_OFF_SQES);
+	if (ring->sq.sqes == MAP_FAILED)
+		goto err;
+
+	ring->cq.khead = ring->cq.ring_ptr + params->cq_off.head;
+	ring->cq.ktail = ring->cq.ring_ptr + params->cq_off.tail;
+	ring->cq.kring_mask = ring->cq.ring_ptr + params->cq_off.ring_mask;
+	ring->cq.kring_entries = ring->cq.ring_ptr +
+				 params->cq_off.ring_entries;
+	ring->cq.ring_mask = *ring->sq.kring_mask;
+	ring->cq.ring_entries = *ring->sq.kring_entries;
+	ring->cq.koverflow = ring->cq.ring_ptr + params->cq_off.overflow;
+	ring->cq.cqes = ring->cq.ring_ptr + params->cq_off.cqes;
+	if (params->cq_off.flags)
+		ring->cq.kflags = ring->cq.ring_ptr + params->cq_off.flags;
+
+	return 0;
+
+err:
+	if (ring->sq.ring_ptr)
+		munmap(ring->sq.ring_ptr, ring->sq.ring_sz);
+	if (ring->cq.ring_ptr)
+		munmap(ring->cq.ring_ptr, ring->cq.ring_sz);
+	fatal("import mmap");
+	return -ENOMEM;
+}
+
+void uring_shutdown(struct io_uring *ring)
+{
+	if (!ring)
+		return;
+	io_uring_queue_exit(ring);
+}
+
+/**
+ * An io_uring test
+ * @param ring the io_uring pointer
+ * @param personality the registered personality to use or 0
+ * @param path the file path to use for the test
+ *
+ * This function executes an io_uring test, see the function body for more
+ * details.  Returns 0 on success, negative values on failure.
+ */
+int uring_op_a(struct io_uring *ring, int personality, const char *path)
+{
+
+#define __OP_A_BSIZE		512
+#define __OP_A_STR		"Lorem ipsum dolor sit amet.\n"
+
+	int rc;
+	int fds[1];
+	char buf1[__OP_A_BSIZE];
+	char buf2[__OP_A_BSIZE];
+	struct io_uring_sqe *sqe;
+	struct io_uring_cqe *cqe;
+	int str_sz = strlen(__OP_A_STR);
+
+	memset(buf1, 0, __OP_A_BSIZE);
+	memset(buf2, 0, __OP_A_BSIZE);
+	strncpy(buf1, __OP_A_STR, str_sz);
+
+	if (personality > 0)
+		printf(">>> io_uring ops using personality = %d\n",
+		       personality);
+
+	/*
+	 * open
+	 */
+
+	sqe = io_uring_get_sqe(ring);
+	if (!sqe)
+		fatal("io_uring_get_sqe(open)");
+	io_uring_prep_openat(sqe, AT_FDCWD, path,
+			     O_RDWR | O_TRUNC | O_CREAT, 0644);
+	if (personality > 0)
+		sqe->personality = personality;
+
+	rc = io_uring_submit(ring);
+	if (rc < 0)
+		fatal("io_uring_submit(open)");
+
+	rc = io_uring_wait_cqe(ring, &cqe);
+	fds[0] = cqe->res;
+	if (rc < 0)
+		fatal("io_uring_wait_cqe(open)");
+	if (fds[0] < 0)
+		fatal("uring_open");
+	io_uring_cqe_seen(ring, cqe);
+
+	rc = io_uring_register_files(ring, fds, 1);
+	if(rc)
+		fatal("io_uring_register_files");
+
+	printf(">>> io_uring open(): OK\n");
+
+	/*
+	 * write
+	 */
+
+	sqe = io_uring_get_sqe(ring);
+	if (!sqe)
+		fatal("io_uring_get_sqe(write1)");
+	io_uring_prep_write(sqe, 0, buf1, str_sz, 0);
+	io_uring_sqe_set_flags(sqe, IOSQE_FIXED_FILE);
+	if (personality > 0)
+		sqe->personality = personality;
+
+	rc = io_uring_submit(ring);
+	if (rc < 0)
+		fatal("io_uring_submit(write)");
+
+	rc = io_uring_wait_cqe(ring, &cqe);
+	if (rc < 0)
+		fatal("io_uring_wait_cqe(write)");
+	if (cqe->res < 0)
+		fatal("uring_write");
+	if (cqe->res != str_sz)
+		fatal("uring_write(length)");
+	io_uring_cqe_seen(ring, cqe);
+
+	printf(">>> io_uring write(): OK\n");
+
+	/*
+	 * read
+	 */
+
+	sqe = io_uring_get_sqe(ring);
+	if (!sqe)
+		fatal("io_uring_get_sqe(read1)");
+	io_uring_prep_read(sqe, 0, buf2, __OP_A_BSIZE, 0);
+	io_uring_sqe_set_flags(sqe, IOSQE_FIXED_FILE);
+	if (personality > 0)
+		sqe->personality = personality;
+
+	rc = io_uring_submit(ring);
+	if (rc < 0)
+		fatal("io_uring_submit(read)");
+
+	rc = io_uring_wait_cqe(ring, &cqe);
+	if (rc < 0)
+		fatal("io_uring_wait_cqe(read)");
+	if (cqe->res < 0)
+		fatal("uring_read");
+	if (cqe->res != str_sz)
+		fatal("uring_read(length)");
+	io_uring_cqe_seen(ring, cqe);
+
+	if (strncmp(buf1, buf2, str_sz))
+		fatal("strncmp(buf1,buf2)");
+
+	printf(">>> io_uring read(): OK\n");
+
+	/*
+	 * close
+	 */
+
+	sqe = io_uring_get_sqe(ring);
+	if (!sqe)
+		fatal("io_uring_get_sqe(close)");
+	io_uring_prep_close(sqe, 0);
+	if (personality > 0)
+		sqe->personality = personality;
+
+	rc = io_uring_submit(ring);
+	if (rc < 0)
+		fatal("io_uring_submit(close)");
+
+	rc = io_uring_wait_cqe(ring, &cqe);
+	if (rc < 0)
+		fatal("io_uring_wait_cqe(close)");
+	if (cqe->res < 0)
+		fatal("uring_close");
+	io_uring_cqe_seen(ring, cqe);
+
+	rc = io_uring_unregister_files(ring);
+	if (rc < 0)
+		fatal("io_uring_unregister_files");
+
+	printf(">>> io_uring close(): OK\n");
+
+	return 0;
+}
+
+/**
+ * The main entrypoint to the test program
+ * @param argc number of command line options
+ * @param argv the command line options array
+ */
+int main(int argc, char *argv[])
+{
+	int rc = 1;
+	int ring_shm_fd;
+	struct io_uring ring_storage, *ring;
+	struct urt_config *cfg_p;
+	char *progname;
+	char *progdir;
+
+	enum { TST_UNKNOWN,
+	       TST_SQPOLL,
+	       TST_T1_PARENT, TST_T1_CHILD
+	     } tst_method;
+
+	/* parse the command line and do some sanity checks */
+	tst_method = TST_UNKNOWN;
+	if (argc >= 2) {
+		if (!strcmp(argv[1], "sqpoll"))
+			tst_method = TST_SQPOLL;
+		else if (!strcmp(argv[1], "t1") ||
+			 !strcmp(argv[1], "t1_parent"))
+			tst_method = TST_T1_PARENT;
+		else if (!strcmp(argv[1], "t1_child"))
+			tst_method = TST_T1_CHILD;
+	}
+	if (tst_method == TST_UNKNOWN) {
+		fprintf(stderr, "usage: %s <method> ... \n", argv[0]);
+		exit(EINVAL);
+	}
+
+	progname = strdup(argv[0]);
+	progdir = dirname(progname);
+
+	snprintf(uring_path, sizeof(uring_path), "%s/iouring.out", progdir);
+
+	/* simple header */
+	printf(">>> running as PID = %d\n", getpid());
+	printf(">>> LSM/SELinux = %s\n", selinux_current());
+	printf(">>> uring_path = %s\n", uring_path);
+
+	/*
+	 * test setup (if necessary)
+	 */
+	if (tst_method == TST_SQPOLL || tst_method == TST_T1_PARENT) {
+		/* create an io_uring and prepare it for optional sharing */
+		int flags;
+
+		/* create a shm segment to hold the io_uring info */
+		ring_shm_fd = shm_open(URING_SHM_NAME, O_CREAT | O_RDWR,
+				       S_IRUSR | S_IWUSR);
+		if (ring_shm_fd < 0)
+			fatal("shm_open(create)");
+
+		rc = ftruncate(ring_shm_fd, sizeof(struct urt_config));
+		if (rc < 0)
+			fatal("ftruncate(shm)");
+
+		cfg_p = mmap(NULL, sizeof(*cfg_p), PROT_READ | PROT_WRITE,
+			     MAP_SHARED, ring_shm_fd, 0);
+		if (!cfg_p)
+			fatal("mmap(shm)");
+
+		/* create the io_uring */
+		memset(&cfg_p->ring, 0, sizeof(cfg_p->ring));
+		memset(&cfg_p->ring_params, 0, sizeof(cfg_p->ring_params));
+		if (tst_method == TST_SQPOLL)
+			cfg_p->ring_params.flags |= IORING_SETUP_SQPOLL;
+		rc = uring_setup(&cfg_p->ring, &cfg_p->ring_params,
+				 &cfg_p->ring_creds);
+		if (rc)
+			fatal("uring_setup");
+		ring = &cfg_p->ring;
+
+		/* explicitly clear FD_CLOEXEC on the io_uring */
+		flags = fcntl(cfg_p->ring.ring_fd, F_GETFD, 0);
+		if (flags < 0)
+			fatal("fcntl(ring_shm_fd,getfd)");
+		flags &= ~FD_CLOEXEC;
+		rc = fcntl(cfg_p->ring.ring_fd, F_SETFD, flags);
+		if (rc)
+			fatal("fcntl(ring_shm_fd,setfd)");
+	} else if (tst_method == TST_T1_CHILD) {
+		/* import a previously created and shared io_uring */
+
+		/* open the existing shm segment with the io_uring info */
+		ring_shm_fd = shm_open(URING_SHM_NAME, O_RDWR, 0);
+		if (ring_shm_fd < 0)
+			fatal("shm_open(existing)");
+		cfg_p = mmap(NULL, sizeof(*cfg_p), PROT_READ | PROT_WRITE,
+			     MAP_SHARED, ring_shm_fd, 0);
+		if (!cfg_p)
+			fatal("mmap(shm)");
+
+		/* import the io_uring */
+		ring = &ring_storage;
+		rc = uring_import(cfg_p->ring.ring_fd,
+				  ring, &cfg_p->ring_params);
+		if (rc < 0)
+			fatal("uring_import");
+	}
+
+	/*
+	 * fork/exec a child process (if necessary)
+	 */
+	if (tst_method == TST_T1_PARENT) {
+		pid_t pid;
+
+		/* set the ctx for the next exec */
+		if (argc >= 3) {
+			printf(">>> set LSM/SELinux exec: %s\n",
+			       (selinux_exec(argv[2]) > 0 ? "OK" : "FAILED"));
+		}
+
+		/* fork/exec */
+		pid = fork();
+		if (pid < 0)
+			fatal("fork");
+		if (!pid) {
+			/* start the child */
+			rc = execl(argv[0], argv[0], "t1_child", (char *)NULL);
+			if (rc < 0)
+				fatal("exec");
+		} else {
+			/* wait for the child to exit */
+			int status;
+			waitpid(pid, &status, 0);
+			if (WIFEXITED(status))
+				rc = WEXITSTATUS(status);
+		}
+	}
+
+	/*
+	 * run test(s)
+	 */
+	if (tst_method == TST_SQPOLL || tst_method == TST_T1_CHILD) {
+		rc = uring_op_a(ring, cfg_p->ring_creds, uring_path);
+		if (rc < 0)
+			fatal("uring_op_a()");
+	}
+
+	/*
+	 * cleanup
+	 */
+	if (tst_method == TST_SQPOLL || tst_method == TST_T1_PARENT) {
+		printf(">>> shutdown\n");
+		uring_shutdown(&cfg_p->ring);
+		shm_unlink(URING_SHM_NAME);
+	} else if (tst_method == TST_T1_CHILD) {
+		shm_unlink(URING_SHM_NAME);
+	}
+
+	return rc;
+}
diff --git a/tests/io_uring/test b/tests/io_uring/test
new file mode 100755
index 0000000..67769ac
--- /dev/null
+++ b/tests/io_uring/test
@@ -0,0 +1,84 @@
+#!/usr/bin/perl
+
+use Test;
+BEGIN { plan tests => 11 }
+
+$basedir = $0;
+$basedir =~ s|(.*)/[^/]*|$1|;
+
+# Remove any leftover test files from prior runs.
+system("rm -f $basedir/iouring.out");
+
+# Verify that test_io_uring_t passes the t1 test
+$result = system("runcon -t test_io_uring_t $basedir/iouring t1");
+ok( $result, 0 );
+
+# Verify that test_io_uring_no_override_t fails the t1 test on io_uring override_creds
+$result = system(
+    "runcon -t test_io_uring_no_override_t $basedir/iouring t1 2>/dev/null");
+ok($result);
+
+# Verify that test_io_uring_no_readwrite_t fails the t1 test on anon_inode read write
+$result = system(
+    "runcon -t test_io_uring_no_readwrite_t $basedir/iouring t1 2>/dev/null");
+ok($result);
+
+# Verify that test_io_uring_no_map_t fails the t1 test on anon_inode map
+$result =
+  system("runcon -t test_io_uring_no_map_t $basedir/iouring t1 2>/dev/null");
+ok($result);
+
+# Verify that test_io_uring_no_create_t fails the t1 test on anon_inode create
+$result =
+  system("runcon -t test_io_uring_no_create_t $basedir/iouring t1 2>/dev/null");
+ok($result);
+
+# Verify that test_io_uring_parent_t passes the t1 test with
+# test_io_uring_child_t as the exec/child context
+$seuser = `secon -u --pid $$ </dev/null`;
+chomp($seuser);
+$serole = `secon -r --pid $$ </dev/null`;
+chomp($serole);
+$serange = `secon -m --pid $$ </dev/null`;
+chomp($serange);
+$childctx = "$seuser:$serole:test_io_uring_child_t:$serange";
+$result =
+  system("runcon -t test_io_uring_parent_t $basedir/iouring t1 $childctx");
+ok( $result, 0 );
+
+# Verify that test_io_uring_child_no_override_t fails the t1 test on io_uring override_creds
+$childctx = "$seuser:$serole:test_io_uring_child_no_override_t:$serange";
+$result =
+  system(
+    "runcon -t test_io_uring_parent_t $basedir/iouring t1 $childctx 2>/dev/null"
+  );
+ok($result);
+
+# Verify that test_io_uring_child_no_map_t fails the t1 test on anon_inode map
+$childctx = "$seuser:$serole:test_io_uring_child_no_map_t:$serange";
+$result =
+  system(
+    "runcon -t test_io_uring_parent_t $basedir/iouring t1 $childctx 2>/dev/null"
+  );
+ok($result);
+
+# Verify that test_io_uring_child_no_readwrite_t fails the t1 test on anon_inode read write
+$childctx = "$seuser:$serole:test_io_uring_child_no_readwrite_t:$serange";
+$result =
+  system(
+    "runcon -t test_io_uring_parent_t $basedir/iouring t1 $childctx 2>/dev/null"
+  );
+ok($result);
+
+# Verify that test_io_uring_sqpoll_t passes the sqpoll test
+$result = system("runcon -t test_io_uring_sqpoll_t $basedir/iouring sqpoll");
+ok( $result, 0 );
+
+# Verify that test_io_uring_no_sqpoll_t fails the sqpoll test
+$result = system(
+    "runcon -t test_io_uring_no_sqpoll_t $basedir/iouring sqpoll 2>/dev/null");
+ok($result);
+
+# Cleanup
+system("rm -f $basedir/iouring.out");
+
diff --git a/tmt/tests.fmf b/tmt/tests.fmf
index 828e078..1df3a5d 100644
--- a/tmt/tests.fmf
+++ b/tmt/tests.fmf
@@ -121,6 +121,7 @@
     - btrfs-progs
     - rdma-core-devel
     - kexec-tools
+    - liburing-devel
   /main:
     summary: Run the testsuite
     duration: 20m
-- 
2.51.1

