Return-Path: <SRS0=73iw=2C=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3AD9C2D0C9
	for <selinux@archiver.kernel.org>; Thu, 12 Dec 2019 13:53:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79F2E2173E
	for <selinux@archiver.kernel.org>; Thu, 12 Dec 2019 13:53:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="ba4HFLHi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729485AbfLLNxh (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 12 Dec 2019 08:53:37 -0500
Received: from UHIL19PA36.eemsg.mail.mil ([214.24.21.195]:39718 "EHLO
        UHIL19PA36.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729429AbfLLNxh (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 12 Dec 2019 08:53:37 -0500
X-EEMSG-check-017: 56972393|UHIL19PA36_ESA_OUT02.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.69,306,1571702400"; 
   d="scan'208";a="56972393"
Received: from emsm-gh1-uea11.ncsc.mil ([214.29.60.3])
  by UHIL19PA36.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 12 Dec 2019 13:53:35 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1576158815; x=1607694815;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=c0Vsp/3WqOkiTZq3oranh8R7opdKTL3sqSHmAPrWNIM=;
  b=ba4HFLHiMoQ67TyENo7f/XDjOQEbcUHLJGL++jjZWCHG04lHNH2TJUjd
   6ug7xXUElS2bj+2r6AIVnabisZrWuKZ74fHkah1Y23Xc2t0ayD91vl6Kw
   zuqPbsjA8spj9Cze9SLzQoiVa5Z/r1lMrIofi26PNG3mebMxYKR9tsS7l
   uHCWb9bwl27i2Oc9ft29xwEMYnzzKMFckHSFSAXWkV7OleQHVduQ6ovIZ
   tp+c4vLqigUrY8Ys8J4hLydi3oDlPw+b+R3sJpYVzYPBhn3Z9cBzFrn51
   3vVt/gpIeTHmcAawh9K38Ej6TOF72DQYSo75RkG2hyzvxzNJu1cHp6Ir5
   Q==;
X-IronPort-AV: E=Sophos;i="5.69,306,1571702400"; 
   d="scan'208";a="36658608"
IronPort-PHdr: =?us-ascii?q?9a23=3A4gS++B8xgBIf2f9uRHKM819IXTAuvvDOBiVQ1K?=
 =?us-ascii?q?B+0+MWIJqq85mqBkHD//Il1AaPAdyArasV1KGL7OjJYi8p2d65qncMcZhBBV?=
 =?us-ascii?q?cuqP49uEgeOvODElDxN/XwbiY3T4xoXV5h+GynYwAOQJ6tL1LdrWev4jEMBx?=
 =?us-ascii?q?7xKRR6JvjvGo7Vks+7y/2+94fcbglVijexe65+IRG0oAnetsQbg5ZpJ7osxB?=
 =?us-ascii?q?fOvnZGYfldy3lyJVKUkRb858Ow84Bm/i9Npf8v9NNOXLvjcaggQrNWEDopM2?=
 =?us-ascii?q?Yu5M32rhbDVheA5mEdUmoNjBVFBRXO4QzgUZfwtiv6sfd92DWfMMbrQ704RS?=
 =?us-ascii?q?iu4qF2QxLzliwJKyA2/33WisxojaJUvhShpwBkw4XJZI2ZLedycr/Bcd8fQ2?=
 =?us-ascii?q?dOUNxRVyhcCY2iaYUBAfcKMeJBo4Xjo1YCqB2zDhSuCuzy0D9FnmL407M00+?=
 =?us-ascii?q?ohEg/I0gIvEN0Mv3vIo9v4L7sSXOKvwaXU0TnOYfFb1DHg44bIaBAhpvSMUK?=
 =?us-ascii?q?ptf8rN10YvDwPFgUuWqYf4Ij2V0/4Cs2yf7+V+VeOklmkqqxpsrTi03coslo?=
 =?us-ascii?q?nIiZ4VylDD7yl5xp01KseiRE50Zt6kDoJduieHPIV1WsMvW3xktSk1x7EcuZ?=
 =?us-ascii?q?O3YTIGxIooyhLBcfCLbo6F6Q/5WumLOzd3nndldaq6hxa17Eev1PXxVtKx0F?=
 =?us-ascii?q?ZWtipFlcTMtmwV2xzT9MeHTvx981+92TmVzQDT6/xEIVsumaraLZ4hzLkwlo?=
 =?us-ascii?q?ENvkvfBCP2hEX3g7OWdkUj4OSo7fjoYq76qZOGMo90iwX+Prwvmsy5H+s4Lh?=
 =?us-ascii?q?ADU3WU9OmzzrHu/VD1TK9UgvA5jKXVqo3WKdwepqGjAg9V1ogj6wy4DzejyN?=
 =?us-ascii?q?kYhmQILEledRKbj4nmJ1HOIPfiAfe5mFSjii1nx//BPr3/GpnNNGTMkK/9fb?=
 =?us-ascii?q?Zh7E5R0AsyzdBF6JJSBbEBO/LzVVX2tNzbEx85NRe5w+bmCNVm14MeXWOPDb?=
 =?us-ascii?q?OeMKPUq1OH+uUvI+yUbo8PpDn9M+Ql5+LpjXIhgl8SY62p3ZoRaHClEfVrOF?=
 =?us-ascii?q?uZYXXyjdcbC2sKvRQxTPbsiFKcVT5ffXGyX7gz5jsjEoKpEZ/DRpyxgLyGxC?=
 =?us-ascii?q?q7EYBWZmdGC1+WF3foeJuIVuwMaCKPOMBgnCILVbm7R4A90hGusRfwy6B7Ie?=
 =?us-ascii?q?rM5i0YqZXj2cBt5+LJiBEy8Sd5D9yH3GGQS2F4h2YIRzgx3KBlv0Nx0EuM0a?=
 =?us-ascii?q?99g/ZAD9xc++tJUhsmNZ7b1+F1FcjyVRjbfteIU1arWc2mDisrTtIw2N8Oe0?=
 =?us-ascii?q?J9FM++gR/dxSaqBKUVl7PYTKAzp5nc1n/yOsA1+XbP0qZp20smS81ALm2vga?=
 =?us-ascii?q?1i8SDTBpXIl0SSkKDsfqMZimqF72qHzGyTrGlGXwNqF6bIR3YSYg3Rt9uqyF?=
 =?us-ascii?q?nFSuqVFbk/MgZHgfWHI69OZ8yh2U5KX9//Kd/eZCS3gG72ChGWkODfJLH2cn?=
 =?us-ascii?q?kQiX2OQHMPlBoeqDPfb1kz?=
X-IPAS-Result: =?us-ascii?q?A2AIAAB/RfJd/wHyM5BkGgEBAQEBAQEBAQMBAQEBEQEBA?=
 =?us-ascii?q?QICAQEBAYFsAwEBAQELAYFzgW0gEiqEA4kDhmsMgTeJaY9LgXsJAQEBAQEBA?=
 =?us-ascii?q?QEBNwEBhEACgi42Bw4CEAEBAQQBAQEBAQUDAQFshUOCOykBgnkBAQEBAyMEE?=
 =?us-ascii?q?UEQCxUDAgImAgJXBgEMBgIBAYJfP4JTJaxSdX8zhU+DL4FIgQ4oAYwxeYEHg?=
 =?us-ascii?q?TgPgl0+axkBhlSCXgSXA0aXJoI6gjyTNwYbhnSTTYpxg1qcPgExgVgrCAIYC?=
 =?us-ascii?q?CEPgydQERSQOI5MIwMwkCUBAQ?=
Received: from tarius.tycho.ncsc.mil (HELO tarius.infosec.tycho.ncsc.mil) ([144.51.242.1])
  by emsm-gh1-uea11.NCSC.MIL with ESMTP; 12 Dec 2019 13:53:34 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.infosec.tycho.ncsc.mil (8.14.7/8.14.4) with ESMTP id xBCDrBoI025086;
        Thu, 12 Dec 2019 08:53:14 -0500
Subject: Re: [PATCH] selinux: remove unnecessary selinux cred request
To:     Shaokun Zhang <zhangshaokun@hisilicon.com>, selinux@vger.kernel.org
Cc:     Yang Guo <guoyang2@huawei.com>, Paul Moore <paul@paul-moore.com>,
        Eric Paris <eparis@parisplace.org>
References: <1576116144-55503-1-git-send-email-zhangshaokun@hisilicon.com>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <a007fa81-1bc6-b243-bf94-b2858ed15222@tycho.nsa.gov>
Date:   Thu, 12 Dec 2019 08:53:51 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <1576116144-55503-1-git-send-email-zhangshaokun@hisilicon.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 12/11/19 9:02 PM, Shaokun Zhang wrote:
> From: Yang Guo <guoyang2@huawei.com>
> 
> task_security_struct was obtained at the beginning of may_create
> and selinux_inode_init_security, no need to obtain again.
> may_create will be called very frequently when create dir and file.
> 
> Cc: Paul Moore <paul@paul-moore.com>
> Cc: Stephen Smalley <sds@tycho.nsa.gov>
> Cc: Eric Paris <eparis@parisplace.org>
> Signed-off-by: Yang Guo <guoyang2@huawei.com>
> Signed-off-by: Shaokun Zhang <zhangshaokun@hisilicon.com>

Reviewed-by: Stephen Smalley <sds@tycho.nsa.gov>

> ---
>   security/selinux/hooks.c | 7 +++----
>   1 file changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index 116b4d644f68..64bc69426369 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -1833,8 +1833,8 @@ static int may_create(struct inode *dir,
>   	if (rc)
>   		return rc;
>   
> -	rc = selinux_determine_inode_label(selinux_cred(current_cred()), dir,
> -					   &dentry->d_name, tclass, &newsid);
> +	rc = selinux_determine_inode_label(tsec, dir, &dentry->d_name, tclass,
> +					   &newsid);
>   	if (rc)
>   		return rc;
>   
> @@ -2906,8 +2906,7 @@ static int selinux_inode_init_security(struct inode *inode, struct inode *dir,
>   
>   	newsid = tsec->create_sid;
>   
> -	rc = selinux_determine_inode_label(selinux_cred(current_cred()),
> -		dir, qstr,
> +	rc = selinux_determine_inode_label(tsec, dir, qstr,
>   		inode_mode_to_security_class(inode->i_mode),
>   		&newsid);
>   	if (rc)
> 

