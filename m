Return-Path: <SRS0=r6Mn=CE=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3530CC433E1
	for <selinux@archiver.kernel.org>; Wed, 26 Aug 2020 14:05:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1059221775
	for <selinux@archiver.kernel.org>; Wed, 26 Aug 2020 14:05:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KJL7XzxI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726514AbgHZOFZ (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 26 Aug 2020 10:05:25 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:60529 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726187AbgHZOFV (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 26 Aug 2020 10:05:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1598450719;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=l655GAyOHBeTwpCXtasjAikdbXD6mqUcm1R/KoxGFRY=;
        b=KJL7XzxIGx1f9Ywxqf3CozzuV3KC6lhd/5DUywc62MEHZmybvEB+o1RKL/BXsLXtioJu8i
        VifoFp8hTOeCk2UTZFcNDaVhVca05wWvCYEmAvuDKJ0b2SO/lL2TFW2ePFf2H8zos0omq4
        xVY6Uome4tDpcxEZXorjGM40zScPcAM=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-421-P-b8DKVyNbqOF2l_zroiUQ-1; Wed, 26 Aug 2020 09:59:12 -0400
X-MC-Unique: P-b8DKVyNbqOF2l_zroiUQ-1
Received: by mail-wm1-f69.google.com with SMTP id f125so813766wma.3
        for <selinux@vger.kernel.org>; Wed, 26 Aug 2020 06:59:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=l655GAyOHBeTwpCXtasjAikdbXD6mqUcm1R/KoxGFRY=;
        b=ATv5kyReRgw4sYa9OIHATZpWHm/ugHctMCM+JVKAp301Z5+BvX84wgKDi9KbVm4jV/
         QpdFmHRfJNm/uVBuFs2hxPg0oL0qC2VLfjfCBYsTV+0LjfjS69OfNriGSz21P6zD0Fmn
         i+7LOvfhupmYJkR4ZbXW1tXtsm0tPySqKGQuSAHo8+p3of5rFH4ePc7ZFhEyY2FTDHPj
         ArmU7Wc86lQuBwDkAZrkH0MWGpZ1+l7GgmY2wGrJjm0HRNhDvdg+bVVab6D4Zf4wJXPR
         0P35EDsG7MOUvq+JCR9h5/1jwHpqsJvXbP0tVs6UbQBluRBPpcsNH4wG9OyShU+aZ6Ej
         y8gQ==
X-Gm-Message-State: AOAM532i9FCXUA0jzEl3CE+meBs1zGutx7PMpJzOZYLYHgoi8O7HFE1H
        T9REtL+TMzSp0p7vASdZCLoYtUEzRMZFjSceEEfTl54+eTGsW/gPby8yQMtabUMP5bWHZiu2H8S
        +Ef5pmuJzpcLpZlHWwQ==
X-Received: by 2002:a1c:7c0d:: with SMTP id x13mr7002780wmc.14.1598450351201;
        Wed, 26 Aug 2020 06:59:11 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzYmh5Vlj6euprpTFSDwOJuMI8kABwjevNrabVqh3H+bX1LbeSKpIPqL4WUmay8QavSdWV2KA==
X-Received: by 2002:a1c:7c0d:: with SMTP id x13mr7002754wmc.14.1598450350871;
        Wed, 26 Aug 2020 06:59:10 -0700 (PDT)
Received: from omos.redhat.com ([2a02:8308:b103:4000:e83d:a4fb:e589:6902])
        by smtp.gmail.com with ESMTPSA id y24sm5622325wmi.17.2020.08.26.06.59.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Aug 2020 06:59:10 -0700 (PDT)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     selinux@vger.kernel.org, Paul Moore <paul@paul-moore.com>
Cc:     Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH v2 3/3] selinux: remove the 'initialized' flag from selinux_state
Date:   Wed, 26 Aug 2020 15:59:06 +0200
Message-Id: <20200826135906.1912186-4-omosnace@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200826135906.1912186-1-omosnace@redhat.com>
References: <20200826135906.1912186-1-omosnace@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

After the RCU conversion, it is possible to simply check the policy
pointer against NULL instead.

Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
---
 security/selinux/include/security.h | 10 +---------
 security/selinux/ss/services.c      | 26 ++++++++++----------------
 2 files changed, 11 insertions(+), 25 deletions(-)

diff --git a/security/selinux/include/security.h b/security/selinux/include/security.h
index 9ab8f8da47812..714c389cc72a0 100644
--- a/security/selinux/include/security.h
+++ b/security/selinux/include/security.h
@@ -95,7 +95,6 @@ struct selinux_state {
 	bool enforcing;
 #endif
 	bool checkreqprot;
-	bool initialized;
 
 	struct page *status_page;
 	struct mutex status_lock;
@@ -110,14 +109,7 @@ extern struct selinux_state selinux_state;
 
 static inline bool selinux_initialized(const struct selinux_state *state)
 {
-	/* do a synchronized load to avoid race conditions */
-	return smp_load_acquire(&state->initialized);
-}
-
-static inline void selinux_mark_initialized(struct selinux_state *state)
-{
-	/* do a synchronized write to avoid race conditions */
-	smp_store_release(&state->initialized, true);
+	return rcu_access_pointer(state->policy) != NULL;
 }
 
 #ifdef CONFIG_SECURITY_SELINUX_DEVELOP
diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
index e82a2cfe171f3..112ca3d9834d7 100644
--- a/security/selinux/ss/services.c
+++ b/security/selinux/ss/services.c
@@ -2118,9 +2118,6 @@ static int security_preserve_bools(struct selinux_policy *oldpolicy,
 
 static void selinux_policy_free(struct selinux_policy *policy)
 {
-	if (!policy)
-		return;
-
 	policydb_destroy(&policy->policydb);
 	sidtab_destroy(policy->sidtab);
 	kfree(policy->sidtab);
@@ -2194,20 +2191,19 @@ void selinux_policy_commit(struct selinux_state *state,
 	/* Install the new policy. */
 	rcu_assign_pointer(state->policy, newpolicy);
 
-	if (!selinux_initialized(state)) {
+	if (!oldpolicy) {
 		/*
 		 * After first policy load, the security server is
 		 * marked as initialized and ready to handle requests and
 		 * any objects created prior to policy load are then labeled.
 		 */
-		selinux_mark_initialized(state);
 		selinux_complete_init();
+	} else {
+		/* Free the old policy */
+		synchronize_rcu();
+		selinux_policy_free(oldpolicy);
 	}
 
-	/* Free the old policy */
-	synchronize_rcu();
-	selinux_policy_free(oldpolicy);
-
 	/* Notify others of the policy change */
 	selinux_notify_policy_change(state, seqno);
 }
@@ -2255,13 +2251,6 @@ int security_load_policy(struct selinux_state *state, void *data, size_t len,
 		goto err;
 	}
 
-
-	if (!selinux_initialized(state)) {
-		/* First policy load, so no need to preserve state from old policy */
-		*newpolicyp = newpolicy;
-		return 0;
-	}
-
 	/*
 	 * NOTE: We do not need to take the rcu read lock
 	 * around the code below because other policy-modifying
@@ -2269,6 +2258,11 @@ int security_load_policy(struct selinux_state *state, void *data, size_t len,
 	 * fsi->mutex.
 	 */
 	oldpolicy = rcu_dereference_check(state->policy, 1);
+	if (!oldpolicy) {
+		/* First policy load, so no need to preserve state from old policy */
+		*newpolicyp = newpolicy;
+		return 0;
+	}
 
 	/* Preserve active boolean values from the old policy */
 	rc = security_preserve_bools(oldpolicy, newpolicy);
-- 
2.26.2

