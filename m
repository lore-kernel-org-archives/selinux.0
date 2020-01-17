Return-Path: <SRS0=ftCu=3G=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0828C33CB1
	for <selinux@archiver.kernel.org>; Fri, 17 Jan 2020 08:58:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B33F92072B
	for <selinux@archiver.kernel.org>; Fri, 17 Jan 2020 08:58:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QluMUZxA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729451AbgAQI6r (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 17 Jan 2020 03:58:47 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:32108 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729144AbgAQI6r (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 17 Jan 2020 03:58:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1579251526;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BV+b/JM1TawckUWa4ei0v6xN0KrVd4heK2kZffGLI4I=;
        b=QluMUZxAWeUneq3GMT1fUUt5oZW9dbsxo5aZ2Y+VL4UH+vNjFU5ENEBc5J2/uFm2mAfogY
        RdQiQ4UUq01zQ6q0mXRcVBYWc6f+NgiuSdwAi/z1RzY3wyqm4LUT8NTn3rwanK2I8s6H9L
        0lgo3sCwodZ61YgTPX05qlSQawaE6xI=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-398-XCJg3UAVOweuz8oaTNQLcw-1; Fri, 17 Jan 2020 03:58:45 -0500
X-MC-Unique: XCJg3UAVOweuz8oaTNQLcw-1
Received: by mail-wr1-f71.google.com with SMTP id u12so10272658wrt.15
        for <selinux@vger.kernel.org>; Fri, 17 Jan 2020 00:58:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BV+b/JM1TawckUWa4ei0v6xN0KrVd4heK2kZffGLI4I=;
        b=W1CmKa77Gf1I06XbDxl8Vh70M46vYYRaJ1CFJPXAc32AzqFDocjLHxY+iNS9F4duJa
         r6mPTL50kza/FVoXviBEflby1X2m4t8T13KwboAwBLZWgl0wjJkB6DdeFfSEqRb8KxR1
         qdhUp09dyVAe0RPM53j+7Q11SywL8SX96lENmm9sG4ixyIorj1qNXLBxgVmeaCYmU+i9
         qpwhz7ZfdhJ3/tvoIFdlfCPuWBH5sKRKSzWL2OpRMEpxWpd0VuD2mIE2bxA8k4D7HqOv
         zeO8JKCeeifUz42lmZV2U0f0+4+P13FCMQVZWCGxHgtxh3rqUt09P9RL+J6nQ1M0KyS8
         q9kg==
X-Gm-Message-State: APjAAAVAK6ZMcAxRqbJ0pHSvXvgYhOMHMl+YPc7/ABI29p/hSRXkL9qr
        us7u/pR5HLBcyYp4fEAa7MfSPVlo5sVahcsc4BaL3kzDR5nXbpubdyJnwwbYDT4qIZnDVn9x1fj
        3uGOGnsawZniaSWAsRw==
X-Received: by 2002:a7b:c851:: with SMTP id c17mr3377843wml.71.1579251523663;
        Fri, 17 Jan 2020 00:58:43 -0800 (PST)
X-Google-Smtp-Source: APXvYqwqYbo3vulC7PBlXtb8d3NEz4+QQpdGiWBTscLRpEgcaG24k5Gp4/wrLcxpH0XUvrDO7/bfbA==
X-Received: by 2002:a7b:c851:: with SMTP id c17mr3377828wml.71.1579251523474;
        Fri, 17 Jan 2020 00:58:43 -0800 (PST)
Received: from omos.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id x18sm33391312wrr.75.2020.01.17.00.58.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jan 2020 00:58:43 -0800 (PST)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     selinux@vger.kernel.org, Paul Moore <paul@paul-moore.com>
Cc:     Stephen Smalley <sds@tycho.nsa.gov>
Subject: [PATCH v2 5/5] selinux: generalize evaluate_cond_node()
Date:   Fri, 17 Jan 2020 09:58:36 +0100
Message-Id: <20200117085836.445797-6-omosnace@redhat.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200117085836.445797-1-omosnace@redhat.com>
References: <20200117085836.445797-1-omosnace@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Both callers iterate the cond_list and call it for each node - turn it
into evaluate_cond_nodes(), which does the iteration for them.

Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
---
 security/selinux/ss/conditional.c | 10 +++++++++-
 security/selinux/ss/conditional.h |  2 +-
 security/selinux/ss/services.c    |  6 ++----
 3 files changed, 12 insertions(+), 6 deletions(-)

diff --git a/security/selinux/ss/conditional.c b/security/selinux/ss/conditional.c
index 8f9f2f3c86a0..ad709ccea036 100644
--- a/security/selinux/ss/conditional.c
+++ b/security/selinux/ss/conditional.c
@@ -86,7 +86,7 @@ static int cond_evaluate_expr(struct policydb *p, struct cond_expr *expr)
  * list appropriately. If the result of the expression is undefined
  * all of the rules are disabled for safety.
  */
-void evaluate_cond_node(struct policydb *p, struct cond_node *node)
+static void evaluate_cond_node(struct policydb *p, struct cond_node *node)
 {
 	struct avtab_node *avnode;
 	int new_state;
@@ -117,6 +117,14 @@ void evaluate_cond_node(struct policydb *p, struct cond_node *node)
 	}
 }
 
+void evaluate_cond_nodes(struct policydb *p)
+{
+	u32 i;
+
+	for (i = 0; i < p->cond_list_len; i++)
+		evaluate_cond_node(p, &p->cond_list[i]);
+}
+
 int cond_policydb_init(struct policydb *p)
 {
 	int rc;
diff --git a/security/selinux/ss/conditional.h b/security/selinux/ss/conditional.h
index 4677c6ff7450..b9eb888ffa76 100644
--- a/security/selinux/ss/conditional.h
+++ b/security/selinux/ss/conditional.h
@@ -78,6 +78,6 @@ void cond_compute_av(struct avtab *ctab, struct avtab_key *key,
 		struct av_decision *avd, struct extended_perms *xperms);
 void cond_compute_xperms(struct avtab *ctab, struct avtab_key *key,
 		struct extended_perms_decision *xpermd);
-void evaluate_cond_node(struct policydb *p, struct cond_node *node);
+void evaluate_cond_nodes(struct policydb *p);
 
 #endif /* _CONDITIONAL_H_ */
diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
index 8fc8ec317bb6..7fb7f2efe566 100644
--- a/security/selinux/ss/services.c
+++ b/security/selinux/ss/services.c
@@ -2958,8 +2958,7 @@ int security_set_bools(struct selinux_state *state, u32 len, int *values)
 			policydb->bool_val_to_struct[i]->state = 0;
 	}
 
-	for (i = 0; i < policydb->cond_list_len; i++)
-		evaluate_cond_node(policydb, &policydb->cond_list[i]);
+	evaluate_cond_nodes(policydb);
 
 	seqno = ++state->ss->latest_granting;
 	rc = 0;
@@ -3012,8 +3011,7 @@ static int security_preserve_bools(struct selinux_state *state,
 		if (booldatum)
 			booldatum->state = bvalues[i];
 	}
-	for (i = 0; i < policydb->cond_list_len; i++)
-		evaluate_cond_node(policydb, &policydb->cond_list[i]);
+	evaluate_cond_nodes(policydb);
 
 out:
 	if (bnames) {
-- 
2.24.1

