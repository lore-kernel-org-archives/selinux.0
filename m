Return-Path: <SRS0=2SWW=27=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B083C282DD
	for <selinux@archiver.kernel.org>; Fri, 10 Jan 2020 15:13:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C445F2080D
	for <selinux@archiver.kernel.org>; Fri, 10 Jan 2020 15:13:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="d54yzq9X"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728224AbgAJPNC (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 10 Jan 2020 10:13:02 -0500
Received: from UHIL19PA35.eemsg.mail.mil ([214.24.21.194]:21494 "EHLO
        UHIL19PA35.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727866AbgAJPNC (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 10 Jan 2020 10:13:02 -0500
X-EEMSG-check-017: 64783764|UHIL19PA35_ESA_OUT01.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.69,417,1571702400"; 
   d="scan'208";a="64783764"
Received: from emsm-gh1-uea10.ncsc.mil ([214.29.60.2])
  by UHIL19PA35.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 10 Jan 2020 15:13:00 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1578669180; x=1610205180;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=PFfeXPBw0smxDS0WrH4VA2nq6kHPoNdXc4ScwnMoJbw=;
  b=d54yzq9XHRTUlpUQNfs445Le/UgymFZE8rnV5YKWhDBmP1gYUjlFus9J
   q2GmBJqkbxoHtNuZ7/KPdHwoQEuaPbzPUVELSYc3Xc8zAc26TArEYJ3GA
   i7CdDPu2LDLxNu3wp9AR96pBtROiCedZmqSnOoVqkbvSZSNiGKAnjnDwu
   0P9J8yuaN0bZlP0VoiAbOztcOzVOnTiJzlZR/hnvs/CkxRezPNWIrZlML
   elUEhBD62f2GdFNW7bx+m2LQXqCh+8BXgQMuAMwalTzjAbV61M+yXoevK
   WuCDVKFyiu5n9V4OkN/rPtmG4JjwZhgR/DaDQRGT5wdKKH6Cfphjkte6b
   g==;
X-IronPort-AV: E=Sophos;i="5.69,417,1571702400"; 
   d="scan'208";a="31813261"
IronPort-PHdr: =?us-ascii?q?9a23=3Ajfh1ExGxjBpYaES0NXCQUp1GYnF86YWxBRYc79?=
 =?us-ascii?q?8ds5kLTJ76pMu9bnLW6fgltlLVR4KTs6sC17ON9fq+Aidevt6oizMrSNR0TR?=
 =?us-ascii?q?gLiMEbzUQLIfWuLgnFFsPsdDEwB89YVVVorDmROElRH9viNRWJ+iXhpTEdFQ?=
 =?us-ascii?q?/iOgVrO+/7BpDdj9it1+C15pbffxhEiCCybL9vIhi6txvdu8gYjIdtK6s8yA?=
 =?us-ascii?q?bCr2dVdehR2W5mP0+YkQzm5se38p5j8iBQtOwk+sVdT6j0fLk2QKJBAjg+PG?=
 =?us-ascii?q?87+MPktR/YTQuS/XQcSXkZkgBJAwfe8h73WIr6vzbguep83CmaOtD2TawxVD?=
 =?us-ascii?q?+/4apnVAPkhSEaPDE36mHXjtF7grxdrhyvuhdzx5fYbY+ROfZ7eK7WYNEUSn?=
 =?us-ascii?q?dbXstJSiJPHI28YYsMAeQPM+lXoIvyqEcBoxalGQmhBvnixiNUinL436A31f?=
 =?us-ascii?q?kqHwHc3AwnGtIDqGnarMnrO6cKUeC60q/IxijeYfNTwzj97IzIfQ4hoPqRWr?=
 =?us-ascii?q?9watfeyVI0GgPZjlSftYzlPzSP2uQLqGiU9fBsVe2oi245sgx8pCWkyMQ0io?=
 =?us-ascii?q?TRm44YxV/J+T95zYooP9G0VkF2bcC+HJdNsSyRKpF4Tdk4Q25yvSY30rgGuZ?=
 =?us-ascii?q?mmcycU0Jkn3Bvfa+Cfc4iP/xLjSP6dITdmi3Jhf7Kynwqy/lK6yu39S8m0y0?=
 =?us-ascii?q?xGritDktnCsXANzALc5dSdRvth/kauxTaP1wfJ5uFCPU80jrbUJ4Qkwr4xkp?=
 =?us-ascii?q?ofqUXDHinol0XqlKKaa0op9+ey5+nnf7nqvIGQOoBqhg3kL6gigsm/Dv45Mg?=
 =?us-ascii?q?gKUWib4+O81Lj78E3iXbpKleY7krXZsZ/GJcQbobS1AwlO0ok58Rq/ADCm0M?=
 =?us-ascii?q?oAkXkdMF1FYA6Hj5TuO1zWIPH3E/e/g0+ynDt32/zLPKbsA5TKLnjDl7ftZ6?=
 =?us-ascii?q?py60lZyAAr19BQ+4pUCq0dIPL0QkLxrMbXDgI9MwGv2+boEsh91ocHVWKKBa?=
 =?us-ascii?q?+ZN7nSvkGS6u0zJOmMYZcfuCzhJPg9+/7ukXg5lEcDcqmxx5QXcnG4Hu99Lk?=
 =?us-ascii?q?WBe3XsmNYBEXwSvgo6VuPllEONXSRUZ3aoUKI2/is7B56+DYffWoCth6SM3C?=
 =?us-ascii?q?W+Hp1RfGBGEFGMEWzzeoWCQfgMbTydIs57njwDT7ihRJcr1Quyuw/i17pnMu?=
 =?us-ascii?q?3U9zUDtZ39zth16PPcmAoy9TNuC8Sd12GMT2dukmwUQD822bh1oVZhxVebza?=
 =?us-ascii?q?h4n/tYGMRP5/JJTwc2KIXRz+hkBND0XQLBYNCJREy6TdWhBDE7VsgxzMMWY0?=
 =?us-ascii?q?ZhB9WiiQjO3y6rA78TiryKC4U48rnC0HftOsZ90XfG1LUhjlU/R8tPMnCphr?=
 =?us-ascii?q?N79wfNHIPJjUqZmLiwdagG3y7C6n2DzWyQs0FcSgJwVr/FXX8HbEvMsdv5/l?=
 =?us-ascii?q?/CT6OpCbk/KQtO18qCKqpMat30glRLX+njONvAbGKrgWuwBgiHxqmKbIX0f2?=
 =?us-ascii?q?URxiLdCFILkwoL53aJKRA+Bju9o2LZFDFuEVPvY0Xx8ehxsX+7TVE7zxuMb0?=
 =?us-ascii?q?J/07q44QAVhfOCRPMJxL4Euzkuqy9yHFmj29LaEd2ApxBufK9Ee9My/E9H1X?=
 =?us-ascii?q?7Ftwx6JpGhL75thl4FcwhqpE7u0wt4CoNHkcg0q3Mm1hZ9KaWd0AAJSzTN/Y?=
 =?us-ascii?q?35O6bXJ2/9tCGiI/rH11HFio7OpY8d7/Q/7V7kuVftXlIr7nFPy9BI1z6Z4Z?=
 =?us-ascii?q?LQAUwZVpe1Gksv/gJ7vJnCazM8/JvQ3HZhd66uvXuK2dcuHvEk0T6mdtJSMe?=
 =?us-ascii?q?WDDgC2W9YXHcejAOwjn1y4aFQPO+UB2rQzOpada/ae2KOtdN1llTaigHUPtJ?=
 =?us-ascii?q?txyWqQ5iF8TajOxJ9DzPaGiFjUHwzghUus55ik0btPYisfSy/kmCU=3D?=
X-IPAS-Result: =?us-ascii?q?A2BoAAAAlBhe/wHyM5BlGgEBAQEBAQEBAQMBAQEBEQEBA?=
 =?us-ascii?q?QICAQEBAYF7gX2BbAEgEiqECYkDhmQBAQEBAQEGgRIliW6KJIckCQEBAQEBA?=
 =?us-ascii?q?QEBATcBAYRAAoIWOBMCEAEBAQQBAQEBAQUDAQFshUOCOymCegEBAQECASMEE?=
 =?us-ascii?q?UEQCxUDAgImAgJXBgEMBgIBAYJjP4JXBSCrFnV/M4VJg0OBPYEOKIwzeYEHg?=
 =?us-ascii?q?TgMA4JdPodZgl4EjVSJT0aXToJBgkiTXwYbmmotji2dBSKBWCsIAhgIIQ+DJ?=
 =?us-ascii?q?1AYDZJbF45BIwMwkTABAQ?=
Received: from tarius.tycho.ncsc.mil (HELO tarius.infosec.tycho.ncsc.mil) ([144.51.242.1])
  by EMSM-GH1-UEA10.NCSC.MIL with ESMTP; 10 Jan 2020 15:12:59 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.infosec.tycho.ncsc.mil (8.14.7/8.14.4) with ESMTP id 00AFCJ4C040830;
        Fri, 10 Jan 2020 10:12:19 -0500
Subject: Re: [PATCH] selinux: remove redundant msg_msg_alloc_security
To:     Huaisheng Ye <yehs2007@zoho.com>, paul@paul-moore.com,
        eparis@parisplace.org, jmorris@namei.org, serge@hallyn.com
Cc:     tyu1@lenovo.com, linux-security-module@vger.kernel.org,
        selinux@vger.kernel.org, linux-kernel@vger.kernel.org,
        Huaisheng Ye <yehs1@lenovo.com>
References: <20200110095856.76612-1-yehs2007@zoho.com>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <e71932ce-0687-02e5-5f34-980c0cad4ae9@tycho.nsa.gov>
Date:   Fri, 10 Jan 2020 10:13:40 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <20200110095856.76612-1-yehs2007@zoho.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 1/10/20 4:58 AM, Huaisheng Ye wrote:
> From: Huaisheng Ye <yehs1@lenovo.com>
> 
> selinux_msg_msg_alloc_security only calls msg_msg_alloc_security but
> do nothing else. And also msg_msg_alloc_security is just used by the
> former.
> 
> Remove the redundant function to simplify the code.

This seems to also be true of other _alloc_security functions, probably 
due to historical reasons.  Further, at least some of these functions no 
longer perform any allocation; they are just initialization functions 
now that allocation has been taken to the LSM framework, so possibly 
could be renamed and made to return void at some point.

> 
> Signed-off-by: Huaisheng Ye <yehs1@lenovo.com>

Acked-by: Stephen Smalley <sds@tycho.nsa.gov>

> ---
>   security/selinux/hooks.c | 17 ++++++-----------
>   1 file changed, 6 insertions(+), 11 deletions(-)
> 
> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index 9625b99..fb1b9da 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -5882,16 +5882,6 @@ static void ipc_init_security(struct ipc_security_struct *isec, u16 sclass)
>   	isec->sid = current_sid();
>   }
>   
> -static int msg_msg_alloc_security(struct msg_msg *msg)
> -{
> -	struct msg_security_struct *msec;
> -
> -	msec = selinux_msg_msg(msg);
> -	msec->sid = SECINITSID_UNLABELED;
> -
> -	return 0;
> -}
> -
>   static int ipc_has_perm(struct kern_ipc_perm *ipc_perms,
>   			u32 perms)
>   {
> @@ -5910,7 +5900,12 @@ static int ipc_has_perm(struct kern_ipc_perm *ipc_perms,
>   
>   static int selinux_msg_msg_alloc_security(struct msg_msg *msg)
>   {
> -	return msg_msg_alloc_security(msg);
> +	struct msg_security_struct *msec;
> +
> +	msec = selinux_msg_msg(msg);
> +	msec->sid = SECINITSID_UNLABELED;
> +
> +	return 0;
>   }
>   
>   /* message queue security operations */
> 

