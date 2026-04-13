Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E50634753F
	for <selinux@vger.kernel.org>; Mon, 13 Apr 2026 17:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776103148; cv=none; b=Ik8+bHhZQPt0H4wfrh9sUBzJI5hgVMwghDTHoMY0qcK5Fbh0PQzShMBRA38ZaOoiQbbPgdpeFAu3BnSGPHnsd0t2n8LuqO58u9JyN9IJwpXYkbqyMOqAwwlG9nHALCEaowL7MgLspu0/M0Ihqaz3tBmfQwPSYKJmNi1MDYuU15s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776103148; c=relaxed/simple;
	bh=DDz2hp9JhTw5/eayfY/rj/tNZviyvtdRmd8JQY744x8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ft0BGvL2wTB4qxykMzwPMnhI33N0kRvYkGaaJESZ/taQ7TnGltVkR78SPlPNX81OgpB6AQXlxsjquUgQKzlw4nCrLCJB3X95Yi/cRd1DYspiYy5CZJ/x0zjolEbOnGHrVV30g2IJGPMyGnQTBWAm5WXLxFwsKzwYPCxbLksLDLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mW+5kqP4; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mW+5kqP4"
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-50d6b9bca48so61193951cf.2
        for <selinux@vger.kernel.org>; Mon, 13 Apr 2026 10:59:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776103146; x=1776707946; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=c6R+Ft6jguwNYByTk7Zf2ryFb/GSd7ACQ00LgPtJrLc=;
        b=mW+5kqP4K/3FJTcFS67VsB/7BzDKhwdH4MLd1AKn7m0aXFHhI59ynnP0I1enD4XUjt
         fLUsrZMd0rwInRhYlFxlt4WgkXAsr9LCD9XFiJU9Jr4ujq2/5Z+YyyCOhosJpoYca3xD
         cVbC8QBJGpGcZmKvfjL8dU0Kz/gABUDU8yL50jB++q/AYSw0YdoE3NUTXXT7+oaFsI0b
         EercETdwPjoanz1lnqOgBevbnIIAZpgvc7/GDmk+XNlpffBuoRtvPDzjPmANe3JdCR5r
         UA2+K1bZgTbUJ4ZH0m/kRcju7o6jnr5xhIEnpCw6xethrXmem4/f5ud4URfdrVFd3LqB
         3JBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776103146; x=1776707946;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c6R+Ft6jguwNYByTk7Zf2ryFb/GSd7ACQ00LgPtJrLc=;
        b=GIgc8byxvodyBXI4+5AN2PFByPj7s1m6pg1b0YowsZiyTULtoIBDFg2BstWbqyZ+9z
         S3yrRYomBL8ZAbdVsq1tsyebBLZaDJerEZE8qC9sYZ3mdvHu/OgqYJkhGDUuSyRsm/zN
         Zzoy8IwvZhhP1yeY2QtNQJaKZqnC3wkVFvdb+cuPonfyd4CbS5saquRc5Qv4ei+MkGnB
         FVNSidosdgYKMcCihn/nrcub6uuDa2irttMV8fN1FWqK/glnZQ01yBHmRN9qQVemA1xA
         VPhbRDZ2aDlf96rwjSvTMHxezAUhNmiYtG2efI9gAu78nCnd0VLtJvQwdjFpvLGV/TiL
         6MZw==
X-Gm-Message-State: AOJu0Yxc9XuSpCCQdO64VOghCMiJrPdWE3K7c/TmrmYMjk9PMH20E985
	gc0daGvmOqviTs4jExTAcJJ+piHY546WNPN7u/4iN++Ps6ps5BllRV8SEdLy2A==
X-Gm-Gg: AeBDietMr72xdV8tpPI9vFQtcjODBtGgbl9kbh+mLhig74aEi0ehzLtkL03D0B7JTZ9
	H4WA563yBApnQRHqGtdQJUxs/2HQeOTymMSyEuSRY9D4s7ZG3y1ibzar3zqalCOJkWSIhjpZrXR
	vDo8jjIJahwedG6QT1pQlsPgq+FkidIZe7RFAVhk1HQ9GsdwX66moCoSngtbYWqJiWuz6xbHQdH
	ZBjKpKPuWDX8dJ5PNfTlxOkor/0NLze8ICworhoa12CPnQW2McdAlGgIQl2YBvb9N2DAj3TD2ka
	2nstehNqHh0FsvBEfD+DStHS/1H/G4nMTnLCyam61GcYtqZoQ+eRvkdZGrIUlKD42KiynYE+3Pn
	r7uG7d3q6025YNl56MblG07w1LTo+QDpnbfREnEXxAyjInrWR+8s6gLSg388Ev94858vCmW4U+o
	6kpKUyJLQ231NxhbJiYr2vI/w2E76/k9Ta4Y7VRPllYUm2mkEYRBd54oekgXVV+h+6/6LIK4Apr
	Wutwajt1IgtCAbXyNthqXvrW3n4ebvFRV3FtBPiDtw9YZQtY7gYVio=
X-Received: by 2002:ac8:5c90:0:b0:50b:501e:152f with SMTP id d75a77b69052e-50dd5d5a613mr243699421cf.59.1776103145767;
        Mon, 13 Apr 2026 10:59:05 -0700 (PDT)
Received: from fuse-fed34-svr.evoforge.org (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-50dd561a34asm93588441cf.26.2026.04.13.10.59.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Apr 2026 10:59:05 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: paul@paul-moore.com,
	omosnace@redhat.com,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH testsuite v3] rename: explicitly test directory write checks
Date: Mon, 13 Apr 2026 13:57:36 -0400
Message-ID: <20260413175736.66018-2-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

After applying this change:
      make -C policy load
      ./tests/rename/test

Then run ausearch -m AVC -ts recent -i and look at the recent audit
messages.

Expected:
avc:  granted  { write } for  pid=2456 comm="mv" name="dst_dir" dev="dm-0" ino=478160604 scontext=unconfined_u:unconfined_r:test_rename_t:s0-s0:c0.c1023 tcontext=unconfined_u:object_r:test_rename_dst_dir_t:s0 tclass=dir

avc:  granted  { write } for  pid=2456 comm="mv" name="src_dir" dev="dm-0" ino=469853139 scontext=unconfined_u:unconfined_r:test_rename_t:s0-s0:c0.c1023 tcontext=unconfined_u:object_r:test_rename_src_dir_t:s0 tclass=dir

...

avc:  denied  { write } for  pid=2275 comm=mv name=src_dir dev="dm-0" ino=369112042 scontext=unconfined_u:unconfined_r:test_norename7_t:s0-s0:c0.c1023 tcontext=unconfined_u:object_r:test_rename_src_dir_t:s0 tclass=dir permissive=0

avc:  denied  { write } for  pid=2276 comm=mv name=dst_dir dev="dm-0" ino=377910481 scontext=unconfined_u:unconfined_r:test_norename8_t:s0-s0:c0.c1023 tcontext=unconfined_u:object_r:test_rename_dst_dir_t:s0 tclass=dir permissive=0

This highlights the difference in behavior before and after:
https://patchwork.kernel.org/project/selinux/patch/20260410192949.16542-2-stephen.smalley.work@gmail.com/

Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
 policy/test_rename.te | 22 ++++++++++++++++++++++
 tests/rename/test     | 16 +++++++++++++++-
 2 files changed, 37 insertions(+), 1 deletion(-)

diff --git a/policy/test_rename.te b/policy/test_rename.te
index 0b9a839..72a36a7 100644
--- a/policy/test_rename.te
+++ b/policy/test_rename.te
@@ -25,6 +25,8 @@ allow test_rename_t test_rename_src_dir_t:dir { search getattr write remove_name
 allow test_rename_t test_rename_dst_dir_t:dir { search getattr write add_name };
 allow test_rename_t test_rename_file_t:file { getattr rename };
 allow test_rename_t test_rename_dir_t:dir { getattr rename write reparent };
+auditallow test_rename_t test_rename_src_dir_t:dir write;
+auditallow test_rename_t test_rename_dst_dir_t:dir write;
 
 # Domain for process that can rename the test file over an existing file.
 type test_rename2_t;
@@ -92,3 +94,23 @@ typeattribute test_norename6_t test_rename_domain;
 allow test_norename6_t test_rename_src_dir_t:dir { search getattr write remove_name };
 allow test_norename6_t test_rename_dst_dir_t:dir { search getattr write add_name };
 allow test_norename6_t test_rename_dir_t:dir { getattr rename write };
+
+# Domain for process that cannot rename the test file, because
+# it lacks write permission to the src_dir.
+type test_norename7_t;
+testsuite_domain_type(test_norename7_t)
+typeattribute test_norename7_t test_rename_domain;
+allow test_norename7_t test_rename_src_dir_t:dir { search getattr remove_name };
+allow test_norename7_t test_rename_dst_dir_t:dir { search getattr write add_name };
+allow test_norename7_t test_rename_dir_t:dir { getattr search };
+allow test_norename7_t test_rename_file_t:file { getattr rename };
+
+# Domain for process that cannot rename the test file, because
+# it lacks write permission to the dst_dir.
+type test_norename8_t;
+testsuite_domain_type(test_norename8_t)
+typeattribute test_norename8_t test_rename_domain;
+allow test_norename8_t test_rename_src_dir_t:dir { search getattr write remove_name };
+allow test_norename8_t test_rename_dst_dir_t:dir { search getattr add_name };
+allow test_norename8_t test_rename_dir_t:dir { getattr search };
+allow test_norename8_t test_rename_file_t:file { getattr rename };
diff --git a/tests/rename/test b/tests/rename/test
index 2001f16..195d51d 100755
--- a/tests/rename/test
+++ b/tests/rename/test
@@ -1,7 +1,7 @@
 #!/usr/bin/perl
 
 use Test;
-BEGIN { plan tests => 9 }
+BEGIN { plan tests => 11 }
 
 $basedir = $0;
 $basedir =~ s|(.*)/[^/]*|$1|;
@@ -101,6 +101,20 @@ $result = system(
 );
 ok($result);
 
+# Verify that test_norename7_t cannot rename the test dir.
+# Should fail on the write check to src_dir.
+$result = system(
+"runcon -t test_norename7_t mv $basedir/src_dir/test_dir $basedir/dst_dir 2>&1"
+);
+ok($result);
+
+# Verify that test_norename8_t cannot rename the test dir.
+# Should fail on the write check to dst_dir.
+$result = system(
+"runcon -t test_norename8_t mv $basedir/src_dir/test_dir $basedir/dst_dir 2>&1"
+);
+ok($result);
+
 # Cleanup.
 system("rm -rf $basedir/src_dir $basedir/dst_dir");
 
-- 
2.53.0

