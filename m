Return-Path: <SRS0=0L3W=NU=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 094C4C43441
	for <selinux@archiver.kernel.org>; Fri,  9 Nov 2018 14:20:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C458C2081C
	for <selinux@archiver.kernel.org>; Fri,  9 Nov 2018 14:20:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C458C2081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=selinux-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727781AbeKJAAt (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 9 Nov 2018 19:00:49 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:38174 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727735AbeKJAAt (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 9 Nov 2018 19:00:49 -0500
Received: by mail-wm1-f65.google.com with SMTP id f2-v6so2086120wme.3
        for <selinux@vger.kernel.org>; Fri, 09 Nov 2018 06:20:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=s/4X6HYI/eolH9/GPG8rYlYB3LPsz5gRJjco5WIbidU=;
        b=dlSfiVZeLoFGn5ZdaMMrZAAbtma610KYTaOzXVNtgPXARqYL0LE2D8eP+/OhXsruOi
         N/QZ33zdhsn6B3yGee5foKYSHvaRdEPVaDFGLFxMnS59kcLemQ30r4r+Im/Ry6DkMuuc
         TM3vZa0Y003pda8sSHsldfUgFleNAFeCoBjxGGWJB8sJ6Vogpo/Z+NWM2H6K98z1aAhQ
         io5hrCN5Vg7jN9K5O7UioENE0u0oU7jz/hyMiZVabNBRJN54WIBjpad2Svn5TvBAwU1J
         vhO57diwOl7megG1eUSWuTQ0MxEA0YmBUTFBdzDOlAahO98Fd47MMS6Sl+vcKwKptMYr
         wVHA==
X-Gm-Message-State: AGRZ1gLOR0z309gMYALU38leBuRknaWDYhlny0DtKN2nFfb8/3IZLcXY
        /NziqC+9hhrvbVAJvkve6tTWzpkrtgM=
X-Google-Smtp-Source: AJdET5dHwe+V7fL6ue2to42BGDY2rlZqUEub8UAuRUeyinAuVYoCFwUBxTbuvZxwYxdB6xFn8xOKtw==
X-Received: by 2002:a1c:aacf:: with SMTP id t198-v6mr5126625wme.108.1541773199931;
        Fri, 09 Nov 2018 06:19:59 -0800 (PST)
Received: from localhost.localdomain.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id b5-v6sm4255996wrs.34.2018.11.09.06.19.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 09 Nov 2018 06:19:59 -0800 (PST)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     selinux@vger.kernel.org, Paul Moore <paul@paul-moore.com>
Cc:     Stephen Smalley <sds@tycho.nsa.gov>, selinux@tycho.nsa.gov,
        Ondrej Mosnacek <omosnace@redhat.com>
Subject: [PATCH] selinux: simplify mls_context_to_sid()
Date:   Fri,  9 Nov 2018 15:19:43 +0100
Message-Id: <20181109141943.5348-1-omosnace@redhat.com>
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
 security/selinux/ss/mls.c      | 44 ++++------------------------------
 security/selinux/ss/mls.h      |  5 +---
 security/selinux/ss/services.c | 32 ++++++++++++++++++++++---
 3 files changed, 35 insertions(+), 46 deletions(-)

diff --git a/security/selinux/ss/mls.c b/security/selinux/ss/mls.c
index 2fe459df3c85..587f51657137 100644
--- a/security/selinux/ss/mls.c
+++ b/security/selinux/ss/mls.c
@@ -223,20 +223,12 @@ int mls_context_isvalid(struct policydb *p, struct context *c)
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
@@ -244,29 +236,6 @@ int mls_context_to_sid(struct policydb *pol,
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
@@ -364,14 +333,11 @@ int mls_from_string(struct policydb *p, char *str, struct context *context,
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

