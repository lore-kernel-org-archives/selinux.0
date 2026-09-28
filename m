Received: from mail-qk2-f39.google.com (mail-qk2-f39.google.com [74.125.230.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DDF64BD79E
	for <selinux@vger.kernel.org>; Mon, 28 Sep 2026 14:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.231
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790605461; cv=none; b=gRAHuIWH30kXvapxMl99bXPU4+T1SrsKucLYBqTCqwAznO3r0/+hrrnT/4H7plQmStAC5JP4vpv8aYnEFg++tnFUJlUvP/34Dxlw66rgw+L4xcW1pHRaYlFpn5NkI16ECsPx/g5tGMG83LAiLyfdgsyCfmRs2Y6xp6EiwBTRz/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790605461; c=relaxed/simple;
	bh=SDTqJWXxbHKKxD6cF3GNA2Bi+XPrAV0f0r2asHswKBM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gCJwk6BVxqpEn2AOCFNzqfnbSg4wbeABIq6yfbk1HS+sJe4KIcQgjAVlT8ZSRY5XKNyDRL7db68s7YF2v6jQ2xsTv8SMsWZ1Ihn2g2hVyBSvL7YCYvr9vBGXdzjaCDy8lSHmlr5ecoknyuWJY/UwRAjZIKKmo888Xy+DFiCpIXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SvPg2auy; arc=none smtp.client-ip=74.125.230.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SvPg2auy"
Received: by mail-qk2-f39.google.com with SMTP id d75a77b69052e-5332f3092eeso14171351cf.1
        for <selinux@vger.kernel.org>; Mon, 28 Sep 2026 07:24:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790605459; x=1791210259; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=jl/40keNKSD90Pb/8V8NW1rQyHEXpHLhLxAihNiRibY=;
        b=SvPg2auykWseALRfzmMsw10kAwsMOT4kRRiGUJgvWDDKP0IcSHAxoWU0xYccIrDNQS
         K1O1TvaCVQi1NU1wwpz87Kg5EOY9rFZy6zkEYlyDfDUpHSF+ytAmCk3Nbfw6wyAFez3+
         flie6WWUDvF46Imk2BJlXDhJmZrOUjfKU7P9yThFTqS5F73/H33ykk26A+jSH6kDwJ9a
         tLFo0cdCmf5a9QPcvheb0+Z34vBSazE9wGFTgU7PSmwtGybn30VstWY546K+EilgP7L/
         KILj/Fkw7EYRkOTWTMJr2HPoFr3KBpdPsqLv4LwMhkV4jKny2oaw0/eV3vXuwUKUfmEd
         +e/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790605459; x=1791210259;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jl/40keNKSD90Pb/8V8NW1rQyHEXpHLhLxAihNiRibY=;
        b=Ng6M/W+DaJXaq0j/irZoDuik0z+0S0L6T98cdwzRjDHmJuEiE37IHX3ZBQtLCvnHi/
         5f9pjggaydpeTe0Si5UOE4ODXlYIxA0HsOHxmp+m0YpVhrvw1ilaCpVmetKpALA1nRiI
         kXEIX2U/ioZklIRdhSNOrsHl+ZGiDHqqLJ6wAnigDPto6o0hBbGgldzk16qycO5h6Bbu
         TcIu2RqTURcRUhZ2qDMvY8+numw05VLH6TMEMx2svSSieZOGz/wXmJTcK67QXGBTwHmH
         DNwE/NMpo4S42CjWRU+1uGoR+sU926HlZK44atqj8s8bq2F4ZoAMBnVgpXGIQJfrssp0
         HbiA==
X-Gm-Message-State: AFuF++mVGDq76XaTGpQRjzrGo1bVs/JPlbBBGH1LY05fkekWsXUHzpzU
	Wdzdian2yyCwM/9JOiSXBDY7syT1a8ZedxrbyJZxXLtEKxzEmWFmriAlowMaZw==
X-Gm-Gg: AYBFou34uHg4J5Mr+6PIIs5jWPpaIfVGRzCKa9FMHmcTqTtW70CalGrQMV2ASMTQisM
	E2r1+H3Dg6vIGTo8NZlJxBJV+O7qV6+k5lh0Y1F70OsWqUWuiVf2Wy3wXgfD9RpBu3K+l7//bgZ
	y6Hi13w5E//XtYGBY36unwojTx1G6FOdiLX9IU8VWwphcN7Ly4HxHfc5jyfx71FU/cg/DGTGhQd
	Ut1S0pG6lngnpuyxO3Ii7DqgJWeH8iXHlbWxiaTHOYhE48meaS0MxcijLZ1H68IquagKBLm1dig
	50jSr3pJhDho/K+Ifi8T9X8CKOHzxCATpzxNYyvUyrHyVT6wKztQBDMv4eCgYYbkflsaZwZjlZh
	CxtKvrY0/EbLkdf9kiXkGrFGw10pAwLtWNiLPEhNY37oBC9HtrSSgRheX57jXN+MwGNdFGWAw0/
	ANZIjJLELJp7iZTDU1H7yjipxVb2ZOmT4/SLLWPAb+wT14qpVHLErfAj7gsdO1FuDXMWvB6BjFw
	h1UqO2R3V1Fm0S/IpnVdM/wvWPAeyFBWKXfEoRGKKrdPOzZxIIU+OUS5TJzJLMyIQcZ/sr48eU=
X-Received: by 2002:a05:6214:8591:20b0:914:40f7:fd2b with SMTP id 6a1803df08f44-91440f801a1mr121352276d6.7.1790605458822;
        Mon, 28 Sep 2026 07:24:18 -0700 (PDT)
Received: from fedora (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91451010a85sm46783396d6.0.2026.09.28.07.24.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2026 07:24:18 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: paul@paul-moore.com,
	omosnacek@gmail.com,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH testsuite] Revert "tests/nfs_filesystem: comment out failing mount"
Date: Mon, 28 Sep 2026 10:23:55 -0400
Message-ID: <20260928142354.17638-2-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This reverts commit 0815abcd70b382e13592264ce39bf48742421cc8.  The
linked kernel patch below fixes the underlying kernel bug that
prevented us from successfully running this test.

Link: https://lore.kernel.org/selinux/20260928141917.17577-1-stephen.smalley.work@gmail.com/
Fixes: https://github.com/SELinuxProject/selinux-testsuite/issues/92
Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
 tests/nfs_filesystem/test | 29 +++++++++++------------------
 1 file changed, 11 insertions(+), 18 deletions(-)

diff --git a/tests/nfs_filesystem/test b/tests/nfs_filesystem/test
index f765ab7..fc8d525 100755
--- a/tests/nfs_filesystem/test
+++ b/tests/nfs_filesystem/test
@@ -38,11 +38,7 @@ BEGIN {
         $v = " ";
     }
 
-    # A test (called twice) is commented out because it does not work
-    # for any known kernel.
-    # See https://github.com/SELinuxProject/selinux-testsuite/issues/92
-    #plan tests => 56;
-    plan tests => 54;
+    plan tests => 56;
 }
 
 # Set for testing mount(2) on first run
@@ -104,19 +100,16 @@ while ( $i < 2 ) {
     );
     ok( $result eq 0, $test_msg );
 
-# The following test is commented out because it does not work
-# for any known kernel.
-# See https://github.com/SELinuxProject/selinux-testsuite/issues/92
-# First mount(2) ok, second currently fails with EBUSY
-#    $result = system(
-# "runcon -t test_filesystem_t $mount_cmd $v -s $dev -t $target -f $fs_type -o $mount_opts 2>&1"
-#    );
-#    if ( $i eq 0 and $result >> 8 eq 16 ) {
-#        ok( 1, "$test_msg - returned EBUSY, possible bug/feature" );
-#    }
-#    else {
-#        ok( $result eq 0 );
-#    }
+    # First mount(2) ok, second currently fails with EBUSY
+    $result = system(
+"runcon -t test_filesystem_t $mount_cmd $v -s $dev -t $target -f $fs_type -o $mount_opts 2>&1"
+    );
+    if ( $i eq 0 and $result >> 8 eq 16 ) {
+        ok( 1, "$test_msg - returned EBUSY, possible bug/feature" );
+    }
+    else {
+        ok( $result eq 0 );
+    }
 
     # Create file and change context via type_transition rule, check ok:
     $result = system(
-- 
2.55.0

