Return-Path: <SRS0=r6Mn=CE=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BE00C433DF
	for <selinux@archiver.kernel.org>; Wed, 26 Aug 2020 14:05:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E3AFB2075E
	for <selinux@archiver.kernel.org>; Wed, 26 Aug 2020 14:05:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QnaX7iZn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726700AbgHZOFX (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 26 Aug 2020 10:05:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:39298 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726753AbgHZOFV (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 26 Aug 2020 10:05:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1598450719;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8I1FDq5khX2w4its7kMgBnLds7+BJaMx39bHYbGDc7Q=;
        b=QnaX7iZnGTihdB+jA8IbwrWBUxf61KqOzc82ejIKKZ7SAc0mITVD/SkZDUKMbbjRcvg0yD
        AFBwRt/MDw+YSL+fwrSf7VESNT6Ay63BgkoYMGX5K0JNVPzIHZNnYKPEauhq14D6tgZ7SR
        NjmXVhoSAnLoQAk/PZ64ZGHzXbFpkdY=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-87-WOgzRS6oP-uDVb_BWwDloA-1; Wed, 26 Aug 2020 09:59:11 -0400
X-MC-Unique: WOgzRS6oP-uDVb_BWwDloA-1
Received: by mail-wm1-f71.google.com with SMTP id d22so802493wmd.2
        for <selinux@vger.kernel.org>; Wed, 26 Aug 2020 06:59:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8I1FDq5khX2w4its7kMgBnLds7+BJaMx39bHYbGDc7Q=;
        b=cdt165MAcXNc2GKpFFJpWzgoOidd7QRbdmPSnNka1D9e+tBYsuxqEx+Rs2x7RovboB
         x/C8oUFde+dIpnVJ0JhtmjVel/RwmwL94HeP3RAdH/U146mrmp48Sl0kq7VWXbfDF7SL
         4h9onAr5gY+ZI/7vlbFDJ3hY/vVQma3k1bv1MFLcF7wcRF9Zv0sKduki2I5e4oAuBVT3
         M7ZbM23OSYq4LtHpcTdp7WNJgPCn4iGQ8TopoJgaR/IrUH0YLckXLpLxyNJWYl4Aputv
         wO7y59U2aSW8rBLMM3+LSb0cYCWNHLbV1oCqW3ytveOQZEy6cEu9HvunIP7CnLLLjEq9
         3nsw==
X-Gm-Message-State: AOAM532EAlmVEJzMOS/ZSma4uK2HnfZqwcSM/w6SHPUwJBO7GkP6RNLk
        iSWc6ooE6eMJcKQgM2l7akmPdKY1jlLiwAeV3s6KE7zbSPWhQ/vRchv3d7kk+6nWGIutnVrqSZ1
        hZphAdHaTzTviBGbkvQ==
X-Received: by 2002:a1c:dd85:: with SMTP id u127mr7669983wmg.65.1598450349932;
        Wed, 26 Aug 2020 06:59:09 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzbGM15Url2QLnlSlqk7h9+cfr8kdkFuWpOw6G0qFnXiz7UnU8y221Ze4SbNft0vy21k8SRDA==
X-Received: by 2002:a1c:dd85:: with SMTP id u127mr7669960wmg.65.1598450349674;
        Wed, 26 Aug 2020 06:59:09 -0700 (PDT)
Received: from omos.redhat.com ([2a02:8308:b103:4000:e83d:a4fb:e589:6902])
        by smtp.gmail.com with ESMTPSA id y24sm5622325wmi.17.2020.08.26.06.59.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Aug 2020 06:59:09 -0700 (PDT)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     selinux@vger.kernel.org, Paul Moore <paul@paul-moore.com>
Cc:     Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH v2 2/3] selinux: eliminate the redundant policycap array
Date:   Wed, 26 Aug 2020 15:59:05 +0200
Message-Id: <20200826135906.1912186-3-omosnace@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200826135906.1912186-1-omosnace@redhat.com>
References: <20200826135906.1912186-1-omosnace@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

The policycap array in struct selinux_state is redundant and can be
substituted by calling security_policycap_supported().

Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
---
 security/selinux/include/security.h | 42 ++++++++++++-----------------
 security/selinux/ss/services.c      | 27 -------------------
 2 files changed, 17 insertions(+), 52 deletions(-)

diff --git a/security/selinux/include/security.h b/security/selinux/include/security.h
index 839774929a10d..9ab8f8da47812 100644
--- a/security/selinux/include/security.h
+++ b/security/selinux/include/security.h
@@ -96,7 +96,6 @@ struct selinux_state {
 #endif
 	bool checkreqprot;
 	bool initialized;
-	bool policycap[__POLICYDB_CAPABILITY_MAX];
 
 	struct page *status_page;
 	struct mutex status_lock;
@@ -159,53 +158,49 @@ static inline bool selinux_disabled(struct selinux_state *state)
 }
 #endif
 
+int security_policycap_supported(struct selinux_state *state,
+				 unsigned int req_cap);
+
 static inline bool selinux_policycap_netpeer(void)
 {
-	struct selinux_state *state = &selinux_state;
-
-	return state->policycap[POLICYDB_CAPABILITY_NETPEER];
+	return security_policycap_supported(&selinux_state,
+					    POLICYDB_CAPABILITY_NETPEER);
 }
 
 static inline bool selinux_policycap_openperm(void)
 {
-	struct selinux_state *state = &selinux_state;
-
-	return state->policycap[POLICYDB_CAPABILITY_OPENPERM];
+	return security_policycap_supported(&selinux_state,
+					    POLICYDB_CAPABILITY_OPENPERM);
 }
 
 static inline bool selinux_policycap_extsockclass(void)
 {
-	struct selinux_state *state = &selinux_state;
-
-	return state->policycap[POLICYDB_CAPABILITY_EXTSOCKCLASS];
+	return security_policycap_supported(&selinux_state,
+					    POLICYDB_CAPABILITY_EXTSOCKCLASS);
 }
 
 static inline bool selinux_policycap_alwaysnetwork(void)
 {
-	struct selinux_state *state = &selinux_state;
-
-	return state->policycap[POLICYDB_CAPABILITY_ALWAYSNETWORK];
+	return security_policycap_supported(&selinux_state,
+					    POLICYDB_CAPABILITY_ALWAYSNETWORK);
 }
 
 static inline bool selinux_policycap_cgroupseclabel(void)
 {
-	struct selinux_state *state = &selinux_state;
-
-	return state->policycap[POLICYDB_CAPABILITY_CGROUPSECLABEL];
+	return security_policycap_supported(&selinux_state,
+					    POLICYDB_CAPABILITY_CGROUPSECLABEL);
 }
 
 static inline bool selinux_policycap_nnp_nosuid_transition(void)
 {
-	struct selinux_state *state = &selinux_state;
-
-	return state->policycap[POLICYDB_CAPABILITY_NNP_NOSUID_TRANSITION];
+	return security_policycap_supported(&selinux_state,
+					    POLICYDB_CAPABILITY_NNP_NOSUID_TRANSITION);
 }
 
 static inline bool selinux_policycap_genfs_seclabel_symlinks(void)
 {
-	struct selinux_state *state = &selinux_state;
-
-	return state->policycap[POLICYDB_CAPABILITY_GENFS_SECLABEL_SYMLINKS];
+	return security_policycap_supported(&selinux_state,
+					    POLICYDB_CAPABILITY_GENFS_SECLABEL_SYMLINKS);
 }
 
 int security_mls_enabled(struct selinux_state *state);
@@ -219,9 +214,6 @@ void selinux_policy_cancel(struct selinux_state *state,
 int security_read_policy(struct selinux_state *state,
 			 void **data, size_t *len);
 
-int security_policycap_supported(struct selinux_state *state,
-				 unsigned int req_cap);
-
 #define SEL_VEC_MAX 32
 struct av_decision {
 	u32 allowed;
diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
index 7cc2f7486c18f..e82a2cfe171f3 100644
--- a/security/selinux/ss/services.c
+++ b/security/selinux/ss/services.c
@@ -2113,30 +2113,6 @@ bad:
 	return 0;
 }
 
-static void security_load_policycaps(struct selinux_state *state,
-				struct selinux_policy *policy)
-{
-	struct policydb *p;
-	unsigned int i;
-	struct ebitmap_node *node;
-
-	p = &policy->policydb;
-
-	for (i = 0; i < ARRAY_SIZE(state->policycap); i++)
-		state->policycap[i] = ebitmap_get_bit(&p->policycaps, i);
-
-	for (i = 0; i < ARRAY_SIZE(selinux_policycap_names); i++)
-		pr_info("SELinux:  policy capability %s=%d\n",
-			selinux_policycap_names[i],
-			ebitmap_get_bit(&p->policycaps, i));
-
-	ebitmap_for_each_positive_bit(&p->policycaps, node, i) {
-		if (i >= ARRAY_SIZE(selinux_policycap_names))
-			pr_info("SELinux:  unknown policy capability %u\n",
-				i);
-	}
-}
-
 static int security_preserve_bools(struct selinux_policy *oldpolicy,
 				struct selinux_policy *newpolicy);
 
@@ -2218,9 +2194,6 @@ void selinux_policy_commit(struct selinux_state *state,
 	/* Install the new policy. */
 	rcu_assign_pointer(state->policy, newpolicy);
 
-	/* Load the policycaps from the new policy */
-	security_load_policycaps(state, newpolicy);
-
 	if (!selinux_initialized(state)) {
 		/*
 		 * After first policy load, the security server is
-- 
2.26.2

