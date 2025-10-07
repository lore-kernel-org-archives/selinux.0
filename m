Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 888A32E975F
	for <selinux@vger.kernel.org>; Tue,  7 Oct 2025 18:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759862260; cv=none; b=gHxHp/22VnbPnMX77b6E0uJezMsGs81ZhYkGE+bVPVV03wVLSwAZ91M9O8SPz5bYYHO06VgGfh3xoowzpav97l39gh4cCZ0mC2gqvxiW6AYJwf8U8G4MjzbausWFBaeIFRtEbSX+SvNDQLvRxz7xIQijcA55vKCu7YlnthUVfJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759862260; c=relaxed/simple;
	bh=eyn/KzFOy4T91KZL7RI/g5YyUZrnAGnZH/GVjmna92E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tsRHUFJKhQayaOdVTk1ssC53FGRznEKa2LzYWz9Fk2ikzzuAUd+D2J32zBucJs+3009PY2robp2ILjBYTf5uipkzAJ9Jzp7VmfiNgeJuJJwvEYN8gwhk/rSxVnHZkGNh74LFbqrTkZMPNwv/xDYOX0FN4U/1lCprJT/4EN/GsLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dfXK+aPW; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dfXK+aPW"
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-4df81016e59so61284761cf.3
        for <selinux@vger.kernel.org>; Tue, 07 Oct 2025 11:37:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759862256; x=1760467056; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+J4WMHvjjOYESNywHE8lupCDlHEDXgItV6s/g7WLU0Y=;
        b=dfXK+aPW/CIE1ADv2rnFYR2eU82Qc6akDCeuI7dOwD5dt2geew0jcYh5ZXs23L55ST
         fFUADdlFZ6/L2x/ro1kIqamGOHukDbrEY14T+jGBl4BlehxQI4CmjeY+tyVJj2GKuDjO
         ovdqpykcReeLRvdHQ5/LrvaSSK3eplD5A4QJMD/lFMK839siimz/IDLOmk/eig1NRC+X
         Pg35hLK9AccpmP8cbAxMxuO31M0NQcPx9p8Kj+dx7bPx/8ULg5ym35/zLWI+9IsLHVaO
         SzhqldNcYYWJ12Q+mCFk+xyqRy88ilqJSqrmC3mpI3IDQahlA5eakYasm7u+cBAGUCJT
         oC7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759862256; x=1760467056;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+J4WMHvjjOYESNywHE8lupCDlHEDXgItV6s/g7WLU0Y=;
        b=IC4PO2uxVyDPP9aRRYGK0aNCp+P6/sbOUNXSmF+7k5mjuvXHpYqcRkQNRURcuA3lP3
         fGeK41DyL7RCN3dXdKU+Me6CD3lC/dgA5G+C2I5QW4zBKACxU8UcQS8klNnthqaVKvhi
         MjNhrLfAzBHQNUQlRjZbFt7ZRow1JQwIX8hLLqJXUHy+Kp/VDS3zwr7/dFhaxBy9YSDL
         wAAuXDpYVfx9yk1UmJ9SHNoxO5VTGImzIsOXKv+wiztaw9PptwUC3eAMhkEHFIdeiwqG
         fQeSHZLf+p9TX0HREbZJB4FxzFo59LHBXwU8MQLUAnUA1Cuf1wyltR2394GwLQM3s4aF
         5lPQ==
X-Gm-Message-State: AOJu0YwpYhbjhwibdTz6XoAO9i7ogHJ+64Zyz63mmWID2UqP3QJ25Fd+
	4qRZEmikykSR8IegDBczLRF9CWhDnMdDMTXqQsohxtb5lcx4qWuE+4mxjSwcoQ==
X-Gm-Gg: ASbGncs9Fp5FPgpWqloSUa6hcD9W/gelnKSkdTy/jo66TJm2gROYJWP1J3VTQqRllYD
	H33NHiorRPoa4/exrIifVd+58FVTQQXYXSzb43R+ghDrhvmlshKW8B8UBqZUQ2+J6cW80ZpX5Oo
	SN29Yz2L8MGK2NGH4C8fSUdp5End3mKo6NQFTI9F+KOuYxumPiVtKSbcsXrbFx/VsKjRvaQ0Q7D
	J8QDaNhZq5wxYzwjixIhqgi4Ve2sb6+Fp4jCdURUfx3LvSKiPzdpVJ4uYyy/HdxRURs3Wngwn0s
	57TI91iPSzfsUZRM3+E3o3qI4QwVIT8LlF6wUXqE256XzIy0VOPiFiBOvBkBg51hN034rBsXZ0E
	HvJcN28Q0psc5RFxP8stP/94uXvfVLk84jYxj6pYtDeZFDQ6JHHtvHUqUET+iEC3HPU6BfyGUIH
	ofFEmmEa4fI86R9l9FwG0h+82GC5AJDtzz94kLwDIX6JjTkdU=
X-Google-Smtp-Source: AGHT+IH6MtvFvd6uN7fkeUEXvArACo/bro5UcS+0UjVdVXI2Mh2kZ7E7xx2IEZJQ1TdRavDdfaeiIQ==
X-Received: by 2002:ac8:5d4d:0:b0:4cf:ce43:5603 with SMTP id d75a77b69052e-4e6eacc67d6mr9433301cf.10.1759862255905;
        Tue, 07 Oct 2025 11:37:35 -0700 (PDT)
Received: from fedora (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8777979927dsm1548337285a.57.2025.10.07.11.37.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Oct 2025 11:37:35 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: paul@paul-moore.com,
	omosnace@redhat.com,
	Richard Haines <richard_c_haines@btinternet.com>,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH v3] selinux-testsuite: Add btrfs support for filesystem tests
Date: Tue,  7 Oct 2025 14:35:53 -0400
Message-ID: <20251007183552.74330-2-stephen.smalley.work@gmail.com>
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
index f169464..7ea9031 100644
--- a/tests/filesystem/Filesystem.pm
+++ b/tests/filesystem/Filesystem.pm
@@ -123,6 +123,9 @@ sub attach_dev {
 sub make_fs {
     my ( $mk_type, $mk_dev, $mk_dir, $mk_opts ) = @_;
     my $mk_size = 16;
+    if ( $mk_type eq "btrfs" ) {
+        $mk_size = 300;
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

