Return-Path: <SRS0=qOYA=EG=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D3CCC388F7
	for <selinux@archiver.kernel.org>; Sat, 31 Oct 2020 11:56:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F0A2E20724
	for <selinux@archiver.kernel.org>; Sat, 31 Oct 2020 11:56:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="M1Jfw7a1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727092AbgJaL4Q (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sat, 31 Oct 2020 07:56:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:32370 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727060AbgJaL4Q (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sat, 31 Oct 2020 07:56:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1604145374;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Z/y1OYalnRGI1Olmrjs8WONPGORx9187XsB0QOJai9k=;
        b=M1Jfw7a1A4MycpQtyOQN/DkgId+9P+7IUtEhe4MWSDa/NCi61pas2u49LVrO2B6awKruYG
        ujJl0A7Vg0J43y0/4XwzDxqgWyCqM+FYuioEBezZa4RaAQJoykFjiT9FDbyJEoHzEsxMAM
        mwZV5PM6Og07uYm+cc6k25CgbTw1WbQ=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-558-Vzf3ykXPPR6RSViik_pvsA-1; Sat, 31 Oct 2020 07:56:08 -0400
X-MC-Unique: Vzf3ykXPPR6RSViik_pvsA-1
Received: by mail-ed1-f71.google.com with SMTP id u12so3803039edi.17
        for <selinux@vger.kernel.org>; Sat, 31 Oct 2020 04:56:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Z/y1OYalnRGI1Olmrjs8WONPGORx9187XsB0QOJai9k=;
        b=f2HE9sv9mCQHl2k/8cQUxs/0/Tong3veByTNRDVPQFEQ5I1aTXqYinR5Mooo4nxP+1
         nf3+lBtuHYHvggYjUl44fzziHrq3JCYqDEINKnAJaRmN0cTzZSbpXqzC5dx8C6daw0ys
         1hfNhWvbIEU2kAzDktu8mmJ/v07y8FX27baLmA6Ckxju9E/CPDw//AYOnoGFS2day8xd
         ujZzeNPWQITuusCjsx81dlrPlx28J2U9wmqnmSsYt62J8OWdEHaVP8xhDKX68v/Vxnav
         qlbZuJGxjLVn31WGTXMyG6/O1R2yeTLQqT0L2FDT9gonji/6IipAVWxq9Tm3RE2nn8N+
         1YNQ==
X-Gm-Message-State: AOAM532JY5IojEZmk4KU9XqwhIQ1ez2NnmsFVpum5t16gB1++r/t3M94
        knMxzR5QH5UCTZZ8ULr5/ZRIO/V8gdFOVJ+3KsI9A1ZFyX0g/1tZJOi8bhBYVNSh69Gd3ofynnI
        7RvjSj3FLSoWCQIBWgg==
X-Received: by 2002:aa7:ce8c:: with SMTP id y12mr7512284edv.185.1604145366682;
        Sat, 31 Oct 2020 04:56:06 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxTmdMF1ua5YuYALF20VcwGVJqQ3KxdeTYua7fUgVdQsdhBgRWYZhdYKqzLEx2SgwSOyH95Wg==
X-Received: by 2002:aa7:ce8c:: with SMTP id y12mr7512269edv.185.1604145366457;
        Sat, 31 Oct 2020 04:56:06 -0700 (PDT)
Received: from omos.redhat.com ([2a02:8308:b103:4000:9293:f330:b535:b530])
        by smtp.gmail.com with ESMTPSA id y14sm4770746edo.69.2020.10.31.04.56.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Oct 2020 04:56:05 -0700 (PDT)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     selinux@vger.kernel.org
Cc:     Richard Haines <richard_c_haines@btinternet.com>,
        Paul Moore <paul@paul-moore.com>
Subject: [PATCH testsuite 3/3] tests/[fs_]filesystem: test all filesystems
Date:   Sat, 31 Oct 2020 12:56:01 +0100
Message-Id: <20201031115601.157591-4-omosnace@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201031115601.157591-1-omosnace@redhat.com>
References: <20201031115601.157591-1-omosnace@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Run [fs_]filesystem tests always for all common filesystems (xfs, ext4,
jfs, vfat). Use symlinks to achieve this without changing much code
while still allowing to run the test script directly (optionally
specifying the filesystem type).

Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
---
 tests/Makefile           |  8 ++++++--
 tests/filesystem/ext4    |  1 +
 tests/filesystem/jfs     |  1 +
 tests/filesystem/test    | 14 ++++++++++++--
 tests/filesystem/vfat    |  1 +
 tests/filesystem/xfs     |  1 +
 tests/fs_filesystem/ext4 |  1 +
 tests/fs_filesystem/jfs  |  1 +
 tests/fs_filesystem/test | 14 ++++++++++++--
 tests/fs_filesystem/vfat |  1 +
 tests/fs_filesystem/xfs  |  1 +
 11 files changed, 38 insertions(+), 6 deletions(-)
 create mode 120000 tests/filesystem/ext4
 create mode 120000 tests/filesystem/jfs
 create mode 120000 tests/filesystem/vfat
 create mode 120000 tests/filesystem/xfs
 create mode 120000 tests/fs_filesystem/ext4
 create mode 120000 tests/fs_filesystem/jfs
 create mode 120000 tests/fs_filesystem/vfat
 create mode 120000 tests/fs_filesystem/xfs

diff --git a/tests/Makefile b/tests/Makefile
index 001639b..b441031 100644
--- a/tests/Makefile
+++ b/tests/Makefile
@@ -4,6 +4,7 @@ SBINDIR ?= $(PREFIX)/sbin
 POLDEV ?= $(PREFIX)/share/selinux/devel
 INCLUDEDIR ?= $(PREFIX)/include
 SELINUXFS ?= /sys/fs/selinux
+FILESYSTEMS ?= ext4 xfs jfs vfat
 
 export CFLAGS+=-g -O0 -Wall -D_GNU_SOURCE
 
@@ -17,6 +18,9 @@ MOD_POL_VERS := $(shell $(CHECKMODULE) -V |cut -f 2 -d '-')
 MAX_KERNEL_POLICY := $(shell cat $(SELINUXFS)/policyvers)
 POL_TYPE := $(shell ./pol_detect $(SELINUXFS))
 
+# Filter out unavailable filesystems
+FILESYSTEMS := $(foreach fs,$(FILESYSTEMS),$(shell modprobe $(fs) && echo $(fs)))
+
 SUBDIRS:= domain_trans entrypoint execshare exectrace execute_no_trans \
 	fdreceive inherit link mkdir msg open ptrace readlink relabel rename \
 	rxdir sem setattr setnice shm sigkill stat sysctl task_create \
@@ -111,7 +115,7 @@ SUBDIRS += lockdown
 endif
 
 ifeq ($(shell grep -q filesystem $(POLDEV)/include/support/all_perms.spt && echo true),true)
-SUBDIRS += filesystem
+SUBDIRS += $(addprefix filesystem/,$(FILESYSTEMS))
 ifeq ($(shell grep -q all_filesystem_perms.*watch $(POLDEV)/include/support/all_perms.spt && echo true),true)
 export CFLAGS += -DHAVE_FS_WATCH_PERM
 endif
@@ -119,7 +123,7 @@ endif
 
 ifeq ($(shell grep -q filesystem $(POLDEV)/include/support/all_perms.spt && echo true),true)
 ifneq ($(shell ./kvercmp $$(uname -r) 5.2),-1)
-SUBDIRS += fs_filesystem
+SUBDIRS += $(addprefix fs_filesystem/,$(FILESYSTEMS))
 endif
 endif
 
diff --git a/tests/filesystem/ext4 b/tests/filesystem/ext4
new file mode 120000
index 0000000..945c9b4
--- /dev/null
+++ b/tests/filesystem/ext4
@@ -0,0 +1 @@
+.
\ No newline at end of file
diff --git a/tests/filesystem/jfs b/tests/filesystem/jfs
new file mode 120000
index 0000000..945c9b4
--- /dev/null
+++ b/tests/filesystem/jfs
@@ -0,0 +1 @@
+.
\ No newline at end of file
diff --git a/tests/filesystem/test b/tests/filesystem/test
index 7d4654d..6b37b76 100755
--- a/tests/filesystem/test
+++ b/tests/filesystem/test
@@ -12,6 +12,17 @@ BEGIN {
     $basedir = $0;
     $basedir =~ s|(.*)/[^/]*|$1|;
 
+    # extract test_name and move up one dir if started from a subdir
+    $test_name = $basedir;
+    $test_name =~ s|.*/([^/]*)|$1|;
+    if ( $test_name eq "fs_filesystem" ) {
+        $fs_type = " ";
+    }
+    else {
+        $fs_type = $test_name;
+        $basedir =~ s|(.*)/[^/]*|$1|;
+    }
+
     # Options: -v Verbose, -e enable udisks(8) daemon, -f filesystem type
     $v              = " ";
     $disable_udisks = 1;
@@ -20,8 +31,7 @@ BEGIN {
     $nfs_enabled    = 0;
     $vfat_enabled   = 0;
 
-    $i       = 0;
-    $fs_type = " ";
+    $i = 0;
     foreach $arg (@ARGV) {
         if ( $arg eq "-v" ) {
             $v = $arg;
diff --git a/tests/filesystem/vfat b/tests/filesystem/vfat
new file mode 120000
index 0000000..945c9b4
--- /dev/null
+++ b/tests/filesystem/vfat
@@ -0,0 +1 @@
+.
\ No newline at end of file
diff --git a/tests/filesystem/xfs b/tests/filesystem/xfs
new file mode 120000
index 0000000..945c9b4
--- /dev/null
+++ b/tests/filesystem/xfs
@@ -0,0 +1 @@
+.
\ No newline at end of file
diff --git a/tests/fs_filesystem/ext4 b/tests/fs_filesystem/ext4
new file mode 120000
index 0000000..945c9b4
--- /dev/null
+++ b/tests/fs_filesystem/ext4
@@ -0,0 +1 @@
+.
\ No newline at end of file
diff --git a/tests/fs_filesystem/jfs b/tests/fs_filesystem/jfs
new file mode 120000
index 0000000..945c9b4
--- /dev/null
+++ b/tests/fs_filesystem/jfs
@@ -0,0 +1 @@
+.
\ No newline at end of file
diff --git a/tests/fs_filesystem/test b/tests/fs_filesystem/test
index 5dedf83..ec71d92 100755
--- a/tests/fs_filesystem/test
+++ b/tests/fs_filesystem/test
@@ -12,6 +12,17 @@ BEGIN {
     $basedir = $0;
     $basedir =~ s|(.*)/[^/]*|$1|;
 
+    # extract test_name and move up one dir if started from a subdir
+    $test_name = $basedir;
+    $test_name =~ s|.*/([^/]*)|$1|;
+    if ( $test_name eq "fs_filesystem" ) {
+        $fs_type = " ";
+    }
+    else {
+        $fs_type = $test_name;
+        $basedir =~ s|(.*)/[^/]*|$1|;
+    }
+
     # Some code in tests/filesystem is reused
     $filesystem_dir = "$basedir/../filesystem";
 
@@ -23,8 +34,7 @@ BEGIN {
     $nfs_enabled    = 0;
     $vfat_enabled   = 0;
 
-    $i       = 0;
-    $fs_type = " ";
+    $i = 0;
     foreach $arg (@ARGV) {
         if ( $arg eq "-v" ) {
             $v = $arg;
diff --git a/tests/fs_filesystem/vfat b/tests/fs_filesystem/vfat
new file mode 120000
index 0000000..945c9b4
--- /dev/null
+++ b/tests/fs_filesystem/vfat
@@ -0,0 +1 @@
+.
\ No newline at end of file
diff --git a/tests/fs_filesystem/xfs b/tests/fs_filesystem/xfs
new file mode 120000
index 0000000..945c9b4
--- /dev/null
+++ b/tests/fs_filesystem/xfs
@@ -0,0 +1 @@
+.
\ No newline at end of file
-- 
2.26.2

