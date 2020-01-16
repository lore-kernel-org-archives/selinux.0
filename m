Return-Path: <SRS0=jI/q=3F=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DF5DC33CB1
	for <selinux@archiver.kernel.org>; Thu, 16 Jan 2020 12:04:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 350EE20663
	for <selinux@archiver.kernel.org>; Thu, 16 Jan 2020 12:04:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Lcu+tSYa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726440AbgAPMEy (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 16 Jan 2020 07:04:54 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:60964 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726370AbgAPMEx (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 16 Jan 2020 07:04:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1579176291;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VBjsbTKLWInXCZNCu2D+Hav+9iUtOgN9abWLjQLDMhw=;
        b=Lcu+tSYaiwSuJ2YswlNXS2p9FpubNZUlrpvFk3h4W275xsRajrjf4m2uo6btvO6RMV8/Hb
        y88cjXb7YYZDHrldgZztVg2JGthz+dtPzEcCZWBqDLdeG7rh39zWP65lzOx0SJJZySb4g3
        AfuHrcChWUkjzrg4QRManSprQ542nWU=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-197-NIYYgCE4PR-Jg5wa60jOyw-1; Thu, 16 Jan 2020 07:04:48 -0500
X-MC-Unique: NIYYgCE4PR-Jg5wa60jOyw-1
Received: by mail-wr1-f70.google.com with SMTP id u18so9153073wrn.11
        for <selinux@vger.kernel.org>; Thu, 16 Jan 2020 04:04:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VBjsbTKLWInXCZNCu2D+Hav+9iUtOgN9abWLjQLDMhw=;
        b=PVHlDevTb0MM8gFgS9qC35A4u2bndL9ULZD3mwRljW+jkBtwH4l/m+iRBLeUhp41Ej
         lgQj7wEmnZY2npK9KOdlNBlDqRckmG4VEcamoENnpPwD4EHO2QrkD/iSOpAvFItBAWDu
         sq1uErqbKGd99DkNNQ5u08z75geVnGsI8f7d6OA0hpxTwVEKiK3pimKkq0JJWM0p8V3q
         3OYyQdez6l0cchKStKo+6Sg5oxzPP1kzkjpXKY5LgczFaocBTCB65tL8I33mIr0Drnva
         XmS0SSo7MEafDylGXD8qVdvbTr1OEJSS0RXwguI5Uhp1tLYSRPlguvjqmkkl2TDl8VRH
         mQrQ==
X-Gm-Message-State: APjAAAWFhJ8xyYk+/P1945e2XDwNCbUo8pUyzu0QHpqyueNXWiJ2D0gW
        AxnvcVaQPGUybjidXrROhopFKmF/eG1xVRdqojDNxc070toFrrF9qSPBvRIMUvoUh46aW4hEpHC
        wCMX378gncFGi9L3uCA==
X-Received: by 2002:a05:600c:2059:: with SMTP id p25mr5887753wmg.161.1579176287340;
        Thu, 16 Jan 2020 04:04:47 -0800 (PST)
X-Google-Smtp-Source: APXvYqyzXj5dkHXUT1hxubDpyvdPI9hw5PlSg+pNhIeo9Mep2mG4mxdD0zL3GBa97NxIZh9u4hSlcQ==
X-Received: by 2002:a05:600c:2059:: with SMTP id p25mr5887735wmg.161.1579176287132;
        Thu, 16 Jan 2020 04:04:47 -0800 (PST)
Received: from omos.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id b67sm278117wmc.38.2020.01.16.04.04.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jan 2020 04:04:46 -0800 (PST)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     selinux@vger.kernel.org, Paul Moore <paul@paul-moore.com>
Cc:     Stephen Smalley <sds@tycho.nsa.gov>
Subject: [PATCH 6/6] selinux: generalize evaluate_cond_node()
Date:   Thu, 16 Jan 2020 13:04:39 +0100
Message-Id: <20200116120439.303034-7-omosnace@redhat.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200116120439.303034-1-omosnace@redhat.com>
References: <20200116120439.303034-1-omosnace@redhat.com>
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
index b0f71afcf4b8..887331a0cc3c 100644
--- a/security/selinux/ss/services.c
+++ b/security/selinux/ss/services.c
@@ -2954,8 +2954,7 @@ int security_set_bools(struct selinux_state *state, u32 len, int *values)
 			policydb->bool_val_to_struct[i]->state = 0;
 	}
 
-	for (i = 0; i < policydb->cond_list_len; i++)
-		evaluate_cond_node(policydb, &policydb->cond_list[i]);
+	evaluate_cond_nodes(policydb);
 
 	seqno = ++state->ss->latest_granting;
 	rc = 0;
@@ -3006,8 +3005,7 @@ static void security_preserve_bools(struct policydb *oldpolicydb,
 		if (booldatum)
 			booldatum->state = value;
 	}
-	for (i = 0; i < newpolicydb->cond_list_len; i++)
-		evaluate_cond_node(newpolicydb, &newpolicydb->cond_list[i]);
+	evaluate_cond_nodes(newpolicydb);
 }
 
 /*
-- 
2.24.1

