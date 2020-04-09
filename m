Return-Path: <SRS0=zGJ6=5Z=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAEE4C2BB86
	for <selinux@archiver.kernel.org>; Thu,  9 Apr 2020 08:19:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 109E020771
	for <selinux@archiver.kernel.org>; Thu,  9 Apr 2020 08:12:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BA204sGK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726534AbgDIIM6 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 9 Apr 2020 04:12:58 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:54889 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725828AbgDIIM5 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 9 Apr 2020 04:12:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1586419976;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6zTHr/Vve7o7D0sCQssgQhM2EuTkmzFeVbwLN4kMqEI=;
        b=BA204sGKWScJrx+RRWbotzj1ETn1Guc+7MBjO2gip7rRCLZZ+Y7rHsCyc53H2e+w6K9i2h
        BkEhPY/AVJPrZKxmCbg06hr0hqSBnpIuJj18//yz9GO3xDPMDNrWOQUzO+MNHKpDjpjYp1
        FJjFjLNF3zNS1SzgKLFZ0zBjUJpVDJk=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-253-hD60vMChOoSjpVwbPY8qOA-1; Thu, 09 Apr 2020 04:12:54 -0400
X-MC-Unique: hD60vMChOoSjpVwbPY8qOA-1
Received: by mail-wr1-f71.google.com with SMTP id h14so5946828wrr.12
        for <selinux@vger.kernel.org>; Thu, 09 Apr 2020 01:12:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6zTHr/Vve7o7D0sCQssgQhM2EuTkmzFeVbwLN4kMqEI=;
        b=B8/3uLTuKN6EhrGf7EyEOLUbFspNHCTa6ijbJG9AcyRFGc+4tfNCg4tReELU+p85d2
         +ffRf7AND74aIztH17UYuRfuiENJs6oVmYddqALIXgbfEPdpmKEt6c5S6iyX4Yf/DS4k
         /1VZ/h5j1IHFCvxH+zEs6McLmSKmiOByU09Ly8n6xsshY8BFriO4RJgtaGeHKNbQQThm
         o/IxyDUZ8lr5dgbszqWcu6TFbffsPO8+WVuA5WSoQAZW3KTvpRXzrchdbaOqEyKXyhhu
         nRIK9cr8S6nR8CYNDwzo3drgoC1sR3TsI310/yVdCo49ZmfuBH7ZGZP11ws/nFg1ThMh
         f+pQ==
X-Gm-Message-State: AGi0Puah3rCLYyonEUBAVNFYc3b0V+HXkjJGK2ucmEpnopiyBXS2gDVU
        jYsAQ5f571AxO0DEWl4bMsW90P8RICsC5NqFvua054LTumrPDbyoMMFL0HgiHGqk6dJrlMxG39Z
        M+HJXgVdGNt4MkPSLPw==
X-Received: by 2002:a1c:2392:: with SMTP id j140mr6437395wmj.136.1586419973190;
        Thu, 09 Apr 2020 01:12:53 -0700 (PDT)
X-Google-Smtp-Source: APiQypKCPRIb+GZX+zDn3sAsurRNlNhgDWVeW+17cLDqP7alWpdAlARPbVmS0i8hoMtkDyXHeH2m5g==
X-Received: by 2002:a1c:2392:: with SMTP id j140mr6437359wmj.136.1586419972713;
        Thu, 09 Apr 2020 01:12:52 -0700 (PDT)
Received: from omos.redhat.com ([2a02:8308:b13f:2100:f695:3ae5:c8bf:2f57])
        by smtp.gmail.com with ESMTPSA id a7sm2772782wmj.12.2020.04.09.01.12.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Apr 2020 01:12:52 -0700 (PDT)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     selinux@vger.kernel.org, Paul Moore <paul@paul-moore.com>
Cc:     Stephen Smalley <sds@tycho.nsa.gov>,
        Jeff Vander Stoep <jeffv@google.com>
Subject: [PATCH 1/2] selinux: hash context structure directly
Date:   Thu,  9 Apr 2020 10:12:47 +0200
Message-Id: <20200409081248.1273383-2-omosnace@redhat.com>
X-Mailer: git-send-email 2.25.2
In-Reply-To: <20200409081248.1273383-1-omosnace@redhat.com>
References: <20200409081248.1273383-1-omosnace@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Always hashing the string representation is inefficient. Just hash the
contents of the structure directly (using jhash). If the context is
invalid (str & len are set), then hash the string as before, otherwise
hash the structured data. Any context that is valid under the given
policy should always be structured, and also any context that is invalid
should be never structured, so the hashes should always match for the
same context. The fact that context_cmp() also follows this logic
further reinforces this assumption.

Since the context hashing function is now faster (about 10 times), this
patch decreases the overhead of security_transition_sid(), which is
called from many hooks.

The jhash function seemed as a good choice, since it is used as the
default hashing algorithm in rhashtable.

Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
---
 security/selinux/Makefile      |  2 +-
 security/selinux/ss/context.c  | 28 ++++++++++++
 security/selinux/ss/context.h  |  6 ++-
 security/selinux/ss/ebitmap.c  | 14 ++++++
 security/selinux/ss/ebitmap.h  |  1 +
 security/selinux/ss/policydb.c |  7 +--
 security/selinux/ss/services.c | 80 ++++++++++++++--------------------
 security/selinux/ss/services.h |  3 --
 8 files changed, 82 insertions(+), 59 deletions(-)
 create mode 100644 security/selinux/ss/context.c

diff --git a/security/selinux/Makefile b/security/selinux/Makefile
index 0c77ede1cc11..4d8e0e8adf0b 100644
--- a/security/selinux/Makefile
+++ b/security/selinux/Makefile
@@ -8,7 +8,7 @@ obj-$(CONFIG_SECURITY_SELINUX) := selinux.o
 selinux-y := avc.o hooks.o selinuxfs.o netlink.o nlmsgtab.o netif.o \
 	     netnode.o netport.o status.o \
 	     ss/ebitmap.o ss/hashtab.o ss/symtab.o ss/sidtab.o ss/avtab.o \
-	     ss/policydb.o ss/services.o ss/conditional.o ss/mls.o
+	     ss/policydb.o ss/services.o ss/conditional.o ss/mls.o ss/context.o
 
 selinux-$(CONFIG_SECURITY_NETWORK_XFRM) += xfrm.o
 
diff --git a/security/selinux/ss/context.c b/security/selinux/ss/context.c
new file mode 100644
index 000000000000..7ca32683056d
--- /dev/null
+++ b/security/selinux/ss/context.c
@@ -0,0 +1,28 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Implementations of the security context functions.
+ *
+ * Author: Ondrej Mosnacek <omosnacek@gmail.com>
+ * Copyright (C) 2018 Red Hat, Inc.
+ */
+
+#include <linux/jhash.h>
+
+#include "context.h"
+#include "mls.h"
+
+u32 context_compute_hash(const struct context *c)
+{
+	u32 hash = 0;
+
+	if (c->len)
+		return full_name_hash(NULL, c->str, c->len);
+
+	hash = jhash_3words(c->user, c->role, c->type, hash);
+	hash = jhash_2words(c->range.level[0].sens,
+			    c->range.level[1].sens, hash);
+	hash = ebitmap_hash(&c->range.level[0].cat, hash);
+	hash = ebitmap_hash(&c->range.level[1].cat, hash);
+
+	return hash;
+}
diff --git a/security/selinux/ss/context.h b/security/selinux/ss/context.h
index 3ba044fe02ed..e7ae7e21449b 100644
--- a/security/selinux/ss/context.h
+++ b/security/selinux/ss/context.h
@@ -196,9 +196,11 @@ static inline int context_cmp(struct context *c1, struct context *c2)
 		mls_context_cmp(c1, c2));
 }
 
-static inline unsigned int context_compute_hash(const char *s)
+u32 context_compute_hash(const struct context *c);
+
+static inline void context_add_hash(struct context *context)
 {
-	return full_name_hash(NULL, s, strlen(s));
+	context->hash = context_compute_hash(context);
 }
 
 #endif	/* _SS_CONTEXT_H_ */
diff --git a/security/selinux/ss/ebitmap.c b/security/selinux/ss/ebitmap.c
index c8c3663111e2..14bedc95c6dc 100644
--- a/security/selinux/ss/ebitmap.c
+++ b/security/selinux/ss/ebitmap.c
@@ -19,6 +19,7 @@
 #include <linux/kernel.h>
 #include <linux/slab.h>
 #include <linux/errno.h>
+#include <linux/jhash.h>
 #include <net/netlabel.h>
 #include "ebitmap.h"
 #include "policydb.h"
@@ -542,6 +543,19 @@ int ebitmap_write(struct ebitmap *e, void *fp)
 	return 0;
 }
 
+u32 ebitmap_hash(const struct ebitmap *e, u32 hash)
+{
+	struct ebitmap_node *node;
+
+	/* need to change hash even if ebitmap is empty */
+	hash = jhash_1word(e->highbit, hash);
+	for (node = e->node; node; node = node->next) {
+		hash = jhash_1word(node->startbit, hash);
+		hash = jhash(node->maps, sizeof(node->maps), hash);
+	}
+	return hash;
+}
+
 void __init ebitmap_cache_init(void)
 {
 	ebitmap_node_cachep = kmem_cache_create("ebitmap_node",
diff --git a/security/selinux/ss/ebitmap.h b/security/selinux/ss/ebitmap.h
index 9a23b81b8832..9eb2d0af2805 100644
--- a/security/selinux/ss/ebitmap.h
+++ b/security/selinux/ss/ebitmap.h
@@ -131,6 +131,7 @@ int ebitmap_set_bit(struct ebitmap *e, unsigned long bit, int value);
 void ebitmap_destroy(struct ebitmap *e);
 int ebitmap_read(struct ebitmap *e, void *fp);
 int ebitmap_write(struct ebitmap *e, void *fp);
+u32 ebitmap_hash(const struct ebitmap *e, u32 hash);
 
 #ifdef CONFIG_NETLABEL
 int ebitmap_netlbl_export(struct ebitmap *ebmap,
diff --git a/security/selinux/ss/policydb.c b/security/selinux/ss/policydb.c
index 70ecdc78efbd..ac6c0a214fc5 100644
--- a/security/selinux/ss/policydb.c
+++ b/security/selinux/ss/policydb.c
@@ -836,11 +836,8 @@ int policydb_load_isids(struct policydb *p, struct sidtab *s)
 		if (!name)
 			continue;
 
-		rc = context_add_hash(p, &c->context[0]);
-		if (rc) {
-			sidtab_destroy(s);
-			goto out;
-		}
+		context_add_hash(&c->context[0]);
+
 		rc = sidtab_set_initial(s, sid, &c->context[0]);
 		if (rc) {
 			pr_err("SELinux:  unable to load initial SID %s.\n",
diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
index 8ad34fd031d1..2099355e9a7d 100644
--- a/security/selinux/ss/services.c
+++ b/security/selinux/ss/services.c
@@ -1490,38 +1490,11 @@ out:
 	return rc;
 }
 
-int context_add_hash(struct policydb *policydb,
-		     struct context *context)
+static int context_struct_to_sid(struct sidtab *sidtab, struct context *context,
+				 u32 *sid)
 {
-	int rc;
-	char *str;
-	int len;
-
-	if (context->str) {
-		context->hash = context_compute_hash(context->str);
-	} else {
-		rc = context_struct_to_string(policydb, context,
-					      &str, &len);
-		if (rc)
-			return rc;
-		context->hash = context_compute_hash(str);
-		kfree(str);
-	}
-	return 0;
-}
-
-static int context_struct_to_sid(struct selinux_state *state,
-				 struct context *context, u32 *sid)
-{
-	int rc;
-	struct sidtab *sidtab = state->ss->sidtab;
-	struct policydb *policydb = &state->ss->policydb;
-
-	if (!context->hash) {
-		rc = context_add_hash(policydb, context);
-		if (rc)
-			return rc;
-	}
+	if (!context->hash)
+		context_add_hash(context);
 
 	return sidtab_context_to_sid(sidtab, context, sid);
 }
@@ -1580,7 +1553,7 @@ static int security_context_to_sid_core(struct selinux_state *state,
 		str = NULL;
 	} else if (rc)
 		goto out_unlock;
-	rc = context_struct_to_sid(state, &context, sid);
+	rc = context_struct_to_sid(sidtab, &context, sid);
 	context_destroy(&context);
 out_unlock:
 	read_unlock(&state->ss->policy_rwlock);
@@ -1891,7 +1864,7 @@ static int security_compute_sid(struct selinux_state *state,
 			goto out_unlock;
 	}
 	/* Obtain the sid for the context. */
-	rc = context_struct_to_sid(state, &newcontext, out_sid);
+	rc = context_struct_to_sid(sidtab, &newcontext, out_sid);
 out_unlock:
 	read_unlock(&state->ss->policy_rwlock);
 	context_destroy(&newcontext);
@@ -2120,9 +2093,7 @@ static int convert_context(struct context *oldc, struct context *newc, void *p)
 			goto bad;
 	}
 
-	rc = context_add_hash(args->newp, newc);
-	if (rc)
-		goto bad;
+	context_add_hash(newc);
 
 	return 0;
 bad:
@@ -2133,7 +2104,7 @@ bad:
 	context_destroy(newc);
 	newc->str = s;
 	newc->len = len;
-	newc->hash = context_compute_hash(s);
+	context_add_hash(newc);
 	pr_info("SELinux:  Context %s became invalid (unmapped).\n",
 		newc->str);
 	return 0;
@@ -2350,12 +2321,14 @@ int security_port_sid(struct selinux_state *state,
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
@@ -2368,7 +2341,7 @@ int security_port_sid(struct selinux_state *state,
 
 	if (c) {
 		if (!c->sid[0]) {
-			rc = context_struct_to_sid(state, &c->context[0],
+			rc = context_struct_to_sid(sidtab, &c->context[0],
 						   &c->sid[0]);
 			if (rc)
 				goto out;
@@ -2393,12 +2366,14 @@ int security_ib_pkey_sid(struct selinux_state *state,
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
@@ -2412,7 +2387,7 @@ int security_ib_pkey_sid(struct selinux_state *state,
 
 	if (c) {
 		if (!c->sid[0]) {
-			rc = context_struct_to_sid(state,
+			rc = context_struct_to_sid(sidtab,
 						   &c->context[0],
 						   &c->sid[0]);
 			if (rc)
@@ -2437,12 +2412,14 @@ int security_ib_endport_sid(struct selinux_state *state,
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
@@ -2457,7 +2434,7 @@ int security_ib_endport_sid(struct selinux_state *state,
 
 	if (c) {
 		if (!c->sid[0]) {
-			rc = context_struct_to_sid(state, &c->context[0],
+			rc = context_struct_to_sid(sidtab, &c->context[0],
 						   &c->sid[0]);
 			if (rc)
 				goto out;
@@ -2480,12 +2457,14 @@ int security_netif_sid(struct selinux_state *state,
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
@@ -2496,11 +2475,11 @@ int security_netif_sid(struct selinux_state *state,
 
 	if (c) {
 		if (!c->sid[0] || !c->sid[1]) {
-			rc = context_struct_to_sid(state, &c->context[0],
+			rc = context_struct_to_sid(sidtab, &c->context[0],
 						   &c->sid[0]);
 			if (rc)
 				goto out;
-			rc = context_struct_to_sid(state, &c->context[1],
+			rc = context_struct_to_sid(sidtab, &c->context[1],
 						   &c->sid[1]);
 			if (rc)
 				goto out;
@@ -2541,12 +2520,14 @@ int security_node_sid(struct selinux_state *state,
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
@@ -2588,7 +2569,7 @@ int security_node_sid(struct selinux_state *state,
 
 	if (c) {
 		if (!c->sid[0]) {
-			rc = context_struct_to_sid(state,
+			rc = context_struct_to_sid(sidtab,
 						   &c->context[0],
 						   &c->sid[0]);
 			if (rc)
@@ -2682,7 +2663,7 @@ int security_get_user_sids(struct selinux_state *state,
 						 &usercon))
 				continue;
 
-			rc = context_struct_to_sid(state, &usercon, &sid);
+			rc = context_struct_to_sid(sidtab, &usercon, &sid);
 			if (rc)
 				goto out_unlock;
 			if (mynel < maxnel) {
@@ -2753,6 +2734,7 @@ static inline int __security_genfs_sid(struct selinux_state *state,
 				       u32 *sid)
 {
 	struct policydb *policydb = &state->ss->policydb;
+	struct sidtab *sidtab = state->ss->sidtab;
 	int len;
 	u16 sclass;
 	struct genfs *genfs;
@@ -2787,7 +2769,7 @@ static inline int __security_genfs_sid(struct selinux_state *state,
 		goto out;
 
 	if (!c->sid[0]) {
-		rc = context_struct_to_sid(state, &c->context[0], &c->sid[0]);
+		rc = context_struct_to_sid(sidtab, &c->context[0], &c->sid[0]);
 		if (rc)
 			goto out;
 	}
@@ -2829,6 +2811,7 @@ int security_genfs_sid(struct selinux_state *state,
 int security_fs_use(struct selinux_state *state, struct super_block *sb)
 {
 	struct policydb *policydb;
+	struct sidtab *sidtab;
 	int rc = 0;
 	struct ocontext *c;
 	struct superblock_security_struct *sbsec = sb->s_security;
@@ -2837,6 +2820,7 @@ int security_fs_use(struct selinux_state *state, struct super_block *sb)
 	read_lock(&state->ss->policy_rwlock);
 
 	policydb = &state->ss->policydb;
+	sidtab = state->ss->sidtab;
 
 	c = policydb->ocontexts[OCON_FSUSE];
 	while (c) {
@@ -2848,7 +2832,7 @@ int security_fs_use(struct selinux_state *state, struct super_block *sb)
 	if (c) {
 		sbsec->behavior = c->v.behavior;
 		if (!c->sid[0]) {
-			rc = context_struct_to_sid(state, &c->context[0],
+			rc = context_struct_to_sid(sidtab, &c->context[0],
 						   &c->sid[0]);
 			if (rc)
 				goto out;
@@ -3096,7 +3080,7 @@ int security_sid_mls_copy(struct selinux_state *state,
 			goto out_unlock;
 		}
 	}
-	rc = context_struct_to_sid(state, &newcon, new_sid);
+	rc = context_struct_to_sid(sidtab, &newcon, new_sid);
 out_unlock:
 	read_unlock(&state->ss->policy_rwlock);
 	context_destroy(&newcon);
@@ -3689,7 +3673,7 @@ int security_netlbl_secattr_to_sid(struct selinux_state *state,
 		if (!mls_context_isvalid(policydb, &ctx_new))
 			goto out_free;
 
-		rc = context_struct_to_sid(state, &ctx_new, sid);
+		rc = context_struct_to_sid(sidtab, &ctx_new, sid);
 		if (rc)
 			goto out_free;
 
diff --git a/security/selinux/ss/services.h b/security/selinux/ss/services.h
index e9bddf33e53d..a06f3d835216 100644
--- a/security/selinux/ss/services.h
+++ b/security/selinux/ss/services.h
@@ -8,7 +8,6 @@
 #define _SS_SERVICES_H_
 
 #include "policydb.h"
-#include "context.h"
 
 /* Mapping for a single class */
 struct selinux_mapping {
@@ -37,6 +36,4 @@ void services_compute_xperms_drivers(struct extended_perms *xperms,
 void services_compute_xperms_decision(struct extended_perms_decision *xpermd,
 					struct avtab_node *node);
 
-int context_add_hash(struct policydb *policydb, struct context *context);
-
 #endif	/* _SS_SERVICES_H_ */
-- 
2.25.2

