Received: from server02.seltendoof.de (server02.seltendoof.de [168.119.48.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD6BC1F0E46
	for <selinux@vger.kernel.org>; Tue,  7 Jan 2025 13:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.48.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736257585; cv=none; b=SSVkydpsV2PMhuXdvmeqo9jcEA32ZBoCvoXL/3+VygwqkFwYx1x8okMqKRO3kO3YUt4Twro+Wkbk4OOi0nGVsAXU16hE+OTsae/ZiUIlxZUBPjzFlegjf0TGWAhsAirNqCSlatLgATts/AP1SYq2IYayWagMlav745/tztnyM5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736257585; c=relaxed/simple;
	bh=7+GdtblkCbLM4lpaUtDGhHp/+dshmcdooPw9ByEgetw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pktCdUPqejZ0sjZRH/ZgKNnUzOG72216WK5SaGN+IHPWkihQ17TbuuN7wzO6lq7OUXSwUXtMZUpRrIffO3Z139xxsWvIWVK5/FCXdrZAxhkmYwGDuWrUtZP2gUeJHKCIq54rqlgQiClSIQeR6H2OLKvrEP3rhY+u1G0yAgSic48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de; spf=pass smtp.mailfrom=seltendoof.de; dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b=TUFRvKTf; arc=none smtp.client-ip=168.119.48.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b="TUFRvKTf"
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seltendoof.de;
	s=2023072701; t=1736257574;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Kk68S0wjF97uYCP0Agj7VdN7nnRK5PHjibC1P7a91J4=;
	b=TUFRvKTfp+XaM9VR6W9tyeoOxfmpSmw1WXIJhKlKfUfZ7Qp5dQJMn495gJw59hGR1264jd
	GILZkWzzKDq89dVEtDzJTUEkHAd718HpMeILk2mrB1rkuVj3pE7zjmwloF65F2GDJqXAdS
	GmA6ZytGcHI75WuBHV6QvAxoFTKHtxX9X87kQqBlpr11PZ2Nz2i871JpMGO3gSlAVEjQFA
	H/5GTZlUtyj4WnToTC9qj7/Rdn2SpEJLHVQw+5qJDrx/BGTMYdZgK9c3Tso8EbkUWWwqGH
	eENrgsqqNEq6B/4H9jDH0259j7uj/XS4jn9AuUSK2OB0a/zT8BcfZ1btI+JSiQ==
To: selinux@vger.kernel.org
Cc: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
Subject: [RFC PATCH v2 09/17] tests/extended_socket_class: work with CONFIG_CRYPTO_USER_API disabled
Date: Tue,  7 Jan 2025 14:45:57 +0100
Message-ID: <20250107134606.37260-9-cgoettsche@seltendoof.de>
In-Reply-To: <20250107134606.37260-1-cgoettsche@seltendoof.de>
References: <20250107134606.37260-1-cgoettsche@seltendoof.de>
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
2.47.1

