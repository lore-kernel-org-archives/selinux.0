Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C9E779D2
	for <selinux@vger.kernel.org>; Mon, 30 Jun 2025 18:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751309564; cv=none; b=Jgp1vZkIK0tL3A6GKmIIJtgfoMaPIMA/vMYJDdnvhiIbAqInVijzoYogi/cY1+vRjBR874jin8/9nXBnxe2a+f0CsselmzBJI0aadixNlWJVYG+E8xrRTwU5GbVU8mCGDTPH6OmhuQI8Th6uT7oRROEyXn/JAIT0SwtSTFmYvNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751309564; c=relaxed/simple;
	bh=f3W3eyss7AmcH5vq8iejPn9X+t2mdyeF26lQRVVn4+0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TVUPWvEkYJ/5p/xWU+bN2lpeHmZf1M8GkcrP/tjKjeRE4I8cPzbgGXgMG26mME6OfFaXTLhMzoddZRPhHJe9z4l0yUdgHVWgwlUamFZ7BQAL4vmk7QRJNWqc1tlQaRtZs0k8fcUTs5liM0gQpkfJiGEmj3cPsap9yZQG/iPTgt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ljf7zR4W; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ljf7zR4W"
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-6fae04a3795so53243096d6.3
        for <selinux@vger.kernel.org>; Mon, 30 Jun 2025 11:52:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751309561; x=1751914361; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=uk4wFQOkB5TBMhF4OE45D/yEoCVdj/Ic+Hn9P5pI+kI=;
        b=Ljf7zR4Wr+5QeKdz9EZ6mvVoipm9+7vKlQ+jvMxHdFDIbt/gLYy2+u7KuKTHeHyLej
         HwgFHG70mW0kgzDDDozV9VE4kvF6y4ucRXoPFqJLKAmnBnZN8vjtYj//lVM46+OlQTiz
         ccxwy6BRwr5Y5+zpXWV3lVPJmi+W1wDhAAyM8hRm3TrjQjK59aJYl2EcV/kBaU2po/Il
         /O7B91ChUXECgYP6unFogfQe9bcpLpNlkuYcfLle1lHPpvbsREq+xGyqZbdxYbtBIjH9
         g1wIKzz+rF8qvTs3Eww5byS3UBVNE7W+y4HLWzT7MM/yxgr1VvH+Z9vba0Gqh14N50RZ
         ISbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751309561; x=1751914361;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uk4wFQOkB5TBMhF4OE45D/yEoCVdj/Ic+Hn9P5pI+kI=;
        b=J+Bm4kaAznp+nxIsLxugc/GqQmftTnWfBRDRz4RltkydpLowDbchsGWZJzjlainAw9
         OTZCnBsjcXOVPQQvuVBg8lbvpMQUrJ4NbMsZjSX9uSFk6omK+IjjnyLpL0lzpwWTgTyP
         qVIsnBIBzE9vebw+kNxe49j/hDc2J7B4N9rzYPWG03lvyDoCpZF9S2rlfI+pvM9HXLPS
         79B1xl2OponNjOFzWYDddZcxJzoCYCQ6hv4adAujnoZbRXkr5ET5nhN2eNLWs1NpG1Fb
         5UURzkzhaySfsQCnAqqElf8SotLAko6xsfiEQKVdzvbHsiLloN48STYseXl9nNKXVBNK
         y5lw==
X-Gm-Message-State: AOJu0YwP4JBq8n+IeLesh4Omii2xawV5FMAR4Ggze4SNAnxuihYoVE1S
	apMjWJalVnOUJEQvDartQVgN5aEeOIMj6HZ6Dng1QQ3iOL/S7lczNtkMzjaCLQ==
X-Gm-Gg: ASbGnctrV4R8KPJ3ogZRuohKCxJPjv1KPxrBQw7fVUBAKiN/y90RCIlStjt6Z+kquEv
	fTViqu3mj2nEK786pJEeUX9qyxdoqqs2KMQ2kSAeJWjqVHGFWBuYJVhEat/CD5D/ZOckuLBl86q
	3gzGi36GqQTzm2Qc71PTjgXCZpabSiE38BccpHp348B5D2TmgBJyTmyMdfbVTdOACGNOmAs071j
	S3p1RrUHqy2rfBF6BDgQikiawWQq7MPEu2+yq1+ffXCd16/0pV9nR+FfpiIPyvoi7z0s1vi/Jsf
	g7nAakCDYdAxhYBzGVOyp6xtpYYYnqX40wSsaYbqIMsQvCLlTjv0FkFjrjC+5IxhfZ+Gk+8M17f
	OIUUvfw==
X-Google-Smtp-Source: AGHT+IElbUhP50vyFGof6y4jLEVq0bOnessXATLuu4liX/tkkl7/srLB9TF2vyv78uHgSnvVOp4/hw==
X-Received: by 2002:a05:6214:621:b0:6fa:ac51:bbda with SMTP id 6a1803df08f44-70002ee7748mr226095626d6.26.1751309560929;
        Mon, 30 Jun 2025 11:52:40 -0700 (PDT)
Received: from fedora ([144.51.8.27])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6fd7718d053sm71390406d6.1.2025.06.30.11.52.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jun 2025 11:52:40 -0700 (PDT)
From: James Carter <jwcart2@gmail.com>
To: selinux@vger.kernel.org
Cc: James Carter <jwcart2@gmail.com>
Subject: [PATCH] libsepol/cil: Fix copying of declarations
Date: Mon, 30 Jun 2025 14:52:30 -0400
Message-ID: <20250630185230.228141-1-jwcart2@gmail.com>
X-Mailer: git-send-email 2.50.0
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 117e4c651e909a418e792efd7abfb90a131973de "libsepol: Allow
multiple policycap statements" has exposed problems in the copying
of declarations.

If a policycap statement is copied into a block (or other namespace)
that already has that policycap statement, then instead of creating
a new policycap struct, a pointer to the old one is returned. Later
in __cil_copy_node_helper() when cil_add_decl_to_symtab() is called,
SEPOL_EEXIST is returned and the original datum is destroyed. This
obviously causes problems later when there is an attempt to access
the orginal datum.

This problem is not just with policycap statements. A pointer to
the original datum should never be returned when copying a
declaration. For a simple declaration, a new struct should always
be created and passed to cil_add_decl_to_symtab(). It will handle
duplicate declarations properly. Either returning an error if
they are not allowed, or updating the right data structures if
they are. Also, since cil_add_decl_to_symtab() will report errors,
there is no need to check for a duplicate declaration before
calling it. For a more complex declaration which requires copying
other data as well as creating the datum, then it makes sense to
check for a duplcate declaration before doing that copy. This
applies to classpermisisons, permissionxs, catsets, levels,
levelranges, contexts, and ipaddrs.

When copying simple declarations, create a new declaration and
allow cil_add_decl_to_symtab() to handle the rest. For more
complex declarations, check for a duplicate declaration before
copying the data.

Reported-by: oss-fuzz (issues 427262638, 427271310, 427814464,
428057580, and 428041877)
Signed-off-by: James Carter <jwcart2@gmail.com>
---
 libsepol/cil/src/cil_copy_ast.c | 252 +++++++++-----------------------
 1 file changed, 66 insertions(+), 186 deletions(-)

diff --git a/libsepol/cil/src/cil_copy_ast.c b/libsepol/cil/src/cil_copy_ast.c
index 2911523e..172d92ff 100644
--- a/libsepol/cil/src/cil_copy_ast.c
+++ b/libsepol/cil/src/cil_copy_ast.c
@@ -170,38 +170,22 @@ int cil_copy_blockinherit(__attribute__((unused)) struct cil_db *db, void *data,
 	return SEPOL_OK;
 }
 
-static int cil_copy_policycap(__attribute__((unused)) struct cil_db *db, void *data, void **copy, symtab_t *symtab)
+static int cil_copy_policycap(__attribute__((unused)) struct cil_db *db, __attribute__((unused)) void *data, void **copy, __attribute__((unused)) symtab_t *symtab)
 {
-	struct cil_policycap *orig = data;
-	char *key = orig->datum.name;
-	struct cil_symtab_datum *datum = NULL;
-
-	cil_symtab_get_datum(symtab, key, &datum);
-	if (datum == NULL) {
-		struct cil_policycap *new;
-		cil_policycap_init(&new);
-		*copy = new;
-	} else {
-		*copy = datum;
-	}
+	struct cil_policycap *new;
+	
+	cil_policycap_init(&new);
+	*copy = new;
 
 	return SEPOL_OK;
 }
 
-int cil_copy_perm(__attribute__((unused)) struct cil_db *db, void *data, void **copy, symtab_t *symtab)
+int cil_copy_perm(__attribute__((unused)) struct cil_db *db, __attribute__((unused)) void *data, void **copy, __attribute__((unused)) symtab_t *symtab)
 {
-	struct cil_perm *orig = data;
-	char *key = orig->datum.name;
-	struct cil_symtab_datum *datum = NULL;
+	struct cil_perm *new;
 
-	cil_symtab_get_datum(symtab, key, &datum);
-	if (datum == NULL) {
-		struct cil_perm *new;
-		cil_perm_init(&new);
-		*copy = new;
-	} else {
-		*copy = datum;
-	}
+	cil_perm_init(&new);
+	*copy = new;
 
 	return SEPOL_OK;
 }
@@ -260,23 +244,11 @@ int cil_copy_classmapping(__attribute__((unused)) struct cil_db *db, void *data,
 	return SEPOL_OK;
 }
 
-int cil_copy_class(__attribute__((unused)) struct cil_db *db, void *data, void **copy, symtab_t *symtab)
+int cil_copy_class(__attribute__((unused)) struct cil_db *db, __attribute__((unused)) void *data, void **copy, __attribute__((unused)) symtab_t *symtab)
 {
-	struct cil_class *orig = data;
-	struct cil_class *new = NULL;
-	char *key = orig->datum.name;
-	struct cil_symtab_datum *datum = NULL;
-
-	cil_symtab_get_datum(symtab, key, &datum);
-	if (datum != NULL) {
-		cil_log(CIL_INFO, "cil_copy_class: class cannot be redefined\n");
-		return SEPOL_ERR;
-	}
+	struct cil_class *new;
 
 	cil_class_init(&new);
-
-	new->common = NULL;
-
 	*copy = new;
 
 	return SEPOL_OK;
@@ -285,22 +257,20 @@ int cil_copy_class(__attribute__((unused)) struct cil_db *db, void *data, void *
 int cil_copy_classpermission(__attribute__((unused)) struct cil_db *db, void *data, void **copy, symtab_t *symtab)
 {
 	struct cil_classpermission *orig = data;
-	struct cil_classpermission *new = NULL;
+	struct cil_classpermission *new;
 	char *key = orig->datum.name;
-	struct cil_symtab_datum *datum = NULL;
+	struct cil_symtab_datum *datum;
 
 	if (key != NULL) {
 		cil_symtab_get_datum(symtab, key, &datum);
 		if (datum != NULL) {
-			cil_log(CIL_INFO, "classpermission cannot be redefined\n");
+			cil_log(CIL_ERR, "Named classpermission cannot be redefined\n");
 			return SEPOL_ERR;
 		}
 	}
 
 	cil_classpermission_init(&new);
-
 	cil_copy_classperms_list(orig->classperms, &new->classperms);
-
 	*copy = new;
 
 	return SEPOL_OK;
@@ -340,20 +310,12 @@ int cil_copy_classcommon(__attribute__((unused)) struct cil_db *db, void *data,
 	return SEPOL_OK;
 }
 
-int cil_copy_sid(__attribute__((unused)) struct cil_db *db, void *data, void **copy, symtab_t *symtab)
+int cil_copy_sid(__attribute__((unused)) struct cil_db *db, __attribute__((unused)) void *data, void **copy, __attribute__((unused)) symtab_t *symtab)
 {
-	struct cil_sid *orig = data;
-	char *key = orig->datum.name;
-	struct cil_symtab_datum *datum = NULL;
+	struct cil_sid *new;
 
-	cil_symtab_get_datum(symtab, key, &datum);
-	if (datum == NULL) {
-		struct cil_sid *new;
-		cil_sid_init(&new);
-		*copy = new;
-	} else {
-		*copy = datum;
-	}
+	cil_sid_init(&new);
+	*copy = new;
 
 	return SEPOL_OK;
 }
@@ -377,38 +339,22 @@ int cil_copy_sidcontext(struct cil_db *db, void *data, void **copy, __attribute_
 	return SEPOL_OK;
 }
 
-int cil_copy_user(__attribute__((unused)) struct cil_db *db, void *data, void **copy, symtab_t *symtab)
+int cil_copy_user(__attribute__((unused)) struct cil_db *db, __attribute__((unused)) void *data, void **copy, __attribute__((unused)) symtab_t *symtab)
 {
-	struct cil_user *orig = data;
-	char *key = orig->datum.name;
-	struct cil_symtab_datum *datum = NULL;
+	struct cil_user *new;
 
-	cil_symtab_get_datum(symtab, key, &datum);
-	if (datum == NULL) {
-		struct cil_user *new;
-		cil_user_init(&new);
-		*copy = new;
-	} else {
-		*copy = datum;
-	}
+	cil_user_init(&new);
+	*copy = new;
 
 	return SEPOL_OK;
 }
 
-int cil_copy_userattribute(__attribute__((unused)) struct cil_db *db, void *data, void **copy, symtab_t *symtab)
+int cil_copy_userattribute(__attribute__((unused)) struct cil_db *db, __attribute__((unused)) void *data, void **copy, __attribute__((unused)) symtab_t *symtab)
 {
-	struct cil_userattribute *orig = data;
-	struct cil_userattribute *new = NULL;
-	char *key = orig->datum.name;
-	struct cil_symtab_datum *datum = NULL;
+	struct cil_userattribute *new;
 
-	cil_symtab_get_datum(symtab, key, &datum);
-	if (datum == NULL) {
-		cil_userattribute_init(&new);
-		*copy = new;
-	} else {
-		*copy = datum;
-	}
+	cil_userattribute_init(&new);
+	*copy = new;
 
 	return SEPOL_OK;
 }
@@ -501,20 +447,12 @@ int cil_copy_userprefix(__attribute__((unused)) struct cil_db *db, void *data, v
 	return SEPOL_OK;
 }
 
-int cil_copy_role(__attribute__((unused)) struct cil_db *db, void *data, void **copy, symtab_t *symtab)
+int cil_copy_role(__attribute__((unused)) struct cil_db *db, __attribute__((unused)) void *data, void **copy, __attribute__((unused)) symtab_t *symtab)
 {
-	struct cil_role *orig = data;
-	char *key = orig->datum.name;
-	struct cil_symtab_datum *datum = NULL;
+	struct cil_role *new;
 
-	cil_symtab_get_datum(symtab, key, &datum);
-	if (datum == NULL) {
-		struct cil_role *new;
-		cil_role_init(&new);
-		*copy = new;
-	} else {
-		*copy = datum;
-	}
+	cil_role_init(&new);
+	*copy = new;
 
 	return SEPOL_OK;
 }
@@ -534,20 +472,12 @@ int cil_copy_roletype(__attribute__((unused)) struct cil_db *db, void *data, voi
 	return SEPOL_OK;
 }
 
-int cil_copy_roleattribute(__attribute__((unused)) struct cil_db *db, void *data, void **copy, symtab_t *symtab)
+int cil_copy_roleattribute(__attribute__((unused)) struct cil_db *db, __attribute__((unused)) void *data, void **copy, __attribute__((unused)) symtab_t *symtab)
 {
-	struct cil_roleattribute *orig = data;
-	char *key = orig->datum.name;
-	struct cil_symtab_datum *datum = NULL;
+	struct cil_roleattribute *new;
 
-	cil_symtab_get_datum(symtab, key, &datum);
-	if (datum == NULL) {
-		struct cil_roleattribute *new;
-		cil_roleattribute_init(&new);
-		*copy = new;
-	} else {
-		*copy = datum;
-	}
+	cil_roleattribute_init(&new);
+	*copy = new;
 
 	return SEPOL_OK;
 }
@@ -671,21 +601,11 @@ static int cil_copy_expandtypeattribute(__attribute__((unused)) struct cil_db *d
 	return SEPOL_OK;
 }
 
-static int cil_copy_alias(__attribute__((unused)) struct cil_db *db, void *data, void **copy, symtab_t *symtab)
+static int cil_copy_alias(__attribute__((unused)) struct cil_db *db, __attribute__((unused)) void *data, void **copy, __attribute__((unused)) symtab_t *symtab)
 {
-	struct cil_alias *orig = data;
-	struct cil_alias *new = NULL;
-	char *key = orig->datum.name;
-	struct cil_symtab_datum *datum = NULL;
-
-	cil_symtab_get_datum(symtab, key, &datum);
-	if (datum != NULL) {
-		cil_log(CIL_INFO, "cil_copy_alias: alias cannot be redefined\n");
-		return SEPOL_ERR;
-	}
+	struct cil_alias *new;
 
 	cil_alias_init(&new);
-
 	*copy = new;
 
 	return SEPOL_OK;
@@ -768,18 +688,10 @@ int cil_copy_rangetransition(struct cil_db *db, void *data, void **copy, __attri
 	return SEPOL_OK;
 }
 
-int cil_copy_bool(__attribute__((unused)) struct cil_db *db, void *data, void **copy, symtab_t *symtab)
+int cil_copy_bool(__attribute__((unused)) struct cil_db *db, void *data, void **copy, __attribute__((unused)) symtab_t *symtab)
 {
 	struct cil_bool *orig = data;
-	struct cil_bool *new = NULL;
-	char *key = orig->datum.name;
-	struct cil_symtab_datum *datum = NULL;
-
-	cil_symtab_get_datum(symtab, key, &datum);
-	if (datum != NULL) {
-		cil_log(CIL_INFO, "cil_copy_bool: boolean cannot be redefined\n");
-		return SEPOL_ERR;
-	}
+	struct cil_bool *new;
 
 	cil_bool_init(&new);
 	new->value = orig->value;
@@ -788,18 +700,10 @@ int cil_copy_bool(__attribute__((unused)) struct cil_db *db, void *data, void **
 	return SEPOL_OK;
 }
 
-static int cil_copy_tunable(__attribute__((unused)) struct cil_db *db, void *data, void **copy, symtab_t *symtab)
+static int cil_copy_tunable(__attribute__((unused)) struct cil_db *db, void *data, void **copy, __attribute__((unused)) symtab_t *symtab)
 {
 	struct cil_tunable *orig = data;
-	struct cil_tunable *new = NULL;
-	char *key = orig->datum.name;
-	struct cil_symtab_datum *datum = NULL;
-
-	cil_symtab_get_datum(symtab, key, &datum);
-	if (datum != NULL) {
-		cil_log(CIL_INFO, "cil_copy_tunable: tunable cannot be redefined\n");
-		return SEPOL_ERR;
-	}
+	struct cil_tunable *new;
 
 	cil_tunable_init(&new);
 	new->value = orig->value;
@@ -846,20 +750,18 @@ int cil_copy_avrule(struct cil_db *db, void *data, void **copy, __attribute__((u
 static int cil_copy_permissionx(struct cil_db *db, void *data, void **copy, symtab_t *symtab)
 {
 	struct cil_permissionx *orig = data;
-	struct cil_permissionx *new = NULL;
+	struct cil_permissionx *new;
 	char *key = orig->datum.name;
-	struct cil_symtab_datum *datum = NULL;
-
+	struct cil_symtab_datum *datum;
 
 	cil_symtab_get_datum(symtab, key, &datum);
 	if (datum != NULL) {
-		cil_log(CIL_INFO, "cil_copy_permissionx: permissionx cannot be redefined\n");
+		cil_log(CIL_ERR, "Permissionx cannot be redefined\n");
 		return SEPOL_ERR;
 	}
 
 	cil_permissionx_init(&new);
 	cil_copy_fill_permissionx(db, orig, new);
-
 	*copy = new;
 
 	return SEPOL_OK;
@@ -899,38 +801,22 @@ int cil_copy_type_rule(__attribute__((unused)) struct cil_db *db, void *data, vo
 	return SEPOL_OK;
 }
 
-int cil_copy_sens(__attribute__((unused)) struct cil_db *db, void *data, void **copy, symtab_t *symtab)
+int cil_copy_sens(__attribute__((unused)) struct cil_db *db, __attribute__((unused)) void *data, void **copy, __attribute__((unused)) symtab_t *symtab)
 {
-	struct cil_sens *orig = data;
-	char *key = orig->datum.name;
-	struct cil_symtab_datum *datum = NULL;
+	struct cil_sens *new;
 
-	cil_symtab_get_datum(symtab, key, &datum);
-	if (datum == NULL) {
-		struct cil_sens *new;
-		cil_sens_init(&new);
-		*copy = new;
-	} else {
-		*copy = datum;
-	}
+	cil_sens_init(&new);
+	*copy = new;
 
 	return SEPOL_OK;
 }
 
-int cil_copy_cat(__attribute__((unused)) struct cil_db *db, void *data, void **copy, symtab_t *symtab)
+int cil_copy_cat(__attribute__((unused)) struct cil_db *db, __attribute__((unused)) void *data, void **copy, __attribute__((unused)) symtab_t *symtab)
 {
-	struct cil_cat *orig = data;
-	char *key = orig->datum.name;
-	struct cil_symtab_datum *datum = NULL;
+	struct cil_cat *new;
 
-	cil_symtab_get_datum(symtab, key, &datum);
-	if (datum == NULL) {
-		struct cil_cat *new;
-		cil_cat_init(&new);
-		*copy = new;
-	} else {
-		*copy = datum;
-	}
+	cil_cat_init(&new);
+	*copy = new;
 
 	return SEPOL_OK;
 }
@@ -945,20 +831,18 @@ static void cil_copy_cats(struct cil_db *db, struct cil_cats *orig, struct cil_c
 int cil_copy_catset(struct cil_db *db, void *data, void **copy, symtab_t *symtab)
 {
 	struct cil_catset *orig = data;
-	struct cil_catset *new = NULL;
+	struct cil_catset *new;
 	char *key = orig->datum.name;
-	struct cil_symtab_datum *datum = NULL;
+	struct cil_symtab_datum *datum;
 
 	cil_symtab_get_datum(symtab, key, &datum);
 	if (datum != NULL) {
-		cil_log(CIL_INFO, "cil_copy_catset: categoryset cannot be redefined\n");
+		cil_log(CIL_ERR, "Category set cannot be redefined\n");
 		return SEPOL_ERR;
 	}
 
 	cil_catset_init(&new);
-
 	cil_copy_cats(db, orig->cats, &new->cats);
-
 	*copy = new;
 
 	return SEPOL_OK;
@@ -994,20 +878,19 @@ void cil_copy_fill_level(struct cil_db *db, struct cil_level *orig, struct cil_l
 int cil_copy_level(struct cil_db *db, void *data, void **copy, symtab_t *symtab)
 {
 	struct cil_level *orig = data;
-	struct cil_level *new = NULL;
+	struct cil_level *new;
 	char *key = orig->datum.name;
-	struct cil_symtab_datum *datum = NULL;
+	struct cil_symtab_datum *datum;
 
 	if (key != NULL) {
 		cil_symtab_get_datum(symtab, key, &datum);
 		if (datum != NULL) {
-			cil_log(CIL_INFO, "cil_copy_level: level cannot be redefined\n");
+			cil_log(CIL_ERR, "Named level cannot be redefined\n");
 			return SEPOL_ERR;
 		}
 	}
 
 	cil_copy_fill_level(db, orig, &new);
-
 	*copy = new;
 
 	return SEPOL_OK;
@@ -1031,21 +914,20 @@ void cil_copy_fill_levelrange(struct cil_db *db, struct cil_levelrange *data, st
 int cil_copy_levelrange(struct cil_db *db, void *data, void **copy, symtab_t *symtab)
 {
 	struct cil_levelrange *orig = data;
-	struct cil_levelrange *new = NULL;
+	struct cil_levelrange *new;
 	char *key = orig->datum.name;
-	struct cil_symtab_datum *datum = NULL;
+	struct cil_symtab_datum *datum;
 
 	if (key != NULL) {
 		cil_symtab_get_datum(symtab, key, &datum);
 		if (datum != NULL) {
-			cil_log(CIL_INFO, "cil_copy_levelrange: levelrange cannot be redefined\n");
+			cil_log(CIL_ERR, "Named levelrange cannot be redefined\n");
 			return SEPOL_ERR;
 		}
 	}
 
 	cil_levelrange_init(&new);
 	cil_copy_fill_levelrange(db, orig, new);
-
 	*copy = new;
 
 	return SEPOL_OK;
@@ -1068,21 +950,20 @@ void cil_copy_fill_context(struct cil_db *db, struct cil_context *data, struct c
 int cil_copy_context(struct cil_db *db, void *data, void **copy, symtab_t *symtab)
 {
 	struct cil_context *orig = data;
-	struct cil_context *new = NULL;
+	struct cil_context *new;
 	char *key = orig->datum.name;
-	struct cil_symtab_datum *datum = NULL;
+	struct cil_symtab_datum *datum;
 
 	if (key != NULL) {
 		cil_symtab_get_datum(symtab, key, &datum);
 		if (datum != NULL) {
-			cil_log(CIL_INFO, "cil_copy_context: context cannot be redefined\n");
+			cil_log(CIL_ERR, "Named context cannot be redefined\n");
 			return SEPOL_ERR;
 		}
 	}
 
 	cil_context_init(&new);
 	cil_copy_fill_context(db, orig, new);
-
 	*copy = new;
 
 	return SEPOL_OK;
@@ -1542,19 +1423,18 @@ void cil_copy_fill_ipaddr(struct cil_ipaddr *data, struct cil_ipaddr *new)
 int cil_copy_ipaddr(__attribute__((unused)) struct cil_db *db, void *data, void **copy, symtab_t *symtab)
 {
 	struct cil_ipaddr *orig = data;
-	struct cil_ipaddr *new = NULL;
+	struct cil_ipaddr *new;
 	char * key = orig->datum.name;	
-	struct cil_symtab_datum *datum = NULL;
+	struct cil_symtab_datum *datum;
 
 	cil_symtab_get_datum(symtab, key, &datum);
 	if (datum != NULL) {
-		cil_log(CIL_INFO, "cil_copy_ipaddr: ipaddress cannot be redefined\n");
+		cil_log(CIL_ERR, "Named IP address cannot be redefined\n");
 		return SEPOL_ERR;
 	}
 
 	cil_ipaddr_init(&new);
 	cil_copy_fill_ipaddr(orig, new);
-
 	*copy = new;
 
 	return SEPOL_OK;
-- 
2.49.0

