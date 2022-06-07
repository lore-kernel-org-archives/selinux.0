Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D144CCA47C
	for <selinux@archiver.kernel.org>; Tue,  7 Jun 2022 18:07:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349700AbiFGSHh (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 7 Jun 2022 14:07:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350095AbiFGSAn (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 7 Jun 2022 14:00:43 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BA0814ACB4
        for <selinux@vger.kernel.org>; Tue,  7 Jun 2022 10:42:41 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id s12so29471065ejx.3
        for <selinux@vger.kernel.org>; Tue, 07 Jun 2022 10:42:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=fQO5Ilfvvo+Bi8qJrsKy6L6lF+nwrD8HP5uMWKvqBIw=;
        b=n63+pFaaUiOepUvNQ80TnfHhRIE/KUBlCNEKI/BU3rFjTUdGnbg6qmRvroTrP55tj+
         Ve/CeZInTqYzMo3RLqGfNu9PiMrI7pc7Oroe1TRw5o+dwvV4EHmmg+KKcta/IvEw2a6W
         rA+mIPFEy4cmXiTc/T3lutuGmTeBBwHgKMklkevqoQDwDG+zHXI4UaDDT4vEN1uX8RKR
         4jlxwtuVldKaMDTgir0w37zrHRZuEJQrrNMUrbOspFSeQjt2L1HUKbjjwoJBmvV4SAwV
         o7mjEhTHjBKmOR32OOap032FPBmjk1lPeck34PqDtAsjgIY0grQKbvhAYSgCfWnOZHSk
         Vc+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fQO5Ilfvvo+Bi8qJrsKy6L6lF+nwrD8HP5uMWKvqBIw=;
        b=7PJD0wJAEXFM1QmNeihDtZ/OUjnDSAb8ltiSDgshdZZVbVpofkKWhtgUK8Q8zw6ghH
         ba2WT/1Fj8RqMQeS80c9NmbXQgZ/LVgz03/oyzUgKeTSst1ygyIwxWyseQAAQXSOpVZ9
         nB5IfCNm50qktV56VHWIIMM4CvxiSYg04h4Z+HvEYrFPtAo0lgJEicqhYNFrclOPBdzr
         rqIknKJIySmQ0eTiu0IvCajCHGNhlwqFnwHdr2Vk0znWkEF0Q5nJLjybrd4tcrX+CxFj
         ea4wOs2ZAHJFGE+Q+TBtTDPMXGknIvn5rwByfGoY+d4c4fD5crIEWj8KOWTM5sxD1nse
         Je/Q==
X-Gm-Message-State: AOAM532CMKegGZIFR3duIzSXvFCAq+9QhgEmsJekvZRF6HiGlY0hpql2
        0yAZlM5PfeOlH84h9PSkgpdTv8mQ2ns=
X-Google-Smtp-Source: ABdhPJw01vZrOQsS3Eb9uTm3vrmJ9fj+mdM29dOJg8VfJMglwMCvsfazZVkbotYI3NxwmkUh4VLiEQ==
X-Received: by 2002:a17:907:364:b0:709:614e:acc0 with SMTP id rs4-20020a170907036400b00709614eacc0mr27325980ejb.692.1654623758030;
        Tue, 07 Jun 2022 10:42:38 -0700 (PDT)
Received: from debianHome.localdomain (dynamic-077-008-054-039.77.8.pool.telefonica.de. [77.8.54.39])
        by smtp.gmail.com with ESMTPSA id o9-20020a170906600900b006fec8e5b8a9sm7962591ejj.152.2022.06.07.10.42.37
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jun 2022 10:42:37 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [RFC PATCH 3/3] checkpolicy: rework initial SID handling
Date:   Tue,  7 Jun 2022 19:41:45 +0200
Message-Id: <20220607174145.51330-3-cgzones@googlemail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220607174145.51330-1-cgzones@googlemail.com>
References: <20220607174145.51330-1-cgzones@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

The kernel removed [1] some unused initial SIDs.  Also libsepol got
support for omitting unused ones [2].

Currently in traditional policy all initial SIDs have to be defined and
also the order of declarations has to follow the order of the libsepol
internal representation.  Support omitting unused initial SIDs in the
traditional policy and do not require a specific order of declarations.

[1]: https://github.com/SELinuxProject/selinux-kernel/commit/e3e0b582c321aefd72db0e7083a0adfe285e96b5
[2]: https://github.com/SELinuxProject/selinux/commit/8677ce5e8f592950ae6f14cea1b68a20ddc1ac25

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 checkpolicy/policy_define.c | 39 ++++++++++++++++++++++++-------------
 1 file changed, 26 insertions(+), 13 deletions(-)

diff --git a/checkpolicy/policy_define.c b/checkpolicy/policy_define.c
index 8bf36859..8f55650d 100644
--- a/checkpolicy/policy_define.c
+++ b/checkpolicy/policy_define.c
@@ -54,6 +54,7 @@
 #include <sepol/policydb/services.h>
 #include <sepol/policydb/conditional.h>
 #include <sepol/policydb/hierarchy.h>
+#include <sepol/policydb/initialsids.h>
 #include <sepol/policydb/polcaps.h>
 #include "queue.h"
 #include "checkpolicy.h"
@@ -287,6 +288,7 @@ int define_polcap(void)
 int define_initial_sid(void)
 {
 	char *id = 0;
+	sepol_security_id_t sid;
 	ocontext_t *newc = 0, *c, *head;
 
 	if (pass == 2) {
@@ -300,28 +302,30 @@ int define_initial_sid(void)
 		yyerror("no sid name for SID definition?");
 		return -1;
 	}
-	newc = (ocontext_t *) malloc(sizeof(ocontext_t));
-	if (!newc) {
-		yyerror("out of memory");
+
+	sid = selinux_str_to_sid(id);
+	if (sid == 0) {
+		yyerror2("invalid initial SID %s", id);
 		goto bad;
 	}
-	memset(newc, 0, sizeof(ocontext_t));
-	newc->u.name = id;
-	context_init(&newc->context[0]);
-	head = policydbp->ocontexts[OCON_ISID];
 
+	head = policydbp->ocontexts[OCON_ISID];
 	for (c = head; c; c = c->next) {
-		if (!strcmp(newc->u.name, c->u.name)) {
+		if (sid == c->sid[0]) {
 			yyerror2("duplicate initial SID %s", id);
 			goto bad;
 		}
 	}
 
-	if (head) {
-		newc->sid[0] = head->sid[0] + 1;
-	} else {
-		newc->sid[0] = 1;
+	newc = (ocontext_t *) malloc(sizeof(ocontext_t));
+	if (!newc) {
+		yyerror("out of memory");
+		goto bad;
 	}
+	memset(newc, 0, sizeof(ocontext_t));
+	newc->u.name = id;
+	context_init(&newc->context[0]);
+	newc->sid[0] = sid;
 	newc->next = head;
 	policydbp->ocontexts[OCON_ISID] = newc;
 
@@ -4567,6 +4571,7 @@ static int parse_security_context(context_struct_t * c)
 int define_initial_sid_context(void)
 {
 	char *id;
+	sepol_security_id_t sid;
 	ocontext_t *c, *head;
 
 	if (pass == 1) {
@@ -4581,9 +4586,17 @@ int define_initial_sid_context(void)
 		yyerror("no sid name for SID context definition?");
 		return -1;
 	}
+
+	sid = selinux_str_to_sid(id);
+	if (sid == 0) {
+		yyerror2("invalid initial SID %s", id);
+		free(id);
+		return -1;
+	}
+
 	head = policydbp->ocontexts[OCON_ISID];
 	for (c = head; c; c = c->next) {
-		if (!strcmp(id, c->u.name))
+		if (sid == c->sid[0])
 			break;
 	}
 
-- 
2.36.1

