Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2AF335CBD6
	for <selinux@vger.kernel.org>; Wed,  1 Apr 2026 14:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775054956; cv=none; b=uUkB5v9bu3ItaMiI/xPSAQwQlA4zynyX2mkVAJ9qLIoLoLzbtnBjPiv+/nPRNTANehHVIQV42/wJFd4IhHMdIixXKfDcPzN4CJ+jS4PHlkrHjdH++mh2K3UPSiYp11GI06OHuag5InOTFBpaIFuKxdfV50dopduc2JEZB6Qdk0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775054956; c=relaxed/simple;
	bh=DCF/Kz5VFUT+ZZj5Sp6JunwoCZiEyxU82KAakVZLKro=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RcgbCBIvBALt/yYJQg1jjcM8vZwiWtCW/U8/YEZCMRmnIKuevNxFor1aiAg4ajVmZ7gHsKDF4685nKyLhVfjAgdouJt3AGaZjBAN/Bgi4f/DlVqWCbrrbOgGj490jDXSaJY12c/8hIbHRJdFrwMuMlb8uMcp47JjIVAGkRjwcHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B63SL8Mr; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B63SL8Mr"
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-8d0288d24f6so175863085a.0
        for <selinux@vger.kernel.org>; Wed, 01 Apr 2026 07:49:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775054952; x=1775659752; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=OQDN8e0LyAnkj6vWxSqIsLgnB/u07ywQQ4eOUbyx7e0=;
        b=B63SL8Mr3aLhkWBc+EqtxqSTmPSrv+/G9H1uUMl1E9DUctxB8gjPm0qPhs6JfWbSgA
         OSjOM0nDjWZVzRi1eKKJwo5gHIivLuDLqChLcZ7EGsyxP0wtkpjZmBap0ztiVuJQixb9
         WfVOEZ1zeXpzWFUuTNdQGz5jztHRLrL9YUmDqGseGU44dXZ/1RBWkxLIge/BQueoWVIj
         o73ED3XXK9hvmxHT6bQGugljPvA30IgJjya3sEnY6UriUj5GB0xEN1CE0u8qqG7hqz1o
         36ZOY/hM6vMz0rFHIiOk5Rj5eVKEsRJKKoxBrKvyzfnFgNXBZwxShE2ZEizn+9cnBnQ0
         9WGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775054952; x=1775659752;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OQDN8e0LyAnkj6vWxSqIsLgnB/u07ywQQ4eOUbyx7e0=;
        b=sW/ubNZwU+vAWF3dbuAwxC+G8/1iKRDjqOX68DgYLS5wSWKbRyTetqNt3uQhE7mUi0
         u49E6TqZOpKPyXOzQIFjNFJU2rm/CV5ciM6YuFgc3c0hrSC92+Mti8wyiF4daJ0XPiZ8
         MRW7tONrroMdyE5PJm7kAw4r7O9v42gJFsho2AdC4UA8smgjTZtvCRLkRfSCLfaVSNjg
         y0haaGgJpSBr4k08Ecptp8/xNp9UbkNJkXud+aR+wmnE4TiHS/gEZESIb43vtRh7zjBX
         0xypChP0SUy1FKTcZu0zewHsFtGdW/LHBMvHgQoaktWLR1s/3MsV1X1c9xg3W1elMW7S
         tJaw==
X-Gm-Message-State: AOJu0YwN+6ZRoFWbKxyc0M2D6EEwFA42PaaxLmc649CWrCdDwGk56IoD
	ewpygIqGcN+Rpp3xxIAqLTPpkxUibmV21e0ugpSVn0zvQ2yO46DDk0ppZI/ntg==
X-Gm-Gg: ATEYQzx/jqkbDvdiEcnNlps3198UISnBFm0bRuPnkry1D9aBjYzspnbVTOJy5u3OLBh
	Z9VzvsdpOOQts55IreP7gaIaCaz+5JXBhKgGu1KqCZPW14NHrAIynOSZw5mDrhfqiRYhZOGMUMO
	QA7jj8XfMP9ayjKRiqSwp6gib7XpEVh7kgYei6WUPV+LmlLfhA+42UMEbdRQRzTPfxOqAZFJbU8
	dv5UsQCsEOH/BdirbWWiWyhihq5h+k19UCe9Lb4r7qtsa+Qkap4bzLS5YtAGI4N8UYpp5z47cvo
	op88FHtBX0BXYEQUsCx8rMai+zSIH5bG2JOt8OjO7w91xPeW+QRijzIalWsS7rwpsYOmBbbnbJw
	9x5v+UCHp5oQ3VHYYOP0/21+mzDLQWJc5hvPV1xSfliq+7SOTxHCCBmrYbu2Cf1pHUiGl+A1CY9
	AtZshLJofE9GhWzJxAB5YE5eNQMcmF+s0m737uoda12SBhMXdkkq1MOEINQoqUK0urfNX/32l+Q
	ucp6bbVP6f0H0O/E0mwLfylNs9PimVASRr77C8DJIQLEWBCFM1bKmM=
X-Received: by 2002:a05:620a:2947:b0:8cd:9584:6340 with SMTP id af79cd13be357-8d1aa7234afmr963136585a.43.1775054951946;
        Wed, 01 Apr 2026 07:49:11 -0700 (PDT)
Received: from fuse-fed34-svr.evoforge.org (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8d028041852sm1105277085a.30.2026.04.01.07.49.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Apr 2026 07:49:11 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: paul@paul-moore.com,
	omosnace@redhat.com,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH testsuite] Test f2fs SELinux support
Date: Wed,  1 Apr 2026 10:48:08 -0400
Message-ID: <20260401144808.35015-2-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add f2fs to the set of filesystem types being tested.

Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
 README.md                      | 2 ++
 defconfig                      | 2 ++
 tests/Makefile                 | 2 +-
 tests/filesystem/Filesystem.pm | 3 +++
 tests/filesystem/f2fs          | 1 +
 tests/fs_filesystem/f2fs       | 1 +
 6 files changed, 10 insertions(+), 1 deletion(-)
 create mode 120000 tests/filesystem/f2fs
 create mode 120000 tests/fs_filesystem/f2fs

diff --git a/README.md b/README.md
index 0338964..5487085 100644
--- a/README.md
+++ b/README.md
@@ -59,6 +59,7 @@ similar dependencies):
 * kernel-devel _(used by the kernel module tests)_
 * quota, xfsprogs-devel and libuuid-devel _(used by the filesystem tests)_
 * e2fsprogs _(used by the ext4 filesystem tests)_
+* f2fs-tools _(used by the f2fs filesystem tests)_
 * jfsutils _(used by the jfs filesystem tests)_
 * dosfstools _(used by the vfat filesystem tests)_
 * btrfs-progs _(used by the btrfs filesystem tests)_
@@ -89,6 +90,7 @@ following command (NOTE: On Fedora 32 and below you need to remove
 		xfsprogs-devel \
 		libuuid-devel \
 		e2fsprogs \
+		f2fs-tools \
 		jfsutils \
 		dosfstools \
 		btrfs-progs \
diff --git a/defconfig b/defconfig
index 214eb26..3dcf710 100644
--- a/defconfig
+++ b/defconfig
@@ -33,6 +33,8 @@ CONFIG_EXT4_FS_SECURITY=y
 CONFIG_JFS_SECURITY=y
 CONFIG_XFS_SECURITY=y
 CONFIG_JFFS2_FS_SECURITY=y
+CONFIG_F2FS_FS=m
+CONFIG_F2FS_FS_SECURITY=y
 
 # Network protocol implementations.
 # These are enabled to test the extended socket classes in
diff --git a/tests/Makefile b/tests/Makefile
index 07403be..4fe6f3c 100644
--- a/tests/Makefile
+++ b/tests/Makefile
@@ -4,7 +4,7 @@ SBINDIR ?= $(PREFIX)/sbin
 POLDEV ?= $(PREFIX)/share/selinux/devel
 INCLUDEDIR ?= $(PREFIX)/include
 SELINUXFS ?= /sys/fs/selinux
-FILESYSTEMS ?= ext4 xfs jfs vfat btrfs
+FILESYSTEMS ?= ext4 xfs jfs vfat btrfs f2fs
 
 export CFLAGS+=-g -O0 -Wall -D_GNU_SOURCE
 
diff --git a/tests/filesystem/Filesystem.pm b/tests/filesystem/Filesystem.pm
index ff9748e..9953923 100644
--- a/tests/filesystem/Filesystem.pm
+++ b/tests/filesystem/Filesystem.pm
@@ -129,6 +129,9 @@ sub make_fs {
     elsif ( $mk_type eq "btrfs" ) {
         $mk_size = 128;
     }
+    elsif ( $mk_type eq "f2fs" ) {
+	$mk_size = 64;
+    }
 
     print "Create $mk_dir/fstest with dd\n";
     $result =
diff --git a/tests/filesystem/f2fs b/tests/filesystem/f2fs
new file mode 120000
index 0000000..945c9b4
--- /dev/null
+++ b/tests/filesystem/f2fs
@@ -0,0 +1 @@
+.
\ No newline at end of file
diff --git a/tests/fs_filesystem/f2fs b/tests/fs_filesystem/f2fs
new file mode 120000
index 0000000..945c9b4
--- /dev/null
+++ b/tests/fs_filesystem/f2fs
@@ -0,0 +1 @@
+.
\ No newline at end of file
-- 
2.53.0

