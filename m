Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C02955E083
	for <selinux@vger.kernel.org>; Wed, 28 Feb 2024 20:44:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709153043; cv=none; b=cxd+knSb3ruKZ0QY1ZhieLFXvT02GPtoBX0b3xUyndvo4RTvfjQuN+b4JgYxrBUCoT/wRFnA96nqctYZ98NhWJLx0sHvLonbQmlYnYqbAHvfB3hE7HtOIk8AG2kDjoE1B8MRc/dq2umGMIoqyPUIoXOyjoiAlL5mA8hThe51hIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709153043; c=relaxed/simple;
	bh=LG9lfP5LEF9uiII73cAgkqd9QArG6EpbYWPke6Pg4VQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mbzKeKpgL8xLia0uvRA+W63GU4ina332jyJF5z01g1N2smDQVcNI3eNVIOUEoYUF0wg3jS7IU099iMsP88x85VFRElcqXgq6umErcqYY8QWVm5hWnIjLUJK2lrnQy7NlYdUlBdX713cWr3ZsfVpWA97VDeaqrlApiYkSXmLnGrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eovRUPQQ; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eovRUPQQ"
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-68fdc714187so628756d6.2
        for <selinux@vger.kernel.org>; Wed, 28 Feb 2024 12:44:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709153040; x=1709757840; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=j3sAb94rFT7FK7zlCsmqKLuvDs4txcy6+MRELvqc6NM=;
        b=eovRUPQQEqUbir4j8QkpAg/lMKKfH9Drc93OJpTyqhmQOxTdZCjzRK+liiNct7jC/t
         xovZtih4KJr1z6kTRTxDu3xO3vi3GjzYqV05g/WhRMt7DjWPSpJ7+fc7+jGeSkhfZL8w
         goBbRmpgv57s/xziq9wucP2gdwer97cPMs31hZ1GtSk34eQObMbcDSUB3bywJwqnWA1j
         1HZzny9EMMraYGydoR7gCfyVdYdg8DQ6kv9DykTGRqbVzVnWwWFoDy94+zNfmUbRL6je
         I18sPnltJhZaYkReaCSUw8FDxT+OA/rEuP7t4si39hdh5/O6+D52urvf04n+s+WIPXc2
         Ulzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709153040; x=1709757840;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=j3sAb94rFT7FK7zlCsmqKLuvDs4txcy6+MRELvqc6NM=;
        b=bsljoA7sffxHvit5Lu78NC9IfNt58co/vDw+6o1AXDL2F4pXBlCKjHw3SRpyk38yJ4
         jGLv+5iyyE7JdCpAGlTbehaGPt2YrcY8SAxDq97luwe1O2+i3NbUiPbPmxlLWysgn8TD
         zvt5gGD6c4j70inSR0iegdYxKfZN16RZ2MFVc+Mfevgi3A1Uxz2QF0TD0UUVX41nkgQ+
         JdOtAviive6a4YBdruUekdHiqGwQ/kZNfyjqweBFD5yrnHR2l0QJB2NJfdqBsz2gTaP1
         Wt+Zfs8e6e8Zuj76FmS//EWcKjSgq3OTk6T49iYrd7ZYmR5PUPqV7HzkG+YoX1P2b4SW
         /Kyw==
X-Gm-Message-State: AOJu0Yy36BTc0S+eHR+HaYAsW2AKjSwnYlhyg40aR2kQLzKynM/fKgxY
	6iiwQs6bVca4ZNraU1R9QCJpv9vGieTS4NnNiPsKlZFqFSoedAU+8JjvvtIc
X-Google-Smtp-Source: AGHT+IFrqH1YaIfWsszxkVSpWhZUOyRkiU/E8fY/+Maz88OY1gUavSbZbyhv6PcyIHzWqKsQK9JGPA==
X-Received: by 2002:a0c:df86:0:b0:68f:7891:ef2e with SMTP id w6-20020a0cdf86000000b0068f7891ef2emr237144qvl.53.1709153040429;
        Wed, 28 Feb 2024 12:44:00 -0800 (PST)
Received: from electric.. (c-69-140-100-37.hsd1.md.comcast.net. [69.140.100.37])
        by smtp.gmail.com with ESMTPSA id mx2-20020a0562142e0200b0068f2d2f64d1sm151907qvb.32.2024.02.28.12.43.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Feb 2024 12:43:59 -0800 (PST)
From: James Carter <jwcart2@gmail.com>
To: selinux@vger.kernel.org
Cc: cgzones@googlemail.com,
	James Carter <jwcart2@gmail.com>
Subject: [PATCH v3] checkpolicy, libsepol: Fix potential double free of mls_level_t
Date: Wed, 28 Feb 2024 15:43:56 -0500
Message-ID: <20240228204356.1809886-1-jwcart2@gmail.com>
X-Mailer: git-send-email 2.43.2
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In checkpolicy, a sensitivity that has one or more aliases will
temporarily share the mls_level_t structure with its aliases until
a level statement is processed for the sensitivity (or one of the
aliases) and the aliases are updated to have their own mls_level_t
structure. If the policydb is destroyed while they are sharing the
mls_level_t structure, then a double free of the shared mls_level_t
will occur. This does not currently occur only because checkpolicy
does very little clean-up before exiting.

The "defined" field of the level_datum_t is set after a level
statement is processed for a sensitivity and its aliases. This means
that we know an alias has its own mls_level_t if the "defined" field
is set. The double free can be avoided by not destroying the
mls_leve_t structure for an alias unless the "defined" field is set.

Since the "defined" field is only set to false while the mls_level_t
structure is being shared, it would be clearer to rename the field
as "notdefined". It would only be set during the time the sensitivity
and its aliases are sharing the mls_level_t structure. Outside of
checkpolicy, the "notdefined" field will always be set to 0.

Also, do more validation of the level_datum_t when validating the
policydb.

Signed-off-by: James Carter <jwcart2@gmail.com>
---
v3: Add a comment about the "notdefined" field in the definition of level_datum_t.
    Do more validation of the level_datum_t when validating the policydb.
v2: Change the field name from "defined" to "notdefined" and change
    the logic to match.

 checkpolicy/checkpolicy.c                  |  7 ++---
 checkpolicy/policy_define.c                | 10 ++++---
 libsepol/cil/src/cil_binary.c              |  3 --
 libsepol/include/sepol/policydb/policydb.h |  2 +-
 libsepol/src/policydb.c                    |  6 ++--
 libsepol/src/policydb_validate.c           | 35 ++++++++++++++++++----
 6 files changed, 44 insertions(+), 19 deletions(-)

diff --git a/checkpolicy/checkpolicy.c b/checkpolicy/checkpolicy.c
index fcec6e51..d7cafaa4 100644
--- a/checkpolicy/checkpolicy.c
+++ b/checkpolicy/checkpolicy.c
@@ -370,10 +370,9 @@ static int check_level(hashtab_key_t key, hashtab_datum_t datum, void *arg __att
 {
 	level_datum_t *levdatum = (level_datum_t *) datum;
 
-	if (!levdatum->isalias && !levdatum->defined) {
-		fprintf(stderr,
-			"Error:  sensitivity %s was not used in a level definition!\n",
-			key);
+	if (!levdatum->isalias && levdatum->notdefined) {
+		fprintf(stderr, "Error:  sensitivity %s was not used in a level definition!\n",
+				key);
 		return -1;
 	}
 	return 0;
diff --git a/checkpolicy/policy_define.c b/checkpolicy/policy_define.c
index 260e609d..ac215086 100644
--- a/checkpolicy/policy_define.c
+++ b/checkpolicy/policy_define.c
@@ -743,6 +743,7 @@ int define_sens(void)
 	level_datum_init(datum);
 	datum->isalias = FALSE;
 	datum->level = level;
+	datum->notdefined = TRUE;
 
 	ret = declare_symbol(SYM_LEVELS, id, datum, &value, &value);
 	switch (ret) {
@@ -780,6 +781,7 @@ int define_sens(void)
 		level_datum_init(aliasdatum);
 		aliasdatum->isalias = TRUE;
 		aliasdatum->level = level;
+		aliasdatum->notdefined = TRUE;
 
 		ret = declare_symbol(SYM_LEVELS, id, aliasdatum, NULL, &value);
 		switch (ret) {
@@ -1006,9 +1008,10 @@ static int clone_level(hashtab_key_t key __attribute__ ((unused)), hashtab_datum
 	mls_level_t *level = (mls_level_t *) arg, *newlevel;
 
 	if (levdatum->level == level) {
-		levdatum->defined = 1;
-		if (!levdatum->isalias)
+		if (!levdatum->isalias) {
+			levdatum->notdefined = FALSE;
 			return 0;
+		}
 		newlevel = (mls_level_t *) malloc(sizeof(mls_level_t));
 		if (!newlevel)
 			return -1;
@@ -1017,6 +1020,7 @@ static int clone_level(hashtab_key_t key __attribute__ ((unused)), hashtab_datum
 			return -1;
 		}
 		levdatum->level = newlevel;
+		levdatum->notdefined = FALSE;
 	}
 	return 0;
 }
@@ -1057,8 +1061,6 @@ int define_level(void)
 	}
 	free(id);
 
-	levdatum->defined = 1;
-
 	while ((id = queue_remove(id_queue))) {
 		cat_datum_t *cdatum;
 		int range_start, range_end, i;
diff --git a/libsepol/cil/src/cil_binary.c b/libsepol/cil/src/cil_binary.c
index a8e3616a..95bd18ba 100644
--- a/libsepol/cil/src/cil_binary.c
+++ b/libsepol/cil/src/cil_binary.c
@@ -907,7 +907,6 @@ static int cil_sensalias_to_policydb(policydb_t *pdb, struct cil_alias *cil_alia
 		goto exit;
 	}
 	sepol_alias->level = mls_level;
-	sepol_alias->defined = 1;
 	sepol_alias->isalias = 1;
 
 	return SEPOL_OK;
@@ -3163,8 +3162,6 @@ int cil_sepol_level_define(policydb_t *pdb, struct cil_sens *cil_sens)
 		}
 	}
 
-	sepol_level->defined = 1;
-
 	return SEPOL_OK;
 
 exit:
diff --git a/libsepol/include/sepol/policydb/policydb.h b/libsepol/include/sepol/policydb/policydb.h
index 6682069e..56d2cb01 100644
--- a/libsepol/include/sepol/policydb/policydb.h
+++ b/libsepol/include/sepol/policydb/policydb.h
@@ -217,7 +217,7 @@ typedef struct user_datum {
 typedef struct level_datum {
 	mls_level_t *level;	/* sensitivity and associated categories */
 	unsigned char isalias;	/* is this sensitivity an alias for another? */
-	unsigned char defined;
+	unsigned char notdefined; /* Only set to non-zero in checkpolicy */
 } level_datum_t;
 
 /* Category attributes */
diff --git a/libsepol/src/policydb.c b/libsepol/src/policydb.c
index f10a8a95..0c23a7a2 100644
--- a/libsepol/src/policydb.c
+++ b/libsepol/src/policydb.c
@@ -1390,8 +1390,10 @@ static int sens_destroy(hashtab_key_t key, hashtab_datum_t datum, void *p
 	if (key)
 		free(key);
 	levdatum = (level_datum_t *) datum;
-	mls_level_destroy(levdatum->level);
-	free(levdatum->level);
+	if (!levdatum->isalias || !levdatum->notdefined) {
+		mls_level_destroy(levdatum->level);
+		free(levdatum->level);
+	}
 	level_datum_destroy(levdatum);
 	free(levdatum);
 	return 0;
diff --git a/libsepol/src/policydb_validate.c b/libsepol/src/policydb_validate.c
index d86f885e..1d8de44e 100644
--- a/libsepol/src/policydb_validate.c
+++ b/libsepol/src/policydb_validate.c
@@ -618,14 +618,39 @@ static int validate_mls_level(const mls_level_t *level, const validate_t *sens,
 	return -1;
 }
 
-static int validate_level_datum(__attribute__ ((unused)) hashtab_key_t k, hashtab_datum_t d, void *args)
+static int validate_level_datum(sepol_handle_t *handle, const level_datum_t *level, validate_t flavors[], const policydb_t *p)
 {
-	level_datum_t *level = d;
-	validate_t *flavors = args;
+	if (level->notdefined != 0)
+		goto bad;
+
+	if (validate_mls_level(level->level, &flavors[SYM_LEVELS], &flavors[SYM_CATS]))
+		goto bad;
+
+	if (level->isalias) {
+		const mls_level_t *l1 = level->level;
+		const mls_level_t *l2;
+		const level_datum_t *actual = (level_datum_t *) hashtab_search(p->p_levels.table, p->p_sens_val_to_name[l1->sens - 1]);
+		if (!actual)
+			goto bad;
+		l2 = actual->level;
+		if (!ebitmap_cmp(&l1->cat, &l2->cat))
+			goto bad;
+	}
 
-	return validate_mls_level(level->level, &flavors[SYM_LEVELS], &flavors[SYM_CATS]);
+	return 0;
+
+	bad:
+	ERR(handle, "Invalid level datum");
+	return -1;
 }
 
+static int validate_level_datum_wrapper(__attribute__ ((unused)) hashtab_key_t k, hashtab_datum_t d, void *args)
+{
+	map_arg_t *margs = args;
+
+	return validate_level_datum(margs->handle, d, margs->flavors, margs->policy);
+}
+	
 static int validate_mls_range(const mls_range_t *range, const validate_t *sens, const validate_t *cats)
 {
 	if (validate_mls_level(&range->level[0], sens, cats))
@@ -774,7 +799,7 @@ static int validate_datum_array_entries(sepol_handle_t *handle, const policydb_t
 	if (hashtab_map(p->p_users.table, validate_user_datum_wrapper, &margs))
 		goto bad;
 
-	if (p->mls && hashtab_map(p->p_levels.table, validate_level_datum, flavors))
+	if (p->mls && hashtab_map(p->p_levels.table, validate_level_datum_wrapper, &margs))
 		goto bad;
 
 	if (hashtab_map(p->p_cats.table, validate_datum, &flavors[SYM_CATS]))
-- 
2.43.2

