Return-Path: <SRS0=ftCu=3G=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19AEEC33CB1
	for <selinux@archiver.kernel.org>; Fri, 17 Jan 2020 13:15:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9F9720728
	for <selinux@archiver.kernel.org>; Fri, 17 Jan 2020 13:15:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aGKSx7Mu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726908AbgAQNPU (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 17 Jan 2020 08:15:20 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:24040 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726329AbgAQNPU (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 17 Jan 2020 08:15:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1579266919;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=x/M0WoxFsburDsESKwVSd5K5XZRD8eYfp/HwirhlCek=;
        b=aGKSx7MuB6UJ0wclEuRxGa1Rr2giZjProGjKhz1gdKgSkT+l8yPbUfCXrRofbeOewYvFm9
        OKszRMuo1rnm5MBbMdju9DeuCwPJSU7zTBOQz0+HOYsKCYogcUQDaKvTtDBRFAn5Sy8jCD
        k/QQGHxg/BAwXelhRoQ6OTFjT3J3qMQ=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-49-7QxrBtPwOd6nl7_rma5U_A-1; Fri, 17 Jan 2020 08:15:18 -0500
X-MC-Unique: 7QxrBtPwOd6nl7_rma5U_A-1
Received: by mail-wr1-f70.google.com with SMTP id u12so10508272wrt.15
        for <selinux@vger.kernel.org>; Fri, 17 Jan 2020 05:15:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=x/M0WoxFsburDsESKwVSd5K5XZRD8eYfp/HwirhlCek=;
        b=RVQt89abnxFjkKUPt5e5nZx7CXnnv4Ks8ow8dOOdsLMzgERZczZ98XMimZP7kr9Jot
         12ehpWpKqoVWkMTwrFwkNGZ0knJAYTrN7Pim+wjpFhq+1zklNtwFOe6yZU9jCFh12OBg
         WpZrKqbteTPA75MrVR3q1MxLHTJeM3GXTZTvOX63i1iDKRXmU4QbrD11Wmz7nauGf2sL
         +XXGX+jdjf4JHo8N4WF0x4ZWWNH75qeXL2faWXzv2MfiDXhxGO8cMSNWJQkdaV9LOGsI
         NwFuPj4Q+BV83G6ETgjwC7KhH7md/6hUvymJnaK7YVFYdFy2xM0uOCtjj5Bp98aAKxz6
         sUUg==
X-Gm-Message-State: APjAAAUOCl5VbWGJgZ0BXto9BVsW50ujqBBCrn0GzMkHDQIZr2j8gzBT
        DFz0PMhKnKthvmBdaDZaDpRTIfVHDoWHVtYVOG3Om7x4acITtdtYMVgFOu/9wVQDUPuGUdbXcRn
        x0R1gomZxDh2QdnzO8w==
X-Received: by 2002:a05:600c:118a:: with SMTP id i10mr4648996wmf.142.1579266916594;
        Fri, 17 Jan 2020 05:15:16 -0800 (PST)
X-Google-Smtp-Source: APXvYqzOODwTThlikqbztqCA2XL3NBbw2hutyMUxj8s1dauuXUuJlXPInO2Ez5iVWBfo4OiIsz7NSw==
X-Received: by 2002:a05:600c:118a:: with SMTP id i10mr4648968wmf.142.1579266916344;
        Fri, 17 Jan 2020 05:15:16 -0800 (PST)
Received: from omos.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id f1sm9378702wmc.45.2020.01.17.05.15.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jan 2020 05:15:15 -0800 (PST)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     selinux@vger.kernel.org, Paul Moore <paul@paul-moore.com>
Cc:     Stephen Smalley <sds@tycho.nsa.gov>
Subject: [PATCH] selinux: move status variables out of selinux_ss
Date:   Fri, 17 Jan 2020 14:15:14 +0100
Message-Id: <20200117131514.496122-1-omosnace@redhat.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

It fits more naturally in selinux_state, since it reflects also global
state (the enforcing and policyload fields).

Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
---
 security/selinux/Makefile           |  4 ++--
 security/selinux/hooks.c            |  1 +
 security/selinux/include/security.h |  4 ++++
 security/selinux/ss/services.c      |  2 --
 security/selinux/ss/services.h      |  2 --
 security/selinux/{ss => }/status.c  | 32 ++++++++++++++---------------
 6 files changed, 23 insertions(+), 22 deletions(-)
 rename security/selinux/{ss => }/status.c (81%)

diff --git a/security/selinux/Makefile b/security/selinux/Makefile
index 2000f95fb197..0c77ede1cc11 100644
--- a/security/selinux/Makefile
+++ b/security/selinux/Makefile
@@ -6,9 +6,9 @@
 obj-$(CONFIG_SECURITY_SELINUX) := selinux.o
 
 selinux-y := avc.o hooks.o selinuxfs.o netlink.o nlmsgtab.o netif.o \
-	     netnode.o netport.o \
+	     netnode.o netport.o status.o \
 	     ss/ebitmap.o ss/hashtab.o ss/symtab.o ss/sidtab.o ss/avtab.o \
-	     ss/policydb.o ss/services.o ss/conditional.o ss/mls.o ss/status.o
+	     ss/policydb.o ss/services.o ss/conditional.o ss/mls.o
 
 selinux-$(CONFIG_SECURITY_NETWORK_XFRM) += xfrm.o
 
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 61085eb3cd24..f9224866d60a 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -7156,6 +7156,7 @@ static __init int selinux_init(void)
 	selinux_state.checkreqprot = selinux_checkreqprot_boot;
 	selinux_ss_init(&selinux_state.ss);
 	selinux_avc_init(&selinux_state.avc);
+	mutex_init(&selinux_state.status_lock);
 
 	/* Set the security state for the initial task. */
 	cred_init_security();
diff --git a/security/selinux/include/security.h b/security/selinux/include/security.h
index a39f9565d80b..f3a621058aba 100644
--- a/security/selinux/include/security.h
+++ b/security/selinux/include/security.h
@@ -108,6 +108,10 @@ struct selinux_state {
 	bool checkreqprot;
 	bool initialized;
 	bool policycap[__POLICYDB_CAPABILITY_MAX];
+
+	struct page *status_page;
+	struct mutex status_lock;
+
 	struct selinux_avc *avc;
 	struct selinux_ss *ss;
 } __randomize_layout;
diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
index 216ce602a2b5..5cf491768142 100644
--- a/security/selinux/ss/services.c
+++ b/security/selinux/ss/services.c
@@ -46,7 +46,6 @@
 #include <linux/in.h>
 #include <linux/sched.h>
 #include <linux/audit.h>
-#include <linux/mutex.h>
 #include <linux/vmalloc.h>
 #include <net/netlabel.h>
 
@@ -81,7 +80,6 @@ static struct selinux_ss selinux_ss;
 void selinux_ss_init(struct selinux_ss **ss)
 {
 	rwlock_init(&selinux_ss.policy_rwlock);
-	mutex_init(&selinux_ss.status_lock);
 	*ss = &selinux_ss;
 }
 
diff --git a/security/selinux/ss/services.h b/security/selinux/ss/services.h
index c5896f39e8f6..e9bddf33e53d 100644
--- a/security/selinux/ss/services.h
+++ b/security/selinux/ss/services.h
@@ -29,8 +29,6 @@ struct selinux_ss {
 	rwlock_t policy_rwlock;
 	u32 latest_granting;
 	struct selinux_map map;
-	struct page *status_page;
-	struct mutex status_lock;
 } __randomize_layout;
 
 void services_compute_xperms_drivers(struct extended_perms *xperms,
diff --git a/security/selinux/ss/status.c b/security/selinux/status.c
similarity index 81%
rename from security/selinux/ss/status.c
rename to security/selinux/status.c
index 3c554a442467..4bc8f809934c 100644
--- a/security/selinux/ss/status.c
+++ b/security/selinux/status.c
@@ -11,7 +11,7 @@
 #include <linux/mm.h>
 #include <linux/mutex.h>
 #include "avc.h"
-#include "services.h"
+#include "security.h"
 
 /*
  * The selinux_status_page shall be exposed to userspace applications
@@ -44,12 +44,12 @@ struct page *selinux_kernel_status_page(struct selinux_state *state)
 	struct selinux_kernel_status   *status;
 	struct page		       *result = NULL;
 
-	mutex_lock(&state->ss->status_lock);
-	if (!state->ss->status_page) {
-		state->ss->status_page = alloc_page(GFP_KERNEL|__GFP_ZERO);
+	mutex_lock(&state->status_lock);
+	if (!state->status_page) {
+		state->status_page = alloc_page(GFP_KERNEL|__GFP_ZERO);
 
-		if (state->ss->status_page) {
-			status = page_address(state->ss->status_page);
+		if (state->status_page) {
+			status = page_address(state->status_page);
 
 			status->version = SELINUX_KERNEL_STATUS_VERSION;
 			status->sequence = 0;
@@ -65,8 +65,8 @@ struct page *selinux_kernel_status_page(struct selinux_state *state)
 				!security_get_allow_unknown(state);
 		}
 	}
-	result = state->ss->status_page;
-	mutex_unlock(&state->ss->status_lock);
+	result = state->status_page;
+	mutex_unlock(&state->status_lock);
 
 	return result;
 }
@@ -81,9 +81,9 @@ void selinux_status_update_setenforce(struct selinux_state *state,
 {
 	struct selinux_kernel_status   *status;
 
-	mutex_lock(&state->ss->status_lock);
-	if (state->ss->status_page) {
-		status = page_address(state->ss->status_page);
+	mutex_lock(&state->status_lock);
+	if (state->status_page) {
+		status = page_address(state->status_page);
 
 		status->sequence++;
 		smp_wmb();
@@ -93,7 +93,7 @@ void selinux_status_update_setenforce(struct selinux_state *state,
 		smp_wmb();
 		status->sequence++;
 	}
-	mutex_unlock(&state->ss->status_lock);
+	mutex_unlock(&state->status_lock);
 }
 
 /*
@@ -107,9 +107,9 @@ void selinux_status_update_policyload(struct selinux_state *state,
 {
 	struct selinux_kernel_status   *status;
 
-	mutex_lock(&state->ss->status_lock);
-	if (state->ss->status_page) {
-		status = page_address(state->ss->status_page);
+	mutex_lock(&state->status_lock);
+	if (state->status_page) {
+		status = page_address(state->status_page);
 
 		status->sequence++;
 		smp_wmb();
@@ -120,5 +120,5 @@ void selinux_status_update_policyload(struct selinux_state *state,
 		smp_wmb();
 		status->sequence++;
 	}
-	mutex_unlock(&state->ss->status_lock);
+	mutex_unlock(&state->status_lock);
 }
-- 
2.24.1

