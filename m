Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84EB92F5302
	for <selinux@vger.kernel.org>; Wed, 18 Jun 2025 16:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750264305; cv=none; b=k8z+v3IlKR+B3PqZJsCBB9peyZLB1Ku+wP2XZYdCNILKMSvFzmMamMm9ufGKqc/KrIY8/w48cmLnuVmADa+bgNN8G51vgjMBvxaLlYWfeujiIkaKxsY7cx4x6qTVDlroifGHVd8llRgSQ/g9TGEs1IYb+BFjWI27TGgdEWpzQro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750264305; c=relaxed/simple;
	bh=7FBAWdcnDf4uly0hflWcAYoi0LocKbAc9EDINd/wyS4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=p9tYhQRjzMN9QXcyfDDH6bdOiTcvkxPVmXTmQeV9kE4zg39bCpKyWb8WbuS7PuGlu4/YIrEFyT/5STNEI8uCdvUQSVxA9uD+iBBWbnlv0WkCd4aAwT5/kA3pfnKEVI+NTw2QJ0Q45ID+8dj05NaMVeQNUJetP4RUXjD5hF/VB1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GM1HjBGI; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GM1HjBGI"
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-7c5f720c717so108327385a.0
        for <selinux@vger.kernel.org>; Wed, 18 Jun 2025 09:31:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750264300; x=1750869100; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=B5w7DYHdWT8EU+RZTFYloguOUQOwV9lSiEShIXr1iM0=;
        b=GM1HjBGIzbqJspSxjGyuCw7nOAY/BWhSFYlvFByTWhnNOBFTdyONWpxycfhwKkpblU
         rogyGg+iEOWjgKq5jiPEDIYcVHpcDKynVPCcycmkVk2S2VbcPrUOEGqPHwldxPMuL162
         fmo5LBlvHqVlkRJ/D2sQHl6s0mS+ao97oQ/cQf6oHT6pyRFK81azXqS+Ty6Jw850Qfr4
         0lJMr6uxxkZGNDS3HsLAoiWu5HmkUBMGZ6mkM/IMvZ1N3v5yo/IEgWDT7cXPosqw27z1
         skIxc4enCQsnBAbI/4558jm3gF5grF8DbbaLxpMCbAP99HG35VqD9CjErQiS3LhYVfjw
         Kt0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750264300; x=1750869100;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=B5w7DYHdWT8EU+RZTFYloguOUQOwV9lSiEShIXr1iM0=;
        b=AdxQzygL0U/JIwDgTB/cI1FTXqKUFCmuGfR5UgK7nD92GEmN9LXNvwddPP+GisOBSQ
         W2IfcugcTmBQa1P2Q+bPVjx+yORH3UPMNXhst6/51zvVCMIX7JwZ028ZB32FdNMuYnkd
         CCxZGQsrVquRXcKkJjC6PDy/zwWvEDd5iDP9knS57rpXAWT8g5xh2/kRdHIvNYWQ10YU
         1SqzhX0TORYJpceAdaTYoFGGmjGJkHabcMNDXLNSa4U/soUaROHhmM5Fk5cHOBX2urOT
         v+uHfI0fZWVErnr7VCPeL1y/VpbepvGQ7XGwuH1XmAh5O5gALDMDo+3fYOp54qCsToH2
         pWkA==
X-Gm-Message-State: AOJu0YwbdW/tI7Qgp/Ti0Uw8REQxW03tahfj0UnUbZMjzRdnpepb76ZR
	j+XaI7LCE30j0ZISv4IGUBTkXWwe9oJdGv46xUerGZniHmkvJVWmPbDGOBLgrA==
X-Gm-Gg: ASbGnctRmwB4IfIdEcrB7espnz0GgwW01D8787xQZq30K5GKiSP0h6PWvr6SYDtt9sQ
	hO2Jn0Q2a2f5e/Yq3TXdxLo4x+zXHrbNh9HCw2iaa8nwGE9n6251XS1DAVO+fCxYMDrzpe41CSP
	6fJ/P00Vp721OOm6wKNnrBQc/xjqWi6nFna5jAPfv3LKWTifs0MzDjKaCen37hX8JXco2whjc4z
	m+iDh9rKTXwdSbBtWr+NIxiw7VSCXS3adyFkq4Ihq6f8tS/sVE1qOL6HjRbacWjonzCIPqyVC/k
	+QfUJsCZYS084Wm4geJCVg+FmLBId2M1ZBsnbb3gY9nJuEYoVPA3JAYQiGsIxlVpsJGBTq7ouPh
	b61s3Cr7u9LwNsjMuxxw48BIDrFl2IiWYT3rx2pVHQZbeGulamSyv+vVF/HP6TSzeGiZ7k9zEAC
	4G0Lq4Fn5FFwg0bXeJZh25CEBSeQ==
X-Google-Smtp-Source: AGHT+IErJM44JdVK/ZhGG85RV5x0r/BYvw9901DdN1raE6/W6YyFjJWl8LLQuLWHsy6bbmiCirE91Q==
X-Received: by 2002:a05:620a:3916:b0:7d3:a7d9:1120 with SMTP id af79cd13be357-7d3f171a794mr26673485a.24.1750264300071;
        Wed, 18 Jun 2025 09:31:40 -0700 (PDT)
Received: from fuse-fed34-svr.evoforge.org (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7d3b8eac7d8sm776076685a.67.2025.06.18.09.31.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jun 2025 09:31:39 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: paul@paul-moore.com,
	omosnace@redhat.com,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH] tests/mac_admin: skip another test on nfs
Date: Wed, 18 Jun 2025 12:29:43 -0400
Message-ID: <20250618162942.124309-2-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Skip another test of undefined label handling that is not guaranteed to
work over labeled NFS and breaks if SELinux namespaces are enabled due
to the global SID table correctly preserving the undefined context value,
producing an error within NFSv4 for which no error handling path exists.
Possibly consider disabling this entire set of tests.

Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
 tests/mac_admin/test | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/tests/mac_admin/test b/tests/mac_admin/test
index c28a7bc..8ecb48b 100755
--- a/tests/mac_admin/test
+++ b/tests/mac_admin/test
@@ -11,7 +11,7 @@ BEGIN {
         plan tests => 8;
     }
     else {
-        plan tests => 7;
+        plan tests => 6;
     }
 }
 
@@ -49,12 +49,13 @@ if ( $isnfs ne "nfs" ) {
       `runcon -t test_mac_admin_t -- secon -t -f $basedir/test_dir 2>&1`;
     chomp($result);
     ok( $result, "UNDEFINED" );
-}
 
-# Verify that test_no_mac_admin_t sees the unlabeled context.
-$result = `runcon -t test_no_mac_admin_t -- secon -t -f $basedir/test_dir 2>&1`;
-chomp($result);
-ok( $result, "unlabeled_t" );
+    # Verify that test_no_mac_admin_t sees the unlabeled context.
+    $result =
+      `runcon -t test_no_mac_admin_t -- secon -t -f $basedir/test_dir 2>&1`;
+    chomp($result);
+    ok( $result, "unlabeled_t" );
+}
 
 # Delete the test directory
 system("rm -rf $basedir/test_dir");
-- 
2.49.0

