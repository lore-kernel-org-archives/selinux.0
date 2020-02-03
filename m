Return-Path: <SRS0=lcCQ=3X=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23986C33CAC
	for <selinux@archiver.kernel.org>; Mon,  3 Feb 2020 11:27:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE6362080D
	for <selinux@archiver.kernel.org>; Mon,  3 Feb 2020 11:27:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ME6h3MAL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727541AbgBCL1f (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 3 Feb 2020 06:27:35 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:23882 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727240AbgBCL1f (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 3 Feb 2020 06:27:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1580729254;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NsDVjOhc++zTz7h+huIdm3hhYfQZnmFt2SBo4Tk9NXI=;
        b=ME6h3MALZe167VyT7nZJO2oZfkgSITFfhv4qaumH80YEfzqc4oj9oDsVnXPlQqo7MdXPy6
        hbCHV+amfka0nNDYtZyMbBAvsdxH6da1AwY0fsVahD4ydy8woOpwxEAeir1egHMP8sou1F
        tdl+rd/eMEwzhimt8BlldRnfumoDDxk=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-139-a9sZmNKfMIiENw2ucAtcOw-1; Mon, 03 Feb 2020 06:27:33 -0500
X-MC-Unique: a9sZmNKfMIiENw2ucAtcOw-1
Received: by mail-wr1-f69.google.com with SMTP id 50so7235428wrc.2
        for <selinux@vger.kernel.org>; Mon, 03 Feb 2020 03:27:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NsDVjOhc++zTz7h+huIdm3hhYfQZnmFt2SBo4Tk9NXI=;
        b=PyuetZkKstVLPiMnbAN/9LnvNuo9fzElFcS68ZbZH3t2bEzaUjHTnZPGBzq2bzHKq0
         HsKWLgSFSrAAmjyS8js5cruDPqPhe6lriRbv6RHNeXrFt0PvhHbqAgNJAhyjxD0Kynaf
         7M8rlJgzT6pNUtmdmKDPe3Y2W+0LBNEGsaxU2hI1agaC+eYnDBg29eQsk+NHW/D8p6Sx
         AlROFuKoa8utLeN2s6cFOjLud9gTMJambgD3MN6FBDnlY+u2y/HuiOy8qU4RbN5bFGc9
         LaB1IzCnHp4wFqcv/mbmslqtgpZb/ZzZafVatM0K7UD0FfLH1hJahe45UTmb0jhcuorE
         TR2g==
X-Gm-Message-State: APjAAAWz8IA7lkW+tgyGvmH7c2GSUv7lVcsV7t6fh66W58oKCLdpFM8C
        SrOXGtRb/CVNU3pdtoCe6x3N13Tq5C+f9AiFGjYdEIMu7UQwRIcoLvYl8GaeAU4rgKX3iBrSuvS
        ZPX/e/vPEf/g3GfZ5SA==
X-Received: by 2002:a1c:9c4c:: with SMTP id f73mr27508426wme.125.1580729251887;
        Mon, 03 Feb 2020 03:27:31 -0800 (PST)
X-Google-Smtp-Source: APXvYqy8DuAE/QcJ8nJOkjkVZDm93+96MQpgn6ttSMZ+6p7C17AEZ34ISe2unTufyiPGD6wIYt65ow==
X-Received: by 2002:a1c:9c4c:: with SMTP id f73mr27508398wme.125.1580729251654;
        Mon, 03 Feb 2020 03:27:31 -0800 (PST)
Received: from omos.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id b16sm22597593wmj.39.2020.02.03.03.27.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Feb 2020 03:27:30 -0800 (PST)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     selinux@vger.kernel.org, Paul Moore <paul@paul-moore.com>
Cc:     Stephen Smalley <sds@tycho.nsa.gov>
Subject: [PATCH v3 5/5] selinux: generalize evaluate_cond_node()
Date:   Mon,  3 Feb 2020 12:27:23 +0100
Message-Id: <20200203112723.405341-6-omosnace@redhat.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200203112723.405341-1-omosnace@redhat.com>
References: <20200203112723.405341-1-omosnace@redhat.com>
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
index 669b766c260b..cce4a75fb3e7 100644
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

