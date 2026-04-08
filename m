Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FD0E38F94A
	for <selinux@vger.kernel.org>; Wed,  8 Apr 2026 20:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775679782; cv=none; b=koUyAbMLXkQcHANqdUfrj6XUY7VNfwzBby94doalbJTdx89/UEij+sccoyC5YeJr1Bkm6tj6E4qjKIK4z8bJQOjdHF46Y0i9QDHEo+Ii8QxynGRIP+WkdOZYkPIRpFyxkmH6CQyfUIfJ+ufPbpBx6zrENkzr2S+fw32RbVbGsFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775679782; c=relaxed/simple;
	bh=zH+750UCTw5Sk+5/9IeJsmlho/AP3YTPUl3ugzzcwI0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UR7uvqYDu89E6x52QD8iECcEwRCJzz7R0TqsTJhEgGXMFlfS5pGvWkyPc3Zz7m3gir0H6SVL7lbp+f83HxGM/cqiW+y21xr9M+VNrz0II2PWiyETDKZXS2HnDGSeQrUcveZg/xsxiqjca7fxptUMna2USceofdhM2KFG1FhiyYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IimsxKUJ; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IimsxKUJ"
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-8a00566c11bso2132166d6.2
        for <selinux@vger.kernel.org>; Wed, 08 Apr 2026 13:23:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775679779; x=1776284579; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=goChYZrT+p9dB9akj+uJa+BCXnatXKHq+bAWFgK0NvQ=;
        b=IimsxKUJ+qheiAXafkB/Zdqef0JiNu1LFCjP1fnC/qY0qMhR4wH5yc2bYQpdOdM7cy
         DNVrdNw+bK43t4BZkMv94coc5ceGdAM4wQ3F9LP5oA3VUv94PigPI8ymcXHCzX3baeT/
         LDT2+tj2980WxXfj1uhBgdsqPmlkB7BKz04Na1Mq4hwKgBWJiqJVE40MSqGFPIEL5XXM
         J03L1AbugoYCJz5CiA6J4L/CcvEPoQ5iz+UYwZTU5EHienl9pKgC3CVbtk6VO1xVC0mK
         /ZOBKv6fRyzeVmKfqSPVfZjw5GjLo6f4+LOrM8UTrmTR7MsLvDQxnZTa79Pk97xcxs6m
         aO+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775679779; x=1776284579;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=goChYZrT+p9dB9akj+uJa+BCXnatXKHq+bAWFgK0NvQ=;
        b=DX9yMW5uIOsrzzbf606fNkSt9IaXX1tCXuBkgyvamDfzpLnedoGC60vCRP4JkoHQMB
         x91dfPrKpHL3rSzTEc00Sfr2rC4P9hxdFoF4PMCtz14i2rpUtO8oFqUyBjteyX3DVmsx
         H0kDiThKaP97+lTErbaIuOLty4ATJHfo4fNR36aCWLrMRPVftoZp9c4/Hpfm4UOERLzH
         asRNl14gTS0CephSBV2Hi+CWLngUkYW6ag+9cKv7yJELj+PLvfMx+EHb06aM8NZCqw4E
         fCniqIX8C4/lH12fVF006O3mPvw0Oe4VzNhC+4yi9JLLREecusr4tQxshsfMJejmflRV
         T1Ng==
X-Gm-Message-State: AOJu0Yz5e/EasHLFyA0O9tCKQ1QQiaaC3GnFFdIYiwUo6C3oZQG7W9yr
	U/iF1MkHSZE7exIObcbgGgqU5AOPUcNB9BtaiBNxpqUWpEnfkajlVthm02vW8g==
X-Gm-Gg: AeBDiet7WEu3f+RkzZCGUFKvdNUs4hJxl9rwnrysjFzgM2gHvgxVf9wPJ9wTpJP3l+e
	nDvfwgBd20KmnEvceQW+8JJ/ytkQwt0nOPp3Hi4rgw2Y/fAX4DQ4BqfZfNQQJrDd8hzYe2PSaPC
	rWVDQT01x/YmHxwbz6qKqRUCzVKd+VJYLq6VnLtL1RCvv1yrVHSjdaViAo5qfVmiqIlAD0v41UM
	teukTMaSk7ul97+01gV2cgY7JB1r8kCMgrFpDzw+oI6IRwalu96QCkmjM7FZFnWtq0ABur+Fj1H
	p5T7C6PiXyMpoOuWyXF9tQa3H/5GWlrC6nmcTLXgbtiVRnK3YB5HP6ssnI1dGfKrtaLIazthNV9
	BN5HlBpw/yATbuaJe3RbqzdWqu80RyopIlpgtnM+9TvU8QWjXJIazugWwjoxvW6OEieawwtxGqh
	tLA75+uAQGiJPjY2s4N9UJ1+EIgINm0PzFtPYwP5NJcvU2yk8xU66Munm/7EL8gEzVghjLuy9eM
	MdWbKKog/e7T5IyQh+9/7DnG1ozwUFUdMoOlufrmjZv5MpzUZs0h2M=
X-Received: by 2002:a05:622a:590:b0:50d:8293:c53b with SMTP id d75a77b69052e-50dc2332e0amr12891981cf.61.1775679779341;
        Wed, 08 Apr 2026 13:22:59 -0700 (PDT)
Received: from fuse-fed34-svr.evoforge.org (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-50d4b1a739dsm169203691cf.1.2026.04.08.13.22.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Apr 2026 13:22:58 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: paul@paul-moore.com,
	omosnace@redhat.com,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH testsuite] rename: explicitly test directory write checks
Date: Wed,  8 Apr 2026 16:22:16 -0400
Message-ID: <20260408202215.2723-2-stephen.smalley.work@gmail.com>
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

Then run ausearch -m AVC -ts recent -i and look at the last few audit
messages.

Expected:
avc:  denied  { write } for  pid=2275 comm=mv name=src_dir dev="dm-0" ino=369112042 scontext=unconfined_u:unconfined_r:test_norename7_t:s0-s0:c0.c1023 tcontext=unconfined_u:object_r:test_rename_src_dir_t:s0 tclass=dir permissive=0

avc:  denied  { write } for  pid=2276 comm=mv name=dst_dir dev="dm-0" ino=377910481 scontext=unconfined_u:unconfined_r:test_norename8_t:s0-s0:c0.c1023 tcontext=unconfined_u:object_r:test_rename_dst_dir_t:s0 tclass=dir permissive=0

This highlights the difference in behavior before and after:
https://lore.kernel.org/selinux/CAEjxPJ6S2QFWogwMB7itdLzFdesqygNK+Hz2PUvDB1Sj7JnPjQ@mail.gmail.com/

Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
 policy/test_rename.te | 20 ++++++++++++++++++++
 tests/rename/test     | 14 ++++++++++++++
 2 files changed, 34 insertions(+)

diff --git a/policy/test_rename.te b/policy/test_rename.te
index 0b9a839..6314930 100644
--- a/policy/test_rename.te
+++ b/policy/test_rename.te
@@ -92,3 +92,23 @@ typeattribute test_norename6_t test_rename_domain;
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

