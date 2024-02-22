Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AD9013BAF8
	for <selinux@vger.kernel.org>; Thu, 22 Feb 2024 23:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708646392; cv=none; b=YxcIKqCHv26mKtYMlZr9wiPABMQiS22qnR+lWkIl2SVgh6qcctk2NUTiXqu+e0afJ+3M2umOHaKlx6nq7sIIT2Q2UnF3o1dirDJAWu09XZb3dRsm8Kb4OdN4CaFqaZwA6VLNESHn+PgWy1GIWS0R49Y67UgMSBXDLtHCEH76PvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708646392; c=relaxed/simple;
	bh=KVOJ2d5yMD1LckI9XHc1d96h3qdrm880a+mK2/nkhEw=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qMLrwksvAuGacHJv5lvqAS9zAzO36Z8nv+kV7XSq69SKOdMlLkWYm2WuQLzIgLETmvD0HTmpQHEBLm1hIkHzJzkve8L+uP5JU0OKn3FXVhZ1rkR+5q3ydvJLZwf4n0Bk2jhgKV6ZFR9G9zf8a/jxeQhKGgPfztUBpEdjY8qkUcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=E+/nNU64; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="E+/nNU64"
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-787ad74786aso10188685a.1
        for <selinux@vger.kernel.org>; Thu, 22 Feb 2024 15:59:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1708646389; x=1709251189; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zFR6ATjvVTG15zONhsoJKLKIqUHlp7tQ91fN7ZEQQUk=;
        b=E+/nNU64FTEqvuAz6L7n4YicmX1gXUaa638PRVXdKWXNdx+ar56j1kAlAizinp+MXq
         lYNIPpwAFDvVy57MWt3Z0Ad6QFv2lnnfAcrhqHMmmxo3l8wus2QaeGhldK+g+kjbp1ho
         CwTcuJxxGBWkVohKuLegiJM20kgDJkHICjJJXwrv/27zdgHux+SBE8nagJkAQcoPxxjl
         cCgiQS76MILAflrQSEDBwM9GxioQ7HrYV0BkfFfzzP9ZBdDAXIkfKMNCreXYrchT7Hbv
         auh7CYNasfrrRtJtPMTdvVNbwuLc2VPhVN7A8qBxzzN2SOC1RTclcaZRjfXMZ7h1wnea
         90Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708646389; x=1709251189;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zFR6ATjvVTG15zONhsoJKLKIqUHlp7tQ91fN7ZEQQUk=;
        b=OiM6Bj1QwxK1Z8sb5J83hySMW+JBDTrMBsFGdxNGkxC3Z9sXR2mmJhVaPuc63EyZCg
         U/bHoyq+bXvC7YLBEEeuhtZORSyhVXi3H4RSRvSBV4o7JP7/xsmTT3LMgpFu+0xzAzpJ
         4GMQCm+XBEW3KbYINwTymSnlP/cQ8RNOS4FJB06arIS3nPsQY4aUXYonABdXe4zbmWLE
         fwAFDAUCB8kIBGXhBLvsoiFDphWqa1FagHo7LN2UmppAEplRgkhkFcAUMNjz29T1HbZM
         hkdKm9BvGVEOkWIzo8CwLg1BtEBSZZSPxMC1MhbgI4KZMW/6aGD21kF4uZuiPg37oq7b
         Aqsw==
X-Gm-Message-State: AOJu0YyWKE8cGJhaUUNOGyu6Fs0zg7ROjijXOtp5aCXGPz3Viaqa/WvL
	FE00/rQOwCAEodqb5qkaY806RaHo8/J+3Y/XhB/4IzrgZcTAFQa0rcinmR5VNlHpJDe0VH7C9Dw
	=
X-Google-Smtp-Source: AGHT+IFrbiJl6EJriji01s6ucIOY9gAIkz2UtJt0az6qBHvTgzoXMs7d7bORWN9+wlpnyIj+tdYY8w==
X-Received: by 2002:a0c:f588:0:b0:68f:709d:a47f with SMTP id k8-20020a0cf588000000b0068f709da47fmr597601qvm.47.1708646388505;
        Thu, 22 Feb 2024 15:59:48 -0800 (PST)
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with ESMTPSA id op23-20020a056214459700b0068fcfef2077sm422236qvb.93.2024.02.22.15.59.47
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Feb 2024 15:59:48 -0800 (PST)
From: Paul Moore <paul@paul-moore.com>
To: selinux@vger.kernel.org
Subject: [PATCH 16/21] selinux: fix style issues in security/selinux/ss/policydb.c
Date: Thu, 22 Feb 2024 18:52:34 -0500
Message-ID: <20240222235708.386652-39-paul@paul-moore.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240222235708.386652-23-paul@paul-moore.com>
References: <20240222235708.386652-23-paul@paul-moore.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=33618; i=paul@paul-moore.com; h=from:subject; bh=KVOJ2d5yMD1LckI9XHc1d96h3qdrm880a+mK2/nkhEw=; b=owEBbQKS/ZANAwAIAeog8tqXN4lzAcsmYgBl19+2Kk2AwTt09nIfgaeMNjV2Yg5Wb8pu2UeH5 J9kXRdyeh6JAjMEAAEIAB0WIQRLQqjPB/KZ1VSXfu/qIPLalzeJcwUCZdfftgAKCRDqIPLalzeJ c/cFD/90WdYat6y4j50riF9qNCfuy80SMGh1VlHcHR4OJdZS2p4GUGSIt1cc/cmYeFsbKF5usmr ZDMrTn8gvwtl2PqdRcVRiS+CWbWlst+NU9aQXvQzr4GNcPs4cAbawa4YD6ID8jCjlQtVJ6/iUsr 6+XpETOJJJD3y1PXcEgBlF5QLDTpwhc9OOGAKqRuSPO2DylKFjtAvQ+t+AuXrG3QKP1ZoGmZJzl nJ0RgQg8HjNM6Va/5eEKwo1fl/DMjhq4eHbFPDcrnD/p5V31OCv8D3qtsSosImaXeATE34DEQwh Ha1EPelRMwaDUD7TrFWcqhwm9XQHsfBIGeiKeM6VeteUpLE7OdUJwHAtJslfLpBUzddqBHGNec0 q4z8F+t+n/T7la4dwDmYJU7KtndeAvlG2lRToqYRJQXV6cK0dDSHE/SnyqczhrBrPvjJwg/+vPc 3bScxaQZ1HrLHdriSNsOHWTYvgtSmV/pu7fpFNzoDmCQo1xaCPzMDCL9S0RCbwnk31cRGx+paBC m5qJwcb2y8CiKQDb4KjqYhuelQCH/MgRCZb9/9TKESfBHtBf721WvAQ4LcRr8jLuzaN0XmbzMuy FfDYMFlwRsVy/84TVB9/DlzUqoXAPK5fV76ov/EbjCSxpPFk5TOy+ycSC2VBuW1qxo1fvfpdJEY Syojh0fDe3PGtOg==
X-Developer-Key: i=paul@paul-moore.com; a=openpgp; fpr=7100AADFAE6E6E940D2E0AD655E45A5AE8CA7C8A
Content-Transfer-Encoding: 8bit

As part of on ongoing effort to perform more automated testing and
provide more tools for individual developers to validate their
patches before submitting, we are trying to make our code
"clang-format clean".  My hope is that once we have fixed all of our
style "quirks", developers will be able to run clang-format on their
patches to help avoid silly formatting problems and ensure their
changes fit in well with the rest of the SELinux kernel code.

Signed-off-by: Paul Moore <paul@paul-moore.com>
---
 security/selinux/ss/policydb.c | 405 +++++++++++++++++----------------
 1 file changed, 213 insertions(+), 192 deletions(-)

diff --git a/security/selinux/ss/policydb.c b/security/selinux/ss/policydb.c
index 3b19ad28c922..3d22d5baa829 100644
--- a/security/selinux/ss/policydb.c
+++ b/security/selinux/ss/policydb.c
@@ -7,25 +7,21 @@
 
 /*
  * Updated: Trusted Computer Solutions, Inc. <dgoeddel@trustedcs.com>
+ *          Support for enhanced MLS infrastructure.
+ *          Copyright (C) 2004-2005 Trusted Computer Solutions, Inc.
  *
- *	Support for enhanced MLS infrastructure.
- *
- * Updated: Frank Mayer <mayerf@tresys.com> and Karl MacMillan <kmacmillan@tresys.com>
- *
- *	Added conditional policy language extensions
+ * Updated: Frank Mayer <mayerf@tresys.com> and
+ *          Karl MacMillan <kmacmillan@tresys.com>
+ *          Added conditional policy language extensions
+ *          Copyright (C) 2003-2004 Tresys Technology, LLC
  *
  * Updated: Hewlett-Packard <paul@paul-moore.com>
- *
- *      Added support for the policy capability bitmap
+ *          Added support for the policy capability bitmap
+ *          Copyright (C) 2007 Hewlett-Packard Development Company, L.P.
  *
  * Update: Mellanox Techonologies
- *
- *	Added Infiniband support
- *
- * Copyright (C) 2016 Mellanox Techonologies
- * Copyright (C) 2007 Hewlett-Packard Development Company, L.P.
- * Copyright (C) 2004-2005 Trusted Computer Solutions, Inc.
- * Copyright (C) 2003 - 2004 Tresys Technology, LLC
+ *         Added Infiniband support
+ *         Copyright (C) 2016 Mellanox Techonologies
  */
 
 #include <linux/kernel.h>
@@ -42,6 +38,7 @@
 #include "services.h"
 
 #ifdef CONFIG_SECURITY_SELINUX_DEBUG
+/* clang-format off */
 static const char *const symtab_name[SYM_NUM] = {
 	"common prefixes",
 	"classes",
@@ -52,6 +49,7 @@ static const char *const symtab_name[SYM_NUM] = {
 	"levels",
 	"categories",
 };
+/* clang-format off */
 #endif
 
 struct policydb_compat_info {
@@ -63,103 +61,104 @@ struct policydb_compat_info {
 /* These need to be updated if SYM_NUM or OCON_NUM changes */
 static const struct policydb_compat_info policydb_compat[] = {
 	{
-		.version	= POLICYDB_VERSION_BASE,
-		.sym_num	= SYM_NUM - 3,
-		.ocon_num	= OCON_NUM - 3,
+		.version = POLICYDB_VERSION_BASE,
+		.sym_num = SYM_NUM - 3,
+		.ocon_num = OCON_NUM - 3,
 	},
 	{
-		.version	= POLICYDB_VERSION_BOOL,
-		.sym_num	= SYM_NUM - 2,
-		.ocon_num	= OCON_NUM - 3,
+		.version = POLICYDB_VERSION_BOOL,
+		.sym_num = SYM_NUM - 2,
+		.ocon_num = OCON_NUM - 3,
 	},
 	{
-		.version	= POLICYDB_VERSION_IPV6,
-		.sym_num	= SYM_NUM - 2,
-		.ocon_num	= OCON_NUM - 2,
+		.version = POLICYDB_VERSION_IPV6,
+		.sym_num = SYM_NUM - 2,
+		.ocon_num = OCON_NUM - 2,
 	},
 	{
-		.version	= POLICYDB_VERSION_NLCLASS,
-		.sym_num	= SYM_NUM - 2,
-		.ocon_num	= OCON_NUM - 2,
+		.version = POLICYDB_VERSION_NLCLASS,
+		.sym_num = SYM_NUM - 2,
+		.ocon_num = OCON_NUM - 2,
 	},
 	{
-		.version	= POLICYDB_VERSION_MLS,
-		.sym_num	= SYM_NUM,
-		.ocon_num	= OCON_NUM - 2,
+		.version = POLICYDB_VERSION_MLS,
+		.sym_num = SYM_NUM,
+		.ocon_num = OCON_NUM - 2,
 	},
 	{
-		.version	= POLICYDB_VERSION_AVTAB,
-		.sym_num	= SYM_NUM,
-		.ocon_num	= OCON_NUM - 2,
+		.version = POLICYDB_VERSION_AVTAB,
+		.sym_num = SYM_NUM,
+		.ocon_num = OCON_NUM - 2,
 	},
 	{
-		.version	= POLICYDB_VERSION_RANGETRANS,
-		.sym_num	= SYM_NUM,
-		.ocon_num	= OCON_NUM - 2,
+		.version = POLICYDB_VERSION_RANGETRANS,
+		.sym_num = SYM_NUM,
+		.ocon_num = OCON_NUM - 2,
 	},
 	{
-		.version	= POLICYDB_VERSION_POLCAP,
-		.sym_num	= SYM_NUM,
-		.ocon_num	= OCON_NUM - 2,
+		.version = POLICYDB_VERSION_POLCAP,
+		.sym_num = SYM_NUM,
+		.ocon_num = OCON_NUM - 2,
 	},
 	{
-		.version	= POLICYDB_VERSION_PERMISSIVE,
-		.sym_num	= SYM_NUM,
-		.ocon_num	= OCON_NUM - 2,
+		.version = POLICYDB_VERSION_PERMISSIVE,
+		.sym_num = SYM_NUM,
+		.ocon_num = OCON_NUM - 2,
 	},
 	{
-		.version	= POLICYDB_VERSION_BOUNDARY,
-		.sym_num	= SYM_NUM,
-		.ocon_num	= OCON_NUM - 2,
+		.version = POLICYDB_VERSION_BOUNDARY,
+		.sym_num = SYM_NUM,
+		.ocon_num = OCON_NUM - 2,
 	},
 	{
-		.version	= POLICYDB_VERSION_FILENAME_TRANS,
-		.sym_num	= SYM_NUM,
-		.ocon_num	= OCON_NUM - 2,
+		.version = POLICYDB_VERSION_FILENAME_TRANS,
+		.sym_num = SYM_NUM,
+		.ocon_num = OCON_NUM - 2,
 	},
 	{
-		.version	= POLICYDB_VERSION_ROLETRANS,
-		.sym_num	= SYM_NUM,
-		.ocon_num	= OCON_NUM - 2,
+		.version = POLICYDB_VERSION_ROLETRANS,
+		.sym_num = SYM_NUM,
+		.ocon_num = OCON_NUM - 2,
 	},
 	{
-		.version	= POLICYDB_VERSION_NEW_OBJECT_DEFAULTS,
-		.sym_num	= SYM_NUM,
-		.ocon_num	= OCON_NUM - 2,
+		.version = POLICYDB_VERSION_NEW_OBJECT_DEFAULTS,
+		.sym_num = SYM_NUM,
+		.ocon_num = OCON_NUM - 2,
 	},
 	{
-		.version	= POLICYDB_VERSION_DEFAULT_TYPE,
-		.sym_num	= SYM_NUM,
-		.ocon_num	= OCON_NUM - 2,
+		.version = POLICYDB_VERSION_DEFAULT_TYPE,
+		.sym_num = SYM_NUM,
+		.ocon_num = OCON_NUM - 2,
 	},
 	{
-		.version	= POLICYDB_VERSION_CONSTRAINT_NAMES,
-		.sym_num	= SYM_NUM,
-		.ocon_num	= OCON_NUM - 2,
+		.version = POLICYDB_VERSION_CONSTRAINT_NAMES,
+		.sym_num = SYM_NUM,
+		.ocon_num = OCON_NUM - 2,
 	},
 	{
-		.version	= POLICYDB_VERSION_XPERMS_IOCTL,
-		.sym_num	= SYM_NUM,
-		.ocon_num	= OCON_NUM - 2,
+		.version = POLICYDB_VERSION_XPERMS_IOCTL,
+		.sym_num = SYM_NUM,
+		.ocon_num = OCON_NUM - 2,
 	},
 	{
-		.version	= POLICYDB_VERSION_INFINIBAND,
-		.sym_num	= SYM_NUM,
-		.ocon_num	= OCON_NUM,
+		.version = POLICYDB_VERSION_INFINIBAND,
+		.sym_num = SYM_NUM,
+		.ocon_num = OCON_NUM,
 	},
 	{
-		.version	= POLICYDB_VERSION_GLBLUB,
-		.sym_num	= SYM_NUM,
-		.ocon_num	= OCON_NUM,
+		.version = POLICYDB_VERSION_GLBLUB,
+		.sym_num = SYM_NUM,
+		.ocon_num = OCON_NUM,
 	},
 	{
-		.version	= POLICYDB_VERSION_COMP_FTRANS,
-		.sym_num	= SYM_NUM,
-		.ocon_num	= OCON_NUM,
+		.version = POLICYDB_VERSION_COMP_FTRANS,
+		.sym_num = SYM_NUM,
+		.ocon_num = OCON_NUM,
 	},
 };
 
-static const struct policydb_compat_info *policydb_lookup_compat(unsigned int version)
+static const struct policydb_compat_info *
+policydb_lookup_compat(unsigned int version)
 {
 	unsigned int i;
 
@@ -312,7 +311,8 @@ static int cat_destroy(void *key, void *datum, void *p)
 	return 0;
 }
 
-static int (*const destroy_f[SYM_NUM]) (void *key, void *datum, void *datap) = {
+/* clang-format off */
+static int (*const destroy_f[SYM_NUM])(void *key, void *datum, void *datap) = {
 	common_destroy,
 	cls_destroy,
 	role_destroy,
@@ -322,6 +322,7 @@ static int (*const destroy_f[SYM_NUM]) (void *key, void *datum, void *datap) = {
 	sens_destroy,
 	cat_destroy,
 };
+/* clang-format on */
 
 static int filenametr_destroy(void *key, void *datum, void *p)
 {
@@ -366,8 +367,8 @@ static void ocontext_destroy(struct ocontext *c, unsigned int i)
 
 	context_destroy(&c->context[0]);
 	context_destroy(&c->context[1]);
-	if (i == OCON_ISID || i == OCON_FS ||
-	    i == OCON_NETIF || i == OCON_FSUSE)
+	if (i == OCON_ISID || i == OCON_FS || i == OCON_NETIF ||
+	    i == OCON_FSUSE)
 		kfree(c->u.name);
 	kfree(c);
 }
@@ -429,7 +430,6 @@ static int filenametr_cmp(const void *k1, const void *k2)
 		return v;
 
 	return strcmp(ft1->name, ft2->name);
-
 }
 
 static const struct hashtab_key_params filenametr_key_params = {
@@ -437,8 +437,8 @@ static const struct hashtab_key_params filenametr_key_params = {
 	.cmp = filenametr_cmp,
 };
 
-struct filename_trans_datum *policydb_filenametr_search(
-	struct policydb *p, struct filename_trans_key *key)
+struct filename_trans_datum *
+policydb_filenametr_search(struct policydb *p, struct filename_trans_key *key)
 {
 	return hashtab_search(&p->filename_trans, key, filenametr_key_params);
 }
@@ -448,7 +448,7 @@ static u32 rangetr_hash(const void *k)
 	const struct range_trans *key = k;
 
 	return key->source_type + (key->target_type << 3) +
-		(key->target_class << 5);
+	       (key->target_class << 5);
 }
 
 static int rangetr_cmp(const void *k1, const void *k2)
@@ -484,7 +484,8 @@ static u32 role_trans_hash(const void *k)
 {
 	const struct role_trans_key *key = k;
 
-	return jhash_3words(key->role, key->type, (u32)key->tclass << 16 | key->tclass, 0);
+	return jhash_3words(key->role, key->type,
+			    (u32)key->tclass << 16 | key->tclass, 0);
 }
 
 static int role_trans_cmp(const void *k1, const void *k2)
@@ -576,9 +577,8 @@ static int role_index(void *key, void *datum, void *datap)
 
 	role = datum;
 	p = datap;
-	if (!role->value
-	    || role->value > p->p_roles.nprim
-	    || role->bounds > p->p_roles.nprim)
+	if (!role->value || role->value > p->p_roles.nprim ||
+	    role->bounds > p->p_roles.nprim)
 		return -EINVAL;
 
 	p->sym_val_to_name[SYM_ROLES][role->value - 1] = key;
@@ -595,9 +595,8 @@ static int type_index(void *key, void *datum, void *datap)
 	p = datap;
 
 	if (typdatum->primary) {
-		if (!typdatum->value
-		    || typdatum->value > p->p_types.nprim
-		    || typdatum->bounds > p->p_types.nprim)
+		if (!typdatum->value || typdatum->value > p->p_types.nprim ||
+		    typdatum->bounds > p->p_types.nprim)
 			return -EINVAL;
 		p->sym_val_to_name[SYM_TYPES][typdatum->value - 1] = key;
 		p->type_val_to_struct[typdatum->value - 1] = typdatum;
@@ -613,9 +612,8 @@ static int user_index(void *key, void *datum, void *datap)
 
 	usrdatum = datum;
 	p = datap;
-	if (!usrdatum->value
-	    || usrdatum->value > p->p_users.nprim
-	    || usrdatum->bounds > p->p_users.nprim)
+	if (!usrdatum->value || usrdatum->value > p->p_users.nprim ||
+	    usrdatum->bounds > p->p_users.nprim)
 		return -EINVAL;
 
 	p->sym_val_to_name[SYM_USERS][usrdatum->value - 1] = key;
@@ -660,7 +658,8 @@ static int cat_index(void *key, void *datum, void *datap)
 	return 0;
 }
 
-static int (*const index_f[SYM_NUM]) (void *key, void *datum, void *datap) = {
+/* clang-format off */
+static int (*const index_f[SYM_NUM])(void *key, void *datum, void *datap) = {
 	common_index,
 	class_index,
 	role_index,
@@ -670,6 +669,7 @@ static int (*const index_f[SYM_NUM]) (void *key, void *datum, void *datap) = {
 	sens_index,
 	cat_index,
 };
+/* clang-format on */
 
 #ifdef CONFIG_SECURITY_SELINUX_DEBUG
 static void hash_eval(struct hashtab *h, const char *hash_name)
@@ -677,9 +677,10 @@ static void hash_eval(struct hashtab *h, const char *hash_name)
 	struct hashtab_info info;
 
 	hashtab_stat(h, &info);
-	pr_debug("SELinux: %s:  %d entries and %d/%d buckets used, longest chain length %d, sum of chain length^2 %llu\n",
-		 hash_name, h->nel, info.slots_used, h->size,
-		 info.max_chain_len, info.chain2_len_sum);
+	pr_debug(
+		"SELinux: %s:  %d entries and %d/%d buckets used, longest chain length %d, sum of chain length^2 %llu\n",
+		hash_name, h->nel, info.slots_used, h->size, info.max_chain_len,
+		info.chain2_len_sum);
 }
 
 static void symtab_hash_eval(struct symtab *s)
@@ -710,16 +711,17 @@ static int policydb_index(struct policydb *p)
 	int i, rc;
 
 	if (p->mls_enabled)
-		pr_debug("SELinux:  %d users, %d roles, %d types, %d bools, %d sens, %d cats\n",
-			 p->p_users.nprim, p->p_roles.nprim, p->p_types.nprim,
-			 p->p_bools.nprim, p->p_levels.nprim, p->p_cats.nprim);
+		pr_debug(
+			"SELinux:  %d users, %d roles, %d types, %d bools, %d sens, %d cats\n",
+			p->p_users.nprim, p->p_roles.nprim, p->p_types.nprim,
+			p->p_bools.nprim, p->p_levels.nprim, p->p_cats.nprim);
 	else
 		pr_debug("SELinux:  %d users, %d roles, %d types, %d bools\n",
 			 p->p_users.nprim, p->p_roles.nprim, p->p_types.nprim,
 			 p->p_bools.nprim);
 
-	pr_debug("SELinux:  %d classes, %d rules\n",
-		 p->p_classes.nprim, p->te_avtab.nel);
+	pr_debug("SELinux:  %d classes, %d rules\n", p->p_classes.nprim,
+		 p->te_avtab.nel);
 
 	avtab_hash_eval(&p->te_avtab, "rules");
 	symtab_hash_eval(p->symtab);
@@ -730,21 +732,18 @@ static int policydb_index(struct policydb *p)
 	if (!p->class_val_to_struct)
 		return -ENOMEM;
 
-	p->role_val_to_struct = kcalloc(p->p_roles.nprim,
-					sizeof(*p->role_val_to_struct),
-					GFP_KERNEL);
+	p->role_val_to_struct = kcalloc(
+		p->p_roles.nprim, sizeof(*p->role_val_to_struct), GFP_KERNEL);
 	if (!p->role_val_to_struct)
 		return -ENOMEM;
 
-	p->user_val_to_struct = kcalloc(p->p_users.nprim,
-					sizeof(*p->user_val_to_struct),
-					GFP_KERNEL);
+	p->user_val_to_struct = kcalloc(
+		p->p_users.nprim, sizeof(*p->user_val_to_struct), GFP_KERNEL);
 	if (!p->user_val_to_struct)
 		return -ENOMEM;
 
-	p->type_val_to_struct = kvcalloc(p->p_types.nprim,
-					 sizeof(*p->type_val_to_struct),
-					 GFP_KERNEL);
+	p->type_val_to_struct = kvcalloc(
+		p->p_types.nprim, sizeof(*p->type_val_to_struct), GFP_KERNEL);
 	if (!p->type_val_to_struct)
 		return -ENOMEM;
 
@@ -754,8 +753,7 @@ static int policydb_index(struct policydb *p)
 
 	for (i = 0; i < SYM_NUM; i++) {
 		p->sym_val_to_name[i] = kvcalloc(p->symtab[i].nprim,
-						 sizeof(char *),
-						 GFP_KERNEL);
+						 sizeof(char *), GFP_KERNEL);
 		if (!p->sym_val_to_name[i])
 			return -ENOMEM;
 
@@ -857,8 +855,7 @@ void policydb_destroy(struct policydb *p)
 int policydb_load_isids(struct policydb *p, struct sidtab *s)
 {
 	struct ocontext *head, *c;
-	bool isid_init_supported = ebitmap_get_bit(&p->policycaps,
-						   POLICYDB_CAP_USERSPACE_INITIAL_CONTEXT);
+	bool isid_init;
 	int rc;
 
 	rc = sidtab_init(s);
@@ -867,6 +864,9 @@ int policydb_load_isids(struct policydb *p, struct sidtab *s)
 		return rc;
 	}
 
+	isid_init = ebitmap_get_bit(&p->policycaps,
+				    POLICYDB_CAP_USERSPACE_INITIAL_CONTEXT);
+
 	head = p->ocontexts[OCON_ISID];
 	for (c = head; c; c = c->next) {
 		u32 sid = c->sid[0];
@@ -886,7 +886,7 @@ int policydb_load_isids(struct policydb *p, struct sidtab *s)
 		 * Also ignore SECINITSID_INIT if the policy doesn't declare
 		 * support for it
 		 */
-		if (sid == SECINITSID_INIT && !isid_init_supported)
+		if (sid == SECINITSID_INIT && !isid_init)
 			continue;
 
 		rc = sidtab_set_initial(s, sid, &c->context[0]);
@@ -905,8 +905,9 @@ int policydb_load_isids(struct policydb *p, struct sidtab *s)
 		 * started before policy load would initially get the context
 		 * corresponding to SECINITSID_KERNEL.
 		 */
-		if (sid == SECINITSID_KERNEL && !isid_init_supported) {
-			rc = sidtab_set_initial(s, SECINITSID_INIT, &c->context[0]);
+		if (sid == SECINITSID_KERNEL && !isid_init) {
+			rc = sidtab_set_initial(s, SECINITSID_INIT,
+						&c->context[0]);
 			if (rc) {
 				pr_err("SELinux:  unable to load initial SID %s.\n",
 				       name);
@@ -1047,8 +1048,7 @@ static int mls_read_range_helper(struct mls_range *r, void *fp)
  * Read and validate a security context structure
  * from a policydb binary representation file.
  */
-static int context_read_and_validate(struct context *c,
-				     struct policydb *p,
+static int context_read_and_validate(struct context *c, struct policydb *p,
 				     void *fp)
 {
 	__le32 buf[3];
@@ -1211,10 +1211,8 @@ static int type_set_read(struct type_set *t, void *fp)
 	return 0;
 }
 
-
-static int read_cons_helper(struct policydb *p,
-				struct constraint_node **nodep,
-				u32 ncons, int allowxtarget, void *fp)
+static int read_cons_helper(struct policydb *p, struct constraint_node **nodep,
+			    u32 ncons, int allowxtarget, void *fp)
 {
 	struct constraint_node *c, *lc;
 	struct constraint_expr *e, *le;
@@ -1284,8 +1282,9 @@ static int read_cons_helper(struct policydb *p,
 					return rc;
 				if (p->policyvers >=
 				    POLICYDB_VERSION_CONSTRAINT_NAMES) {
-					e->type_names = kzalloc(sizeof
-						(*e->type_names), GFP_KERNEL);
+					e->type_names =
+						kzalloc(sizeof(*e->type_names),
+							GFP_KERNEL);
 					if (!e->type_names)
 						return -ENOMEM;
 					type_set_init(e->type_names);
@@ -1319,7 +1318,7 @@ static int class_read(struct policydb *p, struct symtab *s, void *fp)
 	if (!cladatum)
 		return -ENOMEM;
 
-	rc = next_entry(buf, fp, sizeof(u32)*6);
+	rc = next_entry(buf, fp, sizeof(u32) * 6);
 	if (rc)
 		goto bad;
 
@@ -1345,8 +1344,8 @@ static int class_read(struct policydb *p, struct symtab *s, void *fp)
 			goto bad;
 
 		rc = -EINVAL;
-		cladatum->comdatum = symtab_search(&p->p_commons,
-						   cladatum->comkey);
+		cladatum->comdatum =
+			symtab_search(&p->p_commons, cladatum->comkey);
 		if (!cladatum->comdatum) {
 			pr_err("SELinux:  unknown common %s\n",
 			       cladatum->comkey);
@@ -1369,8 +1368,8 @@ static int class_read(struct policydb *p, struct symtab *s, void *fp)
 		if (rc)
 			goto bad;
 		ncons = le32_to_cpu(buf[0]);
-		rc = read_cons_helper(p, &cladatum->validatetrans,
-				ncons, 1, fp);
+		rc = read_cons_helper(p, &cladatum->validatetrans, ncons, 1,
+				      fp);
 		if (rc)
 			goto bad;
 	}
@@ -1507,7 +1506,6 @@ static int type_read(struct policydb *p, struct symtab *s, void *fp)
 	return rc;
 }
 
-
 /*
  * Read a MLS level structure from a policydb binary
  * representation file.
@@ -1659,8 +1657,9 @@ static int cat_read(struct policydb *p, struct symtab *s, void *fp)
 	return rc;
 }
 
-static int (*const read_f[SYM_NUM]) (struct policydb *p,
-				     struct symtab *s, void *fp) = {
+/* clang-format off */
+static int (*const read_f[SYM_NUM])(struct policydb *p, struct symtab *s,
+				    void *fp) = {
 	common_read,
 	class_read,
 	role_read,
@@ -1670,6 +1669,7 @@ static int (*const read_f[SYM_NUM]) (struct policydb *p,
 	sens_read,
 	cat_read,
 };
+/* clang-format on */
 
 static int user_bounds_sanity_check(void *key, void *datum, void *datap)
 {
@@ -1685,12 +1685,13 @@ static int user_bounds_sanity_check(void *key, void *datum, void *datap)
 		if (++depth == POLICYDB_BOUNDS_MAXDEPTH) {
 			pr_err("SELinux: user %s: "
 			       "too deep or looped boundary\n",
-			       (char *) key);
+			       (char *)key);
 			return -EINVAL;
 		}
 
 		upper = p->user_val_to_struct[upper->bounds - 1];
-		ebitmap_for_each_positive_bit(&user->roles, node, bit) {
+		ebitmap_for_each_positive_bit(&user->roles, node, bit)
+		{
 			if (ebitmap_get_bit(&upper->roles, bit))
 				continue;
 
@@ -1721,12 +1722,13 @@ static int role_bounds_sanity_check(void *key, void *datum, void *datap)
 		if (++depth == POLICYDB_BOUNDS_MAXDEPTH) {
 			pr_err("SELinux: role %s: "
 			       "too deep or looped bounds\n",
-			       (char *) key);
+			       (char *)key);
 			return -EINVAL;
 		}
 
 		upper = p->role_val_to_struct[upper->bounds - 1];
-		ebitmap_for_each_positive_bit(&role->types, node, bit) {
+		ebitmap_for_each_positive_bit(&role->types, node, bit)
+		{
 			if (ebitmap_get_bit(&upper->types, bit))
 				continue;
 
@@ -1754,7 +1756,7 @@ static int type_bounds_sanity_check(void *key, void *datum, void *datap)
 		if (++depth == POLICYDB_BOUNDS_MAXDEPTH) {
 			pr_err("SELinux: type %s: "
 			       "too deep or looped boundary\n",
-			       (char *) key);
+			       (char *)key);
 			return -EINVAL;
 		}
 
@@ -1764,7 +1766,7 @@ static int type_bounds_sanity_check(void *key, void *datum, void *datap)
 		if (upper->attribute) {
 			pr_err("SELinux: type %s: "
 			       "bounded by attribute %s\n",
-			       (char *) key,
+			       (char *)key,
 			       sym_name(p, SYM_TYPES, upper->value - 1));
 			return -EINVAL;
 		}
@@ -1815,7 +1817,7 @@ u32 string_to_av_perm(struct policydb *p, u16 tclass, const char *name)
 	if (!tclass || tclass > p->p_classes.nprim)
 		return 0;
 
-	cladatum = p->class_val_to_struct[tclass-1];
+	cladatum = p->class_val_to_struct[tclass - 1];
 	comdatum = cladatum->comdatum;
 	if (comdatum)
 		perdatum = symtab_search(&comdatum->permissions, name);
@@ -1824,7 +1826,7 @@ u32 string_to_av_perm(struct policydb *p, u16 tclass, const char *name)
 	if (!perdatum)
 		return 0;
 
-	return 1U << (perdatum->value-1);
+	return 1U << (perdatum->value - 1);
 }
 
 static int range_read(struct policydb *p, void *fp)
@@ -2192,12 +2194,12 @@ static int genfs_read(struct policydb *p, void *fp)
 				goto out;
 
 			newc->v.sclass = le32_to_cpu(buf[0]);
-			rc = context_read_and_validate(&newc->context[0], p, fp);
+			rc = context_read_and_validate(&newc->context[0], p,
+						       fp);
 			if (rc)
 				goto out;
 
-			for (l = NULL, c = genfs->head; c;
-			     l = c, c = c->next) {
+			for (l = NULL, c = genfs->head; c; l = c, c = c->next) {
 				rc = -EINVAL;
 				if (!strcmp(newc->u.name, c->u.name) &&
 				    (!c->v.sclass || !newc->v.sclass ||
@@ -2231,8 +2233,8 @@ static int genfs_read(struct policydb *p, void *fp)
 	return rc;
 }
 
-static int ocontext_read(struct policydb *p, const struct policydb_compat_info *info,
-			 void *fp)
+static int ocontext_read(struct policydb *p,
+			 const struct policydb_compat_info *info, void *fp)
 {
 	int rc;
 	unsigned int i;
@@ -2267,7 +2269,8 @@ static int ocontext_read(struct policydb *p, const struct policydb_compat_info *
 					goto out;
 
 				c->sid[0] = le32_to_cpu(buf[0]);
-				rc = context_read_and_validate(&c->context[0], p, fp);
+				rc = context_read_and_validate(&c->context[0],
+							       p, fp);
 				if (rc)
 					goto out;
 				break;
@@ -2286,21 +2289,24 @@ static int ocontext_read(struct policydb *p, const struct policydb_compat_info *
 					pr_warn("SELinux:  void and deprecated fs ocon %s\n",
 						c->u.name);
 
-				rc = context_read_and_validate(&c->context[0], p, fp);
+				rc = context_read_and_validate(&c->context[0],
+							       p, fp);
 				if (rc)
 					goto out;
-				rc = context_read_and_validate(&c->context[1], p, fp);
+				rc = context_read_and_validate(&c->context[1],
+							       p, fp);
 				if (rc)
 					goto out;
 				break;
 			case OCON_PORT:
-				rc = next_entry(buf, fp, sizeof(u32)*3);
+				rc = next_entry(buf, fp, sizeof(u32) * 3);
 				if (rc)
 					goto out;
 				c->u.port.protocol = le32_to_cpu(buf[0]);
 				c->u.port.low_port = le32_to_cpu(buf[1]);
 				c->u.port.high_port = le32_to_cpu(buf[2]);
-				rc = context_read_and_validate(&c->context[0], p, fp);
+				rc = context_read_and_validate(&c->context[0],
+							       p, fp);
 				if (rc)
 					goto out;
 				break;
@@ -2310,12 +2316,13 @@ static int ocontext_read(struct policydb *p, const struct policydb_compat_info *
 					goto out;
 				c->u.node.addr = nodebuf[0]; /* network order */
 				c->u.node.mask = nodebuf[1]; /* network order */
-				rc = context_read_and_validate(&c->context[0], p, fp);
+				rc = context_read_and_validate(&c->context[0],
+							       p, fp);
 				if (rc)
 					goto out;
 				break;
 			case OCON_FSUSE:
-				rc = next_entry(buf, fp, sizeof(u32)*2);
+				rc = next_entry(buf, fp, sizeof(u32) * 2);
 				if (rc)
 					goto out;
 
@@ -2332,7 +2339,8 @@ static int ocontext_read(struct policydb *p, const struct policydb_compat_info *
 				if (rc)
 					goto out;
 
-				rc = context_read_and_validate(&c->context[0], p, fp);
+				rc = context_read_and_validate(&c->context[0],
+							       p, fp);
 				if (rc)
 					goto out;
 				break;
@@ -2345,8 +2353,9 @@ static int ocontext_read(struct policydb *p, const struct policydb_compat_info *
 				for (k = 0; k < 4; k++)
 					c->u.node6.addr[k] = nodebuf[k];
 				for (k = 0; k < 4; k++)
-					c->u.node6.mask[k] = nodebuf[k+4];
-				rc = context_read_and_validate(&c->context[0], p, fp);
+					c->u.node6.mask[k] = nodebuf[k + 4];
+				rc = context_read_and_validate(&c->context[0],
+							       p, fp);
 				if (rc)
 					goto out;
 				break;
@@ -2359,7 +2368,8 @@ static int ocontext_read(struct policydb *p, const struct policydb_compat_info *
 					goto out;
 
 				/* we need to have subnet_prefix in CPU order */
-				c->u.ibpkey.subnet_prefix = be64_to_cpu(prefixbuf[0]);
+				c->u.ibpkey.subnet_prefix =
+					be64_to_cpu(prefixbuf[0]);
 
 				rc = next_entry(buf, fp, sizeof(u32) * 2);
 				if (rc)
@@ -2373,12 +2383,11 @@ static int ocontext_read(struct policydb *p, const struct policydb_compat_info *
 					goto out;
 				}
 
-				c->u.ibpkey.low_pkey  = pkey_lo;
+				c->u.ibpkey.low_pkey = pkey_lo;
 				c->u.ibpkey.high_pkey = pkey_hi;
 
 				rc = context_read_and_validate(&c->context[0],
-							       p,
-							       fp);
+							       p, fp);
 				if (rc)
 					goto out;
 				break;
@@ -2391,7 +2400,8 @@ static int ocontext_read(struct policydb *p, const struct policydb_compat_info *
 					goto out;
 				len = le32_to_cpu(buf[0]);
 
-				rc = str_read(&c->u.ibendport.dev_name, GFP_KERNEL, fp, len);
+				rc = str_read(&c->u.ibendport.dev_name,
+					      GFP_KERNEL, fp, len);
 				if (rc)
 					goto out;
 
@@ -2404,8 +2414,7 @@ static int ocontext_read(struct policydb *p, const struct policydb_compat_info *
 				c->u.ibendport.port = port;
 
 				rc = context_read_and_validate(&c->context[0],
-							       p,
-							       fp);
+							       p, fp);
 				if (rc)
 					goto out;
 				break;
@@ -2462,7 +2471,8 @@ int policydb_read(struct policydb *p, void *fp)
 	policydb_str = kmalloc(len + 1, GFP_KERNEL);
 	if (!policydb_str) {
 		pr_err("SELinux:  unable to allocate memory for policydb "
-		       "string of length %d\n", len);
+		       "string of length %d\n",
+		       len);
 		goto bad;
 	}
 
@@ -2477,7 +2487,8 @@ int policydb_read(struct policydb *p, void *fp)
 	policydb_str[len] = '\0';
 	if (strcmp(policydb_str, POLICYDB_STRING)) {
 		pr_err("SELinux:  policydb string %s does not match "
-		       "my string %s\n", policydb_str, POLICYDB_STRING);
+		       "my string %s\n",
+		       policydb_str, POLICYDB_STRING);
 		kfree(policydb_str);
 		goto bad;
 	}
@@ -2486,7 +2497,7 @@ int policydb_read(struct policydb *p, void *fp)
 	policydb_str = NULL;
 
 	/* Read the version and table sizes. */
-	rc = next_entry(buf, fp, sizeof(u32)*4);
+	rc = next_entry(buf, fp, sizeof(u32) * 4);
 	if (rc)
 		goto bad;
 
@@ -2496,7 +2507,8 @@ int policydb_read(struct policydb *p, void *fp)
 	    p->policyvers > POLICYDB_VERSION_MAX) {
 		pr_err("SELinux:  policydb version %d does not match "
 		       "my version range %d-%d\n",
-		       le32_to_cpu(buf[0]), POLICYDB_VERSION_MIN, POLICYDB_VERSION_MAX);
+		       le32_to_cpu(buf[0]), POLICYDB_VERSION_MIN,
+		       POLICYDB_VERSION_MAX);
 		goto bad;
 	}
 
@@ -2506,8 +2518,8 @@ int policydb_read(struct policydb *p, void *fp)
 		rc = -EINVAL;
 		if (p->policyvers < POLICYDB_VERSION_MLS) {
 			pr_err("SELinux: security policydb version %d "
-				"(MLS) not backwards compatible\n",
-				p->policyvers);
+			       "(MLS) not backwards compatible\n",
+			       p->policyvers);
 			goto bad;
 		}
 	}
@@ -2530,22 +2542,23 @@ int policydb_read(struct policydb *p, void *fp)
 	info = policydb_lookup_compat(p->policyvers);
 	if (!info) {
 		pr_err("SELinux:  unable to find policy compat info "
-		       "for version %d\n", p->policyvers);
+		       "for version %d\n",
+		       p->policyvers);
 		goto bad;
 	}
 
 	rc = -EINVAL;
 	if (le32_to_cpu(buf[2]) != info->sym_num ||
-		le32_to_cpu(buf[3]) != info->ocon_num) {
+	    le32_to_cpu(buf[3]) != info->ocon_num) {
 		pr_err("SELinux:  policydb table sizes (%d,%d) do "
-		       "not match mine (%d,%d)\n", le32_to_cpu(buf[2]),
-			le32_to_cpu(buf[3]),
-		       info->sym_num, info->ocon_num);
+		       "not match mine (%d,%d)\n",
+		       le32_to_cpu(buf[2]), le32_to_cpu(buf[3]), info->sym_num,
+		       info->ocon_num);
 		goto bad;
 	}
 
 	for (i = 0; i < info->sym_num; i++) {
-		rc = next_entry(buf, fp, sizeof(u32)*2);
+		rc = next_entry(buf, fp, sizeof(u32) * 2);
 		if (rc)
 			goto bad;
 		nprim = le32_to_cpu(buf[0]);
@@ -2606,7 +2619,7 @@ int policydb_read(struct policydb *p, void *fp)
 		if (!rtd)
 			goto bad;
 
-		rc = next_entry(buf, fp, sizeof(u32)*3);
+		rc = next_entry(buf, fp, sizeof(u32) * 3);
 		if (rc)
 			goto bad;
 
@@ -2650,7 +2663,7 @@ int policydb_read(struct policydb *p, void *fp)
 			lra->next = ra;
 		else
 			p->role_allow = ra;
-		rc = next_entry(buf, fp, sizeof(u32)*2);
+		rc = next_entry(buf, fp, sizeof(u32) * 2);
 		if (rc)
 			goto bad;
 
@@ -2698,9 +2711,8 @@ int policydb_read(struct policydb *p, void *fp)
 		goto bad;
 
 	rc = -ENOMEM;
-	p->type_attr_map_array = kvcalloc(p->p_types.nprim,
-					  sizeof(*p->type_attr_map_array),
-					  GFP_KERNEL);
+	p->type_attr_map_array = kvcalloc(
+		p->p_types.nprim, sizeof(*p->type_attr_map_array), GFP_KERNEL);
 	if (!p->type_attr_map_array)
 		goto bad;
 
@@ -2773,7 +2785,7 @@ static int mls_write_range_helper(struct mls_range *r, void *fp)
 		items = 2;
 	else
 		items = 3;
-	buf[0] = cpu_to_le32(items-1);
+	buf[0] = cpu_to_le32(items - 1);
 	buf[1] = cpu_to_le32(r->level[0].sens);
 	if (!eq)
 		buf[2] = cpu_to_le32(r->level[1].sens);
@@ -2916,8 +2928,7 @@ static int role_allow_write(struct role_allow *r, void *fp)
  * Write a security context structure
  * to a policydb binary representation file.
  */
-static int context_write(struct policydb *p, struct context *c,
-			 void *fp)
+static int context_write(struct policydb *p, struct context *c, void *fp)
 {
 	int rc;
 	__le32 buf[3];
@@ -3045,7 +3056,7 @@ static int write_cons_helper(struct policydb *p, struct constraint_node *node,
 				if (rc)
 					return rc;
 				if (p->policyvers >=
-					POLICYDB_VERSION_CONSTRAINT_NAMES) {
+				    POLICYDB_VERSION_CONSTRAINT_NAMES) {
 					rc = type_set_write(e->type_names, fp);
 					if (rc)
 						return rc;
@@ -3266,7 +3277,8 @@ static int user_write(void *vkey, void *datum, void *ptr)
 	return 0;
 }
 
-static int (*const write_f[SYM_NUM]) (void *key, void *datum, void *datap) = {
+/* clang-format off */
+static int (*const write_f[SYM_NUM])(void *key, void *datum, void *datap) = {
 	common_write,
 	class_write,
 	role_write,
@@ -3276,9 +3288,10 @@ static int (*const write_f[SYM_NUM]) (void *key, void *datum, void *datap) = {
 	sens_write,
 	cat_write,
 };
+/* clang-format on */
 
-static int ocontext_write(struct policydb *p, const struct policydb_compat_info *info,
-			  void *fp)
+static int ocontext_write(struct policydb *p,
+			  const struct policydb_compat_info *info, void *fp)
 {
 	unsigned int i, j;
 	int rc;
@@ -3360,9 +3373,13 @@ static int ocontext_write(struct policydb *p, const struct policydb_compat_info
 				break;
 			case OCON_NODE6:
 				for (j = 0; j < 4; j++)
-					nodebuf[j] = c->u.node6.addr[j]; /* network order */
+					nodebuf[j] =
+						c->u.node6.addr
+							[j]; /* network order */
 				for (j = 0; j < 4; j++)
-					nodebuf[j + 4] = c->u.node6.mask[j]; /* network order */
+					nodebuf[j + 4] =
+						c->u.node6.mask
+							[j]; /* network order */
 				rc = put_entry(nodebuf, sizeof(u32), 8, fp);
 				if (rc)
 					return rc;
@@ -3372,7 +3389,8 @@ static int ocontext_write(struct policydb *p, const struct policydb_compat_info
 				break;
 			case OCON_IBPKEY:
 				/* subnet_prefix is in CPU order */
-				prefixbuf[0] = cpu_to_be64(c->u.ibpkey.subnet_prefix);
+				prefixbuf[0] =
+					cpu_to_be64(c->u.ibpkey.subnet_prefix);
 
 				rc = put_entry(prefixbuf, sizeof(u64), 1, fp);
 				if (rc)
@@ -3395,7 +3413,8 @@ static int ocontext_write(struct policydb *p, const struct policydb_compat_info
 				rc = put_entry(buf, sizeof(u32), 2, fp);
 				if (rc)
 					return rc;
-				rc = put_entry(c->u.ibendport.dev_name, 1, len, fp);
+				rc = put_entry(c->u.ibendport.dev_name, 1, len,
+					       fp);
 				if (rc)
 					return rc;
 				rc = context_write(p, &c->context[0], fp);
@@ -3521,7 +3540,8 @@ static int filename_write_helper_compat(void *key, void *data, void *ptr)
 	u32 bit, len = strlen(ft->name);
 
 	do {
-		ebitmap_for_each_positive_bit(&datum->stypes, node, bit) {
+		ebitmap_for_each_positive_bit(&datum->stypes, node, bit)
+		{
 			buf[0] = cpu_to_le32(len);
 			rc = put_entry(buf, sizeof(u32), 1, fp);
 			if (rc)
@@ -3645,8 +3665,8 @@ int policydb_write(struct policydb *p, void *fp)
 	 */
 	if (p->policyvers < POLICYDB_VERSION_AVTAB) {
 		pr_err("SELinux: refusing to write policy version %d."
-		       "  Because it is less than version %d\n", p->policyvers,
-		       POLICYDB_VERSION_AVTAB);
+		       "  Because it is less than version %d\n",
+		       p->policyvers, POLICYDB_VERSION_AVTAB);
 		return -EINVAL;
 	}
 
@@ -3674,7 +3694,8 @@ int policydb_write(struct policydb *p, void *fp)
 	info = policydb_lookup_compat(p->policyvers);
 	if (!info) {
 		pr_err("SELinux: compatibility lookup failed for policy "
-		    "version %d\n", p->policyvers);
+		       "version %d\n",
+		       p->policyvers);
 		return -EINVAL;
 	}
 
-- 
2.43.2

