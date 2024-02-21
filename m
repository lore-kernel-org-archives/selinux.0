Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com [209.85.219.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B4133A1DB
	for <selinux@vger.kernel.org>; Wed, 21 Feb 2024 21:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708549689; cv=none; b=i9ZbZnFltCkARC1tWGjRxq7ug4TuFKUhP5pGHLtw+LlbAIJgoH3NjKIj/L68hoG17Qz4p99Ie7BdJcv2927PvvxkL0pPtXdBpDDjB3DaBoQpR1WtCuBTR2Du3tt+guSHUaUB4PLvtTFk30/YGnmVmq4iqZ/6PCqK2droLgyOBxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708549689; c=relaxed/simple;
	bh=kNmisPuU8vqMuXGDqFtBV4skkF0kG+B01CpCKwI6HBI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=egQdLUso3pUyti1jF/2wa3vDcn8XGZM76ycwzJ1f/DFA7USLXZ8fITMO55RhvVasX+8v+66LauF/40mWEukHg0zd2IU5lxoKWz+DA9l77/9aXqzZIZ8R4QgRH6gnCH4OI13Em/NKtfHE3ApqF3nVknwv1qLZpBpurrRbtvoBx7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VB2v/MbD; arc=none smtp.client-ip=209.85.219.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VB2v/MbD"
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-dcc80d6004bso1250162276.0
        for <selinux@vger.kernel.org>; Wed, 21 Feb 2024 13:08:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708549686; x=1709154486; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PTOSr8eTEeyR/I4eZ+nJG/iPPz8e1J+oO9HXrfhMV6Y=;
        b=VB2v/MbDAKTzcQiI6V/CsXvCj8nfIfQGyRVN5S+YOXuh7nI/tis8lIo5o8Ov4XStIO
         myNfTriyNVFz3NAe6BaIb+A+dJrscPPZCPx4JwkZZ9r27k/kX4MPVM5u/zrz7eM+6Fcb
         QDXQymXH+wwx3Tu83oi6Yk0WGQRBmRnniEDkwmIWZXXcmhEM3k3ghrgkfhAVXHCy5/1m
         aYgmKywe8Hoxzsk0UqeM6SbEfJbvCNu6Srp2KquO7rQI8zgTBKT6jz1jMTggqUcllp+v
         YX4bJlRBUHkhE/nDt+Z+pK8ojkYvc5rGGnljc3iNK2YMkbqmG8WUF9PqJgqM1W9OJYWZ
         xvbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708549686; x=1709154486;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PTOSr8eTEeyR/I4eZ+nJG/iPPz8e1J+oO9HXrfhMV6Y=;
        b=v9mR3Zc4vDtX4yKpwPiT7XZgxwgamWHXGj9HRDRlXgdCRWykFzDL2ncmULf+XV8MY4
         6o16peemCkqLSOXhJSEQZ+yzH58w+NBN2fcc33zjS3FUAlqi/alzun/RF9j2E4fD588c
         kRXmJn6rghPV5SqWgrURNRAW+E7gq/MkjGbaefgSWSRmXv1Zv34RYbFkBNjEfhU2QKOP
         dUgqsIWoxO0HCc3JBFChEKk4bQmxWk0iZjoN/K3GWSSxXUI1QAfHMFd6bphNO9RlyAs9
         notKElc0HzbKBqNkDES5Wr/zM7+5lUtkVjchxG3DR7x+eOG28/24qk6MqoEs177Gd4cK
         bqGA==
X-Gm-Message-State: AOJu0Yy82ph0bMXGj7HOwZDItHsinmXeq/dxyp8yf/hxxXBSIV5SoHN4
	+KlJzO58NgqUbHEL9xFmaNnvtVpLqE/hB6Tc5YtzqZNbJONRy1g6ydmx9RoO
X-Google-Smtp-Source: AGHT+IFOnpruguYcif52keeQ84kYxPfsmwvTwhQEE9XIvjV9hkYvC630avKKna6uO1zEhOxh/dp57Q==
X-Received: by 2002:a25:ce0a:0:b0:dbf:6267:eba4 with SMTP id x10-20020a25ce0a000000b00dbf6267eba4mr483046ybe.27.1708549685773;
        Wed, 21 Feb 2024 13:08:05 -0800 (PST)
Received: from electric.. (c-69-140-100-37.hsd1.md.comcast.net. [69.140.100.37])
        by smtp.gmail.com with ESMTPSA id v1-20020a056902028100b00dc7622402b9sm2472502ybh.43.2024.02.21.13.08.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Feb 2024 13:08:05 -0800 (PST)
From: James Carter <jwcart2@gmail.com>
To: selinux@vger.kernel.org
Cc: cgzones@googlemail.com,
	James Carter <jwcart2@gmail.com>
Subject: [PATCH v2] checkpolicy, libsepol: Fix potential double free of mls_level_t
Date: Wed, 21 Feb 2024 16:07:59 -0500
Message-ID: <20240221210759.1310310-1-jwcart2@gmail.com>
X-Mailer: git-send-email 2.43.0
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

Signed-off-by: James Carter <jwcart2@gmail.com>
---
v2: Change the field name from "defined" to "notdefined" and change
    the logic to match.

 checkpolicy/checkpolicy.c                  |  7 +++----
 checkpolicy/policy_define.c                | 10 ++++++----
 libsepol/cil/src/cil_binary.c              |  3 ---
 libsepol/include/sepol/policydb/policydb.h |  2 +-
 libsepol/src/policydb.c                    |  6 ++++--
 5 files changed, 14 insertions(+), 14 deletions(-)

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
index 6682069e..66d93999 100644
--- a/libsepol/include/sepol/policydb/policydb.h
+++ b/libsepol/include/sepol/policydb/policydb.h
@@ -217,7 +217,7 @@ typedef struct user_datum {
 typedef struct level_datum {
 	mls_level_t *level;	/* sensitivity and associated categories */
 	unsigned char isalias;	/* is this sensitivity an alias for another? */
-	unsigned char defined;
+	unsigned char notdefined;
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
-- 
2.43.0

