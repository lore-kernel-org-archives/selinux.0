Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72D491CA87
	for <selinux@vger.kernel.org>; Wed, 29 May 2024 14:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716991463; cv=none; b=g8fGYkmhIlu/aFcKvDiuUKrflUGiAN65ro8Bba+g/4lSYHppQ+KafQVpNk0jOERIpM/KUPS1Fdy0+S2x5vHOx6AjiSUzjRUZhpGKWLdO6m/qZqBp6grv7mNPdzwwiBb8tt1zhZu1tnREjLP3IV/n6OFwcynxwV/yAIREpXeZJ7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716991463; c=relaxed/simple;
	bh=DIkkw/j5ssDt8eKfVDCqlqH72UnBjWdo3EL4xI+jngU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qwVxVutnuuW5wUxE9CSF8AF2h4AfvcVIsYQbCwyDn2RvlEf0+E7TS+lUkt2BPiZ/a2Ih5RjMaXLqDjLtImKj+VnvP6+aWtyyRJR/tF/bosT/1+/+VObDUWNRANxOljaqsQpnXKSDIe9gX0QmqyKKPnbwAeRvd20pcuHiljETwxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QGGkL5YC; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QGGkL5YC"
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-79305314956so141456685a.3
        for <selinux@vger.kernel.org>; Wed, 29 May 2024 07:04:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716991461; x=1717596261; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fnMikCGHKw3M2OoDg/XtL/7SBcFilvxx+w8BXmbvm+M=;
        b=QGGkL5YCJkAo3HQHCict3Ni3uVRWbHsPI3o7sd+IsEyy+f5jgjJQee+/9J+Zvo9hgk
         OsSIpq9PtI1cJjSa1kRLHItHyvHJ2ZRoN0D5bMW0BVck7HcI8LEYROdyUzHx3x9CfmA4
         m2MGfN/fKdIJkLXeNt9BRdQX/PhNoh2I6lAXYiGq85P0zHZzG9H7OLX66cWtw/ce0UUB
         TTAQCLQR7OFx/ahrtomI251z4z3I4btDOM/pNKRl3JmCTgGs4zL3+irsXqcywUqFLhi3
         e3VL7MwWemPDLB8OGyM9u1cGX+7elUsAZrd1njnys2KXUgcCmFfD1Rh9XiHkj6iM1lZh
         a6/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716991461; x=1717596261;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fnMikCGHKw3M2OoDg/XtL/7SBcFilvxx+w8BXmbvm+M=;
        b=toeJEml7hoJnN+HHz7PCiD/vI/2twwPbkyYK4q5M4i32VF22Xaxqx1rRZenHEym+2e
         OXSsXnamNlvpoSZBrfa+T1ImnlqV51w1rLq/pNj9+ZS8Eskl5viwAhbINNz7cs0nEKDT
         ylvBYjvMsKUBbo2nWFb8BvFDmVqKA+jWKEWqsBKYHk3QAjTZ4Pe2cL5It8eLr+O2h4CZ
         SI5GVUDuXeHoW756AtQbytdwR2L1OSe33FqXOt0TupPK7FKvSkLnFXWBp15KZVVDGwIk
         Hq/p6/ZFek43V9l2m4vClM5vLRBV2yMNgMm82uOOm5SOrfX78xLuXPfpHlgGG48Dy3vx
         +PhA==
X-Gm-Message-State: AOJu0YyOE0wn1zouREn4RVkTSe1PdOVyKQ8pcBum0jk0mjQs++Vy9HYu
	7DktH3J+AZKQFexO/Dovt82hBmAn5uqXBngX/WE9ro8oOkG+0KmOF/Dnjg==
X-Google-Smtp-Source: AGHT+IH/aD+MPNs5MPdOZyObuTXGDMPkkRUP8AWrlMJJlzFzby2gxqJbkI1TjrQ+4vk4Wk7D0kMe1A==
X-Received: by 2002:a05:620a:c4a:b0:794:d27e:6d59 with SMTP id af79cd13be357-794d27e94a7mr598107785a.69.1716991461164;
        Wed, 29 May 2024 07:04:21 -0700 (PDT)
Received: from a-gady2p56i3do.evoforge.org (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-794abd3345esm470867485a.118.2024.05.29.07.04.20
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 29 May 2024 07:04:20 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: paul@paul-moore.com,
	omosnace@redhat.com,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH v2 2/2] tests/nfs_filesystem: remove failing mount
Date: Wed, 29 May 2024 10:03:09 -0400
Message-Id: <20240529140306.6663-2-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240529140306.6663-1-stephen.smalley.work@gmail.com>
References: <20240529140306.6663-1-stephen.smalley.work@gmail.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For reasons unclear, we attempt to mount twice, the 2nd time yields EBUSY,
and then the following test fails. Remove the 2nd mount, which also
resolves the failure.

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
 tests/nfs_filesystem/test | 13 +------------
 1 file changed, 1 insertion(+), 12 deletions(-)

diff --git a/tests/nfs_filesystem/test b/tests/nfs_filesystem/test
index fc8d525..4203206 100755
--- a/tests/nfs_filesystem/test
+++ b/tests/nfs_filesystem/test
@@ -38,7 +38,7 @@ BEGIN {
         $v = " ";
     }
 
-    plan tests => 56;
+    plan tests => 54;
 }
 
 # Set for testing mount(2) on first run
@@ -100,17 +100,6 @@ while ( $i < 2 ) {
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
-
     # Create file and change context via type_transition rule, check ok:
     $result = system(
 "runcon -t test_filesystem_t $filesystem_dir/create_file -f $target/tests/nfs_filesystem/mntpoint/mp1/test_file -e test_filesystem_filetranscon_t $v"
-- 
2.40.1

