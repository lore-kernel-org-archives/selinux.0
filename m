Return-Path: <SRS0=WX8y=ON=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFEA4C04EBF
	for <selinux@archiver.kernel.org>; Tue,  4 Dec 2018 21:28:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6882F20850
	for <selinux@archiver.kernel.org>; Tue,  4 Dec 2018 21:28:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6882F20850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tycho.nsa.gov
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=selinux-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725886AbeLDV2R (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 4 Dec 2018 16:28:17 -0500
Received: from ucol19pa12.eemsg.mail.mil ([214.24.24.85]:59618 "EHLO
        ucol19pa12.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725899AbeLDV2Q (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 4 Dec 2018 16:28:16 -0500
X-EEMSG-check-008: 663810922|UCOL19PA12_EEMSG_MP10.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.56,315,1539648000"; 
   d="scan'208";a="663810922"
Received: from emsm-gh1-uea11.ncsc.mil ([214.29.60.3])
  by ucol19pa12.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 04 Dec 2018 21:28:12 +0000
X-IronPort-AV: E=Sophos;i="5.56,315,1539648000"; 
   d="scan'208";a="21334227"
IronPort-PHdr: =?us-ascii?q?9a23=3A+VCsOhX0QO0GRhbBveaA3zyRQ+rV8LGtZVwlr6?=
 =?us-ascii?q?E/grcLSJyIuqrYbBGGt8tkgFKBZ4jH8fUM07OQ7/iwHzRYqb+681k6OKRWUB?=
 =?us-ascii?q?EEjchE1ycBO+WiTXPBEfjxciYhF95DXlI2t1uyMExSBdqsLwaK+i764jEdAA?=
 =?us-ascii?q?jwOhRoLerpBIHSk9631+ev8JHPfglEnjWwba9xIRmssQndqtQdjJd/JKo21h?=
 =?us-ascii?q?bHuGZDdf5MxWNvK1KTnhL86dm18ZV+7SleuO8v+tBZX6nicKs2UbJXDDI9M2?=
 =?us-ascii?q?Ao/8LrrgXMTRGO5nQHTGoblAdDDhXf4xH7WpfxtTb6tvZ41SKHM8D6Uaw4VD?=
 =?us-ascii?q?K/5KhlUh/ojDoMOSA//m/Zl8d8iLtXrAy9qxB6xYPffYObO+dkfq7FYN0UW2?=
 =?us-ascii?q?RBUMZSWSJPDIyzYIkAAPYOM+tDs4nwpUEDoQeiCQSiBu7izCJDiH/s3a091u?=
 =?us-ascii?q?QsCRzI3BA+ENIWsHTbstP1P7oPX+Cw1qbIyTHDYO1W2Dzg74XIaQ0uoeqXUL?=
 =?us-ascii?q?Jsccve1UkvFwTfglWWsozqJSmZ1usKs2iF9udtU/+khW0/qwxpvzSiycghhp?=
 =?us-ascii?q?PJi44I0FzI6yp0zJgvKdGlTkNwfMSqH4FKty6AMot7WsYiQ2Z1tykk0rAGop?=
 =?us-ascii?q?u7fDQSyJQg2h7fd+SLc4iW7RLnU+acOSt4i2h/eLK+mhay6lKsyvH8V8ao0F?=
 =?us-ascii?q?ZKqTBJkt/QuXAWyxPf8M2HSvp5/ku52DaP0R7c6v1cLEwpmqfWJIQtz74tmp?=
 =?us-ascii?q?YJr0jOETH6lF/rgKOOc0Ur4Omo6+DpYrX8oZ+cMpd5ihrjPaQ1gcG/HeQ5PR?=
 =?us-ascii?q?QOX2ic4+i80qbj8lfjTLVFif02jLHVsIrGKsQDuq65HwhV35446xmhCzem0d?=
 =?us-ascii?q?IYnWQILV9eZhKHgJbmO0vULPD7E/i/mVKsnylvx/zcOb3hGJrNJGDZkLj9Zb?=
 =?us-ascii?q?Z991JcyA0rwNBH/Z1UF7UBLenrWkDrqdzYCgY1Mwmzw+bgEtVyyJkSVn6IAq?=
 =?us-ascii?q?+cKKnSq0OH5vozI+mQY48YoC3yK/0m5/7ykH84l14dcrev3ZYMZ3C4G+5pI0?=
 =?us-ascii?q?SdYXb2ntgBFmIK7UICS7nxhVmDVyNDT2i9Urh65TwhDo+iS4DZSdODmruEiR?=
 =?us-ascii?q?ynE4VWa2YOMVWFFXPlZs3QQPsXQD6DKc9m1DofXP6uTJF3hkLmjxPz17cydr?=
 =?us-ascii?q?mcwSYfr5+2kYIt6g=3D=3D?=
X-IPAS-Result: =?us-ascii?q?A2CYAADT8AZc/wHyM5BkHAEBAQQBAQcEAQGBUwUBAQsBg?=
 =?us-ascii?q?VopgTUzJ4N5lCdSBoEILYkRDo4qgXo4AYRAAoMKIjYHDQEDAQEBAQEBAgFsK?=
 =?us-ascii?q?II2JIJiAQEBAQIBIwQRQRALGAICJgICITYTBgIBAYJeP4FqAwgFCKUxfDOFQ?=
 =?us-ascii?q?IJJDYIcgQuLExd4gQeBESeCa4JXhS6CVwKJDQ+GXDdQjxwuCY4TgygGGIFbi?=
 =?us-ascii?q?DaHFYoJhHGLSgIvgVUrCAIYCCEPgyeCJxcSjikhAzCBBQEBimEBAQ?=
Received: from tarius.tycho.ncsc.mil ([144.51.242.1])
  by emsm-gh1-uea11.NCSC.MIL with ESMTP; 04 Dec 2018 21:28:11 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id wB4LSBnq011479;
        Tue, 4 Dec 2018 16:28:11 -0500
Subject: Re: [RFC][PATCH] selinux: avoid silent denials in permissive mode
 under RCU walk
To:     selinux@vger.kernel.org
Cc:     paul@paul-moore.com, bmktuwien@gmail.com
References: <20181204204209.21542-1-sds@tycho.nsa.gov>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <5472c4a0-43ea-ad7a-957f-a6cbc063c756@tycho.nsa.gov>
Date:   Tue, 4 Dec 2018 16:30:52 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.1
MIME-Version: 1.0
In-Reply-To: <20181204204209.21542-1-sds@tycho.nsa.gov>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 12/4/18 3:42 PM, Stephen Smalley wrote:
> commit 0dc1ba24f7fff6 ("SELINUX: Make selinux cache VFS RCU walks safe")
> results in no audit messages at all if in permissive mode because the
> cache is updated during the rcu walk and thus no denial occurs on
> the subsequent ref walk.  Fix this by not updating the cache when
> performing a non-blocking permission check.  This only affects search
> and symlink read checks during rcu walk.

Probably should drop "under RCU walk" from the subject line since the 
denials remain silent during the rcu walk itself but are then audited 
properly upon falling back to the ref walk when a denial occurs.

> 
> Fixes: 0dc1ba24f7fff6 ("SELINUX: Make selinux cache VFS RCU walks safe")
> Reported-by: BMK <bmktuwien@gmail.com>
> Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>
> ---
>   security/selinux/avc.c         | 9 ++++++---
>   security/selinux/hooks.c       | 4 +++-
>   security/selinux/include/avc.h | 1 +
>   3 files changed, 10 insertions(+), 4 deletions(-)
> 
> diff --git a/security/selinux/avc.c b/security/selinux/avc.c
> index 635e5c1e3e48..f0e7bc0dc442 100644
> --- a/security/selinux/avc.c
> +++ b/security/selinux/avc.c
> @@ -1021,8 +1021,10 @@ static noinline int avc_denied(struct selinux_state *state,
>   	    !(avd->flags & AVD_FLAGS_PERMISSIVE))
>   		return -EACCES;
>   
> -	avc_update_node(state->avc, AVC_CALLBACK_GRANT, requested, driver,
> -			xperm, ssid, tsid, tclass, avd->seqno, NULL, flags);
> +	if (!(flags & AVC_NONBLOCKING))
> +		avc_update_node(state->avc, AVC_CALLBACK_GRANT, requested,
> +				driver, xperm, ssid, tsid, tclass, avd->seqno,
> +				NULL, flags);
>   	return 0;
>   }
>   
> @@ -1199,7 +1201,8 @@ int avc_has_perm_flags(struct selinux_state *state,
>   	struct av_decision avd;
>   	int rc, rc2;
>   
> -	rc = avc_has_perm_noaudit(state, ssid, tsid, tclass, requested, 0,
> +	rc = avc_has_perm_noaudit(state, ssid, tsid, tclass, requested,
> +				  (flags & MAY_NOT_BLOCK) ? AVC_NONBLOCKING : 0,
>   				  &avd);
>   
>   	rc2 = avc_audit(state, ssid, tsid, tclass, requested, &avd, rc,
> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index 7ce012d9ec51..9b05f84808d9 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -3196,7 +3196,9 @@ static int selinux_inode_permission(struct inode *inode, int mask)
>   		return PTR_ERR(isec);
>   
>   	rc = avc_has_perm_noaudit(&selinux_state,
> -				  sid, isec->sid, isec->sclass, perms, 0, &avd);
> +				  sid, isec->sid, isec->sclass, perms,
> +				  (flags & MAY_NOT_BLOCK) ? AVC_NONBLOCKING : 0,
> +				  &avd);
>   	audited = avc_audit_required(perms, &avd, rc,
>   				     from_access ? FILE__AUDIT_ACCESS : 0,
>   				     &denied);
> diff --git a/security/selinux/include/avc.h b/security/selinux/include/avc.h
> index ef899bcfd2cb..74ea50977c20 100644
> --- a/security/selinux/include/avc.h
> +++ b/security/selinux/include/avc.h
> @@ -142,6 +142,7 @@ static inline int avc_audit(struct selinux_state *state,
>   
>   #define AVC_STRICT 1 /* Ignore permissive mode. */
>   #define AVC_EXTENDED_PERMS 2	/* update extended permissions */
> +#define AVC_NONBLOCKING    4	/* non blocking */
>   int avc_has_perm_noaudit(struct selinux_state *state,
>   			 u32 ssid, u32 tsid,
>   			 u16 tclass, u32 requested,
> 

