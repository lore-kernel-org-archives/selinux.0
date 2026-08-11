Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E44131A07F
	for <selinux@vger.kernel.org>; Tue, 11 Aug 2026 15:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786461439; cv=none; b=kQaGdEO5Lt673oOWMNXPWJTjlEeaHSQ/HKYC42AV42QGek0AqChROPPzNcCnYqiECl/CA+UPC+81BMpc+21p+x+VtkYIa5XZv5D3WZLM0FdYrVuQqKIAfTrBG+bvn5dhVaMeXP+rFoP8c6NdsHZvFvENs+RcBbfgxAUagX0FZIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786461439; c=relaxed/simple;
	bh=uCiam+XT4Pv/O11kY4FpS23Nmw1qMKc5Fvc+x7OcDEk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AgeatMLw+jnEkLdeTdaYYOLmILyLPO/s35BmvZEkHetfr8/RVgd77lw8phJXkE63k93K7e+txR3Vi9QtWSmNH9gKLmBKPnm1095H5/ZGD3How2PwMEnHBRglmSZno153h/+VoDUd3tsPBrGm20RIx6V2a8z376r5j4LLRf6wNwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lYJtIQbr; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lYJtIQbr"
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-52d37b65926so180861cf.2
        for <selinux@vger.kernel.org>; Tue, 11 Aug 2026 08:17:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786461437; x=1787066237; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=UKtA+OIy4lhxAtG9OBO67Sou5x1Y+qj0nSUNPv+FV1Q=;
        b=lYJtIQbrbVOXY98ZacOpzYv8+2WUo6L67I8UtDKdytMWJvFfYDyUsZfvtGF2EuCOMg
         XrtWcQAgbn+/tcdOKb56c8lSaoj4VeJTqQaY7LL3FaP66miDC6IL7E3p+UgF2+0RImB0
         wPg6luO3Pf739nyTDOwy2wq5E/rWWST6FqZooeb4LS3IfQNSdLun7P4SXLlldk2WrJkh
         OMAtsvGqlp2KiTyZOyJ7apffC6qUloMml6sFeSWWifA+V+fMRdBMHXyTUrE3YU8lvGVS
         n9cP6WiXsb6F/WtNoIKP6VdFVn5kwUAgtIrdoNmOUc8bgUkRxVVlgwuP8jRTrMSaxY7Y
         XM0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786461437; x=1787066237;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=UKtA+OIy4lhxAtG9OBO67Sou5x1Y+qj0nSUNPv+FV1Q=;
        b=OXvVtlkTZR5FQ3YNdH1Y3FJ9EvTNqXrdwcDqMIH49uC7CXjKNYYunQXs/o2tphpf4C
         M10471qcLnN+zDO/M7kWLTdNbUW3asbV7aE28VPIYBoYk/IMOFqa8xAE0CYZNoPdSXq6
         BeyVQiGMrr59HUUUYLFXsn9E5va9BpFsDbpsr4XpwDAVLEfXrl3Evj0ilkmpDaA/O6at
         KIqzPuUGelGJArO95v7uSopmDujrZtolzz/7j/hGxY5e9z5pol7SNygT/5KKLqeFikLy
         aY9XVvWPVtbhA0IussaNFQ9h7dP/iixbtWqoFyl2hyxnmmnpoZ1JitpcL51fw3hGDFYg
         QotQ==
X-Gm-Message-State: AOJu0Yzh6cKOlHc/5O6+yAUj18xBbcMfuiIC5w9UvNoiMi1IfWeUTXtl
	wED0p5OuhME6vXcqZA3NGNWKNEwkmlk38HcA0NgfgUaN3rj980Fo9wxG9KeIog==
X-Gm-Gg: AR+sD10ISMFhy8izYEQb10wyR3OM1ELmSlf5Syg4HiEo0K1H/hGwUcQUBrPgHUFiv4f
	G6OWSzYC3B2IzT+J/ZQg+QtpzM2n0epr0YWXfR30NhKzyZWczP+YVgy+bskJTWjp7nMDdLjlvkE
	PTpEJ4axDlG5DFpm1sA1u/IZn0pv3lkLzgJzNi7SVr0Qjs8EQVZwFSuOl0myM7x9wbnuwl2VZfj
	/Lc1OZucqNQ8Om4x0sM71zdJi2npci08Q2cBi/ue4hEv+f31ckwGKFsF23tLUuvPii+os0j3CUZ
	XngOL+0cIyhsLxKsACa8BRCbKh6psEqs+nM3JTUJmgvPG8CmbxRvn/+M40M19fKPUkz/dNoqzl+
	QVw1zlVJhnGLjAL8MTf3fAz7GnCMAk/qvIeva6aswegFQnSc8uLgirLtaVgfsGOA5WCgJblRpdG
	sEKKfCW79DO8ZcGRhRpJtlP7hOnxdsnLq4SzK2liZoZ07hJuEsPoEJoN/ebwojYVceHrQ1pSPVx
	w302aYTIJM=
X-Received: by 2002:a05:622a:491:b0:51c:1e69:bcc9 with SMTP id d75a77b69052e-52d600e6aa5mr9301471cf.12.1786461437153;
        Tue, 11 Aug 2026 08:17:17 -0700 (PDT)
Received: from Fedora43-SELinux ([144.51.8.27])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-52d578f7d54sm13669111cf.5.2026.08.11.08.17.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Aug 2026 08:17:16 -0700 (PDT)
From: James Carter <jwcart2@gmail.com>
To: selinux@vger.kernel.org
Cc: stephen.smalley.work@gmail.com,
	James Carter <jwcart2@gmail.com>
Subject: [PATCH 1/2] libsepol: Copy a chain of type alias references
Date: Tue, 11 Aug 2026 11:17:04 -0400
Message-ID: <20260811151705.109129-1-jwcart2@gmail.com>
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
---
 libsepol/src/expand.c | 47 ++++++++++++++++++++++++++++---------------
 1 file changed, 31 insertions(+), 16 deletions(-)

diff --git a/libsepol/src/expand.c b/libsepol/src/expand.c
index 466d5bc1..96d7b332 100644
--- a/libsepol/src/expand.c
+++ b/libsepol/src/expand.c
@@ -39,6 +39,8 @@
 #include "debug.h"
 #include "private.h"
 
+#define MAX_ALIAS_REPEATS 32
+
 typedef struct expand_state {
 	int verbose;
 	uint32_t *typemap;
@@ -49,6 +51,7 @@ typedef struct expand_state {
 	policydb_t *out;
 	sepol_handle_t *handle;
 	int expand_neverallow;
+	int aliases_skipped;
 } expand_state_t;
 
 static void expand_state_init(expand_state_t *state)
@@ -771,6 +774,19 @@ static int alias_copy_callback(hashtab_key_t key, hashtab_datum_t datum,
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
 
@@ -787,20 +803,7 @@ static int alias_copy_callback(hashtab_key_t key, hashtab_datum_t datum,
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
@@ -3266,6 +3269,7 @@ int expand_module(sepol_handle_t *handle, policydb_t *base, policydb_t *out,
 	unsigned int i;
 	expand_state_t state;
 	avrule_block_t *curblock;
+	int repeats = 0;
 
 	/* Append tunable's avtrue_list or avfalse_list to the avrules list
 	 * of its home decl depending on its state value, so that the effect
@@ -3348,8 +3352,19 @@ int expand_module(sepol_handle_t *handle, policydb_t *base, policydb_t *out,
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
-- 
2.55.0

