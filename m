Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2733F3D0D0
	for <selinux@vger.kernel.org>; Mon, 22 Jan 2024 13:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705931724; cv=none; b=FFjKaRNJMDCK5cyGh3xBe/+bzJBUvEC5ccSsqwrl+frLePsRm0H9aauKhyuuOiqHYiwsK5BAUAHHqEYdPMyJCBZH4qlb7igWKn8CT3c9OiyyY7qnoF8Cvrqzq2d29qMZVaQjHvf5r92N1z5QJy8HxE6RYLRFMmzYiC9tunyV3Ws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705931724; c=relaxed/simple;
	bh=ZFe9/FtWTOLUnAk7LrLWtC1UKnV/gQNqW7WyaCXGYXs=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NimlXDk91dEPUe352DuoXq1tI7/sXcE/Y2JicbLK8PZNoFJ4mVUV44NRlV6d/Em9nnCx12Pn19RQVNImq8RV8YXYcjNGaL7+Ud6PGrHky1/wC3kk7fJ4N+OVD2DBc74bNPZb8QcAQWBc93fGiP9vaqWAoP9V5s7fEBobflqrLFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=ZmrNoGXC; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="ZmrNoGXC"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-40e80046264so41041285e9.0
        for <selinux@vger.kernel.org>; Mon, 22 Jan 2024 05:55:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1705931720; x=1706536520; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qavJBSy4d/c1dBYEIzYp+MSpPGq2/WT8bP6OUmMm5oI=;
        b=ZmrNoGXCJmy1py1taxnX88djtLXdgYdk9zYqjj2qDvMCN0c6oeTrgpziNql6H/ALcV
         sTrGiOrcpgdqP8JOvybgXI1Fu60qgZKlzIW2X2bPxzp1lM2ROF05kahjIpEDUQCwb1yr
         BYfgqF7avnOHHaGI/s7GoaEg2Y27Ew6joK8yEHS4JRxKzF4fl4Wbh3o/Rd0j0G0r7dgt
         skmHb0ongUmHLZ1KITG5odu1sVxiEvsMwQvfgRsWs/ER0V3xqrK1ipAoJcg+gG2fJqBw
         ff92971wQUdUxMZmRCQqhlg5qPmwPLj9YAvaGGp9j39LaJFJRswD2xRznz8Jt0Aap9x4
         3S8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705931720; x=1706536520;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qavJBSy4d/c1dBYEIzYp+MSpPGq2/WT8bP6OUmMm5oI=;
        b=q86QB37mvm5phHenZ3N10+uupVLfKmK3FGEyzS8Tnt2tuL3jRrmlVJvyftGpYqlicy
         uYfyXPpLkbULDo6j+9qsJM8i/JliHvD0e6zhUVPbO2PCDI5j8jAA5paNgg7qUD5vKESf
         M1Vy8p+X3qbM14f3BmovsWDXeRxE4SHdKnwnqH7CZ4llmiwkgpCEOMIlt6ltaVKj9E3i
         CDPPw+S5TSDri3HD5+oJv/XQ5CVGbCmCl1YmgW2Y2aFd14NphSZMJ3kNClrxzqhUJweM
         c7z1CjXlcYmdKtV8LjmAJDnZGbgisz6PNqEz7Rz8TNfkxVCtXCKOfgIDGafTmdCLCYQ2
         XU8A==
X-Gm-Message-State: AOJu0Yw3ZafYeOKD7u/edaV5gmsU52V4c/+Q8A9KIUWYOGqLcVTEIOnP
	wMQy0qQiCW9RodbiQWLLHTp+aiGv23Qps0YsVPKVaU+g8zB7CSEG24tZ+gJx
X-Google-Smtp-Source: AGHT+IE/coc0m8lsWHxxKVR+zo7QzEaVuplfitym90xcjPDvTIwXGHEsuydpTucuczPdV9gnWUvsFA==
X-Received: by 2002:a05:600c:3c8b:b0:40e:44ad:4645 with SMTP id bg11-20020a05600c3c8b00b0040e44ad4645mr2430456wmb.3.1705931719988;
        Mon, 22 Jan 2024 05:55:19 -0800 (PST)
Received: from ddev.DebianHome (dynamic-077-003-088-202.77.3.pool.telefonica.de. [77.3.88.202])
        by smtp.gmail.com with ESMTPSA id i16-20020a1709061cd000b00a28825e0a2bsm13340284ejh.22.2024.01.22.05.55.19
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jan 2024 05:55:19 -0800 (PST)
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To: selinux@vger.kernel.org
Subject: [PATCH 12/15] checkpolicy: provide more descriptive error messages
Date: Mon, 22 Jan 2024 14:55:04 +0100
Message-ID: <20240122135507.63506-12-cgzones@googlemail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240122135507.63506-1-cgzones@googlemail.com>
References: <20240122135507.63506-1-cgzones@googlemail.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Provide more descriptive error messages by including the identifier
or other kind of value if available.

Also drop duplicate newlines at the end of messages.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 checkpolicy/module_compiler.c |   6 +-
 checkpolicy/policy_define.c   | 123 ++++++++++++++++++++--------------
 2 files changed, 76 insertions(+), 53 deletions(-)

diff --git a/checkpolicy/module_compiler.c b/checkpolicy/module_compiler.c
index 74a9f93c..119b7e36 100644
--- a/checkpolicy/module_compiler.c
+++ b/checkpolicy/module_compiler.c
@@ -75,7 +75,7 @@ static void print_error_msg(int ret, uint32_t symbol_type)
 		yyerror2("Could not declare %s here", flavor_str[symbol_type]);
 		break;
 	default:
-		yyerror("Unknown error");
+		yyerror2("Unknown error %d", ret);
 	}
 }
 
@@ -86,7 +86,7 @@ int define_policy(int pass, int module_header_given)
 	if (module_header_given) {
 		if (policydbp->policy_type != POLICY_MOD) {
 			yyerror
-			    ("Module specification found while not building a policy module.\n");
+			    ("Module specification found while not building a policy module.");
 			return -1;
 		}
 
@@ -111,7 +111,7 @@ int define_policy(int pass, int module_header_given)
 	} else {
 		if (policydbp->policy_type == POLICY_MOD) {
 			yyerror
-			    ("Building a policy module, but no module specification found.\n");
+			    ("Building a policy module, but no module specification found.");
 			return -1;
 		}
 	}
diff --git a/checkpolicy/policy_define.c b/checkpolicy/policy_define.c
index 360cff68..cd49cae3 100644
--- a/checkpolicy/policy_define.c
+++ b/checkpolicy/policy_define.c
@@ -96,6 +96,17 @@ void yyerror2(const char *fmt, ...)
 	va_end(ap);
 }
 
+__attribute__ ((format(printf, 1, 2)))
+static void yywarn2(const char *fmt, ...)
+{
+	char warnmsg[256];
+	va_list ap;
+	va_start(ap, fmt);
+	vsnprintf(warnmsg, sizeof(warnmsg), fmt, ap);
+	yywarn(warnmsg);
+	va_end(ap);
+}
+
 int insert_separator(int push)
 {
 	int error;
@@ -233,7 +244,7 @@ int define_permissive(void)
 	}
 
 	if (t->flavor == TYPE_ATTRIB) {
-		yyerror2("attributes may not be permissive: %s\n", type);
+		yyerror2("attributes may not be permissive: %s", type);
 		rc = -1;
 		goto out;
 	}
@@ -520,7 +531,7 @@ int define_common_perms(void)
 	}
 	comdatum = hashtab_search(policydbp->p_commons.table, id);
 	if (comdatum) {
-		yyerror2("duplicate declaration for common %s\n", id);
+		yyerror2("duplicate declaration for common %s", id);
 		free(id);
 		return -1;
 	}
@@ -557,8 +568,8 @@ int define_common_perms(void)
 		perdatum->s.value = comdatum->permissions.nprim + 1;
 
 		if (perdatum->s.value > (sizeof(sepol_access_vector_t) * 8)) {
-			yyerror
-			    ("too many permissions to fit in an access vector");
+			yyerror2
+			    ("too many permissions (%d) to fit in an access vector", perdatum->s.value);
 			goto bad_perm;
 		}
 		ret = hashtab_insert(comdatum->permissions.table,
@@ -619,12 +630,15 @@ int define_av_perms(int inherits)
 		yyerror2("class %s is not defined", id);
 		goto bad;
 	}
-	free(id);
 
 	if (cladatum->comdatum || cladatum->permissions.nprim) {
-		yyerror("duplicate access vector definition");
-		return -1;
+		yyerror2("duplicate access vector definition for class %s", id);
+		goto bad;
 	}
+
+	free(id);
+	id = NULL;
+
 	if (symtab_init(&cladatum->permissions, PERM_SYMTAB_SIZE)) {
 		yyerror("out of memory");
 		return -1;
@@ -664,8 +678,8 @@ int define_av_perms(int inherits)
 		perdatum->s.value = ++cladatum->permissions.nprim;
 
 		if (perdatum->s.value > (sizeof(sepol_access_vector_t) * 8)) {
-			yyerror
-			    ("too many permissions to fit in an access vector");
+			yyerror2
+			    ("too many permissions (%d) to fit in an access vector", perdatum->s.value);
 			goto bad;
 		}
 		if (inherits) {
@@ -737,7 +751,7 @@ int define_sens(void)
 		return -1;
 	}
 	if (id_has_dot(id)) {
-		yyerror("sensitivity identifiers may not contain periods");
+		yyerror2("sensitivity identifier %s may not contain periods", id);
 		goto bad;
 	}
 	level = (mls_level_t *) malloc(sizeof(mls_level_t));
@@ -766,11 +780,11 @@ int define_sens(void)
 			goto bad;
 		}
 	case -2:{
-			yyerror("duplicate declaration of sensitivity level");
+			yyerror2("duplicate declaration of sensitivity level %s", id);
 			goto bad;
 		}
 	case -1:{
-			yyerror("could not declare sensitivity level here");
+			yyerror2("could not declare sensitivity level %s here", id);
 			goto bad;
 		}
 	case 0:
@@ -784,7 +798,7 @@ int define_sens(void)
 
 	while ((id = queue_remove(id_queue))) {
 		if (id_has_dot(id)) {
-			yyerror("sensitivity aliases may not contain periods");
+			yyerror2("sensitivity alias %s may not contain periods", id);
 			free(id);
 			return -1;
 		}
@@ -806,13 +820,13 @@ int define_sens(void)
 				goto bad_alias;
 			}
 		case -2:{
-				yyerror
-				    ("duplicate declaration of sensitivity alias");
+				yyerror2
+				    ("duplicate declaration of sensitivity alias %s", id);
 				goto bad_alias;
 			}
 		case -1:{
-				yyerror
-				    ("could not declare sensitivity alias here");
+				yyerror2
+				    ("could not declare sensitivity alias %s here", id);
 				goto bad_alias;
 			}
 		case 0:
@@ -920,7 +934,7 @@ int define_category(void)
 		return -1;
 	}
 	if (id_has_dot(id)) {
-		yyerror("category identifiers may not contain periods");
+		yyerror2("category identifier %s may not contain periods", id);
 		goto bad;
 	}
 	datum = (cat_datum_t *) malloc(sizeof(cat_datum_t));
@@ -938,11 +952,11 @@ int define_category(void)
 			goto bad;
 		}
 	case -2:{
-			yyerror("duplicate declaration of category");
+			yyerror2("duplicate declaration of category %s", id);
 			goto bad;
 		}
 	case -1:{
-			yyerror("could not declare category here");
+			yyerror2("could not declare category %s here", id);
 			goto bad;
 		}
 	case 0:
@@ -957,7 +971,7 @@ int define_category(void)
 
 	while ((id = queue_remove(id_queue))) {
 		if (id_has_dot(id)) {
-			yyerror("category aliases may not contain periods");
+			yyerror2("category alias %s may not contain periods", id);
 			free(id);
 			return -1;
 		}
@@ -980,13 +994,13 @@ int define_category(void)
 				goto bad_alias;
 			}
 		case -2:{
-				yyerror
-				    ("duplicate declaration of category aliases");
+				yyerror2
+				    ("duplicate declaration of category alias %s", id);
 				goto bad_alias;
 			}
 		case -1:{
-				yyerror
-				    ("could not declare category aliases here");
+				yyerror2
+				    ("could not declare category alias %s here", id);
 				goto bad_alias;
 			}
 		case 0:
@@ -1114,7 +1128,7 @@ int define_level(void)
 			range_end = cdatum->s.value - 1;
 
 			if (range_end < range_start) {
-				yyerror2("category range is invalid");
+				yyerror2("category range %d-%d is invalid", range_start, range_end);
 				free(id);
 				return -1;
 			}
@@ -1170,6 +1184,7 @@ int expand_attrib(void)
 	ebitmap_t attrs;
 	type_datum_t *attr;
 	ebitmap_node_t *node;
+	const char *name;
 	uint32_t i;
 	int rc = -1;
 	int flags = 0;
@@ -1222,13 +1237,13 @@ int expand_attrib(void)
 	}
 
 	ebitmap_for_each_positive_bit(&attrs, node, i) {
-		attr = hashtab_search(policydbp->p_types.table,
-				policydbp->sym_val_to_name[SYM_TYPES][i]);
+		name = policydbp->sym_val_to_name[SYM_TYPES][i];
+		attr = hashtab_search(policydbp->p_types.table, name);
 		attr->flags |= flags;
 		if ((attr->flags & TYPE_FLAGS_EXPAND_ATTR_TRUE) &&
 				(attr->flags & TYPE_FLAGS_EXPAND_ATTR_FALSE)) {
-			yywarn("Expandattribute option was set to both true and false. "
-				"Resolving to false.");
+			yywarn2("Expandattribute option of attribute %s was set to both true and false; "
+				"Resolving to false.", name);
 			attr->flags &= ~TYPE_FLAGS_EXPAND_ATTR_TRUE;
 		}
 	}
@@ -1247,9 +1262,9 @@ static int add_aliases_to_type(type_datum_t * type)
 	int ret;
 	while ((id = queue_remove(id_queue))) {
 		if (id_has_dot(id)) {
+			yyerror2
+			    ("type alias identifier %s may not contain periods", id);
 			free(id);
-			yyerror
-			    ("type alias identifiers may not contain periods");
 			return -1;
 		}
 		aliasdatum = (type_datum_t *) malloc(sizeof(type_datum_t));
@@ -1274,7 +1289,7 @@ static int add_aliases_to_type(type_datum_t * type)
 				goto cleanup;
 			}
 		case -1:{
-				yyerror("could not declare alias here");
+				yyerror2("could not declare alias %s here", id);
 				goto cleanup;
 			}
 		case 0:	 	break;
@@ -1790,8 +1805,8 @@ int define_bool_tunable(int is_tunable)
 		return -1;
 	}
 	if (id_has_dot(id)) {
+		yyerror2("boolean identifier %s may not contain periods", id);
 		free(id);
-		yyerror("boolean identifiers may not contain periods");
 		return -1;
 	}
 	datum = (cond_bool_datum_t *) malloc(sizeof(cond_bool_datum_t));
@@ -1814,7 +1829,7 @@ int define_bool_tunable(int is_tunable)
 			goto cleanup;
 		}
 	case -1:{
-			yyerror("could not declare boolean here");
+			yyerror2("could not declare boolean %s here", id);
 			goto cleanup;
 		}
 	case 0:
@@ -1957,7 +1972,8 @@ static int avrule_read_ioctls(struct av_ioctl_range_list **rangehead)
 			id = queue_remove(id_queue);
 			r->range.high = (uint16_t) strtoul(id,NULL,0);
 			if (r->range.high < r->range.low) {
-				yyerror("Ioctl ranges must be in ascending order.");
+				yyerror2("Ioctl range %d-%d must be in ascending order.",
+					 r->range.low, r->range.high);
 				return -1;
 			}
 			free(id);
@@ -2532,7 +2548,7 @@ int define_te_avtab_extended_perms(int which)
 	if (strcmp(id,"ioctl") == 0) {
 		rc = define_te_avtab_ioctl(avrule_template);
 	} else {
-		yyerror("only ioctl extended permissions are supported");
+		yyerror2("only ioctl extended permissions are supported, found %s", id);
 		rc = -1;
 	}
 
@@ -3189,7 +3205,7 @@ int define_role_allow(void)
 avrule_t *define_cond_filename_trans(void)
 {
 	yyerror("type transitions with a filename not allowed inside "
-		"conditionals\n");
+		"conditionals");
 	return COND_ERR;
 }
 
@@ -3861,7 +3877,7 @@ int define_conditional(cond_expr_t * expr, avrule_t * t, avrule_t * f)
 		f = 0;
 		expr = define_cond_expr(COND_NOT, expr, 0);
 		if (!expr) {
-			yyerror("unable to invert");
+			yyerror("unable to invert conditional expression");
 			return -1;
 		}
 	}
@@ -4126,7 +4142,7 @@ static int parse_categories(char *id, level_datum_t * levdatum, ebitmap_t * cats
 		range_end = cdatum->s.value - 1;
 
 		if (range_end < range_start) {
-			yyerror2("category range is invalid");
+			yyerror2("category range %d-%d is invalid", range_start, range_end);
 			return -1;
 		}
 	} else {
@@ -5102,7 +5118,7 @@ int define_ibendport_context(unsigned int port)
 	}
 
 	if (port > 0xff || port == 0) {
-		yyerror("Invalid ibendport port number, should be 0 < port < 256");
+		yyerror2("Invalid ibendport port number %d, should be 0 < port < 256", port);
 		return -1;
 	}
 
@@ -5121,7 +5137,7 @@ int define_ibendport_context(unsigned int port)
 	}
 
 	if (strlen(newc->u.ibendport.dev_name) > IB_DEVICE_NAME_MAX - 1) {
-		yyerror("infiniband device name exceeds max length of 63.");
+		yyerror2("infiniband device name %s exceeds max length of 63.", newc->u.ibendport.dev_name);
 		rc = -1;
 		goto out;
 	}
@@ -5248,13 +5264,14 @@ int define_ipv4_node_context(void)
 	}
 
 	rc = inet_pton(AF_INET, id, &addr);
-	free(id);
 	if (rc < 1) {
-		yyerror("failed to parse ipv4 address");
+		yyerror2("failed to parse ipv4 address %s", id);
+		free(id);
 		if (rc == 0)
 			rc = -1;
 		goto out;
 	}
+	free(id);
 
 	id = queue_remove(id_queue);
 	if (!id) {
@@ -5264,14 +5281,16 @@ int define_ipv4_node_context(void)
 	}
 
 	rc = inet_pton(AF_INET, id, &mask);
-	free(id);
 	if (rc < 1) {
-		yyerror("failed to parse ipv4 mask");
+		yyerror2("failed to parse ipv4 mask %s", id);
+		free(id);
 		if (rc == 0)
 			rc = -1;
 		goto out;
 	}
 
+	free(id);
+
 	if (mask.s_addr != 0 && ((~mask.s_addr + 1) & ~mask.s_addr) != 0) {
 		yywarn("ipv4 mask is not contiguous");
 	}
@@ -5376,14 +5395,16 @@ int define_ipv6_node_context(void)
 	}
 
 	rc = inet_pton(AF_INET6, id, &addr);
-	free(id);
 	if (rc < 1) {
-		yyerror("failed to parse ipv6 address");
+		yyerror2("failed to parse ipv6 address %s", id);
+		free(id);
 		if (rc == 0)
 			rc = -1;
 		goto out;
 	}
 
+	free(id);
+
 	id = queue_remove(id_queue);
 	if (!id) {
 		yyerror("failed to read ipv6 address");
@@ -5392,14 +5413,16 @@ int define_ipv6_node_context(void)
 	}
 
 	rc = inet_pton(AF_INET6, id, &mask);
-	free(id);
 	if (rc < 1) {
-		yyerror("failed to parse ipv6 mask");
+		yyerror2("failed to parse ipv6 mask %s", id);
+		free(id);
 		if (rc == 0)
 			rc = -1;
 		goto out;
 	}
 
+	free(id);
+
 	if (!ipv6_is_mask_contiguous(&mask)) {
 		yywarn("ipv6 mask is not contiguous");
 	}
-- 
2.43.0

