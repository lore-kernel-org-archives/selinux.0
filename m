Return-Path: <SRS0=lcCQ=3X=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0163C3F68F
	for <selinux@archiver.kernel.org>; Mon,  3 Feb 2020 11:27:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6DD520661
	for <selinux@archiver.kernel.org>; Mon,  3 Feb 2020 11:27:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bHABjxzJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727276AbgBCL1c (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 3 Feb 2020 06:27:32 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:53339 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727240AbgBCL1b (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 3 Feb 2020 06:27:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1580729249;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9lIemL6brFPUCAYSBZWFrUpZJZjzccOl0mn5RZzFkss=;
        b=bHABjxzJbg9Lh7fxRM4NKiQt2/7Q5/syTt7dB1wHTlE+BB9EGGgqUbt0vXfpJ6qi3wez+X
        OAs3/8FgAz8sDAWKka97gYncKhuwk+rb0rKYxQ7Xd6bIT5IFP/nvdJpQ17GJM9U2y5OHks
        vqohjIcwGtS9Pmkula/xv8+TEkIEc0k=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-370-SMGpf9HNMCKy46AVh7etBg-1; Mon, 03 Feb 2020 06:27:28 -0500
X-MC-Unique: SMGpf9HNMCKy46AVh7etBg-1
Received: by mail-wr1-f71.google.com with SMTP id u8so7083129wrp.10
        for <selinux@vger.kernel.org>; Mon, 03 Feb 2020 03:27:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9lIemL6brFPUCAYSBZWFrUpZJZjzccOl0mn5RZzFkss=;
        b=M4B1V9pFGx8nid+qPuP6kFpNkVSKEH7imd875HjyJZRpQYQaddEZyHx/CxcGMogJXh
         iqB8UrITERGTBb0z78vkl4rPAGAHbiSXIyX56RWvg44F0ugo0zmSiQMknuog+88cwLo7
         ItLE9ZjHWoaZn5h808q2wgloyiLvdPz+F5e3de/7JGEkmSlOS8CnCCrPSNwD/OBA5lKl
         E1/HDRLt+EUSNGjQtryOxZcAHLqc70MEL2GK2jJGTSdWhu4wVcPumI4UXRsggZ8bwkOd
         VJlMdVwejmG2lamU5FwdFB9Z5XsS2hj5lIo00uy2z7uOJ/LYWHGWuep7JiT3uRRhzZYO
         klqw==
X-Gm-Message-State: APjAAAWUJr8v3PDLWZrB+WDtOGD113fKW7UkftQ/z3tISETgT9bkidOs
        9B+GW3OnJt5CxqyirIRpI/yu6TUapLqLzvoZXT1WHiLymZxYqr+/eZS4cp8tBJ6QFkjulSQ1kED
        ejMZ1I3ghMsHhIqlEyw==
X-Received: by 2002:a7b:c76a:: with SMTP id x10mr27221942wmk.49.1580729247181;
        Mon, 03 Feb 2020 03:27:27 -0800 (PST)
X-Google-Smtp-Source: APXvYqy/nw6vpN8dOfUXN53cWzZEP3ttaAwoc66q2+6UKX0UjjOifkGdOPzijnf8nhrNZVah2iwhfA==
X-Received: by 2002:a7b:c76a:: with SMTP id x10mr27221911wmk.49.1580729246907;
        Mon, 03 Feb 2020 03:27:26 -0800 (PST)
Received: from omos.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id b16sm22597593wmj.39.2020.02.03.03.27.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Feb 2020 03:27:25 -0800 (PST)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     selinux@vger.kernel.org, Paul Moore <paul@paul-moore.com>
Cc:     Stephen Smalley <sds@tycho.nsa.gov>
Subject: [PATCH v3 1/5] selinux: simplify evaluate_cond_node()
Date:   Mon,  3 Feb 2020 12:27:19 +0100
Message-Id: <20200203112723.405341-2-omosnace@redhat.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200203112723.405341-1-omosnace@redhat.com>
References: <20200203112723.405341-1-omosnace@redhat.com>
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

