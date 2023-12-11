Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="RB9eohdM"
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EB8FC3
	for <selinux@vger.kernel.org>; Mon, 11 Dec 2023 06:54:15 -0800 (PST)
Received: by mail-lf1-x12e.google.com with SMTP id 2adb3069b0e04-50bf2d9b3fdso5909799e87.3
        for <selinux@vger.kernel.org>; Mon, 11 Dec 2023 06:54:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1702306454; x=1702911254; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=hkB4uX3Hwz9lRdY6ubSx7g6l/fJfkhe4Zh7LzhrzemQ=;
        b=RB9eohdM35HeQzMjYSc8IgKCNX61TkosSrLMnt25qrkGcvWi0M6+YV/rwnZPMD5zPz
         kB/yeOiCj0kNQzjS0VJYVVgxb7RTZXo3K7YZ6C3F9CHzl6mBzgTOZTaZDz5w9eYLknXW
         hNjYAit+l4yc/X9GHkIc+pZVfW2jkdByvOmHCjcE6MsRPPI1BhrdMdamdJy4gbuWoq5T
         C0eqHHpwW+AvCxzYMjdwhx3A6nydO8ZybvkCi/gJPryYMIVOJH4APrRNB2EtsF9i2LNl
         oxP0Pc8HqIQjH/4mABjwfL0FT4mreDMir1tiCDAKN+JNl4700zWZy2CDiURIQVHwGfOL
         CaUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702306454; x=1702911254;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hkB4uX3Hwz9lRdY6ubSx7g6l/fJfkhe4Zh7LzhrzemQ=;
        b=aIrFUj41s1YjrdT5XXee1owyeFSt+MpZl5+t4R0Zhv+F6akmFsp0quUmxDo4oAOL7H
         Zc0htWbi1ChLrBxDkO4+C5NVgnmdm9Dx+K1k/f8dfxlUqCzGUtt06o4Q4SmTR0K7ijya
         Mcl0yOLYJDJTSdPob7UztTysFZegqwQ1WAU7dbtaKuAdtv63wKN7HkSa5zw+kkydnvGt
         lmOSqnNEYfXoGfe3EoKef96O7hTjXer7NYWtGpsy+r8/vD+tzg96RKGERZyVB/Y6pSYc
         qXyFC8OrlfyHL4pHHsUqUCeSLvqkVzoVFmXtAdqpkIeakfYQxB6Vf0VRvmWf07M8i6ek
         1h9Q==
X-Gm-Message-State: AOJu0YwKZEUU6iATGi0tJPVIH9NY2NMUc1FkXNQZVKk9ynWy5c1jmspu
	vHojAoMe6SaLUsYsU56tUOUhUbfXZ/0=
X-Google-Smtp-Source: AGHT+IHJIm9EZCGwRFHPUKzgEM+GSJJz7xYMxdV+XTqlnxDarl4YFT6JXtwby5VRw4RWKjnzRFb/2A==
X-Received: by 2002:a05:6512:4db:b0:50b:ed58:584c with SMTP id w27-20020a05651204db00b0050bed58584cmr1881230lfq.124.1702306453624;
        Mon, 11 Dec 2023 06:54:13 -0800 (PST)
Received: from debian_development.DebianHome (dynamic-077-001-173-175.77.1.pool.telefonica.de. [77.1.173.175])
        by smtp.gmail.com with ESMTPSA id uv8-20020a170907cf4800b00a1d232b39b9sm4869158ejc.184.2023.12.11.06.54.13
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Dec 2023 06:54:13 -0800 (PST)
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To: selinux@vger.kernel.org
Subject: [RFC PATCH] libsepol: handle long permission names in sepol_av_to_string()
Date: Mon, 11 Dec 2023 15:54:07 +0100
Message-ID: <20231211145408.124757-1-cgzones@googlemail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Use a growing dynamically allocated buffer to format permission names of
an access vector instead of a fixed static buffer to support very long
permission names.

This changes the behavior of the since libsepol 3.4 exported function
sepol_av_perm_to_string(): previously it returned a pointer to a static
buffer which must not be free'd by the caller, now an allocated string
which should be free'd by the caller (to avoid memory leaks).

Reported-by: oss-fuzz (issue 64832, 64933)
Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
The oss-fuzz issue 64832 got closed by the latest fuzzer updates (due to
unrelated changes that invalid the current reproducer), but the issue is
still valid.

Supersedes https://patchwork.kernel.org/project/selinux/patch/20231207165319.63889-1-cgzones@googlemail.com/
---
 checkpolicy/test/dismod.c                  | 11 +++--
 checkpolicy/test/dispol.c                  |  7 ++--
 libsepol/include/sepol/policydb/services.h |  5 +--
 libsepol/include/sepol/policydb/util.h     |  2 +-
 libsepol/src/assertion.c                   | 16 +++++--
 libsepol/src/hierarchy.c                   |  7 +++-
 libsepol/src/kernel_to_cil.c               |  7 ++++
 libsepol/src/kernel_to_conf.c              | 15 +++++--
 libsepol/src/module_to_cil.c               |  7 ++++
 libsepol/src/services.c                    |  8 ++--
 libsepol/src/util.c                        | 49 ++++++++++++----------
 libsepol/utils/sepol_compute_av.c          | 25 ++++++++---
 12 files changed, 106 insertions(+), 53 deletions(-)

diff --git a/checkpolicy/test/dismod.c b/checkpolicy/test/dismod.c
index ac2d61d2..bd45c95e 100644
--- a/checkpolicy/test/dismod.c
+++ b/checkpolicy/test/dismod.c
@@ -118,12 +118,11 @@ static __attribute__((__noreturn__)) void usage(const char *progname)
 static void render_access_mask(uint32_t mask, uint32_t class, policydb_t * p,
 			       FILE * fp)
 {
-	char *perm;
+	char *perm = sepol_av_to_string(p, class, mask);
 	fprintf(fp, "{");
-	perm = sepol_av_to_string(p, class, mask);
-	if (perm)
-		fprintf(fp, "%s ", perm);
+	fprintf(fp, "%s ", perm ?: "<format-failure>");
 	fprintf(fp, "}");
+	free(perm);
 }
 
 static void render_access_bitmap(ebitmap_t * map, uint32_t class,
@@ -135,8 +134,8 @@ static void render_access_bitmap(ebitmap_t * map, uint32_t class,
 	for (i = ebitmap_startbit(map); i < ebitmap_length(map); i++) {
 		if (ebitmap_get_bit(map, i)) {
 			perm = sepol_av_to_string(p, class, UINT32_C(1) << i);
-			if (perm)
-				fprintf(fp, "%s", perm);
+			fprintf(fp, "%s", perm ?: "<format-failure>");
+			free(perm);
 		}
 	}
 	fprintf(fp, " }");
diff --git a/checkpolicy/test/dispol.c b/checkpolicy/test/dispol.c
index 944ef7ec..2662048e 100644
--- a/checkpolicy/test/dispol.c
+++ b/checkpolicy/test/dispol.c
@@ -93,12 +93,11 @@ static __attribute__((__noreturn__)) void usage(const char *progname)
 static int render_access_mask(uint32_t mask, avtab_key_t * key, policydb_t * p,
 		       FILE * fp)
 {
-	char *perm;
+	char *perm = sepol_av_to_string(p, key->target_class, mask);
 	fprintf(fp, "{");
-	perm = sepol_av_to_string(p, key->target_class, mask);
-	if (perm)
-		fprintf(fp, "%s ", perm);
+	fprintf(fp, "%s ", perm ?: "<format-failure>");
 	fprintf(fp, "}");
+	free(perm);
 	return 0;
 }
 
diff --git a/libsepol/include/sepol/policydb/services.h b/libsepol/include/sepol/policydb/services.h
index f2e311aa..c5889da5 100644
--- a/libsepol/include/sepol/policydb/services.h
+++ b/libsepol/include/sepol/policydb/services.h
@@ -106,10 +106,9 @@ extern int sepol_string_to_av_perm(sepol_security_class_t tclass,
 /*
  * Return a string representation of the permission av bit associated with
  * tclass.
- * Returns a pointer to an internal buffer, overridden by the next call to
- * this function or sepol_av_to_string().
+ * The returned string must be free'd by the caller using free(3).
  */
- extern const char *sepol_av_perm_to_string(sepol_security_class_t tclass,
+extern char *sepol_av_perm_to_string(sepol_security_class_t tclass,
 					sepol_access_vector_t av);
 
 /*
diff --git a/libsepol/include/sepol/policydb/util.h b/libsepol/include/sepol/policydb/util.h
index db8da213..70c531d3 100644
--- a/libsepol/include/sepol/policydb/util.h
+++ b/libsepol/include/sepol/policydb/util.h
@@ -31,7 +31,7 @@ extern "C" {
 
 extern int add_i_to_a(uint32_t i, uint32_t * cnt, uint32_t ** a);
 
-extern char *sepol_av_to_string(policydb_t * policydbp, uint32_t tclass,
+extern char *sepol_av_to_string(const policydb_t *policydbp, sepol_security_class_t tclass,
 				sepol_access_vector_t av);
 
 char *sepol_extended_perms_to_string(avtab_extended_perms_t *xperms);
diff --git a/libsepol/src/assertion.c b/libsepol/src/assertion.c
index 6de7d031..3076babe 100644
--- a/libsepol/src/assertion.c
+++ b/libsepol/src/assertion.c
@@ -48,26 +48,30 @@ static void report_failure(sepol_handle_t *handle, policydb_t *p, const avrule_t
 			   unsigned int stype, unsigned int ttype,
 			   const class_perm_node_t *curperm, uint32_t perms)
 {
+	char *permstr = sepol_av_to_string(p, curperm->tclass, perms);
+
 	if (avrule->source_filename) {
 		ERR(handle, "neverallow on line %lu of %s (or line %lu of %s) violated by allow %s %s:%s {%s };",
 		    avrule->source_line, avrule->source_filename, avrule->line, policy_name(p),
 		    p->p_type_val_to_name[stype],
 		    p->p_type_val_to_name[ttype],
 		    p->p_class_val_to_name[curperm->tclass - 1],
-		    sepol_av_to_string(p, curperm->tclass, perms));
+		    permstr ?: "<format-failure>");
 	} else if (avrule->line) {
 		ERR(handle, "neverallow on line %lu violated by allow %s %s:%s {%s };",
 		    avrule->line, p->p_type_val_to_name[stype],
 		    p->p_type_val_to_name[ttype],
 		    p->p_class_val_to_name[curperm->tclass - 1],
-		    sepol_av_to_string(p, curperm->tclass, perms));
+		    permstr ?: "<format-failure>");
 	} else {
 		ERR(handle, "neverallow violated by allow %s %s:%s {%s };",
 		    p->p_type_val_to_name[stype],
 		    p->p_type_val_to_name[ttype],
 		    p->p_class_val_to_name[curperm->tclass - 1],
-		    sepol_av_to_string(p, curperm->tclass, perms));
+		    permstr ?: "<format-failure>");
 	}
+
+	free(permstr);
 }
 
 static int match_any_class_permissions(class_perm_node_t *cp, uint32_t class, uint32_t data)
@@ -200,13 +204,17 @@ static int report_assertion_extended_permissions(sepol_handle_t *handle,
 
 	/* failure on the regular permissions */
 	if (!found_xperm) {
+		char *permstr = sepol_av_to_string(p, curperm->tclass, perms);
+
 		ERR(handle, "neverallowxperm on line %lu of %s (or line %lu of %s) violated by\n"
 				"allow %s %s:%s {%s };",
 				avrule->source_line, avrule->source_filename, avrule->line, policy_name(p),
 				p->p_type_val_to_name[stype],
 				p->p_type_val_to_name[ttype],
 				p->p_class_val_to_name[curperm->tclass - 1],
-				sepol_av_to_string(p, curperm->tclass, perms));
+				permstr ?: "<format-failure>");
+
+		free(permstr);
 		errors++;
 
 	}
diff --git a/libsepol/src/hierarchy.c b/libsepol/src/hierarchy.c
index 350443a8..06e05310 100644
--- a/libsepol/src/hierarchy.c
+++ b/libsepol/src/hierarchy.c
@@ -443,12 +443,15 @@ static void bounds_report(sepol_handle_t *handle, policydb_t *p, uint32_t child,
 	    p->p_type_val_to_name[child - 1],
 	    p->p_type_val_to_name[parent - 1]);
 	for (; cur; cur = cur->next) {
+		char *permstr = sepol_av_to_string(p, cur->key.target_class, cur->datum.data);
+
 		ERR(handle, "    %s %s : %s { %s }",
 		    p->p_type_val_to_name[cur->key.source_type - 1],
 		    p->p_type_val_to_name[cur->key.target_type - 1],
 		    p->p_class_val_to_name[cur->key.target_class - 1],
-		    sepol_av_to_string(p, cur->key.target_class,
-				       cur->datum.data));
+		    permstr ?: "<format-failure>");
+
+		free(permstr);
 	}
 }
 
diff --git a/libsepol/src/kernel_to_cil.c b/libsepol/src/kernel_to_cil.c
index bcb58eee..634826d5 100644
--- a/libsepol/src/kernel_to_cil.c
+++ b/libsepol/src/kernel_to_cil.c
@@ -297,6 +297,11 @@ static int class_constraint_rules_to_strs(struct policydb *pdb, char *classkey,
 		}
 
 		perms = sepol_av_to_string(pdb, class->s.value, curr->permissions);
+		if (!perms) {
+			ERR(NULL, "Failed to generate permission string");
+			rc = -1;
+			goto exit;
+		}
 
 		if (is_mls) {
 			key_word = "mlsconstrain";
@@ -307,6 +312,7 @@ static int class_constraint_rules_to_strs(struct policydb *pdb, char *classkey,
 		}
 
 		rc = strs_create_and_add(strs, "(%s (%s (%s)) %s)", key_word, classkey, perms+1, expr);
+		free(perms);
 		free(expr);
 		if (rc != 0) {
 			goto exit;
@@ -1772,6 +1778,7 @@ static char *avtab_node_to_str(struct policydb *pdb, avtab_key_t *key, avtab_dat
 		}
 		rule = create_str("(%s %s %s (%s (%s)))",
 				  flavor, src, tgt, class, perms+1);
+		free(perms);
 	} else if (key->specified & AVTAB_XPERMS) {
 		perms = xperms_to_str(datum->xperms);
 		if (perms == NULL) {
diff --git a/libsepol/src/kernel_to_conf.c b/libsepol/src/kernel_to_conf.c
index 83f46e0f..de1d9e09 100644
--- a/libsepol/src/kernel_to_conf.c
+++ b/libsepol/src/kernel_to_conf.c
@@ -292,6 +292,11 @@ static int class_constraint_rules_to_strs(struct policydb *pdb, char *classkey,
 		}
 
 		perms = sepol_av_to_string(pdb, class->s.value, curr->permissions);
+		if (!perms) {
+			ERR(NULL, "Failed to generate permission string");
+			rc = -1;
+			goto exit;
+		}
 		if (strchr(perms, ' ')) {
 			perm_prefix = "{ ";
 			perm_suffix = " }";
@@ -311,6 +316,7 @@ static int class_constraint_rules_to_strs(struct policydb *pdb, char *classkey,
 					 flavor, classkey,
 					 perm_prefix, perms+1, perm_suffix,
 					 expr);
+		free(perms);
 		free(expr);
 		if (rc != 0) {
 			goto exit;
@@ -1682,7 +1688,7 @@ static char *avtab_node_to_str(struct policydb *pdb, avtab_key_t *key, avtab_dat
 {
 	uint32_t data = datum->data;
 	type_datum_t *type;
-	const char *flavor, *src, *tgt, *class, *perms, *new;
+	const char *flavor, *src, *tgt, *class, *new;
 	char *rule = NULL, *permstring;
 
 	switch (0xFFF & key->specified) {
@@ -1730,13 +1736,14 @@ static char *avtab_node_to_str(struct policydb *pdb, avtab_key_t *key, avtab_dat
 	class = pdb->p_class_val_to_name[key->target_class - 1];
 
 	if (key->specified & AVTAB_AV) {
-		perms = sepol_av_to_string(pdb, key->target_class, data);
-		if (perms == NULL) {
+		permstring = sepol_av_to_string(pdb, key->target_class, data);
+		if (permstring == NULL) {
 			ERR(NULL, "Failed to generate permission string");
 			goto exit;
 		}
 		rule = create_str("%s %s %s:%s { %s };",
-				  flavor, src, tgt, class, perms+1);
+				  flavor, src, tgt, class, permstring+1);
+		free(permstring);
 	} else if (key->specified & AVTAB_XPERMS) {
 		permstring = sepol_extended_perms_to_string(datum->xperms);
 		if (permstring == NULL) {
diff --git a/libsepol/src/module_to_cil.c b/libsepol/src/module_to_cil.c
index ee22dbbd..2ec66292 100644
--- a/libsepol/src/module_to_cil.c
+++ b/libsepol/src/module_to_cil.c
@@ -597,6 +597,7 @@ static int avrule_to_cil(int indent, struct policydb *pdb, uint32_t type, const
 					rule, src, tgt,
 					pdb->p_class_val_to_name[classperm->tclass - 1],
 					perms + 1);
+			free(perms);
 		} else {
 			cil_println(indent, "(%s %s %s %s %s)",
 					rule, src, tgt,
@@ -1967,7 +1968,13 @@ static int constraints_to_cil(int indent, struct policydb *pdb, char *classkey,
 
 		if (is_constraint) {
 			perms = sepol_av_to_string(pdb, class->s.value, node->permissions);
+			if (perms == NULL) {
+				ERR(NULL, "Failed to generate permission string");
+				rc = -1;
+				goto exit;
+			}
 			cil_println(indent, "(%sconstrain (%s (%s)) %s)", mls, classkey, perms + 1, expr);
+			free(perms);
 		} else {
 			cil_println(indent, "(%svalidatetrans %s %s)", mls, classkey, expr);
 		}
diff --git a/libsepol/src/services.c b/libsepol/src/services.c
index 0eeee7ec..e37221c8 100644
--- a/libsepol/src/services.c
+++ b/libsepol/src/services.c
@@ -347,9 +347,11 @@ static char *get_class_info(sepol_security_class_t tclass,
 		p += len;
 		buf_used += len;
 		if (state_num < 2) {
+			char *permstr = sepol_av_to_string(policydb, tclass, constraint->permissions);
+
 			len = snprintf(p, class_buf_len - buf_used, "{%s } (",
-			sepol_av_to_string(policydb, tclass,
-				constraint->permissions));
+				       permstr ?: "<format-failure>");
+			free(permstr);
 		} else {
 			len = snprintf(p, class_buf_len - buf_used, "(");
 		}
@@ -1234,7 +1236,7 @@ out:
 	return STATUS_ERR;
 }
 
- const char *sepol_av_perm_to_string(sepol_security_class_t tclass,
+char *sepol_av_perm_to_string(sepol_security_class_t tclass,
 					sepol_access_vector_t av)
 {
 	return sepol_av_to_string(policydb, tclass, av);
diff --git a/libsepol/src/util.c b/libsepol/src/util.c
index 2f877920..1d4f0005 100644
--- a/libsepol/src/util.c
+++ b/libsepol/src/util.c
@@ -32,7 +32,7 @@
 
 struct val_to_name {
 	unsigned int val;
-	char *name;
+	const char *name;
 };
 
 /* Add an unsigned integer to a dynamically reallocated array.  *cnt
@@ -82,20 +82,26 @@ static int perm_name(hashtab_key_t key, hashtab_datum_t datum, void *data)
 	return 0;
 }
 
-char *sepol_av_to_string(policydb_t * policydbp, uint32_t tclass,
+char *sepol_av_to_string(const policydb_t *policydbp, sepol_security_class_t tclass,
 			 sepol_access_vector_t av)
 {
 	struct val_to_name v;
-	static char avbuf[1024];
-	class_datum_t *cladatum;
-	char *perm = NULL, *p;
-	unsigned int i;
+	const class_datum_t *cladatum = policydbp->class_val_to_struct[tclass - 1];
+	uint32_t i;
 	int rc;
-	int avlen = 0, len;
+	char *buffer = NULL, *p;
+	int len;
+	size_t remaining, size = 64;
+
+retry:
+	if (__builtin_mul_overflow(size, 2, &size))
+		goto err;
+	p = realloc(buffer, size);
+	if (!p)
+		goto err;
+	buffer = p;
+	remaining = size;
 
-	memset(avbuf, 0, sizeof avbuf);
-	cladatum = policydbp->class_val_to_struct[tclass - 1];
-	p = avbuf;
 	for (i = 0; i < cladatum->permissions.nprim; i++) {
 		if (av & (UINT32_C(1) << i)) {
 			v.val = i + 1;
@@ -106,22 +112,23 @@ char *sepol_av_to_string(policydb_t * policydbp, uint32_t tclass,
 						 permissions.table, perm_name,
 						 &v);
 			}
-			if (rc)
-				perm = v.name;
-			if (perm) {
-				len =
-				    snprintf(p, sizeof(avbuf) - avlen, " %s",
-					     perm);
-				if (len < 0
-				    || (size_t) len >= (sizeof(avbuf) - avlen))
-					return NULL;
+			if (rc == 1) {
+				len = snprintf(p, remaining, " %s", v.name);
+				if (len < 0)
+					goto err;
+				if ((size_t) len >= remaining)
+					goto retry;
 				p += len;
-				avlen += len;
+				remaining -= len;
 			}
 		}
 	}
 
-	return avbuf;
+	return buffer;
+
+err:
+	free(buffer);
+	return NULL;
 }
 
 #define next_bit_in_range(i, p) (((i) + 1 < sizeof(p)*8) && xperm_test(((i) + 1), p))
diff --git a/libsepol/utils/sepol_compute_av.c b/libsepol/utils/sepol_compute_av.c
index d64dc31d..2ffc7a53 100644
--- a/libsepol/utils/sepol_compute_av.c
+++ b/libsepol/utils/sepol_compute_av.c
@@ -49,12 +49,27 @@ int main(int argc, char *argv[])
 
 	rc = sepol_compute_av(ssid, tsid, tclass, 0, &avd);
 	switch (rc) {
-	case 0:
-		printf("allowed:    %s\n", sepol_av_perm_to_string(tclass, avd.allowed));
-		printf("decided:    %s\n", sepol_av_perm_to_string(tclass, avd.decided));
-		printf("auditallow: %s\n", sepol_av_perm_to_string(tclass, avd.auditallow));
-		printf("auditdeny:  %s\n", sepol_av_perm_to_string(tclass, avd.auditdeny));
+	case 0: {
+		char *permstr;
+
+		permstr = sepol_av_perm_to_string(tclass, avd.allowed);
+		printf("allowed:    %s\n", permstr ?: "<format-failure>");
+		free(permstr);
+
+		permstr = sepol_av_perm_to_string(tclass, avd.decided);
+		printf("decided:    %s\n", permstr ?: "<format-failure>");
+		free(permstr);
+
+		permstr = sepol_av_perm_to_string(tclass, avd.auditallow);
+		printf("auditallow: %s\n", permstr ?: "<format-failure>");
+		free(permstr);
+
+		permstr = sepol_av_perm_to_string(tclass, avd.auditdeny);
+		printf("auditdeny:  %s\n", permstr ?: "<format-failure>");
+		free(permstr);
+
 		break;
+	}
 	case -EINVAL:
 		printf("Invalid request\n");
 		break;
-- 
2.43.0

