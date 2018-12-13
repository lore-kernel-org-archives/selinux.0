Return-Path: <SRS0=DV1m=OW=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20C0BC65BAE
	for <selinux@archiver.kernel.org>; Thu, 13 Dec 2018 16:16:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0DAF20879
	for <selinux@archiver.kernel.org>; Thu, 13 Dec 2018 16:16:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="A3lIzL1Y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D0DAF20879
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=tycho.nsa.gov
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=selinux-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728620AbeLMQQY (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 13 Dec 2018 11:16:24 -0500
Received: from upbd19pa11.eemsg.mail.mil ([214.24.27.86]:10084 "EHLO
        upbd19pa11.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727942AbeLMQQW (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 13 Dec 2018 11:16:22 -0500
X-EEMSG-check-008: 176321566|UPBD19PA11_EEMSG_MP11.csd.disa.mil
Received: from emsm-gh1-uea10.ncsc.mil ([214.29.60.2])
  by upbd19pa11.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 13 Dec 2018 16:16:18 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1544717778; x=1576253778;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=0bXPUiYHM8/v5WkjYRIkO9fLBWTWj3KX66RNzDf7MBA=;
  b=A3lIzL1YjMPH3Im/OEElvSXmctN8i8rZwzZgpQaC4YG473/XfbJzMuDJ
   0F2PG0TKjXmFnlwpnNjddx7AxLMeXn8m8A6j2NsStk0EoXySBGF1xuz3j
   XafTcQE+cnn9gfV6sUQdX222rXUeXxGwQUBlUEEm2KuaqujIfL1dTG3Bu
   8ZKMsOIWaQ5nSh8K8DYFECiu3RfXNWFdZGO3+teiRKyWp9hixpPB5JGhG
   guogugbrINKorwurxah5j9VhJu92Uo7Jz0uCancBivavraC6puJCWuAVr
   YUT1vPFe8eplqSR74+jf0pZHSPy7yem6WFIggGdEZfpfu+9HNgOffRfjs
   w==;
X-IronPort-AV: E=Sophos;i="5.56,349,1539648000"; 
   d="scan'208";a="18686635"
IronPort-PHdr: =?us-ascii?q?9a23=3AIIELexVvsg8hdpo7F0bsVH4GGDHV8LGtZVwlr6?=
 =?us-ascii?q?E/grcLSJyIuqrYZRaBvqdThVPEFb/W9+hDw7KP9fy4CSpYud6oizMrSNR0TR?=
 =?us-ascii?q?gLiMEbzUQLIfWuLgnFFsPsdDEwB89YVVVorDmROElRH9viNRWJ+iXhpTEdFQ?=
 =?us-ascii?q?/iOgVrO+/7BpDdj9it1+C15pbffxhEiCCybL9uLxi6txndutULioZ+N6g9zQ?=
 =?us-ascii?q?fErGFVcOpM32NoIlyTnxf45siu+ZNo7jpdtfE8+cNeSKv2Z6s3Q6BWAzQgKG?=
 =?us-ascii?q?A1+dbktQLfQguV53sTSXsZnxxVCAXY9h76X5Pxsizntuph3SSRIMP7QawoVT?=
 =?us-ascii?q?mk8qxmUwHjhjsZODEl8WHXks1wg7xdoBK9vBx03orYbJiIOPZiYq/ReNUXSm?=
 =?us-ascii?q?RbXsZVSidPHIWyYYUSBOYFJOpUspXxq14IoBCjBwejGfnvxydViHHo06000+?=
 =?us-ascii?q?cvHw/I0wMvHd0BrHvaoc7pNKoQS+250LXEwDvBYv5QxDzz6JLIchckofyUQL?=
 =?us-ascii?q?xwbdTeyVEvFwzbiFWbtJHrPzaP2eQJt2iU8ephXv+ohm48tg5xuSOixtssi4?=
 =?us-ascii?q?bVhoIVzUrI9SNiwIkvP9G4R0l7YcC9HZZWqiqUOYx2QsY4TGFpviY30rIGuZ?=
 =?us-ascii?q?+nfCgK1ZQo3ATTZOCAc4iN5B/oSeWfIS9giX54d7+yiAy+/Ei9xuHmSMW530?=
 =?us-ascii?q?hGojBYntTKq3sDzQbc6tKdRft45kqh3DGP2B3N5excOkA0kLbbK4Ymwr4tip?=
 =?us-ascii?q?ofqUTDETHymEXxlKKWal8r+vKp6+T6ebXqvIOcNo9ohQH+NaQigMq/DvgjMg?=
 =?us-ascii?q?cSRWSb/OW81Ln78U34RrVFkOE2n7HEvJ3VKskXvK60DxJP3oo95BuzES2q3M?=
 =?us-ascii?q?kAkXkCNl1FeRaHj4bzO1HJJfD1Fey/jEm3kDpw2/DHPqHuApXKLnTZlrfhZq?=
 =?us-ascii?q?xy51RTyAo009BT/4hUBa0ZIPLvRk/xs8TVDhg8Mwyz2ObnDs9y2Z8AVm+UGK?=
 =?us-ascii?q?+WLr7dsV+S6eIzOeWDeIgVuDPlIfg/+/HulWM5mUMafaSxxpsYdnS4HvVgI0?=
 =?us-ascii?q?WEbnvhmckBEWgUsQokVuDqi0ONUSRVZ3msW6Iw/DY7CJipDY3bXICinKSB3D?=
 =?us-ascii?q?unHp1Rfm1GEkqDEWrsd4ifQ/cDcj+SIst4njwBUrihTJUh2g+0uADmzLpnK/?=
 =?us-ascii?q?Le+jcEupL7yNh1++rTmAku+jx7FcSd1HyNT3lvnm4TWT82075woVZnxleAz6?=
 =?us-ascii?q?d4mfpYGsJX5/9TVQc6L5HcxfRgC9/uQgLBYsuJSFG+T9W6AzE8VdExzMEUY0?=
 =?us-ascii?q?Z7BdqiigrP3y2wA78aj7aLHoA78rrA33jtIMZw03LG1KggjlY4TMtAL2umi7?=
 =?us-ascii?q?V/9wjOHYHInVuWl6eweasA2y7N8X+JzXCSs0FATA5wTaLFUGgfZkTMq9T54F?=
 =?us-ascii?q?3NT6S1BLs7NwtB0cGDJbdKat3ml1lGQ+3jONuNK162zkC2CQyFxPupa5Hscm?=
 =?us-ascii?q?4Q322JD00DiAYa9nuuLwUyBi695WnZCWoqXUniZ0Lq7PlWtny2VAk3whuMYk?=
 =?us-ascii?q?kn0KC6vlYtjOGYA9YU2agJ8HM5oihwNE60wtaTDt2HvQcnd6JZN5d161hd0n?=
 =?us-ascii?q?/BrCRjMZG6aaNvnFgTd0JwpUyqnyl6CJhG2egnqzt+0AhaKq+C1l5FMTSC0s?=
 =?us-ascii?q?ajFKfQLzzJ4B23a6PQkmrb2dKS97ZHvO80sH3/rQqpEQwk6Hwh3N5LhSjPrq?=
 =?us-ascii?q?7WBRYfBMqiGn088AJ38vSDO3Ew?=
X-IPAS-Result: =?us-ascii?q?A2AKAQBXhRJc/wHyM5BjHAEBAQQBAQcEAQGBVAQBAQsBg?=
 =?us-ascii?q?VopZoECJ4N8lHkFBoEILYkhhSGLDDAIAYRAAoMDIjcGDQEDAQEBAQEBAgFsH?=
 =?us-ascii?q?AyCNiQBgmEBAQEBAgEjBBFBEAsOCgICJgICVwYBDAYCAQGCXj8BgXMFCA+nD?=
 =?us-ascii?q?nwzhUCEc4ELizEXeIEHgTiCa4MeAoRlglcCiT+GCEc3kEoJhw2KRgYYgimPI?=
 =?us-ascii?q?YkuhHaNASKBVisIAhgIIQ+DJwmFf4VChS8hAzCBBQEBjEgBAQ?=
Received: from tarius.tycho.ncsc.mil ([144.51.242.1])
  by EMSM-GH1-UEA10.NCSC.MIL with ESMTP; 13 Dec 2018 16:16:16 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto.infosec.tycho.ncsc.mil [192.168.25.131])
        by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id wBDGG92S024184;
        Thu, 13 Dec 2018 11:16:10 -0500
Subject: Re: [RFC PATCH 2/3] selinux: never allow relabeling on context mounts
To:     Ondrej Mosnacek <omosnace@redhat.com>, selinux@vger.kernel.org,
        Paul Moore <paul@paul-moore.com>, cgroups@vger.kernel.org,
        Tejun Heo <tj@kernel.org>
Cc:     Li Zefan <lizefan@huawei.com>, Johannes Weiner <hannes@cmpxchg.org>
References: <20181213141739.8534-1-omosnace@redhat.com>
 <20181213141739.8534-3-omosnace@redhat.com>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <282f3f4c-6d0a-985e-76d7-6472efabf09b@tycho.nsa.gov>
Date:   Thu, 13 Dec 2018 11:18:43 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.1
MIME-Version: 1.0
In-Reply-To: <20181213141739.8534-3-omosnace@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 12/13/18 9:17 AM, Ondrej Mosnacek wrote:
> In the SECURITY_FS_USE_MNTPOINT case we never want to allow relabeling
> files/directories, so we should never set the SBLABEL_MNT flag in this
> case. The 'special handling' in selinux_is_sblabel_mnt() is only
> intended for SECURITY_FS_USE_GENFS.
> 
> While there, make the logic in selinux_is_sblabel_mnt() more explicit
> and add a BUILD_BUG_ON() to make sure that introducing a new
> SECURITY_FS_USE_* forces a review of the logic.
> 
> Note that checkpatch.pl produces some false positives here, likely
> having problems recognizing the monstrous return statement...
> 
> Fixes: d5f3a5f6e7e7 ("selinux: add security in-core xattr support for pstore and debugfs")
> Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> ---
>   security/selinux/hooks.c | 41 ++++++++++++++++++++++++++++------------
>   1 file changed, 29 insertions(+), 12 deletions(-)
> 
> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index 7ce012d9ec51..d6d29ec54eab 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -501,19 +501,36 @@ static int selinux_is_sblabel_mnt(struct super_block *sb)
>   {
>   	struct superblock_security_struct *sbsec = sb->s_security;
>   
> -	return sbsec->behavior == SECURITY_FS_USE_XATTR ||
> -		sbsec->behavior == SECURITY_FS_USE_TRANS ||
> -		sbsec->behavior == SECURITY_FS_USE_TASK ||
> -		sbsec->behavior == SECURITY_FS_USE_NATIVE ||
> +	/*
> +	 * IMPORTANT: Double-check logic in this function when adding a new
> +	 * SECURITY_FS_USE_* definition!
> +	 */
> +	BUILD_BUG_ON(SECURITY_FS_USE_MAX != 7);
> +
> +	switch (sbsec->behavior) {
> +	case SECURITY_FS_USE_XATTR:
> +	case SECURITY_FS_USE_TRANS:
> +	case SECURITY_FS_USE_TASK:
> +	case SECURITY_FS_USE_NATIVE:
> +		return 1;
> +
> +	case SECURITY_FS_USE_GENFS:
>   		/* Special handling. Genfs but also in-core setxattr handler */
> -		!strcmp(sb->s_type->name, "sysfs") ||
> -		!strcmp(sb->s_type->name, "pstore") ||
> -		!strcmp(sb->s_type->name, "debugfs") ||
> -		!strcmp(sb->s_type->name, "tracefs") ||
> -		!strcmp(sb->s_type->name, "rootfs") ||
> -		(selinux_policycap_cgroupseclabel() &&
> -		 (!strcmp(sb->s_type->name, "cgroup") ||
> -		  !strcmp(sb->s_type->name, "cgroup2")));
> +		return	!strcmp(sb->s_type->name, "sysfs") ||
> +			!strcmp(sb->s_type->name, "pstore") ||
> +			!strcmp(sb->s_type->name, "debugfs") ||
> +			!strcmp(sb->s_type->name, "tracefs") ||
> +			!strcmp(sb->s_type->name, "rootfs") ||
> +			(selinux_policycap_cgroupseclabel() &&
> +			 (!strcmp(sb->s_type->name, "cgroup") ||
> +			  !strcmp(sb->s_type->name, "cgroup2")));
> +
> +	/* Never allow relabeling on context mounts */
> +	case SECURITY_FS_USE_MNTPOINT:
> +	case SECURITY_FS_USE_NONE:
> +	default:
> +		return 0;
> +	}
>   }

This looks sane to me. Note that 
https://github.com/SELinuxProject/selinux-kernel/issues/2 calls for 
replacing the use of hardcoded lists of filesystem types above with 
something more general.  Maybe you could at least abstract that part 
into its own function.

>   
>   static int sb_finish_set_opts(struct super_block *sb)
> 

