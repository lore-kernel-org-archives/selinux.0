Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC81F3803E9
	for <selinux@vger.kernel.org>; Tue, 11 Aug 2026 19:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786476157; cv=none; b=TtB4DM/FTq116kDHOZIKxh5FwsgkDr++6w0pBp0aAcjDDrayZNqOP9fjjtf6FFICSVSfel33FMdNGbMk30FIscZrAvrPNELpeo5E3/setSsCk1o6tcBiGo9FehHajN+86AJ6DTgypCMsLSCezNQeTImS0qsrzYkeR/86gmABQPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786476157; c=relaxed/simple;
	bh=OsVQSMmEJwz0+mIQPR5DjfI6zDIkO/VcKPACDIn/d+w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kGNn/idlwOmubdZoIou21GrYtGXUIB70xvAqWIhxnn2pv3JTmYBKad8vQfHEfRY4wP0BXzHLkUgvHQiIiyJwY26TXp/WiYyWZfR5ilHfZaxf+yWRn7fO5tQNbSXJGsHtjbyTZT6R1LWpRGKzK6NpxiDaaSpiwYKFAzk+TI1kPAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hel6WUwA; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hel6WUwA"
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-52b4e988c77so2230941cf.3
        for <selinux@vger.kernel.org>; Tue, 11 Aug 2026 12:22:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786476154; x=1787080954; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=FyUAqj9TaVKmeZBVZiZ6Saax55cshK8haNMj0GXefPo=;
        b=hel6WUwAug0HXUvr4NvKpqhcU6IAgi1S0swK72pNgshj3KcrmPHpHTdBVWgDffKDT/
         req+W/k1LYXU83qewnpVlIsTBNYg/GOYSlMbG9OD7f3Z2mHoafkuNDgKfHI43ITCuyQf
         Zk7oihmINEzCIh49eR2hSORVS8uA71jUONboxTc6sW2/L2Tb6TJAMUvombqoDZbGTgMA
         4v13C6R5WdfNbZYlLSRxeCUsQozhXf4ryBNRlgbvq5jAxdHtnSKgrv4zhlZjy4hQ/FiN
         DeLwuR7hPi/NYQXUwJ7FDQsJvlBXKAGogYUIG7nu0zFfPk2qpcTs/VOBaKm8uTHT6Ams
         M+ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786476154; x=1787080954;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=FyUAqj9TaVKmeZBVZiZ6Saax55cshK8haNMj0GXefPo=;
        b=gUSeu8/uuMG9jJqeQHf7vZyaIeNpZkxFD4JbcR11hgyteVfO1+9HSVG8RR+JiBR7LC
         cJo5uic+5PUdBx/npWt3pgDRBMMlyDTLpzQ7/DWqghg/mVK6lokm4UINcGjRCRuU1w5C
         qvabNqI3fVb5OEU0lSshwx6SRYhG3QdEpJaEYPlezs2IUj/WWc5Dlmrk6Grxb1LCvbp0
         IJa8SKp6HmlT8U6aCpaxOd7Wyv52pVU9uS9SNPECRMonjZOhLa4GkqqhJlBdPhdaHNCV
         XfUB4LtJiF84I9MZMK463eDkHYE5AMfak8qDgKOmRO6iQxzZO3S3cBiMK5I+xAL9Y+Ye
         bgMg==
X-Gm-Message-State: AOJu0Yy0xfGop5ZSrmVCJXrC2UxFmQDF5oM2ZNXFs3fRPOIvCCV50D5g
	HQyM5vMwiHaYCw2fs0qEU1ScRF2mGSlkI/NVOkT0By4FUGlRrojJhPss6ZvI6g==
X-Gm-Gg: AR+sD10FMGVqQPUthm+FjVOAr810EtuZOyGuM/7sm7cHw2eQYbExXH0VEZ3a330InrF
	k9gZqDDGNbt9+AEeMijy6LSrIrQgFWN9QkZu620tbDvZgn1PjPnyXnw6rciHAoWpEH7BmUw5L8c
	RgOlRfsWEApH9mz2XiTqMi9BXiA+O7EDxPk9CbTexl0rXZVHjrc+ZR7+RuYzCqCTGwi8ki0lhar
	fe/A4qrpGFUcpQEcpfS5qsUg9gsOyLIWeycH/WIrsfikRUQq1laDyW3qzprz4Tx2NMrGEK9lcRk
	fmRF/VRg3c8mojdcoyYzpIKzMpn8lrUX/fJ1yt9yjMZ2cy6q+GQc/+Y0ylW7TxdSJyZT+j47hkT
	3nR+bOXcvYlpf960RDb3l+fHMfJ3yxCpZCIyWi5WJjjYCHIPC22PIUmTj/AYpVbjVuP4vE6Zezv
	1j97ta4igdRzM8VVxfuZdZOmDM+Wql2yx/YB3no0DoxSUY7NTzaSHeaa81hJQOiIzlt7Kwu0Amo
	gFavz9YvRo=
X-Received: by 2002:ac8:7d96:0:b0:51c:bb79:a52d with SMTP id d75a77b69052e-52d58508d06mr44523271cf.14.1786476154336;
        Tue, 11 Aug 2026 12:22:34 -0700 (PDT)
Received: from Fedora43-SELinux ([144.51.8.27])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-90a6c3994efsm5702196d6.32.2026.08.11.12.22.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Aug 2026 12:22:33 -0700 (PDT)
From: James Carter <jwcart2@gmail.com>
To: selinux@vger.kernel.org
Cc: stephen.smalley.work@gmail.com,
	James Carter <jwcart2@gmail.com>
Subject: [PATCH 1/2 v2] libsepol: Copy a chain of type alias references
Date: Tue, 11 Aug 2026 15:22:15 -0400
Message-ID: <20260811192216.140092-1-jwcart2@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For a policy with multiple modules it is possible for there to be
a chain of type alias references where an alias in one module refers
to an alias in another module which refers an alias in a third
module and so on. When expanding a policy with this sort of chain,
a situation can arise where an alias being copied references an
alias that has yet to be copied. Since the value of an alias is set
to the typemap of its primary and the typemap of its primary has not
been set yet, this alias will end up with an invalid value of 0 and
return an error.

When copying aliases, skip over aliases that refer to an alias that
has yet to be copied and keep repeating the copying of aliases until
none have been skipped or the maximum number of repeats has been
exceeded.

Signed-off-by: James Carter <jwcart2@gmail.com>
Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
v2: Move MAX_ALIAS_REPEATS to private.h

 libsepol/src/expand.c  | 45 +++++++++++++++++++++++++++---------------
 libsepol/src/private.h |  2 ++
 2 files changed, 31 insertions(+), 16 deletions(-)

diff --git a/libsepol/src/expand.c b/libsepol/src/expand.c
index 466d5bc1..3d5bae83 100644
--- a/libsepol/src/expand.c
+++ b/libsepol/src/expand.c
@@ -49,6 +49,7 @@ typedef struct expand_state {
 	policydb_t *out;
 	sepol_handle_t *handle;
 	int expand_neverallow;
+	int aliases_skipped;
 } expand_state_t;
 
 static void expand_state_init(expand_state_t *state)
@@ -771,6 +772,19 @@ static int alias_copy_callback(hashtab_key_t key, hashtab_datum_t datum,
 		return 0;
 	}
 
+	if (state->typemap[prival - 1] == 0) {
+		/* The primary is another alias that has yet to be copied.
+		 * Skip this alias for now and come back to it later. */
+		state->aliases_skipped++;
+		return 0;
+	}
+
+	new_alias = hashtab_search(state->out->p_types.table, key);
+	if (new_alias) {
+		/* This alias has already been copied */
+		return 0;
+	}
+
 	if (state->verbose)
 		INFO(state->handle, "copying alias %s", id);
 
@@ -787,20 +801,7 @@ static int alias_copy_callback(hashtab_key_t key, hashtab_datum_t datum,
 		return SEPOL_ENOMEM;
 	}
 	memset(new_alias, 0, sizeof(type_datum_t));
-	if (alias->flavor == TYPE_TYPE)
-		new_alias->s.value = state->typemap[alias->s.value - 1];
-	else if (alias->flavor == TYPE_ALIAS)
-		new_alias->s.value = state->typemap[alias->primary - 1];
-	else
-		assert(0); /* unreachable */
-
-	if (!new_alias->s.value) {
-		ERR(state->handle, "No type mapping for %s", new_id);
-		free(new_alias);
-		free(new_id);
-		return -1;
-	}
-
+	new_alias->s.value = state->typemap[prival - 1];
 	new_alias->flags = alias->flags;
 
 	ret = hashtab_insert(state->out->p_types.table, (hashtab_key_t)new_id,
@@ -3266,6 +3267,7 @@ int expand_module(sepol_handle_t *handle, policydb_t *base, policydb_t *out,
 	unsigned int i;
 	expand_state_t state;
 	avrule_block_t *curblock;
+	int repeats = 0;
 
 	/* Append tunable's avtrue_list or avfalse_list to the avrules list
 	 * of its home decl depending on its state value, so that the effect
@@ -3348,8 +3350,19 @@ int expand_module(sepol_handle_t *handle, policydb_t *base, policydb_t *out,
 	/* Needed for processing aliases */
 	if (policydb_index_others(handle, out, verbose))
 		goto cleanup;
-	if (hashtab_map(state.base->p_types.table, alias_copy_callback, &state))
-		goto cleanup;
+
+	do {
+		if (repeats >= MAX_ALIAS_REPEATS) {
+			ERR(handle, "Failed to resolve alias references");
+			goto cleanup;
+		}
+		state.aliases_skipped = 0;
+		if (hashtab_map(state.base->p_types.table, alias_copy_callback,
+				&state))
+			goto cleanup;
+		repeats++;
+	} while (state.aliases_skipped > 0);
+
 	if (hashtab_map(state.base->p_types.table, type_bounds_copy_callback,
 			&state))
 		goto cleanup;
diff --git a/libsepol/src/private.h b/libsepol/src/private.h
index 50fe2b2c..6fc5fa2d 100644
--- a/libsepol/src/private.h
+++ b/libsepol/src/private.h
@@ -43,6 +43,8 @@
 
 #define ARRAY_SIZE(x) (sizeof(x) / sizeof((x)[0]))
 
+#define MAX_ALIAS_REPEATS 32
+
 static inline int exceeds_available_bytes(const struct policy_file *fp,
 					  size_t x, size_t req_elem_size)
 {
-- 
2.55.0

