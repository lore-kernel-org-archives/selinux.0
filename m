Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56E7820C006
	for <selinux@vger.kernel.org>; Fri, 13 Jun 2025 04:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749788869; cv=none; b=Ce+eWAJL7Pi6pFQI1L3AWOGEW40wphFilyyqXHQnZRDeG9wtKR5jcXmKr/YVPKgKOUcPgu0PMrceM0IH42HT1pVb1F/pAmGS+SDXSp7WZRyHIAUK7IOEiaJm7Y4nw7VUB1S+XmzIqIEBSthaHUqPO7sKb25FHsu0hBM0Igj7SwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749788869; c=relaxed/simple;
	bh=jTRTc5J6MMBsjszpBqOI4IWWTxdUdO3v6KmRTWWMvs0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Q2tnwsr39rVI9AHS4v6n4GQibYuwR/Soz8YT4eUA8+vhLjIMCWYpNg0tTKl8q+DAeEgRFIGnb1CptJwQjyt3vA4OBuxCm6HgyM31++xbkf19bmT6pQx01VHFWXZ7PTVFawQploxItQUI91zzxOhcXkreUQyYedhG8d9mzJQJBzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--inseob.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=AQHpGYTM; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--inseob.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AQHpGYTM"
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-b2eeff19115so2083347a12.0
        for <selinux@vger.kernel.org>; Thu, 12 Jun 2025 21:27:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1749788868; x=1750393668; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=3As22K5kcX1AuC7emyPT084DsXTdjVYPQyZMK638k0E=;
        b=AQHpGYTMk4eYhQbcaMjvUgpHvZjebZTPJ55a0pXhhIlkYuUX/L3aTkCpfA7ckDoGVJ
         H0HOWvzAYoNJYEHmx3PFPTPgVYTdrzD+04WymCrJHwFYS5hfz14VCqun1jT56rwAhHrY
         NSE+M33XLF8Eickj9rABoDFtrSQngGSysW7uK2RFawmWbc2wjtSCjZ0X2Z9kcOAcafXZ
         hx2CrgVf3SPvTMBs6YRqlVr50X6pDQlLWYXpCwfXegxFpKfnN0KKxNhtcC8/4rBTtA/N
         pOwNoxMpdO7vHzNj2jYxdVIX9r/5fqna17k2km0w+d7h+PpqAhAFVpxzUUTkoMz745tX
         xx7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749788868; x=1750393668;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3As22K5kcX1AuC7emyPT084DsXTdjVYPQyZMK638k0E=;
        b=auYQZFz3oekqGEgWA8GQ6IqWxrs1Vkv4uHZ8rcW4z9NGUuv35z87SW2oQ3TJ3b4tV8
         /Z5fOQUy9Eegz6PnV8194ZhC2gIRq9GAEQaCKIKrjPqy9eFDbU6HnNA2cshVV4hlTQ+s
         AIBl03Y6f06wy3ZpYcIROeg1Ra0SOAT/d5cbBqLk2k1yjqLMFwZ4xXumftV31mByrSl5
         X2jGyv2nTOKoRbWGLP7yG8pX/wRvqR89pohHHW1edpwfTHguKLlXTbFk+7ppJ7RYaXvO
         28RDtbeognZSr8zXz39lLEywvmAZ2hSlqXQgb6UdCcurogY6n9QVIuAGsriljKyAZ/8L
         nhdg==
X-Gm-Message-State: AOJu0Yw/gzMla9EXQZKjMK/a3wu6NCdqfHtCl5w464JywRxVouddXCeJ
	CVQK0kpJXHqyJAYnWZs7FjUDMUR7XW8w/F2VVpDt21HZZmdghTfi1omJUwgrgudBgjCy94lUFPJ
	OrS+cZa1I9Qi4cUz+QR1yKI7oPhj71nDUko/mHI5o2ded4Yb306MwAFMEmd/57M0lhI9a+E4SEg
	dm/OiWyfCeSg9v/gxfRLicWusTa8t2Vdj95D365Q==
X-Google-Smtp-Source: AGHT+IEqP71oYcWCQ8+HKDqFyODCYzKDC4wBWW53RpsMBIXmGPJ5tTQ8rG5j4IMrQcz8KKo1iYFANrW4eZo=
X-Received: from pflr18.prod.google.com ([2002:aa7:9892:0:b0:746:270f:79c0])
 (user=inseob job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:3291:b0:21f:4631:811c
 with SMTP id adf61e73a8af0-21facebb1ecmr2045339637.19.1749788867364; Thu, 12
 Jun 2025 21:27:47 -0700 (PDT)
Date: Fri, 13 Jun 2025 04:27:37 +0000
In-Reply-To: <20250613042737.485384-1-inseob@google.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250613042737.485384-1-inseob@google.com>
X-Mailer: git-send-email 2.50.0.rc2.692.g299adb8693-goog
Message-ID: <20250613042737.485384-2-inseob@google.com>
Subject: [PATCH v3 2/2] libsepol: Support genfs_seclabel_wildcard
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

Changes since v2:
- Use cil_malloc, not plain malloc
---
 checkpolicy/policy_define.c               | 14 ++++++++++++++
 libsepol/cil/src/cil_binary.c             | 11 ++++++++++-
 libsepol/include/sepol/policydb/polcaps.h |  1 +
 libsepol/src/kernel_to_cil.c              | 20 ++++++++++++++++----
 libsepol/src/kernel_to_conf.c             | 20 ++++++++++++++++----
 libsepol/src/polcaps.c                    |  1 +
 6 files changed, 58 insertions(+), 9 deletions(-)

diff --git a/checkpolicy/policy_define.c b/checkpolicy/policy_define.c
index 4e0ddcc6..7029b834 100644
--- a/checkpolicy/policy_define.c
+++ b/checkpolicy/policy_define.c
@@ -6010,6 +6010,7 @@ static int define_genfs_context_helper(char *fstype, int has_type)
 	char *type = NULL;
 	const char *sclass;
 	size_t len, len2;
+	int wildcard = ebitmap_get_bit(&policydbp->policycaps, POLICYDB_CAP_GENFS_SECLABEL_WILDCARD);
 
 	if (policydbp->target_platform != SEPOL_TARGET_SELINUX) {
 		yyerror("genfs not supported for target");
@@ -6060,6 +6061,19 @@ static int define_genfs_context_helper(char *fstype, int has_type)
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
index 6b17e7f4..74ec3cd5 100644
--- a/libsepol/cil/src/cil_binary.c
+++ b/libsepol/cil/src/cil_binary.c
@@ -3770,6 +3770,7 @@ int cil_genfscon_to_policydb(policydb_t *pdb, struct cil_sort *genfscons)
 	uint32_t i = 0;
 	genfs_t *genfs_tail = NULL;
 	ocontext_t *ocon_tail = NULL;
+	int wildcard = ebitmap_get_bit(&pdb->policycaps, POLICYDB_CAP_GENFS_SECLABEL_WILDCARD);
 
 	for (i = 0; i < genfscons->count; i++) {
 		struct cil_genfscon *cil_genfscon = genfscons->array[i];
@@ -3794,7 +3795,15 @@ int cil_genfscon_to_policydb(policydb_t *pdb, struct cil_sort *genfscons)
 
 		ocon_tail = new_ocon;
 
-		new_ocon->u.name = cil_strdup(cil_genfscon->path_str);
+		if (wildcard) {
+			size_t name_len = strlen(cil_genfscon->path_str);
+			new_ocon->u.name = cil_malloc(name_len + 2);
+			memcpy(new_ocon->u.name, cil_genfscon->path_str, name_len);
+			new_ocon->u.name[name_len] = '*';
+			new_ocon->u.name[name_len + 1] = '\0';
+		} else {
+			new_ocon->u.name = cil_strdup(cil_genfscon->path_str);
+		}
 
 		if (cil_genfscon->file_type != CIL_FILECON_ANY) {
 			class_datum_t *class_datum;
diff --git a/libsepol/include/sepol/policydb/polcaps.h b/libsepol/include/sepol/policydb/polcaps.h
index 1aa9b30a..72147665 100644
--- a/libsepol/include/sepol/policydb/polcaps.h
+++ b/libsepol/include/sepol/policydb/polcaps.h
@@ -17,6 +17,7 @@ enum {
 	POLICYDB_CAP_IOCTL_SKIP_CLOEXEC,
 	POLICYDB_CAP_USERSPACE_INITIAL_CONTEXT,
 	POLICYDB_CAP_NETLINK_XPERM,
+	POLICYDB_CAP_GENFS_SECLABEL_WILDCARD,
 	__POLICYDB_CAP_MAX
 };
 #define POLICYDB_CAP_MAX (__POLICYDB_CAP_MAX - 1)
diff --git a/libsepol/src/kernel_to_cil.c b/libsepol/src/kernel_to_cil.c
index 6fea2c6f..4da63ba5 100644
--- a/libsepol/src/kernel_to_cil.c
+++ b/libsepol/src/kernel_to_cil.c
@@ -2750,6 +2750,8 @@ static int write_genfscon_rules_to_cil(FILE *out, struct policydb *pdb)
 	uint32_t sclass;
 	const char *file_type;
 	int rc;
+	int wildcard = ebitmap_get_bit(&pdb->policycaps, POLICYDB_CAP_GENFS_SECLABEL_WILDCARD);
+	size_t name_len;
 
 	rc = strs_init(&strs, 32);
 	if (rc != 0) {
@@ -2791,12 +2793,22 @@ static int write_genfscon_rules_to_cil(FILE *out, struct policydb *pdb)
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
index b3b0f224..6d608443 100644
--- a/libsepol/src/kernel_to_conf.c
+++ b/libsepol/src/kernel_to_conf.c
@@ -2598,6 +2598,8 @@ static int write_genfscon_rules_to_conf(FILE *out, struct policydb *pdb)
 	uint32_t sclass;
 	const char *file_type;
 	int rc;
+	int wildcard = ebitmap_get_bit(&pdb->policycaps, POLICYDB_CAP_GENFS_SECLABEL_WILDCARD);
+	size_t name_len;
 
 	rc = strs_init(&strs, 32);
 	if (rc != 0) {
@@ -2639,12 +2641,22 @@ static int write_genfscon_rules_to_conf(FILE *out, struct policydb *pdb)
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
index 6b28c84e..0bd26df8 100644
--- a/libsepol/src/polcaps.c
+++ b/libsepol/src/polcaps.c
@@ -16,6 +16,7 @@ static const char * const polcap_names[POLICYDB_CAP_MAX + 1] = {
 	[POLICYDB_CAP_IOCTL_SKIP_CLOEXEC]		= "ioctl_skip_cloexec",
 	[POLICYDB_CAP_USERSPACE_INITIAL_CONTEXT]	= "userspace_initial_context",
 	[POLICYDB_CAP_NETLINK_XPERM]			= "netlink_xperm",
+	[POLICYDB_CAP_GENFS_SECLABEL_WILDCARD]		= "genfs_seclabel_wildcard",
 };
 
 int sepol_polcap_getnum(const char *name)
-- 
2.50.0.rc2.692.g299adb8693-goog

