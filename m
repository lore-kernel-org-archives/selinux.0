Return-Path: <SRS0=sWNN=AT=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F918C433DF
	for <selinux@archiver.kernel.org>; Wed,  8 Jul 2020 11:24:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E9B0F20772
	for <selinux@archiver.kernel.org>; Wed,  8 Jul 2020 11:24:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EmKfdkFN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728679AbgGHLY6 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 8 Jul 2020 07:24:58 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:41716 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728666AbgGHLY6 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 8 Jul 2020 07:24:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1594207495;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=x40jrShvEc/ZeH6VEVycY8nJpYJ5g8JNud1VbHtkvIQ=;
        b=EmKfdkFNFxbcxQs/erh7Tn8Mlo9eE5DZjXA7StGXd0dHQYLcO7GXqhVqKUQHDaoXOaBc+D
        5sQEcLxzdLA1b0ONN9wlB4hlLNU/LWOoFZVa1QSDx1gyEUFd2KdL2ISbs4BLWpAtiNx1HS
        I/tYsXq/colI6IFrBdhtsVC27oeJ/eI=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-513-jZBON10SPmWk3UgWTyZAQg-1; Wed, 08 Jul 2020 07:24:53 -0400
X-MC-Unique: jZBON10SPmWk3UgWTyZAQg-1
Received: by mail-ej1-f72.google.com with SMTP id q11so43317128eja.3
        for <selinux@vger.kernel.org>; Wed, 08 Jul 2020 04:24:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=x40jrShvEc/ZeH6VEVycY8nJpYJ5g8JNud1VbHtkvIQ=;
        b=ZwXFBVSKMuIhyUXO6EQjni0DwGT4GkmAzdX8acxj3ir9e7tjwdFqEwzSYv7WdR9mbI
         l4HnlMTnqSyTQ0IVf6rNtSe+wDjeNmHvGyLVKmiwaHPhhivEMKPz7J4qK+yrq/vZP9Q1
         VgK1oPv4LxgIMystpO0DDY0M6hlTGB6WzI/D/X+7U+BnXi1iZ53f+5XNRj/OiLogJUKB
         W8NBaKfujfkvqrQImSK7pdl6rX8F02EYg5+o8zWo+FpiHqqhcJ0zVbzaW2sL0qfSEDmr
         4vEM9Y3S9/thF29p1rZS9uOVNoMn1fexc2PvSb3yMgsgXeXfP1E6AoS9Z6dbIIImv/cV
         yq/A==
X-Gm-Message-State: AOAM53086ElotLm+5/nFIptUwufAQ6kahf/5caySU1l3wbVn3KzPLhaV
        iCxSb6Mat4df6loOnixlhrdi6wxsGwGMObQuku/RkqxbHO1145fNCwxznsVqnlaoQ2L+wa8/7qn
        KW6QJlPoKRlTkJiV5lg==
X-Received: by 2002:a17:907:7245:: with SMTP id ds5mr54231968ejc.67.1594207491695;
        Wed, 08 Jul 2020 04:24:51 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw6MZ/kr/Q4r4NhDtsc140shOGqHFVPHuq6rvzSEu4bb4PRfeEONwol2W2Wewu/3d7eBwZbiw==
X-Received: by 2002:a17:907:7245:: with SMTP id ds5mr54231950ejc.67.1594207491378;
        Wed, 08 Jul 2020 04:24:51 -0700 (PDT)
Received: from omos.redhat.com ([2a02:8308:b13f:2100:f695:3ae5:c8bf:2f57])
        by smtp.gmail.com with ESMTPSA id p9sm1839374ejd.50.2020.07.08.04.24.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2020 04:24:50 -0700 (PDT)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     selinux@vger.kernel.org, Paul Moore <paul@paul-moore.com>
Cc:     Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH v3 1/3] selinux: specialize symtab insert and search functions
Date:   Wed,  8 Jul 2020 13:24:45 +0200
Message-Id: <20200708112447.292321-2-omosnace@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200708112447.292321-1-omosnace@redhat.com>
References: <20200708112447.292321-1-omosnace@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

This encapsulates symtab a little better and will help with further
refactoring later.

Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
---
 security/selinux/ss/conditional.c |  4 +--
 security/selinux/ss/conditional.h |  2 +-
 security/selinux/ss/mls.c         | 21 +++++++------
 security/selinux/ss/policydb.c    | 52 +++++++++++++++----------------
 security/selinux/ss/services.c    | 34 ++++++++++----------
 security/selinux/ss/symtab.c      |  9 ++++++
 security/selinux/ss/symtab.h      |  3 ++
 7 files changed, 69 insertions(+), 56 deletions(-)

diff --git a/security/selinux/ss/conditional.c b/security/selinux/ss/conditional.c
index 25850c9ea6fae..e68dd2e4cac1d 100644
--- a/security/selinux/ss/conditional.c
+++ b/security/selinux/ss/conditional.c
@@ -200,7 +200,7 @@ static int bool_isvalid(struct cond_bool_datum *b)
 	return 1;
 }
 
-int cond_read_bool(struct policydb *p, struct hashtab *h, void *fp)
+int cond_read_bool(struct policydb *p, struct symtab *s, void *fp)
 {
 	char *key = NULL;
 	struct cond_bool_datum *booldatum;
@@ -235,7 +235,7 @@ int cond_read_bool(struct policydb *p, struct hashtab *h, void *fp)
 	if (rc)
 		goto err;
 	key[len] = '\0';
-	rc = hashtab_insert(h, key, booldatum);
+	rc = symtab_insert(s, key, booldatum);
 	if (rc)
 		goto err;
 
diff --git a/security/selinux/ss/conditional.h b/security/selinux/ss/conditional.h
index 90c9c964f5f55..79e7e03db8594 100644
--- a/security/selinux/ss/conditional.h
+++ b/security/selinux/ss/conditional.h
@@ -69,7 +69,7 @@ int cond_destroy_bool(void *key, void *datum, void *p);
 
 int cond_index_bool(void *key, void *datum, void *datap);
 
-int cond_read_bool(struct policydb *p, struct hashtab *h, void *fp);
+int cond_read_bool(struct policydb *p, struct symtab *s, void *fp);
 int cond_read_list(struct policydb *p, void *fp);
 int cond_write_bool(void *key, void *datum, void *ptr);
 int cond_write_list(struct policydb *p, void *fp);
diff --git a/security/selinux/ss/mls.c b/security/selinux/ss/mls.c
index cd8734f25b39b..5be241b6b1900 100644
--- a/security/selinux/ss/mls.c
+++ b/security/selinux/ss/mls.c
@@ -165,8 +165,8 @@ int mls_level_isvalid(struct policydb *p, struct mls_level *l)
 
 	if (!l->sens || l->sens > p->p_levels.nprim)
 		return 0;
-	levdatum = hashtab_search(&p->p_levels.table,
-				  sym_name(p, SYM_LEVELS, l->sens - 1));
+	levdatum = symtab_search(&p->p_levels,
+				 sym_name(p, SYM_LEVELS, l->sens - 1));
 	if (!levdatum)
 		return 0;
 
@@ -293,7 +293,7 @@ int mls_context_to_sid(struct policydb *pol,
 			*(next_cat++) = '\0';
 
 		/* Parse sensitivity. */
-		levdatum = hashtab_search(&pol->p_levels.table, sensitivity);
+		levdatum = symtab_search(&pol->p_levels, sensitivity);
 		if (!levdatum)
 			return -EINVAL;
 		context->range.level[l].sens = levdatum->level->sens;
@@ -312,7 +312,7 @@ int mls_context_to_sid(struct policydb *pol,
 				*rngptr++ = '\0';
 			}
 
-			catdatum = hashtab_search(&pol->p_cats.table, cur_cat);
+			catdatum = symtab_search(&pol->p_cats, cur_cat);
 			if (!catdatum)
 				return -EINVAL;
 
@@ -325,7 +325,7 @@ int mls_context_to_sid(struct policydb *pol,
 			if (rngptr == NULL)
 				continue;
 
-			rngdatum = hashtab_search(&pol->p_cats.table, rngptr);
+			rngdatum = symtab_search(&pol->p_cats, rngptr);
 			if (!rngdatum)
 				return -EINVAL;
 
@@ -458,9 +458,10 @@ int mls_convert_context(struct policydb *oldp,
 		return 0;
 
 	for (l = 0; l < 2; l++) {
-		levdatum = hashtab_search(&newp->p_levels.table,
-					  sym_name(oldp, SYM_LEVELS,
-						   oldc->range.level[l].sens - 1));
+		char *name = sym_name(oldp, SYM_LEVELS,
+				      oldc->range.level[l].sens - 1);
+
+		levdatum = symtab_search(&newp->p_levels, name);
 
 		if (!levdatum)
 			return -EINVAL;
@@ -470,8 +471,8 @@ int mls_convert_context(struct policydb *oldp,
 					      node, i) {
 			int rc;
 
-			catdatum = hashtab_search(&newp->p_cats.table,
-						  sym_name(oldp, SYM_CATS, i));
+			catdatum = symtab_search(&newp->p_cats,
+						 sym_name(oldp, SYM_CATS, i));
 			if (!catdatum)
 				return -EINVAL;
 			rc = ebitmap_set_bit(&newc->range.level[l].cat,
diff --git a/security/selinux/ss/policydb.c b/security/selinux/ss/policydb.c
index 6f81152248524..02b722c5c189d 100644
--- a/security/selinux/ss/policydb.c
+++ b/security/selinux/ss/policydb.c
@@ -400,7 +400,7 @@ static int roles_init(struct policydb *p)
 	if (!key)
 		goto out;
 
-	rc = hashtab_insert(&p->p_roles.table, key, role);
+	rc = symtab_insert(&p->p_roles, key, role);
 	if (rc)
 		goto out;
 
@@ -1065,7 +1065,7 @@ static int str_read(char **strp, gfp_t flags, void *fp, u32 len)
 	return 0;
 }
 
-static int perm_read(struct policydb *p, struct hashtab *h, void *fp)
+static int perm_read(struct policydb *p, struct symtab *s, void *fp)
 {
 	char *key = NULL;
 	struct perm_datum *perdatum;
@@ -1088,7 +1088,7 @@ static int perm_read(struct policydb *p, struct hashtab *h, void *fp)
 	if (rc)
 		goto bad;
 
-	rc = hashtab_insert(h, key, perdatum);
+	rc = symtab_insert(s, key, perdatum);
 	if (rc)
 		goto bad;
 
@@ -1098,7 +1098,7 @@ bad:
 	return rc;
 }
 
-static int common_read(struct policydb *p, struct hashtab *h, void *fp)
+static int common_read(struct policydb *p, struct symtab *s, void *fp)
 {
 	char *key = NULL;
 	struct common_datum *comdatum;
@@ -1128,12 +1128,12 @@ static int common_read(struct policydb *p, struct hashtab *h, void *fp)
 		goto bad;
 
 	for (i = 0; i < nel; i++) {
-		rc = perm_read(p, &comdatum->permissions.table, fp);
+		rc = perm_read(p, &comdatum->permissions, fp);
 		if (rc)
 			goto bad;
 	}
 
-	rc = hashtab_insert(h, key, comdatum);
+	rc = symtab_insert(s, key, comdatum);
 	if (rc)
 		goto bad;
 	return 0;
@@ -1262,7 +1262,7 @@ static int read_cons_helper(struct policydb *p,
 	return 0;
 }
 
-static int class_read(struct policydb *p, struct hashtab *h, void *fp)
+static int class_read(struct policydb *p, struct symtab *s, void *fp)
 {
 	char *key = NULL;
 	struct class_datum *cladatum;
@@ -1300,8 +1300,8 @@ static int class_read(struct policydb *p, struct hashtab *h, void *fp)
 			goto bad;
 
 		rc = -EINVAL;
-		cladatum->comdatum = hashtab_search(&p->p_commons.table,
-						    cladatum->comkey);
+		cladatum->comdatum = symtab_search(&p->p_commons,
+						   cladatum->comkey);
 		if (!cladatum->comdatum) {
 			pr_err("SELinux:  unknown common %s\n",
 			       cladatum->comkey);
@@ -1309,7 +1309,7 @@ static int class_read(struct policydb *p, struct hashtab *h, void *fp)
 		}
 	}
 	for (i = 0; i < nel; i++) {
-		rc = perm_read(p, &cladatum->permissions.table, fp);
+		rc = perm_read(p, &cladatum->permissions, fp);
 		if (rc)
 			goto bad;
 	}
@@ -1347,7 +1347,7 @@ static int class_read(struct policydb *p, struct hashtab *h, void *fp)
 		cladatum->default_type = le32_to_cpu(buf[0]);
 	}
 
-	rc = hashtab_insert(h, key, cladatum);
+	rc = symtab_insert(s, key, cladatum);
 	if (rc)
 		goto bad;
 
@@ -1357,7 +1357,7 @@ bad:
 	return rc;
 }
 
-static int role_read(struct policydb *p, struct hashtab *h, void *fp)
+static int role_read(struct policydb *p, struct symtab *s, void *fp)
 {
 	char *key = NULL;
 	struct role_datum *role;
@@ -1404,7 +1404,7 @@ static int role_read(struct policydb *p, struct hashtab *h, void *fp)
 		goto bad;
 	}
 
-	rc = hashtab_insert(h, key, role);
+	rc = symtab_insert(s, key, role);
 	if (rc)
 		goto bad;
 	return 0;
@@ -1413,7 +1413,7 @@ bad:
 	return rc;
 }
 
-static int type_read(struct policydb *p, struct hashtab *h, void *fp)
+static int type_read(struct policydb *p, struct symtab *s, void *fp)
 {
 	char *key = NULL;
 	struct type_datum *typdatum;
@@ -1451,7 +1451,7 @@ static int type_read(struct policydb *p, struct hashtab *h, void *fp)
 	if (rc)
 		goto bad;
 
-	rc = hashtab_insert(h, key, typdatum);
+	rc = symtab_insert(s, key, typdatum);
 	if (rc)
 		goto bad;
 	return 0;
@@ -1487,7 +1487,7 @@ static int mls_read_level(struct mls_level *lp, void *fp)
 	return 0;
 }
 
-static int user_read(struct policydb *p, struct hashtab *h, void *fp)
+static int user_read(struct policydb *p, struct symtab *s, void *fp)
 {
 	char *key = NULL;
 	struct user_datum *usrdatum;
@@ -1528,7 +1528,7 @@ static int user_read(struct policydb *p, struct hashtab *h, void *fp)
 			goto bad;
 	}
 
-	rc = hashtab_insert(h, key, usrdatum);
+	rc = symtab_insert(s, key, usrdatum);
 	if (rc)
 		goto bad;
 	return 0;
@@ -1537,7 +1537,7 @@ bad:
 	return rc;
 }
 
-static int sens_read(struct policydb *p, struct hashtab *h, void *fp)
+static int sens_read(struct policydb *p, struct symtab *s, void *fp)
 {
 	char *key = NULL;
 	struct level_datum *levdatum;
@@ -1569,7 +1569,7 @@ static int sens_read(struct policydb *p, struct hashtab *h, void *fp)
 	if (rc)
 		goto bad;
 
-	rc = hashtab_insert(h, key, levdatum);
+	rc = symtab_insert(s, key, levdatum);
 	if (rc)
 		goto bad;
 	return 0;
@@ -1578,7 +1578,7 @@ bad:
 	return rc;
 }
 
-static int cat_read(struct policydb *p, struct hashtab *h, void *fp)
+static int cat_read(struct policydb *p, struct symtab *s, void *fp)
 {
 	char *key = NULL;
 	struct cat_datum *catdatum;
@@ -1602,7 +1602,7 @@ static int cat_read(struct policydb *p, struct hashtab *h, void *fp)
 	if (rc)
 		goto bad;
 
-	rc = hashtab_insert(h, key, catdatum);
+	rc = symtab_insert(s, key, catdatum);
 	if (rc)
 		goto bad;
 	return 0;
@@ -1611,7 +1611,7 @@ bad:
 	return rc;
 }
 
-static int (*read_f[SYM_NUM]) (struct policydb *p, struct hashtab *h, void *fp) =
+static int (*read_f[SYM_NUM]) (struct policydb *p, struct symtab *s, void *fp) =
 {
 	common_read,
 	class_read,
@@ -1751,7 +1751,7 @@ u16 string_to_security_class(struct policydb *p, const char *name)
 {
 	struct class_datum *cladatum;
 
-	cladatum = hashtab_search(&p->p_classes.table, name);
+	cladatum = symtab_search(&p->p_classes, name);
 	if (!cladatum)
 		return 0;
 
@@ -1770,9 +1770,9 @@ u32 string_to_av_perm(struct policydb *p, u16 tclass, const char *name)
 	cladatum = p->class_val_to_struct[tclass-1];
 	comdatum = cladatum->comdatum;
 	if (comdatum)
-		perdatum = hashtab_search(&comdatum->permissions.table, name);
+		perdatum = symtab_search(&comdatum->permissions, name);
 	if (!perdatum)
-		perdatum = hashtab_search(&cladatum->permissions.table, name);
+		perdatum = symtab_search(&cladatum->permissions, name);
 	if (!perdatum)
 		return 0;
 
@@ -2509,7 +2509,7 @@ int policydb_read(struct policydb *p, void *fp)
 		}
 
 		for (j = 0; j < nel; j++) {
-			rc = read_f[i](p, &p->symtab[i].table, fp);
+			rc = read_f[i](p, &p->symtab[i], fp);
 			if (rc)
 				goto bad;
 		}
diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
index 313919bd42f8c..1d12bb9ff3dd6 100644
--- a/security/selinux/ss/services.c
+++ b/security/selinux/ss/services.c
@@ -1441,7 +1441,7 @@ static int string_to_context_struct(struct policydb *pol,
 
 	*p++ = 0;
 
-	usrdatum = hashtab_search(&pol->p_users.table, scontextp);
+	usrdatum = symtab_search(&pol->p_users, scontextp);
 	if (!usrdatum)
 		goto out;
 
@@ -1457,7 +1457,7 @@ static int string_to_context_struct(struct policydb *pol,
 
 	*p++ = 0;
 
-	role = hashtab_search(&pol->p_roles.table, scontextp);
+	role = symtab_search(&pol->p_roles, scontextp);
 	if (!role)
 		goto out;
 	ctx->role = role->value;
@@ -1469,7 +1469,7 @@ static int string_to_context_struct(struct policydb *pol,
 	oldc = *p;
 	*p++ = 0;
 
-	typdatum = hashtab_search(&pol->p_types.table, scontextp);
+	typdatum = symtab_search(&pol->p_types, scontextp);
 	if (!typdatum || typdatum->attribute)
 		goto out;
 
@@ -2024,26 +2024,26 @@ static int convert_context(struct context *oldc, struct context *newc, void *p)
 
 	/* Convert the user. */
 	rc = -EINVAL;
-	usrdatum = hashtab_search(&args->newp->p_users.table,
-				  sym_name(args->oldp,
-					   SYM_USERS, oldc->user - 1));
+	usrdatum = symtab_search(&args->newp->p_users,
+				 sym_name(args->oldp,
+					  SYM_USERS, oldc->user - 1));
 	if (!usrdatum)
 		goto bad;
 	newc->user = usrdatum->value;
 
 	/* Convert the role. */
 	rc = -EINVAL;
-	role = hashtab_search(&args->newp->p_roles.table,
-			      sym_name(args->oldp, SYM_ROLES, oldc->role - 1));
+	role = symtab_search(&args->newp->p_roles,
+			     sym_name(args->oldp, SYM_ROLES, oldc->role - 1));
 	if (!role)
 		goto bad;
 	newc->role = role->value;
 
 	/* Convert the type. */
 	rc = -EINVAL;
-	typdatum = hashtab_search(&args->newp->p_types.table,
-				  sym_name(args->oldp,
-					   SYM_TYPES, oldc->type - 1));
+	typdatum = symtab_search(&args->newp->p_types,
+				 sym_name(args->oldp,
+					  SYM_TYPES, oldc->type - 1));
 	if (!typdatum)
 		goto bad;
 	newc->type = typdatum->value;
@@ -2623,7 +2623,7 @@ int security_get_user_sids(struct selinux_state *state,
 		goto out_unlock;
 
 	rc = -EINVAL;
-	user = hashtab_search(&policydb->p_users.table, username);
+	user = symtab_search(&policydb->p_users, username);
 	if (!user)
 		goto out_unlock;
 
@@ -2975,7 +2975,7 @@ static int security_preserve_bools(struct selinux_state *state,
 	if (rc)
 		goto out;
 	for (i = 0; i < nbools; i++) {
-		booldatum = hashtab_search(&policydb->p_bools.table, bnames[i]);
+		booldatum = symtab_search(&policydb->p_bools, bnames[i]);
 		if (booldatum)
 			booldatum->state = bvalues[i];
 	}
@@ -3226,7 +3226,7 @@ int security_get_permissions(struct selinux_state *state,
 	read_lock(&state->ss->policy_rwlock);
 
 	rc = -EINVAL;
-	match = hashtab_search(&policydb->p_classes.table, class);
+	match = symtab_search(&policydb->p_classes, class);
 	if (!match) {
 		pr_err("SELinux: %s:  unrecognized class %s\n",
 			__func__, class);
@@ -3365,7 +3365,7 @@ int selinux_audit_rule_init(u32 field, u32 op, char *rulestr, void **vrule)
 	case AUDIT_SUBJ_USER:
 	case AUDIT_OBJ_USER:
 		rc = -EINVAL;
-		userdatum = hashtab_search(&policydb->p_users.table, rulestr);
+		userdatum = symtab_search(&policydb->p_users, rulestr);
 		if (!userdatum)
 			goto out;
 		tmprule->au_ctxt.user = userdatum->value;
@@ -3373,7 +3373,7 @@ int selinux_audit_rule_init(u32 field, u32 op, char *rulestr, void **vrule)
 	case AUDIT_SUBJ_ROLE:
 	case AUDIT_OBJ_ROLE:
 		rc = -EINVAL;
-		roledatum = hashtab_search(&policydb->p_roles.table, rulestr);
+		roledatum = symtab_search(&policydb->p_roles, rulestr);
 		if (!roledatum)
 			goto out;
 		tmprule->au_ctxt.role = roledatum->value;
@@ -3381,7 +3381,7 @@ int selinux_audit_rule_init(u32 field, u32 op, char *rulestr, void **vrule)
 	case AUDIT_SUBJ_TYPE:
 	case AUDIT_OBJ_TYPE:
 		rc = -EINVAL;
-		typedatum = hashtab_search(&policydb->p_types.table, rulestr);
+		typedatum = symtab_search(&policydb->p_types, rulestr);
 		if (!typedatum)
 			goto out;
 		tmprule->au_ctxt.type = typedatum->value;
diff --git a/security/selinux/ss/symtab.c b/security/selinux/ss/symtab.c
index 92d7a948070ed..48f523ef93aae 100644
--- a/security/selinux/ss/symtab.c
+++ b/security/selinux/ss/symtab.c
@@ -39,3 +39,12 @@ int symtab_init(struct symtab *s, unsigned int size)
 	return hashtab_init(&s->table, symhash, symcmp, size);
 }
 
+int symtab_insert(struct symtab *s, char *name, void *datum)
+{
+	return hashtab_insert(&s->table, name, datum);
+}
+
+void *symtab_search(struct symtab *s, const char *name)
+{
+	return hashtab_search(&s->table, name);
+}
diff --git a/security/selinux/ss/symtab.h b/security/selinux/ss/symtab.h
index f145301b9d9f7..f2614138d0cd8 100644
--- a/security/selinux/ss/symtab.h
+++ b/security/selinux/ss/symtab.h
@@ -19,6 +19,9 @@ struct symtab {
 
 int symtab_init(struct symtab *s, unsigned int size);
 
+int symtab_insert(struct symtab *s, char *name, void *datum);
+void *symtab_search(struct symtab *s, const char *name);
+
 #endif	/* _SS_SYMTAB_H_ */
 
 
-- 
2.26.2

