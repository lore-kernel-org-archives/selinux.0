Return-Path: <SRS0=Xw2L=2J=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28E5FC43603
	for <selinux@archiver.kernel.org>; Thu, 19 Dec 2019 14:19:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5975206D8
	for <selinux@archiver.kernel.org>; Thu, 19 Dec 2019 14:19:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="YxrwZvRl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726786AbfLSOTB (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 19 Dec 2019 09:19:01 -0500
Received: from mail25.static.mailgun.info ([104.130.122.25]:17509 "EHLO
        mail25.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726695AbfLSOTB (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 19 Dec 2019 09:19:01 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1576765140; h=Content-Transfer-Encoding: Content-Type:
 MIME-Version: Message-ID: Date: Subject: In-Reply-To: References: Cc:
 To: From: Sender; bh=6GKg6LUDj0/5gj13PtP7v6ttNeh17ZIiliA4FDrjVoQ=; b=YxrwZvRlQ836lQb5TDDQSXQcdMqBUKlcKxriSvmgyt7N4knBbsb8oij9UBxZxDhR9pLkXfud
 nF71woOW1QPMJpSCClQ7eNHXP9srzF+Rt7CAzL5++zMd1JwhAPwlGxI9mcY8j7MjfAxQe3D4
 pfg9IoQNY7KDYbLzwKGcqw/k6Vc=
X-Mailgun-Sending-Ip: 104.130.122.25
X-Mailgun-Sid: WyIxZmM3MiIsICJzZWxpbnV4QHZnZXIua2VybmVsLm9yZyIsICJiZTllNGEiXQ==
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5dfb86cd.7f0f5eea3848-smtp-out-n03;
 Thu, 19 Dec 2019 14:18:53 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id C705BC53811; Thu, 19 Dec 2019 14:18:52 +0000 (UTC)
Received: from rsiddoji1 (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: rsiddoji)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 7075AC53808;
        Thu, 19 Dec 2019 14:18:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 7075AC53808
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=rsiddoji@codeaurora.org
From:   "Ravi Kumar Siddojigari" <rsiddoji@codeaurora.org>
To:     "'Paul Moore'" <paul@paul-moore.com>
Cc:     <selinux@vger.kernel.org>, "'Stephen Smalley'" <sds@tycho.nsa.gov>
References: <002301d5b568$8149c7a0$83dd56e0$@codeaurora.org> <CAHC9VhRqsGQfO-7EYctCmcjXbPznh=+xm7OJ_oN1RLGWaywGag@mail.gmail.com>
In-Reply-To: <CAHC9VhRqsGQfO-7EYctCmcjXbPznh=+xm7OJ_oN1RLGWaywGag@mail.gmail.com>
Subject: RE: [PATCH] selinux: move ibpkeys code under CONFIG_SECURITY_INFINIBAND.
Date:   Thu, 19 Dec 2019 19:48:47 +0530
Organization: The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,\na Linux Foundation Collaborative Project
Message-ID: <000101d5b677$3cbb50d0$b631f270$@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-us
Thread-Index: AQIvJDMhxhQBIs1mLzpfW9yXOgn5oQGttGjRpwE30TA=
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Updated the path , moved header file also under the config key which was =
missed out in earlier patch.
--
From a53941d36621ccb53fba900cb9a762dded41dc96 Mon Sep 17 00:00:00 2001
From: Ravi Kumar Siddojigari <rsiddoji@codeaurora.org>
Date: Wed, 11 Dec 2019 19:57:24 +0530
Subject: [PATCH] selinux: move ibpkeys code under =
CONFIG_SECURITY_INFINIBAND.

Move cache based  pkey sid  retrieval code which was added
with  Commit 409dcf31. under CONFIG_SECURITY_INFINIBAND.
As its  going to alloc a new cache which may impact
low ram devices which was enabled by default.

Change-Id: I80a13fb7bce8723c8c880cb77cbaee42db413a7a
Suggested-by: Paul Moore <paul@paul-moore.com>
Signed-off-by: Ravi Kumar Siddojigari <rsiddoji@codeaurora.org>
---
 security/selinux/Makefile         | 4 +++-
 security/selinux/hooks.c          | 6 ++++++
 security/selinux/include/ibpkey.h | 2 ++
 security/selinux/include/objsec.h | 2 ++
 4 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/security/selinux/Makefile b/security/selinux/Makefile
index c7161f8..bf67fc8 100644
--- a/security/selinux/Makefile
+++ b/security/selinux/Makefile
@@ -6,12 +6,14 @@
 obj-$(CONFIG_SECURITY_SELINUX) :=3D selinux.o
=20
 selinux-y :=3D avc.o hooks.o selinuxfs.o netlink.o nlmsgtab.o netif.o \
-	     netnode.o netport.o ibpkey.o exports.o \
+	     netnode.o netport.o exports.o \
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
diff --git a/security/selinux/include/ibpkey.h =
b/security/selinux/include/ibpkey.h
index b17a19e..c90251b 100644
--- a/security/selinux/include/ibpkey.h
+++ b/security/selinux/include/ibpkey.h
@@ -24,8 +24,10 @@
 #ifndef _SELINUX_IB_PKEY_H
 #define _SELINUX_IB_PKEY_H
=20
+#ifdef CONFIG_SECURITY_INFINIBAND
 void sel_ib_pkey_flush(void);
=20
 int sel_ib_pkey_sid(u64 subnet_prefix, u16 pkey, u32 *sid);
=20
 #endif
+#endif
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


Br,



-----Original Message-----
From: Paul Moore <paul@paul-moore.com>=20
Sent: Thursday, December 19, 2019 7:39 AM
To: Ravi Kumar Siddojigari <rsiddoji@codeaurora.org>
Cc: selinux@vger.kernel.org; Stephen Smalley <sds@tycho.nsa.gov>
Subject: Re: [PATCH] selinux: move ibpkeys code under =
CONFIG_SECURITY_INFINIBAND.

On Wed, Dec 18, 2019 at 1:01 AM Ravi Kumar Siddojigari =
<rsiddoji@codeaurora.org> wrote:
> -----Original Message-----
> From: selinux-owner@vger.kernel.org <selinux-owner@vger.kernel.org> On =

> Behalf Of Ravi Kumar Siddojigari
> Sent: Tuesday, December 17, 2019 8:42 PM
> To: 'Paul Moore' <paul@paul-moore.com>
> Cc: selinux@vger.kernel.org
> Subject: RE: [PATCH] selinux: move pkey sid cache based retrieval=20
> under defconfig
>
> Yes Paul,  it should be under  CONFIG_SECURITY_INFINIBAND thanks for =
correcting this .
> Hope  we can taken it fwd as all the targets with disabled  InfiniBand =
can be gained .
> Please find the updated path for review .
>
> From 6a8c60eacd0b6e5189722bb1823864b6728c2e34 Mon Sep 17 00:00:00 2001
> From: Ravi Kumar Siddojigari <rsiddoji@codeaurora.org>
> Date: Wed, 11 Dec 2019 19:57:24 +0530
> Subject: [PATCH] selinux: move ibpkeys code under =
CONFIG_SECURITY_INFINIBAND.
>
> Move cache based  pkey sid  retrieval code which was added with  =
Commit 409dcf31. under CONFIG_SECURITY_INFINIBAND.
> As its  going to alloc a new cache which may impact low ram devices =
which was enabled by default.
>
> Change-Id: I80a13fb7bce8723c8c880cb77cbaee42db413a7a
> Signed-off-by: Ravi Kumar Siddojigari <rsiddoji@codeaurora.org>
> ---
>  security/selinux/Makefile         | 4 +++-
>  security/selinux/hooks.c          | 6 ++++++
>  security/selinux/include/objsec.h | 2 ++
>  3 files changed, 11 insertions(+), 1 deletion(-)

...

> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c index =

> b1a9ac9..157faaf 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -94,7 +94,11 @@
>  #include "netif.h"
>  #include "netnode.h"
>  #include "netport.h"
> +
> +#ifdef CONFIG_SECURITY_INFINIBAND
>  #include "ibpkey.h"
> +#endif

See the comments below ...


>  #include "xfrm.h"
>  #include "netlabel.h"
>  #include "audit.h"
> @@ -198,7 +202,9 @@ static int selinux_netcache_avc_callback(u32 =
event)  static int selinux_lsm_notifier_avc_callback(u32 event)  {
>         if (event =3D=3D AVC_CALLBACK_RESET) {
> +#ifdef CONFIG_SECURITY_INFINIBAND
>                 sel_ib_pkey_flush();
> +#endif
>                 call_lsm_notifier(LSM_POLICY_CHANGE, NULL);
>         }

In cases like the you see directly above, and in the #include further =
up, the kernel usually solves this by creating dummy function in the =
header file.  In this case, ibpkey.h would look something like this:

>>>
/* header comments, blah blah blah */

#ifndef _SELINUX_IB_PKEY_H
#define _SELINUX_IB_PKEY_H

#ifdef CONFIG_SECURITY_INFINIBAND
void sel_ib_pkey_flush(void);
int sel_ib_pkey_sid(u64 subnet_prefix, u16 pkey, u32 *sid); #else static =
inline void sel_ib_pkey_flush(void) {
  return;
}
static inline int sel_ib_pkey_sid(u64 subnet_prefix, u16 pkey, u32 *sid) =
{
  *sid =3D SECINITSID_UNLABELED;
  return 0;
}
#endif

#endif
>>>

Does that make sense?

--
paul moore
www.paul-moore.com
