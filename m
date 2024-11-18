Received: from server02.seltendoof.de (server02.seltendoof.de [168.119.48.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A32061C1F38
	for <selinux@vger.kernel.org>; Mon, 18 Nov 2024 15:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.48.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731942197; cv=none; b=Oe8pje6UZyIxmbnFN59Thjv2Fbc6iG+KEoE7gb101qHBixpp5t5xI4U3HHIex82SCqMsu4/1d40/MrM1R1LUkqYIcKOjiPpZdHOcUY5Z2nEVUyLGJWBUjHcvKFKloJW96oRCzqntH+prd4w8BIUGkbWggqvHCt1FZeEklllfEFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731942197; c=relaxed/simple;
	bh=O5t9CC7M2FpZFt09N9hql0vJG2J4v0TF90ygs7BHoNM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IW8zHuu1n798q32H0D40pR01uWUohXs36SUQwEbBKxP2Wwo6MKHv5KsWIQsyleP6AOfSJNfcipOa0oxE/pOzk1oyNcC5uYsfRMklcTKBaDjVY849bqneaSC6EA7DWMmpmeS70Yg4QasV1Vk8Na2lZ6aKT/MkrEm17Gm0NkgxJbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de; spf=pass smtp.mailfrom=seltendoof.de; dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b=ZLhKhIRd; arc=none smtp.client-ip=168.119.48.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b="ZLhKhIRd"
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seltendoof.de;
	s=2023072701; t=1731942183;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=m1x/o9CZffdwrpSVGl+bTdGOg3OLyn8xj4otoBjdY8Y=;
	b=ZLhKhIRdzOKqcw4DnCI7KbTj1B3tUixm84PFjujfVm2cc1Bq+Ymk+5BEJYGakXIGXsoWmX
	bcWTGrFphk2myv+rgYODBcyd5dWH3PBEG+5UC2ZofcYU+Dn63wa3d6YDzGwGTX6M++m14x
	0egxB77NvU2XGrF5H0YolMksPDwC0l77RLiFqzIYxoLuyzYSxiULsJ3WS35kiCdCcuQmJE
	n3m48UKGl2uxIjOJn8j6CLThDgp96YU79ry6PXzRd/FBLuVDYBSW1uq30kw0mKf9mc5b77
	Ts2yRApZh9sSZ579UkOwP9IMe89bDbcaXOJVOC00tZSMeNnYxQHZeDX1vla/WA==
To: selinux@vger.kernel.org
Cc: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
Subject: [PATCH 09/17] tests/extended_socket_class: work with CONFIG_CRYPTO_USER_API disabled
Date: Mon, 18 Nov 2024 16:02:31 +0100
Message-ID: <20241118150256.135432-10-cgoettsche@seltendoof.de>
In-Reply-To: <20241118150256.135432-1-cgoettsche@seltendoof.de>
References: <20241118150256.135432-1-cgoettsche@seltendoof.de>
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
2.45.2

