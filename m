Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="Plm+ygXy"
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B64231BE
	for <selinux@vger.kernel.org>; Tue, 28 Nov 2023 10:22:00 -0800 (PST)
Received: by mail-lf1-x12b.google.com with SMTP id 2adb3069b0e04-50bc2e7f1e4so199976e87.1
        for <selinux@vger.kernel.org>; Tue, 28 Nov 2023 10:22:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1701195719; x=1701800519; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=sSg4wNWRB6w9+S3G2kZZH0kx41YqQrh+Ljtlqr70pxs=;
        b=Plm+ygXySmQCWSCdUlYbHqee4E4DPI1hicZhFePL83eb8A57Qexz+95zaOXOHvqTyy
         W7kajsOR4FqNkN8EiV6JUXtYPjFjnH8YbeHkGJNc6dkIZbAUG1H6IrnlYj0TBIqF/j3T
         gt5IDFZ1y1M7TN2Qgex+LZUE/Ue0slC7cbcVf2HGtQ6BQWVvAinVPmVQ6lZnVMddPQlg
         J9GqBwa02e9jjIbkuR+924i0koPUARq768MX6hIlTdbI7z1naB44cdUtEQiZLsljA/nB
         zokISL7QZr2ASTcWHVVC+TYJPpbpiLUePzl58mY5ufNTZER8+1JPKK4UQM5AtmjXg+LW
         vMcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701195719; x=1701800519;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sSg4wNWRB6w9+S3G2kZZH0kx41YqQrh+Ljtlqr70pxs=;
        b=MkUxh94JAYNZHzYGdQK8uxnqlxNMnUHh6OaC7qoOuIWaux8GdEjFAv2SPutc3KVrw1
         UcIzD/9Q7/BVIBrjJ2WvCx/1fBmiL8oiywOrYhNDxJ1v31Bqwm2QMSTaOk0smjP+Evw9
         hI4eXEuPwt2tFQ54SeHnn5X0tbUnH6J1QGHVNsvEqBxOMaTuikFdjdNDrSf3tXMhb2VY
         V0be1uDjdP/LpP+n9ZhzKSGNImbpWoRK5XijZsHKqiSht2/KH/mgtNVFN9GK9c+JHcgA
         7i6ZVg9L3qaAIrd/Y5ncnv+aQ0ulR6eneDVVyGO363uJzoMtSspidHaMRhEbNmVbUBYJ
         5uJQ==
X-Gm-Message-State: AOJu0YyA8gLFsJlUDwB9dNA6gA5qxEhlZCQav6LN0uRB7iy+Fk7K6HXg
	7jGkYM5x4u263knJW141yV22mmhEmVQ=
X-Google-Smtp-Source: AGHT+IGCyZZGkqQYAQ8SPSBF5Xv9MEh1TLwzYvTrv2KxUFZ0GOr7RwZBxJM4i1Ur4pg/5OIWYCzAuQ==
X-Received: by 2002:a19:5207:0:b0:503:3278:3221 with SMTP id m7-20020a195207000000b0050332783221mr10231282lfb.69.1701195718659;
        Tue, 28 Nov 2023 10:21:58 -0800 (PST)
Received: from debian_development.DebianHome (dynamic-077-003-184-154.77.3.pool.telefonica.de. [77.3.184.154])
        by smtp.gmail.com with ESMTPSA id u10-20020a170906c40a00b009fd0a0b7ee5sm7010986ejz.9.2023.11.28.10.21.58
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Nov 2023 10:21:58 -0800 (PST)
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To: selinux@vger.kernel.org
Subject: [PATCH] libsepol: simplify string formatting
Date: Tue, 28 Nov 2023 19:21:52 +0100
Message-ID: <20231128182152.57198-1-cgzones@googlemail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Simplify the string formatting helpers create_str() and
strs_create_and_add() by calling the GNU extension vasprintf(3), already
used in libsepol/cil/.  This allows to drop a redundant parameter from
both functions.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libsepol/src/kernel_to_cil.c    | 56 ++++++++++++++---------------
 libsepol/src/kernel_to_common.c | 62 +++++++--------------------------
 libsepol/src/kernel_to_common.h |  8 ++---
 libsepol/src/kernel_to_conf.c   | 60 +++++++++++++++----------------
 4 files changed, 74 insertions(+), 112 deletions(-)

diff --git a/libsepol/src/kernel_to_cil.c b/libsepol/src/kernel_to_cil.c
index 8ec79749..bcb58eee 100644
--- a/libsepol/src/kernel_to_cil.c
+++ b/libsepol/src/kernel_to_cil.c
@@ -45,7 +45,7 @@ static char *cond_expr_to_str(struct policydb *pdb, struct cond_expr *expr)
 	for (curr = expr; curr != NULL; curr = curr->next) {
 		if (curr->expr_type == COND_BOOL) {
 			char *val1 = pdb->p_bool_val_to_name[curr->boolean - 1];
-			new_val = create_str("%s", 1, val1);
+			new_val = create_str("%s", val1);
 		} else {
 			const char *op;
 			uint32_t num_params;
@@ -79,10 +79,10 @@ static char *cond_expr_to_str(struct policydb *pdb, struct cond_expr *expr)
 				goto exit;
 			}
 			if (num_params == 2) {
-				new_val = create_str("(%s %s %s)", 3, op, val1, val2);
+				new_val = create_str("(%s %s %s)", op, val1, val2);
 				free(val2);
 			} else {
-				new_val = create_str("(%s %s)", 2, op, val1);
+				new_val = create_str("(%s %s)", op, val1);
 			}
 			free(val1);
 		}
@@ -178,7 +178,7 @@ static char *constraint_expr_to_str(struct policydb *pdb, struct constraint_expr
 			}
 
 			if (curr->expr_type == CEXPR_ATTR) {
-				new_val = create_str("(%s %s %s)", 3, op, attr1, attr2);
+				new_val = create_str("(%s %s %s)", op, attr1, attr2);
 			} else {
 				char *names = NULL;
 				if (curr->attr & CEXPR_TYPE) {
@@ -197,9 +197,9 @@ static char *constraint_expr_to_str(struct policydb *pdb, struct constraint_expr
 					}
 				}
 				if (strchr(names, ' ')) {
-					new_val = create_str("(%s %s (%s))", 3, op, attr1, names);
+					new_val = create_str("(%s %s (%s))", op, attr1, names);
 				} else {
-					new_val = create_str("(%s %s %s)", 3, op, attr1, names);
+					new_val = create_str("(%s %s %s)", op, attr1, names);
 				}
 				free(names);
 			}
@@ -232,10 +232,10 @@ static char *constraint_expr_to_str(struct policydb *pdb, struct constraint_expr
 			}
 
 			if (num_params == 2) {
-				new_val = create_str("(%s %s %s)", 3, op, val1, val2);
+				new_val = create_str("(%s %s %s)", op, val1, val2);
 				free(val2);
 			} else {
-				new_val = create_str("(%s %s)", 2, op, val1);
+				new_val = create_str("(%s %s)", op, val1);
 			}
 			free(val1);
 		}
@@ -306,7 +306,7 @@ static int class_constraint_rules_to_strs(struct policydb *pdb, char *classkey,
 			strs = non_mls_list;
 		}
 
-		rc = strs_create_and_add(strs, "(%s (%s (%s)) %s)", 4, key_word, classkey, perms+1, expr);
+		rc = strs_create_and_add(strs, "(%s (%s (%s)) %s)", key_word, classkey, perms+1, expr);
 		free(expr);
 		if (rc != 0) {
 			goto exit;
@@ -346,7 +346,7 @@ static int class_validatetrans_rules_to_strs(struct policydb *pdb, char *classke
 			strs = non_mls_list;
 		}
 
-		rc = strs_create_and_add(strs, "(%s %s %s)", 3, key_word, classkey, expr);
+		rc = strs_create_and_add(strs, "(%s %s %s)", key_word, classkey, expr);
 		free(expr);
 		if (rc != 0) {
 			goto exit;
@@ -1203,7 +1203,7 @@ static int write_polcap_rules_to_cil(FILE *out, struct policydb *pdb)
 			goto exit;
 		}
 
-		rc = strs_create_and_add(strs, "(policycap %s)", 1, name);
+		rc = strs_create_and_add(strs, "(policycap %s)", name);
 		if (rc != 0) {
 			goto exit;
 		}
@@ -1321,7 +1321,7 @@ static int map_boolean_to_strs(char *key, void *data, void *args)
 
 	value = boolean->state ? "true" : "false";
 
-	return strs_create_and_add(strs, "(boolean %s %s)", 2, key, value);
+	return strs_create_and_add(strs, "(boolean %s %s)", key, value);
 }
 
 static int write_boolean_decl_rules_to_cil(FILE *out, struct policydb *pdb)
@@ -1562,7 +1562,7 @@ static int write_type_attribute_sets_to_cil(FILE *out, struct policydb *pdb)
 		}
 
 		rc = strs_create_and_add(strs, "(typeattributeset %s (%s))",
-					 2, name, types);
+					 name, types);
 		free(types);
 		if (rc != 0) {
 			goto exit;
@@ -1770,7 +1770,7 @@ static char *avtab_node_to_str(struct policydb *pdb, avtab_key_t *key, avtab_dat
 			ERR(NULL, "Failed to generate permission string");
 			goto exit;
 		}
-		rule = create_str("(%s %s %s (%s (%s)))", 5,
+		rule = create_str("(%s %s %s (%s (%s)))",
 				  flavor, src, tgt, class, perms+1);
 	} else if (key->specified & AVTAB_XPERMS) {
 		perms = xperms_to_str(datum->xperms);
@@ -1779,13 +1779,13 @@ static char *avtab_node_to_str(struct policydb *pdb, avtab_key_t *key, avtab_dat
 			goto exit;
 		}
 
-		rule = create_str("(%s %s %s (%s %s (%s)))", 6,
+		rule = create_str("(%s %s %s (%s %s (%s)))",
 				  flavor, src, tgt, "ioctl", class, perms);
 		free(perms);
 	} else {
 		new = pdb->p_type_val_to_name[data - 1];
 
-		rule = create_str("(%s %s %s %s %s)", 5, flavor, src, tgt, class, new);
+		rule = create_str("(%s %s %s %s %s)", flavor, src, tgt, class, new);
 	}
 
 	if (!rule) {
@@ -1907,7 +1907,7 @@ static int map_filename_trans_to_str(hashtab_key_t key, void *data, void *arg)
 			src = pdb->p_type_val_to_name[bit];
 			rc = strs_create_and_add(strs,
 						 "(typetransition %s %s %s \"%s\" %s)",
-						 5, src, tgt, class, filename, new);
+						 src, tgt, class, filename, new);
 			if (rc)
 				return rc;
 		}
@@ -1960,10 +1960,10 @@ static char *level_to_str(struct policydb *pdb, struct mls_level *level)
 
 	if (!ebitmap_is_empty(cats)) {
 		cats_str = cats_ebitmap_to_str(cats, pdb->p_cat_val_to_name);
-		level_str = create_str("(%s %s)", 2, sens_str, cats_str);
+		level_str = create_str("(%s %s)", sens_str, cats_str);
 		free(cats_str);
 	} else {
-		level_str = create_str("(%s)", 1, sens_str);
+		level_str = create_str("(%s)", sens_str);
 	}
 
 	return level_str;
@@ -1985,7 +1985,7 @@ static char *range_to_str(struct policydb *pdb, mls_range_t *range)
 		goto exit;
 	}
 
-	range_str = create_str("(%s %s)", 2, low, high);
+	range_str = create_str("(%s %s)", low, high);
 
 exit:
 	free(low);
@@ -2018,7 +2018,7 @@ static int map_range_trans_to_str(hashtab_key_t key, void *data, void *arg)
 		goto exit;
 	}
 
-	rc = strs_create_and_add(strs, "(rangetransition %s %s %s %s)", 4,
+	rc = strs_create_and_add(strs, "(rangetransition %s %s %s %s)",
 				 src, tgt, class, range);
 	free(range);
 	if (rc != 0) {
@@ -2345,7 +2345,7 @@ static int write_role_transition_rules_to_cil(FILE *out, struct policydb *pdb)
 		class = pdb->p_class_val_to_name[curr->tclass - 1];
 		new = pdb->p_role_val_to_name[curr->new_role - 1];
 
-		rc = strs_create_and_add(strs, "(roletransition %s %s %s %s)", 4,
+		rc = strs_create_and_add(strs, "(roletransition %s %s %s %s)",
 					 role, type, class, new);
 		if (rc != 0) {
 			goto exit;
@@ -2384,7 +2384,7 @@ static int write_role_allow_rules_to_cil(FILE *out, struct policydb *pdb)
 		role = pdb->p_role_val_to_name[curr->role - 1];
 		new =  pdb->p_role_val_to_name[curr->new_role - 1];
 
-		rc = strs_create_and_add(strs, "(roleallow %s %s)", 2, role, new);
+		rc = strs_create_and_add(strs, "(roleallow %s %s)", role, new);
 		if (rc != 0) {
 			goto exit;
 		}
@@ -2559,13 +2559,13 @@ static char *context_to_str(struct policydb *pdb, struct context_struct *con)
 	if (pdb->mls) {
 		range = range_to_str(pdb, &con->range);
 	} else {
-		range = create_str("(%s %s)", 2, DEFAULT_LEVEL, DEFAULT_LEVEL);
+		range = create_str("(%s %s)", DEFAULT_LEVEL, DEFAULT_LEVEL);
 	}
 	if (!range) {
 		goto exit;
 	}
 
-	ctx = create_str("(%s %s %s %s)", 4, user, role, type, range);
+	ctx = create_str("(%s %s %s %s)", user, role, type, range);
 	free(range);
 
 exit:
@@ -2602,7 +2602,7 @@ static int write_sid_context_rules_to_cil(FILE *out, struct policydb *pdb, const
 			goto exit;
 		}
 
-		rule = create_str("(sidcontext %s %s)", 2, sid, ctx);
+		rule = create_str("(sidcontext %s %s)", sid, ctx);
 		free(ctx);
 		if (!rule) {
 			rc = -1;
@@ -2724,10 +2724,10 @@ static int write_genfscon_rules_to_cil(FILE *out, struct policydb *pdb)
 			}
 
 			if (file_type) {
-				rc = strs_create_and_add(strs, "(genfscon %s \"%s\" %s %s)", 4,
+				rc = strs_create_and_add(strs, "(genfscon %s \"%s\" %s %s)",
 										 fstype, name, file_type, ctx);
 			} else {
-				rc = strs_create_and_add(strs, "(genfscon %s \"%s\" %s)", 3,
+				rc = strs_create_and_add(strs, "(genfscon %s \"%s\" %s)",
 										 fstype, name, ctx);
 			}
 			free(ctx);
diff --git a/libsepol/src/kernel_to_common.c b/libsepol/src/kernel_to_common.c
index 09c08b3d..4612eef3 100644
--- a/libsepol/src/kernel_to_common.c
+++ b/libsepol/src/kernel_to_common.c
@@ -40,55 +40,19 @@ void sepol_printf(FILE *out, const char *fmt, ...)
 	va_end(argptr);
 }
 
-__attribute__ ((format(printf, 1, 0)))
-static char *create_str_helper(const char *fmt, int num, va_list vargs)
+char *create_str(const char *fmt, ...)
 {
-	va_list vargs2;
-	char *str = NULL;
-	char *s;
-	size_t len, s_len;
-	int i, rc;
-
-	va_copy(vargs2, vargs);
-
-	len = strlen(fmt) + 1; /* +1 for '\0' */
-
-	for (i=0; i<num; i++) {
-		s = va_arg(vargs, char *);
-		s_len = strlen(s);
-		len += s_len > 1 ? s_len - 2 : 0; /* -2 for each %s in fmt */
-	}
-
-	str = malloc(len);
-	if (!str) {
-		ERR(NULL, "Out of memory");
-		goto exit;
-	}
-
-	rc = vsnprintf(str, len, fmt, vargs2);
-	if (rc < 0 || rc >= (int)len) {
-		goto exit;
-	}
-
-	va_end(vargs2);
-
-	return str;
-
-exit:
-	free(str);
-	va_end(vargs2);
-	return NULL;
-}
-
-char *create_str(const char *fmt, int num, ...)
-{
-	char *str = NULL;
+	char *str;
 	va_list vargs;
+	int rc;
 
-	va_start(vargs, num);
-	str = create_str_helper(fmt, num, vargs);
+	va_start(vargs, fmt);
+	rc = vasprintf(&str, fmt, vargs);
 	va_end(vargs);
 
+	if (rc == -1)
+		return NULL;
+
 	return str;
 }
 
@@ -170,20 +134,18 @@ int strs_add(struct strs *strs, char *s)
 	return 0;
 }
 
-int strs_create_and_add(struct strs *strs, const char *fmt, int num, ...)
+int strs_create_and_add(struct strs *strs, const char *fmt, ...)
 {
 	char *str;
 	va_list vargs;
 	int rc;
 
-	va_start(vargs, num);
-	str = create_str_helper(fmt, num, vargs);
+	va_start(vargs, fmt);
+	rc = vasprintf(&str, fmt, vargs);
 	va_end(vargs);
 
-	if (!str) {
-		rc = -1;
+	if (rc == -1)
 		goto exit;
-	}
 
 	rc = strs_add(strs, str);
 	if (rc != 0) {
diff --git a/libsepol/src/kernel_to_common.h b/libsepol/src/kernel_to_common.h
index 9e567eb8..3ba97dfc 100644
--- a/libsepol/src/kernel_to_common.h
+++ b/libsepol/src/kernel_to_common.h
@@ -87,15 +87,15 @@ void sepol_indent(FILE *out, int indent);
 __attribute__ ((format(printf, 2, 3)))
 void sepol_printf(FILE *out, const char *fmt, ...);
 
-__attribute__ ((format(printf, 1, 3)))
-char *create_str(const char *fmt, int num, ...);
+__attribute__ ((format(printf, 1, 2)))
+char *create_str(const char *fmt, ...);
 
 int strs_init(struct strs **strs, size_t size);
 void strs_destroy(struct strs **strs);
 void strs_free_all(struct strs *strs);
 int strs_add(struct strs *strs, char *s);
-__attribute__ ((format(printf, 2, 4)))
-int strs_create_and_add(struct strs *strs, const char *fmt, int num, ...);
+__attribute__ ((format(printf, 2, 3)))
+int strs_create_and_add(struct strs *strs, const char *fmt, ...);
 char *strs_remove_last(struct strs *strs);
 int strs_add_at_index(struct strs *strs, char *s, size_t index);
 char *strs_read_at_index(struct strs *strs, size_t index);
diff --git a/libsepol/src/kernel_to_conf.c b/libsepol/src/kernel_to_conf.c
index b5b530d6..83f46e0f 100644
--- a/libsepol/src/kernel_to_conf.c
+++ b/libsepol/src/kernel_to_conf.c
@@ -44,7 +44,7 @@ static char *cond_expr_to_str(struct policydb *pdb, struct cond_expr *expr)
 	for (curr = expr; curr != NULL; curr = curr->next) {
 		if (curr->expr_type == COND_BOOL) {
 			char *val1 = pdb->p_bool_val_to_name[curr->boolean - 1];
-			new_val = create_str("%s", 1, val1);
+			new_val = create_str("%s", val1);
 		} else {
 			const char *op;
 			uint32_t num_params;
@@ -77,10 +77,10 @@ static char *cond_expr_to_str(struct policydb *pdb, struct cond_expr *expr)
 				goto exit;
 			}
 			if (num_params == 2) {
-				new_val = create_str("(%s %s %s)", 3, val1, op, val2);
+				new_val = create_str("(%s %s %s)", val1, op, val2);
 				free(val2);
 			} else {
-				new_val = create_str("%s %s", 2, op, val1);
+				new_val = create_str("%s %s", op, val1);
 			}
 			free(val1);
 		}
@@ -175,7 +175,7 @@ static char *constraint_expr_to_str(struct policydb *pdb, struct constraint_expr
 			}
 
 			if (curr->expr_type == CEXPR_ATTR) {
-				new_val = create_str("%s %s %s", 3, attr1, op, attr2);
+				new_val = create_str("%s %s %s", attr1, op, attr2);
 			} else {
 				char *names = NULL;
 				if (curr->attr & CEXPR_TYPE) {
@@ -194,9 +194,9 @@ static char *constraint_expr_to_str(struct policydb *pdb, struct constraint_expr
 					}
 				}
 				if (strchr(names, ' ')) {
-					new_val = create_str("%s %s { %s }", 3, attr1, op, names);
+					new_val = create_str("%s %s { %s }", attr1, op, names);
 				} else {
-					new_val = create_str("%s %s %s", 3, attr1, op, names);
+					new_val = create_str("%s %s %s", attr1, op, names);
 				}
 				free(names);
 			}
@@ -228,10 +228,10 @@ static char *constraint_expr_to_str(struct policydb *pdb, struct constraint_expr
 			}
 
 			if (num_params == 2) {
-				new_val = create_str("(%s %s %s)", 3, val1, op, val2);
+				new_val = create_str("(%s %s %s)", val1, op, val2);
 				free(val2);
 			} else {
-				new_val = create_str("%s (%s)", 2, op, val1);
+				new_val = create_str("%s (%s)", op, val1);
 			}
 			free(val1);
 		}
@@ -307,7 +307,7 @@ static int class_constraint_rules_to_strs(struct policydb *pdb, char *classkey,
 			strs = non_mls_list;
 		}
 
-		rc = strs_create_and_add(strs, "%s %s %s%s%s %s;", 6,
+		rc = strs_create_and_add(strs, "%s %s %s%s%s %s;",
 					 flavor, classkey,
 					 perm_prefix, perms+1, perm_suffix,
 					 expr);
@@ -350,7 +350,7 @@ static int class_validatetrans_rules_to_strs(struct policydb *pdb, char *classke
 			strs = non_mls_list;
 		}
 
-		rc = strs_create_and_add(strs, "%s %s %s;", 3, flavor, classkey, expr);
+		rc = strs_create_and_add(strs, "%s %s %s;", flavor, classkey, expr);
 		free(expr);
 		if (rc != 0) {
 			goto exit;
@@ -834,7 +834,7 @@ static int write_sensitivity_rules_to_conf(FILE *out, struct policydb *pdb)
 				}
 			} else {
 				alias = sens_alias_map[j];
-				sens_alias_map[j] = create_str("%s %s", 2, alias, name);
+				sens_alias_map[j] = create_str("%s %s", alias, name);
 				free(alias);
 				if (!sens_alias_map[j]) {
 					rc = -1;
@@ -965,7 +965,7 @@ static int write_category_rules_to_conf(FILE *out, struct policydb *pdb)
 				}
 			} else {
 				alias = cat_alias_map[j];
-				cat_alias_map[j] = create_str("%s %s", 2, alias, name);
+				cat_alias_map[j] = create_str("%s %s", alias, name);
 				free(alias);
 				if (!cat_alias_map[j]) {
 					rc = -1;
@@ -1186,7 +1186,7 @@ static int write_polcap_rules_to_conf(FILE *out, struct policydb *pdb)
 			goto exit;
 		}
 
-		rc = strs_create_and_add(strs, "policycap %s;", 1, name);
+		rc = strs_create_and_add(strs, "policycap %s;", name);
 		if (rc != 0) {
 			goto exit;
 		}
@@ -1304,7 +1304,7 @@ static int map_boolean_to_strs(char *key, void *data, void *args)
 
 	value = boolean->state ? "true" : "false";
 
-	return strs_create_and_add(strs, "bool %s %s;", 2, key, value);
+	return strs_create_and_add(strs, "bool %s %s;", key, value);
 }
 
 static int write_boolean_decl_rules_to_conf(FILE *out, struct policydb *pdb)
@@ -1615,7 +1615,7 @@ static int write_type_attribute_sets_to_conf(FILE *out, struct policydb *pdb)
 		}
 
 		rc = strs_create_and_add(strs, "typeattribute %s %s;",
-					 2, name, attrs);
+					 name, attrs);
 		free(attrs);
 		if (rc != 0) {
 			goto exit;
@@ -1735,7 +1735,7 @@ static char *avtab_node_to_str(struct policydb *pdb, avtab_key_t *key, avtab_dat
 			ERR(NULL, "Failed to generate permission string");
 			goto exit;
 		}
-		rule = create_str("%s %s %s:%s { %s };", 5,
+		rule = create_str("%s %s %s:%s { %s };",
 				  flavor, src, tgt, class, perms+1);
 	} else if (key->specified & AVTAB_XPERMS) {
 		permstring = sepol_extended_perms_to_string(datum->xperms);
@@ -1744,12 +1744,12 @@ static char *avtab_node_to_str(struct policydb *pdb, avtab_key_t *key, avtab_dat
 			goto exit;
 		}
 
-		rule = create_str("%s %s %s:%s %s;", 5, flavor, src, tgt, class, permstring);
+		rule = create_str("%s %s %s:%s %s;", flavor, src, tgt, class, permstring);
 		free(permstring);
 	} else {
 		new = pdb->p_type_val_to_name[data - 1];
 
-		rule = create_str("%s %s %s:%s %s;", 5, flavor, src, tgt, class, new);
+		rule = create_str("%s %s %s:%s %s;", flavor, src, tgt, class, new);
 	}
 
 	if (!rule) {
@@ -1871,7 +1871,7 @@ static int map_filename_trans_to_str(hashtab_key_t key, void *data, void *arg)
 			src = pdb->p_type_val_to_name[bit];
 			rc = strs_create_and_add(strs,
 						 "type_transition %s %s:%s %s \"%s\";",
-						 5, src, tgt, class, new, filename);
+						 src, tgt, class, new, filename);
 			if (rc)
 				return rc;
 		}
@@ -1924,10 +1924,10 @@ static char *level_to_str(struct policydb *pdb, struct mls_level *level)
 
 	if (!ebitmap_is_empty(cats)) {
 		cats_str = cats_ebitmap_to_str(cats, pdb->p_cat_val_to_name);
-		level_str = create_str("%s:%s", 2, sens_str, cats_str);
+		level_str = create_str("%s:%s", sens_str, cats_str);
 		free(cats_str);
 	} else {
-		level_str = create_str("%s", 1, sens_str);
+		level_str = create_str("%s", sens_str);
 	}
 
 	return level_str;
@@ -1949,7 +1949,7 @@ static char *range_to_str(struct policydb *pdb, mls_range_t *range)
 		goto exit;
 	}
 
-	range_str = create_str("%s - %s", 2, low, high);
+	range_str = create_str("%s - %s", low, high);
 
 exit:
 	free(low);
@@ -1982,7 +1982,7 @@ static int map_range_trans_to_str(hashtab_key_t key, void *data, void *arg)
 		goto exit;
 	}
 
-	rc = strs_create_and_add(strs, "range_transition %s %s:%s %s;", 4,
+	rc = strs_create_and_add(strs, "range_transition %s %s:%s %s;",
 				 src, tgt, class, range);
 	free(range);
 	if (rc != 0) {
@@ -2264,7 +2264,7 @@ static int write_role_transition_rules_to_conf(FILE *out, struct policydb *pdb)
 		class = pdb->p_class_val_to_name[curr->tclass - 1];
 		new = pdb->p_role_val_to_name[curr->new_role - 1];
 
-		rc = strs_create_and_add(strs, "role_transition %s %s:%s %s;", 4,
+		rc = strs_create_and_add(strs, "role_transition %s %s:%s %s;",
 					 role, type, class, new);
 		if (rc != 0) {
 			goto exit;
@@ -2303,7 +2303,7 @@ static int write_role_allow_rules_to_conf(FILE *out, struct policydb *pdb)
 		role = pdb->p_role_val_to_name[curr->role - 1];
 		new =  pdb->p_role_val_to_name[curr->new_role - 1];
 
-		rc = strs_create_and_add(strs, "allow %s %s;", 2, role, new);
+		rc = strs_create_and_add(strs, "allow %s %s;", role, new);
 		if (rc != 0) {
 			goto exit;
 		}
@@ -2419,10 +2419,10 @@ static char *context_to_str(struct policydb *pdb, struct context_struct *con)
 
 	if (pdb->mls) {
 		range = range_to_str(pdb, &con->range);
-		ctx = create_str("%s:%s:%s:%s", 4, user, role, type, range);
+		ctx = create_str("%s:%s:%s:%s", user, role, type, range);
 		free(range);
 	} else {
-		ctx = create_str("%s:%s:%s", 3, user, role, type);
+		ctx = create_str("%s:%s:%s", user, role, type);
 	}
 
 	return ctx;
@@ -2458,7 +2458,7 @@ static int write_sid_context_rules_to_conf(FILE *out, struct policydb *pdb, cons
 			goto exit;
 		}
 
-		rule = create_str("sid %s %s", 2, sid, ctx);
+		rule = create_str("sid %s %s", sid, ctx);
 		free(ctx);
 		if (!rule) {
 			rc = -1;
@@ -2580,10 +2580,10 @@ static int write_genfscon_rules_to_conf(FILE *out, struct policydb *pdb)
 			}
 
 			if (file_type) {
-				rc = strs_create_and_add(strs, "genfscon %s \"%s\" %s %s", 4,
+				rc = strs_create_and_add(strs, "genfscon %s \"%s\" %s %s",
 										 fstype, name, file_type, ctx);
 			} else {
-				rc = strs_create_and_add(strs, "genfscon %s \"%s\" %s", 3,
+				rc = strs_create_and_add(strs, "genfscon %s \"%s\" %s",
 										 fstype, name, ctx);
 			}
 			free(ctx);
-- 
2.43.0

