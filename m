Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05F652C9D
	for <selinux@vger.kernel.org>; Thu,  9 Oct 2025 12:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760013207; cv=none; b=uxZb0oflYqjQWFp2OLHSQHtMtOw2KdtAypEsx/pCAR1alcbBByviK6kLKa90oiHEpza5MkQ1cu0p6/GTrubC/kzhtiAk8TC2ccusT8uC4MsEhtf74KNUj1NQUPIJvaVDdKits6mU36RpZdjzmEDbbhcXlFfslB6tNOskVClghaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760013207; c=relaxed/simple;
	bh=btshGNXddEjj/omJpP2/OgBceDiIrKknMTtR0M3Nvwo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=masf9g7QvetvtImfoOmtoMHH6+Qlmy+EIzQkZCEdERFBr93Ce0FjCJ39ZqgdZPStawnKl9oedAN8oqci3pWtJiizT5Chpu2+KCqR88RQZiEOWMyXNWf9M2v5lTG9ilWdXWUVIfe0IW6H5pBc8OHgIkc78ZcRmt7D1Te3LPiP0h4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jPtYVi5F; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jPtYVi5F"
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-4ddabf2ada5so12681691cf.1
        for <selinux@vger.kernel.org>; Thu, 09 Oct 2025 05:33:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760013204; x=1760618004; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9HAn0gJni/7NPbUg769x4R3RJqeiM8tsJAeYkY2htGM=;
        b=jPtYVi5F/L7SFKSrSyTt+wLNEN8HCl2P6xvh3HmBEWQj7l8ybEhdkuOB9YZQu4m3Wg
         qqChWFvxyUpQEI3+uptggLIWiQdDE0k2+RQs3PB5oZQ1soFqPN4cIfI2GTd8WEaClzeW
         KOF92oj8yBEwD31ueDc6JA9YPrF1DYne3vjJVyckMCrKs3DZtE9c84wHV/R0nH2sbTr+
         HDif5Q7W13SaEUOavnhvu0TL6XiiFhVwTThZ1927yqSW7Mf7vEHlSIOAxLNsVqMMQp1L
         iDduoEMCIZhduOaO+yDe8SIvIV/lxy0TQy8ZXncSCUFaQb1Alhl3A5qQPO1odilPTtD9
         3Arw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760013204; x=1760618004;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9HAn0gJni/7NPbUg769x4R3RJqeiM8tsJAeYkY2htGM=;
        b=TKaAkxr0ZDx9F1fhAAgXC4SQJFpartgSCsoAKXJBqzAcyxLoXK6A8/LNr5bpx1KM2K
         GndME3kU8UHiRVHk7XPC4RiwIS8zWY9B/sn02dJn+S1xxVXBSPVUhGRmcw+emvIayd/X
         5BOT01DMjUCbEUy4UZqTC5XQyQCUHNfK3B8zdvArdWzQnEJHpl3tYBDYDAroMMVwxZgA
         0wpI79H1HBcUsXV4Zg61dnd27AOxz+UvqbRrhkiQz64O6qyAfmGa/teavtXYZ4raZd1L
         rVjMl8qqMg7f/px07HgU3Lobg4eC2K7AZNfY4eE2gYFYaz36zAfFumyeqLXL8R1iFcNQ
         ecDg==
X-Gm-Message-State: AOJu0YwwjC2MwMJjEQFOuvW197NWfIyuoqFE8XcHrpbuJYqDyzntRh6V
	tx1uxhRQz+qOqTDuy6ykjUTiccg2Y/TQ02HnrLqvXD9mGKrHC16vQvtc6wScXA==
X-Gm-Gg: ASbGncvjukUR0DFXGg5Yqr7rKR35XTjmkk26brszAeIgfT8iWBq2Y6zwTmWvCRhfkMS
	sRF9WAK5iJfz67EdXp5VjH+k8366q9MLl9VOn09mKDXS1/ctlA4wh5HZVzXB4ildH1ckQjn2P8s
	379pYSB7Tmm7rxJzAe5BfWXyboORRDwN0r19I8Bixq5PqsKNxjBDpraOGxvOxTz9LcjFyxtL7P8
	F/1nDvSES98c70dmYNx6uJ8Cp3dLyASYJgESmsR/dpOtfuA2xSTlrkPfWkLYOTQL4q6J8VeLjjl
	nftNR0/Gp5Shdw0CXKyI6Xf9fLFgDdZytZTOk41ke4bhvSJVzVrXsfkeTA0QdOGbOMJJEA36gNd
	iFpcpb7eFApRkl087iswo7lXHwvxQSKteAVyIEZODx/nHIoouT5BGpjuqFSWPsSJst5RU/56MY3
	u2IncHMzNbS0w2XPD1j8EBqzjWWRHU9JbPINT9XuwqgIYqwtg9GuyFOPav1Q==
X-Google-Smtp-Source: AGHT+IGoTLJYOk6p3tG7ixIj/VLCOUkRhbXv5rUAitn7C6bHDYBfN00u2Znhqd+rzTEtXQGDnKH+9w==
X-Received: by 2002:ac8:5d03:0:b0:4d4:4a2e:531a with SMTP id d75a77b69052e-4e6ead20c6bmr95862791cf.30.1760013204500;
        Thu, 09 Oct 2025 05:33:24 -0700 (PDT)
Received: from fedora (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-878bd783b33sm179610946d6.38.2025.10.09.05.33.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Oct 2025 05:33:24 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: paul@paul-moore.com,
	omosnace@redhat.com,
	Richard Haines <richard_c_haines@btinternet.com>,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH v5] selinux-testsuite: Add btrfs support for filesystem tests
Date: Thu,  9 Oct 2025 08:32:04 -0400
Message-ID: <20251009123203.104314-2-stephen.smalley.work@gmail.com>
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
 README.md                      | 3 +++
 defconfig                      | 5 +++++
 tests/Makefile                 | 2 +-
 tests/filesystem/Filesystem.pm | 4 ++++
 tests/filesystem/btrfs         | 1 +
 tests/filesystem/test          | 6 ++++++
 tests/fs_filesystem/btrfs      | 1 +
 tests/fs_filesystem/test       | 6 ++++++
 tmt/tests.fmf                  | 1 +
 9 files changed, 28 insertions(+), 1 deletion(-)
 create mode 120000 tests/filesystem/btrfs
 create mode 120000 tests/fs_filesystem/btrfs

diff --git a/README.md b/README.md
index f067eeb..1a1b621 100644
--- a/README.md
+++ b/README.md
@@ -61,6 +61,7 @@ similar dependencies):
 * e2fsprogs _(used by the ext4 filesystem tests)_
 * jfsutils _(used by the jfs filesystem tests)_
 * dosfstools _(used by the vfat filesystem tests)_
+* btrfs-progs _(used by the btrfs filesystem tests)_
 * nftables _(used by inet_socket and sctp tests if ver >= 9.3 for secmark testing )_
 * rdma-core-devel _(to build the `ibpkey` test program)_
 
@@ -89,6 +90,7 @@ following command (NOTE: On Fedora 32 and below you need to remove
 		e2fsprogs \
 		jfsutils \
 		dosfstools \
+		btrfs-progs \
 		rdma-core-devel \
 		kernel-devel-$(uname -r) \
 		kernel-modules-$(uname -r)
@@ -136,6 +138,7 @@ command:
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
index f169464..ff9748e 100644
--- a/tests/filesystem/Filesystem.pm
+++ b/tests/filesystem/Filesystem.pm
@@ -126,6 +126,10 @@ sub make_fs {
     if ( $mk_type eq "xfs" ) {
         $mk_size = 300;
     }
+    elsif ( $mk_type eq "btrfs" ) {
+        $mk_size = 128;
+    }
+
     print "Create $mk_dir/fstest with dd\n";
     $result =
       system(
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
diff --git a/tmt/tests.fmf b/tmt/tests.fmf
index 9fc892b..828e078 100644
--- a/tmt/tests.fmf
+++ b/tmt/tests.fmf
@@ -118,6 +118,7 @@
     - e2fsprogs
     - jfsutils
     - dosfstools
+    - btrfs-progs
     - rdma-core-devel
     - kexec-tools
   /main:
-- 
2.51.0

