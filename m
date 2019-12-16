Return-Path: <SRS0=HHao=2G=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06A11C43603
	for <selinux@archiver.kernel.org>; Mon, 16 Dec 2019 10:13:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CDB21206D3
	for <selinux@archiver.kernel.org>; Mon, 16 Dec 2019 10:13:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="reEfLMPI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727224AbfLPKN1 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 16 Dec 2019 05:13:27 -0500
Received: from mail25.static.mailgun.info ([104.130.122.25]:40031 "EHLO
        mail25.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727099AbfLPKN1 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 16 Dec 2019 05:13:27 -0500
X-Greylist: delayed 302 seconds by postgrey-1.27 at vger.kernel.org; Mon, 16 Dec 2019 05:13:24 EST
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1576491206; h=Content-Transfer-Encoding: Content-Type:
 MIME-Version: Message-ID: Date: Subject: To: From: Sender;
 bh=1vtyzgjHXkmAnklSV6EXehzxMTrEiDYXFQb7K7MPNyk=; b=reEfLMPIGHKY7rXrh3U9nM3oMVCvBH1JXUpbWT++ttV3juz+7VCCizd0YK15uJ9sMJPfLGL1
 ax0oVheszZKguYap8Oj4lckhKuYZcg+ay1IV1jpRhW4RgYiRPbg3ucaQmt/SRn4pgPp0ZnyN
 sMCo21ajM2SYFb9NK44NK1f3Bbk=
X-Mailgun-Sending-Ip: 104.130.122.25
X-Mailgun-Sid: WyIxZmM3MiIsICJzZWxpbnV4QHZnZXIua2VybmVsLm9yZyIsICJiZTllNGEiXQ==
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5df75794.7ff9bfc5df10-smtp-out-n03;
 Mon, 16 Dec 2019 10:08:20 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 4438DC433A2; Mon, 16 Dec 2019 10:08:20 +0000 (UTC)
Received: from rsiddoji1 (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: rsiddoji)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 179C0C43383
        for <selinux@vger.kernel.org>; Mon, 16 Dec 2019 10:08:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 179C0C43383
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=rsiddoji@codeaurora.org
From:   "Ravi Kumar Siddojigari" <rsiddoji@codeaurora.org>
To:     <selinux@vger.kernel.org>
Subject: [PATCH] selinux: move pkey sid cache based retrieval under defconfig
Date:   Mon, 16 Dec 2019 15:38:16 +0530
Organization: The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,\na Linux Foundation Collaborative Project
Message-ID: <001501d5b3f8$bdc5b610$39512230$@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-us
Thread-Index: AdWz+CypHkf7Klt6RBSwMcNWvYREAA==
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Hi Team, 
We see an increase in the memory consumption from 4.9 ->4.19 kernel which is
impacting the low_ram device .
So thought of enabling only that are really needed for the such  device
where performance might not be of priority list .
One such patch is on the  pkey sid cache  which was added with commit :"
409dcf31" 
which can be moved under defconfig where enabled by default and only
disabled for low_ram targets.
Which is going to save ram/reduce slub usage . 

--
From 1719256bbb8fe3e239be0928386a50b7b41752e8 Mon Sep 17 00:00:00 2001
From: Ravi Kumar Siddojigari <rsiddoji@codeaurora.org>
Date: Wed, 11 Dec 2019 19:57:24 +0530
Subject: [PATCH] selinux: move pkey sid cache based retrieval under
defconfig
 .

adding new  key CONFIG_FASTER_RETRIEVAL_PKEY_SID which is used to enable
cache based  pkey sid  retrieval code added with  Commit 409dcf31.
As this is going to alloc a new cache for this booster which may  impact
low ram devices .  By default  its enabled  for low_ram targets
they can disable this feature.

Change-Id: I80a13fb7bce8723c8c880cb77cbaee42db413a7a
Signed-off-by: Ravi Kumar Siddojigari <rsiddoji@codeaurora.org>
---
 security/selinux/Kconfig          | 10 ++++++++++
 security/selinux/Makefile         |  4 +++-
 security/selinux/hooks.c          | 10 ++++++++++
 security/selinux/include/objsec.h |  2 ++
 4 files changed, 25 insertions(+), 4 deletions(-)

diff --git a/security/selinux/Kconfig b/security/selinux/Kconfig
index 8af7a69..7bcc015 100644
--- a/security/selinux/Kconfig
+++ b/security/selinux/Kconfig
@@ -99,3 +99,13 @@ config SECURITY_SELINUX_CHECKREQPROT_VALUE
 	  via /selinux/checkreqprot if authorized by policy.
 
 	  If you are unsure how to answer this question, answer 0.
+
+config FASTER_RETRIEVAL_PKEY_SID
+	bool "quicker retrieval of PKey SIDs"
+        depends on SECURITY_SELINUX
+        default y
+        help
+         This option enables cache for quicker retrieval of PKey SIDs
+	 by storing the Pkey SIDs to cache.
+	 Better performance but penalty on memory (RAM ).
+	 for low ram devices better to say n.
diff --git a/security/selinux/Makefile b/security/selinux/Makefile
index c7161f8..192f4ba 100644
--- a/security/selinux/Makefile
+++ b/security/selinux/Makefile
@@ -6,12 +6,14 @@
 obj-$(CONFIG_SECURITY_SELINUX) := selinux.o
 
 selinux-y := avc.o hooks.o selinuxfs.o netlink.o nlmsgtab.o netif.o \
-	     netnode.o netport.o ibpkey.o exports.o \
+	     netnode.o netport.o exports.o \
 	     ss/ebitmap.o ss/hashtab.o ss/symtab.o ss/sidtab.o ss/avtab.o \
 	     ss/policydb.o ss/services.o ss/conditional.o ss/mls.o
ss/status.o
 
 selinux-$(CONFIG_SECURITY_NETWORK_XFRM) += xfrm.o
 
+selinux-$(CONFIG_FASTER_RETRIEVAL_PKEY_SID) += ibpkey.o
+
 selinux-$(CONFIG_NETLABEL) += netlabel.o
 
 ccflags-y := -I$(srctree)/security/selinux
-I$(srctree)/security/selinux/include
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index af030ff..60c4212 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -92,7 +92,11 @@
 #include "netif.h"
 #include "netnode.h"
 #include "netport.h"
+
+#ifdef CONFIG_FASTER_RETRIEVAL_PKEY_SID
 #include "ibpkey.h"
+#endif
+
 #include "xfrm.h"
 #include "netlabel.h"
 #include "audit.h"
@@ -177,7 +181,9 @@ static int selinux_netcache_avc_callback(u32 event)
 static int selinux_lsm_notifier_avc_callback(u32 event)
 {
 	if (event == AVC_CALLBACK_RESET) {
+#ifdef  CONFIG_FASTER_RETRIEVAL_PKEY_SID
 		sel_ib_pkey_flush();
+#endif
 		call_lsm_notifier(LSM_POLICY_CHANGE, NULL);
 	}
 
@@ -6246,7 +6252,11 @@ static int selinux_ib_pkey_access(void *ib_sec, u64
subnet_prefix, u16 pkey_val)
 	struct ib_security_struct *sec = ib_sec;
 	struct lsm_ibpkey_audit ibpkey;
 
+#ifdef CONFIG_FASTER_RETRIEVAL_PKEY_SID
 	err = sel_ib_pkey_sid(subnet_prefix, pkey_val, &sid);
+#else
+	err = security_ib_pkey_sid(subnet_prefix, pkey_val, &sid);
+#endif
 	if (err)
 		return err;
 
diff --git a/security/selinux/include/objsec.h
b/security/selinux/include/objsec.h
index 9cec304..5608978 100644
--- a/security/selinux/include/objsec.h
+++ b/security/selinux/include/objsec.h
@@ -147,11 +147,13 @@ struct ib_security_struct {
 	u32 sid;        /* SID of the queue pair or MAD agent */
 };
 
+#ifdef CONFIG_FASTER_RETRIEVAL_PKEY_SID
 struct pkey_security_struct {
 	u64	subnet_prefix; /* Port subnet prefix */
 	u16	pkey;	/* PKey number */
 	u32	sid;	/* SID of pkey */
 };
+#endif
 
 struct bpf_security_struct {
 	u32 sid;  /*SID of bpf obj creater*/
-- 
1.9.1

Regards,
Ravi
