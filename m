Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A7ED4CA287
	for <selinux@vger.kernel.org>; Thu, 22 Jan 2026 16:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769097993; cv=none; b=JoNTZNOO1buqirvZJd4y/AhjVzQPiYZtyA3DxrzqQk7cpym73ipi9AH9Zia+nQyM0U4dSoKtCXTxZRXSFnPm7Ztgk1zDLu6FvdrJ5cAYfC2oREXlBVqS3wWq4jNYlK8DuuS5ln/PD1T8Tpe+DAQp3skbsyYKH67Fhk83xodJfZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769097993; c=relaxed/simple;
	bh=OhD6AgnFZsUy1EvUAhFk1NVGcEJr8+xUWFiooq5FhUM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FYHyT5BFAs8JPMTpEn9D2opx7dtikQz9v6ljVp4G4EQVuD5NnItbhBPLH9+kU1nVmYDIG6m68lVHMnlYvBchHgCcCU6VkD1rhcB99Wepf4EtzQEdBv1CDoRI1WnVfdlKMCIK2fc/Ui/1eT5fx7ackHlWmQmK6uZDLu6B+p3a9Ks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gf6351w4; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gf6351w4"
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-8c655e0ee70so140511085a.3
        for <selinux@vger.kernel.org>; Thu, 22 Jan 2026 08:06:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769097974; x=1769702774; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=c7pyZN2ZhqqDo1rpGZwSk2R0xhAoJshXr9Oe+QgJhMQ=;
        b=gf6351w4JGhdnS9pc+hGOrgut/goxWZgH4/hR9ZwJ9UR/nvNTqNcmqthkB92m2fNoW
         /Fi0VhaEsCQszehU0uZkBK4Qn1g+CmJExdWU1ypRt7sP9Bn2JSL5/H1kshCkh6rpwp5v
         kyZHhZWdB9qHS0jJdUxgYjqqzbOhlfe4/DShHWj4xPt/KgAgJNerh1T8tKUF9IsYmeFl
         mKndfphnUWJh7kJKR7GcNWcYUEYMWODIK5fC1ajeph0zuakmqDpsy1TaWrBTUg1lMO/X
         LUeIZ/pjKI8lprlJNl0D12jH8RxevMEV92ZtkkV4M4GUZDqACpVFCQbh6Zw6WuIXhC3T
         Z9uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769097974; x=1769702774;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c7pyZN2ZhqqDo1rpGZwSk2R0xhAoJshXr9Oe+QgJhMQ=;
        b=CsueWHzcgvZrwpqY6iWNF2Lr1+btPKzJC+0+zTmR2aLH5WIfDtnfsxOoM1sU0VKy1C
         NBgQeFzEwWC0KkdQVpzMgVPvjhTBi7BqEov3zck7zQAg4UsnCHfLXYhN4/VVedJUvTJ/
         B8mKBPAzS35VVAM+Vu83uwutHwBpMd2pp/VRaK0vEmopWJdzkekgbzS9C+qKZ9+kwO9T
         VejrXFdNCakP8G4SN2t0Esm3oesh0GYMD7aZ2/S2N9d546Q3P/GG2lm8k3kbf3vxKIQD
         HJaKoAzsc9ffXDGLAIen8/CYCFm1oxb6yhM3rrmfMlSv8T2X9lJVloFzbpRYi1gnWdy5
         zKkg==
X-Gm-Message-State: AOJu0YwgzMnvIKdcOh5605m7p4s0RsGVsemDaHJN16m6vgctcXtzn6Wu
	/sQTd6+irMTj6tfoRTtCFcI8Jbtm4zHBF36lRcyuK/2+Y473bwpQUKPwLif6Xw==
X-Gm-Gg: AZuq6aJvMoF+q0COrK66ofqLbH115zAosd/Olzzqpsdel2l7/Mr4G/rYiq6Gca73YON
	BOhL2LQXdys0LLe05d7A1YN1KnXPWp5OSUpUL3yiRjMsiJq94rSBB/8sUE+ZVv5V7UXbFdTjgIO
	fO9Jzl7K33OuXtlqxkVTWN2IeopTuozyE0dCL5vVRubbsgyahA9+XPmFBD3pRC2SENKm7Qe4SE4
	xr1E9GdtsAIzDsS7qsP/zrhAF2NJfBDnrWDml/JjYvDuZzGxa8K4+jqI0Aoip3Y30USCTeBqGnR
	HfgifkMgl1aChD48H967J4DLf7IgF24memlPpu4QKxiG1tNiNF7Zzvg4QkuQpg7J6fNl1FYEo1q
	wB6lRkok8IQgCuGx1Hlbk0rKj59DLDlzHzh6g0mNdbbWQhKeelDoIQ56UUdy+7Sj0y/vP37dIu/
	+BL2/FY7tSDtpv+Bezleo=
X-Received: by 2002:a05:620a:469f:b0:8b3:19dd:46ea with SMTP id af79cd13be357-8c6cce508e4mr1198988185a.72.1769097974371;
        Thu, 22 Jan 2026 08:06:14 -0800 (PST)
Received: from fedora ([144.51.8.27])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8c6a725e897sm1562127385a.38.2026.01.22.08.06.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jan 2026 08:06:13 -0800 (PST)
From: James Carter <jwcart2@gmail.com>
To: selinux@vger.kernel.org
Cc: James Carter <jwcart2@gmail.com>
Subject: [PATCH 1/3] libsepol: Tighten checks on MLS range and level when validating
Date: Thu, 22 Jan 2026 11:06:00 -0500
Message-ID: <20260122160602.65567-1-jwcart2@gmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Because of various corner cases, the checks for MLS semantic
levels and ranges and the checks for MLS levels and ranges do not
give an error when the value for the sensitivity is 0 (which occurs
because it has not been set).

The corner cases only apply to users and, even then, not to all
policy types, so user's MLS portions are not being checked as
strictly as possible. Range transitions are also not getting checked
as strictly as they could be either.

For user datums:
- Only check the MLS portions for MLS policies.
- Do not allow unset sensitivities in semantic levels and ranges for
a modular policy.
- Do not allow unset sensitivities in levels and ranges for a
kernel policy.

For range transitions:
- Never allow unset sensitivities.

Reported-by: oss-fuzz (issues 471456886 and 471525113)
Signed-off-by: James Carter <jwcart2@gmail.com>
---
 libsepol/src/policydb_validate.c | 50 +++++++++++++++++---------------
 1 file changed, 27 insertions(+), 23 deletions(-)

diff --git a/libsepol/src/policydb_validate.c b/libsepol/src/policydb_validate.c
index 5afbfa49..9ee71bf2 100644
--- a/libsepol/src/policydb_validate.c
+++ b/libsepol/src/policydb_validate.c
@@ -661,9 +661,9 @@ bad:
 	return -1;
 }
 
-static int validate_mls_semantic_level(const mls_semantic_level_t *level, const validate_t *sens, const validate_t *cats)
+static int validate_mls_semantic_level(const mls_semantic_level_t *level, const validate_t *sens, const validate_t *cats, int allow_unset)
 {
-	if (level->sens == 0)
+	if (allow_unset && level->sens == 0)
 		return 0;
 	if (validate_value(level->sens, sens))
 		goto bad;
@@ -676,11 +676,11 @@ bad:
 	return -1;
 }
 
-static int validate_mls_semantic_range(const mls_semantic_range_t *range, const validate_t *sens, const validate_t *cats)
+static int validate_mls_semantic_range(const mls_semantic_range_t *range, const validate_t *sens, const validate_t *cats, int allow_unset)
 {
-	if (validate_mls_semantic_level(&range->level[0], sens, cats))
+	if (validate_mls_semantic_level(&range->level[0], sens, cats, allow_unset))
 		goto bad;
-	if (validate_mls_semantic_level(&range->level[1], sens, cats))
+	if (validate_mls_semantic_level(&range->level[1], sens, cats, allow_unset))
 		goto bad;
 
 	return 0;
@@ -689,9 +689,9 @@ bad:
 	return -1;
 }
 
-static int validate_mls_level(const mls_level_t *level, const validate_t *sens, const validate_t *cats)
+static int validate_mls_level(const mls_level_t *level, const validate_t *sens, const validate_t *cats, int allow_unset)
 {
-	if (level->sens == 0)
+	if (allow_unset && level->sens == 0)
 		return 0;
 	if (validate_value(level->sens, sens))
 		goto bad;
@@ -712,7 +712,7 @@ static int validate_level_datum(sepol_handle_t *handle, const level_datum_t *lev
 	if (level->level->sens == 0)
 		goto bad;
 
-	if (validate_mls_level(level->level, &flavors[SYM_LEVELS], &flavors[SYM_CATS]))
+	if (validate_mls_level(level->level, &flavors[SYM_LEVELS], &flavors[SYM_CATS], 0))
 		goto bad;
 
 	if (level->isalias) {
@@ -740,11 +740,11 @@ static int validate_level_datum_wrapper(__attribute__ ((unused)) hashtab_key_t k
 	return validate_level_datum(margs->handle, d, margs->flavors, margs->policy);
 }
 
-static int validate_mls_range(const mls_range_t *range, const validate_t *sens, const validate_t *cats)
+static int validate_mls_range(const mls_range_t *range, const validate_t *sens, const validate_t *cats, int allow_unset)
 {
-	if (validate_mls_level(&range->level[0], sens, cats))
+	if (validate_mls_level(&range->level[0], sens, cats, allow_unset))
 		goto bad;
-	if (validate_mls_level(&range->level[1], sens, cats))
+	if (validate_mls_level(&range->level[1], sens, cats, allow_unset))
 		goto bad;
 
 	return 0;
@@ -759,14 +759,19 @@ static int validate_user_datum(sepol_handle_t *handle, const user_datum_t *user,
 		goto bad;
 	if (validate_role_set(&user->roles, &flavors[SYM_ROLES]))
 		goto bad;
-	if (validate_mls_semantic_range(&user->range, &flavors[SYM_LEVELS], &flavors[SYM_CATS]))
-		goto bad;
-	if (validate_mls_semantic_level(&user->dfltlevel, &flavors[SYM_LEVELS], &flavors[SYM_CATS]))
-		goto bad;
-	if (p->mls && p->policy_type != POLICY_MOD && validate_mls_range(&user->exp_range, &flavors[SYM_LEVELS], &flavors[SYM_CATS]))
-		goto bad;
-	if (p->mls && p->policy_type != POLICY_MOD && validate_mls_level(&user->exp_dfltlevel, &flavors[SYM_LEVELS], &flavors[SYM_CATS]))
-		goto bad;
+	if (p->mls) {
+		int allow_unset = (p->policy_type != POLICY_MOD);
+		if (validate_mls_semantic_range(&user->range, &flavors[SYM_LEVELS], &flavors[SYM_CATS], allow_unset))
+			goto bad;
+		if (validate_mls_semantic_level(&user->dfltlevel, &flavors[SYM_LEVELS], &flavors[SYM_CATS], allow_unset))
+			goto bad;
+
+		allow_unset = (p->policy_type != POLICY_KERN);
+		if (validate_mls_range(&user->exp_range, &flavors[SYM_LEVELS], &flavors[SYM_CATS], allow_unset))
+			goto bad;
+		if (validate_mls_level(&user->exp_dfltlevel, &flavors[SYM_LEVELS], &flavors[SYM_CATS], allow_unset))
+			goto bad;
+	}
 	if (user->bounds && validate_value(user->bounds, &flavors[SYM_USERS]))
 		goto bad;
 
@@ -1323,7 +1328,7 @@ static int validate_context(const context_struct_t *con, validate_t flavors[], i
 		return -1;
 	if (validate_value(con->type, &flavors[SYM_TYPES]))
 		return -1;
-	if (mls && validate_mls_range(&con->range, &flavors[SYM_LEVELS], &flavors[SYM_CATS]))
+	if (mls && validate_mls_range(&con->range, &flavors[SYM_LEVELS], &flavors[SYM_CATS], 0))
 		return -1;
 
 	return 0;
@@ -1484,7 +1489,7 @@ static int validate_range_trans_rules(sepol_handle_t *handle, const range_trans_
 			goto bad;
 		if (validate_ebitmap(&range_trans->tclasses, &flavors[SYM_CLASSES]))
 			goto bad;
-		if (validate_mls_semantic_range(&range_trans->trange, &flavors[SYM_LEVELS], &flavors[SYM_CATS]))
+		if (validate_mls_semantic_range(&range_trans->trange, &flavors[SYM_LEVELS], &flavors[SYM_CATS], 0))
 			goto bad;
 	}
 
@@ -1663,8 +1668,7 @@ static int validate_range_transition(hashtab_key_t key, hashtab_datum_t data, vo
 		goto bad;
 	if (validate_value(rt->target_class, &flavors[SYM_CLASSES]))
 		goto bad;
-
-	if (validate_mls_range(r, &flavors[SYM_LEVELS], &flavors[SYM_CATS]))
+	if (validate_mls_range(r, &flavors[SYM_LEVELS], &flavors[SYM_CATS], 0))
 		goto bad;
 
 	return 0;
-- 
2.52.0

