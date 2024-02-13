Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 920E260872
	for <selinux@vger.kernel.org>; Tue, 13 Feb 2024 20:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707857772; cv=none; b=KEQXaYXchbvWosJxQj0yfOFR8nEdrZjkElf65YTzahC7+CyWKZXvhSqWfFOR7ANUAEflUWvHU9qeA5kD6aDh7J1SPfyKtVB8BsPebhgPjGWdsmOBQ5KNjQ8pga4VO+RWStQ3ijaaf+YyEfNgxDQulUv4zL21VDjeSCVVFatGTZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707857772; c=relaxed/simple;
	bh=dGKLBGa59XRydJInzor93qNhwgdzYLGC6t33BncqeqU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FDCuyv41AZLq8kLv1JxBhYd8H5C7OyjGI65d321BkD929iQ0fIpffyzidyzY4dXAuKkbKNu3felrO91pDkRG7o0Eo8sKrasKjX1pWwDMmLiGXopU6KXFKhXbSEvsYCrVZDHKIVX83fwM9btQr/Ae4NdgFHhiwYDCl/kM4EyY9n8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SZ+fs/09; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SZ+fs/09"
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-68ee2c0a237so1002776d6.1
        for <selinux@vger.kernel.org>; Tue, 13 Feb 2024 12:56:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707857769; x=1708462569; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=uQzYGCT5St57ckKrn0eybsw3cMnW4dkwWw0ip/LdObQ=;
        b=SZ+fs/09M7FenEdu1UaANyu2Unec3NhJiVbHgSSMqWxTfFfrMDBwGMmzWaZv6f/X2/
         QZ7e8dBEiF2wUxogLCswpobl2eb6eiLG9OxM5dvn+Uw1AT7X/y9j7dREKNQn+yoO31uF
         vls7ZOHsJZT0ebceEKhYJJj/TLNyP6jqBIL845kYtqFMKiOiYn+XIDMwsn1uTnBIV2cs
         +8cnlGlPzVowHYEFwDFUX8cntpq3lilZFMMyOchsMi92EkGMR2FO2IRb9l42guXWKjRy
         H9tTfth5UWvwG/Ag30sBGRsYyMgKfxbUeS7xBy6OlQVaH4glLegsATx4JhrypzE5QEvi
         oI+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707857769; x=1708462569;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uQzYGCT5St57ckKrn0eybsw3cMnW4dkwWw0ip/LdObQ=;
        b=Iwcw44o9cAaR8b0WUVglTbqF9PE12uviinlyFzmw4oJMgNEbeSqu46rnKc1Vt/hP9n
         sWIheAMMZxppCZp789CUvjfOKIvOMDJTvOJPgqEXTp3XO3S5bE3yByqaaRYmhyUFO2Yx
         7GqZp1e7859UJ8vg1PukToKgOccEftnRWlDrS+R9LDpM02QmtbPHQ8pNZbEQJHOWCTEf
         40hjJH+0mbR4BQnpDjh9K4djU1F18Q8lUK6EIn5pvEb7mpod3c0pZeTy3pO4bfyoLC+K
         7X8PFDwmPRf5sZgoCf362dWCFZd5e1TILRx530i7NQT4sbZQMrqeokaIRVItmJ/hPdMQ
         xCzg==
X-Gm-Message-State: AOJu0YwQRGrYJG8ho3B7DsaoRbu6LaD2qxnec7SzijPo5zSW+gie9RSF
	t18b3vD7WJczwkEyZ2pYCCk3Iuibr7n7m+TFYLUMahLHHzdSCk1cWP9wk4j+
X-Google-Smtp-Source: AGHT+IHAnX8kQ+Clo5ruadMvbypU2LOAja1O3DgOag5vcAqfIPOflwwRBljOJwm/eLgcwgQdGwCCtQ==
X-Received: by 2002:a0c:aa95:0:b0:68c:ae6d:2abb with SMTP id f21-20020a0caa95000000b0068cae6d2abbmr1093590qvb.15.1707857768994;
        Tue, 13 Feb 2024 12:56:08 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUOs89M6l99N7nu9JXEksj/7SRm8rptljHVHYSfvP6NasFPc8NhDbzCthDKR1ZFztGIfRFhJPpG03JQrJJwqdbVYw==
Received: from electric.. (c-69-140-100-37.hsd1.md.comcast.net. [69.140.100.37])
        by smtp.gmail.com with ESMTPSA id nh9-20020a056214390900b0068c6d56d4f7sm1595570qvb.92.2024.02.13.12.56.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Feb 2024 12:56:08 -0800 (PST)
From: James Carter <jwcart2@gmail.com>
To: selinux@vger.kernel.org
Cc: cgzones@googlemail.com,
	James Carter <jwcart2@gmail.com>
Subject: [PATCH] checkpolicy, libsepol: Fix potential double free of mls_level_t
Date: Tue, 13 Feb 2024 15:56:05 -0500
Message-ID: <20240213205605.830719-1-jwcart2@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In checkpolicy, sensitivities that have aliases will temporarily
share the mls_level_t structure until a level statement defines the
categories for the level and the alias is updated to have its own
mls_level_t structure. Currently, this does not cause a problem
because checkpolicy does very little clean-up before exiting when
an error is detected. But if the policydb is destroyed before exiting
due to an error after a sensitivity and its alias is declared, but
before a level statement involving either of them, then a double
free of the shared mls_level_t will occur.

The defined field of the level_datum_t is set after a level statement
is processed for the level_datum_t. This means that we know the alias
has its own mls_level_t if the defined field is set. This means that
the defined field can be used to determine whether or not the
mls_level_t pointed to by an alias level_datum_t should be destroyed.

Since the defined field is not set when reading or expanding a policy,
update libsepol to set the defined field.

Signed-off-by: James Carter <jwcart2@gmail.com>
---
 checkpolicy/policy_define.c | 11 +++++++----
 libsepol/src/expand.c       |  1 +
 libsepol/src/policydb.c     |  7 +++++--
 3 files changed, 13 insertions(+), 6 deletions(-)

diff --git a/checkpolicy/policy_define.c b/checkpolicy/policy_define.c
index 260e609d..542bb978 100644
--- a/checkpolicy/policy_define.c
+++ b/checkpolicy/policy_define.c
@@ -1006,9 +1006,10 @@ static int clone_level(hashtab_key_t key __attribute__ ((unused)), hashtab_datum
 	mls_level_t *level = (mls_level_t *) arg, *newlevel;
 
 	if (levdatum->level == level) {
-		levdatum->defined = 1;
-		if (!levdatum->isalias)
+		if (!levdatum->isalias) {
+			levdatum->defined = 1;
 			return 0;
+		}
 		newlevel = (mls_level_t *) malloc(sizeof(mls_level_t));
 		if (!newlevel)
 			return -1;
@@ -1017,6 +1018,7 @@ static int clone_level(hashtab_key_t key __attribute__ ((unused)), hashtab_datum
 			return -1;
 		}
 		levdatum->level = newlevel;
+		levdatum->defined = 1;
 	}
 	return 0;
 }
@@ -1057,8 +1059,6 @@ int define_level(void)
 	}
 	free(id);
 
-	levdatum->defined = 1;
-
 	while ((id = queue_remove(id_queue))) {
 		cat_datum_t *cdatum;
 		int range_start, range_end, i;
@@ -1121,6 +1121,9 @@ int define_level(void)
 		free(id);
 	}
 
+	if (!levdatum->isalias)
+		levdatum->defined = 1;
+
 	if (hashtab_map
 	    (policydbp->p_levels.table, clone_level, levdatum->level)) {
 		yyerror("out of memory");
diff --git a/libsepol/src/expand.c b/libsepol/src/expand.c
index e63414b1..0e16c502 100644
--- a/libsepol/src/expand.c
+++ b/libsepol/src/expand.c
@@ -1191,6 +1191,7 @@ static int sens_copy_callback(hashtab_key_t key, hashtab_datum_t datum,
 		goto out_of_mem;
 	}
 	new_level->isalias = level->isalias;
+	new_level->defined = 1;
 	state->out->p_levels.nprim++;
 
 	if (hashtab_insert(state->out->p_levels.table,
diff --git a/libsepol/src/policydb.c b/libsepol/src/policydb.c
index f10a8a95..0c950bf1 100644
--- a/libsepol/src/policydb.c
+++ b/libsepol/src/policydb.c
@@ -1390,8 +1390,10 @@ static int sens_destroy(hashtab_key_t key, hashtab_datum_t datum, void *p
 	if (key)
 		free(key);
 	levdatum = (level_datum_t *) datum;
-	mls_level_destroy(levdatum->level);
-	free(levdatum->level);
+	if (!levdatum->isalias || levdatum->defined) {
+		mls_level_destroy(levdatum->level);
+		free(levdatum->level);
+	}
 	level_datum_destroy(levdatum);
 	free(levdatum);
 	return 0;
@@ -3357,6 +3359,7 @@ static int sens_read(policydb_t * p
 		goto bad;
 
 	levdatum->isalias = le32_to_cpu(buf[1]);
+	levdatum->defined = 1;
 
 	levdatum->level = malloc(sizeof(mls_level_t));
 	if (!levdatum->level || mls_read_level(levdatum->level, fp))
-- 
2.43.0

