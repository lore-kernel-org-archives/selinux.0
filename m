Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26BAE3B42E1
	for <selinux@vger.kernel.org>; Fri, 31 Jul 2026 17:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785520301; cv=none; b=VqwrzE3c0fLz08wH8mQyB2CY/IjrrbuRRznHlWsYE9Yhn3nX+Ro1IL71rDQZe8/W4Z/lMxI3F9afDij2LG0ShmPq3SvMwj5Y6rEg2EkyukNQVn7SuEWHkgiQoKzkV6OBa3rBrZEhhgXJohp7mh7gVAMcmtz9FcYC1pBPn9dXuIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785520301; c=relaxed/simple;
	bh=tOenOK/Fkfos4kilK+GLRvvestAlT/FDmEzwh0GFuBI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XMvYURRHTFL4qgu6lNSaSIEuV6/qPvXEvmoizt9H6o6usZQp5d6BWrp98VPWFgItqZx8jSthu8HDtHCzd9MWYn8A5Da+dcPaIilcdsVYDqYrOI0F2Jx/cMemqHm838Zn/44fR/O3GKAz5hkAIAPOW6KXGI/e5jC9CGFab4eOD5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OFYi+VEL; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OFYi+VEL"
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-8ef7b7651ecso16729356d6.1
        for <selinux@vger.kernel.org>; Fri, 31 Jul 2026 10:51:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785520298; x=1786125098; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=eTcMUh8Ra1E9+8tDSq+W7GHKYsYDSFZdbDgi3CPbkJM=;
        b=OFYi+VELYFDDkSLYmNlxBwRBI4bX35TemDxWGEoNNNKOKwoZ4QW3LUXPgS6iXSt77e
         wCkh1iVr8bmJIcZCyflq8VAFKtWQ4So8ra8UOfbdw+SMSuFZ303V02gDpEZfF7MuKYYI
         9f66YejkVKxyYmbgfn3YpntlNc2IF1dGEd54EDtUM+e9l6Jei3vRJrr2aX61Joz8K59Z
         s/YHwKwgory+E/faT0r7ii0l9HMFf3nNeYe5OoNBs5LeX3ZD2W5xhxjBkZ225YG9aO7n
         DLFdQj7WIKVtsMyO05B8UZFCXatUE9ILWzo6fuN3l90wCUkLf4tv7E0w/Z6tb8A0eG7c
         2Yew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785520298; x=1786125098;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=eTcMUh8Ra1E9+8tDSq+W7GHKYsYDSFZdbDgi3CPbkJM=;
        b=fxYPSNIEqS7IrWjT/pkA4qDSotTKipPZEBk8sDpLbhLLdcBwNteFjqCjPPCfbgNz8P
         Yn3+tHjkZqmTl1HZ7OJqScdLkanN3NzmcvsyYndAtZWDmQWhV5/grTWwSCaHpHk9wmHf
         9HiMFZfIvnRQRldZiLaO/nHBw2fe0kCvbaelDNTjQ6o3DNQaBJ2tou2qI2S65d3D1guE
         qJoYfNtYnysQqf5ncWXB5CqnoNRnvJNzIkKmapDBzPTRCSUo06zzomKvR6V9VeRzXBnT
         zEtsTlGsWhgY3I8DQBi0jeck3KUESubYb9aRCp0JkTgRyjNdVeoL7aW8394toSoXvmP5
         kSvw==
X-Gm-Message-State: AOJu0YwaG9MfQdP/z0zJpNvRLOXZrX3bzLmra8X74L5myMtE9R9Cd5k6
	zchHHb9VQhfqNphl3dAZCyWjwoPTn99YKSUBNAIvEr7EwUwS1HPBej6g49t6wg==
X-Gm-Gg: AR+sD10HSNuI40rQ3rFnHJprdNe7wPruzFcM1BrsLz2cRCbU6SmJC1GARwk0jJUy3d/
	I4wcLbxFtSZuGNSeyz15lDvHbrBA3D2aNASZFi4mr35H0fCSBnDVHkpLguCIom6skibh7PaJK0z
	qUrrD1P0ogovliuM8aNcd+aVNK5njWoHkQgPH1WMHQq0LGDZ3UvX1uibTmlbS9d6DuabTllTsDR
	kpLawsuY0Fgx5YWMZk1Tf3Gr4bHbLQdkgYhLKoomGYaRwvwEhz/NvybrYQPrBIuMsd3OGmcFV87
	+80DPNZCRkcWGKwEWWQeF9X6pNawcel0UXR05UM+TjHpNbSn1oczDtOH0BMdDhgWgp/61OddhGv
	KEltNBzNk99/61nDpkH0otEhxJZzZ8Q90vv3O/pIMIKdCSdm7YYHCAQE7DQr64qfm7DfsXfM8SC
	BHBSUR/AUV1zV25I0sWls9mgI8pAhcUTniqlXdDg1K4aImksi2azRi1nu3JdxYpAW6wLaji50/K
	nK/zWU9sfrZR6jbfRA6Vw==
X-Received: by 2002:a05:6214:5782:b0:8e9:51b7:2d49 with SMTP id 6a1803df08f44-90843123f45mr58274256d6.2.1785520297397;
        Fri, 31 Jul 2026 10:51:37 -0700 (PDT)
Received: from Fedora43-SELinux ([144.51.8.27])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-908435b6778sm15292326d6.30.2026.07.31.10.51.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2026 10:51:36 -0700 (PDT)
From: James Carter <jwcart2@gmail.com>
To: selinux@vger.kernel.org
Cc: stephen.smalley.work@gmail.com,
	James Carter <jwcart2@gmail.com>
Subject: [PATCH] libsepol: Check for zero when mapping identifier values
Date: Fri, 31 Jul 2026 13:51:23 -0400
Message-ID: <20260731175123.52557-1-jwcart2@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When expanding a base along with its modules, the identifier values
of declarations are mapped from their values in the module to their
values in the kernel policy. A maliciously crafted policy could
create a situation where there is no mapping. This would leave the
new identifier value as zero. Identifier values must start at 1
because "value - 1" is used to reference zero-based arrays.

Signed-off-by: James Carter <jwcart2@gmail.com>
---
 libsepol/src/expand.c | 76 ++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 72 insertions(+), 4 deletions(-)

diff --git a/libsepol/src/expand.c b/libsepol/src/expand.c
index 1ef0fb39..8cb62d82 100644
--- a/libsepol/src/expand.c
+++ b/libsepol/src/expand.c
@@ -646,6 +646,10 @@ static int type_bounds_copy_callback(hashtab_key_t key, hashtab_datum_t datum,
 		return 0;
 
 	bounds_val = state->typemap[type->bounds - 1];
+	if (!bounds_val) {
+		ERR(state->handle, "No type mapping for %s", (char *)key);
+		return -1;
+	}
 
 	dest = hashtab_search(state->out->p_types.table, (char *)key);
 	if (!dest) {
@@ -676,6 +680,10 @@ static int role_bounds_copy_callback(hashtab_key_t key, hashtab_datum_t datum,
 		return 0;
 
 	bounds_val = state->rolemap[role->bounds - 1];
+	if (!bounds_val) {
+		ERR(state->handle, "No role mapping for %s", (char *)key);
+		return -1;
+	}
 
 	dest = hashtab_search(state->out->p_roles.table, (char *)key);
 	if (!dest) {
@@ -706,6 +714,10 @@ static int user_bounds_copy_callback(hashtab_key_t key, hashtab_datum_t datum,
 		return 0;
 
 	bounds_val = state->usermap[user->bounds - 1];
+	if (!bounds_val) {
+		ERR(state->handle, "No user mapping for %s", (char *)key);
+		return -1;
+	}
 
 	dest = hashtab_search(state->out->p_users.table, (char *)key);
 	if (!dest) {
@@ -782,6 +794,13 @@ static int alias_copy_callback(hashtab_key_t key, hashtab_datum_t datum,
 	else
 		assert(0); /* unreachable */
 
+	if (!new_alias->s.value) {
+		ERR(state->handle, "No type mapping for %s", new_id);
+		free(new_alias);
+		free(new_id);
+		return -1;
+	}
+
 	new_alias->flags = alias->flags;
 
 	ret = hashtab_insert(state->out->p_types.table, (hashtab_key_t)new_id,
@@ -1559,6 +1578,11 @@ static int copy_role_trans(expand_state_t *state, role_trans_rule_t *rules)
 							state->rolemap
 								[cur->new_role -
 								 1];
+						if (!mapped_role) {
+							ERR(state->handle,
+							    "No role mapping");
+							return -1;
+						}
 
 						if ((cur_trans->role ==
 						     i + 1) &&
@@ -1607,6 +1631,11 @@ static int copy_role_trans(expand_state_t *state, role_trans_rule_t *rules)
 					n->new_role =
 						state->rolemap[cur->new_role -
 							       1];
+					if (!n->new_role) {
+						ERR(state->handle,
+						    "No role mapping");
+						return -1;
+					}
 					if (l)
 						l->next = n;
 					else
@@ -1633,6 +1662,10 @@ static int expand_filename_trans_helper(expand_state_t *state,
 	int rc;
 
 	mapped_otype = state->typemap[rule->otype - 1];
+	if (!mapped_otype) {
+		ERR(state->handle, "No type mapping");
+		return -1;
+	}
 
 	rc = policydb_filetrans_insert(state->out, s + 1, t + 1, rule->tclass,
 				       rule->name, NULL, mapped_otype,
@@ -1940,8 +1973,18 @@ static int expand_terule_helper(sepol_handle_t *handle, policydb_t *p,
 
 	cur = perms;
 	while (cur) {
-		uint32_t remapped_data = typemap ? typemap[cur->data - 1] :
-						   cur->data;
+		uint32_t remapped_data;
+
+		if (typemap) {
+			remapped_data = typemap[cur->data - 1];
+			if (!remapped_data) {
+				ERR(handle, "No type mapping");
+				return -1;
+			}
+		} else {
+			remapped_data = cur->data;
+		}
+
 		avkey.target_class = cur->tclass;
 
 		conflict = 0;
@@ -2245,13 +2288,23 @@ static int cond_node_map_bools(expand_state_t *state, cond_node_t *cn)
 
 	cur = cn->expr;
 	while (cur) {
-		if (cur->boolean)
+		if (cur->boolean) {
 			cur->boolean = state->boolmap[cur->boolean - 1];
+			if (!cur->boolean) {
+				ERR(state->handle, "No bool mapping");
+				return -1;
+			}
+		}
 		cur = cur->next;
 	}
 
-	for (i = 0; i < min(cn->nbools, COND_MAX_BOOLS); i++)
+	for (i = 0; i < min(cn->nbools, COND_MAX_BOOLS); i++) {
 		cn->bool_ids[i] = state->boolmap[cn->bool_ids[i] - 1];
+		if (!cn->bool_ids[i]) {
+			ERR(state->handle, "No bool mapping");
+			return -1;
+		}
+	}
 
 	if (cond_normalize_expr(state->out, cn)) {
 		ERR(state->handle, "Error while normalizing conditional");
@@ -2329,8 +2382,23 @@ static int context_copy(context_struct_t *dst, context_struct_t *src,
 			expand_state_t *state)
 {
 	dst->user = state->usermap[src->user - 1];
+	if (!dst->user) {
+		ERR(state->handle, "No user mapping");
+		return -1;
+	}
+
 	dst->role = state->rolemap[src->role - 1];
+	if (!dst->role) {
+		ERR(state->handle, "No role mapping");
+		return -1;
+	}
+
 	dst->type = state->typemap[src->type - 1];
+	if (!dst->type) {
+		ERR(state->handle, "No type mapping");
+		return -1;
+	}
+
 	return mls_context_cpy(dst, src);
 }
 
-- 
2.55.0

