Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6AF2291C1A
	for <selinux@vger.kernel.org>; Tue, 24 Jun 2025 17:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750786440; cv=none; b=uXzPzd4Fwi3kpuDRt1l7SnKsMK/0jwowCCADnOXy9SqHBPhiM78Q6vJ2RbnphJMJlRZxtND8ISEKvaz6itHMAPwW2DV15YXHMNizULJY8AHmUVZ8J5Cf03oCkarz67yaqSamhLYYeWCSCX93CkWCdTsHL5lzzUUOttbdrWUHB68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750786440; c=relaxed/simple;
	bh=oGdwJdNJE1bVk1jyNZq/szX/7xgXffrQF5YTJzk/FUA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=I3K2W2zc9TJhR6LwjCEuGr9itRA/ttHzB7gu+45Zs+QVdgh+UzdxUI61wO/WzeQkluwaExXRpc6HfbcbGnkDFFfJ8Z6e9VKP4fmi0bLzaUIG0vXLR0EJUZzvQw8anl2ltT3XHNgHLH9hUq0TI57kN6Pp6nj/WCmcgc5NyBUoaSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Uk6IYfWy; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Uk6IYfWy"
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-4a58f79d6e9so9491871cf.2
        for <selinux@vger.kernel.org>; Tue, 24 Jun 2025 10:33:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750786437; x=1751391237; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=v4djXgYxQ6uc7ZeAiM68SawfWVJktv+O/yGeqaRTock=;
        b=Uk6IYfWyI6qMe7ejztCZ3qMRk2LQZbmXFipdMyJvOU3o6IuaFXRnCB8M+XvyUatZOL
         XzJMA9H2qToN4eC7wV4n4yg3zJyVYU0vEMt42OfDV/kfEuwmpEhV87T0goNmWQ6uI7UF
         DxeqjhJ01PzCyWVRXEfF0qGu01TET6/aiiun1QW4b0V68WyKIlR9Ukm/mWnRH5vlz1qB
         zbobu8yo5bGzkH6bpzLcspdyQ7Gn0TgRYKDeRGADxlyTHETCWJgUGI+HdOS9znsJEvZ7
         yFDjraQCmNEj6klKVLLmEaGa1v5Dhtpl+t19hfZc/EumbP+bYyLIXYyicfOs1GKQzzqk
         1wbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750786437; x=1751391237;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=v4djXgYxQ6uc7ZeAiM68SawfWVJktv+O/yGeqaRTock=;
        b=Zr7vfcCmJrZ0V4xVcXZUW2G6boWYgq17By+iYBKctmYfCCDalJr+nYOcDufxLRdEhM
         NI1f16jdB9S7oNUd+UpvK0WC6YzypcOqdMUFGZtOk8n7bSdChf6K24zs1Bb1uZDHbwz5
         Na91YIwbDPMdsdrgS7ze1v9yJ0glQDJnttXMgZKXlez6AQVZ6lrfASZRvOscRqq9yZO8
         a+5V0eWkiaifrDJzr9zuIazS2Ojmgbn55O3REjyBwSitKKsYyCGSq6eqyA2mILEkLO85
         OW91IEeKLlImpaku7yOs3vGUBeNPqgQcyQmIM710AHTcQSr33HYuCA5GEOkBiYaKe/fL
         wR3g==
X-Gm-Message-State: AOJu0Yy3juhHBNnp9/f5C72ccaoUkD31QG0a39sNDnLEAvvyB2Qmwzxl
	hgJ6sXrcPeZbiWcDRoTfWyPUsSC/QLC3WA5bpem6n2XYua7dkBrS9tZqx9kf2A==
X-Gm-Gg: ASbGncvLUvQLfvcQ0u08x8RL7ytAgY74vMDZV9iNEHSyK7UyQTygW4Grn2bl49dMom/
	Zd7hJYGeuHMwR3whd3Etnmh8iM4r8NFyy6crFdSB0rXA+dPRLgnRiYVLcUJfr5M9mbDHjge1Svc
	1KExJjn6FX0Gxyr91qaNgBtCHKHMMIQJiGNa5Xnv9JdXI2yAmO31zhH/CNG7lzgzYejICXXY1ca
	Sa5gNtF8/a0DZ0mTk/5lhXxLCngmBvtk1e3aFdi5GjmHqmKRwuktxt2927KJjEzuZCPOTSGYbrf
	EigSZBVH9k5sVxEuIcRO0adjaAy0RPR4Dq/YBFklvX8IydLB96vGcrAM0g4vqHo5eLjlLL4Rsde
	TsVhBMfiA3DtW1OvqcFoU3Gj4B3GxzSHSPx+yXHhUhCHiHkdo8TmTgGPshXhH5qdqRUj28M65bF
	nElPk8ty9Fk144/A==
X-Google-Smtp-Source: AGHT+IHBUQheJhI4lS8Z/76xhev/cK8hPWajkxL+W+w8xOPZxKj/p+NVUqm8vGjN3TXXbHs4x/90hw==
X-Received: by 2002:a05:622a:1f94:b0:4a7:64cf:f092 with SMTP id d75a77b69052e-4a7c0af6de3mr1289631cf.17.1750786437152;
        Tue, 24 Jun 2025 10:33:57 -0700 (PDT)
Received: from fuse-fed34-svr.evoforge.org (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4a779d6ce47sm51956441cf.22.2025.06.24.10.33.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Jun 2025 10:33:56 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: paul@paul-moore.com,
	omosnace@redhat.com,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH testsuite] tests/mac_admin: skip all tests on NFS
Date: Tue, 24 Jun 2025 13:33:20 -0400
Message-ID: <20250624173319.23880-2-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

NFS does not truly support setting / getting of undefined
contexts. While some of the tests currently pass,
they trigger kernel error messages like the ones below:

nfs_setsecurity() system_u:object_r:UNDEFINED:s0 31 security_inode_notifysecctx() -22
nfs_setsecurity() system_u:object_r:UNDEFINED:s0 31 security_inode_notifysecctx() -22
nfs_setsecurity() unconfined_u:object_r:UNDEFINED:s0 35 security_inode_notifysecctx() -22

If we wanted this to work over NFS, we would need further changes to
the kernel. For now, skip all the mac_admin tests to avoid log spam.
This is similar to handling in other test scripts like
tests/capable_file/test.

Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
 tests/mac_admin/test | 38 +++++++++++++++++---------------------
 1 file changed, 17 insertions(+), 21 deletions(-)

diff --git a/tests/mac_admin/test b/tests/mac_admin/test
index 8ecb48b..973fac3 100755
--- a/tests/mac_admin/test
+++ b/tests/mac_admin/test
@@ -1,17 +1,18 @@
 #!/usr/bin/perl
 
-use Test;
+use Test::More;
 
 BEGIN {
     $basedir = $0;
     $basedir =~ s|(.*)/[^/]*|$1|;
 
     $isnfs = `stat -f --print %T $basedir`;
-    if ( $isnfs ne "nfs" ) {
-        plan tests => 8;
+
+    if ( $isnfs eq "nfs" ) {
+        plan skip_all => "undefined contexts not supported over NFS";
     }
     else {
-        plan tests => 6;
+        plan tests => 8;
     }
 }
 
@@ -19,18 +20,18 @@ BEGIN {
 system("rm -f $basedir/test_file; touch $basedir/test_file");
 $result = system(
     "runcon -t test_mac_admin_t -- chcon -t UNDEFINED $basedir/test_file 2>&1");
-ok( $result, 0 );    # we expect this to succeed.
+ok( $result eq 0 );    # we expect this to succeed.
 
 # Verify that test_mac_admin_t sees the undefined context.
 $result = `runcon -t test_mac_admin_t -- secon -t -f $basedir/test_file 2>&1`;
 chomp($result);
-ok( $result, "UNDEFINED" );
+ok( $result eq "UNDEFINED" );
 
 # Verify that test_no_mac_admin_t sees the unlabeled context
 $result =
   `runcon -t test_no_mac_admin_t -- secon -t -f $basedir/test_file 2>&1`;
 chomp($result);
-ok( $result, "unlabeled_t" );
+ok( $result eq "unlabeled_t" );
 
 # Delete the test file.
 system("rm -f $basedir/test_file");
@@ -40,22 +41,17 @@ system("rm -rf $basedir/test_dir");
 $result = system(
 "runcon -t test_mac_admin_t -- mkdir --context=system_u:object_r:UNDEFINED:s0 $basedir/test_dir 2>&1"
 );
-ok( $result, 0 );    # we expect this to succeed.
-
-if ( $isnfs ne "nfs" ) {
+ok( $result eq 0 );    # we expect this to succeed.
 
-    # Verify that test_mac_admin_t sees the undefined label value.
-    $result =
-      `runcon -t test_mac_admin_t -- secon -t -f $basedir/test_dir 2>&1`;
-    chomp($result);
-    ok( $result, "UNDEFINED" );
+# Verify that test_mac_admin_t sees the undefined label value.
+$result = `runcon -t test_mac_admin_t -- secon -t -f $basedir/test_dir 2>&1`;
+chomp($result);
+ok( $result eq "UNDEFINED" );
 
-    # Verify that test_no_mac_admin_t sees the unlabeled context.
-    $result =
-      `runcon -t test_no_mac_admin_t -- secon -t -f $basedir/test_dir 2>&1`;
-    chomp($result);
-    ok( $result, "unlabeled_t" );
-}
+# Verify that test_no_mac_admin_t sees the unlabeled context.
+$result = `runcon -t test_no_mac_admin_t -- secon -t -f $basedir/test_dir 2>&1`;
+chomp($result);
+ok( $result eq "unlabeled_t" );
 
 # Delete the test directory
 system("rm -rf $basedir/test_dir");
-- 
2.49.0

