Received: from server02.seltendoof.de (server02.seltendoof.de [168.119.48.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41FC3312819
	for <selinux@vger.kernel.org>; Mon, 28 Sep 2026 15:58:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.48.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790611116; cv=none; b=F/GC7QPo396gKimVBtm+8T+5+lRIzABH4kAWu2OZ0rUBqjg+6la/fgkopGSYZ87pPK7w1O/yKgkDTFWScDb5QqMO65xcTy4k3S1wSyrS8u9zVcg8lqp7Hm9bO/iIzN4PiPHxfLZkun/v2J4aPmZYg6wvcZ0OXCCB59hL5d8eheE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790611116; c=relaxed/simple;
	bh=Sg7FmyN4P1kCUGV5Je//LXE/8n0Axho5KwCB0KQdiOc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TWmYlyxI7UehAEwvqQQW0U9pPyn+e1ZaZrrRZLXPqEZhrL0sOjcSm7ae2F6Mpl8mNOShnEG0sMlkfuYSD0TEPmllokTy3OSfORZwenrwxl3b9H7R0Y3z3SBGctUAyL8zhKBYBegSMcRasu35s6OCN85iypl87jZ/qx9UySwQXb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de; spf=pass smtp.mailfrom=seltendoof.de; dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b=IDT/1Sjk; arc=none smtp.client-ip=168.119.48.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b="IDT/1Sjk"
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seltendoof.de;
	s=2023072701; t=1790611103;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1JULJako1O63+9cdW4dK1Klom2TIFu3DItDpOIgHbmA=;
	b=IDT/1Sjk6w2NzkB+WeiikO3kXW+5H7++jWHoSX5uOSF9aLw9W+FROOqsyzIT6hgMdlhXTN
	HKeH68ulLl/fouEAhCXh6CI1qxPyMM4WWFmVylyKG2eIH/5cTT0EIIBBYBFYXF4EZ+zJvB
	zWduS0lxI4LWCEMPJH9a6Nf1WfJUK80V0nV7TA0Mc/y4EosbVzJ67t+t1RwqlcLbhNk2JO
	6Yde/7HxpVPMNtEcG/jHVBKa0Fv6lPbSKqFhU01waSYqgbbs9yIyeWVIEk1H0Dna5zkdUK
	XHfL08Ui5m6dJLl70j9u9penk6pJU0CJK/h28PKrlkUXxLCvJLWKHSZAsHkhJQ==
To: selinux@vger.kernel.org
Cc: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
Subject: [PATCH v2 15/21] tests/extended_socket_class: work with CONFIG_CRYPTO_USER_API disabled
Date: Mon, 28 Sep 2026 17:57:46 +0200
Message-ID: <20260928155753.2259807-14-cgoettsche@seltendoof.de>
In-Reply-To: <20260928155753.2259807-1-cgoettsche@seltendoof.de>
References: <20260928155753.2259807-1-cgoettsche@seltendoof.de>
Reply-To: cgzones@googlemail.com
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Christian Göttsche <cgzones@googlemail.com>

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 tests/extended_socket_class/test | 28 +++++++++++++++++++---------
 1 file changed, 19 insertions(+), 9 deletions(-)

diff --git a/tests/extended_socket_class/test b/tests/extended_socket_class/test
index 1e6299f..f85243a 100755
--- a/tests/extended_socket_class/test
+++ b/tests/extended_socket_class/test
@@ -3,10 +3,11 @@
 use Test;
 
 BEGIN {
-    $test_count     = 6;
+    $test_count     = 4;
     $test_bluetooth = 0;
     $test_sctp      = 0;
     $test_smc       = 0;
+    $test_alg       = 0;
 
     # check if SCTP is enabled
     if ( system("modprobe sctp 2>/dev/null && checksctp 2>/dev/null") eq 0 ) {
@@ -26,6 +27,12 @@ BEGIN {
         $test_smc = 1;
     }
 
+    # check if ALG is supported
+    if ( system("modprobe af_alg 2>/dev/null") eq 0 ) {
+        $test_count += 2;
+        $test_alg = 1;
+    }
+
     plan tests => $test_count;
 }
 
@@ -127,17 +134,20 @@ if ($test_bluetooth) {
     ok($result);
 }
 
-# Verify that test_alg_socket_t can create a Crypto API socket.
-$result = system(
+if ($test_alg) {
+
+    # Verify that test_alg_socket_t can create a Crypto API socket.
+    $result = system(
 "runcon -t test_alg_socket_t -- $basedir/sockcreate alg seqpacket default 2>&1"
-);
-ok( $result, 0 );
+    );
+    ok( $result, 0 );
 
-# Verify that test_no_alg_socket_t cannot create a Crypto API socket.
-$result = system(
+    # Verify that test_no_alg_socket_t cannot create a Crypto API socket.
+    $result = system(
 "runcon -t test_no_alg_socket_t -- $basedir/sockcreate alg seqpacket default 2>&1"
-);
-ok($result);
+    );
+    ok($result);
+}
 
 if ($test_smc) {
 
-- 
2.55.0

