Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0AB6C4332F
	for <selinux@archiver.kernel.org>; Wed,  9 Nov 2022 04:00:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229985AbiKIEAo (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 8 Nov 2022 23:00:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229934AbiKIEAo (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 8 Nov 2022 23:00:44 -0500
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6AAC1AD91
        for <selinux@vger.kernel.org>; Tue,  8 Nov 2022 20:00:41 -0800 (PST)
Received: by mail-qt1-x834.google.com with SMTP id w4so9844483qts.0
        for <selinux@vger.kernel.org>; Tue, 08 Nov 2022 20:00:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=VaW57rkQrOVBj3tT4MZ2AmOjRG5PBKftxYpggV0FhhI=;
        b=251AT/3e0koK3Ur17mJmIKOh0j5qMHftc6q8rmGSRqy073RmEDEWRW4e5DcFAmqP4D
         9ac5d12VWAFXiEZ5245BThnInYiQfem2Kg+/vf3kWERAisnyPHjmOOGD1GxMqK3kLx0x
         SgOpQvzHE3+lmrIwGgekP4p2Hd0d+XMK/CKwxzxRDuUh8+iA1XIe3PdeKQC2QHxlDvZR
         mGyxl/LEONvuNfDybLFTTLvoslbnUPQXEBfDI3DsvJ4g7Ar0K6tEr2cvDESqIkhkuoNo
         l+8R8mOt4gJdc+1yBm/xOi7W84aBqlI3naCCabXiANo1YraklYKgbIGP5XUHtFb/sIIl
         8AAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VaW57rkQrOVBj3tT4MZ2AmOjRG5PBKftxYpggV0FhhI=;
        b=EqvPu4w/elSRurSQ72Ydb2JwxVt2Kgy31y+R4BLOb5WJKfnycRwsWt3ONsCa1zxEno
         WiglNsEFjtU8yOrO7ACkVECfzzexdYhvM2u0/yusNS9ThEdvqtuUyMfEoHuEfl/N2RKn
         Amt4VqPC8KZAEk1BRC7A0KQQ+4mc/fd3Zfkl65s+ry1ORgLnYHTgFJ8MvfpoYCnRVrUH
         LoI1sC2SRK+ZHV4maQQMsNV4VF2tnSxX+1XP1li5ZpHgXXkmlxHJak9RAqnOl4hxyQVY
         s5q3B2tmY3evwYgilomCL55DYwi9akvmT4hjGrzpScjXiydZlgX/byu3SuUieEngJDdu
         i30w==
X-Gm-Message-State: ACrzQf2K+2Ylj2dN4x9G5qIsq2xLqPTc2BCQV0BhzlHUVY/iW/lOu9nm
        aDIC3YTe8Q66XaoPo+jhhHJFyQOQKR0/
X-Google-Smtp-Source: AMsMyM4EwUcSG8a6hTfie2hB4kDv/ZhQYVyt6MDQl7ElWIq4yB/JaQKQ39pdukBum5iB/Y77QGY7Fg==
X-Received: by 2002:ac8:4b68:0:b0:3a5:2307:9ed0 with SMTP id g8-20020ac84b68000000b003a523079ed0mr41549350qts.465.1667966440359;
        Tue, 08 Nov 2022 20:00:40 -0800 (PST)
Received: from localhost (pool-108-26-161-203.bstnma.fios.verizon.net. [108.26.161.203])
        by smtp.gmail.com with ESMTPSA id fg26-20020a05622a581a00b00399b73d06f0sm9146789qtb.38.2022.11.08.20.00.39
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Nov 2022 20:00:40 -0800 (PST)
From:   Paul Moore <paul@paul-moore.com>
To:     selinux@vger.kernel.org
Subject: [PATCH] selinux: remove the sidtab context conversion indirect calls
Date:   Tue,  8 Nov 2022 23:00:39 -0500
Message-Id: <20221109040039.732341-1-paul@paul-moore.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

The sidtab conversion code has support for multiple context
conversion routines through the use of function pointers and
indirect calls.  However, the reality is that all current users rely
on the same conversion routine: convert_context().  This patch does
away with this extra complexity and replaces the indirect calls
with direct function calls; allowing us to remove a layer of
obfuscation and create cleaner, more maintainable code.

Signed-off-by: Paul Moore <paul@paul-moore.com>
---
 security/selinux/ss/services.c | 51 ++++++++++++++--------------------
 security/selinux/ss/services.h | 14 ++++++++--
 security/selinux/ss/sidtab.c   | 21 ++++++++------
 security/selinux/ss/sidtab.h   |  3 +-
 4 files changed, 45 insertions(+), 44 deletions(-)

diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
index fe5fcf571c564..e63c4f942fd6a 100644
--- a/security/selinux/ss/services.c
+++ b/security/selinux/ss/services.c
@@ -68,12 +68,6 @@
 #include "policycap_names.h"
 #include "ima.h"
 
-struct convert_context_args {
-	struct selinux_state *state;
-	struct policydb *oldp;
-	struct policydb *newp;
-};
-
 struct selinux_policy_convert_data {
 	struct convert_context_args args;
 	struct sidtab_convert_params sidtab_params;
@@ -2014,17 +2008,20 @@ static inline int convert_context_handle_invalid_context(
 	return 0;
 }
 
-/*
- * Convert the values in the security context
- * structure `oldc' from the values specified
- * in the policy `p->oldp' to the values specified
- * in the policy `p->newp', storing the new context
- * in `newc'.  Verify that the context is valid
- * under the new policy.
+/**
+ * services_convert_context - Convert a security context across policies.
+ * @args: populated convert_context_args struct
+ * @oldc: original context
+ * @newc: converted context
+ *
+ * Convert the values in the security context structure @oldc from the values
+ * specified in the policy @args->oldp to the values specified in the policy
+ * @args->newp, storing the new context in @newc, and verifying that the
+ * context is valid under the new policy.
  */
-static int convert_context(struct context *oldc, struct context *newc, void *p)
+int services_convert_context(struct convert_context_args *args,
+			     struct context *oldc, struct context *newc)
 {
-	struct convert_context_args *args;
 	struct ocontext *oc;
 	struct role_datum *role;
 	struct type_datum *typdatum;
@@ -2033,15 +2030,12 @@ static int convert_context(struct context *oldc, struct context *newc, void *p)
 	u32 len;
 	int rc;
 
-	args = p;
-
 	if (oldc->str) {
 		s = kstrdup(oldc->str, GFP_KERNEL);
 		if (!s)
 			return -ENOMEM;
 
-		rc = string_to_context_struct(args->newp, NULL, s,
-					      newc, SECSID_NULL);
+		rc = string_to_context_struct(args->newp, NULL, s, newc, SECSID_NULL);
 		if (rc == -EINVAL) {
 			/*
 			 * Retain string representation for later mapping.
@@ -2072,8 +2066,7 @@ static int convert_context(struct context *oldc, struct context *newc, void *p)
 
 	/* Convert the user. */
 	usrdatum = symtab_search(&args->newp->p_users,
-				 sym_name(args->oldp,
-					  SYM_USERS, oldc->user - 1));
+				 sym_name(args->oldp, SYM_USERS, oldc->user - 1));
 	if (!usrdatum)
 		goto bad;
 	newc->user = usrdatum->value;
@@ -2087,8 +2080,7 @@ static int convert_context(struct context *oldc, struct context *newc, void *p)
 
 	/* Convert the type. */
 	typdatum = symtab_search(&args->newp->p_types,
-				 sym_name(args->oldp,
-					  SYM_TYPES, oldc->type - 1));
+				 sym_name(args->oldp, SYM_TYPES, oldc->type - 1));
 	if (!typdatum)
 		goto bad;
 	newc->type = typdatum->value;
@@ -2122,8 +2114,7 @@ static int convert_context(struct context *oldc, struct context *newc, void *p)
 	/* Check the validity of the new context. */
 	if (!policydb_context_isvalid(args->newp, newc)) {
 		rc = convert_context_handle_invalid_context(args->state,
-							args->oldp,
-							oldc);
+							    args->oldp, oldc);
 		if (rc)
 			goto bad;
 	}
@@ -2332,21 +2323,21 @@ int security_load_policy(struct selinux_state *state, void *data, size_t len,
 		goto err_free_isids;
 	}
 
+	/*
+	 * Convert the internal representations of contexts
+	 * in the new SID table.
+	 */
+
 	convert_data = kmalloc(sizeof(*convert_data), GFP_KERNEL);
 	if (!convert_data) {
 		rc = -ENOMEM;
 		goto err_free_isids;
 	}
 
-	/*
-	 * Convert the internal representations of contexts
-	 * in the new SID table.
-	 */
 	convert_data->args.state = state;
 	convert_data->args.oldp = &oldpolicy->policydb;
 	convert_data->args.newp = &newpolicy->policydb;
 
-	convert_data->sidtab_params.func = convert_context;
 	convert_data->sidtab_params.args = &convert_data->args;
 	convert_data->sidtab_params.target = newpolicy->sidtab;
 
diff --git a/security/selinux/ss/services.h b/security/selinux/ss/services.h
index 9555ad074303c..6348c95ff0e52 100644
--- a/security/selinux/ss/services.h
+++ b/security/selinux/ss/services.h
@@ -29,10 +29,18 @@ struct selinux_policy {
 	u32 latest_granting;
 } __randomize_layout;
 
-void services_compute_xperms_drivers(struct extended_perms *xperms,
-				struct avtab_node *node);
+struct convert_context_args {
+	struct selinux_state *state;
+	struct policydb *oldp;
+	struct policydb *newp;
+};
 
+void services_compute_xperms_drivers(struct extended_perms *xperms,
+				     struct avtab_node *node);
 void services_compute_xperms_decision(struct extended_perms_decision *xpermd,
-					struct avtab_node *node);
+				      struct avtab_node *node);
+
+int services_convert_context(struct convert_context_args *args,
+			     struct context *oldc, struct context *newc);
 
 #endif	/* _SS_SERVICES_H_ */
diff --git a/security/selinux/ss/sidtab.c b/security/selinux/ss/sidtab.c
index a54b8652bfb50..1c3d2cda6b92a 100644
--- a/security/selinux/ss/sidtab.c
+++ b/security/selinux/ss/sidtab.c
@@ -18,6 +18,7 @@
 #include "flask.h"
 #include "security.h"
 #include "sidtab.h"
+#include "services.h"
 
 struct sidtab_str_cache {
 	struct rcu_head rcu_member;
@@ -292,7 +293,6 @@ int sidtab_context_to_sid(struct sidtab *s, struct context *context,
 	}
 
 	count = s->count;
-	convert = s->convert;
 
 	/* bail out if we already reached max entries */
 	rc = -EOVERFLOW;
@@ -316,25 +316,28 @@ int sidtab_context_to_sid(struct sidtab *s, struct context *context,
 	 * if we are building a new sidtab, we need to convert the context
 	 * and insert it there as well
 	 */
+	convert = s->convert;
 	if (convert) {
+		struct sidtab *target = convert->target;
+
 		rc = -ENOMEM;
-		dst_convert = sidtab_do_lookup(convert->target, count, 1);
+		dst_convert = sidtab_do_lookup(target, count, 1);
 		if (!dst_convert) {
 			context_destroy(&dst->context);
 			goto out_unlock;
 		}
 
-		rc = convert->func(context, &dst_convert->context,
-				   convert->args);
+		rc = services_convert_context(convert->args,
+					      context, &dst_convert->context);
 		if (rc) {
 			context_destroy(&dst->context);
 			goto out_unlock;
 		}
 		dst_convert->sid = index_to_sid(count);
 		dst_convert->hash = context_compute_hash(&dst_convert->context);
-		convert->target->count = count + 1;
+		target->count = count + 1;
 
-		hash_add_rcu(convert->target->context_to_sid,
+		hash_add_rcu(target->context_to_sid,
 			     &dst_convert->list, dst_convert->hash);
 	}
 
@@ -402,9 +405,9 @@ static int sidtab_convert_tree(union sidtab_entry_inner *edst,
 		}
 		i = 0;
 		while (i < SIDTAB_LEAF_ENTRIES && *pos < count) {
-			rc = convert->func(&esrc->ptr_leaf->entries[i].context,
-					   &edst->ptr_leaf->entries[i].context,
-					   convert->args);
+			rc = services_convert_context(convert->args,
+					&esrc->ptr_leaf->entries[i].context,
+					&edst->ptr_leaf->entries[i].context);
 			if (rc)
 				return rc;
 			(*pos)++;
diff --git a/security/selinux/ss/sidtab.h b/security/selinux/ss/sidtab.h
index 4eff0e49dcb22..72810a080e77b 100644
--- a/security/selinux/ss/sidtab.h
+++ b/security/selinux/ss/sidtab.h
@@ -65,8 +65,7 @@ struct sidtab_isid_entry {
 };
 
 struct sidtab_convert_params {
-	int (*func)(struct context *oldc, struct context *newc, void *args);
-	void *args;
+	struct convert_context_args *args;
 	struct sidtab *target;
 };
 
-- 
2.38.1

