Return-Path: <SRS0=0L3W=NU=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 611A4C43441
	for <selinux@archiver.kernel.org>; Fri,  9 Nov 2018 15:43:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B3F420855
	for <selinux@archiver.kernel.org>; Fri,  9 Nov 2018 15:43:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B3F420855
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=selinux-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728404AbeKJBYp (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 9 Nov 2018 20:24:45 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:38941 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727802AbeKJBYp (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 9 Nov 2018 20:24:45 -0500
Received: by mail-wr1-f67.google.com with SMTP id b13so2343676wrx.6
        for <selinux@vger.kernel.org>; Fri, 09 Nov 2018 07:43:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=hdajTUYZsV+N0P6koXKHomrq/kTNz6dtzi/LO6+JfcU=;
        b=bqI46s8XyoIR/BR8WjVHUhIMlJNZjq8wIQhnIo+fYxZAkPxnL/S/eDSzbSc1cwy1AB
         dBBpb///G6fdBTpF7wLQlY7wFDjjHHoL1sX/xgmbQnDfn1VBHdLP30yb3en8S6iXwnZQ
         sYAIjfsCNUeHQlMFFnv/BDMgDma7zNGwUWWWcytTMcFIcjtdnyueRy/eWgfGq+kMA2SB
         AOygjKq15As4IBv7O0SP4fMV4RKNqyuYorN30UMu/hl3icsgg3Lj6xSFi9G51SYrGyL/
         iXklXJ/iSxdQERcfjVHRgp3Kgs9PTwLgTkjOytmvtUiRbzZm0rhquamn5x6iLz5VPgPO
         Xg5A==
X-Gm-Message-State: AGRZ1gJCScOuj+Bhg2dPFmLV/O6Hf+c8jH26hsCKjuuhM/64r8ZQrANb
        M5Zct5rZ+SDKKxk7QYiVKA6eEddJvgA=
X-Google-Smtp-Source: AJdET5eeCzphGxecq87kE7Lt85pMoAZndQUlITlv0vxo8g/B9hOV3t2YrR3DSVDLrmi0h2etYkXNGg==
X-Received: by 2002:a05:6000:110b:: with SMTP id z11mr8360694wrw.136.1541778216329;
        Fri, 09 Nov 2018 07:43:36 -0800 (PST)
Received: from localhost.localdomain.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id j18-v6sm3230389wmf.39.2018.11.09.07.43.35
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 09 Nov 2018 07:43:35 -0800 (PST)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     selinux@vger.kernel.org, Paul Moore <paul@paul-moore.com>
Cc:     Stephen Smalley <sds@tycho.nsa.gov>, selinux@tycho.nsa.gov,
        Ondrej Mosnacek <omosnace@redhat.com>
Subject: [PATCH v2] selinux: simplify mls_context_to_sid()
Date:   Fri,  9 Nov 2018 16:43:23 +0100
Message-Id: <20181109154323.21122-1-omosnace@redhat.com>
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

Changes in v2:
 - also drop unneeded #include's from mls.c

 security/selinux/ss/mls.c      | 47 ++++------------------------------
 security/selinux/ss/mls.h      |  5 +---
 security/selinux/ss/services.c | 32 ++++++++++++++++++++---
 3 files changed, 35 insertions(+), 49 deletions(-)

diff --git a/security/selinux/ss/mls.c b/security/selinux/ss/mls.c
index 2fe459df3c85..f1377f278b5d 100644
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
  * Policy read-lock must be held for sidtab lookup.
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

