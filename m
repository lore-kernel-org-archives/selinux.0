Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90A9AA55
	for <selinux@vger.kernel.org>; Thu, 29 May 2025 09:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748510803; cv=none; b=K8DQxMfuO9D4VwKhzwIAzVA2eC2NieBRi2YS4eUO92AhlgYkldALFVkOUoWzaPQZksTWqy7giJkGZV4g7eJHw6U7Z5zMlag0TPuX+jDHj8pNtSFZdrr8WWhOFkhXQlLtMbmbNbHP45B22kcxuO84AoK1kaPz5MUBE9v+YK9tYvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748510803; c=relaxed/simple;
	bh=6TgBPWdaaF51EZ//PkpwUIpVExca7NEHiH53EEf21MI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=j7B+rqP1bN1qkpMm1lEjqrUnXojusG3hdWXrIcmaaRhsYihGyJxhA/jp0xua7Y1N0QbmCbfhIUUL2UQLSZK6ONQ1vBKlrOfvwCLBQbQ22EkzTrqL6v/uQpt/R6ToOtm3Ao+Bxyb9ze+Pd+BjQ2ZdaQ4kYqy+lIpNVJzvYUQwrTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--inseob.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=J54fOssD; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--inseob.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="J54fOssD"
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-b2c0cbf9fddso539572a12.3
        for <selinux@vger.kernel.org>; Thu, 29 May 2025 02:26:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1748510801; x=1749115601; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=g4YyFjxjXv2eo1t0OiQzDXtgS4eyuNbzdthzfXx3QMc=;
        b=J54fOssDyS9Hp0EhjMKkpJBZLeDFMNjTImCi5OOggbnU5Hxo/PUubh3TL0VUfp5lWu
         SL4Mv+KFF/4+1cOInWUduNQOw3bwFG43WKLa5lNlcbvOxpE9SLmFT7ZwZUllvVzN3Gs4
         u2PgSKxN6o63Gbz5EOm1RjbIJiwEhFFSN+umbWND1nr/cJo58p7gT4mB1aI6zgD4yeTG
         Sm3A0csyx/pJ7pV9QwLYthVHDkdcAP9DuJg+JpvdJfZp3aXDUoh5OWmBVVxbvt20YA9/
         P9FeWq1ceRvJIA6A8yq9/HE7+UCus+n5rE52VkVrgNqZ0VxHYRZhiaZ2QaRfT6RpExd6
         jSiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748510801; x=1749115601;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=g4YyFjxjXv2eo1t0OiQzDXtgS4eyuNbzdthzfXx3QMc=;
        b=NXcTz3wbWCry6UTM8+jb5dy2+j+9yyIiq9dvuIXUn0DfBIlh9UI0ei+n+LLVz8Y1uU
         m/ubi9VToGpTT/qJt+sXxbltZ7Q8aXjfE4yHU0wCUIunxzxv6597Xip5fJS7fxfWB7sJ
         Y3hxtGvfOJBv8+GluChlrBXYEmsam4m5iJjFMy5ROviTcxRVaLRZts3UKbfRRvNRL/lg
         dx/ug8brc1lAZ/AuBeYy7lgm63ixhJgsx30oUV5PjRxXf5sNhzK59muID89o9sn/FpUX
         px4GizXNlZ6osIMW/aj7+2AU9sW78T7KSb93dIzTIqnSTvspKj3tbYIuxWp69tcUvH7P
         9j8g==
X-Gm-Message-State: AOJu0Yz/JfifFBU1xTfQ2M2SX+tW9D/YNzCmo5iVaYj5qvzcm4W1q063
	gBxWAxoJn07GXwVRz4eu+m9zEjeqyVS1QUP4S7VxExtfX8MNqQKH5iLWv8GyFccymvBBO5QExAN
	UR93HGVN0RYbIurmcrC6VRXn6Or/K6oHudc8tl6ogEOOPHlj/jWfB5OkkfKqm6h/cT6dJq60js5
	7IKFVFg2pszlKBfxjFeG5G2Uw5Lt45aFniwlU+YQ==
X-Google-Smtp-Source: AGHT+IGe3rh8BQd595j82LH3PIvZNS3Dn4QsLCj1OSSZcqCpTzaAfs+yxR1qfgAm5nJjU5MDRqOymm3LIaU=
X-Received: from plpi15.prod.google.com ([2002:a17:903:3c6f:b0:223:4c5f:3494])
 (user=inseob job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:f790:b0:234:f6ba:e68a
 with SMTP id d9443c01a7336-234f6bae7cfmr39525195ad.45.1748510800712; Thu, 29
 May 2025 02:26:40 -0700 (PDT)
Date: Thu, 29 May 2025 09:26:33 +0000
In-Reply-To: <20250529092633.1057963-1-inseob@google.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250529092633.1057963-1-inseob@google.com>
X-Mailer: git-send-email 2.49.0.1238.gf8c92423fb-goog
Message-ID: <20250529092633.1057963-2-inseob@google.com>
Subject: [PATCH 2/2] libsepol: Support genfs_seclabel_wildcard
From: Inseob Kim <inseob@google.com>
To: selinux@vger.kernel.org
Cc: takayas@google.com, tweek@google.com, stephen.smalley.work@gmail.com, 
	Inseob Kim <inseob@google.com>
Content-Type: text/plain; charset="UTF-8"

This adds genfs_seclabel_wildcard support to libsepol, which makes genfs
paths wildcard-matched. To support backward compatibility and to keep
semantics of genfscon statements, an asterisk '*' is added to paths of
genfscon statements when compiling CIL/conf files having policycap
genfs_seclabel_wildcard.

Signed-off-by: Inseob Kim <inseob@google.com>
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
index 1aa9b30a..9f3495f5 100644
--- a/libsepol/include/sepol/policydb/polcaps.h
+++ b/libsepol/include/sepol/policydb/polcaps.h
@@ -16,6 +16,7 @@ enum {
 	POLICYDB_CAP_GENFS_SECLABEL_SYMLINKS,
 	POLICYDB_CAP_IOCTL_SKIP_CLOEXEC,
 	POLICYDB_CAP_USERSPACE_INITIAL_CONTEXT,
+	POLICYDB_CAP_GENFS_SECLABEL_WILDCARD,
 	POLICYDB_CAP_NETLINK_XPERM,
 	__POLICYDB_CAP_MAX
 };
diff --git a/libsepol/src/kernel_to_cil.c b/libsepol/src/kernel_to_cil.c
index ddca2b62..33ee59fb 100644
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
+				                         fstype, name_len, name, file_type, ctx);
 			} else {
-				rc = strs_create_and_add(strs, "(genfscon %s \"%s\" %s)",
-										 fstype, name, ctx);
+				rc = strs_create_and_add(strs, "(genfscon %s \"%.*s\" %s)",
+				                         fstype, name_len, name, ctx);
 			}
 			free(ctx);
 			if (rc != 0) {
diff --git a/libsepol/src/kernel_to_conf.c b/libsepol/src/kernel_to_conf.c
index 661546af..dac6fce9 100644
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
+				                         fstype, name_len, name, file_type, ctx);
 			} else {
-				rc = strs_create_and_add(strs, "genfscon %s \"%s\" %s",
-										 fstype, name, ctx);
+				rc = strs_create_and_add(strs, "genfscon %s \"%.*s\" %s",
+				                         fstype, name_len, name, ctx);
 			}
 			free(ctx);
 			if (rc != 0) {
diff --git a/libsepol/src/polcaps.c b/libsepol/src/polcaps.c
index 6b28c84e..a6fad2a9 100644
--- a/libsepol/src/polcaps.c
+++ b/libsepol/src/polcaps.c
@@ -15,6 +15,7 @@ static const char * const polcap_names[POLICYDB_CAP_MAX + 1] = {
 	[POLICYDB_CAP_GENFS_SECLABEL_SYMLINKS]		= "genfs_seclabel_symlinks",
 	[POLICYDB_CAP_IOCTL_SKIP_CLOEXEC]		= "ioctl_skip_cloexec",
 	[POLICYDB_CAP_USERSPACE_INITIAL_CONTEXT]	= "userspace_initial_context",
+	[POLICYDB_CAP_GENFS_SECLABEL_WILDCARD]		= "genfs_seclabel_wildcard",
 	[POLICYDB_CAP_NETLINK_XPERM]			= "netlink_xperm",
 };
 
-- 
2.49.0.1238.gf8c92423fb-goog

