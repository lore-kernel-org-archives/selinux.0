Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57806346E71
	for <selinux@vger.kernel.org>; Thu,  9 Apr 2026 17:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775755801; cv=none; b=r14CYjmTvs7AtBB9JaM0fvmM3vSsXxqlyva/0ohmhlM6TThqf28qMCuqSQe7catzQASyHCFfFKY6s7XXStcik2InSd0b5qhQxGTXAA9iCWe19vby31QKWjWZxw3DfqhdiMWwFaliJsWALeWIPWTCgxOy72vYLkPwWuhG8F8mVTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775755801; c=relaxed/simple;
	bh=3XA1DaD6lisFkcrAhIUrQ/+kfOtbFJ3hMZ5DMkg8bos=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pktI7NcAnBFXA1DG7mL9xzxYyzdE0hHv/c8mr0CLWPW4F2WXFRZr2EfOso3sBFLLkuSRLyt1hIOMFPqHjK+sS44P/clKQTgPb4o1Wm0w3Sno1WaVUPghhcz0apzxAWJjc939FSf3lyVzTtCxEHU82huy0RSTQvHu9y1UA+bWQKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qUElqxJG; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qUElqxJG"
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-506aa685d62so6282251cf.0
        for <selinux@vger.kernel.org>; Thu, 09 Apr 2026 10:30:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775755799; x=1776360599; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LGA+nnGcu1N9MTm4UgpQsTtO+5MGpb0keUreVIHI+xo=;
        b=qUElqxJGQkCBwxY0YuHIZ6RvxCV7jBFKsBVVpyX9mGoeBfmiCr5lKVnCaDfAa/iQJc
         R9zgNm+kSG1Jb6A7FRsijJlTCMpJxJVh11lForvg4CowIVRLZ6luz9lNDvJH/YuXlTfb
         gfKY2vLTb4RR0PqJSxLvPLkpzj9FB0+gQwYji4eBcXIVdxVLa0jhE2jEHyhpjO91T4s7
         46fRP2MUVsZRs8GPLUgWwy1nv7nzAUlPmjFCJAjTXrjCZbevSCBSnwattzb6FBzvR8pi
         v9tMUFCg1yw8mCYFPZOEMcSyImpwG4rV5UgKT8d1NveD/upgEL+YETyyZDTa1VcNwiv4
         FGNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775755799; x=1776360599;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LGA+nnGcu1N9MTm4UgpQsTtO+5MGpb0keUreVIHI+xo=;
        b=q4L2HqOOBh1XvB1aDKf17524VNAc69JXi/8LykeTD4K2XV0wQyvfzY0u9tCVqyIFei
         YSwXyMcvV6QqevlKB2JOdyVOSHmxU8LZ/9fGKCT2sgGMza4RxtTHyAzw0PWm1D8gr1mh
         dhj+yTnZdBW7YDqlSNeauVh6mBNolxD4ghnlEQl92/x9QK/RHhEAVXtSHuUHVLvlT/rJ
         RzjJMf3eSB34jymsVd4cZNHMnMwBDluFZYt5YG4bYRNzQwXvFhpYoqOVXGqLMg0EJqdP
         wMHlqWR68DGlIcqTPEnrg6AuJzKOmDJSfC3z3qlue1J0VtysYDn6MyezCKL7IVZNlsp2
         s7iw==
X-Gm-Message-State: AOJu0Yxt2QB3yh3P3ZwlomcQCxl5LNmu+0//W5g1BfDibJ7mPDMRGCss
	yOYo6hWhn7Z8ElU6bvIPk90vuGT9WB235FE5KApA9X6cWaNWnK/KMZ+ieRqm7w==
X-Gm-Gg: AeBDievyO09nolKdnHRavywRV9h87RyyHmKK2NPyMuWnVJLKRF5k+BpdSH+/4nvY5CW
	rWj2AxoMfCsq+stKJ0YGXcTI0kGWo1p2tmLKiSDq3oZE5CJ06GOh/2dg6TSYwXuruMxd+2Depgl
	ynPqKStC3zF9C68GXwj6fg8xBAx0agJDKz1PaJevjrCD7EgTBYBolfzIIYByrYL+P0Qnadp5V+B
	bxVX4GY6TQ0SW2U8Jsi8Wj7qeTVjjs0xkRWlrBRIRSh3lgcAQR4tQ18jFlwhkoV98Was3SozmtV
	UqkwY90WUoUu0Jzb80dujOdLkDrZ98kOxXu3ZZMyil8PSJwlWc2zQYEL5t0VS8Ea13gHi+dqIra
	X2NCADV97dJDXjNWGYpQEK8tOOVJrI2MHVe1AEdeoayLoSk5tu7qm5OVdrGiWg7KngJKbQhgNOO
	4EMqR0t2lIwo3SFzplb61d54TNhojUR06tp8mN1xjbebEv+b6ft8h/y3moNnDSw+llXkiabSjht
	wWLPTFvJN+J+iowmV1yI89nrD/IrfQWHjqhBf7MOAdJZ5xZyYqpbHw=
X-Received: by 2002:a05:622a:3c8:b0:50b:4755:94b9 with SMTP id d75a77b69052e-50dd5c15d59mr1310911cf.56.1775755798890;
        Thu, 09 Apr 2026 10:29:58 -0700 (PDT)
Received: from fuse-fed34-svr.evoforge.org (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-50dd539b3f3sm1555141cf.2.2026.04.09.10.29.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Apr 2026 10:29:58 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: paul@paul-moore.com,
	omosnace@redhat.com,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH v2 testsuite] rename: explicitly test directory write checks
Date: Thu,  9 Apr 2026 13:29:35 -0400
Message-ID: <20260409172934.2543-2-stephen.smalley.work@gmail.com>
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
https://lore.kernel.org/selinux/20260409164903.19584-2-stephen.smalley.work@gmail.com/

Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
 policy/test_rename.te | 22 ++++++++++++++++++++++
 tests/rename/test     | 14 ++++++++++++++
 2 files changed, 36 insertions(+)

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
index 2001f16..8d069c6 100755
--- a/tests/rename/test
+++ b/tests/rename/test
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

