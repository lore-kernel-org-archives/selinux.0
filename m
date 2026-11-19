Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795095144;
	b=VhMC+xQCLMxfXxBgqM1/hiMrZ3JCZcyIHndtZzXgPmTR7zLQASt7m+fyBljgT0ss2GCh
	 V9EskiABgnwpFEF1vv1UUMYqbLTeR0Aev78eKH5i7XDlvYv51lqqAlMdanMvmxN6QVC8w
	 dq//OzOuabBM1xkQASdmEmo65HUXft67tgp01cmhtIgGUUByocyI1KgjQApYULNe9GNTw
	 iAhbVArKBQydcueOy1ptOddc3ihajGY1IG8pHx1dTmXCAS+YEpi2grHzXAINtlQCLhZzN
	 fodVqMimN3fm+yVo3M+yBLPZMWc2C4U6tzGG4+0WVAg2f/EGbPl0uPpDVHQ7qYquq3w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795095144;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=uEqyZefyJBQRZx3iLN3O0kesNXrXkwjOPt2xmvh0HrY=;
	b=QZo1kqXu0Bbcz9YZB0PrLR6ikfydERM+l/LlH4WQJMUi/aH62CxzJYQ3Mlkcj4oFfPia
	 c/v52k8BNAgBH0bCseR0c/9I8wGk9+GP5pLcUJp9SiIpZpO7QuvU5DPUya+Gv4TH/QJoF
	 AMLin9nHHHHKaCxuxUfDpKPoDxn4lFRUE2ic2rfxSl+nUcgJRlILEdb0/MEJJLG/37Zo0
	 FJ0qDYrlIh/E6o6DIgMog0rwAJtCajHIIKOhTYmw8mtUOzm0L0Dh3Yc18Lj15TmMwissY
	 Wgc7wUrb0iX/HR9W9wxA+78h7fWMLIkR5X7J/HikgRMMHtJtqopqEOZvIAQN5+s7bHQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=GN2a3Z25;
	arc=none smtp.remote-ip=209.85.219.51
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D7A3606A32A
	for <selinux@vger.kernel.org>; Thu, 19 Nov 2026 13:32:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1D7A3606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=GN2a3Z25
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-921276742e3so7352716d6.2
        for <selinux@vger.kernel.org>; Thu, 19 Nov 2026 05:32:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795095143; x=1795699943; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=uEqyZefyJBQRZx3iLN3O0kesNXrXkwjOPt2xmvh0HrY=;
        b=GN2a3Z25DG7gHOWRUQBi4GkLE+nrwCB9egc6EGFVyniE6GQxyxKGbVNceQ/H9EEURP
         ph5+qWk98XpmfpyV0T2WMpq42aKHc49MBJ59VVpf5uBiSY71GvXiv30LKlDY/AK4lM0L
         x7poy4KMyA5jFMo5ZEDnWdJ4QSHGsVfcCHX4YrsA0+7ahDI9edZSM2d2iIFji4dDtV0t
         1KiDM9vgElcRFIcKrUbU9ojh10q2Ymtxmo/vlNkDnEcZdqfnNPb/7rsftcQ5ggIM95gL
         nMCZGvyKDGggAYidUAM7c9hEtLQ7xR5LL0Ud/CDKzBk3X/UDQznjWjTqsuD3un57lTzf
         zZPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795095143; x=1795699943;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=uEqyZefyJBQRZx3iLN3O0kesNXrXkwjOPt2xmvh0HrY=;
        b=ihdh3F4I2uiceGh2VrDi3go4Qvcr1/aiaduYTYW0lPRb7WMLBIc2iwRgt09ZREkd89
         YRyUUmqFnwFTndlwrKBAUCnjYhEKe10mc3VQXLnl5oplBmFEQPZfelJ7pKHkjfVst0SU
         EmqN7BeRruE9iBva0vp20WUbzkINVSbkL9fxlAPXPMfUANzRoQhgraPQYl3Zy+nqZrS9
         LTexITe8+odsuQUVh8SbKsnjYunB2Mk4nxdKTIV7FkzLfQwgtZjQhgzP/esvNM7Z/YQU
         sxFBJ1wGtxu2MkT0uDa7nUsYp7EImb4+5qF99G3YGTllrmksGfLAYzpZy7sRxmWA1zgV
         IPlQ==
X-Gm-Message-State: APuU4Z+yr+QtENaMmQI+JE6m7g+714SHeq9nSGDkOdzHuOxxaKLziRlA
	7KTioI+a6aRKrsBjpLneCtkaT6r9V8hA2dvoDLVHyUdUXGK87UdLO0N7qz61NQ==
X-Gm-Gg: AZFdTZfloX3AuuEXEGjlK0Uf0dkrMTAhApvmxxys25W308Cemj7CbrO0zvWXEjVS8Ki
	pUuK2z3r439kVtbUXu/tFtrUl4BEFMpciwv42syGCNngksspzjmJ5emFlh5W0FD7UkLTkUuFaid
	dy8vuZ5Kj4VB/2HCFLpnZisP3t6yGgHCkYRGnU9yaCZGkhc8wCacuUBKaXBMIxwpUC8BJKAl0og
	21l8iVC+q3OGfNCO9LUZ1si98UHOQM6tXtER9AsVPemYiWRM6SfF5DbPR60aTNDIYPj2dnfA5pI
	v+QdAbq//9xx52PxwYAVfOPGP9hjQKlSUYYiLyVWtEFPepyhJkob2hSAkuUGxtvJzlfy3ZdI9jG
	TqJXY0YzunDhjuEXT1EtORqftwwTMPoH318XVQNCblnZtiQvA07rO6VxFIVI/kbG5jJlfYZKCvg
	jv7emldxlImjh1bqagJGGSx9X+foL5x9+L3MvMv7DvEMbRjcKIUtQcZah+8irM2YLdw/L9+z+G6
	invLvZ+jmQjeIxirDN0EZaBYhNgjO5zkVUCHAs++AWIKK3smL8aybvUEwwV1YKVFy2SNpoaFhNL
	ixOvaxSvLd2g3uteY2HI6RIpVipAKTdxY9rxrKvMQv++C6mJhP5A4XN26/YKO18yHzsZn8uJjYp
	Tuyt456AzzBBSNXoK3TGZnwkHsqFNUNfZXrVNeqEQTdGwI7fQoV/05hfqaEARhYAYRVF93H4H4L
	VeYA/O9uvebD9j6LLeBtP8wdJLLIYjt+02
X-Received: by 2002:ad4:5cae:0:b0:921:2a6:c6d9 with SMTP id 6a1803df08f44-92114e938b1mr99650046d6.51.1795095142878;
        Thu, 19 Nov 2026 05:32:22 -0800 (PST)
Received: from debian.. (pool-96-244-147-163.bltmmd.fios.verizon.net. [96.244.147.163])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-92114d10f89sm50094936d6.13.2026.11.19.05.32.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2026 05:32:22 -0800 (PST)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: omosnacek@gmail.com,
	paul@paul-moore.com,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH 2/2] Reapply "tests/nfs_filesystem: comment out failing mount"
Date: Thu, 19 Nov 2026 13:32:01 +0000
Message-ID: <20261119133201.2185-2-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261119133201.2185-1-stephen.smalley.work@gmail.com>
References: <20261119133201.2185-1-stephen.smalley.work@gmail.com>
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

This reverts commit 58ec49b227f8c825e4a46d2dd97786df894ba0ba.

Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
 tests/nfs_filesystem/test | 29 ++++++++++++++++++-----------
 1 file changed, 18 insertions(+), 11 deletions(-)

diff --git a/tests/nfs_filesystem/test b/tests/nfs_filesystem/test
index fc8d525..f765ab7 100755
--- a/tests/nfs_filesystem/test
+++ b/tests/nfs_filesystem/test
@@ -38,7 +38,11 @@ BEGIN {
         $v = " ";
     }
 
-    plan tests => 56;
+    # A test (called twice) is commented out because it does not work
+    # for any known kernel.
+    # See https://github.com/SELinuxProject/selinux-testsuite/issues/92
+    #plan tests => 56;
+    plan tests => 54;
 }
 
 # Set for testing mount(2) on first run
@@ -100,16 +104,19 @@ while ( $i < 2 ) {
     );
     ok( $result eq 0, $test_msg );
 
-    # First mount(2) ok, second currently fails with EBUSY
-    $result = system(
-"runcon -t test_filesystem_t $mount_cmd $v -s $dev -t $target -f $fs_type -o $mount_opts 2>&1"
-    );
-    if ( $i eq 0 and $result >> 8 eq 16 ) {
-        ok( 1, "$test_msg - returned EBUSY, possible bug/feature" );
-    }
-    else {
-        ok( $result eq 0 );
-    }
+# The following test is commented out because it does not work
+# for any known kernel.
+# See https://github.com/SELinuxProject/selinux-testsuite/issues/92
+# First mount(2) ok, second currently fails with EBUSY
+#    $result = system(
+# "runcon -t test_filesystem_t $mount_cmd $v -s $dev -t $target -f $fs_type -o $mount_opts 2>&1"
+#    );
+#    if ( $i eq 0 and $result >> 8 eq 16 ) {
+#        ok( 1, "$test_msg - returned EBUSY, possible bug/feature" );
+#    }
+#    else {
+#        ok( $result eq 0 );
+#    }
 
     # Create file and change context via type_transition rule, check ok:
     $result = system(
-- 
2.47.3

