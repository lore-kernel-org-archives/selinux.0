Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0AC01B5826
	for <selinux@vger.kernel.org>; Thu, 29 Aug 2024 13:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724938037; cv=none; b=izsHlgbW0zmk1JWUf0FvvymoAHAmJQpRc2EFw9e6MWzPCUIXnMAx2cqpRwL3gzrow7S6nAPHW6tSNO+is8AY4dwrxaD3jJ4rdSXaioUKu84l5rokiBWg8g7B/MmJlFVMPISyxfxpsGKzXev4vsirQhkT2CA8D6ws4rxeybr8mbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724938037; c=relaxed/simple;
	bh=TSkOnGAE4nColb6MjNNvBdzHLhutfCdgSDs/AmlBYVY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=pPTD1wU51VTdruhc/yD+8c5dMFUrViVHzWh1V/tSWo6Jy6wQ9wFHBKkUV130OlS06VGG/21E449iD7rRoeBOoqiMsMtedv0OayInOs6J9XzFAzicbPCNmFwS7XkTdLM8FvS4lqOGJ9Igld4c9SR+iXuoRNIk62XILUDPO/zigPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BydkvC0y; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BydkvC0y"
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-7a66b813745so34639085a.3
        for <selinux@vger.kernel.org>; Thu, 29 Aug 2024 06:27:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724938034; x=1725542834; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=C/W+BzuytA48OZpyefqQ7s971grdKaOzVAVEd4sTRNI=;
        b=BydkvC0yISJLtCrOlSnLikxF5eqLfxqfpXc2PlJICvCXFpUbt24DBRHMZPbKb/QuFU
         sTtAyGqvloa1ZfkW41dfc4RR5Fy1xXi7y5ZdcX0THomcuB3iggQflEm/5aKRG5/HI/P/
         oi7Y5Sw68e1EoHRc1fGJ7hEzt58VvVB+u//pxaoLnORaUZZlFm3CFD+pp1XTFPfhydJq
         61sDUOXqPBgcg623RHa8pKVedJD4XtONhEw/KWRIgDDkZN7hDQ9zT5rcnakNyn9FZi5t
         zpZGYpsrrCBPDbjKaRsSUk3lYH/kv+3vnL03BbNoNGg+XYjrbYCYaKAsyJMBFgxzREDH
         uNNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724938034; x=1725542834;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=C/W+BzuytA48OZpyefqQ7s971grdKaOzVAVEd4sTRNI=;
        b=oP86hOnkfzzaq2rBnlCyqR5hopJt7NSPKo22UixKy2XZhsoJllG8HREfF9VQsDagxp
         ZmFXvY5L+0cEoAU2wRB+24I4j8mAye2pvBgzbVtxO6D2Q6xIpROqVQkwX1Vgbh+CxOYl
         c4F+L5QDXMcV0/ijCkQ4aaFah0a5cMttAyza7iw9UYW+E/zsH+oaMb3cgzNAroKS4G88
         QWQ6CGVkvdVKnIQQqNMDAScEQyztu7DV6vQb+iFOoamVxPMVVykwV7DKrzE+wbwTyBfV
         4SvY9KLrEW/pIy3LInozWJs7U693s7Q8fdI0tPGIrgE6NG/EsNq26V2OZ2V3wARNaVzA
         FyEQ==
X-Gm-Message-State: AOJu0Yz5N6wYlupVsu/RBbq2X/1zZA4DKqMctYPO0HrTQchhjbsk3Ucg
	kXb/7u6XXIh/IiHjzNNijpv2XiLBoI1/g5cZoE5KmuWq7yPTUChuIJOjWw==
X-Google-Smtp-Source: AGHT+IGKPHXGHiwA2FROmJg2TxjB68EPdbYx+QRGjpo18lqF5eJTv66RggWIPUNfEgZJP2o09hFi4g==
X-Received: by 2002:a05:620a:3196:b0:79d:9102:554a with SMTP id af79cd13be357-7a804187593mr287405585a.14.1724938034303;
        Thu, 29 Aug 2024 06:27:14 -0700 (PDT)
Received: from a-gady2p56i3do.evoforge.org (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a806c4cd89sm50061285a.57.2024.08.29.06.27.13
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 29 Aug 2024 06:27:13 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: paul@paul-moore.com,
	omosnace@redhat.com,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH testsuite v2] tests/extended_socket_class: test SMC sockets
Date: Thu, 29 Aug 2024 09:26:18 -0400
Message-Id: <20240829132617.1610-1-stephen.smalley.work@gmail.com>
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
against the correct class. The tests only cover AF_SMC,
not IPPROTO_SMC.

Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
v2 drops the tests for IPPROTO_SMC since apparently that patch isn't
going anywhere.

 defconfig                                |  5 +++++
 policy/test_extended_socket_class.te     |  3 +++
 tests/extended_socket_class/sockcreate.c |  1 +
 tests/extended_socket_class/test         | 22 ++++++++++++++++++++++
 4 files changed, 31 insertions(+)

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
index ee1d8f3..e3bbf0b 100644
--- a/tests/extended_socket_class/sockcreate.c
+++ b/tests/extended_socket_class/sockcreate.c
@@ -47,6 +47,7 @@ static struct nameval domains[] = {
 #define AF_QIPCRTR 42
 #endif
 	{ "qipcrtr", AF_QIPCRTR },
+	{ "smc", AF_SMC },
 	{ NULL, 0 }
 };
 
diff --git a/tests/extended_socket_class/test b/tests/extended_socket_class/test
index 86c706b..1e6299f 100755
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
+        $test_count += 2;
+        $test_smc = 1;
+    }
+
     plan tests => $test_count;
 }
 
@@ -131,3 +138,18 @@ $result = system(
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
+    # Verify that test_no_smc_socket_t cannot create a SMC socket (AF_SMC).
+    $result = system(
+"runcon -t test_no_smc_socket_t -- $basedir/sockcreate smc stream default 2>&1"
+    );
+    ok($result);
+}
-- 
2.40.1

