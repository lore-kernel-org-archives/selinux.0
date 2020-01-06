Return-Path: <SRS0=/M55=23=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C90D6C33C8C
	for <selinux@archiver.kernel.org>; Mon,  6 Jan 2020 16:03:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A79120707
	for <selinux@archiver.kernel.org>; Mon,  6 Jan 2020 16:03:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="RLggU0A7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726446AbgAFQDB (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 6 Jan 2020 11:03:01 -0500
Received: from mail25.static.mailgun.info ([104.130.122.25]:35805 "EHLO
        mail25.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726296AbgAFQDB (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 6 Jan 2020 11:03:01 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1578326580; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=lpJ0DhmwcXrocVyqRrj+zJqB313nI+3M4z6m9eAIYQY=; b=RLggU0A7NdCAQcB1NrBpnrvpD1+cuNtNef83beq8Wv9za09mi66314g+K7NhGTEGZ4lAIqzz
 J9QYhRRS3vo/PnRV3SVK/kl/x5zO18FZOvdcZI7nE73E9unfHybJxXM0quqYxCHmjiI0Ns9C
 g/mWpLbJJJzl2ZtPjva7/cdTksg=
X-Mailgun-Sending-Ip: 104.130.122.25
X-Mailgun-Sid: WyIxZmM3MiIsICJzZWxpbnV4QHZnZXIua2VybmVsLm9yZyIsICJiZTllNGEiXQ==
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e135a2f.7f43787833b0-smtp-out-n01;
 Mon, 06 Jan 2020 16:02:55 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id B3057C433A2; Mon,  6 Jan 2020 16:02:54 +0000 (UTC)
Received: from rsiddoji-linux.qualcomm.com (blr-c-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: rsiddoji)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 4B95DC43383;
        Mon,  6 Jan 2020 16:02:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 4B95DC43383
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=rsiddoji@codeaurora.org
From:   Ravi Kumar Siddojigari <rsiddoji@codeaurora.org>
To:     selinux@vger.kernel.org
Cc:     Ravi Kumar Siddojigari <rsiddoji@codeaurora.org>
Subject: [PATCH v3] selinux: move ibpkeys code under CONFIG_SECURITY_INFINIBAND.
Date:   Mon,  6 Jan 2020 21:31:53 +0530
Message-Id: <1578326514-22012-1-git-send-email-rsiddoji@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <[PATCH] selinux: move ibpkeys code under CONFIG_SECURITY_INFINIBAND.>
References: <[PATCH] selinux: move ibpkeys code under CONFIG_SECURITY_INFINIBAND.>
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org


please find the updated patch based on the review comments


Move cache based  pkey sid  retrieval code which was added
with  Commit "409dcf31" under CONFIG_SECURITY_INFINIBAND.
As its  going to alloc a new cache which impacts
low ram devices which was enabled by default.

Suggested-by: Paul Moore <paul@paul-moore.com>
Signed-off-by: Ravi Kumar Siddojigari <rsiddoji@codeaurora.org>
---
 security/selinux/Makefile         |  4 +++-
 security/selinux/include/ibpkey.h | 13 +++++++++++++
 2 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/security/selinux/Makefile b/security/selinux/Makefile
index ccf950409384..2000f95fb197 100644
--- a/security/selinux/Makefile
+++ b/security/selinux/Makefile
@@ -6,7 +6,7 @@
 obj-$(CONFIG_SECURITY_SELINUX) := selinux.o

 selinux-y := avc.o hooks.o selinuxfs.o netlink.o nlmsgtab.o netif.o \
-            netnode.o netport.o ibpkey.o \
+            netnode.o netport.o \
             ss/ebitmap.o ss/hashtab.o ss/symtab.o ss/sidtab.o ss/avtab.o \
             ss/policydb.o ss/services.o ss/conditional.o ss/mls.o ss/status.o

@@ -14,6 +14,8 @@ selinux-$(CONFIG_SECURITY_NETWORK_XFRM) += xfrm.o

 selinux-$(CONFIG_NETLABEL) += netlabel.o

+selinux-$(CONFIG_SECURITY_INFINIBAND) += ibpkey.o
+
 ccflags-y := -I$(srctree)/security/selinux -I$(srctree)/security/selinux/include

 $(addprefix $(obj)/,$(selinux-y)): $(obj)/flask.h
diff --git a/security/selinux/include/ibpkey.h b/security/selinux/include/ibpkey.h
index a2ebe397bcb7..040b93cca486 100644
--- a/security/selinux/include/ibpkey.h
+++ b/security/selinux/include/ibpkey.h
@@ -14,8 +14,21 @@
 #ifndef _SELINUX_IB_PKEY_H
 #define _SELINUX_IB_PKEY_H

+#ifdef CONFIG_SECURITY_INFINIBAND
 void sel_ib_pkey_flush(void);

 int sel_ib_pkey_sid(u64 subnet_prefix, u16 pkey, u32 *sid);

+#else
+
+static inline void sel_ib_pkey_flush(void) {
+  return;
+}
+
+static inline int sel_ib_pkey_sid(u64 subnet_prefix, u16 pkey, u32 *sid) {
+  *sid = SECINITSID_UNLABELED;
+  return 0;
+}
Move cache based  pkey sid  retrieval code which was added
with  Commit "409dcf31" under CONFIG_SECURITY_INFINIBAND.
As its  going to alloc a new cache which impacts
low ram devices which was enabled by default.

Suggested-by: Paul Moore <paul@paul-moore.com>
Signed-off-by: Ravi Kumar Siddojigari <rsiddoji@codeaurora.org>
---
 security/selinux/Makefile         |  4 +++-
 security/selinux/include/ibpkey.h | 13 +++++++++++++
 2 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/security/selinux/Makefile b/security/selinux/Makefile
index ccf950409384..2000f95fb197 100644
--- a/security/selinux/Makefile
+++ b/security/selinux/Makefile
@@ -6,7 +6,7 @@
 obj-$(CONFIG_SECURITY_SELINUX) := selinux.o

 selinux-y := avc.o hooks.o selinuxfs.o netlink.o nlmsgtab.o netif.o \
-            netnode.o netport.o ibpkey.o \
+            netnode.o netport.o \
             ss/ebitmap.o ss/hashtab.o ss/symtab.o ss/sidtab.o ss/avtab.o \
             ss/policydb.o ss/services.o ss/conditional.o ss/mls.o ss/status.o

@@ -14,6 +14,8 @@ selinux-$(CONFIG_SECURITY_NETWORK_XFRM) += xfrm.o

 selinux-$(CONFIG_NETLABEL) += netlabel.o

+selinux-$(CONFIG_SECURITY_INFINIBAND) += ibpkey.o
+
 ccflags-y := -I$(srctree)/security/selinux -I$(srctree)/security/selinux/include

 $(addprefix $(obj)/,$(selinux-y)): $(obj)/flask.h
diff --git a/security/selinux/include/ibpkey.h b/security/selinux/include/ibpkey.h
index a2ebe397bcb7..040b93cca486 100644
--- a/security/selinux/include/ibpkey.h
+++ b/security/selinux/include/ibpkey.h
@@ -14,8 +14,21 @@
 #ifndef _SELINUX_IB_PKEY_H
 #define _SELINUX_IB_PKEY_H

+#ifdef CONFIG_SECURITY_INFINIBAND
 void sel_ib_pkey_flush(void);

 int sel_ib_pkey_sid(u64 subnet_prefix, u16 pkey, u32 *sid);

+#else
+
+static inline void sel_ib_pkey_flush(void) {
+  return;
+}
+
+static inline int sel_ib_pkey_sid(u64 subnet_prefix, u16 pkey, u32 *sid) {
+  *sid = SECINITSID_UNLABELED;
+  return 0;
+}
+#endif
+
 #endif
--
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
