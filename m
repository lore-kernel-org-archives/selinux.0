Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795188703;
	b=fTSN/pIeHiuPb5Ge28w7aoHtGkk4+9+3aSlQxxaLNZaA0PFCmAMLaXdPae5HkjmHinQK
	 hFc5YT/9PJ2YzJcSs2+onXnbIYrHvfhoFQetNBczROuhvXcdBWmC2dK4390PAaDord9If
	 NruxrULf4xtALQwAokqo6X1yfhrE+JJl31nadDu1FjmE6PMMR1Q8+ekWF4lcheZS3/76m
	 4IqJIhUtV6gdKdTbhyxEpF2yj0hYSLcLgAnMoRbB/1DA9bg7FU6cftnNt3ZwUfbFbHUsJ
	 jfMjvYAO90Dl0sYBnpDUiG356iVmr3hSPZ7cOYNDkdTtV//hHzGXF0U0gh/AAa8PACQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795188703;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=Cb5MGeynZH+NqRa1rFpaJ9Ug0YjsZDqjjqFmwUbvFo8=;
	b=EgjieTkVxut+HKjKkzoo0ho4QCNh05Xfc0z3RvfUj04qReKERM37ZDgCGXPl6kizGTRb
	 fsJZvMsg2LwI3c2cAq91x7UENceMIaxwQ5U3sBP4EM5o8O5cxL3uju8OepRk2fL7eCHQR
	 5Pem239+tRGtssxkx/LCXP+DHciEIpiJHt4L8y2S3JihoUPD87TzSapMsyI9KWrt/ArNA
	 0M3APuONtB35/XKylqL6aPc0TGXmQi8DAapzZnsLrII/DwxQEGEJmMcMIx1YGsd4mRMhO
	 dOc8RhTzk477vrPjDTY+8vQPnfQXFq2ssDjTRm3MdODIwQg8uwkR1MY4TRzQua1TvQA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="Sl/eotDi";
	arc=none smtp.remote-ip=209.85.222.173
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AA7160A2606
	for <selinux@vger.kernel.org>; Fri, 20 Nov 2026 15:31:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7AA7160A2606
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Sl/eotDi
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-9495f083657so131439985a.0
        for <selinux@vger.kernel.org>; Fri, 20 Nov 2026 07:31:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795188702; x=1795793502; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Cb5MGeynZH+NqRa1rFpaJ9Ug0YjsZDqjjqFmwUbvFo8=;
        b=Sl/eotDiZ9/oZxakSDDsiUuovVEEWb3kvTCBAoKgBPDpo+qb3u92+nI2yaj8T6Sc6C
         HTRpnDBXbzBCQczFCyYrsDUHzfT2tSlAB0d35S3q1HYLMZxO78NQtizIkJCiQe3G+4aA
         YW5lPDRLFXcb8UzGJ3cHyIWsX8ER1SYJrxJ0Lvikkr+aJda8hPJ0fbNKDjvdRbhhKz9/
         2nhC91NgG+zStQ49QlRlA+ErOY7alC/rM0bYV1SZJcs+Z/3z+dB7+MDi8sYG2d/xt35o
         vRboNV7wC/jmpmpm5TtovTMfeyF4jD5FKffiZFsQ48j9hJXETDzJSYjY4dbSfFMqdvkq
         IdPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795188702; x=1795793502;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Cb5MGeynZH+NqRa1rFpaJ9Ug0YjsZDqjjqFmwUbvFo8=;
        b=RFqrEEQQEbaknjEJCbEgeYuxmx77gYln3Jqp2xtypIolcIaCnKi9XxFwfmMeKxVt0k
         IhTHURRIY0yBVTp1p+pCh1LcHn6mNnJTanooc55Or3pg8KNXWhRJd0ymK7NvTmYtLoQf
         HONdacfuNm2MHkLUK4RSl+8wLe7BiBTALzi1AIwsP5x4h/Ifq/IMtecnYqHhdrB3Ydz2
         k4Iikr8bOz9eZ0jrXDZQ9a3X920uHSIKS5u1N23/6BZjG75cRdLqjFxZyzpogVtxujVK
         0FCVTujvbftrmQ95Ez6M82MZyYyyexx2PxPis1nLFGu4Y3axLrFwQIJTJSF8Jcazg3/8
         a57A==
X-Gm-Message-State: APuU4Z+7meBDhJOWQjFZuKcBtlmBbrwxVDTx8Z/nPwfG+pcKYaDPlSRM
	DW4E3SA3S5bL8mnnzSfj90b4eUTdp+vYYnKA1M1FCHbYqXru0JZsDrN5T7W7PRoe
X-Gm-Gg: AYBFou3FLM3PwkyjLKWFVefsB+mGRrt/oZOkhQ4dlIiJcUu/vTANMYB9jrlPX6Wc2TS
	DAIj7/AtkR22aW8Wq8JT2nfNgGjLQHozkGEPdS/Fis1MLaooqds8oW44ZSLcCTmXzXTNdcdPS2F
	DzL/uZ2Sn2ysm2lsOr4fy0cIBnTny4Io/mL0SX/HK4XN/ubpcQD2QzOAHfkTDsG1Y5MOB2U1xQE
	QPrsC6D7Br7TgFPNvlegRc/dcT0Qn93rxTOYGvbhB/TvrNyCc5kEUmXlXMqA3Wx+m2EsjM0M8dT
	PH+4numB8WJ/KybNjQas+H2i3VGBTbSj6Rcn16VFERh5XVoQUPnfd5a93gVw63n+kTIGS/k26kz
	6SUuxD6yg5Fb8Gyz18e7RrJyaZo5Yye4CsW8ojKJk6xODeVDfcGmOZYG0pb7VOG1Xde6+6PPV93
	iEEnrzzTvs41OPICGTzRhc5z2WxZIizjrxfXWZnlnM8/SB5cOp2luKUTT0FghL61Gi3N9DIjBUh
	Lo8pPR/gHzRwFXXCzMUDWL5ZAlKcb7EztWo4kx+JlaCILHHbfMu4Ef4D93WzHVFtdG8+lSEaJVx
	cRW09oszG8whh/RcfS3ZEFDqaP7RFVJzKEd7i+QR4FG8hL+OT0yjd54o4/pnr44MDhLYnOFhNU/
	mDMRs+DVURKc0KgKO7B0zdln8k68yqkkZ+S9N5dtuHWLMB+XP6BvPa09+zlOyZMjbqSVrGiJsdF
	PtX9IPme7sHtzqXrFOdsnuLZjIDARAtGUl1evJLiR+HkvC+A==
X-Received: by 2002:a05:620a:8804:b0:947:b201:fafc with SMTP id af79cd13be357-949baa043b6mr491462585a.39.1795188702277;
        Fri, 20 Nov 2026 07:31:42 -0800 (PST)
Received: from fedora (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-949bb0319fcsm213578385a.4.2026.11.20.07.31.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 07:31:41 -0800 (PST)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: paul@paul-moore.com,
	omosnacek@gmail.com,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH] tests/mmap: test MAP_SHARED_VALIDATE flag
Date: Fri, 20 Nov 2026 10:30:36 -0500
Message-ID: <20261120153036.37093-2-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.56.1
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Post: <mailto:selinux@vger.kernel.org>
List-Help: <mailto:selinux+help@vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
List-Owner: <mailto:selinux+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For each MAP_SHARED test that supports MAP_SHARED_VALIDATE, test
MAP_SHARED_VALIDATE too. This will fail on kernels that lack commit
beb0ae6bcd75 ("selinux: check MAP_SHARED_VALIDATE mappings as
shared").

Link: https://github.com/SELinuxProject/selinux-kernel/issues/78
Link: https://lore.kernel.org/selinux/20261106182913.15233-1-stephen.smalley.work@gmail.com/
Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
This won't pass on the testfarm yet but posting it for review and
eventual merging once the fix reaches stable kernels.

 tests/mmap/mmap_file_shared.c             | 13 +++--
 tests/mmap/mmap_hugetlb_anon_shared.c     | 27 ++++++++--
 tests/mmap/mprotect_file_shared.c         | 31 ++++++++---
 tests/mmap/mprotect_hugetlb_anon_shared.c | 27 ++++++++--
 tests/mmap/test                           | 64 +++++++++++++++++++++--
 5 files changed, 140 insertions(+), 22 deletions(-)

diff --git a/tests/mmap/mmap_file_shared.c b/tests/mmap/mmap_file_shared.c
index ad349a4..612d1d8 100644
--- a/tests/mmap/mmap_file_shared.c
+++ b/tests/mmap/mmap_file_shared.c
@@ -8,16 +8,17 @@
 
 void usage(const char *progname)
 {
-	fprintf(stderr, "usage: %s [-r] file\n", progname);
+	fprintf(stderr, "usage: %s [-rs] file\n", progname);
 	exit(1);
 }
 
 int main(int argc, char **argv)
 {
 	char *ptr;
-	int fd, opt, prot = PROT_READ | PROT_WRITE | PROT_EXEC;
+	int fd, opt, shared = MAP_SHARED, prot = PROT_READ | PROT_WRITE | PROT_EXEC;
+	const size_t length = 4096;
 
-	while ((opt = getopt(argc, argv, "r")) != -1) {
+	while ((opt = getopt(argc, argv, "rs")) != -1) {
 		switch (opt) {
 		case 'r':
 			if (personality(READ_IMPLIES_EXEC) == -1) {
@@ -26,6 +27,9 @@ int main(int argc, char **argv)
 			}
 			prot &= ~PROT_EXEC;
 			break;
+		case 's':
+			shared = MAP_SHARED_VALIDATE;
+			break;
 		default:
 			usage(argv[0]);
 			break;
@@ -41,12 +45,13 @@ int main(int argc, char **argv)
 		exit(1);
 	}
 
-	ptr = mmap(NULL, 4096, prot, MAP_SHARED, fd, 0);
+	ptr = mmap(NULL, length, prot, shared, fd, 0);
 	if (ptr == MAP_FAILED) {
 		perror("mmap");
 		close(fd);
 		exit(1);
 	}
+
 	close(fd);
 	exit(0);
 }
diff --git a/tests/mmap/mmap_hugetlb_anon_shared.c b/tests/mmap/mmap_hugetlb_anon_shared.c
index c1a8722..d0d3159 100644
--- a/tests/mmap/mmap_hugetlb_anon_shared.c
+++ b/tests/mmap/mmap_hugetlb_anon_shared.c
@@ -9,15 +9,36 @@
 # define MAP_HUGETLB 0x40000
 #endif
 
-int main(void)
+void usage(const char *progname)
+{
+	fprintf(stderr, "usage: %s [-s]\n", progname);
+	exit(1);
+}
+
+int main(int argc, char **argv)
 {
 	char *ptr;
+	int opt, shared = MAP_SHARED;
 	long length = getdefaulthugesize();
 
+	while ((opt = getopt(argc, argv, "s")) != -1) {
+		switch (opt) {
+		case 's':
+			shared = MAP_SHARED_VALIDATE;
+			break;
+		default:
+			usage(argv[0]);
+			break;
+		}
+	}
+
+	if ((argc - optind) != 0)
+		usage(argv[0]);
+
 	ptr = mmap(NULL, length, PROT_READ | PROT_WRITE | PROT_EXEC,
-		   MAP_SHARED | MAP_ANONYMOUS | MAP_HUGETLB, -1, 0);
+		   shared | MAP_ANONYMOUS | MAP_HUGETLB, -1, 0);
 	if (ptr == MAP_FAILED) {
-		perror("mmap");
+		perror("mmap MAP_SHARED");
 		exit(1);
 	}
 	exit(0);
diff --git a/tests/mmap/mprotect_file_shared.c b/tests/mmap/mprotect_file_shared.c
index d1e5465..3be05a1 100644
--- a/tests/mmap/mprotect_file_shared.c
+++ b/tests/mmap/mprotect_file_shared.c
@@ -5,35 +5,52 @@
 #include <fcntl.h>
 #include <sys/mman.h>
 
+void usage(const char *progname)
+{
+	fprintf(stderr, "usage: %s [-s]\n", progname);
+	exit(1);
+}
+
 int main(int argc, char **argv)
 {
 	char *ptr;
-	int rc;
+	int rc, opt, shared = MAP_SHARED;
 	int fd;
+	const size_t length = 4096;
 
-	if (argc != 2) {
-		fprintf(stderr, "usage: %s file\n", argv[0]);
-		exit(1);
+	while ((opt = getopt(argc, argv, "s")) != -1) {
+		switch (opt) {
+		case 's':
+			shared = MAP_SHARED_VALIDATE;
+			break;
+		default:
+			usage(argv[0]);
+			break;
+		}
 	}
 
-	fd = open(argv[1], O_RDWR);
+	if ((argc - optind) != 1)
+		usage(argv[0]);
+
+	fd = open(argv[optind], O_RDWR);
 	if (fd < 0) {
 		perror(argv[1]);
 		exit(1);
 	}
 
-	ptr = mmap(NULL, 4096, PROT_READ | PROT_WRITE, MAP_SHARED, fd,
+	ptr = mmap(NULL, length, PROT_READ | PROT_WRITE, shared, fd,
 		   0);
 	if (ptr == MAP_FAILED) {
 		perror("mmap");
 		exit(1);
 	}
 
-	rc = mprotect(ptr, 4096, PROT_READ | PROT_EXEC);
+	rc = mprotect(ptr, length, PROT_READ | PROT_EXEC);
 	if (rc < 0) {
 		perror("mprotect");
 		exit(1);
 	}
+
 	exit(0);
 }
 
diff --git a/tests/mmap/mprotect_hugetlb_anon_shared.c b/tests/mmap/mprotect_hugetlb_anon_shared.c
index 52707ef..797e17e 100644
--- a/tests/mmap/mprotect_hugetlb_anon_shared.c
+++ b/tests/mmap/mprotect_hugetlb_anon_shared.c
@@ -9,14 +9,34 @@
 # define MAP_HUGETLB 0x40000
 #endif
 
-int main(void)
+void usage(const char *progname)
+{
+	fprintf(stderr, "usage: %s [-s]\n", progname);
+	exit(1);
+}
+
+int main(int argc, char **argv)
 {
 	char *ptr;
-	int rc;
+	int rc, opt, shared = MAP_SHARED;
 	long length = getdefaulthugesize();
 
+	while ((opt = getopt(argc, argv, "s")) != -1) {
+		switch (opt) {
+		case 's':
+			shared = MAP_SHARED_VALIDATE;
+			break;
+		default:
+			usage(argv[0]);
+			break;
+		}
+	}
+
+	if ((argc - optind) != 0)
+		usage(argv[0]);
+
 	ptr = mmap(NULL, length, PROT_READ | PROT_WRITE,
-		   MAP_SHARED | MAP_ANONYMOUS | MAP_HUGETLB, -1,
+		   shared | MAP_ANONYMOUS | MAP_HUGETLB, -1,
 		   0);
 	if (ptr == MAP_FAILED) {
 		perror("mmap");
@@ -28,5 +48,6 @@ int main(void)
 		perror("mprotect");
 		exit(1);
 	}
+
 	exit(0);
 }
diff --git a/tests/mmap/test b/tests/mmap/test
index b7cd56a..79b0b0b 100755
--- a/tests/mmap/test
+++ b/tests/mmap/test
@@ -3,7 +3,7 @@
 use Test;
 
 BEGIN {
-    $test_count            = 30;
+    $test_count            = 36;
     $test_hugepages        = 0;
     $test_exec_checking    = 0;
     $test_map_checking     = 0;
@@ -12,23 +12,23 @@ BEGIN {
     system("echo 1 > /proc/sys/vm/nr_hugepages 2> /dev/null");
     if ( system("grep -q 1 /proc/sys/vm/nr_hugepages 2> /dev/null") == 0 ) {
         $test_hugepages = 1;
-        $test_count += 8;
+        $test_count += 12;
     }
 
     if ( system("grep -q 0 /sys/fs/selinux/checkreqprot 2> /dev/null") == 0 ) {
         $test_exec_checking = 1;
-        $test_count += 4;
+        $test_count += 6;
     }
 
     if ( system("grep -q '/dev .*noexec' /proc/self/mounts 2> /dev/null") != 0 )
     {
         $test_devzero_checking = 1;
-        $test_count += 4;
+        $test_count += 8;
     }
 
     if ( -e '/sys/fs/selinux/class/file/perms/map' ) {
         $test_map_checking = 1;
-        $test_count += 1;
+        $test_count += 2;
     }
 
     plan tests => $test_count;
@@ -79,6 +79,13 @@ if ($test_devzero_checking) {
     $result = system
 "runcon -t test_no_mmap_dev_zero_t $basedir/mmap_file_shared /dev/zero 2>&1";
     ok($result);
+    $result =
+      system
+      "runcon -t test_mmap_dev_zero_t $basedir/mmap_file_shared -s /dev/zero";
+    ok( $result, 0 );
+    $result = system
+"runcon -t test_no_mmap_dev_zero_t $basedir/mmap_file_shared -s /dev/zero 2>&1";
+    ok($result);
 }
 
 # Test success and failure for mprotect w/ anonymous shared memory.
@@ -91,6 +98,14 @@ $result = system
   "runcon -t test_no_mprotect_anon_shared_t $basedir/mprotect_anon_shared 2>&1";
 ok($result);
 
+$result =
+  system
+  "runcon -t test_mprotect_anon_shared_t $basedir/mprotect_anon_shared -s";
+ok( $result, 0 );
+$result = system
+"runcon -t test_no_mprotect_anon_shared_t $basedir/mprotect_anon_shared -s 2>&1";
+ok($result);
+
 if ($test_devzero_checking) {
 
     # Test success and failure for mprotect /dev/zero.
@@ -100,6 +115,12 @@ if ($test_devzero_checking) {
     $result = system
 "runcon -t test_no_mprotect_dev_zero_t $basedir/mprotect_file_shared /dev/zero 2>&1";
     ok($result);
+    $result = system
+"runcon -t test_mprotect_dev_zero_t $basedir/mprotect_file_shared -s /dev/zero";
+    ok( $result, 0 );
+    $result = system
+"runcon -t test_no_mprotect_dev_zero_t $basedir/mprotect_file_shared -s /dev/zero 2>&1";
+    ok($result);
 }
 
 # Test success and failure for execheap, independent of execmem.
@@ -139,6 +160,12 @@ ok( $result, 0 );
 $result = system
   "runcon -t test_file_rw_t $basedir/mmap_file_shared $basedir/temp_file 2>&1";
 ok($result);
+$result = system
+  "runcon -t test_file_rwx_t $basedir/mmap_file_shared -s $basedir/temp_file";
+ok( $result, 0 );
+$result = system
+"runcon -t test_file_rw_t $basedir/mmap_file_shared -s $basedir/temp_file 2>&1";
+ok($result);
 
 if ($test_exec_checking) {
 
@@ -149,12 +176,21 @@ if ($test_exec_checking) {
     $result = system
 "runcon -t test_file_rw_t -- $basedir/mmap_file_shared -r $basedir/temp_file 2>&1";
     ok($result);
+    $result = system
+"runcon -t test_file_rwx_t -- $basedir/mmap_file_shared -r -s $basedir/temp_file";
+    ok( $result, 0 );
+    $result = system
+"runcon -t test_file_rw_t -- $basedir/mmap_file_shared -r -s $basedir/temp_file 2>&1";
+    ok($result);
 }
 
 if ($test_map_checking) {
     $result = system
 "runcon -t test_no_map_t -- $basedir/mmap_file_shared $basedir/temp_file 2>&1";
     ok($result);
+    $result = system
+"runcon -t test_no_map_t -- $basedir/mmap_file_shared -s $basedir/temp_file 2>&1";
+    ok($result);
 }
 
 # Test success and failure for file execute on mprotect w/ file shared mapping.
@@ -164,6 +200,12 @@ ok( $result, 0 );
 $result = system
 "runcon -t test_file_rw_t $basedir/mprotect_file_shared $basedir/temp_file 2>&1";
 ok($result);
+$result = system
+"runcon -t test_file_rwx_t $basedir/mprotect_file_shared -s $basedir/temp_file";
+ok( $result, 0 );
+$result = system
+"runcon -t test_file_rw_t $basedir/mprotect_file_shared -s $basedir/temp_file 2>&1";
+ok($result);
 
 # Test success and failure for execmem on mmap w/ file private mapping.
 $result = system
@@ -206,6 +248,12 @@ if ($test_hugepages) {
     $result = system
       "runcon -t test_no_execmem_t $basedir/mmap_hugetlb_anon_shared 2>&1";
     ok($result);
+    $result =
+      system "runcon -t test_execmem_t $basedir/mmap_hugetlb_anon_shared -s";
+    ok( $result, 0 );
+    $result = system
+      "runcon -t test_no_execmem_t $basedir/mmap_hugetlb_anon_shared -s 2>&1";
+    ok($result);
 
 # Test success and failure for execmem on mprotect w/ hugetlb anonymous shared memory.
     $result = system
@@ -214,6 +262,12 @@ if ($test_hugepages) {
     $result = system
 "runcon -t test_no_mprotect_anon_shared_t $basedir/mprotect_hugetlb_anon_shared 2>&1";
     ok($result);
+    $result = system
+"runcon -t test_mprotect_anon_shared_t $basedir/mprotect_hugetlb_anon_shared -s";
+    ok( $result, 0 );
+    $result = system
+"runcon -t test_no_mprotect_anon_shared_t $basedir/mprotect_hugetlb_anon_shared -s 2>&1";
+    ok($result);
 
 # Test success and failure for execmem on mmap w/ hugetlb anonymous private memory.
     $result =
-- 
2.56.1

