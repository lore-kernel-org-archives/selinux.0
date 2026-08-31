Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DB0F3B42C6
	for <selinux@vger.kernel.org>; Mon, 31 Aug 2026 12:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788179974; cv=none; b=VjeADGp7ujN+Uy7acY6U03wlyjamMntH7u54ISttIqx20A+0mLTz+tbV8ESVzdP+VT6eqtnU+TKJz5RWnZfnE/jyzEQy9kV5kXFnw/Hht+F+lWHZpJcNdmXxL+BfsWyuBpBqt+R0Gd8UdzE4Fn1myB7ICK+jkjQBTVG6lNlGeK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788179974; c=relaxed/simple;
	bh=9vJHpWrbHVKV1WRj84JckTgySZEYU2bol/pyuU8Fqbc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lbeEwr3/jb2KFN1ArmsZa3F4Rwkwr40GNo9pDLVJfysph2E0CqAjwUxdA0FHs/sl00PpICXpTuOtf8Wm62kQ5JJAkO6xCBpbGQn0WE4y785pcA16+7+jrykTLyU5suDmUJ6wxwfhQ8rSE9e/yUmDzaS7t3aLnn6fMGrBA8PqQmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k3dgcgyB; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k3dgcgyB"
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-90c776f6c13so40362916d6.1
        for <selinux@vger.kernel.org>; Mon, 31 Aug 2026 05:39:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788179972; x=1788784772; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=f39WrgoAthcQ9xqZ8wovi2dDNIBGZT5iAVeSZ0DqUbg=;
        b=k3dgcgyBX3Kb8FEfKnATOPKJzG7xKIbrNIWwOp6fT8iy1t58vjGJQORi+7GJiRKWzx
         13zoObW88vuIKclvvK+EsvxYU4/x1zk3G7YW5cWjPfuMW2ezzrgGl0V2/pqJi7DdGBfH
         M3W1vkyv87abtUr07DjitDQnE618G96zWn8kHdkutMiSxnBB4lA/TMwIqlYNyETw88Iu
         v6ZHlsN4NKBdIeohwzgfLqFYwzlvOyzJJIJyQZ2OmdWxewTZPy3oSvj9GGyjUsCvLI8t
         VQjd+OCmLi4WLuFBQ4uAylHRBKOCiUiDoteDKzugdDYzc2+F4y/8Wgui4JziNRy3zI1u
         ZiXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788179972; x=1788784772;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=f39WrgoAthcQ9xqZ8wovi2dDNIBGZT5iAVeSZ0DqUbg=;
        b=EzOVJqSuy6ksz56S6hyeQ+ifze6oI4imc/WFMPC/0fVc06R2J9M+FCpHUjGnT3gDDE
         Eg/IsVL4dRAl13gqWvEAFKtfqjUs0PGAlYGui/GkGaqQsJv64eee/Tle8zFa4tqHsL9C
         5LUf6aWcXy7qJUdhcXe05J5nUcoycOCXVbQpZVtFGoHH/SFY7Mrt+RUTAa13jobAKYhu
         b3Qa4EmrCcbOTDfE1m9vcowGJSkWTWYTkWMHGNrl9b5KsR1zrPtK+wmH9oNA9dKa3ROQ
         Kx3bVaqogBKo2yb/Vvyd+x9oPNUJ3i8uWNOP2BfdajbfHzCzGKRAFpDXsnmDr6Q8oCZv
         wJhw==
X-Gm-Message-State: AFuF++kwB1xoy0j4uv3SkMbpordM9xWie6lS0/sb8nPh366e4X3QiVFQ
	KyDqHx1AEHjDSrIQ2cwf2uLjfZn3FBtvG2Kra5BoBMfCppC6FvEQLlLGBKbpdQ==
X-Gm-Gg: AYBFou2AqMJkQ+2BofdPgDdOYjQRfNKq66iRdHl/hvMtC590SSfebbZpgfWW4212ixG
	0orGUR2uU6rwnpojtATxfXxfouYMfd0Y200AeoxtZ9l31cjc0X6QRo8NDwXe/YDgIIzc2Qoke23
	C54E+3osw9sNXKtzJTtHMPDNkuqDEh041O1X8Oh1ZIXosmpzVghOa/x/BNpQ4+KTVv/frD5TOy+
	XzQ6YM7c19uV7QOhCfD6zPlAs4EbrrdeHTRrRuFh06OEtzlMcIGg3x2N3xlFibFDXasa+gqKpsE
	V4rf+fYAvMGwwaT2N43aQq3CNFYwcd55PhPfPPyEc0gmwUl+hFPSmSNSUUjl/ETI4V67V/7CyPH
	A1mAQfrdruts293vvOCR0SuelvcmF/5aZgRq6hzeSh5YgNjttrfx8/fKA7bXcNkbCPwGAWwpGpl
	WB1PTUeIHMSMi6ktmsevfULljWJ0bajnu7DhTmnh9hMNuoJCB03NmfEKqZQkZ2SQOG74XMaIzXY
	Eebjx6VA8LG8oFDiniL1Rh4kW2/ZgX/D1oU4inOMwdtR4eLSrufY0r8rvMwZcHa8GtYXohVFis=
X-Received: by 2002:a05:6214:5505:b0:90e:8d34:7bd7 with SMTP id 6a1803df08f44-90e8d347d0amr60088586d6.10.1788179971861;
        Mon, 31 Aug 2026 05:39:31 -0700 (PDT)
Received: from fedora (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-90ce44f592csm83138796d6.32.2026.08.31.05.39.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2026 05:39:31 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: jwcart2@gmail.com,
	plautrba@redhat.com,
	omosnace@redhat.com,
	jason@perfinion.com,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH] libsepol: do not reject control characters in pathnames
Date: Mon, 31 Aug 2026 08:39:02 -0400
Message-ID: <20260831123902.3938-1-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Pathnames can in fact include control characters and checkpolicy
accepts them so we should not reject them in policydb_validate().

Fixes: https://issues.oss-fuzz.com/issues/554550509
Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
 libsepol/src/policydb_validate.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/libsepol/src/policydb_validate.c b/libsepol/src/policydb_validate.c
index 99d27f88..5a7ee2a3 100644
--- a/libsepol/src/policydb_validate.c
+++ b/libsepol/src/policydb_validate.c
@@ -1478,8 +1478,6 @@ static int validate_filename_trans(hashtab_key_t k, hashtab_datum_t d,
 		goto bad;
 	if (validate_value(ftk->tclass, &flavors[SYM_CLASSES]))
 		goto bad;
-	if (validate_string_field(ftk->name))
-		goto bad;
 	if (!ftd)
 		goto bad;
 	for (; ftd; ftd = ftd->next) {
@@ -1635,8 +1633,6 @@ static int validate_genfs(sepol_handle_t *handle, const policydb_t *p,
 			    validate_value(octx->v.sclass,
 					   &flavors[SYM_CLASSES]))
 				goto bad;
-			if (validate_string_field(octx->u.name))
-				goto bad;
 		}
 
 		if (validate_string_field(genfs->fstype))
@@ -1806,8 +1802,6 @@ validate_filename_trans_rules(sepol_handle_t *handle,
 			goto bad;
 		if (validate_simpletype(filename_trans->otype, p, flavors))
 			goto bad;
-		if (validate_string_field(filename_trans->name))
-			goto bad;
 
 		/* currently only the RULE_SELF flag can be set */
 		switch (filename_trans->flags) {
-- 
2.55.0

