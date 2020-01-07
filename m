Return-Path: <SRS0=B3ih=24=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76292C33C8C
	for <selinux@archiver.kernel.org>; Tue,  7 Jan 2020 15:21:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4952B24656
	for <selinux@archiver.kernel.org>; Tue,  7 Jan 2020 15:21:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="CPNpB3se"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727880AbgAGPVX (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 7 Jan 2020 10:21:23 -0500
Received: from mail26.static.mailgun.info ([104.130.122.26]:24029 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728103AbgAGPVX (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 7 Jan 2020 10:21:23 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1578410482; h=Content-Transfer-Encoding: Content-Type:
 In-Reply-To: MIME-Version: Date: Message-ID: From: References: Cc: To:
 Subject: Sender; bh=6qTf0np1Gb2DbuInf2kcHcxHKGUWz8AlQtyJLQ+kEsk=; b=CPNpB3sepeAVORpXBXHZ95tkaUzZEU2KtS7PC5qh4gbZksbcsXVntefIRIXcc3oGUTAi2e6R
 xLB0kM59fT2pFosxg/K0iB/X5HLR3JFDNYMMass/qzCNNdV5sx6XawIPRS3YaAOYeHDeqelV
 aF5d5nygTFA0Go4RZ5X0mNcBbwI=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyIxZmM3MiIsICJzZWxpbnV4QHZnZXIua2VybmVsLm9yZyIsICJiZTllNGEiXQ==
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e14a1ed.7fe012eef688-smtp-out-n03;
 Tue, 07 Jan 2020 15:21:17 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 24EF4C4479C; Tue,  7 Jan 2020 15:21:16 +0000 (UTC)
Received: from [10.204.78.121] (blr-c-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: rsiddoji)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 84025C433A2;
        Tue,  7 Jan 2020 15:21:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 84025C433A2
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=rsiddoji@codeaurora.org
Subject: Re: [PATCH v3] selinux: move ibpkeys code under
 CONFIG_SECURITY_INFINIBAND.
To:     Paul Moore <paul@paul-moore.com>
Cc:     selinux@vger.kernel.org
References: <1578326514-22012-1-git-send-email-rsiddoji@codeaurora.org>
 <CAHC9VhRROm6esDfhTc5DUuA9ocmFN5dUyXHHv+=neeW4km8DMg@mail.gmail.com>
From:   Ravi Kumar Siddojigari <rsiddoji@codeaurora.org>
Message-ID: <54b618f1-879f-7233-b66e-0fa00c4cdde2@codeaurora.org>
Date:   Tue, 7 Jan 2020 20:51:12 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CAHC9VhRROm6esDfhTc5DUuA9ocmFN5dUyXHHv+=neeW4km8DMg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Move cache based  pkey sid  retrieval code which was added
with  Commit "409dcf31" under CONFIG_SECURITY_INFINIBAND.
As its  going to alloc a new cache which impacts
low ram devices which was enabled by default.

Suggested-by: Paul Moore <paul@paul-moore.com>
Signed-off-by: Ravi Kumar Siddojigari <rsiddoji@codeaurora.org>
---
  security/selinux/Makefile         |  4 +++-
  security/selinux/include/ibpkey.h | 13 +++++++++++++
  2 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/security/selinux/Makefile b/security/selinux/Makefile
index ccf950409384..2000f95fb197 100644
--- a/security/selinux/Makefile
+++ b/security/selinux/Makefile
@@ -6,7 +6,7 @@
  obj-$(CONFIG_SECURITY_SELINUX) := selinux.o

  selinux-y := avc.o hooks.o selinuxfs.o netlink.o nlmsgtab.o netif.o \
-         netnode.o netport.o ibpkey.o \
+         netnode.o netport.o \
           ss/ebitmap.o ss/hashtab.o ss/symtab.o ss/sidtab.o ss/avtab.o \
           ss/policydb.o ss/services.o ss/conditional.o ss/mls.o ss/status.o

@@ -14,6 +14,8 @@ selinux-$(CONFIG_SECURITY_NETWORK_XFRM) += xfrm.o

  selinux-$(CONFIG_NETLABEL) += netlabel.o

+selinux-$(CONFIG_SECURITY_INFINIBAND) += ibpkey.o
+
  ccflags-y := -I$(srctree)/security/selinux 
-I$(srctree)/security/selinux/include

  $(addprefix $(obj)/,$(selinux-y)): $(obj)/flask.h
diff --git a/security/selinux/include/ibpkey.h 
b/security/selinux/include/ibpkey.h
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
+  return;
+}
+
+static inline int sel_ib_pkey_sid(u64 subnet_prefix, u16 pkey, u32 *sid) {
+  *sid = SECINITSID_UNLABELED;
+  return 0;
+}
+#endif
+
  #endif
-- 
