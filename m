Return-Path: <SRS0=81+4=OJ=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40756C04EB8
	for <selinux@archiver.kernel.org>; Fri, 30 Nov 2018 15:24:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ECC5C20868
	for <selinux@archiver.kernel.org>; Fri, 30 Nov 2018 15:24:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ECC5C20868
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=selinux-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726771AbeLACeA (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 30 Nov 2018 21:34:00 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:40292 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726624AbeLACeA (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 30 Nov 2018 21:34:00 -0500
Received: by mail-wm1-f65.google.com with SMTP id q26so6063676wmf.5
        for <selinux@vger.kernel.org>; Fri, 30 Nov 2018 07:24:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7mXhzvveVXWFeciyhwMy1mc1pi6Bv8ODNmoGZwYh2kw=;
        b=nc4V2Hjfo8DHSvCHl038+fZm3lRzDd/S9I8ZpWBzoXp25x8w20tK8bMkmbUtwf/3fc
         2ui8b0W9T2OznJbiXO9L2yq64b1l5NE+KlVh+4eeevHVy0M9HWwYffZjG6qw2rlsXn9i
         eiDlVOS4VoCW50y724hlSKBXKcVugy2hdrxzEUYCN0HIS0Y/JDdYhvOUdIFztlAgs2aO
         WK648WY5IkQh7mPnc/orL2aErJ4QcM7LCanvcFAa7gri5j5HcU1PW7EUm69dem6BuyU1
         RowwNrue4JNBAHL+csxE3R22xW9fDbtptRAJANGv9PK2ajeJemg3rGY1QxjY8QFC538p
         ye8w==
X-Gm-Message-State: AA+aEWbc38BLz+mpkS1Nyg8QK35qCDvTNJhbdbFU5dfNtmW8okdBg2gm
        10hSanZaFYTOuxKIPSMd7BQmwLSuZ6OEJA==
X-Google-Smtp-Source: AFSGD/UqOiR/bxl/NmTaZEt9+l7tFISwUcDgOCYpAFwYgRxqOb6XiVLE9d1P0oVsUR7X05/kU74i/w==
X-Received: by 2002:a1c:a755:: with SMTP id q82mr6178195wme.6.1543591456738;
        Fri, 30 Nov 2018 07:24:16 -0800 (PST)
Received: from localhost.localdomain (adsl-dyn176.78-99-75.t-com.sk. [78.99.75.176])
        by smtp.gmail.com with ESMTPSA id l2sm10102085wma.33.2018.11.30.07.24.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 30 Nov 2018 07:24:15 -0800 (PST)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     selinux@vger.kernel.org, Paul Moore <paul@paul-moore.com>
Cc:     Stephen Smalley <sds@tycho.nsa.gov>,
        Ondrej Mosnacek <omosnace@redhat.com>
Subject: [RFC PATCH v4 1/2] selinux: use separate table for initial SID lookup
Date:   Fri, 30 Nov 2018 16:24:07 +0100
Message-Id: <20181130152408.24513-2-omosnace@redhat.com>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181130152408.24513-1-omosnace@redhat.com>
References: <20181130152408.24513-1-omosnace@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

This moves handling of initial SIDs into a separate table. Note that the
SIDs stored in the main table are now shifted by SECINITSID_NUM and
converted to/from the actual SIDs transparently by helper functions.

This change doesn't make much sense on its own, but it simplifies
further sidtab overhaul in a succeeding patch.

Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
---
 security/selinux/ss/policydb.c |  10 +-
 security/selinux/ss/services.c |  88 +++++++++--------
 security/selinux/ss/services.h |   2 +-
 security/selinux/ss/sidtab.c   | 168 ++++++++++++++++++++-------------
 security/selinux/ss/sidtab.h   |  15 ++-
 5 files changed, 173 insertions(+), 110 deletions(-)

diff --git a/security/selinux/ss/policydb.c b/security/selinux/ss/policydb.c
index b63ef865ce1e..a50d625e7946 100644
--- a/security/selinux/ss/policydb.c
+++ b/security/selinux/ss/policydb.c
@@ -909,13 +909,21 @@ int policydb_load_isids(struct policydb *p, struct sidtab *s)
 		if (!c->context[0].user) {
 			pr_err("SELinux:  SID %s was never defined.\n",
 				c->u.name);
+			sidtab_destroy(s);
+			goto out;
+		}
+		if (c->sid[0] == SECSID_NULL || c->sid[0] > SECINITSID_NUM) {
+			pr_err("SELinux:  Initial SID %s out of range.\n",
+				c->u.name);
+			sidtab_destroy(s);
 			goto out;
 		}
 
-		rc = sidtab_insert(s, c->sid[0], &c->context[0]);
+		rc = sidtab_set_initial(s, c->sid[0], &c->context[0]);
 		if (rc) {
 			pr_err("SELinux:  unable to load initial SID %s.\n",
 				c->u.name);
+			sidtab_destroy(s);
 			goto out;
 		}
 	}
diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
index 7337db24a6a8..30170d4c567a 100644
--- a/security/selinux/ss/services.c
+++ b/security/selinux/ss/services.c
@@ -776,7 +776,7 @@ static int security_compute_validatetrans(struct selinux_state *state,
 	read_lock(&state->ss->policy_rwlock);
 
 	policydb = &state->ss->policydb;
-	sidtab = &state->ss->sidtab;
+	sidtab = state->ss->sidtab;
 
 	if (!user)
 		tclass = unmap_class(&state->ss->map, orig_tclass);
@@ -876,7 +876,7 @@ int security_bounded_transition(struct selinux_state *state,
 	read_lock(&state->ss->policy_rwlock);
 
 	policydb = &state->ss->policydb;
-	sidtab = &state->ss->sidtab;
+	sidtab = state->ss->sidtab;
 
 	rc = -EINVAL;
 	old_context = sidtab_search(sidtab, old_sid);
@@ -1034,7 +1034,7 @@ void security_compute_xperms_decision(struct selinux_state *state,
 		goto allow;
 
 	policydb = &state->ss->policydb;
-	sidtab = &state->ss->sidtab;
+	sidtab = state->ss->sidtab;
 
 	scontext = sidtab_search(sidtab, ssid);
 	if (!scontext) {
@@ -1123,7 +1123,7 @@ void security_compute_av(struct selinux_state *state,
 		goto allow;
 
 	policydb = &state->ss->policydb;
-	sidtab = &state->ss->sidtab;
+	sidtab = state->ss->sidtab;
 
 	scontext = sidtab_search(sidtab, ssid);
 	if (!scontext) {
@@ -1177,7 +1177,7 @@ void security_compute_av_user(struct selinux_state *state,
 		goto allow;
 
 	policydb = &state->ss->policydb;
-	sidtab = &state->ss->sidtab;
+	sidtab = state->ss->sidtab;
 
 	scontext = sidtab_search(sidtab, ssid);
 	if (!scontext) {
@@ -1315,7 +1315,7 @@ static int security_sid_to_context_core(struct selinux_state *state,
 	}
 	read_lock(&state->ss->policy_rwlock);
 	policydb = &state->ss->policydb;
-	sidtab = &state->ss->sidtab;
+	sidtab = state->ss->sidtab;
 	if (force)
 		context = sidtab_search_force(sidtab, sid);
 	else
@@ -1483,7 +1483,7 @@ static int security_context_to_sid_core(struct selinux_state *state,
 	}
 	read_lock(&state->ss->policy_rwlock);
 	policydb = &state->ss->policydb;
-	sidtab = &state->ss->sidtab;
+	sidtab = state->ss->sidtab;
 	rc = string_to_context_struct(policydb, sidtab, scontext2,
 				      &context, def_sid);
 	if (rc == -EINVAL && force) {
@@ -1668,7 +1668,7 @@ static int security_compute_sid(struct selinux_state *state,
 	}
 
 	policydb = &state->ss->policydb;
-	sidtab = &state->ss->sidtab;
+	sidtab = state->ss->sidtab;
 
 	scontext = sidtab_search(sidtab, ssid);
 	if (!scontext) {
@@ -1925,10 +1925,7 @@ static int convert_context(u32 key,
 	struct user_datum *usrdatum;
 	char *s;
 	u32 len;
-	int rc = 0;
-
-	if (key <= SECINITSID_NUM)
-		goto out;
+	int rc;
 
 	args = p;
 
@@ -2090,9 +2087,8 @@ static int security_preserve_bools(struct selinux_state *state,
 int security_load_policy(struct selinux_state *state, void *data, size_t len)
 {
 	struct policydb *policydb;
-	struct sidtab *sidtab;
+	struct sidtab *oldsidtab, *newsidtab;
 	struct policydb *oldpolicydb, *newpolicydb;
-	struct sidtab oldsidtab, newsidtab;
 	struct selinux_mapping *oldmapping;
 	struct selinux_map newmap;
 	struct convert_context_args args;
@@ -2108,27 +2104,37 @@ int security_load_policy(struct selinux_state *state, void *data, size_t len)
 	newpolicydb = oldpolicydb + 1;
 
 	policydb = &state->ss->policydb;
-	sidtab = &state->ss->sidtab;
+
+	newsidtab = kmalloc(sizeof(*newsidtab), GFP_KERNEL);
+	if (!newsidtab) {
+		rc = -ENOMEM;
+		goto out;
+	}
 
 	if (!state->initialized) {
 		rc = policydb_read(policydb, fp);
-		if (rc)
+		if (rc) {
+			kfree(newsidtab);
 			goto out;
+		}
 
 		policydb->len = len;
 		rc = selinux_set_mapping(policydb, secclass_map,
 					 &state->ss->map);
 		if (rc) {
+			kfree(newsidtab);
 			policydb_destroy(policydb);
 			goto out;
 		}
 
-		rc = policydb_load_isids(policydb, sidtab);
+		rc = policydb_load_isids(policydb, newsidtab);
 		if (rc) {
+			kfree(newsidtab);
 			policydb_destroy(policydb);
 			goto out;
 		}
 
+		state->ss->sidtab = newsidtab;
 		security_load_policycaps(state);
 		state->initialized = 1;
 		seqno = ++state->ss->latest_granting;
@@ -2141,13 +2147,17 @@ int security_load_policy(struct selinux_state *state, void *data, size_t len)
 		goto out;
 	}
 
+	oldsidtab = state->ss->sidtab;
+
 #if 0
-	sidtab_hash_eval(sidtab, "sids");
+	sidtab_hash_eval(oldsidtab, "sids");
 #endif
 
 	rc = policydb_read(newpolicydb, fp);
-	if (rc)
+	if (rc) {
+		kfree(newsidtab);
 		goto out;
+	}
 
 	newpolicydb->len = len;
 	/* If switching between different policy types, log MLS status */
@@ -2156,10 +2166,11 @@ int security_load_policy(struct selinux_state *state, void *data, size_t len)
 	else if (!policydb->mls_enabled && newpolicydb->mls_enabled)
 		pr_info("SELinux: Enabling MLS support...\n");
 
-	rc = policydb_load_isids(newpolicydb, &newsidtab);
+	rc = policydb_load_isids(newpolicydb, newsidtab);
 	if (rc) {
 		pr_err("SELinux:  unable to load the initial SIDs\n");
 		policydb_destroy(newpolicydb);
+		kfree(newsidtab);
 		goto out;
 	}
 
@@ -2180,7 +2191,7 @@ int security_load_policy(struct selinux_state *state, void *data, size_t len)
 	args.state = state;
 	args.oldp = policydb;
 	args.newp = newpolicydb;
-	rc = sidtab_convert(sidtab, &newsidtab, convert_context, &args);
+	rc = sidtab_convert(oldsidtab, newsidtab, convert_context, &args);
 	if (rc) {
 		pr_err("SELinux:  unable to convert the internal"
 			" representation of contexts in the new SID"
@@ -2190,12 +2201,11 @@ int security_load_policy(struct selinux_state *state, void *data, size_t len)
 
 	/* Save the old policydb and SID table to free later. */
 	memcpy(oldpolicydb, policydb, sizeof(*policydb));
-	sidtab_set(&oldsidtab, sidtab);
 
 	/* Install the new policydb and SID table. */
 	write_lock_irq(&state->ss->policy_rwlock);
 	memcpy(policydb, newpolicydb, sizeof(*policydb));
-	sidtab_set(sidtab, &newsidtab);
+	state->ss->sidtab = newsidtab;
 	security_load_policycaps(state);
 	oldmapping = state->ss->map.mapping;
 	state->ss->map.mapping = newmap.mapping;
@@ -2205,7 +2215,8 @@ int security_load_policy(struct selinux_state *state, void *data, size_t len)
 
 	/* Free the old policydb and SID table. */
 	policydb_destroy(oldpolicydb);
-	sidtab_destroy(&oldsidtab);
+	sidtab_destroy(oldsidtab);
+	kfree(oldsidtab);
 	kfree(oldmapping);
 
 	avc_ss_reset(state->avc, seqno);
@@ -2219,7 +2230,8 @@ int security_load_policy(struct selinux_state *state, void *data, size_t len)
 
 err:
 	kfree(newmap.mapping);
-	sidtab_destroy(&newsidtab);
+	sidtab_destroy(newsidtab);
+	kfree(newsidtab);
 	policydb_destroy(newpolicydb);
 
 out:
@@ -2256,7 +2268,7 @@ int security_port_sid(struct selinux_state *state,
 	read_lock(&state->ss->policy_rwlock);
 
 	policydb = &state->ss->policydb;
-	sidtab = &state->ss->sidtab;
+	sidtab = state->ss->sidtab;
 
 	c = policydb->ocontexts[OCON_PORT];
 	while (c) {
@@ -2302,7 +2314,7 @@ int security_ib_pkey_sid(struct selinux_state *state,
 	read_lock(&state->ss->policy_rwlock);
 
 	policydb = &state->ss->policydb;
-	sidtab = &state->ss->sidtab;
+	sidtab = state->ss->sidtab;
 
 	c = policydb->ocontexts[OCON_IBPKEY];
 	while (c) {
@@ -2348,7 +2360,7 @@ int security_ib_endport_sid(struct selinux_state *state,
 	read_lock(&state->ss->policy_rwlock);
 
 	policydb = &state->ss->policydb;
-	sidtab = &state->ss->sidtab;
+	sidtab = state->ss->sidtab;
 
 	c = policydb->ocontexts[OCON_IBENDPORT];
 	while (c) {
@@ -2394,7 +2406,7 @@ int security_netif_sid(struct selinux_state *state,
 	read_lock(&state->ss->policy_rwlock);
 
 	policydb = &state->ss->policydb;
-	sidtab = &state->ss->sidtab;
+	sidtab = state->ss->sidtab;
 
 	c = policydb->ocontexts[OCON_NETIF];
 	while (c) {
@@ -2459,7 +2471,7 @@ int security_node_sid(struct selinux_state *state,
 	read_lock(&state->ss->policy_rwlock);
 
 	policydb = &state->ss->policydb;
-	sidtab = &state->ss->sidtab;
+	sidtab = state->ss->sidtab;
 
 	switch (domain) {
 	case AF_INET: {
@@ -2559,7 +2571,7 @@ int security_get_user_sids(struct selinux_state *state,
 	read_lock(&state->ss->policy_rwlock);
 
 	policydb = &state->ss->policydb;
-	sidtab = &state->ss->sidtab;
+	sidtab = state->ss->sidtab;
 
 	context_init(&usercon);
 
@@ -2661,7 +2673,7 @@ static inline int __security_genfs_sid(struct selinux_state *state,
 				       u32 *sid)
 {
 	struct policydb *policydb = &state->ss->policydb;
-	struct sidtab *sidtab = &state->ss->sidtab;
+	struct sidtab *sidtab = state->ss->sidtab;
 	int len;
 	u16 sclass;
 	struct genfs *genfs;
@@ -2747,7 +2759,7 @@ int security_fs_use(struct selinux_state *state, struct super_block *sb)
 	read_lock(&state->ss->policy_rwlock);
 
 	policydb = &state->ss->policydb;
-	sidtab = &state->ss->sidtab;
+	sidtab = state->ss->sidtab;
 
 	c = policydb->ocontexts[OCON_FSUSE];
 	while (c) {
@@ -2953,7 +2965,7 @@ int security_sid_mls_copy(struct selinux_state *state,
 			  u32 sid, u32 mls_sid, u32 *new_sid)
 {
 	struct policydb *policydb = &state->ss->policydb;
-	struct sidtab *sidtab = &state->ss->sidtab;
+	struct sidtab *sidtab = state->ss->sidtab;
 	struct context *context1;
 	struct context *context2;
 	struct context newcon;
@@ -3044,7 +3056,7 @@ int security_net_peersid_resolve(struct selinux_state *state,
 				 u32 *peer_sid)
 {
 	struct policydb *policydb = &state->ss->policydb;
-	struct sidtab *sidtab = &state->ss->sidtab;
+	struct sidtab *sidtab = state->ss->sidtab;
 	int rc;
 	struct context *nlbl_ctx;
 	struct context *xfrm_ctx;
@@ -3405,7 +3417,7 @@ int selinux_audit_rule_match(u32 sid, u32 field, u32 op, void *vrule,
 		goto out;
 	}
 
-	ctxt = sidtab_search(&state->ss->sidtab, sid);
+	ctxt = sidtab_search(state->ss->sidtab, sid);
 	if (unlikely(!ctxt)) {
 		WARN_ONCE(1, "selinux_audit_rule_match: unrecognized SID %d\n",
 			  sid);
@@ -3568,7 +3580,7 @@ int security_netlbl_secattr_to_sid(struct selinux_state *state,
 				   u32 *sid)
 {
 	struct policydb *policydb = &state->ss->policydb;
-	struct sidtab *sidtab = &state->ss->sidtab;
+	struct sidtab *sidtab = state->ss->sidtab;
 	int rc;
 	struct context *ctx;
 	struct context ctx_new;
@@ -3646,7 +3658,7 @@ int security_netlbl_sid_to_secattr(struct selinux_state *state,
 	read_lock(&state->ss->policy_rwlock);
 
 	rc = -ENOENT;
-	ctx = sidtab_search(&state->ss->sidtab, sid);
+	ctx = sidtab_search(state->ss->sidtab, sid);
 	if (ctx == NULL)
 		goto out;
 
diff --git a/security/selinux/ss/services.h b/security/selinux/ss/services.h
index 24c7bdcc8075..9a36de860368 100644
--- a/security/selinux/ss/services.h
+++ b/security/selinux/ss/services.h
@@ -24,7 +24,7 @@ struct selinux_map {
 };
 
 struct selinux_ss {
-	struct sidtab sidtab;
+	struct sidtab *sidtab;
 	struct policydb policydb;
 	rwlock_t policy_rwlock;
 	u32 latest_granting;
diff --git a/security/selinux/ss/sidtab.c b/security/selinux/ss/sidtab.c
index ccc0ea230df4..45a50172f139 100644
--- a/security/selinux/ss/sidtab.c
+++ b/security/selinux/ss/sidtab.c
@@ -22,16 +22,24 @@ int sidtab_init(struct sidtab *s)
 	s->htable = kmalloc_array(SIDTAB_SIZE, sizeof(*s->htable), GFP_ATOMIC);
 	if (!s->htable)
 		return -ENOMEM;
+
+	for (i = 0; i < SECINITSID_NUM; i++)
+		s->isids[i].set = 0;
+
 	for (i = 0; i < SIDTAB_SIZE; i++)
 		s->htable[i] = NULL;
+
+	for (i = 0; i < SIDTAB_CACHE_LEN; i++)
+		s->cache[i] = NULL;
+
 	s->nel = 0;
-	s->next_sid = 1;
+	s->next_sid = 0;
 	s->shutdown = 0;
 	spin_lock_init(&s->lock);
 	return 0;
 }
 
-int sidtab_insert(struct sidtab *s, u32 sid, struct context *context)
+static int sidtab_insert(struct sidtab *s, u32 sid, struct context *context)
 {
 	int hvalue;
 	struct sidtab_node *prev, *cur, *newnode;
@@ -76,34 +84,62 @@ int sidtab_insert(struct sidtab *s, u32 sid, struct context *context)
 	return 0;
 }
 
-static struct context *sidtab_search_core(struct sidtab *s, u32 sid, int force)
+int sidtab_set_initial(struct sidtab *s, u32 sid, struct context *context)
+{
+	struct sidtab_isid_entry *entry;
+	int rc;
+
+	if (sid == 0 || sid > SECINITSID_NUM)
+		return -EINVAL;
+
+	entry = &s->isids[sid - 1];
+
+	rc = context_cpy(&entry->context, context);
+	if (rc)
+		return rc;
+
+	entry->set = 1;
+	return 0;
+}
+
+static struct context *sidtab_lookup(struct sidtab *s, u32 sid)
 {
 	int hvalue;
 	struct sidtab_node *cur;
 
-	if (!s)
-		return NULL;
-
 	hvalue = SIDTAB_HASH(sid);
 	cur = s->htable[hvalue];
 	while (cur && sid > cur->sid)
 		cur = cur->next;
 
-	if (force && cur && sid == cur->sid && cur->context.len)
-		return &cur->context;
+	if (!cur || sid != cur->sid)
+		return NULL;
 
-	if (!cur || sid != cur->sid || cur->context.len) {
-		/* Remap invalid SIDs to the unlabeled SID. */
-		sid = SECINITSID_UNLABELED;
-		hvalue = SIDTAB_HASH(sid);
-		cur = s->htable[hvalue];
-		while (cur && sid > cur->sid)
-			cur = cur->next;
-		if (!cur || sid != cur->sid)
-			return NULL;
+	return &cur->context;
+}
+
+static struct context *sidtab_lookup_initial(struct sidtab *s, u32 sid)
+{
+	return s->isids[sid - 1].set ? &s->isids[sid - 1].context : NULL;
+}
+
+static struct context *sidtab_search_core(struct sidtab *s, u32 sid, int force)
+{
+	struct context *context;
+
+	if (!s)
+		return NULL;
+
+	if (sid != 0) {
+		if (sid > SECINITSID_NUM)
+			context = sidtab_lookup(s, sid - (SECINITSID_NUM + 1));
+		else
+			context = sidtab_lookup_initial(s, sid);
+		if (context && (!context->len || force))
+			return context;
 	}
 
-	return &cur->context;
+	return sidtab_lookup_initial(s, SECINITSID_UNLABELED);
 }
 
 struct context *sidtab_search(struct sidtab *s, u32 sid)
@@ -145,11 +181,7 @@ out:
 static int clone_sid(u32 sid, struct context *context, void *arg)
 {
 	struct sidtab *s = arg;
-
-	if (sid > SECINITSID_NUM)
-		return sidtab_insert(s, sid, context);
-	else
-		return 0;
+	return sidtab_insert(s, sid, context);
 }
 
 int sidtab_convert(struct sidtab *s, struct sidtab *news,
@@ -183,8 +215,8 @@ static void sidtab_update_cache(struct sidtab *s, struct sidtab_node *n, int loc
 	s->cache[0] = n;
 }
 
-static inline u32 sidtab_search_context(struct sidtab *s,
-						  struct context *context)
+static inline int sidtab_search_context(struct sidtab *s,
+					struct context *context, u32 *sid)
 {
 	int i;
 	struct sidtab_node *cur;
@@ -194,15 +226,17 @@ static inline u32 sidtab_search_context(struct sidtab *s,
 		while (cur) {
 			if (context_cmp(&cur->context, context)) {
 				sidtab_update_cache(s, cur, SIDTAB_CACHE_LEN - 1);
-				return cur->sid;
+				*sid = cur->sid;
+				return 0;
 			}
 			cur = cur->next;
 		}
 	}
-	return 0;
+	return -ENOENT;
 }
 
-static inline u32 sidtab_search_cache(struct sidtab *s, struct context *context)
+static inline int sidtab_search_cache(struct sidtab *s, struct context *context,
+				      u32 *sid)
 {
 	int i;
 	struct sidtab_node *node;
@@ -210,54 +244,68 @@ static inline u32 sidtab_search_cache(struct sidtab *s, struct context *context)
 	for (i = 0; i < SIDTAB_CACHE_LEN; i++) {
 		node = s->cache[i];
 		if (unlikely(!node))
-			return 0;
+			return -ENOENT;
 		if (context_cmp(&node->context, context)) {
 			sidtab_update_cache(s, node, i);
-			return node->sid;
+			*sid = node->sid;
+			return 0;
 		}
 	}
-	return 0;
+	return -ENOENT;
 }
 
-int sidtab_context_to_sid(struct sidtab *s,
-			  struct context *context,
-			  u32 *out_sid)
+static int sidtab_reverse_lookup(struct sidtab *s, struct context *context,
+				 u32 *sid)
 {
-	u32 sid;
-	int ret = 0;
+	int ret;
 	unsigned long flags;
 
-	*out_sid = SECSID_NULL;
-
-	sid  = sidtab_search_cache(s, context);
-	if (!sid)
-		sid = sidtab_search_context(s, context);
-	if (!sid) {
+	ret = sidtab_search_cache(s, context, sid);
+	if (ret)
+		ret = sidtab_search_context(s, context, sid);
+	if (ret) {
 		spin_lock_irqsave(&s->lock, flags);
 		/* Rescan now that we hold the lock. */
-		sid = sidtab_search_context(s, context);
-		if (sid)
+		ret = sidtab_search_context(s, context, sid);
+		if (!ret)
 			goto unlock_out;
 		/* No SID exists for the context.  Allocate a new one. */
-		if (s->next_sid == UINT_MAX || s->shutdown) {
+		if (s->next_sid == (UINT_MAX - SECINITSID_NUM - 1) || s->shutdown) {
 			ret = -ENOMEM;
 			goto unlock_out;
 		}
-		sid = s->next_sid++;
+		*sid = s->next_sid++;
 		if (context->len)
 			pr_info("SELinux:  Context %s is not valid (left unmapped).\n",
 			       context->str);
-		ret = sidtab_insert(s, sid, context);
+		ret = sidtab_insert(s, *sid, context);
 		if (ret)
 			s->next_sid--;
 unlock_out:
 		spin_unlock_irqrestore(&s->lock, flags);
 	}
 
-	if (ret)
-		return ret;
+	return ret;
+}
+
+int sidtab_context_to_sid(struct sidtab *s, struct context *context, u32 *sid)
+{
+	int rc;
+	u32 i;
 
-	*out_sid = sid;
+	for (i = 0; i < SECINITSID_NUM; i++) {
+		struct sidtab_isid_entry *entry = &s->isids[i];
+
+		if (entry->set && context_cmp(context, &entry->context)) {
+			*sid = i + 1;
+			return 0;
+		}
+	}
+
+	rc = sidtab_reverse_lookup(s, context, sid);
+	if (rc)
+		return rc;
+	*sid += SECINITSID_NUM + 1;
 	return 0;
 }
 
@@ -296,6 +344,11 @@ void sidtab_destroy(struct sidtab *s)
 	if (!s)
 		return;
 
+	for (i = 0; i < SECINITSID_NUM; i++)
+		if (s->isids[i].set)
+			context_destroy(&s->isids[i].context);
+
+
 	for (i = 0; i < SIDTAB_SIZE; i++) {
 		cur = s->htable[i];
 		while (cur) {
@@ -311,18 +364,3 @@ void sidtab_destroy(struct sidtab *s)
 	s->nel = 0;
 	s->next_sid = 1;
 }
-
-void sidtab_set(struct sidtab *dst, struct sidtab *src)
-{
-	unsigned long flags;
-	int i;
-
-	spin_lock_irqsave(&src->lock, flags);
-	dst->htable = src->htable;
-	dst->nel = src->nel;
-	dst->next_sid = src->next_sid;
-	dst->shutdown = 0;
-	for (i = 0; i < SIDTAB_CACHE_LEN; i++)
-		dst->cache[i] = NULL;
-	spin_unlock_irqrestore(&src->lock, flags);
-}
diff --git a/security/selinux/ss/sidtab.h b/security/selinux/ss/sidtab.h
index e1d1f0beb17c..e657ae6bf996 100644
--- a/security/selinux/ss/sidtab.h
+++ b/security/selinux/ss/sidtab.h
@@ -22,6 +22,11 @@ struct sidtab_node {
 
 #define SIDTAB_SIZE SIDTAB_HASH_BUCKETS
 
+struct sidtab_isid_entry {
+	int set;
+	struct context context;
+};
+
 struct sidtab {
 	struct sidtab_node **htable;
 	unsigned int nel;	/* number of elements */
@@ -30,10 +35,13 @@ struct sidtab {
 #define SIDTAB_CACHE_LEN	3
 	struct sidtab_node *cache[SIDTAB_CACHE_LEN];
 	spinlock_t lock;
+
+	/* index == SID - 1 (no entry for SECSID_NULL) */
+	struct sidtab_isid_entry isids[SECINITSID_NUM];
 };
 
 int sidtab_init(struct sidtab *s);
-int sidtab_insert(struct sidtab *s, u32 sid, struct context *context);
+int sidtab_set_initial(struct sidtab *s, u32 sid, struct context *context);
 struct context *sidtab_search(struct sidtab *s, u32 sid);
 struct context *sidtab_search_force(struct sidtab *s, u32 sid);
 
@@ -43,13 +51,10 @@ int sidtab_convert(struct sidtab *s, struct sidtab *news,
 				void *args),
 		   void *args);
 
-int sidtab_context_to_sid(struct sidtab *s,
-			  struct context *context,
-			  u32 *sid);
+int sidtab_context_to_sid(struct sidtab *s, struct context *context, u32 *sid);
 
 void sidtab_hash_eval(struct sidtab *h, char *tag);
 void sidtab_destroy(struct sidtab *s);
-void sidtab_set(struct sidtab *dst, struct sidtab *src);
 
 #endif	/* _SS_SIDTAB_H_ */
 
-- 
2.19.2

