Return-Path: <SRS0=v2nJ=B5=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2924CC433E1
	for <selinux@archiver.kernel.org>; Wed, 19 Aug 2020 13:46:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EC188204FD
	for <selinux@archiver.kernel.org>; Wed, 19 Aug 2020 13:46:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CZezxBo9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727022AbgHSNqH (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 19 Aug 2020 09:46:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728668AbgHSNp6 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 19 Aug 2020 09:45:58 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63B15C061757
        for <selinux@vger.kernel.org>; Wed, 19 Aug 2020 06:45:58 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id i20so7369057qkk.8
        for <selinux@vger.kernel.org>; Wed, 19 Aug 2020 06:45:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VK7I7vwY8eEzyRcrKMPChj0wBCw9e6DCulIhJRPk9RQ=;
        b=CZezxBo98C50sxLeIdPeN1yePggEWEiLuFAX1h4e4ZpTx89q/hlbfBorq1JneoNX2h
         zdv5pEJJCYfJnnxr1+sIrQ2rUkafFBlfBdz0gPNiJatttEd4HJIQsq+OkseSijFBQFIJ
         5R3+79ZXCWrL96OKlqDRfe5Wli01nxszhmCofOk6uLh44vRrv3ImlFFdeTWuhohniqLS
         NRJgWKemliYPRvHsdoMymd/yPyNh85qbx9uQdif9bvjsBab/XJsEOOA7M7Zdu7YK9jPz
         8rSnrVXFHNuqAyacL60UrkvWHpHdEwTsdWXt6cVivCA7m17Y2EoqCQv70whbGrgUqAQ2
         LuIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VK7I7vwY8eEzyRcrKMPChj0wBCw9e6DCulIhJRPk9RQ=;
        b=N+ZAOqtMSTO2sVC8IN/2hZAgF6sQ27LsI1X7uDuvPEX3HEdQaI9UeCle+xbgEFD1Gu
         Kt6PYk5LMH4kBaVUGYSSTfTNMn96ICK8Q74tqQBEUuEemijyzOiD9KfB/sWNbCE3hEEx
         vPXCgeJ59Lp4WxnYrVxGc2FoCYpihpRRSHZEK5gsNU6zmuC9sJOpR1db2laEBmj9wto0
         GjC7y2drqbil2rPm1Pixe/Wnc+XCVgbLKxKvjOqvQmWqzIzou1LBvAUC0UYMESJ7cOEx
         +BgW2r0dEOo0ZN/1Fc/l+HqGQRBOXFJWOVcVaa2onrEeFG6J5G346hrJWhnalS+EC3kF
         ELYQ==
X-Gm-Message-State: AOAM533CxcpDG79yyoKb7YAwKc5b+6837bC5hWBTRIgq8OFn4VeLbTm1
        r04vP+SsJWeo7jHr4rlLPG0=
X-Google-Smtp-Source: ABdhPJxZI9vjZwLynqyIEJ4SlIdQ3xFO8PKt+lmw1TSi6k5SktdnavDdoM7w+/2JTpLdNAFq7YMUVA==
X-Received: by 2002:ae9:ef8d:: with SMTP id d135mr21781660qkg.477.1597844757241;
        Wed, 19 Aug 2020 06:45:57 -0700 (PDT)
Received: from puritycontrol.fios-router.home (pool-68-134-6-11.bltmmd.fios.verizon.net. [68.134.6.11])
        by smtp.gmail.com with ESMTPSA id t187sm24348529qka.26.2020.08.19.06.45.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Aug 2020 06:45:56 -0700 (PDT)
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
To:     paul@paul-moore.com, omosnace@redhat.com
Cc:     selinux@vger.kernel.org, naresh.kamboju@linaro.org,
        Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH] selinux: avoid dereferencing the policy prior to initialization
Date:   Wed, 19 Aug 2020 09:45:41 -0400
Message-Id: <20200819134541.41136-1-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Certain SELinux security server functions (e.g. security_port_sid,
called during bind) were not explicitly testing to see if SELinux
has been initialized (i.e. initial policy loaded) and handling
the no-policy-loaded case.  In the past this happened to work
because the policydb was statically allocated and could always
be accessed, but with the recent encapsulation of policy state
and conversion to dynamic allocation, we can no longer access
the policy state prior to initialization.  Add a test of
!selinux_initialized(state) to all of the exported functions that
were missing them and handle appropriately.

Fixes: 461698026ffa ("selinux: encapsulate policy state, refactor policy load")
Reported-by: Naresh Kamboju <naresh.kamboju@linaro.org>
Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
 security/selinux/ss/services.c | 60 ++++++++++++++++++++++++++++++++++
 1 file changed, 60 insertions(+)

diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
index f6f78c65f53f..b3b610a58096 100644
--- a/security/selinux/ss/services.c
+++ b/security/selinux/ss/services.c
@@ -2293,6 +2293,9 @@ size_t security_policydb_len(struct selinux_state *state)
 {
 	size_t len;
 
+	if (!selinux_initialized(state))
+		return 0;
+
 	read_lock(&state->ss->policy_rwlock);
 	len = state->ss->policy->policydb.len;
 	read_unlock(&state->ss->policy_rwlock);
@@ -2314,6 +2317,11 @@ int security_port_sid(struct selinux_state *state,
 	struct ocontext *c;
 	int rc = 0;
 
+	if (!selinux_initialized(state)) {
+		*out_sid = SECINITSID_PORT;
+		return 0;
+	}
+
 	read_lock(&state->ss->policy_rwlock);
 
 	policydb = &state->ss->policy->policydb;
@@ -2359,6 +2367,11 @@ int security_ib_pkey_sid(struct selinux_state *state,
 	struct ocontext *c;
 	int rc = 0;
 
+	if (!selinux_initialized(state)) {
+		*out_sid = SECINITSID_UNLABELED;
+		return 0;
+	}
+
 	read_lock(&state->ss->policy_rwlock);
 
 	policydb = &state->ss->policy->policydb;
@@ -2405,6 +2418,11 @@ int security_ib_endport_sid(struct selinux_state *state,
 	struct ocontext *c;
 	int rc = 0;
 
+	if (!selinux_initialized(state)) {
+		*out_sid = SECINITSID_UNLABELED;
+		return 0;
+	}
+
 	read_lock(&state->ss->policy_rwlock);
 
 	policydb = &state->ss->policy->policydb;
@@ -2450,6 +2468,11 @@ int security_netif_sid(struct selinux_state *state,
 	int rc = 0;
 	struct ocontext *c;
 
+	if (!selinux_initialized(state)) {
+		*if_sid = SECINITSID_NETIF;
+		return 0;
+	}
+
 	read_lock(&state->ss->policy_rwlock);
 
 	policydb = &state->ss->policy->policydb;
@@ -2513,6 +2536,11 @@ int security_node_sid(struct selinux_state *state,
 	int rc;
 	struct ocontext *c;
 
+	if (!selinux_initialized(state)) {
+		*out_sid = SECINITSID_NODE;
+		return 0;
+	}
+
 	read_lock(&state->ss->policy_rwlock);
 
 	policydb = &state->ss->policy->policydb;
@@ -2780,6 +2808,11 @@ int security_genfs_sid(struct selinux_state *state,
 {
 	int retval;
 
+	if (!selinux_initialized(state)) {
+		*sid = SECINITSID_UNLABELED;
+		return 0;
+	}
+
 	read_lock(&state->ss->policy_rwlock);
 	retval = __security_genfs_sid(state->ss->policy,
 				fstype, path, orig_sclass, sid);
@@ -2810,6 +2843,12 @@ int security_fs_use(struct selinux_state *state, struct super_block *sb)
 	struct superblock_security_struct *sbsec = sb->s_security;
 	const char *fstype = sb->s_type->name;
 
+	if (!selinux_initialized(state)) {
+		sbsec->behavior = SECURITY_FS_USE_NONE;
+		sbsec->sid = SECINITSID_UNLABELED;
+		return 0;
+	}
+
 	read_lock(&state->ss->policy_rwlock);
 
 	policydb = &state->ss->policy->policydb;
@@ -2906,6 +2945,9 @@ int security_set_bools(struct selinux_state *state, u32 len, int *values)
 	int rc;
 	u32 i, seqno = 0;
 
+	if (!selinux_initialized(state))
+		return -EINVAL;
+
 	/*
 	 * NOTE: We do not need to take the policy read-lock
 	 * around the code below because other policy-modifying
@@ -2982,6 +3024,9 @@ int security_get_bool_value(struct selinux_state *state,
 	int rc;
 	u32 len;
 
+	if (!selinux_initialized(state))
+		return 0;
+
 	read_lock(&state->ss->policy_rwlock);
 
 	policydb = &state->ss->policy->policydb;
@@ -3161,6 +3206,9 @@ int security_net_peersid_resolve(struct selinux_state *state,
 		return 0;
 	}
 
+	if (!selinux_initialized(state))
+		return 0;
+
 	read_lock(&state->ss->policy_rwlock);
 
 	policydb = &state->ss->policy->policydb;
@@ -3307,6 +3355,9 @@ int security_get_reject_unknown(struct selinux_state *state)
 {
 	int value;
 
+	if (!selinux_initialized(state))
+		return 0;
+
 	read_lock(&state->ss->policy_rwlock);
 	value = state->ss->policy->policydb.reject_unknown;
 	read_unlock(&state->ss->policy_rwlock);
@@ -3317,6 +3368,9 @@ int security_get_allow_unknown(struct selinux_state *state)
 {
 	int value;
 
+	if (!selinux_initialized(state))
+		return 0;
+
 	read_lock(&state->ss->policy_rwlock);
 	value = state->ss->policy->policydb.allow_unknown;
 	read_unlock(&state->ss->policy_rwlock);
@@ -3338,6 +3392,9 @@ int security_policycap_supported(struct selinux_state *state,
 {
 	int rc;
 
+	if (!selinux_initialized(state))
+		return 0;
+
 	read_lock(&state->ss->policy_rwlock);
 	rc = ebitmap_get_bit(&state->ss->policy->policydb.policycaps, req_cap);
 	read_unlock(&state->ss->policy_rwlock);
@@ -3499,6 +3556,9 @@ int selinux_audit_rule_match(u32 sid, u32 field, u32 op, void *vrule)
 		return -ENOENT;
 	}
 
+	if (!selinux_initialized(state))
+		return 0;
+
 	read_lock(&state->ss->policy_rwlock);
 
 	if (rule->au_seqno < state->ss->latest_granting) {
-- 
2.25.1

