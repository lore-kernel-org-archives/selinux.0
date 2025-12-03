Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AD6436CE03
	for <selinux@vger.kernel.org>; Wed,  3 Dec 2025 16:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764779552; cv=none; b=phImHwHi+Ik5R1FHX0XO0pdEw2wJYZlmaZm3srqxN514l8luVuEU41fmpli1ci0einGCHILVz6D6nnlmUiMmcLpZ4zx49vQptCAeUcmf9LHvBqRNqwaKaTdlpr08qLph0DTkDWUhUPYclpC6m1BdVDV0Zyvv25jmZHnQigqPl3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764779552; c=relaxed/simple;
	bh=sIMqAdJiOxsGVrcTnwqFxhKAqvxwlftZwD2s1YVqjOw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nUwJGL8TIJKPKDvH3NWKcUeKFpF1sQhnwX2RsF1041jd3QaNwm9i2VTZwAn0bRJnKPjlbdi+1SBqo2SwyGBlk3H0L4/I0XQ+seY3bIcYZis4beCkBW8/wrsXqhkVXZXBkmxpF0VriC0q94mD6QHEoitrwYczXi7K6kUUChymy3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LB/CiCLa; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LB/CiCLa"
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-8b2d56eaaceso670839885a.0
        for <selinux@vger.kernel.org>; Wed, 03 Dec 2025 08:32:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764779550; x=1765384350; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+U7x2jmWm9sc1nbdFLdJV249l/yM7BpZE1V39GMeTpY=;
        b=LB/CiCLao0vbmLi6zdWf4MB2QMsWYU0ANpJ//CRnILvUkO7DzGRgVs6149JMj6zhT7
         tWLQTkgSyaD5wOa/F13FaF/K2xF0XTuEshACYzHy3fOyduwqZ/oNrP0i/P24RTCDD8kj
         qOruH30KNc9Os24MbGeInYufDBCmEAyUSIqbr8iefnhizpV8UlcO6Pq1uHXVixXiF+wn
         aWXMzmAB+veE37Q8H55JTRt7QAqMz8Tt1Gjb9Xg1ZlKpEj8x4cMKPfwULa+7tl96OS/7
         w3FB4bX4KsA+gw/Qfn5qpBy1LatJ5Ebg3FFA30cGvE2OQcNjouq5IFbSBlBvf/00likS
         7PGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764779550; x=1765384350;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+U7x2jmWm9sc1nbdFLdJV249l/yM7BpZE1V39GMeTpY=;
        b=rNuGc7SQH4FK2yOyMzUjpGXPMG5lrVgLZY9CLdWC6b/EQrgHk4bLqqkBXAVN4gFFUt
         64SeW6sb6b8ZCBNO5/LujFGT/P1vO/pZ4CFp5PsiTsZQygcP6nLwY34/GfhwIawMN7V7
         oVl71PZ8jhQAuv0WVYCkjk9DItLd4Czu9o9xfzBn3Mmm/fcPFW58LuR3xEl5FbBlttKb
         esZ1lDP7DjEATDcpaHK0xwX4YPaXrJG42aytvuwgkZPt0V5iVOVAs9mxli1GGjwRke3x
         Z+/9f7xWsIaDdddInreNpVOSljGMdzouKPZIxu+dZMem/3ps4QbD7+LfEiLUIfbuq03C
         g7xg==
X-Gm-Message-State: AOJu0Yy6IMiU2ntyen6LYnxzLVVFiIVASVnvtjWN6Aika4Nh/Ke1S47h
	88ArL3JHeyGt7NZGHYgHiKprzwdFre+6ysvumldh5IKKP3B7Q7W7MESqwiL4Hw==
X-Gm-Gg: ASbGncstnx2wysTh9frC/wohCan5rPodZNDm09EDFMbNtxmEXU9qY9hwVbGxjkDKf7Y
	tDs7j83FS+kWzCnSFnJD1t6meRDpfKbPjLTqLhALIlr530DO0W9kjFWnKDOCH+UH/QOFzT++uK8
	oXfeql82TnLRXBRYBmib7yY4FyAFxY1MQRKfwkktScON1d1FyS+2kuQzlNJQzRlgSL7OHo9PH6a
	cB8xRClQ/i/KXtRR3wxv8R6ivkeqh8/fQkCf6UXrzyN4lCtLt7t/+qNzUVan8Cygbo3WQiSGwxC
	2CG7QHeqq+0sMSJqY4+MemAtdQkNtRnub+Fu9zxQBGkVlXURCOFYwJVXp6EQVtscLqGS9fzjvWE
	pCH7K8SXh67YG73q1GUevEvh4wrVRvjuf4n3k8bjWx7v2MMTyOUGgGWTMT2kYpl9oy+bnbr0B+/
	cKBkU7gIXKLlWivVF2OO8=
X-Google-Smtp-Source: AGHT+IGRLiAt2NAxnY6ttpxS8RKiWQN98Pyjax7JX9WhgGUwAhjf1z1BCGLl4GrWdXDAr+3MMxkXpw==
X-Received: by 2002:a05:620a:4044:b0:8b2:f269:f8a1 with SMTP id af79cd13be357-8b5e707355cmr357743485a.71.1764779549564;
        Wed, 03 Dec 2025 08:32:29 -0800 (PST)
Received: from fedora ([144.51.8.27])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8b52a1cad4esm1333399485a.45.2025.12.03.08.32.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Dec 2025 08:32:29 -0800 (PST)
From: James Carter <jwcart2@gmail.com>
To: selinux@vger.kernel.org
Cc: James Carter <jwcart2@gmail.com>
Subject: [PATCH 1/6] Fix problem with bounds statements in optional blocks
Date: Wed,  3 Dec 2025 11:32:13 -0500
Message-ID: <20251203163218.54939-2-jwcart2@gmail.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20251203163218.54939-1-jwcart2@gmail.com>
References: <20251203163218.54939-1-jwcart2@gmail.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Using a bounds statement in an optional will always cause that bounds
to apply even when the optional block's requires are not met and the
block is disabled.

Instead, handle bounds like type attributes and create a local
declaration for the block and only copy the bounds to the global
declaration when creating the kernel binary policy.

Signed-off-by: James Carter <jwcart2@gmail.com>
---
 checkpolicy/policy_define.c | 11 +++++++----
 libsepol/src/expand.c       | 10 ++++++++++
 libsepol/src/link.c         | 24 +++++++++++++++++++++---
 3 files changed, 38 insertions(+), 7 deletions(-)

diff --git a/checkpolicy/policy_define.c b/checkpolicy/policy_define.c
index 7029b834..4c53e1e6 100644
--- a/checkpolicy/policy_define.c
+++ b/checkpolicy/policy_define.c
@@ -1484,6 +1484,8 @@ int define_typeattribute(void)
 static int define_typebounds_helper(const char *bounds_id, const char *type_id)
 {
 	type_datum_t *bounds, *type;
+	char *id;
+	uint32_t value;
 
 	if (!is_id_in_scope(SYM_TYPES, bounds_id)) {
 		yyerror2("type %s is not within scope", bounds_id);
@@ -1507,10 +1509,11 @@ static int define_typebounds_helper(const char *bounds_id, const char *type_id)
 		return -1;
 	}
 
-	if (type->flavor == TYPE_TYPE && !type->primary) {
-		type = policydbp->type_val_to_struct[type->s.value - 1];
-	} else if (type->flavor == TYPE_ALIAS) {
-		type = policydbp->type_val_to_struct[type->primary - 1];
+	id = strdup(type_id);
+	value = (type->flavor != TYPE_ALIAS) ? type->s.value : type->primary;
+	type = get_local_type(id, value, 0);
+	if (!type) {
+		yyerror("Out of memory!");
 	}
 
 	if (!type->bounds)
diff --git a/libsepol/src/expand.c b/libsepol/src/expand.c
index 8695540c..61dee255 100644
--- a/libsepol/src/expand.c
+++ b/libsepol/src/expand.c
@@ -3146,16 +3146,26 @@ int expand_module(sepol_handle_t * handle,
 		    (decl->p_types.table, attr_convert_callback, &state)) {
 			goto cleanup;
 		}
+		/* copy type bounds */
+		if (hashtab_map(decl->p_types.table,
+						type_bounds_copy_callback, &state))
+			goto cleanup;
 
 		/* copy roles */
 		if (hashtab_map
 		    (decl->p_roles.table, role_copy_callback, &state))
 			goto cleanup;
+		if (hashtab_map(state.base->p_roles.table,
+						role_bounds_copy_callback, &state))
+			goto cleanup;
 
 		/* copy users */
 		if (hashtab_map
 		    (decl->p_users.table, user_copy_callback, &state))
 			goto cleanup;
+		if (hashtab_map(decl->p_users.table,
+						user_bounds_copy_callback, &state))
+			goto cleanup;
 
 	}
 
diff --git a/libsepol/src/link.c b/libsepol/src/link.c
index 588b5cd2..55c29d21 100644
--- a/libsepol/src/link.c
+++ b/libsepol/src/link.c
@@ -766,13 +766,19 @@ static int type_bounds_copy_callback(hashtab_key_t key,
 	type_datum_t *type = (type_datum_t *) datum;
 	type_datum_t *dest;
 	uint32_t bounds_val;
+	hashtab_t type_tab;
 
 	if (!type->bounds)
 		return 0;
 
+	if (state->dest_decl == NULL)
+		type_tab = state->base->p_types.table;
+	else
+		type_tab = state->dest_decl->p_types.table;
+
 	bounds_val = state->cur->map[SYM_TYPES][type->bounds - 1];
 
-	dest = hashtab_search(state->base->p_types.table, key);
+	dest = hashtab_search(type_tab, key);
 	if (!dest) {
 		ERR(state->handle,
 		    "Type lookup failed for %s", (char *)key);
@@ -795,13 +801,19 @@ static int role_bounds_copy_callback(hashtab_key_t key,
 	role_datum_t *role = (role_datum_t *) datum;
 	role_datum_t *dest;
 	uint32_t bounds_val;
+	hashtab_t role_tab;
 
 	if (!role->bounds)
 		return 0;
 
+	if (state->dest_decl == NULL)
+		role_tab = state->base->p_roles.table;
+	else
+		role_tab = state->dest_decl->p_roles.table;
+
 	bounds_val = state->cur->map[SYM_ROLES][role->bounds - 1];
 
-	dest = hashtab_search(state->base->p_roles.table, key);
+	dest = hashtab_search(role_tab, key);
 	if (!dest) {
 		ERR(state->handle,
 		    "Role lookup failed for %s", (char *)key);
@@ -824,13 +836,19 @@ static int user_bounds_copy_callback(hashtab_key_t key,
 	user_datum_t *user = (user_datum_t *) datum;
 	user_datum_t *dest;
 	uint32_t bounds_val;
+	hashtab_t user_tab;
 
 	if (!user->bounds)
 		return 0;
 
+	if (state->dest_decl == NULL)
+		user_tab = state->base->p_users.table;
+	else
+		user_tab = state->dest_decl->p_users.table;
+
 	bounds_val = state->cur->map[SYM_USERS][user->bounds - 1];
 
-	dest = hashtab_search(state->base->p_users.table, key);
+	dest = hashtab_search(user_tab, key);
 	if (!dest) {
 		ERR(state->handle,
 		    "User lookup failed for %s", (char *)key);
-- 
2.50.0

