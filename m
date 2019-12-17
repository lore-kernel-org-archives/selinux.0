Return-Path: <SRS0=4tRG=2H=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FB3AC43603
	for <selinux@archiver.kernel.org>; Tue, 17 Dec 2019 15:11:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13BD42146E
	for <selinux@archiver.kernel.org>; Tue, 17 Dec 2019 15:11:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="aHbuoAI2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727512AbfLQPLx (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 17 Dec 2019 10:11:53 -0500
Received: from mail25.static.mailgun.info ([104.130.122.25]:41102 "EHLO
        mail25.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727241AbfLQPLx (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 17 Dec 2019 10:11:53 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1576595512; h=Content-Transfer-Encoding: Content-Type:
 MIME-Version: Message-ID: Date: Subject: In-Reply-To: References: Cc:
 To: From: Sender; bh=ylXqbzs1H/AWvYTKBY6MBRtcApeQlVPDvffG41tIBV8=; b=aHbuoAI2b6M8u4Qp81jnuZaNRHh+9scXfZLm4dbnFhQf9EmChhTCRPCAuOdl2YYNybSwEQfF
 YS2phKJ7GUn21tnTUUDz1kRhy26SpFKM5oLi57P8KbL8bUdoyevRFtbBFJrwzaf4ntCFtIVJ
 terAdeJfSfQm+OTV+iJiGyYqC7E=
X-Mailgun-Sending-Ip: 104.130.122.25
X-Mailgun-Sid: WyIxZmM3MiIsICJzZWxpbnV4QHZnZXIua2VybmVsLm9yZyIsICJiZTllNGEiXQ==
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5df8f033.7fad33615730-smtp-out-n02;
 Tue, 17 Dec 2019 15:11:47 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 14577C43383; Tue, 17 Dec 2019 15:11:47 +0000 (UTC)
Received: from rsiddoji1 (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: rsiddoji)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 627CAC433CB;
        Tue, 17 Dec 2019 15:11:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 627CAC433CB
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=rsiddoji@codeaurora.org
From:   "Ravi Kumar Siddojigari" <rsiddoji@codeaurora.org>
To:     "'Paul Moore'" <paul@paul-moore.com>
Cc:     <selinux@vger.kernel.org>
References: <001501d5b3f8$bdc5b610$39512230$@codeaurora.org> <CAHC9VhQXrukJZWrc2ZxOZg5vvmJUHdQyuTJAKR0Kf7-qFEWGNQ@mail.gmail.com>
In-Reply-To: <CAHC9VhQXrukJZWrc2ZxOZg5vvmJUHdQyuTJAKR0Kf7-qFEWGNQ@mail.gmail.com>
Subject: RE: [PATCH] selinux: move pkey sid cache based retrieval under defconfig
Date:   Tue, 17 Dec 2019 20:41:42 +0530
Organization: The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,\na Linux Foundation Collaborative Project
Message-ID: <001a01d5b4ec$4c296340$e47c29c0$@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-us
Thread-Index: AQEaCzTOE2vCGV1YF4tBNqUZHN9u1QJdq/ZpqSLGQGA=
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Yes Paul,  it should be under  CONFIG_SECURITY_INFINIBAND thanks for =
correcting this .=20
Hope  we can taken it fwd as all the targets with disabled  InfiniBand =
can be gained .
Please find the updated path for review .=20

From 6a8c60eacd0b6e5189722bb1823864b6728c2e34 Mon Sep 17 00:00:00 2001
From: Ravi Kumar Siddojigari <rsiddoji@codeaurora.org>
Date: Wed, 11 Dec 2019 19:57:24 +0530
Subject: [PATCH] selinux: move ibpkeys code under =
CONFIG_SECURITY_INFINIBAND.

Move cache based  pkey sid  retrieval code which was added
with  Commit 409dcf31. under CONFIG_SECURITY_INFINIBAND.
As its  going to alloc a new cache which may impact
low ram devices which was enabled by default.

Change-Id: I80a13fb7bce8723c8c880cb77cbaee42db413a7a
Signed-off-by: Ravi Kumar Siddojigari <rsiddoji@codeaurora.org>
---
 security/selinux/Makefile         | 4 +++-
 security/selinux/hooks.c          | 6 ++++++
 security/selinux/include/objsec.h | 2 ++
 3 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/security/selinux/Makefile b/security/selinux/Makefile
index c7161f8..bf67fc8 100644
--- a/security/selinux/Makefile
+++ b/security/selinux/Makefile
@@ -6,12 +6,14 @@
 obj-$(CONFIG_SECURITY_SELINUX) :=3D selinux.o
=20
 selinux-y :=3D avc.o hooks.o selinuxfs.o netlink.o nlmsgtab.o netif.o \
-	     netnode.o netport.o ibpkey.o exports.o \
+	     netnode.o netport.o exports.o \=09
 	     ss/ebitmap.o ss/hashtab.o ss/symtab.o ss/sidtab.o ss/avtab.o \
 	     ss/policydb.o ss/services.o ss/conditional.o ss/mls.o ss/status.o
=20
 selinux-$(CONFIG_SECURITY_NETWORK_XFRM) +=3D xfrm.o
=20
+selinux-$(CONFIG_SECURITY_INFINIBAND) +=3D ibpkey.o
+
 selinux-$(CONFIG_NETLABEL) +=3D netlabel.o
=20
 ccflags-y :=3D -I$(srctree)/security/selinux =
-I$(srctree)/security/selinux/include
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index b1a9ac9..157faaf 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -94,7 +94,11 @@
 #include "netif.h"
 #include "netnode.h"
 #include "netport.h"
+
+#ifdef CONFIG_SECURITY_INFINIBAND
 #include "ibpkey.h"
+#endif
+
 #include "xfrm.h"
 #include "netlabel.h"
 #include "audit.h"
@@ -198,7 +202,9 @@ static int selinux_netcache_avc_callback(u32 event)
 static int selinux_lsm_notifier_avc_callback(u32 event)
 {
 	if (event =3D=3D AVC_CALLBACK_RESET) {
+#ifdef CONFIG_SECURITY_INFINIBAND
 		sel_ib_pkey_flush();
+#endif
 		call_lsm_notifier(LSM_POLICY_CHANGE, NULL);
 	}
=20
diff --git a/security/selinux/include/objsec.h =
b/security/selinux/include/objsec.h
index 4b0da5f..94e6322 100644
--- a/security/selinux/include/objsec.h
+++ b/security/selinux/include/objsec.h
@@ -149,11 +149,13 @@ struct ib_security_struct {
 	u32 sid;        /* SID of the queue pair or MAD agent */
 };
=20
+#ifdef CONFIG_SECURITY_INFINIBAND
 struct pkey_security_struct {
 	u64	subnet_prefix; /* Port subnet prefix */
 	u16	pkey;	/* PKey number */
 	u32	sid;	/* SID of pkey */
 };
+#endif
=20
 struct bpf_security_struct {
 	u32 sid;  /*SID of bpf obj creater*/
--=20
1.9.1


Regards,
Ravi


-----Original Message-----
From: selinux-owner@vger.kernel.org <selinux-owner@vger.kernel.org> On =
Behalf Of Paul Moore
Sent: Monday, December 16, 2019 7:56 PM
To: Ravi Kumar Siddojigari <rsiddoji@codeaurora.org>
Cc: selinux@vger.kernel.org
Subject: Re: [PATCH] selinux: move pkey sid cache based retrieval under =
defconfig

On Mon, Dec 16, 2019 at 5:13 AM Ravi Kumar Siddojigari =
<rsiddoji@codeaurora.org> wrote:
> Hi Team,
> We see an increase in the memory consumption from 4.9 ->4.19 kernel=20
> which is impacting the low_ram device .
> So thought of enabling only that are really needed for the such =20
> device where performance might not be of priority list .
> One such patch is on the  pkey sid cache  which was added with commit =
:"
> 409dcf31"
> which can be moved under defconfig where enabled by default and only=20
> disabled for low_ram targets.
> Which is going to save ram/reduce slub usage .

Why not just reuse CONFIG_SECURITY_INFINIBAND?  I'm guessing these =
systems are using the SELinux/IB controls at all, so why not remove them =
completely?

--
paul moore
www.paul-moore.com
