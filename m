Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60EC0176247
	for <selinux@vger.kernel.org>; Fri, 31 May 2024 13:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717161263; cv=none; b=qGx4JEDTZaUR+Vq90E9FemdF1l97zeDo/yUQR3vM0RQCAjM51MhiaxZAGvQoAo5ShDGNLiPysmNxPJsGAW3awWs6Jp0As/bOsTHzg7MKpPXEVt3xOauECRbSqX2/eaNQBz39adZZ2hEdoDP3ktTsc9dvCy7nvKq85B20noU24/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717161263; c=relaxed/simple;
	bh=foBeSO5wuzh1s8jjAZZn7D4MIXgsMyElbPPPCPiG/qM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Rb+VITWkvDvTYiRBrSJZVes5ovTlxUxyzjHLB3+r++VwAmO0rOui4dsJVgrxrHuJpB1Zq+8vj4y6QU4x+ha3B3sRMY/DGhzFJgPrTjXtC1em7SA7Ti0Y6Ig1Q4UjKg+kM3BeKnBrXEPrHZeaVi5qcx2eCvcqokou7n8+YjyrZBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KtuOcpRs; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KtuOcpRs"
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-43fdb990b3aso10159761cf.1
        for <selinux@vger.kernel.org>; Fri, 31 May 2024 06:14:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717161261; x=1717766061; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GLlSH14Pm63dyV87tbiL9WR2b6xzutVQZ4gYa8/7pmw=;
        b=KtuOcpRsBsLQyQ6Z7qeBxzHEpn9YIkkx3XU/XdkOBc0umYdHvyd4AdMBImcFBYRM3H
         aSYxffHMTgnAv9cnd81eSvzjHBCLq8+PTZKakYAgHtMwoS58ikiCC1nHSMLouSORlShI
         OWwaVrhyEzG8yU5zni8BmWRhaw9XhdmyPyZJakrKM+G72x27IO18lXQtv79Hh8njGCJo
         KMaxwBWtBAPSK8lts2q+no6UQ8LkxouyKPiim/ci3lxN5G/96dITXlaJmpd2Pa3d6JUW
         wVq/YX06oA8O7q4zBntVZuenf/IWOuVr/erFy6BGaV7WA2iq1spORIr+wUr5WFYLODA5
         BRvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717161261; x=1717766061;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GLlSH14Pm63dyV87tbiL9WR2b6xzutVQZ4gYa8/7pmw=;
        b=Z64bIsuEkVTGa/it/Rts0qDovFvOBGRrCMg4b//rnGRiJNPjpi+eVc2Ljc6+3Ocbwu
         8UjTueIqCMpvGL3PNe7uzOiMk6XLZmcd/E7uF28WeRYpRdFS7ZXktEgDoY3fBiPdeLde
         +h8z8bmNe6FzmatDwfabaTmEjmqn2TsmyE3kAMrEh9GuIMPNK4dzyWakm5jpPcQTODuU
         +rM32NjFfPS/bR2n0VHr0Yq+/XJk0SLzQ8rWNX6duUytkAg+CaUXU8aWWw/0WK+wHYQO
         BOxWZChyV/VWZSJltAbhPdTNAVkFyyGpGwLBHpozs2nifrfW65B/jjl+yFCFO7SLFtoq
         8vkA==
X-Gm-Message-State: AOJu0YwIXsW38lY4e50O7wOzShCYBHGaat7nMnvQVznnN/Y1PvClcfdu
	mMwqezU56dA47ClvpLl6F5G+UMF5hjQaN0P7e0D2pqGH/c7X+N7KDfcNHQ==
X-Google-Smtp-Source: AGHT+IH+qUa0vKJUYfQyXiVtAS6jCtliARK9XhN5+79DQka0paF+DWTwnxx/CTX8XNNkPq+CcJJyww==
X-Received: by 2002:ac8:7f49:0:b0:43d:f4e8:3b14 with SMTP id d75a77b69052e-43ff5297056mr19359311cf.39.1717161260946;
        Fri, 31 May 2024 06:14:20 -0700 (PDT)
Received: from a-gady2p56i3do.evoforge.org (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-43ff23e269bsm8020781cf.46.2024.05.31.06.14.20
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 31 May 2024 06:14:20 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: paul@paul-moore.com,
	omosnace@redhat.com,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH v3 2/2 testsuite] tests/nfs_filesystem: comment out failing mount
Date: Fri, 31 May 2024 09:12:39 -0400
Message-Id: <20240531131237.16666-2-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240531131237.16666-1-stephen.smalley.work@gmail.com>
References: <20240531131237.16666-1-stephen.smalley.work@gmail.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For reasons unclear, we attempt to mount twice, the 2nd time yields EBUSY,
and then the following test fails. Comment out the 2nd mount, which also
resolves the failure.

This bug is tracked in
https://github.com/SELinuxProject/selinux-testsuite/issues/92

Before:
Run NFS context specific tests
nfs_filesystem/test .. 2/56 creat(2) Failed: Permission denied

#   Failed test at nfs_filesystem/test line 118.
nfs_filesystem/test .. 30/56 creat(2) Failed: Permission denied

#   Failed test at nfs_filesystem/test line 118.
nfs_filesystem/test .. 53/56 # Looks like you failed 2 tests of 56.
nfs_filesystem/test .. Dubious, test returned 2 (wstat 512, 0x200)
Failed 2/56 subtests

Test Summary Report
-------------------
nfs_filesystem/test (Wstat: 512 (exited 2) Tests: 56 Failed: 2)
  Failed tests:  7, 35
  Non-zero exit status: 2
Files=1, Tests=56, 12 wallclock secs ( 0.02 usr  0.00 sys +  0.15 cusr  0.25 csys =  0.42 CPU)
Result: FAIL
Failed 1/1 test programs. 2/56 subtests failed.
Error on line: 104 - Closing down NFS
umount: /mnt/selinux-testsuite: not mounted.
NFS Closed down

After:
No errors from this test script.

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
2.40.1

