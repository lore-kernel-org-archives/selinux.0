Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AC8A279DCD
	for <selinux@vger.kernel.org>; Wed,  8 Oct 2025 14:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759934440; cv=none; b=QmBkyKLaV1QGrmjxSXEoF0RMB0Yn3sZGKbyo0rk67pGERfDU4mVo75ALWLzJxvQV7dOfabNSzl0igJmutLo7npbGxN9j4vw6gq5AFplx5CxDLeTXlN1yu4WlHeOteXKDoJCi7exqY4k9Lp5wbCM/e11NCZM9TWc/37oqp/oT5B4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759934440; c=relaxed/simple;
	bh=On/ssRliCJ+lzi+IUFGjgwiK12A6dXfmjaTobpMyOKM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pf34bxJ2hZtF4h7TUw8HzD15ROz1nnpjiwwy7gBEIKB9ROH0q9nLwkVbwEIbtXAU/QKUrP0Ys+kdE8tDzBr3sDgWGexSB5Brt9+GvugZzs2zo80NVhysn9bbV6DVdyR4H1bXEAdWyZ7VVZh62Mala7cdcP9rQ5YIA/zBzxZCaYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EfLZ3BL7; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EfLZ3BL7"
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-4e56cd8502aso80263661cf.0
        for <selinux@vger.kernel.org>; Wed, 08 Oct 2025 07:40:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759934437; x=1760539237; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=81gLHPGjuxq1S4fnDZ6X3Cc0W1T7ow5PeO1l2e4jQy8=;
        b=EfLZ3BL7Pyp4dIEwTvCvR7siCqLvGIOJewKrczoG6WIDo93/OGEpO5IR4ni/SC86DR
         WjflRznozE2NSbyK2Sj3TRcxCSmzFZ5iAY7COqPoTg0O6n0bu47SQu69ZAa8tA5ZrezE
         7NdPEZaXSULVzxUa0h0gTiSD9LAhx3A28YXKIe+HN44UOoE8ujulDnckElP9zwE4VVMA
         SemxboHPG+r3qdCo2oUXEhqjJ0hUK4lH4pVk55ZJsekqIf+FqPv7vL/Pjg9rErRAWVUT
         1w5MMPwmOIGVPQx6rew2vQymNiDwIyVZxcKgYC9ynQPkm65w3n7KES0ca0aK1eNQS3jT
         Xtvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759934437; x=1760539237;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=81gLHPGjuxq1S4fnDZ6X3Cc0W1T7ow5PeO1l2e4jQy8=;
        b=OCtAi3rJp5ZQz2w9aoht2TV5iBymvn9mhjJPZPPiSTvv0CIW2GtYpCELyG6Hby2uzw
         +SSM0ilb+yKVM4OLhKytIb6IMowOyxyfQw/6EH3D00gALyZH5UQuFJey1xDnb2kjgria
         koTvitHUhVaMInu3L8/1s0eqexrCX0XlHap82kFBm27qZQffeSE1MK4ujCaBZDcJTgTX
         ju00415shJydgrRXtXJmSfneU+qVcy7EzIB4nC4Zyglnikh3Hkjsg3dQ9fNHzud/alDn
         RAXloxOGgcU+itUZ7UZgB7a1SjuGXbGAEMECzSSY0ryLnffdzdg1XxpTiysVKMCR/SoV
         kTiA==
X-Gm-Message-State: AOJu0YzkpWBGTFxFKYXt+ln+6zEtdKbYA/xmSKw2A+U66mQH9NYpCM4/
	unWzusrMWLGqWsxoTqIkgoRbCPMQymbicr3qC4R0lyJcd5B8B7cqTnMJwc4yIQ==
X-Gm-Gg: ASbGnctW3IQzyB00+Zu9qbacZwrVRlyoayeOXEYR6DX+4bbk+vnjM0ANprcpcXPVmQS
	zbZyZ7WguasbFjzZTYetdQLVo4ib5X6/4EiUhE1/+W9CNFp2zBrLh6NqFNcSjPN4srbn0BT+Fen
	cYS6DKKmDDJLDUrKhUIw9tDwMbzWiFYC1xzetP+OkRqxVlaySASw30LUATMD0p1NS8aLEkZtwAJ
	z1wm47TVuYLtsJzA83j2qsokuNLBH35l+VN9bihjZDYsjkhS8Pv0OoOZRUbRb4zLGW1cxbnU/Ko
	6i5S7sGcO6gwTfJ0QjoDUYufUqVMoJw5qgC5WXoQYE5cWfmAM50EZui9VsWJ9byshBJF4djuDf4
	Ey8vX5O4BDWGuTCRxiXip8gqKMBhyY3J6oY0fVmaBzyicpyPUsk70E9SYPnGvXd0E5t5PxT2utU
	3v5p9MdwcyHTLGwLe7BBry+5/1LS7AZYBwoJr3UvQ4O83BhQ8=
X-Google-Smtp-Source: AGHT+IEDsk5WIqo1K6/orZE7Tvtlk2Sg5GRQFn8vc5ofjQNPK8cEULWe1ddaLiLKxv9Nr9l5yCOAEg==
X-Received: by 2002:a05:622a:1c0e:b0:4e0:a6c6:1c91 with SMTP id d75a77b69052e-4e6ead64d2fmr44514241cf.69.1759934436848;
        Wed, 08 Oct 2025 07:40:36 -0700 (PDT)
Received: from fedora (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-877725550f1sm1736455785a.25.2025.10.08.07.40.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Oct 2025 07:40:36 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: paul@paul-moore.com,
	omosnace@redhat.com,
	Richard Haines <richard_c_haines@btinternet.com>,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH v4] selinux-testsuite: Add btrfs support for filesystem tests
Date: Wed,  8 Oct 2025 10:36:14 -0400
Message-ID: <20251008143612.96917-3-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Richard Haines <richard_c_haines@btinternet.com>

This allows btrfs filesystems to be created to support the
filesystem mount(2) type calls and the fs_filesystem fsmount(2)
type calls.

Signed-off-by: Richard Haines <richard_c_haines@btinternet.com>
Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
v4 drops the mkfs size for btrfs to 128M since it doesn't require
300M, unlike xfs.

v3 was just a re-base of Richard Haines' earlier patch which
ended at v2.

 README.md                      | 2 ++
 defconfig                      | 5 +++++
 tests/Makefile                 | 2 +-
 tests/filesystem/Filesystem.pm | 3 +++
 tests/filesystem/btrfs         | 1 +
 tests/filesystem/test          | 6 ++++++
 tests/fs_filesystem/btrfs      | 1 +
 tests/fs_filesystem/test       | 6 ++++++
 8 files changed, 25 insertions(+), 1 deletion(-)
 create mode 120000 tests/filesystem/btrfs
 create mode 120000 tests/fs_filesystem/btrfs

diff --git a/README.md b/README.md
index f067eeb..973028e 100644
--- a/README.md
+++ b/README.md
@@ -61,6 +61,7 @@ similar dependencies):
 * e2fsprogs _(used by the ext4 filesystem tests)_
 * jfsutils _(used by the jfs filesystem tests)_
 * dosfstools _(used by the vfat filesystem tests)_
+* btrfs-progs _(used by the btrfs filesystem tests)_
 * nftables _(used by inet_socket and sctp tests if ver >= 9.3 for secmark testing )_
 * rdma-core-devel _(to build the `ibpkey` test program)_
 
@@ -136,6 +137,7 @@ command:
 		e2fsprogs \
 		jfsutils \
 		dosfstools \
+		btrfs-progs \
 		nftables \
 		netlabel-tools \
 		libibverbs-dev
diff --git a/defconfig b/defconfig
index b2d4a90..214eb26 100644
--- a/defconfig
+++ b/defconfig
@@ -122,6 +122,11 @@ CONFIG_XFS_QUOTA=y
 CONFIG_VFAT_FS=m
 CONFIG_FAT_DEFAULT_IOCHARSET="ascii"
 
+
+# Test BTRFS filesystem.
+# This is not required for SELinux operation itself.
+CONFIG_BTRFS_FS=y
+
 # watch_queue for key changes.
 # They are not required for SELinux operation itself.
 CONFIG_WATCH_QUEUE=y
diff --git a/tests/Makefile b/tests/Makefile
index 903ab11..f002389 100644
--- a/tests/Makefile
+++ b/tests/Makefile
@@ -4,7 +4,7 @@ SBINDIR ?= $(PREFIX)/sbin
 POLDEV ?= $(PREFIX)/share/selinux/devel
 INCLUDEDIR ?= $(PREFIX)/include
 SELINUXFS ?= /sys/fs/selinux
-FILESYSTEMS ?= ext4 xfs jfs vfat
+FILESYSTEMS ?= ext4 xfs jfs vfat btrfs
 
 export CFLAGS+=-g -O0 -Wall -D_GNU_SOURCE
 
diff --git a/tests/filesystem/Filesystem.pm b/tests/filesystem/Filesystem.pm
index f169464..d5c68e6 100644
--- a/tests/filesystem/Filesystem.pm
+++ b/tests/filesystem/Filesystem.pm
@@ -123,6 +123,9 @@ sub attach_dev {
 sub make_fs {
     my ( $mk_type, $mk_dev, $mk_dir, $mk_opts ) = @_;
     my $mk_size = 16;
+    if ( $mk_type eq "btrfs" ) {
+        $mk_size = 128;
+    }
     if ( $mk_type eq "xfs" ) {
         $mk_size = 300;
     }
diff --git a/tests/filesystem/btrfs b/tests/filesystem/btrfs
new file mode 120000
index 0000000..945c9b4
--- /dev/null
+++ b/tests/filesystem/btrfs
@@ -0,0 +1 @@
+.
\ No newline at end of file
diff --git a/tests/filesystem/test b/tests/filesystem/test
index a7d8b24..56f116a 100755
--- a/tests/filesystem/test
+++ b/tests/filesystem/test
@@ -89,6 +89,12 @@ BEGIN {
         $test_count   = 55;
         $quota_checks = 0;
     }
+
+    # BTRFS uses internal quotas requiring no security hooks
+    elsif ( $fs_type eq "btrfs" ) {
+        $test_count   = 55;
+        $quota_checks = 0;
+    }
     else {
         $test_count = 69;
     }
diff --git a/tests/fs_filesystem/btrfs b/tests/fs_filesystem/btrfs
new file mode 120000
index 0000000..945c9b4
--- /dev/null
+++ b/tests/fs_filesystem/btrfs
@@ -0,0 +1 @@
+.
\ No newline at end of file
diff --git a/tests/fs_filesystem/test b/tests/fs_filesystem/test
index 9af8971..1d04bbc 100755
--- a/tests/fs_filesystem/test
+++ b/tests/fs_filesystem/test
@@ -92,6 +92,12 @@ BEGIN {
         $test_count   = 54;
         $quota_checks = 0;
     }
+
+    # BTRFS uses internal quotas requiring no security hooks
+    elsif ( $fs_type eq "btrfs" ) {
+        $test_count   = 54;
+        $quota_checks = 0;
+    }
     else {
         $test_count = 68;
     }
-- 
2.51.0

