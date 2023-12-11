Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PkwAaNV/"
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCC61BD
	for <selinux@vger.kernel.org>; Mon, 11 Dec 2023 13:48:19 -0800 (PST)
Received: by mail-qk1-x729.google.com with SMTP id af79cd13be357-77f408d123bso161177485a.0
        for <selinux@vger.kernel.org>; Mon, 11 Dec 2023 13:48:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702331298; x=1702936098; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=TCBBUlpU5EJpCDgmhh2XURZq17usK2BsbFwflZH0rXw=;
        b=PkwAaNV/OHN6z5kKRoPL9IVnLWxSzqh9iCftXChGFsPqDWOcEZFJi8wIViJ6mr+Flb
         A9pkvRuGsCff+8bvu51zu+YLltONeB1ycGldxso/VqoPhIHll0mdBNI/Sh7nzENGaQGP
         6Q0Bg/P0m76DzGnEXmRD+QvXfH00uRRiSGT957oGkzwXRmFLGg9tbD8VgqAGlHAG0Bjp
         sVVgYkqmqnB06E2TNYdlhb7uj1KMoDcH0L3JBPefw6edvm18ATOY+vv80JNbZjsZP4Wa
         oU7/HG+G1lMUhoui31sGYj4/e3lSOrIzpCrx8ZUCQqpeV2kq/dcRFTZTPaqURRn89dgW
         AyxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702331298; x=1702936098;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TCBBUlpU5EJpCDgmhh2XURZq17usK2BsbFwflZH0rXw=;
        b=IjNr4XyiL+pBwwUtbgMfQqEiSQYMD21MpSeSffABfF1Y0DAAfHJ5h+cSRDhJJ2J9RK
         kiJkdIKbh2rBfdivF3Pqyt5rie5TiC5r6r1UTtXrAXu5YKeateCYQKq7MVPr3gu72+Hu
         PjL9cU1vfvs4T2xqw6+pPhHPqLwtnaS6i8827Dj4MehZlZjp8QMZVgbKGUd4RBg+T5SP
         7R+ziGC7i4+m60ySSfZ1m3/SUdTn46whAvcn7DvwRuJ5G8d4tHR8RHmJ3/CGnLb8HQvv
         SRzbReUGoMyriYKCELPkqxRy+XEPzJKsH+AXX0kcnxCfgSrgECjb1Voa54bibl/sZFBr
         OqQg==
X-Gm-Message-State: AOJu0YyMZz2yrJb6jeZeKfdFK+JTTt/DQ/KqxrW2uITu4TQqLX2n3tJ8
	1xvdAitXCg/JfdIX3zdXDmTgj04pYxk=
X-Google-Smtp-Source: AGHT+IEgr9Z/bu81twbDC8319l0xuiVpQsG52sFQcjxEkQa9xS2njMauOcYyASd2l+jR0hQs+O07Tw==
X-Received: by 2002:a05:620a:31a2:b0:77d:992f:857e with SMTP id bi34-20020a05620a31a200b0077d992f857emr4233252qkb.61.1702331297811;
        Mon, 11 Dec 2023 13:48:17 -0800 (PST)
Received: from electric.. (c-73-172-54-2.hsd1.md.comcast.net. [73.172.54.2])
        by smtp.gmail.com with ESMTPSA id rc3-20020a05620a8d8300b0077dc7a029bfsm3234572qkn.100.2023.12.11.13.48.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Dec 2023 13:48:17 -0800 (PST)
From: James Carter <jwcart2@gmail.com>
To: selinux@vger.kernel.org
Cc: cgzones@googlemail.com,
	James Carter <jwcart2@gmail.com>
Subject: [PATCH] libsepol: Use a dynamic buffer in sepol_av_to_string()
Date: Mon, 11 Dec 2023 16:48:14 -0500
Message-ID: <20231211214814.1054824-1-jwcart2@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

In the internal function sepol_av_to_string(), use a dynamically
allocated buffer for the permission names of an access vector instead
of a fixed static buffer to support very long permission names.

Update the internal users of sepol_av_to_string() to free the buffer.

The exported function sepol_perm_to_string() is just a wrapper to
the internal function. To avoid changing the behavior of this function,
use a static buffer and copy the resulting string from the internal
function. If the string is too long for the buffer or there was an
error in creating the string, return a string indicating the error.

All of the changes to the internal function and users was the work
of Christian Göttsche <cgzones@googlemail.com>.

Reported-by: oss-fuzz (issue 64832, 64933)
Suggested-by: Christian Göttsche <cgzones@googlemail.com>
Signed-off-by: James Carter <jwcart2@gmail.com>
---
 checkpolicy/test/dismod.c              | 11 +++---
 checkpolicy/test/dispol.c              |  7 ++--
 libsepol/include/sepol/policydb/util.h |  2 +-
 libsepol/src/assertion.c               | 16 ++++++---
 libsepol/src/hierarchy.c               |  7 ++--
 libsepol/src/kernel_to_cil.c           |  7 ++++
 libsepol/src/kernel_to_conf.c          | 15 +++++---
 libsepol/src/module_to_cil.c           |  7 ++++
 libsepol/src/services.c                | 25 +++++++++++--
 libsepol/src/util.c                    | 49 +++++++++++++++-----------
 10 files changed, 101 insertions(+), 45 deletions(-)

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
index 0eeee7ec..5f3787d3 100644
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
@@ -1237,7 +1239,24 @@ out:
  const char *sepol_av_perm_to_string(sepol_security_class_t tclass,
 					sepol_access_vector_t av)
 {
-	return sepol_av_to_string(policydb, tclass, av);
+	static char avbuf[1024];
+	char *avstr = sepol_av_to_string(policydb, tclass, av);
+	size_t len;
+
+	memset(avbuf, 0, sizeof avbuf);
+
+	if (avstr) {
+		len = strlen(avstr);
+		if (len < 1024) {
+			strcpy(avbuf, avstr);
+		} else {
+			sprintf(avbuf, "<access-vector overflowed buffer>");
+		}
+	} else {
+		sprintf(avbuf, "<format-failure>");
+	}
+
+	return avbuf;
 }
 
 /*
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
-- 
2.43.0

