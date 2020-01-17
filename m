Return-Path: <SRS0=ftCu=3G=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B942C33CB6
	for <selinux@archiver.kernel.org>; Fri, 17 Jan 2020 08:58:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 522872072B
	for <selinux@archiver.kernel.org>; Fri, 17 Jan 2020 08:58:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="h1ljZPkH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728512AbgAQI6o (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 17 Jan 2020 03:58:44 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:20218 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727531AbgAQI6n (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 17 Jan 2020 03:58:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1579251522;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9lIemL6brFPUCAYSBZWFrUpZJZjzccOl0mn5RZzFkss=;
        b=h1ljZPkHlke3SKs59nidJcJqpzcjfFDPW3JOeCNlchXCmBBu42uV1g63w1jP2/Xi7PXW0F
        sf1x/noFkquouLeW1SeyXM4YFDjfCz6zpPPdtynJhRv80BoBVs+IXdiKx48dREynQcYey9
        PekOOUZmIyUGZkbevgwuB8Q6x0luNtE=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-418-3xDkwnjiNo-JJug9I3lUXA-1; Fri, 17 Jan 2020 03:58:41 -0500
X-MC-Unique: 3xDkwnjiNo-JJug9I3lUXA-1
Received: by mail-wr1-f70.google.com with SMTP id h30so10262131wrh.5
        for <selinux@vger.kernel.org>; Fri, 17 Jan 2020 00:58:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9lIemL6brFPUCAYSBZWFrUpZJZjzccOl0mn5RZzFkss=;
        b=E70xRM+Yu4+u19bNF78qJ7xHdX20JJYZkJNqtgRbYT9+aaoL3MEt0WDwxHLZED8t1D
         YzEu2BN3jCM/OpbdNGUOLrQ/2UhSWpQ7B/ucJPiGR+sR4poP/D5nsLNQ78elvoNWO4qh
         JjNl1Nn1JlJtuPSogcyj0ydJtvqC2aebVbFQXol3p/yUx4Tp9Jehmt8iBUGTN0IZvnmt
         nxYXvYjMXogBwV6nh23vYmHRO2XUiCdr36EKrxVzeLnGD+xz2KQk6QaM/0uiYiJW+mzP
         j+W0tyX3D+n6ix3ZO+QyBvRtjG/QdUkdPLb4+4jN/yvq3hga5z5uEUVQVjxsG22MRzBK
         G2zw==
X-Gm-Message-State: APjAAAVSpqyivsbC2VU0I09QCbR/0mKEhiOzgpnSJo8M1j1n0GkS4QMb
        ZxGYJbXO8VnfjSGwdCHT3j0T0vB64sRYOFZ4qr2D3xfHa5m0RPHuvIj+t8Q3DQUEgWynEEHPnmK
        Rjl3mXWcn8wbVn7L3QQ==
X-Received: by 2002:a05:600c:2117:: with SMTP id u23mr3589246wml.106.1579251520004;
        Fri, 17 Jan 2020 00:58:40 -0800 (PST)
X-Google-Smtp-Source: APXvYqzboKo2vEDKRPDvsJaByWcGMwdbDjM3HBAQn2a1IHqAZvsp2swrCNAsvUSALW5U9H1i7s+B6A==
X-Received: by 2002:a05:600c:2117:: with SMTP id u23mr3589231wml.106.1579251519816;
        Fri, 17 Jan 2020 00:58:39 -0800 (PST)
Received: from omos.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id x18sm33391312wrr.75.2020.01.17.00.58.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jan 2020 00:58:39 -0800 (PST)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     selinux@vger.kernel.org, Paul Moore <paul@paul-moore.com>
Cc:     Stephen Smalley <sds@tycho.nsa.gov>
Subject: [PATCH v2 1/5] selinux: simplify evaluate_cond_node()
Date:   Fri, 17 Jan 2020 09:58:32 +0100
Message-Id: <20200117085836.445797-2-omosnace@redhat.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200117085836.445797-1-omosnace@redhat.com>
References: <20200117085836.445797-1-omosnace@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

It never fails, so it can just return void.

Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
---
 security/selinux/ss/conditional.c |  3 +--
 security/selinux/ss/conditional.h |  2 +-
 security/selinux/ss/services.c    | 14 ++++----------
 3 files changed, 6 insertions(+), 13 deletions(-)

diff --git a/security/selinux/ss/conditional.c b/security/selinux/ss/conditional.c
index 70c378ee1a2f..04593062008d 100644
--- a/security/selinux/ss/conditional.c
+++ b/security/selinux/ss/conditional.c
@@ -85,7 +85,7 @@ static int cond_evaluate_expr(struct policydb *p, struct cond_expr *expr)
  * list appropriately. If the result of the expression is undefined
  * all of the rules are disabled for safety.
  */
-int evaluate_cond_node(struct policydb *p, struct cond_node *node)
+void evaluate_cond_node(struct policydb *p, struct cond_node *node)
 {
 	int new_state;
 	struct cond_av_list *cur;
@@ -111,7 +111,6 @@ int evaluate_cond_node(struct policydb *p, struct cond_node *node)
 				cur->node->key.specified |= AVTAB_ENABLED;
 		}
 	}
-	return 0;
 }
 
 int cond_policydb_init(struct policydb *p)
diff --git a/security/selinux/ss/conditional.h b/security/selinux/ss/conditional.h
index ec846e45904c..d86ef286ca84 100644
--- a/security/selinux/ss/conditional.h
+++ b/security/selinux/ss/conditional.h
@@ -75,6 +75,6 @@ void cond_compute_av(struct avtab *ctab, struct avtab_key *key,
 		struct av_decision *avd, struct extended_perms *xperms);
 void cond_compute_xperms(struct avtab *ctab, struct avtab_key *key,
 		struct extended_perms_decision *xpermd);
-int evaluate_cond_node(struct policydb *p, struct cond_node *node);
+void evaluate_cond_node(struct policydb *p, struct cond_node *node);
 
 #endif /* _CONDITIONAL_H_ */
diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
index 216ce602a2b5..ff43a35bb874 100644
--- a/security/selinux/ss/services.c
+++ b/security/selinux/ss/services.c
@@ -2958,11 +2958,8 @@ int security_set_bools(struct selinux_state *state, int len, int *values)
 			policydb->bool_val_to_struct[i]->state = 0;
 	}
 
-	for (cur = policydb->cond_list; cur; cur = cur->next) {
-		rc = evaluate_cond_node(policydb, cur);
-		if (rc)
-			goto out;
-	}
+	for (cur = policydb->cond_list; cur; cur = cur->next)
+		evaluate_cond_node(policydb, cur);
 
 	seqno = ++state->ss->latest_granting;
 	rc = 0;
@@ -3015,11 +3012,8 @@ static int security_preserve_bools(struct selinux_state *state,
 		if (booldatum)
 			booldatum->state = bvalues[i];
 	}
-	for (cur = policydb->cond_list; cur; cur = cur->next) {
-		rc = evaluate_cond_node(policydb, cur);
-		if (rc)
-			goto out;
-	}
+	for (cur = policydb->cond_list; cur; cur = cur->next)
+		evaluate_cond_node(policydb, cur);
 
 out:
 	if (bnames) {
-- 
2.24.1

