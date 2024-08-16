Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A85E1BD02F
	for <selinux@vger.kernel.org>; Fri, 16 Aug 2024 14:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723819608; cv=none; b=Ffs9pqJIRtPrpfY58JlSqZig6vInmnDsOqZzSZszmKGy8Oewof5v0zCnw3uNhLTEkzgAVAKUSfA7+ZgUHmbS2baCpWqhPKBFkA3EZORiiM2AFSBm04CGpkHgSh/8ijHTNsE3trORzUg4MpBECSQwyosSfD2OpEv3dB3zE9YcQVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723819608; c=relaxed/simple;
	bh=iHw7rJebToWRhjJXUS3jb5CGxZxLNvAKtndhU34ysnU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=TLTKkm1x34nKRKpPEP7lYMWjE53jifvpuFN4yFmEGDo9Eid5C+cyxhuwp1E9GPM5Yz54zPoGROBC2cp9KzGj/eEcslMDTjSlM7SZNfTFfA56T4oKrPMudMrHlJKCzf9enmh5C5YraK1nMUjKtkn/ECGLwF++1Ep2J7q4mtFZlb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O5xqaToT; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O5xqaToT"
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-6bf7f4a133aso4018256d6.2
        for <selinux@vger.kernel.org>; Fri, 16 Aug 2024 07:46:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723819605; x=1724424405; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=uQRMHdGFzX7CUxnynLv8mJZKOB/DNfXITywu6x6giMk=;
        b=O5xqaToTAyVVY1VJqn/PD8smZLxCyHO1R2JT9+Rylf3hmpDAB8lH/TpmHJEn2M3lBT
         u8dM8gW9RrSZVj9dW0fbeQR+Ju+wONJOliHbHOIv3DeQCug3uXHixTxIoOlBO8Kuvs/d
         6YLVyPqQWt2z/oQDJc0DMla42V+PGooLB6eZ05GQBAymmxKPKb/ys4qh7Pb8pMDBb4Bo
         uAfoD9N39Vzt5ZcUdT+3KhUixAyWLOHbNG5k56z46RPzG7nu/Lb20DgBP408oD0jeq9s
         fiZMULgrqbNUJ/DrBwlDCf2dBQB1P+Lm9RuVMospL7bThGe+fjM8wGV5m33sKe2uMKGF
         /hUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723819605; x=1724424405;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uQRMHdGFzX7CUxnynLv8mJZKOB/DNfXITywu6x6giMk=;
        b=KP8VgNF4STBbeyqnEvlpuhr9vUJzTVJW+zNkueQh9W4qDzwqW5/thObA/y9d/0Nbfq
         A2jiB9eGSUZdxaDEC1apYn85Z8Lfh1iCaCQe/nVkZ5sL59tOREZa2oy9YMqkq/XDvgmf
         g9YPsMLNDYk3COdRCJmSs0FioqM1iVeQ8ULpcC5DRKjvC0+SeWoeJfOEHyjnHgZWjN4f
         TslX60PQY6VrwXpNLQzw3Lwj6n7Hemi1DFjqx5SuWXDpn1p5mErWLbiSJcNXtaPgNjBu
         bZYEz4PEbwWpqFpVkN/LB+HBCJg2xgeVSeJh2IemM9DypMpgHgxbZKkW26hJVmvoqhFj
         PHbA==
X-Gm-Message-State: AOJu0YwCrM7PwuNM/vW3Ogp9M7ggEFhyMz4A1xz4sgwKG6xLz2TtSI+o
	UUqbhBTrv0DbBFOrmgRiVPTyaowLTVsTZU8eA3QS5IovisolwMWGIRFcig==
X-Google-Smtp-Source: AGHT+IE66UdLXnA/EFjt9DwJG+wb6ZKJ0ulJuUgPejXnwRRQZze2SAAahbnVLnWJ5r22Czx24fhXyQ==
X-Received: by 2002:a05:6214:5987:b0:6bf:7968:1405 with SMTP id 6a1803df08f44-6bf7ce6660bmr38793266d6.46.1723819604646;
        Fri, 16 Aug 2024 07:46:44 -0700 (PDT)
Received: from a-gady2p56i3do.evoforge.org (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6bf6fe3a5a9sm18029446d6.72.2024.08.16.07.46.43
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 16 Aug 2024 07:46:44 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: paul@paul-moore.com,
	omosnace@redhat.com,
	aha310510@gmail.com,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH testsuite] tests/extended_socket_class: test SMC sockets
Date: Fri, 16 Aug 2024 10:45:20 -0400
Message-Id: <20240816144519.25600-1-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Enable SMC sockets and their dependencies in the defconfig and
exercise them as part of the extended socket class tests.
This only verifies that socket create permission is checked
against the correct class. The tests cover both usage of AF_SMC
and AF_INET using the recently introduced IPPROTO_SMC.

Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
 defconfig                                |  5 ++++
 policy/test_extended_socket_class.te     |  3 +++
 tests/extended_socket_class/sockcreate.c |  5 ++++
 tests/extended_socket_class/test         | 34 ++++++++++++++++++++++++
 4 files changed, 47 insertions(+)

diff --git a/defconfig b/defconfig
index 47938c1..b2d4a90 100644
--- a/defconfig
+++ b/defconfig
@@ -131,3 +131,8 @@ CONFIG_KEY_NOTIFICATIONS=y
 # This is not required for SELinux operation itself.
 CONFIG_TRACING=y
 CONFIG_DEBUG_FS=y
+
+# Test SMC sockets
+CONFIG_INFINIBAND=m
+CONFIG_SMC=m
+CONFIG_SMC_LO=y
diff --git a/policy/test_extended_socket_class.te b/policy/test_extended_socket_class.te
index c8840b4..6f0ebaa 100644
--- a/policy/test_extended_socket_class.te
+++ b/policy/test_extended_socket_class.te
@@ -48,6 +48,9 @@ extended_socket_class_test(bluetooth_socket, socket)
 # Test use of alg_socket for Alg (Crypto API) sockets instead of socket.
 extended_socket_class_test(alg_socket, socket)
 
+# Test use of smc_socket for SMC sockets instead of socket.
+extended_socket_class_test(smc_socket, socket)
+
 #
 # Common rules for all extended_socket_class test domains.
 #
diff --git a/tests/extended_socket_class/sockcreate.c b/tests/extended_socket_class/sockcreate.c
index ee1d8f3..f72f2c9 100644
--- a/tests/extended_socket_class/sockcreate.c
+++ b/tests/extended_socket_class/sockcreate.c
@@ -47,6 +47,7 @@ static struct nameval domains[] = {
 #define AF_QIPCRTR 42
 #endif
 	{ "qipcrtr", AF_QIPCRTR },
+	{ "smc", AF_SMC },
 	{ NULL, 0 }
 };
 
@@ -62,6 +63,10 @@ static struct nameval protocols[] = {
 	{ "icmp", IPPROTO_ICMP },
 	{ "icmpv6", IPPROTO_ICMPV6 },
 	{ "sctp", IPPROTO_SCTP },
+#ifndef IPPROTO_SMC
+#define IPPROTO_SMC 256
+#endif
+	{ "smc", IPPROTO_SMC },
 #ifndef CAN_RAW
 #define CAN_RAW 1
 #endif
diff --git a/tests/extended_socket_class/test b/tests/extended_socket_class/test
index 86c706b..ce02f00 100755
--- a/tests/extended_socket_class/test
+++ b/tests/extended_socket_class/test
@@ -6,6 +6,7 @@ BEGIN {
     $test_count     = 6;
     $test_bluetooth = 0;
     $test_sctp      = 0;
+    $test_smc       = 0;
 
     # check if SCTP is enabled
     if ( system("modprobe sctp 2>/dev/null && checksctp 2>/dev/null") eq 0 ) {
@@ -19,6 +20,12 @@ BEGIN {
         $test_bluetooth = 1;
     }
 
+    # check if SMC is supported
+    if ( system("modprobe smc 2>/dev/null") eq 0 ) {
+        $test_count += 4;
+        $test_smc = 1;
+    }
+
     plan tests => $test_count;
 }
 
@@ -131,3 +138,30 @@ $result = system(
 "runcon -t test_no_alg_socket_t -- $basedir/sockcreate alg seqpacket default 2>&1"
 );
 ok($result);
+
+if ($test_smc) {
+
+    # Verify that test_smc_socket_t can create a SMC socket (AF_SMC).
+    $result = system(
+"runcon -t test_smc_socket_t -- $basedir/sockcreate smc stream default 2>&1"
+    );
+    ok( $result, 0 );
+
+    # Verify that test_smc_socket_t can create a SMC socket (IPPROTO_SMC).
+    $result = system(
+"runcon -t test_smc_socket_t -- $basedir/sockcreate inet stream smc 2>&1"
+    );
+    ok( $result, 0 );
+
+    # Verify that test_no_smc_socket_t cannot create a SMC socket (AF_SMC).
+    $result = system(
+"runcon -t test_no_smc_socket_t -- $basedir/sockcreate smc stream default 2>&1"
+    );
+    ok($result);
+
+    # Verify that test_no_smc_socket_t cannot create a SMC socket (IPPROTO_SMC).
+    $result = system(
+"runcon -t test_no_smc_socket_t -- $basedir/sockcreate inet stream smc 2>&1"
+    );
+    ok($result);
+}
-- 
2.40.1

