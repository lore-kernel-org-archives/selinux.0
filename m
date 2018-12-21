Return-Path: <SRS0=+qLe=O6=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84544C43387
	for <selinux@archiver.kernel.org>; Fri, 21 Dec 2018 20:40:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3DB3B2190A
	for <selinux@archiver.kernel.org>; Fri, 21 Dec 2018 20:40:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="FLZk9w4U"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387835AbeLUUkJ (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 21 Dec 2018 15:40:09 -0500
Received: from upbd19pa10.eemsg.mail.mil ([214.24.27.85]:46449 "EHLO
        upbd19pa10.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730319AbeLUUkJ (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 21 Dec 2018 15:40:09 -0500
X-EEMSG-check-017: 188644836|UPBD19PA10_EEMSG_MP10.csd.disa.mil
Received: from emsm-gh1-uea11.ncsc.mil ([214.29.60.3])
  by upbd19pa10.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 21 Dec 2018 20:40:04 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1545424805; x=1576960805;
  h=subject:to:references:from:message-id:date:mime-version:
   in-reply-to:content-transfer-encoding;
  bh=l0Wk/eo4PfNXpTNSS/LZBq/yZaHbIVk9aMvt1IG1AHY=;
  b=FLZk9w4UAGYRtzXmTEIEya5yIPxOyAVU652pDpIoXPzZ+wLCLAjyUWeW
   5DUgC/DkC+r2HiQYJQNvfh/zwAQTWq8R1aiMf+t8q8z7WRNk+kgdQK6Vs
   26bbIdYHOre+es0liyA+nW8VrALgLqnpHqJ4sNXQ1IkokT7yfa0jaLkl8
   u8XJHIQCJUDEv4J6zaBcYGzp5R0Xw1q66AvBP89P6ddAx7iOJdraSMRtL
   vph1uuYe6NFU98OydM3FQ3mNfET75T69PHiPvMdQgoDHj7XPTL3cSuKaT
   Wc6TfrvEka4Z26Pn/QfPOy6xOHT8ZZiuIw9/jMbwcxLJCMjzaX9TnUlpF
   A==;
X-IronPort-AV: E=Sophos;i="5.56,382,1539648000"; 
   d="scan'208";a="21990544"
IronPort-PHdr: =?us-ascii?q?9a23=3AcKuEzBxza+3sAXzXCy+O+j09IxM/srCxBDY+r6?=
 =?us-ascii?q?Qd2uwTIJqq85mqBkHD//Il1AaPAd2Lraocw8Pt8InYEVQa5piAtH1QOLdtbD?=
 =?us-ascii?q?Qizfssogo7HcSeAlf6JvO5JwYzHcBFSUM3tyrjaRsdF8nxfUDdrWOv5jAOBB?=
 =?us-ascii?q?r/KRB1JuPoEYLOksi7ze+/94HQbglSmDaxfa55IQmrownWqsQYm5ZpJLwryh?=
 =?us-ascii?q?vOrHtIeuBWyn1tKFmOgRvy5dq+8YB6/ShItP0v68BPUaPhf6QlVrNYFygpM3?=
 =?us-ascii?q?o05MLwqxbOSxaE62YGXWUXlhpIBBXF7A3/U5zsvCb2qvZx1S+HNsDtU7s6RS?=
 =?us-ascii?q?qt4LtqSB/wiScIKTg58H3MisdtiK5XuQ+tqwBjz4LRZoyaOuB+fqfAdt0EQ2?=
 =?us-ascii?q?RPUNtaWyhYDo+ic4cDCuwMNvtaoYbgvVsDtQawCxeiBO3vyTFGiHH50qI43O?=
 =?us-ascii?q?s9Hg/LxxAgEtAUvXjIsNn4OqUfXOaox6fI1zXDaPZW1C/g5ojUbB8hufGMUq?=
 =?us-ascii?q?x2ccHM1EcvEhnKjlGUqYP7PzKey+MAs3OG4Op7Tu+vl24mpB1xojio3MssjJ?=
 =?us-ascii?q?LJiZgPxlDL8iV53p84KNulQ0B4ed6pCIZcui6VOodsQs4uXntktDg1x7EYo5?=
 =?us-ascii?q?K3YS4Hw4k9yRHFcfyIaY2I7wrmVOaWPDh3mmpoeKm6hxau6UigzfD8VtWs3F?=
 =?us-ascii?q?ZKsCVFlt7Mu2gR1xPJ8MiHS+Z9/ly71TaT1wHc9uFEIUcumardN5Eh2aI/mo?=
 =?us-ascii?q?AWsUTCGi/6gET2jKmIeUU44uWk9uvqb7r8qpKcKoN4kB/yP6swlsClHOg0Kg?=
 =?us-ascii?q?0OUHKa+eS42r3j50r5QLBSg/0tj6bZq4vXJdgbp6GlAw9V1Zwv6xCkDzi8yt?=
 =?us-ascii?q?gYkn4HLExddBKdk4fpI03OIOz/DfqnhFSslTBrx+vAPrL7HprCMGPOkK3/cr?=
 =?us-ascii?q?lg605T0hYzwcpD6JJTD7ELOOjzVVPptNzEEh85NBS5w/35B9V514MeX3+PA6?=
 =?us-ascii?q?CCPaPMvl+H+PgvL/OPZIALojb9LeYq5/r0gX8+g18dcrGj3YELZ3CgAvRmP0?=
 =?us-ascii?q?KZbGL0gtgbDGcKuhEzTPTwh12fVT5ffnOyX6U75jEhFo2qF5vMRoeogO/J4C?=
 =?us-ascii?q?DuOZtafG1EQnWLCnHhfIiHE6MLbSWJJMZqnxQeWLShQpNn3har4kuy0LdjL+?=
 =?us-ascii?q?zJ6gUGup/5ktt4/evekVc17zMwR/yUzmXFamZzhG5AEyc/waRXuUVgzhKG1q?=
 =?us-ascii?q?9ijrpTEtkFtN1TVQJvDoLR1+x3DZjJXwvFetqYAAK9Ts6OHSA6TtV3xcQHJU?=
 =?us-ascii?q?l6BYPx3Vj4wyO2DupNxPSwD5su//eZhiKpKg=3D=3D?=
X-IPAS-Result: =?us-ascii?q?A2AoAQCPTh1c/wHyM5BkHAEBAQQBAQcEAQGBVAQBAQsBg?=
 =?us-ascii?q?VopgWgng32UYQEBAQEBAQaBCAgliSSQNjgBhEACgm4iNwYNAQMBAQEBAQECA?=
 =?us-ascii?q?WwogjopAYJnAQUjBBFRCw4KAgImAgJXBgEMBgIBAYJfP4F1DaYnfDOFQIRtg?=
 =?us-ascii?q?QuLNBd4gQeBOAyCX4gJglcCj2BJN5BlCZFjBhiRX4lTkiUigVYrCAIYCCEPg?=
 =?us-ascii?q?yeCJxeOOyEDMIEFAQGOLgEB?=
Received: from tarius.tycho.ncsc.mil ([144.51.242.1])
  by emsm-gh1-uea11.NCSC.MIL with ESMTP; 21 Dec 2018 20:40:04 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto.infosec.tycho.ncsc.mil [192.168.25.131])
        by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id wBLKe1kG004166;
        Fri, 21 Dec 2018 15:40:03 -0500
Subject: Re: [PATCH v2 1/2] selinux: never allow relabeling on context mounts
To:     Ondrej Mosnacek <omosnace@redhat.com>, selinux@vger.kernel.org,
        Paul Moore <paul@paul-moore.com>
References: <20181221201853.24015-1-omosnace@redhat.com>
 <20181221201853.24015-2-omosnace@redhat.com>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <b8346ac3-2735-240c-3c94-7662ef1a8243@tycho.nsa.gov>
Date:   Fri, 21 Dec 2018 15:42:27 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.1
MIME-Version: 1.0
In-Reply-To: <20181221201853.24015-2-omosnace@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 12/21/18 3:18 PM, Ondrej Mosnacek wrote:
> In the SECURITY_FS_USE_MNTPOINT case we never want to allow relabeling
> files/directories, so we should never set the SBLABEL_MNT flag. The
> 'special handling' in selinux_is_sblabel_mnt() is only intended for when
> the behavior is set to SECURITY_FS_USE_GENFS.
> 
> While there, make the logic in selinux_is_sblabel_mnt() more explicit
> and add a BUILD_BUG_ON() to make sure that introducing a new
> SECURITY_FS_USE_* forces a review of the logic.
> 
> Fixes: d5f3a5f6e7e7 ("selinux: add security in-core xattr support for pstore and debugfs")
> Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>

Reviewed-by: Stephen Smalley <sds@tycho.nsa.gov>

> ---
>   security/selinux/hooks.c | 40 +++++++++++++++++++++++++++++++---------
>   1 file changed, 31 insertions(+), 9 deletions(-)
> 
> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index 7ce012d9ec51..b4759bebeddc 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -497,16 +497,10 @@ static int may_context_mount_inode_relabel(u32 sid,
>   	return rc;
>   }
>   
> -static int selinux_is_sblabel_mnt(struct super_block *sb)
> +static int selinux_is_genfs_special_handling(struct super_block *sb)
>   {
> -	struct superblock_security_struct *sbsec = sb->s_security;
> -
> -	return sbsec->behavior == SECURITY_FS_USE_XATTR ||
> -		sbsec->behavior == SECURITY_FS_USE_TRANS ||
> -		sbsec->behavior == SECURITY_FS_USE_TASK ||
> -		sbsec->behavior == SECURITY_FS_USE_NATIVE ||
> -		/* Special handling. Genfs but also in-core setxattr handler */
> -		!strcmp(sb->s_type->name, "sysfs") ||
> +	/* Special handling. Genfs but also in-core setxattr handler */
> +	return	!strcmp(sb->s_type->name, "sysfs") ||
>   		!strcmp(sb->s_type->name, "pstore") ||
>   		!strcmp(sb->s_type->name, "debugfs") ||
>   		!strcmp(sb->s_type->name, "tracefs") ||
> @@ -516,6 +510,34 @@ static int selinux_is_sblabel_mnt(struct super_block *sb)
>   		  !strcmp(sb->s_type->name, "cgroup2")));
>   }
>   
> +static int selinux_is_sblabel_mnt(struct super_block *sb)
> +{
> +	struct superblock_security_struct *sbsec = sb->s_security;
> +
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
> +		return selinux_is_genfs_special_handling(sb);
> +
> +	/* Never allow relabeling on context mounts */
> +	case SECURITY_FS_USE_MNTPOINT:
> +	case SECURITY_FS_USE_NONE:
> +	default:
> +		return 0;
> +	}
> +}
> +
>   static int sb_finish_set_opts(struct super_block *sb)
>   {
>   	struct superblock_security_struct *sbsec = sb->s_security;
> 

