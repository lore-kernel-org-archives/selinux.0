Received: from server02.seltendoof.de (server02.seltendoof.de [168.119.48.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70F0E416859
	for <selinux@vger.kernel.org>; Fri, 25 Sep 2026 17:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.48.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790356737; cv=none; b=se6l8saws8QXny62Fhdtakk1OeB21HRu8jUmHJ1jPRn6IaELnJJIpPpX2zLNsFJ/Z0MlYtckWZaeOVbbNKc3rs0UbJGcEdJVFKEXMIm7oB+Ee/6Kz/bxINxhboLWAwl+HYEQCbqU/GAP+oqscCmavLmFWVp8rX3N0DuPHb8XbOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790356737; c=relaxed/simple;
	bh=Sg7FmyN4P1kCUGV5Je//LXE/8n0Axho5KwCB0KQdiOc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MrCC2pVqEU84jWuK9ptIslypxqgqIvuma0UPQ3pUGk2fI8D+cxMQ2wR/o+umwkkSLOupu/0tpCc82E+DzV8SkjcSwTse7W2WwhNHGtsirN9cBFtt4/5HlJZBZsCLuE76bx9gB7Waa2wUyAASuK5EkzNOnN2GfERplh09nn5VwSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de; spf=pass smtp.mailfrom=seltendoof.de; dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b=sawqxUbY; arc=none smtp.client-ip=168.119.48.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b="sawqxUbY"
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seltendoof.de;
	s=2023072701; t=1790356714;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1JULJako1O63+9cdW4dK1Klom2TIFu3DItDpOIgHbmA=;
	b=sawqxUbYmGiI7kl441vseqZM61qBp7GDqrK+naN9q0MpEOJrHlQTJcDfvUHU6UnMwQzH7C
	aFIBwyaOfdFjeHwNKQOsONsnSOcgzYqloGmDKDzjtYzUnCksWl1hp3maBptiHI3TniLEWY
	qlgLO5jdjxeGNAy1pi32IYAwm3zrQJOnF0fER2ainxTBdKvTvMBFRGjQ7wkjxFmlEPEAQj
	YxHFDXMANvyOLN6216D6/HXSP+0OsnMzH3CDvL139B36+eobsEueWDHWcWEfuavkoHdeWD
	p8fDoU7hutZENdO/Id3PYh8ryCDyEQp6OCjVVjInT7EO7d+GlIy7AITKEHQRsA==
To: selinux@vger.kernel.org
Cc: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
Subject: [PATCH 15/21] tests/extended_socket_class: work with CONFIG_CRYPTO_USER_API disabled
Date: Fri, 25 Sep 2026 19:17:47 +0200
Message-ID: <20260925171755.2029271-14-cgoettsche@seltendoof.de>
In-Reply-To: <20260925171755.2029271-1-cgoettsche@seltendoof.de>
References: <20260925171755.2029271-1-cgoettsche@seltendoof.de>
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

