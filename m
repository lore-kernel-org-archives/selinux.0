Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B08C11EB195
	for <selinux@vger.kernel.org>; Fri, 30 May 2025 05:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748582019; cv=none; b=MH3kY13nw7yuazu9cZt6QnMwc5txpVqq5aAzFWjUQDloopMkX9NXlDQudFYemempt3Ymp1GSKapgMQt3lzeoIHgOqZZwq3GTF06YgqkuzZno0VmT9RQvlMNGyf5mupPkVgWDhtmVFKUK0bqPEV7/EEC3bVBgBjI9LvNswpIm67U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748582019; c=relaxed/simple;
	bh=MUUSfb+GsoYK9rwRZjXKZ/BVOwkRIFYgg4ZO90PY9qw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=q6V6u2kHnKV2PqBLkC58fl/vJmbHV54go9zrCMgefTcu/rwrdz+92hwSYpvUj34cLt7Pa8Rb5IZRPKVr1G1kJma7EzoyCcI5X6PN4Q4CksgrLFIWe1v2397KK5MHadv7jG0M/9o/pRzZ1DqMtSt92BkDRPcIY2zLaCXQsO9hlf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--inseob.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=iBt+cdDR; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--inseob.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iBt+cdDR"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2349fe5be47so12783415ad.0
        for <selinux@vger.kernel.org>; Thu, 29 May 2025 22:13:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1748582017; x=1749186817; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=KbOBP3CRoXku/iUEhpbS7UyITD9Ytqt0OxLXgigfgXc=;
        b=iBt+cdDRiJHMqNFiuDRu5ZMo/+KWaYeNTvfxeyx0Pb2tnt2HRmGbYjvXd4sDUJtaGI
         j/+4g8dohTj2krb6EYWyPtEX0NZU0HPZgHtXNYB5iACzmob8TyPx/mmcN1EX0v/6cTYt
         1oxRkkA/YDxmMCwz7kL9KpmHCumrQZUo8GdZ6N5kWdK1tz1WKDgrZ2r1iDWZ+afnPDI8
         Wv5hVZNwgke0S1bs5np6oD7nKFVvc9mlrfIXSBg/ztPCZQwSuuMqdtq8yP6dzmsjUaw5
         ZAddH3BJYB0jQv7NjERk5jjIHnJcB40j04qDVZSkvTTANUfi08Z0iwBecKL75LvoFSs8
         Ehvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748582017; x=1749186817;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KbOBP3CRoXku/iUEhpbS7UyITD9Ytqt0OxLXgigfgXc=;
        b=TE2cjD6NiOVbjAz60vMziIpmXyJfn6EcRi4jCs1hbnn+kckDvupPaVJZ+0goGuHdqD
         kZ0vavflDycbBwz+JKy+qvTc7ttpc3Zg95LkrX/w4Pet65aIYogRtwg4kLYDL7Hp1+wt
         NS2z6hV+9iWMuq/NBxofX9xo920b4r81seS7R4fnkfX9vGpT3TROZwb8fOW7FG2OMzIV
         CK2gZpA1qzL2rAA6GBrRF7PoQESKrrCmD73vsf8/00HFh4Xi0vJI9xVnbP6rJVOA0kBR
         Ddfq8XGqRQjvAAt4Qea/jiECi6k1YBV1YXG3X63/YAtQasgDZSZFNKPVRj9H54UlOgTi
         NYEQ==
X-Gm-Message-State: AOJu0Yxv1wYmQr/hsn4N+sKckMpOe/pbZZkyGvH8qUUe1x81LicgbEQv
	c15upPFSH/Q+InF4zKJw/c3G9sEucE5pKx02MDYq9OrAYPQedzKU+9H32oZCpG3gyjegkO7MFfV
	dG7t+AHCQDD1+RYIc9+dkeFTBikTYZkt1KvExqUUW6lIKyb6hk3d5JJnmuSSg1TE/j/FcPZ0kwD
	M6qtnH0GIyOIprCOzt32yI1QLHi8Zr8GrjCFRQPA==
X-Google-Smtp-Source: AGHT+IFKhjaQgfTSwZ52cVIPLf4OoY05F12D2B5v6sdPyfDEYqpNiTVT9buBborhFt3YryVqxntQmGVp3is=
X-Received: from pgct5.prod.google.com ([2002:a05:6a02:5285:b0:b11:3ba:92e4])
 (user=inseob job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:cf0a:b0:224:26fd:82e5
 with SMTP id d9443c01a7336-23529b4637emr36407905ad.48.1748582016749; Thu, 29
 May 2025 22:13:36 -0700 (PDT)
Date: Fri, 30 May 2025 05:13:22 +0000
In-Reply-To: <20250530051322.1678251-1-inseob@google.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250530051322.1678251-1-inseob@google.com>
X-Mailer: git-send-email 2.49.0.1238.gf8c92423fb-goog
Message-ID: <20250530051322.1678251-3-inseob@google.com>
Subject: [PATCH v2 3/3] libsepol: Support genfs_seclabel_wildcard
From: Inseob Kim <inseob@google.com>
To: selinux@vger.kernel.org
Cc: takayas@google.com, tweek@google.com, stephen.smalley.work@gmail.com, 
	cgzones@googlemail.com, Inseob Kim <inseob@google.com>
Content-Type: text/plain; charset="UTF-8"

This adds genfs_seclabel_wildcard support to libsepol, which makes genfs
paths wildcard-matched. To support backward compatibility and to keep
semantics of genfscon statements, an asterisk '*' is added to paths of
genfscon statements when compiling CIL/conf files having policycap
genfs_seclabel_wildcard.

Signed-off-by: Inseob Kim <inseob@google.com>

Changes since v1:
- Sync the order of polcaps with the kernel
- Cast to int for printf precision arguments
---
 checkpolicy/policy_define.c               | 14 ++++++++++++++
 libsepol/cil/src/cil_binary.c             | 15 ++++++++++++++-
 libsepol/include/sepol/policydb/polcaps.h |  1 +
 libsepol/src/kernel_to_cil.c              | 20 ++++++++++++++++----
 libsepol/src/kernel_to_conf.c             | 20 ++++++++++++++++----
 libsepol/src/polcaps.c                    |  1 +
 6 files changed, 62 insertions(+), 9 deletions(-)

diff --git a/checkpolicy/policy_define.c b/checkpolicy/policy_define.c
index 78adbec0..868b8214 100644
--- a/checkpolicy/policy_define.c
+++ b/checkpolicy/policy_define.c
@@ -5967,6 +5967,7 @@ static int define_genfs_context_helper(char *fstype, int has_type)
 	char *type = NULL;
 	const char *sclass;
 	size_t len, len2;
+	int wildcard = ebitmap_get_bit(&policydbp->policycaps, POLICYDB_CAP_GENFS_SECLABEL_WILDCARD);
 
 	if (policydbp->target_platform != SEPOL_TARGET_SELINUX) {
 		yyerror("genfs not supported for target");
@@ -6017,6 +6018,19 @@ static int define_genfs_context_helper(char *fstype, int has_type)
 	newc->u.name = (char *)queue_remove(id_queue);
 	if (!newc->u.name)
 		goto fail;
+
+	if (wildcard) {
+		size_t name_len = strlen(newc->u.name);
+		newc->u.name = realloc(newc->u.name, name_len + 2);
+		if (newc->u.name == NULL) {
+			yyerror("out of memory");
+			return -1;
+		}
+
+		newc->u.name[name_len] = '*';
+		newc->u.name[name_len + 1] = '\0';
+	}
+
 	if (has_type) {
 		type = (char *)queue_remove(id_queue);
 		if (!type)
diff --git a/libsepol/cil/src/cil_binary.c b/libsepol/cil/src/cil_binary.c
index b0befda3..b2c940f9 100644
--- a/libsepol/cil/src/cil_binary.c
+++ b/libsepol/cil/src/cil_binary.c
@@ -3749,6 +3749,7 @@ int cil_genfscon_to_policydb(policydb_t *pdb, struct cil_sort *genfscons)
 	uint32_t i = 0;
 	genfs_t *genfs_tail = NULL;
 	ocontext_t *ocon_tail = NULL;
+	int wildcard = ebitmap_get_bit(&pdb->policycaps, POLICYDB_CAP_GENFS_SECLABEL_WILDCARD);
 
 	for (i = 0; i < genfscons->count; i++) {
 		struct cil_genfscon *cil_genfscon = genfscons->array[i];
@@ -3773,7 +3774,19 @@ int cil_genfscon_to_policydb(policydb_t *pdb, struct cil_sort *genfscons)
 
 		ocon_tail = new_ocon;
 
-		new_ocon->u.name = cil_strdup(cil_genfscon->path_str);
+		if (wildcard) {
+			size_t name_len = strlen(cil_genfscon->path_str);
+			new_ocon->u.name = malloc(name_len + 2);
+			if (new_ocon->u.name == NULL) {
+				cil_log(CIL_ERR, "Failed to allocate memory\n");
+				exit(1);
+			}
+			memcpy(new_ocon->u.name, cil_genfscon->path_str, name_len);
+			new_ocon->u.name[name_len] = '*';
+			new_ocon->u.name[name_len + 1] = '\0';
+		} else {
+			new_ocon->u.name = cil_strdup(cil_genfscon->path_str);
+		}
 
 		if (cil_genfscon->file_type != CIL_FILECON_ANY) {
 			class_datum_t *class_datum;
diff --git a/libsepol/include/sepol/policydb/polcaps.h b/libsepol/include/sepol/policydb/polcaps.h
index 7bebe4da..0835ea21 100644
--- a/libsepol/include/sepol/policydb/polcaps.h
+++ b/libsepol/include/sepol/policydb/polcaps.h
@@ -18,6 +18,7 @@ enum {
 	POLICYDB_CAP_USERSPACE_INITIAL_CONTEXT,
 	POLICYDB_CAP_NETLINK_XPERM,
 	POLICYDB_CAP_NETIF_WILDCARD,
+	POLICYDB_CAP_GENFS_SECLABEL_WILDCARD,
 	__POLICYDB_CAP_MAX
 };
 #define POLICYDB_CAP_MAX (__POLICYDB_CAP_MAX - 1)
diff --git a/libsepol/src/kernel_to_cil.c b/libsepol/src/kernel_to_cil.c
index ddca2b62..e69e1663 100644
--- a/libsepol/src/kernel_to_cil.c
+++ b/libsepol/src/kernel_to_cil.c
@@ -2708,6 +2708,8 @@ static int write_genfscon_rules_to_cil(FILE *out, struct policydb *pdb)
 	uint32_t sclass;
 	const char *file_type;
 	int rc;
+	int wildcard = ebitmap_get_bit(&pdb->policycaps, POLICYDB_CAP_GENFS_SECLABEL_WILDCARD);
+	size_t name_len;
 
 	rc = strs_init(&strs, 32);
 	if (rc != 0) {
@@ -2749,12 +2751,22 @@ static int write_genfscon_rules_to_cil(FILE *out, struct policydb *pdb)
 				goto exit;
 			}
 
+			name_len = strlen(name);
+			if (wildcard) {
+				if (name_len == 0 || name[name_len - 1] != '*') {
+					ERR(NULL, "genfscon path must end with '*' when genfs_seclabel_wildcard");
+					rc = -1;
+					goto exit;
+				}
+				--name_len;
+			}
+
 			if (file_type) {
-				rc = strs_create_and_add(strs, "(genfscon %s \"%s\" %s %s)",
-										 fstype, name, file_type, ctx);
+				rc = strs_create_and_add(strs, "(genfscon %s \"%.*s\" %s %s)",
+				                         fstype, (int)name_len, name, file_type, ctx);
 			} else {
-				rc = strs_create_and_add(strs, "(genfscon %s \"%s\" %s)",
-										 fstype, name, ctx);
+				rc = strs_create_and_add(strs, "(genfscon %s \"%.*s\" %s)",
+				                         fstype, (int)name_len, name, ctx);
 			}
 			free(ctx);
 			if (rc != 0) {
diff --git a/libsepol/src/kernel_to_conf.c b/libsepol/src/kernel_to_conf.c
index 661546af..a7160997 100644
--- a/libsepol/src/kernel_to_conf.c
+++ b/libsepol/src/kernel_to_conf.c
@@ -2556,6 +2556,8 @@ static int write_genfscon_rules_to_conf(FILE *out, struct policydb *pdb)
 	uint32_t sclass;
 	const char *file_type;
 	int rc;
+	int wildcard = ebitmap_get_bit(&pdb->policycaps, POLICYDB_CAP_GENFS_SECLABEL_WILDCARD);
+	size_t name_len;
 
 	rc = strs_init(&strs, 32);
 	if (rc != 0) {
@@ -2597,12 +2599,22 @@ static int write_genfscon_rules_to_conf(FILE *out, struct policydb *pdb)
 				goto exit;
 			}
 
+			name_len = strlen(name);
+			if (wildcard) {
+				if (name_len == 0 || name[name_len - 1] != '*') {
+					ERR(NULL, "genfscon path must end with '*' when genfs_seclabel_wildcard");
+					rc = -1;
+					goto exit;
+				}
+				--name_len;
+			}
+
 			if (file_type) {
-				rc = strs_create_and_add(strs, "genfscon %s \"%s\" %s %s",
-										 fstype, name, file_type, ctx);
+				rc = strs_create_and_add(strs, "genfscon %s \"%.*s\" %s %s",
+				                         fstype, (int)name_len, name, file_type, ctx);
 			} else {
-				rc = strs_create_and_add(strs, "genfscon %s \"%s\" %s",
-										 fstype, name, ctx);
+				rc = strs_create_and_add(strs, "genfscon %s \"%.*s\" %s",
+				                         fstype, (int)name_len, name, ctx);
 			}
 			free(ctx);
 			if (rc != 0) {
diff --git a/libsepol/src/polcaps.c b/libsepol/src/polcaps.c
index ec6c902d..7ac0ae7c 100644
--- a/libsepol/src/polcaps.c
+++ b/libsepol/src/polcaps.c
@@ -17,6 +17,7 @@ static const char * const polcap_names[POLICYDB_CAP_MAX + 1] = {
 	[POLICYDB_CAP_USERSPACE_INITIAL_CONTEXT]	= "userspace_initial_context",
 	[POLICYDB_CAP_NETLINK_XPERM]			= "netlink_xperm",
 	[POLICYDB_CAP_NETIF_WILDCARD]			= "netif_wildcard",
+	[POLICYDB_CAP_GENFS_SECLABEL_WILDCARD]		= "genfs_seclabel_wildcard",
 };
 
 int sepol_polcap_getnum(const char *name)
-- 
2.49.0.1238.gf8c92423fb-goog

