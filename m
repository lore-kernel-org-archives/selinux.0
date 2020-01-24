Return-Path: <SRS0=mP8O=3N=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F8FFC2D0DB
	for <selinux@archiver.kernel.org>; Fri, 24 Jan 2020 18:53:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D2BF2075D
	for <selinux@archiver.kernel.org>; Fri, 24 Jan 2020 18:53:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="S7TmG+HD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388539AbgAXSxm (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 24 Jan 2020 13:53:42 -0500
Received: from USAT19PA23.eemsg.mail.mil ([214.24.22.197]:59680 "EHLO
        USAT19PA23.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391617AbgAXSxm (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 24 Jan 2020 13:53:42 -0500
X-EEMSG-check-017: 73189567|USAT19PA23_ESA_OUT04.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.70,358,1574121600"; 
   d="scan'208";a="73189567"
Received: from emsm-gh1-uea10.ncsc.mil ([214.29.60.2])
  by USAT19PA23.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 24 Jan 2020 18:52:48 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1579891968; x=1611427968;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=Rze7cn/GSJSTFQpc/Z8REuiFndHt8sF/HNqriHe3EXw=;
  b=S7TmG+HDPRCD9ZpNvcjJSuDQz7bBjsdjXZr9DUxvSfeS1RrRNGxV0DcX
   6wom1IjsUtgM5BZeql7qXjHxwgyFC5aQuRI8I5KKiYnFZgiWiqWJjIenS
   uKWda0AfAEe56ma1tf/0SyxZTxo/LL7rqRghGDRsxxfBXFnqTxtE1No0Y
   NqMUTEFoc0wYX3nYvZfkSFEcLWs5an+PfUSTEth8SeOUKRSNQgsphUGOo
   jTyB6s/0ay/0SRkCsZtNeNGdBCH8XDKyWBg1pHa/xeatjPcoonGOD9vqb
   5ID22ix+3a4LAYMn4B21SZjgMk9w1LmYeYHu5pj55sUPT3OC/hJDOsvnK
   w==;
X-IronPort-AV: E=Sophos;i="5.70,358,1574121600"; 
   d="scan'208";a="32312420"
IronPort-PHdr: =?us-ascii?q?9a23=3AuubD1xCus8mlfxm8AM1xUyQJP3N1i/DPJgcQr6?=
 =?us-ascii?q?AfoPdwSP36ocqwAkXT6L1XgUPTWs2DsrQY0raQ6fyrADVcqdbZ6TZeKccKD0?=
 =?us-ascii?q?dEwewt3CUYSPafDkP6KPO4JwcbJ+9lEGFfwnegLEJOE9z/bVCB6le77DoVBw?=
 =?us-ascii?q?mtfVEtfre9FYHdldm42P6v8JPPfQpImCC9YbRvJxmqsAndrMYbjZZtJ6or1B?=
 =?us-ascii?q?fErXREd/lLyW5nOFmfmwrw6tqq8JNs7ihdtegt+9JcXan/Yq81UaFWADM6Pm?=
 =?us-ascii?q?4v+cblrwPDTQyB5nsdVmUZjB9FCBXb4R/5Q5n8rDL0uvJy1yeGM8L2S6s0WS?=
 =?us-ascii?q?m54KdwVBDokiYHOCUn/2zRl8d9kbhUoBOlpxx43o7UfISYP+dwc6/BYd8XQ3?=
 =?us-ascii?q?dKU91PXCJdHIyzc4oPD/IAPelGqYn9u0AOpga6CQW1Ge/j1iNEinrw0KI0ye?=
 =?us-ascii?q?QhFRzN0hImEdwArX/YqMz5OakWXOywyqTD0DfNYO5M2Trl9YbGbB4hr/GPU7?=
 =?us-ascii?q?x+f8XexksgGB/KgFiLtYzoPCmY2vgRv2WV7edtU/+khW49qwF2pzii3toiip?=
 =?us-ascii?q?XXiYINylDL6yN5y5soK929UkF7ZdqkH4VQtiqHMIZ2Wd4tQ3pztSYmyrwJpZ?=
 =?us-ascii?q?67fC8QxJQh3B7QceaLc4eP4hL9TeucJypzinF9eL+nmhq//ketxvf8W8Wpyl?=
 =?us-ascii?q?pGsCVInsfWunwQ0RHY99KJReFn/ki73DaCzwXT6uZZLk8qjafbMJshwqIolp?=
 =?us-ascii?q?oUrETDAjf6mEXog6+ScUUp4vSo5P79YrXnu5+cLJV4igD4MqQgncy/Gvo3PR?=
 =?us-ascii?q?QUU2iH+eWzyL3j/UrjTLVMkvI2ibXWvIrfJcQaoq61Gw5V0oA95BajFzqqzd?=
 =?us-ascii?q?sVkHYdIF9FZR6LlZblNl7QLPziEPuzm1Gsny1qx/DCML3hGJLNLn3bnbf6YL?=
 =?us-ascii?q?l98FVRyBYzzN9D55JUDasNIPToWkDrrtDYARg5MxKsz+b9FNp9zp8eWX6IAq?=
 =?us-ascii?q?KBLKzSvl6J5uUpI+aSf48Yozn9K/8i5/7hiX82h1odcrOo3ZsTcny3AvNmI0?=
 =?us-ascii?q?CBa3r2ntgBCXsKvhY5TOHykF2NSyNTZ3KpUqIk/D47FYamAZ7GRoCqh7yBxj?=
 =?us-ascii?q?m0EodKaWBBD1CGCW3oeJmcW/cQdCKSJddsnSIcVbe7UY8h1AquuRTiy7V9NO?=
 =?us-ascii?q?rU+zYYtYrn1Ndv++Lciws+9TtuD8SSy2uNVX17nnsURz8q26ByuUt9ylKE0a?=
 =?us-ascii?q?hjhfxXD8Bc6O1SXwcgK5HT0ux6BMruWg7bYtiJT1OmSM28AT4tVtIx38MOY0?=
 =?us-ascii?q?FlFtW5kB/D2yuqA7kIl72EH5E07K3c0GbrJ8pnyHbJyrMhj184TctLL2Gmgb?=
 =?us-ascii?q?R/9wfLDY7Tj0qZj7qqdbgb3CPV8GeDzGyOvFxXUQJpUqXKQ2ofZk3IotT9/U?=
 =?us-ascii?q?7CUbCuBqo9Mgdbys6NNLFKatv3glVCXvvjP87eY23i01u3UD2I3LKXcIvjfV?=
 =?us-ascii?q?IyQjnBE0MEnkhH9nmUMg4zHQ+upGXRCDFrHFPrJUjr9L8thmm8SxoP0wySb0?=
 =?us-ascii?q?Bnn4Gw8xoRiO3UH+gfxZoYqSwhrHNyB1/70NXIXYnT7zF9dblRNItuqGxM0n?=
 =?us-ascii?q?jU4kkkZc2t?=
X-IPAS-Result: =?us-ascii?q?A2BrAgAzPCte/wHyM5BlHAEBAQEBBwEBEQEEBAEBgXuBf?=
 =?us-ascii?q?YFtIBIqhBKJA4Z5BoE3iW+RSQkBAQEBAQEBAQE3AQGEQAKCRjgTAhABAQEEA?=
 =?us-ascii?q?QEBAQEFAwEBbIVDgjspAYJ6AQUjBAsBBUEQCxgCAiYCAlcGDQYCAQGCYz+CS?=
 =?us-ascii?q?wMJJa4jfzOFSoJJDWKBPoEOKowxeYEHgTgPgl0+ghuCCIM2gl4EllOBJ5deg?=
 =?us-ascii?q?kOCTJNlBhuafKt+IoFYKwgCGAghD4MnUBgNiA0XjkEjAzCLFIJCAQE?=
Received: from tarius.tycho.ncsc.mil (HELO tarius.infosec.tycho.ncsc.mil) ([144.51.242.1])
  by EMSM-GH1-UEA10.NCSC.MIL with ESMTP; 24 Jan 2020 18:52:47 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.infosec.tycho.ncsc.mil (8.14.7/8.14.4) with ESMTP id 00OIq2GH101408;
        Fri, 24 Jan 2020 13:52:04 -0500
Subject: Re: [PATCH] selinux: allow kernfs symlinks to inherit parent
 directory context
To:     =?UTF-8?Q?Christian_G=c3=b6ttsche?= <cgzones@googlemail.com>
Cc:     Paul Moore <paul@paul-moore.com>,
        Eric Paris <eparis@parisplace.org>,
        Ondrej Mosnacek <omosnace@redhat.com>, selinux@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20200124184221.322248-1-cgzones@googlemail.com>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <6e33cbcd-31fd-2d50-5d0f-70eb475f9811@tycho.nsa.gov>
Date:   Fri, 24 Jan 2020 13:53:30 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <20200124184221.322248-1-cgzones@googlemail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 1/24/20 1:42 PM, Christian Göttsche wrote:
> Currently symlinks on kernel filesystems, like sysfs, are labeled on
> creation with the parent fs root sid.
> 
> Allow symlinks to inherit the parent directory context, so fine-grained
> kernfs labeling can be applied to symlinks too and checking contexts
> doesn't complain about them.
> 
> For backward-compatibility this behavior is contained in a new policy
> capability: kernfs_sovereign_symlinks
> 
> Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
> ---
>   security/selinux/hooks.c            | 5 ++++-
>   security/selinux/include/security.h | 8 ++++++++
>   security/selinux/ss/services.c      | 3 ++-
>   3 files changed, 14 insertions(+), 2 deletions(-)
> 
> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index d9e8b2131..1303bc8c4 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -1475,7 +1475,10 @@ static int inode_doinit_with_dentry(struct inode *inode, struct dentry *opt_dent
>   		/* Default to the fs superblock SID. */
>   		sid = sbsec->sid;
>   
> -		if ((sbsec->flags & SE_SBGENFS) && !S_ISLNK(inode->i_mode)) {
> +		if (((sbsec->flags & SE_SBGENFS) &&
> +		     (!S_ISLNK(inode->i_mode))) ||
> +		    (selinux_policycap_kernfs_sovereign_symlinks() &&

Not fond of the name.  1) kernfs is a kernel implementation detail, 
shouldn't be exposed to policy; genfs is the policy construct 2) 
sovereign doesn't seem to fit the meaning of this capability; seclabel 
would be more appropriate.

> +		     (sbsec->flags & SE_SBGENFS_XATTR))) {

Why limit this to SE_SBGENFS_XATTR filesystems?  Why not just make the test:
	if ((sbsec->flags & SE_SBGENFS) && (!S_ISLNK(inode->i_mode) || 
selinux_policycap_genfs_symlinkseclabel()))
or similar.

>   			/* We must have a dentry to determine the label on
>   			 * procfs inodes */
>   			if (opt_dentry) {
> diff --git a/security/selinux/include/security.h b/security/selinux/include/security.h
> index a39f9565d..cc8217848 100644
> --- a/security/selinux/include/security.h
> +++ b/security/selinux/include/security.h
> @@ -79,6 +79,7 @@ enum {
>   	POLICYDB_CAPABILITY_ALWAYSNETWORK,
>   	POLICYDB_CAPABILITY_CGROUPSECLABEL,
>   	POLICYDB_CAPABILITY_NNP_NOSUID_TRANSITION,
> +	POLICYDB_CAPABILITY_KERNFS_SOVEREIGN_SYMLINKS,
>   	__POLICYDB_CAPABILITY_MAX
>   };
>   #define POLICYDB_CAPABILITY_MAX (__POLICYDB_CAPABILITY_MAX - 1)
> @@ -209,6 +210,13 @@ static inline bool selinux_policycap_nnp_nosuid_transition(void)
>   	return state->policycap[POLICYDB_CAPABILITY_NNP_NOSUID_TRANSITION];
>   }
>   
> +static inline bool selinux_policycap_kernfs_sovereign_symlinks(void)
> +{
> +	struct selinux_state *state = &selinux_state;
> +
> +	return state->policycap[POLICYDB_CAPABILITY_KERNFS_SOVEREIGN_SYMLINKS];
> +}
> +
>   int security_mls_enabled(struct selinux_state *state);
>   int security_load_policy(struct selinux_state *state,
>   			 void *data, size_t len);
> diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
> index 216ce602a..b70380947 100644
> --- a/security/selinux/ss/services.c
> +++ b/security/selinux/ss/services.c
> @@ -73,7 +73,8 @@ const char *selinux_policycap_names[__POLICYDB_CAPABILITY_MAX] = {
>   	"extended_socket_class",
>   	"always_check_network",
>   	"cgroup_seclabel",
> -	"nnp_nosuid_transition"
> +	"nnp_nosuid_transition",
> +	"kernfs_sovereign_symlinks"
>   };
>   
>   static struct selinux_ss selinux_ss;
> 

