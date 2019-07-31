Return-Path: <SRS0=SQk1=V4=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BEB7C32751
	for <selinux@archiver.kernel.org>; Wed, 31 Jul 2019 23:29:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F61C20679
	for <selinux@archiver.kernel.org>; Wed, 31 Jul 2019 23:29:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="kHxyn+WE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730700AbfGaX3R (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 31 Jul 2019 19:29:17 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:42044 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725793AbfGaX3R (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 31 Jul 2019 19:29:17 -0400
Received: by mail-qt1-f195.google.com with SMTP id h18so68336200qtm.9
        for <selinux@vger.kernel.org>; Wed, 31 Jul 2019 16:29:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=subject:from:to:date:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=8PioBQkDOh/v/axWmkgv9+FP+4IoMNuyS2flKEg40kA=;
        b=kHxyn+WEIukINFry9xhni1xz3L6llqQlDwNq51RlXL+8RcnKFpNOimGWiTHhZqRvd8
         BaNwJJfymmhpdZ+QLI7sIBGO2gvTrZX571zrTaKKCN1fmmbMzrcSOGD2sRdY3dpYMQgV
         5gvubeFTK0DhVaMdqKFh2S5g0FIczZ+M0G9/NDVyn34G7AFPgNaFPznBP/XP7CRo4ldp
         chMewTQ0/T6TmxeAon7EGCdJ0QWvldokkSOSLA/0BMqZwb7yo4RxAuJRmkpU9qJ/peNg
         tA7fFIchGsvhWyG7TkT7eKL8u8m3g9d4nZOit9wrk1ucT+Krf4u6MsfXbldT6wY1FdxX
         f5Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:date:message-id:user-agent
         :mime-version:content-transfer-encoding;
        bh=8PioBQkDOh/v/axWmkgv9+FP+4IoMNuyS2flKEg40kA=;
        b=S7zdg5R+p5PPKqvCHIXKon2MoEHiFX1nzKXjN5L8mPqv2hgQyv9pknxkjD+8jdYy7z
         pfsegNUwEjvdHWAjU8UDrX3sgeT9bxSNvWtapjXQ913g4IFAu0rSW1bBNl88NiOVvbfO
         aIS8QxSzGmDzsYRxwTcwnDqyMupwg3npIkCVsVwWvKdZPSAI5CIY9y7y73y5vysg8294
         h9EVLPGsPUyhY6GWzcUvbrsKpHVLNcRt4a1hAJWMIMZAGeyx+hGZmBJ5IHxbDiX20HaF
         SrwWKksdQyeq0UApBpqI93xjINcx99gaJUfm7aExX6UGjGIhlXyJzctekd1oKEv+wh1M
         WZVA==
X-Gm-Message-State: APjAAAVzYPuWsA1YTozbkwV9z+3g1JWwsu6V7SoEw/wxVYynK8tC43lS
        YFwgXz768j/fBIrrU3DCUVGMNVU=
X-Google-Smtp-Source: APXvYqzCbNk+PD9sxuT9LRK1aSUZNJ1juPIvdf3AR/qeRP1yITY3XSDFPU2ENBmPnpiSL7aLuZVQuw==
X-Received: by 2002:aed:39e5:: with SMTP id m92mr85550392qte.135.1564615755764;
        Wed, 31 Jul 2019 16:29:15 -0700 (PDT)
Received: from localhost (static-96-233-112-89.bstnma.ftas.verizon.net. [96.233.112.89])
        by smtp.gmail.com with ESMTPSA id j19sm27598198qtq.94.2019.07.31.16.29.14
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 31 Jul 2019 16:29:15 -0700 (PDT)
Subject: [PATCH] selinux: shuffle around policydb.c to get rid of forward
 declarations
From:   Paul Moore <paul@paul-moore.com>
To:     selinux@vger.kernel.org
Date:   Wed, 31 Jul 2019 19:29:14 -0400
Message-ID: <156461575415.7833.141394474474181558.stgit@chester>
User-Agent: StGit/0.19-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

No code changes, but move a lot of the policydb destructors higher up
so we can get rid of a forward declaration.

This patch does expose a few old checkpatch.pl errors, but those will
be dealt with in a separate (set of) patches.

Signed-off-by: Paul Moore <paul@paul-moore.com>
---
 security/selinux/ss/policydb.c |  376 ++++++++++++++++++++--------------------
 1 file changed, 187 insertions(+), 189 deletions(-)

diff --git a/security/selinux/ss/policydb.c b/security/selinux/ss/policydb.c
index 38d0083204f1..d5effce86304 100644
--- a/security/selinux/ss/policydb.c
+++ b/security/selinux/ss/policydb.c
@@ -178,6 +178,193 @@ static struct policydb_compat_info *policydb_lookup_compat(int version)
 	return info;
 }
 
+/*
+ * The following *_destroy functions are used to
+ * free any memory allocated for each kind of
+ * symbol data in the policy database.
+ */
+
+static int perm_destroy(void *key, void *datum, void *p)
+{
+	kfree(key);
+	kfree(datum);
+	return 0;
+}
+
+static int common_destroy(void *key, void *datum, void *p)
+{
+	struct common_datum *comdatum;
+
+	kfree(key);
+	if (datum) {
+		comdatum = datum;
+		hashtab_map(comdatum->permissions.table, perm_destroy, NULL);
+		hashtab_destroy(comdatum->permissions.table);
+	}
+	kfree(datum);
+	return 0;
+}
+
+static void constraint_expr_destroy(struct constraint_expr *expr)
+{
+	if (expr) {
+		ebitmap_destroy(&expr->names);
+		if (expr->type_names) {
+			ebitmap_destroy(&expr->type_names->types);
+			ebitmap_destroy(&expr->type_names->negset);
+			kfree(expr->type_names);
+		}
+		kfree(expr);
+	}
+}
+
+static int cls_destroy(void *key, void *datum, void *p)
+{
+	struct class_datum *cladatum;
+	struct constraint_node *constraint, *ctemp;
+	struct constraint_expr *e, *etmp;
+
+	kfree(key);
+	if (datum) {
+		cladatum = datum;
+		hashtab_map(cladatum->permissions.table, perm_destroy, NULL);
+		hashtab_destroy(cladatum->permissions.table);
+		constraint = cladatum->constraints;
+		while (constraint) {
+			e = constraint->expr;
+			while (e) {
+				etmp = e;
+				e = e->next;
+				constraint_expr_destroy(etmp);
+			}
+			ctemp = constraint;
+			constraint = constraint->next;
+			kfree(ctemp);
+		}
+
+		constraint = cladatum->validatetrans;
+		while (constraint) {
+			e = constraint->expr;
+			while (e) {
+				etmp = e;
+				e = e->next;
+				constraint_expr_destroy(etmp);
+			}
+			ctemp = constraint;
+			constraint = constraint->next;
+			kfree(ctemp);
+		}
+		kfree(cladatum->comkey);
+	}
+	kfree(datum);
+	return 0;
+}
+
+static int role_destroy(void *key, void *datum, void *p)
+{
+	struct role_datum *role;
+
+	kfree(key);
+	if (datum) {
+		role = datum;
+		ebitmap_destroy(&role->dominates);
+		ebitmap_destroy(&role->types);
+	}
+	kfree(datum);
+	return 0;
+}
+
+static int type_destroy(void *key, void *datum, void *p)
+{
+	kfree(key);
+	kfree(datum);
+	return 0;
+}
+
+static int user_destroy(void *key, void *datum, void *p)
+{
+	struct user_datum *usrdatum;
+
+	kfree(key);
+	if (datum) {
+		usrdatum = datum;
+		ebitmap_destroy(&usrdatum->roles);
+		ebitmap_destroy(&usrdatum->range.level[0].cat);
+		ebitmap_destroy(&usrdatum->range.level[1].cat);
+		ebitmap_destroy(&usrdatum->dfltlevel.cat);
+	}
+	kfree(datum);
+	return 0;
+}
+
+static int sens_destroy(void *key, void *datum, void *p)
+{
+	struct level_datum *levdatum;
+
+	kfree(key);
+	if (datum) {
+		levdatum = datum;
+		if (levdatum->level)
+			ebitmap_destroy(&levdatum->level->cat);
+		kfree(levdatum->level);
+	}
+	kfree(datum);
+	return 0;
+}
+
+static int cat_destroy(void *key, void *datum, void *p)
+{
+	kfree(key);
+	kfree(datum);
+	return 0;
+}
+
+static int (*destroy_f[SYM_NUM]) (void *key, void *datum, void *datap) =
+{
+	common_destroy,
+	cls_destroy,
+	role_destroy,
+	type_destroy,
+	user_destroy,
+	cond_destroy_bool,
+	sens_destroy,
+	cat_destroy,
+};
+
+static int filenametr_destroy(void *key, void *datum, void *p)
+{
+	struct filename_trans *ft = key;
+	kfree(ft->name);
+	kfree(key);
+	kfree(datum);
+	cond_resched();
+	return 0;
+}
+
+static int range_tr_destroy(void *key, void *datum, void *p)
+{
+	struct mls_range *rt = datum;
+	kfree(key);
+	ebitmap_destroy(&rt->level[0].cat);
+	ebitmap_destroy(&rt->level[1].cat);
+	kfree(datum);
+	cond_resched();
+	return 0;
+}
+
+static void ocontext_destroy(struct ocontext *c, int i)
+{
+	if (!c)
+		return;
+
+	context_destroy(&c->context[0]);
+	context_destroy(&c->context[1]);
+	if (i == OCON_ISID || i == OCON_FS ||
+	    i == OCON_NETIF || i == OCON_FSUSE)
+		kfree(c->u.name);
+	kfree(c);
+}
+
 /*
  * Initialize the role table.
  */
@@ -274,8 +461,6 @@ static int rangetr_cmp(struct hashtab *h, const void *k1, const void *k2)
 	return v;
 }
 
-static int (*destroy_f[SYM_NUM]) (void *key, void *datum, void *datap);
-
 /*
  * Initialize a policy database structure.
  */
@@ -569,193 +754,6 @@ static int policydb_index(struct policydb *p)
 	return rc;
 }
 
-/*
- * The following *_destroy functions are used to
- * free any memory allocated for each kind of
- * symbol data in the policy database.
- */
-
-static int perm_destroy(void *key, void *datum, void *p)
-{
-	kfree(key);
-	kfree(datum);
-	return 0;
-}
-
-static int common_destroy(void *key, void *datum, void *p)
-{
-	struct common_datum *comdatum;
-
-	kfree(key);
-	if (datum) {
-		comdatum = datum;
-		hashtab_map(comdatum->permissions.table, perm_destroy, NULL);
-		hashtab_destroy(comdatum->permissions.table);
-	}
-	kfree(datum);
-	return 0;
-}
-
-static void constraint_expr_destroy(struct constraint_expr *expr)
-{
-	if (expr) {
-		ebitmap_destroy(&expr->names);
-		if (expr->type_names) {
-			ebitmap_destroy(&expr->type_names->types);
-			ebitmap_destroy(&expr->type_names->negset);
-			kfree(expr->type_names);
-		}
-		kfree(expr);
-	}
-}
-
-static int cls_destroy(void *key, void *datum, void *p)
-{
-	struct class_datum *cladatum;
-	struct constraint_node *constraint, *ctemp;
-	struct constraint_expr *e, *etmp;
-
-	kfree(key);
-	if (datum) {
-		cladatum = datum;
-		hashtab_map(cladatum->permissions.table, perm_destroy, NULL);
-		hashtab_destroy(cladatum->permissions.table);
-		constraint = cladatum->constraints;
-		while (constraint) {
-			e = constraint->expr;
-			while (e) {
-				etmp = e;
-				e = e->next;
-				constraint_expr_destroy(etmp);
-			}
-			ctemp = constraint;
-			constraint = constraint->next;
-			kfree(ctemp);
-		}
-
-		constraint = cladatum->validatetrans;
-		while (constraint) {
-			e = constraint->expr;
-			while (e) {
-				etmp = e;
-				e = e->next;
-				constraint_expr_destroy(etmp);
-			}
-			ctemp = constraint;
-			constraint = constraint->next;
-			kfree(ctemp);
-		}
-		kfree(cladatum->comkey);
-	}
-	kfree(datum);
-	return 0;
-}
-
-static int role_destroy(void *key, void *datum, void *p)
-{
-	struct role_datum *role;
-
-	kfree(key);
-	if (datum) {
-		role = datum;
-		ebitmap_destroy(&role->dominates);
-		ebitmap_destroy(&role->types);
-	}
-	kfree(datum);
-	return 0;
-}
-
-static int type_destroy(void *key, void *datum, void *p)
-{
-	kfree(key);
-	kfree(datum);
-	return 0;
-}
-
-static int user_destroy(void *key, void *datum, void *p)
-{
-	struct user_datum *usrdatum;
-
-	kfree(key);
-	if (datum) {
-		usrdatum = datum;
-		ebitmap_destroy(&usrdatum->roles);
-		ebitmap_destroy(&usrdatum->range.level[0].cat);
-		ebitmap_destroy(&usrdatum->range.level[1].cat);
-		ebitmap_destroy(&usrdatum->dfltlevel.cat);
-	}
-	kfree(datum);
-	return 0;
-}
-
-static int sens_destroy(void *key, void *datum, void *p)
-{
-	struct level_datum *levdatum;
-
-	kfree(key);
-	if (datum) {
-		levdatum = datum;
-		if (levdatum->level)
-			ebitmap_destroy(&levdatum->level->cat);
-		kfree(levdatum->level);
-	}
-	kfree(datum);
-	return 0;
-}
-
-static int cat_destroy(void *key, void *datum, void *p)
-{
-	kfree(key);
-	kfree(datum);
-	return 0;
-}
-
-static int (*destroy_f[SYM_NUM]) (void *key, void *datum, void *datap) =
-{
-	common_destroy,
-	cls_destroy,
-	role_destroy,
-	type_destroy,
-	user_destroy,
-	cond_destroy_bool,
-	sens_destroy,
-	cat_destroy,
-};
-
-static int filenametr_destroy(void *key, void *datum, void *p)
-{
-	struct filename_trans *ft = key;
-	kfree(ft->name);
-	kfree(key);
-	kfree(datum);
-	cond_resched();
-	return 0;
-}
-
-static int range_tr_destroy(void *key, void *datum, void *p)
-{
-	struct mls_range *rt = datum;
-	kfree(key);
-	ebitmap_destroy(&rt->level[0].cat);
-	ebitmap_destroy(&rt->level[1].cat);
-	kfree(datum);
-	cond_resched();
-	return 0;
-}
-
-static void ocontext_destroy(struct ocontext *c, int i)
-{
-	if (!c)
-		return;
-
-	context_destroy(&c->context[0]);
-	context_destroy(&c->context[1]);
-	if (i == OCON_ISID || i == OCON_FS ||
-	    i == OCON_NETIF || i == OCON_FSUSE)
-		kfree(c->u.name);
-	kfree(c);
-}
-
 /*
  * Free any memory allocated by a policy database structure.
  */

