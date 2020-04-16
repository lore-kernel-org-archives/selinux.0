Return-Path: <SRS0=3hV4=6A=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5444DC352BE
	for <selinux@archiver.kernel.org>; Thu, 16 Apr 2020 12:41:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2858E21D7E
	for <selinux@archiver.kernel.org>; Thu, 16 Apr 2020 12:41:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="J7xQWxb7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2635824AbgDPMlc (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 16 Apr 2020 08:41:32 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:47593 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2635936AbgDPMlZ (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 16 Apr 2020 08:41:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1587040880;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=P60Gahpgfw5dNlKHuhuzBou9E5M6glchSl9e0TaQ4G8=;
        b=J7xQWxb7ttaumoF1+Um6iYnEWbKH+JEwvSv+Sz/ALCJ2yq/Zh8b8aJM8u6g5Wges4wjbnO
        k7qUFA5YQvOKS5CKi7T9wfAJ+W3U8i4NGr02fnOPRQGV12R5waV6++Ju1CxZN9R3zOUIC/
        B6wRGUlgn/8fm07Q7MHd2z+2DxrC6C0=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-18-pXx2QLrePfur_0YWvD7uIA-1; Thu, 16 Apr 2020 08:41:19 -0400
X-MC-Unique: pXx2QLrePfur_0YWvD7uIA-1
Received: by mail-wm1-f71.google.com with SMTP id f17so1132119wmm.5
        for <selinux@vger.kernel.org>; Thu, 16 Apr 2020 05:41:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=P60Gahpgfw5dNlKHuhuzBou9E5M6glchSl9e0TaQ4G8=;
        b=VnqmpDV5/rmppVNGHCLLFLkbuNb29aQe1Saf4Zk8+b2lsTTAF8yXkUN6gcOQz9Gf6p
         S4ORL7bBLxfbkBq8nd6WLQ5QfRw/y4kUhSpocCC/fpgG1iS4oIlE4k+f1DBhB8/wMW5E
         vuko8OYR1DmzN5X+5UPC685Np6D2P+rvR2pgejHoSvXpZJrwoN7spE+8YSULtDX8v+26
         hNWLDSSLKXWvywibiuRMb+fB67Xyjt586H6rVWDd4MLNpjQcqI0EbeM8vbEso+nRXzUH
         laPh0MAAkUflF0ZwgL6D2iriap2h8g190hmV3GU+2HZgFzlAJ7vEa9V9cbdUJg1oGw01
         D0zA==
X-Gm-Message-State: AGi0PubbC+k8X+21pdr85Aif5/P0vPG1C765E/iRJOOESqEh4apEN+vS
        6keKmaXxezt3wE7rUDlYrFZ5kPGSFciMGNobqguS5kfWoPK2dJDtVk+YAuJjIBNGiIvWg5KJP6w
        QdB6ksxjQQO8FThcKDQ==
X-Received: by 2002:adf:f54c:: with SMTP id j12mr32681848wrp.183.1587040877564;
        Thu, 16 Apr 2020 05:41:17 -0700 (PDT)
X-Google-Smtp-Source: APiQypIEMIwECGrGEHpAS0T+kqz9VZfo7SsFTp5ZxvgDmQo4bvrLZahawr8lAxuv7jWhO1HwRelwig==
X-Received: by 2002:adf:f54c:: with SMTP id j12mr32681809wrp.183.1587040877044;
        Thu, 16 Apr 2020 05:41:17 -0700 (PDT)
Received: from omos.redhat.com ([2a02:8308:b13f:2100:f695:3ae5:c8bf:2f57])
        by smtp.gmail.com with ESMTPSA id w6sm24059333wrm.86.2020.04.16.05.41.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Apr 2020 05:41:15 -0700 (PDT)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     selinux@vger.kernel.org, Paul Moore <paul@paul-moore.com>
Cc:     Stephen Smalley <sds@tycho.nsa.gov>,
        Jeff Vander Stoep <jeffv@google.com>
Subject: [PATCH v2 2/2] selinux: move context hashing under sidtab
Date:   Thu, 16 Apr 2020 14:41:10 +0200
Message-Id: <20200416124110.541408-3-omosnace@redhat.com>
X-Mailer: git-send-email 2.25.2
In-Reply-To: <20200416124110.541408-1-omosnace@redhat.com>
References: <20200416124110.541408-1-omosnace@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Now that context hash computation no longer depends on policydb, we can
simplify things by moving the context hashing completely under sidtab.
The hash is still cached in sidtab entries, but not for the in-flight
context structures.

Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
---
 security/selinux/ss/context.h  | 11 +------
 security/selinux/ss/policydb.c |  2 --
 security/selinux/ss/services.c | 59 +++++++++++++++-------------------
 security/selinux/ss/sidtab.c   | 32 ++++++++++--------
 security/selinux/ss/sidtab.h   |  1 +
 5 files changed, 47 insertions(+), 58 deletions(-)

diff --git a/security/selinux/ss/context.h b/security/selinux/ss/context.h
index e7ae7e21449b..62990aa1ec9e 100644
--- a/security/selinux/ss/context.h
+++ b/security/selinux/ss/context.h
@@ -31,7 +31,6 @@ struct context {
 	u32 len;        /* length of string in bytes */
 	struct mls_range range;
 	char *str;	/* string representation if context cannot be mapped. */
-	u32 hash;	/* a hash of the string representation */
 };
 
 static inline void mls_context_init(struct context *c)
@@ -169,13 +168,12 @@ static inline int context_cpy(struct context *dst, struct context *src)
 		kfree(dst->str);
 		return rc;
 	}
-	dst->hash = src->hash;
 	return 0;
 }
 
 static inline void context_destroy(struct context *c)
 {
-	c->user = c->role = c->type = c->hash = 0;
+	c->user = c->role = c->type = 0;
 	kfree(c->str);
 	c->str = NULL;
 	c->len = 0;
@@ -184,8 +182,6 @@ static inline void context_destroy(struct context *c)
 
 static inline int context_cmp(struct context *c1, struct context *c2)
 {
-	if (c1->hash && c2->hash && (c1->hash != c2->hash))
-		return 0;
 	if (c1->len && c2->len)
 		return (c1->len == c2->len && !strcmp(c1->str, c2->str));
 	if (c1->len || c2->len)
@@ -198,10 +194,5 @@ static inline int context_cmp(struct context *c1, struct context *c2)
 
 u32 context_compute_hash(const struct context *c);
 
-static inline void context_add_hash(struct context *context)
-{
-	context->hash = context_compute_hash(context);
-}
-
 #endif	/* _SS_CONTEXT_H_ */
 
diff --git a/security/selinux/ss/policydb.c b/security/selinux/ss/policydb.c
index ac6c0a214fc5..f00f5851638f 100644
--- a/security/selinux/ss/policydb.c
+++ b/security/selinux/ss/policydb.c
@@ -836,8 +836,6 @@ int policydb_load_isids(struct policydb *p, struct sidtab *s)
 		if (!name)
 			continue;
 
-		context_add_hash(&c->context[0]);
-
 		rc = sidtab_set_initial(s, sid, &c->context[0]);
 		if (rc) {
 			pr_err("SELinux:  unable to load initial SID %s.\n",
diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
index e4ee6d5ed825..512cee09ee10 100644
--- a/security/selinux/ss/services.c
+++ b/security/selinux/ss/services.c
@@ -1490,17 +1490,6 @@ out:
 	return rc;
 }
 
-static int context_struct_to_sid(struct selinux_state *state,
-				 struct context *context, u32 *sid)
-{
-	struct sidtab *sidtab = state->ss->sidtab;
-
-	if (!context->hash)
-		context_add_hash(context);
-
-	return sidtab_context_to_sid(sidtab, context, sid);
-}
-
 static int security_context_to_sid_core(struct selinux_state *state,
 					const char *scontext, u32 scontext_len,
 					u32 *sid, u32 def_sid, gfp_t gfp_flags,
@@ -1555,7 +1544,7 @@ static int security_context_to_sid_core(struct selinux_state *state,
 		str = NULL;
 	} else if (rc)
 		goto out_unlock;
-	rc = context_struct_to_sid(state, &context, sid);
+	rc = sidtab_context_to_sid(sidtab, &context, sid);
 	context_destroy(&context);
 out_unlock:
 	read_unlock(&state->ss->policy_rwlock);
@@ -1866,7 +1855,7 @@ static int security_compute_sid(struct selinux_state *state,
 			goto out_unlock;
 	}
 	/* Obtain the sid for the context. */
-	rc = context_struct_to_sid(state, &newcontext, out_sid);
+	rc = sidtab_context_to_sid(sidtab, &newcontext, out_sid);
 out_unlock:
 	read_unlock(&state->ss->policy_rwlock);
 	context_destroy(&newcontext);
@@ -2018,7 +2007,6 @@ static int convert_context(struct context *oldc, struct context *newc, void *p)
 			context_init(newc);
 			newc->str = s;
 			newc->len = oldc->len;
-			newc->hash = oldc->hash;
 			return 0;
 		}
 		kfree(s);
@@ -2095,8 +2083,6 @@ static int convert_context(struct context *oldc, struct context *newc, void *p)
 			goto bad;
 	}
 
-	context_add_hash(newc);
-
 	return 0;
 bad:
 	/* Map old representation to string and save it. */
@@ -2106,7 +2092,6 @@ bad:
 	context_destroy(newc);
 	newc->str = s;
 	newc->len = len;
-	context_add_hash(newc);
 	pr_info("SELinux:  Context %s became invalid (unmapped).\n",
 		newc->str);
 	return 0;
@@ -2323,12 +2308,14 @@ int security_port_sid(struct selinux_state *state,
 		      u8 protocol, u16 port, u32 *out_sid)
 {
 	struct policydb *policydb;
+	struct sidtab *sidtab;
 	struct ocontext *c;
 	int rc = 0;
 
 	read_lock(&state->ss->policy_rwlock);
 
 	policydb = &state->ss->policydb;
+	sidtab = state->ss->sidtab;
 
 	c = policydb->ocontexts[OCON_PORT];
 	while (c) {
@@ -2341,7 +2328,7 @@ int security_port_sid(struct selinux_state *state,
 
 	if (c) {
 		if (!c->sid[0]) {
-			rc = context_struct_to_sid(state, &c->context[0],
+			rc = sidtab_context_to_sid(sidtab, &c->context[0],
 						   &c->sid[0]);
 			if (rc)
 				goto out;
@@ -2366,12 +2353,14 @@ int security_ib_pkey_sid(struct selinux_state *state,
 			 u64 subnet_prefix, u16 pkey_num, u32 *out_sid)
 {
 	struct policydb *policydb;
+	struct sidtab *sidtab;
 	struct ocontext *c;
 	int rc = 0;
 
 	read_lock(&state->ss->policy_rwlock);
 
 	policydb = &state->ss->policydb;
+	sidtab = state->ss->sidtab;
 
 	c = policydb->ocontexts[OCON_IBPKEY];
 	while (c) {
@@ -2385,7 +2374,7 @@ int security_ib_pkey_sid(struct selinux_state *state,
 
 	if (c) {
 		if (!c->sid[0]) {
-			rc = context_struct_to_sid(state,
+			rc = sidtab_context_to_sid(sidtab,
 						   &c->context[0],
 						   &c->sid[0]);
 			if (rc)
@@ -2410,12 +2399,14 @@ int security_ib_endport_sid(struct selinux_state *state,
 			    const char *dev_name, u8 port_num, u32 *out_sid)
 {
 	struct policydb *policydb;
+	struct sidtab *sidtab;
 	struct ocontext *c;
 	int rc = 0;
 
 	read_lock(&state->ss->policy_rwlock);
 
 	policydb = &state->ss->policydb;
+	sidtab = state->ss->sidtab;
 
 	c = policydb->ocontexts[OCON_IBENDPORT];
 	while (c) {
@@ -2430,7 +2421,7 @@ int security_ib_endport_sid(struct selinux_state *state,
 
 	if (c) {
 		if (!c->sid[0]) {
-			rc = context_struct_to_sid(state, &c->context[0],
+			rc = sidtab_context_to_sid(sidtab, &c->context[0],
 						   &c->sid[0]);
 			if (rc)
 				goto out;
@@ -2453,12 +2444,14 @@ int security_netif_sid(struct selinux_state *state,
 		       char *name, u32 *if_sid)
 {
 	struct policydb *policydb;
+	struct sidtab *sidtab;
 	int rc = 0;
 	struct ocontext *c;
 
 	read_lock(&state->ss->policy_rwlock);
 
 	policydb = &state->ss->policydb;
+	sidtab = state->ss->sidtab;
 
 	c = policydb->ocontexts[OCON_NETIF];
 	while (c) {
@@ -2469,11 +2462,11 @@ int security_netif_sid(struct selinux_state *state,
 
 	if (c) {
 		if (!c->sid[0] || !c->sid[1]) {
-			rc = context_struct_to_sid(state, &c->context[0],
+			rc = sidtab_context_to_sid(sidtab, &c->context[0],
 						   &c->sid[0]);
 			if (rc)
 				goto out;
-			rc = context_struct_to_sid(state, &c->context[1],
+			rc = sidtab_context_to_sid(sidtab, &c->context[1],
 						   &c->sid[1]);
 			if (rc)
 				goto out;
@@ -2514,12 +2507,14 @@ int security_node_sid(struct selinux_state *state,
 		      u32 *out_sid)
 {
 	struct policydb *policydb;
+	struct sidtab *sidtab;
 	int rc;
 	struct ocontext *c;
 
 	read_lock(&state->ss->policy_rwlock);
 
 	policydb = &state->ss->policydb;
+	sidtab = state->ss->sidtab;
 
 	switch (domain) {
 	case AF_INET: {
@@ -2561,7 +2556,7 @@ int security_node_sid(struct selinux_state *state,
 
 	if (c) {
 		if (!c->sid[0]) {
-			rc = context_struct_to_sid(state,
+			rc = sidtab_context_to_sid(sidtab,
 						   &c->context[0],
 						   &c->sid[0]);
 			if (rc)
@@ -2645,17 +2640,12 @@ int security_get_user_sids(struct selinux_state *state,
 		usercon.role = i + 1;
 		ebitmap_for_each_positive_bit(&role->types, tnode, j) {
 			usercon.type = j + 1;
-			/*
-			 * The same context struct is reused here so the hash
-			 * must be reset.
-			 */
-			usercon.hash = 0;
 
 			if (mls_setup_user_range(policydb, fromcon, user,
 						 &usercon))
 				continue;
 
-			rc = context_struct_to_sid(state, &usercon, &sid);
+			rc = sidtab_context_to_sid(sidtab, &usercon, &sid);
 			if (rc)
 				goto out_unlock;
 			if (mynel < maxnel) {
@@ -2726,6 +2716,7 @@ static inline int __security_genfs_sid(struct selinux_state *state,
 				       u32 *sid)
 {
 	struct policydb *policydb = &state->ss->policydb;
+	struct sidtab *sidtab = state->ss->sidtab;
 	int len;
 	u16 sclass;
 	struct genfs *genfs;
@@ -2760,7 +2751,7 @@ static inline int __security_genfs_sid(struct selinux_state *state,
 		goto out;
 
 	if (!c->sid[0]) {
-		rc = context_struct_to_sid(state, &c->context[0], &c->sid[0]);
+		rc = sidtab_context_to_sid(sidtab, &c->context[0], &c->sid[0]);
 		if (rc)
 			goto out;
 	}
@@ -2802,6 +2793,7 @@ int security_genfs_sid(struct selinux_state *state,
 int security_fs_use(struct selinux_state *state, struct super_block *sb)
 {
 	struct policydb *policydb;
+	struct sidtab *sidtab;
 	int rc = 0;
 	struct ocontext *c;
 	struct superblock_security_struct *sbsec = sb->s_security;
@@ -2810,6 +2802,7 @@ int security_fs_use(struct selinux_state *state, struct super_block *sb)
 	read_lock(&state->ss->policy_rwlock);
 
 	policydb = &state->ss->policydb;
+	sidtab = state->ss->sidtab;
 
 	c = policydb->ocontexts[OCON_FSUSE];
 	while (c) {
@@ -2821,7 +2814,7 @@ int security_fs_use(struct selinux_state *state, struct super_block *sb)
 	if (c) {
 		sbsec->behavior = c->v.behavior;
 		if (!c->sid[0]) {
-			rc = context_struct_to_sid(state, &c->context[0],
+			rc = sidtab_context_to_sid(sidtab, &c->context[0],
 						   &c->sid[0]);
 			if (rc)
 				goto out;
@@ -3069,7 +3062,7 @@ int security_sid_mls_copy(struct selinux_state *state,
 			goto out_unlock;
 		}
 	}
-	rc = context_struct_to_sid(state, &newcon, new_sid);
+	rc = sidtab_context_to_sid(sidtab, &newcon, new_sid);
 out_unlock:
 	read_unlock(&state->ss->policy_rwlock);
 	context_destroy(&newcon);
@@ -3662,7 +3655,7 @@ int security_netlbl_secattr_to_sid(struct selinux_state *state,
 		if (!mls_context_isvalid(policydb, &ctx_new))
 			goto out_free;
 
-		rc = context_struct_to_sid(state, &ctx_new, sid);
+		rc = sidtab_context_to_sid(sidtab, &ctx_new, sid);
 		if (rc)
 			goto out_free;
 
diff --git a/security/selinux/ss/sidtab.c b/security/selinux/ss/sidtab.c
index a308ce1e6a13..8012a6f7ef89 100644
--- a/security/selinux/ss/sidtab.c
+++ b/security/selinux/ss/sidtab.c
@@ -54,14 +54,15 @@ int sidtab_init(struct sidtab *s)
 	return 0;
 }
 
-static u32 context_to_sid(struct sidtab *s, struct context *context)
+static u32 context_to_sid(struct sidtab *s, struct context *context, u32 hash)
 {
 	struct sidtab_entry *entry;
 	u32 sid = 0;
 
 	rcu_read_lock();
-	hash_for_each_possible_rcu(s->context_to_sid, entry, list,
-				   context->hash) {
+	hash_for_each_possible_rcu(s->context_to_sid, entry, list, hash) {
+		if (entry->hash != hash)
+			continue;
 		if (context_cmp(&entry->context, context)) {
 			sid = entry->sid;
 			break;
@@ -74,6 +75,7 @@ static u32 context_to_sid(struct sidtab *s, struct context *context)
 int sidtab_set_initial(struct sidtab *s, u32 sid, struct context *context)
 {
 	struct sidtab_isid_entry *isid;
+	u32 hash;
 	int rc;
 
 	if (sid == 0 || sid > SECINITSID_NUM)
@@ -90,15 +92,18 @@ int sidtab_set_initial(struct sidtab *s, u32 sid, struct context *context)
 #endif
 	isid->set = 1;
 
+	hash = context_compute_hash(context);
+
 	/*
 	 * Multiple initial sids may map to the same context. Check that this
 	 * context is not already represented in the context_to_sid hashtable
 	 * to avoid duplicate entries and long linked lists upon hash
 	 * collision.
 	 */
-	if (!context_to_sid(s, context)) {
+	if (!context_to_sid(s, context, hash)) {
 		isid->entry.sid = sid;
-		hash_add(s->context_to_sid, &isid->entry.list, context->hash);
+		isid->entry.hash = hash;
+		hash_add(s->context_to_sid, &isid->entry.list, hash);
 	}
 
 	return 0;
@@ -259,12 +264,12 @@ int sidtab_context_to_sid(struct sidtab *s, struct context *context,
 			  u32 *sid)
 {
 	unsigned long flags;
-	u32 count;
+	u32 count, hash = context_compute_hash(context);
 	struct sidtab_convert_params *convert;
 	struct sidtab_entry *dst, *dst_convert;
 	int rc;
 
-	*sid = context_to_sid(s, context);
+	*sid = context_to_sid(s, context, hash);
 	if (*sid)
 		return 0;
 
@@ -272,7 +277,7 @@ int sidtab_context_to_sid(struct sidtab *s, struct context *context,
 	spin_lock_irqsave(&s->lock, flags);
 
 	rc = 0;
-	*sid = context_to_sid(s, context);
+	*sid = context_to_sid(s, context, hash);
 	if (*sid)
 		goto out_unlock;
 
@@ -292,6 +297,7 @@ int sidtab_context_to_sid(struct sidtab *s, struct context *context,
 		goto out_unlock;
 
 	dst->sid = index_to_sid(count);
+	dst->hash = hash;
 
 	rc = context_cpy(&dst->context, context);
 	if (rc)
@@ -316,10 +322,11 @@ int sidtab_context_to_sid(struct sidtab *s, struct context *context,
 			goto out_unlock;
 		}
 		dst_convert->sid = index_to_sid(count);
+		dst_convert->hash = context_compute_hash(&dst_convert->context);
 		convert->target->count = count + 1;
 
 		hash_add_rcu(convert->target->context_to_sid,
-			     &dst_convert->list, dst_convert->context.hash);
+			     &dst_convert->list, dst_convert->hash);
 	}
 
 	if (context->len)
@@ -330,7 +337,7 @@ int sidtab_context_to_sid(struct sidtab *s, struct context *context,
 
 	/* write entries before updating count */
 	smp_store_release(&s->count, count + 1);
-	hash_add_rcu(s->context_to_sid, &dst->list, dst->context.hash);
+	hash_add_rcu(s->context_to_sid, &dst->list, dst->hash);
 
 	rc = 0;
 out_unlock:
@@ -346,10 +353,9 @@ static void sidtab_convert_hashtable(struct sidtab *s, u32 count)
 	for (i = 0; i < count; i++) {
 		entry = sidtab_do_lookup(s, i, 0);
 		entry->sid = index_to_sid(i);
+		entry->hash = context_compute_hash(&entry->context);
 
-		hash_add_rcu(s->context_to_sid, &entry->list,
-			     entry->context.hash);
-
+		hash_add_rcu(s->context_to_sid, &entry->list, entry->hash);
 	}
 }
 
diff --git a/security/selinux/ss/sidtab.h b/security/selinux/ss/sidtab.h
index 3311d9f236c0..f2a84560b8b3 100644
--- a/security/selinux/ss/sidtab.h
+++ b/security/selinux/ss/sidtab.h
@@ -19,6 +19,7 @@
 
 struct sidtab_entry {
 	u32 sid;
+	u32 hash;
 	struct context context;
 #if CONFIG_SECURITY_SELINUX_SID2STR_CACHE_SIZE > 0
 	struct sidtab_str_cache __rcu *cache;
-- 
2.25.2

