Return-Path: <SRS0=BHhV=EI=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8F13C388F2
	for <selinux@archiver.kernel.org>; Mon,  2 Nov 2020 08:35:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9B52F20756
	for <selinux@archiver.kernel.org>; Mon,  2 Nov 2020 08:35:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OVpUs0GS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727902AbgKBIf3 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 2 Nov 2020 03:35:29 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:46650 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727972AbgKBIf3 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 2 Nov 2020 03:35:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1604306127;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YylDKXGj+yoMBkJBYwGvlONXX4fbuQwuC7OTKd//2GU=;
        b=OVpUs0GSEn1V65BfDw6jnfTv5Scsgt49SM1i7sfazCWUndvbjgGcSp97IJn63afAK8ReWx
        hCpOEdA8n2mYMw5XvtikR0oye2gr/u+2jHa7nu/nbASnQv6252o3XJ5kWnLbGbhG3/bOVO
        dUOZf9i4EBAuWHAvYEdyPXqma710p3A=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-109-BFWlMUGZOwuBszfbMJKn3A-1; Mon, 02 Nov 2020 03:35:25 -0500
X-MC-Unique: BFWlMUGZOwuBszfbMJKn3A-1
Received: by mail-ej1-f71.google.com with SMTP id 27so316942ejy.8
        for <selinux@vger.kernel.org>; Mon, 02 Nov 2020 00:35:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YylDKXGj+yoMBkJBYwGvlONXX4fbuQwuC7OTKd//2GU=;
        b=ZFmi90HKAukNZIKEBKhKFujkDnKz2KtSTLpZerTvTnx7F6b4m4DJJXpu7rRZ50yWqY
         fHSvBYIvrIREZE1xabR5w2IjsyTfw5/a54BCGGQYyUnsuSgNamobDYjBJnBwdrl+7gl0
         4rHYqxKKW2EX0D0JcJk2ghPL/v1A2htNmQw/SauskUMjQCvlIzk8LOiQTCu/ljFCq34l
         l525TSRS/IYI4y3tzpVPso8H5isN+6mpB4bMid2loZLIX6qH4jeM8sJUxi+nk4+8ciDW
         nXqoSJrY1AErIG3amZTGnneb0fbK4S03LDcnmE/K+pg3RC03zx30g7kcZHdNDvld1uGD
         9ZIg==
X-Gm-Message-State: AOAM5331f2sbHTb2Z8urvj0JWK6dMXxDVZzgS9K+aRG5H7VP6mOhLlrb
        8h4PiNQGdfYH2lv0xcbzI8u3oeKSWLSNI+1a+DYaEVA4YSFB3ZCqqti+QqPdtDFFUhpENaMaY32
        Rv5LtEVIUySWvfh5Qxg==
X-Received: by 2002:a17:906:16d6:: with SMTP id t22mr2157022ejd.376.1604306124019;
        Mon, 02 Nov 2020 00:35:24 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzRoFWQyPq9zqnlpcphNJVDbsPIkK7WkswVgGtWzgeK3M9ps9imetoCMxbMxtJyAe+2xMTdJA==
X-Received: by 2002:a17:906:16d6:: with SMTP id t22mr2157012ejd.376.1604306123698;
        Mon, 02 Nov 2020 00:35:23 -0800 (PST)
Received: from omos.redhat.com ([2a02:8308:b103:4000:9293:f330:b535:b530])
        by smtp.gmail.com with ESMTPSA id bk13sm9293716ejb.58.2020.11.02.00.35.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2020 00:35:22 -0800 (PST)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     selinux@vger.kernel.org
Cc:     Richard Haines <richard_c_haines@btinternet.com>,
        Paul Moore <paul@paul-moore.com>
Subject: [PATCH testsuite v2 4/4] tests/[fs_]filesystem: test all filesystems
Date:   Mon,  2 Nov 2020 09:35:16 +0100
Message-Id: <20201102083516.477149-5-omosnace@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201102083516.477149-1-omosnace@redhat.com>
References: <20201102083516.477149-1-omosnace@redhat.com>
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
 tests/filesystem/test    | 28 +++++++++++++---------------
 tests/filesystem/vfat    |  1 +
 tests/filesystem/xfs     |  1 +
 tests/fs_filesystem/ext4 |  1 +
 tests/fs_filesystem/jfs  |  1 +
 tests/fs_filesystem/test | 34 ++++++++++++++++------------------
 tests/fs_filesystem/vfat |  1 +
 tests/fs_filesystem/xfs  |  1 +
 11 files changed, 43 insertions(+), 35 deletions(-)
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
index 5a9f0f6..c94deda 100755
--- a/tests/filesystem/test
+++ b/tests/filesystem/test
@@ -2,15 +2,22 @@
 use Test::More;
 
 # Load common subroutines.
-use File::Basename qw(dirname);
+use File::Basename qw(dirname basename);
 use Cwd qw(abs_path);
-use lib dirname( abs_path $0);
+
+BEGIN {
+    $basedir = dirname($0);
+    $basedir = `cd $basedir && pwd`;
+    chomp($basedir);
+}
+use lib $basedir;
 use Filesystem
   qw(check_config udisks2_stop udisks2_restart get_loop_dev attach_dev make_fs mk_mntpoint_1 mk_mntpoint_2 cleanup cleanup1 reaper nfs_gen_opts);
 
 BEGIN {
-    $basedir = $0;
-    $basedir =~ s|(.*)/[^/]*|$1|;
+    # extract fs_type
+    $test_name = basename($basedir);
+    $fs_type   = $test_name ne "filesystem" ? $test_name : " ";
 
     # Options: -v Verbose, -e enable udisks(8) daemon, -f filesystem type
     $v              = " ";
@@ -20,8 +27,7 @@ BEGIN {
     $nfs_enabled    = 0;
     $vfat_enabled   = 0;
 
-    $i       = 0;
-    $fs_type = " ";
+    $i = 0;
     foreach $arg (@ARGV) {
         if ( $arg eq "-v" ) {
             $v = $arg;
@@ -131,15 +137,7 @@ print "Testing filesystem fs_type: $fs_type\n";
 
 # mount(2) MS_BIND | MS_PRIVATE requires an absolute path to a private mount
 # point before MS_MOVE
-$cwd = `pwd 2>/dev/null`;
-chomp($cwd);
-$private_path = "$cwd";
-if ( $basedir eq "." ) {
-    $private_path = "$cwd/mntpoint";
-}
-else {
-    $private_path = "$cwd/$basedir/mntpoint";
-}
+$private_path = abs_path($basedir) . "/mntpoint";
 
 # Keep a list of devices used for removal at end of test.
 $device_count = 0;
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
index 4462438..e706e42 100755
--- a/tests/fs_filesystem/test
+++ b/tests/fs_filesystem/test
@@ -2,18 +2,25 @@
 use Test::More;
 
 # Load common subroutines.
-use File::Basename qw(dirname);
+use File::Basename qw(dirname basename);
 use Cwd qw(abs_path);
-use lib dirname( abs_path $0) . '/../filesystem';
-use Filesystem
-  qw(check_config udisks2_stop udisks2_restart get_loop_dev attach_dev make_fs mk_mntpoint_1 mk_mntpoint_2 cleanup cleanup1 reaper nfs_gen_opts);
 
 BEGIN {
-    $basedir = $0;
-    $basedir =~ s|(.*)/[^/]*|$1|;
+    $basedir = dirname($0);
+    $basedir = `cd $basedir && pwd`;
+    chomp($basedir);
 
     # Some code in tests/filesystem is reused
-    $filesystem_dir = "$basedir/../filesystem";
+    $filesystem_dir = abs_path($basedir) . "/../filesystem";
+}
+use lib $filesystem_dir;
+use Filesystem
+  qw(check_config udisks2_stop udisks2_restart get_loop_dev attach_dev make_fs mk_mntpoint_1 mk_mntpoint_2 cleanup cleanup1 reaper nfs_gen_opts);
+
+BEGIN {
+    # extract fs_type
+    $test_name = basename($basedir);
+    $fs_type   = $test_name ne "fs_filesystem" ? $test_name : " ";
 
     # Options: -v = Verbose, -e enable udisks(8) daemon, -f filesystem type
     $v              = " ";
@@ -23,8 +30,7 @@ BEGIN {
     $nfs_enabled    = 0;
     $vfat_enabled   = 0;
 
-    $i       = 0;
-    $fs_type = " ";
+    $i = 0;
     foreach $arg (@ARGV) {
         if ( $arg eq "-v" ) {
             $v = $arg;
@@ -133,15 +139,7 @@ BEGIN {
 print "Testing filesystem fs_type: $fs_type\n";
 
 # Generate an absolute path to a private mount
-$cwd = `pwd 2>/dev/null`;
-chomp($cwd);
-$private_path = "$cwd";
-if ( $basedir eq "." ) {
-    $private_path = "$cwd/mntpoint";
-}
-else {
-    $private_path = "$cwd/$basedir/mntpoint";
-}
+$private_path = abs_path($basedir) . "/mntpoint";
 
 # Keep a list of devices used for removal at end of test.
 $device_count = 0;
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

