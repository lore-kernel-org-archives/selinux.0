Return-Path: <SRS0=jI/q=3F=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B767C33CB1
	for <selinux@archiver.kernel.org>; Thu, 16 Jan 2020 12:04:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 696212073A
	for <selinux@archiver.kernel.org>; Thu, 16 Jan 2020 12:04:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="S59k/4t1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726410AbgAPMEs (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 16 Jan 2020 07:04:48 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:45359 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726018AbgAPMEs (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 16 Jan 2020 07:04:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1579176286;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9eh6fTwDkaaIjtWAtG0HVT6Md3jZLcNyvj8n9G9ZTjM=;
        b=S59k/4t1UHAQWaGZzDz55EJ6OMWYz9cMOrg1byyh0Dq4erWllJCDsX91kYOVo/8A59Xny1
        DqKCAmrHfwEFZKiFnE5afGJkA4Qlfc57yHhYaVriR+FMxmv5DEQxCIxilW6gwLCoiRlDRy
        EBOxOX544QiNSoMmEYRfmHO5ZZwGJbY=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-355-aXpdddZaMeWRuf-VtWJLgQ-1; Thu, 16 Jan 2020 07:04:44 -0500
X-MC-Unique: aXpdddZaMeWRuf-VtWJLgQ-1
Received: by mail-wm1-f72.google.com with SMTP id t4so1126340wmf.2
        for <selinux@vger.kernel.org>; Thu, 16 Jan 2020 04:04:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9eh6fTwDkaaIjtWAtG0HVT6Md3jZLcNyvj8n9G9ZTjM=;
        b=H3nCmoVKLNwXuoz97xlDjyhD1ZmKjRjed0j2BknZabLIqqsFZqNuAVKdiyUWRpemWy
         Oc4FkucC2Sr2rDxpBWFT0aKzCXlidXruwSAiSLQvqgUY6poLuTCeOGKnstM9SKJLk8Nl
         SFs5EoQRVn612WPCIVZt9hCGszy5jKlPwhU/C27YofnqQt4RH1n+h86DPaR8vHXEZMR7
         /OaDQtCKfLNIvad10ryU9P2eBqsJexkYC6o9pHAwaaj4bgGLyVQhWYsPQw2aLz6NBxEd
         zhw+QXV5AXFzPesIfUmUU6rvdK1fbYcv/wOz0MFZHz/O+B90IsC7emuT7OroGifChLer
         JS7g==
X-Gm-Message-State: APjAAAWXa3/kvQZq7eVir4Zbcbp2KH85WPKnOk4jqIHVaT7EdqmffNFb
        3ShK3qy6CePiCxG+3fq1NGgBp10wW8f6e58Q5ekSgqXLPiDQwtUhIFgjr1p2k+zaMDe8foH/7Xs
        U1RnMI5yh9e8rULy5Rg==
X-Received: by 2002:a7b:c84a:: with SMTP id c10mr5889399wml.157.1579176283524;
        Thu, 16 Jan 2020 04:04:43 -0800 (PST)
X-Google-Smtp-Source: APXvYqynCN7/M2n3iABcnFkN4Vqeh/C18IjfVQwQ5PFtzQ6IuUhLY9rZlssxMst1gB5RjYqRLsmOvA==
X-Received: by 2002:a7b:c84a:: with SMTP id c10mr5889389wml.157.1579176283263;
        Thu, 16 Jan 2020 04:04:43 -0800 (PST)
Received: from omos.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id b67sm278117wmc.38.2020.01.16.04.04.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jan 2020 04:04:42 -0800 (PST)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     selinux@vger.kernel.org, Paul Moore <paul@paul-moore.com>
Cc:     Stephen Smalley <sds@tycho.nsa.gov>
Subject: [PATCH 2/6] selinux: simplify security_preserve_bools()
Date:   Thu, 16 Jan 2020 13:04:35 +0100
Message-Id: <20200116120439.303034-3-omosnace@redhat.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200116120439.303034-1-omosnace@redhat.com>
References: <20200116120439.303034-1-omosnace@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

First, evaluate_cond_node() never returns an error. Make it just return
void.

Second, drop the use of security_get_bools() from
security_preserve_bools() and read from the old policydb directly. This
saves some useless allocations and together with the first change makes
security_preserve_bools() no longer possibly return an error. Again the
return type is changed to void.

Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
---
 security/selinux/ss/conditional.c |  3 +-
 security/selinux/ss/conditional.h |  2 +-
 security/selinux/ss/services.c    | 52 ++++++++++---------------------
 3 files changed, 18 insertions(+), 39 deletions(-)

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
index 42ca9f6dbbf4..b9eda7d89e22 100644
--- a/security/selinux/ss/services.c
+++ b/security/selinux/ss/services.c
@@ -2157,8 +2157,8 @@ static void security_load_policycaps(struct selinux_state *state)
 	}
 }
 
-static int security_preserve_bools(struct selinux_state *state,
-				   struct policydb *newpolicydb);
+static void security_preserve_bools(struct policydb *oldpolicydb,
+				    struct policydb *newpolicydb);
 
 /**
  * security_load_policy - Load a security policy configuration.
@@ -2257,11 +2257,7 @@ int security_load_policy(struct selinux_state *state, void *data, size_t len)
 	if (rc)
 		goto err;
 
-	rc = security_preserve_bools(state, newpolicydb);
-	if (rc) {
-		pr_err("SELinux:  unable to preserve booleans\n");
-		goto err;
-	}
+	security_preserve_bools(policydb, newpolicydb);
 
 	oldsidtab = state->ss->sidtab;
 
@@ -2958,11 +2954,8 @@ int security_set_bools(struct selinux_state *state, int len, int *values)
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
@@ -2999,36 +2992,23 @@ out:
 	return rc;
 }
 
-static int security_preserve_bools(struct selinux_state *state,
-				   struct policydb *policydb)
+static void security_preserve_bools(struct policydb *oldpolicydb,
+				    struct policydb *newpolicydb)
 {
-	int rc, nbools = 0, *bvalues = NULL, i;
-	char **bnames = NULL;
 	struct cond_bool_datum *booldatum;
 	struct cond_node *cur;
+	int i;
 
-	rc = security_get_bools(state, &nbools, &bnames, &bvalues);
-	if (rc)
-		goto out;
-	for (i = 0; i < nbools; i++) {
-		booldatum = hashtab_search(policydb->p_bools.table, bnames[i]);
-		if (booldatum)
-			booldatum->state = bvalues[i];
-	}
-	for (cur = policydb->cond_list; cur; cur = cur->next) {
-		rc = evaluate_cond_node(policydb, cur);
-		if (rc)
-			goto out;
-	}
+	for (i = 0; i < oldpolicydb->p_bools.nprim; i++) {
+		const char *name = sym_name(oldpolicydb, SYM_BOOLS, i);
+		int value = oldpolicydb->bool_val_to_struct[i]->state;
 
-out:
-	if (bnames) {
-		for (i = 0; i < nbools; i++)
-			kfree(bnames[i]);
+		booldatum = hashtab_search(newpolicydb->p_bools.table, name);
+		if (booldatum)
+			booldatum->state = value;
 	}
-	kfree(bnames);
-	kfree(bvalues);
-	return rc;
+	for (cur = newpolicydb->cond_list; cur; cur = cur->next)
+		evaluate_cond_node(newpolicydb, cur);
 }
 
 /*
-- 
2.24.1

