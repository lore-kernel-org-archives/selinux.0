Return-Path: <SRS0=Zaf8=NX=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08791C43441
	for <selinux@archiver.kernel.org>; Mon, 12 Nov 2018 11:44:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C568A223D8
	for <selinux@archiver.kernel.org>; Mon, 12 Nov 2018 11:44:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C568A223D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=selinux-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729293AbeKLVhc (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 12 Nov 2018 16:37:32 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:36383 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728667AbeKLVhc (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 12 Nov 2018 16:37:32 -0500
Received: by mail-wr1-f66.google.com with SMTP id z13-v6so8981026wrs.3
        for <selinux@vger.kernel.org>; Mon, 12 Nov 2018 03:44:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=+nsE4vVL3vZpy1Qd2om+IK2FjkUr7v1NauHREs0Vl8c=;
        b=EzUh9TqZ6T2PcNZxoth3tnRIJ/00/PS+U/bVdqicVAXdZRMpGSPP4PkTj4bwsEhBI5
         RXaGjaazrAS/e3mzUl/A9GOvjF4SGA4eZG5MSCOqfo4++B7EBejnEtkJpU31k14Euf15
         ZOBLr6T+h1q6hp3cebuM7xdqQJg2lmVW3AQs5osPbL0Ho05r62Lcn55aGHvSbO3ZvL/v
         L3bMyCyxquQEzBR4Lf7Le3+o8Pz9By/oY7UzKGl2oLJsiLSlQiL1N9kc0+P0JRGYHkeP
         a8uucb5syNWGx/nxpgdwtlGsZ3/OsOREK7aN/2rsgPVMteh9EtmpVyPE2cusxt2arc6K
         5teA==
X-Gm-Message-State: AGRZ1gIh4YPzGrCILovfRfXBoZFNRh5FC/9k9HdLrOQZCFdB5pp7pOs9
        pQj7ue5ip28Cb85PU9yztEFc15QxX6+9BQ==
X-Google-Smtp-Source: AJdET5f25q7GTL4ixUz/tBtUrGZxaMsnJYQKqg8usUUoQI7qqC2Uw1ec3SSEAjrE4m40KWBUWHjWyQ==
X-Received: by 2002:a5d:408c:: with SMTP id o12-v6mr673918wrp.90.1542023076376;
        Mon, 12 Nov 2018 03:44:36 -0800 (PST)
Received: from localhost.localdomain.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id i73-v6sm8699303wmd.10.2018.11.12.03.44.35
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 12 Nov 2018 03:44:35 -0800 (PST)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     selinux@vger.kernel.org, Paul Moore <paul@paul-moore.com>
Cc:     Stephen Smalley <sds@tycho.nsa.gov>, selinux@tycho.nsa.gov,
        Ondrej Mosnacek <omosnace@redhat.com>
Subject: [PATCH v3] selinux: simplify mls_context_to_sid()
Date:   Mon, 12 Nov 2018 12:44:26 +0100
Message-Id: <20181112114426.20887-1-omosnace@redhat.com>
X-Mailer: git-send-email 2.17.2
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

This function has only two callers, but only one of them actually needs
the special logic at the beginning. Factoring this logic out into
string_to_context_struct() allows us to drop the arguments 'oldc', 's',
and 'def_sid'.

Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
---

Changes in v3:
 - correct the comment about policy read lock

Changes in v2:
 - also drop unneeded #include's from mls.c

 security/selinux/ss/mls.c      | 49 +++++-----------------------------
 security/selinux/ss/mls.h      |  5 +---
 security/selinux/ss/services.c | 32 +++++++++++++++++++---
 3 files changed, 36 insertions(+), 50 deletions(-)

diff --git a/security/selinux/ss/mls.c b/security/selinux/ss/mls.c
index 2fe459df3c85..d1da928a7e77 100644
--- a/security/selinux/ss/mls.c
+++ b/security/selinux/ss/mls.c
@@ -24,10 +24,7 @@
 #include <linux/string.h>
 #include <linux/errno.h>
 #include <net/netlabel.h>
-#include "sidtab.h"
 #include "mls.h"
-#include "policydb.h"
-#include "services.h"
 
 /*
  * Return the length in bytes for the MLS fields of the
@@ -223,20 +220,12 @@ int mls_context_isvalid(struct policydb *p, struct context *c)
  * This function modifies the string in place, inserting
  * NULL characters to terminate the MLS fields.
  *
- * If a def_sid is provided and no MLS field is present,
- * copy the MLS field of the associated default context.
- * Used for upgraded to MLS systems where objects may lack
- * MLS fields.
- *
- * Policy read-lock must be held for sidtab lookup.
+ * Policy read-lock must be held for policy data lookup.
  *
  */
 int mls_context_to_sid(struct policydb *pol,
-		       char oldc,
 		       char *scontext,
-		       struct context *context,
-		       struct sidtab *s,
-		       u32 def_sid)
+		       struct context *context)
 {
 	char *sensitivity, *cur_cat, *next_cat, *rngptr;
 	struct level_datum *levdatum;
@@ -244,29 +233,6 @@ int mls_context_to_sid(struct policydb *pol,
 	int l, rc, i;
 	char *rangep[2];
 
-	if (!pol->mls_enabled) {
-		if ((def_sid != SECSID_NULL && oldc) || (*scontext) == '\0')
-			return 0;
-		return -EINVAL;
-	}
-
-	/*
-	 * No MLS component to the security context, try and map to
-	 * default if provided.
-	 */
-	if (!oldc) {
-		struct context *defcon;
-
-		if (def_sid == SECSID_NULL)
-			return -EINVAL;
-
-		defcon = sidtab_search(s, def_sid);
-		if (!defcon)
-			return -EINVAL;
-
-		return mls_context_cpy(context, defcon);
-	}
-
 	/*
 	 * If we're dealing with a range, figure out where the two parts
 	 * of the range begin.
@@ -364,14 +330,11 @@ int mls_from_string(struct policydb *p, char *str, struct context *context,
 		return -EINVAL;
 
 	tmpstr = kstrdup(str, gfp_mask);
-	if (!tmpstr) {
-		rc = -ENOMEM;
-	} else {
-		rc = mls_context_to_sid(p, ':', tmpstr, context,
-					NULL, SECSID_NULL);
-		kfree(tmpstr);
-	}
+	if (!tmpstr)
+		return -ENOMEM;
 
+	rc = mls_context_to_sid(p, tmpstr, context);
+	kfree(tmpstr);
 	return rc;
 }
 
diff --git a/security/selinux/ss/mls.h b/security/selinux/ss/mls.h
index 67093647576d..e2498f78e100 100644
--- a/security/selinux/ss/mls.h
+++ b/security/selinux/ss/mls.h
@@ -33,11 +33,8 @@ int mls_range_isvalid(struct policydb *p, struct mls_range *r);
 int mls_level_isvalid(struct policydb *p, struct mls_level *l);
 
 int mls_context_to_sid(struct policydb *p,
-		       char oldc,
 		       char *scontext,
-		       struct context *context,
-		       struct sidtab *s,
-		       u32 def_sid);
+		       struct context *context);
 
 int mls_from_string(struct policydb *p, char *str, struct context *context,
 		    gfp_t gfp_mask);
diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
index 12e414394530..ccad4334f99d 100644
--- a/security/selinux/ss/services.c
+++ b/security/selinux/ss/services.c
@@ -1425,9 +1425,35 @@ static int string_to_context_struct(struct policydb *pol,
 
 	ctx->type = typdatum->value;
 
-	rc = mls_context_to_sid(pol, oldc, p, ctx, sidtabp, def_sid);
-	if (rc)
-		goto out;
+	if (!pol->mls_enabled) {
+		rc = -EINVAL;
+		if ((def_sid == SECSID_NULL || !oldc) && (*p) != '\0')
+			goto out;
+	} else if (!oldc) {
+		/*
+		 * If a def_sid is provided and no MLS field is present,
+		 * copy the MLS field of the associated default context.
+		 * Used for upgrading to MLS systems where objects may lack
+		 * MLS fields.
+		 */
+		struct context *defcon;
+
+		rc = -EINVAL;
+		if (def_sid == SECSID_NULL)
+			goto out;
+
+		defcon = sidtab_search(sidtabp, def_sid);
+		if (!defcon)
+			goto out;
+
+		rc = mls_context_cpy(ctx, defcon);
+		if (rc)
+			goto out;
+	} else {
+		rc = mls_context_to_sid(pol, p, ctx);
+		if (rc)
+			goto out;
+	}
 
 	/* Check the validity of the new context. */
 	rc = -EINVAL;
-- 
2.17.2

