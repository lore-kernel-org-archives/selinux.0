Return-Path: <SRS0=lcCQ=3X=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53219C35247
	for <selinux@archiver.kernel.org>; Mon,  3 Feb 2020 15:38:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23D6E2082E
	for <selinux@archiver.kernel.org>; Mon,  3 Feb 2020 15:38:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="k3aqCYvF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727183AbgBCPi2 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 3 Feb 2020 10:38:28 -0500
Received: from USAT19PA21.eemsg.mail.mil ([214.24.22.195]:7668 "EHLO
        USAT19PA21.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726272AbgBCPi2 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 3 Feb 2020 10:38:28 -0500
X-EEMSG-check-017: 76471922|USAT19PA21_ESA_OUT02.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.70,398,1574121600"; 
   d="scan'208";a="76471922"
Received: from emsm-gh1-uea10.ncsc.mil ([214.29.60.2])
  by USAT19PA21.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 03 Feb 2020 15:35:09 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1580744110; x=1612280110;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=tATQjSoqZm6pZEWvsCNlErsHnJJ/ACe3zakLZ8pg3G8=;
  b=k3aqCYvFukKJK6FLh0SJerWcPJb2pJ6Pe6NbHKujiMe77UGp7mDpG4yu
   zOGNZXQW4qmBblqy9qqEhYEjQgK7B+KBcwxrnHaVyInhOyhKz/upvmyAZ
   /+arg5Hoa3wOstXWteXgR+CrSMfzPR5OJly7gCFCH3IumFP/IjEBAjeyN
   gnV8mIPZ9XIKy7SDo5NvwYsgt0sIQyInmF9EK1qRRYyaSmCPk/2lkb/+V
   JpqJMAK2orO/fhjs2eKnOCaS3eNqsVaNCtzSFzSOM1cvQeEDUFxuHpZVz
   87LM/AhUFvjM9IRId1cAfu/YNFjWXEhQsmmqorcN05KpSEK1TdS/NAf2O
   A==;
X-IronPort-AV: E=Sophos;i="5.70,398,1574121600"; 
   d="scan'208";a="32609932"
IronPort-PHdr: =?us-ascii?q?9a23=3ARIO6DRbgusi76dws9/l5VW3/LSx+4OfEezUN45?=
 =?us-ascii?q?9isYplN5qZpsy8YR7h7PlgxGXEQZ/co6odzbaP7+a8Bidfut7B6ClELMUXEU?=
 =?us-ascii?q?ddyI0/pE8JOIa9E0r1LfrnPWQRPf9pcxtbxUy9KlVfA83kZlff8TWY5D8WHQ?=
 =?us-ascii?q?jjZ0IufrymUoHdgN6q2O+s5pbdfxtHhCanYbN1MR66sRjdutMZjId/Jas90B?=
 =?us-ascii?q?TEr3lHd+lUy25jOFafkwrh6suq85Nv7ipdt+g9+8JcVKnxYrg1Q6FfADk6KW?=
 =?us-ascii?q?4++dfltQPETQuB53scVnsZnx9VCAXb7x/0Q4n8vDLiuuVyxCeVM8v2TaspWT?=
 =?us-ascii?q?u59KdkVAXoiCYcODEn9mzcl9F9g7haoBKloBx/3pLUbYSIP/dwYq/RYdUXTn?=
 =?us-ascii?q?daU81PSyJOHJ+zb4oXD+oAI+lYqZX9p0ATphe6HAWgGf/jxiNNinLw06I6ye?=
 =?us-ascii?q?AhGhzY0gImEdwFrXDYoMzrOKoWVOy4yrTDwzfeYPNMwTrz9ZbGch4hr/+PU7?=
 =?us-ascii?q?x/f8XexkszGA3KlViQtY7oMimJ2ugRvWWW7extXv+vhW49rAFxpyCiyNowio?=
 =?us-ascii?q?bXnoIVyk7L9SNky4goIN23Ukp7Ydq6H5pQqiqXMJB2Td45Q2xzpCY7yqEJuZ?=
 =?us-ascii?q?68fCQQzpQn3ATQZ+aIc4iP/BLuTeCcKip2inJifbKwnRey8U64x+3/SMa0yl?=
 =?us-ascii?q?BKoTRBktXWsXANzRPT586aQfV+5keswSuD2g/c5+1eIU04iLDXJ4Auz7IujJ?=
 =?us-ascii?q?YfrELOFTLslkrslq+ZbEAk9/Ct6+Tgf7rpuIeRN5RxigHiKqQundG/AfggPg?=
 =?us-ascii?q?gOQWeb/eO82aX//ULjWrVKj+A2krLDvJDbI8QbqKm5AxRL3Yk/8Rq/Ezen38?=
 =?us-ascii?q?gYnXkANl5Ffg6Ij5P1NF3UJfD4DPO/j0ytkDdt2f/GIqXsDojCI3XMirvsfa?=
 =?us-ascii?q?tx51RCxAc809xT/Y9YBqkEIP3pW0/xsNLYDgU+Mwyx2+vnE8hy1pgFVGKTAq?=
 =?us-ascii?q?6WLKPSsViS6uIpOOmDfpUZuDn6K/g7//Lul2M2mUcBfam12psacGq4HvV6LE?=
 =?us-ascii?q?WZe3XsmMoOHn8WsQUmTOzlklyCUThNaHapRK8z/S07CIOgDYffWI+tmrqB0z?=
 =?us-ascii?q?mnHpFMem9GDVWMG2/yd4qYQ/cMdD6SIsh5nzwfS7ehT44h1ReztA710LdnMO?=
 =?us-ascii?q?XU9TMCtZ7519h6+ffTlRcs+jxwFcid1HuNT25slGMSWzA2xLx/oVB6ylqbzK?=
 =?us-ascii?q?d4g/tYFNJN6PNNVgc6LoXRz/ZkBN/vWgLOZMuJREy6TdWhBDFiBu42luUPaE?=
 =?us-ascii?q?Z0AdnqrhnC2SexS+sPlreLDYY4xanr33HwIctm43za1a89gkMgT9cJPmqj0O?=
 =?us-ascii?q?o37AXXBojUg22HmKuwM6cRxijA8CGE12XdkltfVVtLTajdXX0ZLnDTpND961?=
 =?us-ascii?q?KKG6SiEpw7IwBBzoiEMaIMZdr32wYVDMz/McjTNjri01y7AgyFk/bVNtvn?=
X-IPAS-Result: =?us-ascii?q?A2D7AAB3PThe/wHyM5BlGwEBAQEBAQEFAQEBEQEBAwMBA?=
 =?us-ascii?q?QGBe4F9gRhVIBIqhBSJA4ZcAQEGgRIliW+RSQkBAQEBAQEBAQEtCgEBhEACg?=
 =?us-ascii?q?lg4EwIQAQEBBAEBAQEBBQMBAWyFNwyCOykBgwIBBSMVQRALGAICJgICVwYBD?=
 =?us-ascii?q?AYCAQGCYz8BgkoDCSUPrACBMoQ1AYEUgzyBOAaBDiqMOnmBB4ERJwwDgl0+g?=
 =?us-ascii?q?huFQIJeBI1biV1Gl2SCRYJOhHiOdAYbmwgtjjSIZ5REIoFYKwgCGAghD4MnE?=
 =?us-ascii?q?z0YDZckhV0jAzACAYxDKoIZAQE?=
Received: from tarius.tycho.ncsc.mil (HELO tarius.infosec.tycho.ncsc.mil) ([144.51.242.1])
  by EMSM-GH1-UEA10.NCSC.MIL with ESMTP; 03 Feb 2020 15:34:49 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.infosec.tycho.ncsc.mil (8.14.7/8.14.4) with ESMTP id 013FXxVh216915;
        Mon, 3 Feb 2020 10:33:59 -0500
Subject: Re: [RFC PATCH] libsepol: Add 'key_perms' policy capability
To:     Richard Haines <richard_c_haines@btinternet.com>,
        selinux@vger.kernel.org
Cc:     dhowells@redhat.com
References: <20200202193632.15205-1-richard_c_haines@btinternet.com>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <f9406d34-8509-97cc-6879-37f4547a49d2@tycho.nsa.gov>
Date:   Mon, 3 Feb 2020 10:36:02 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200202193632.15205-1-richard_c_haines@btinternet.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 2/2/20 2:36 PM, Richard Haines wrote:
> Allow the new key class permissions 'inval, revoke, join and clear' to be
> handled.
> 
> Signed-off-by: Richard Haines <richard_c_haines@btinternet.com>

Since the 'genfs_seclabel_symlinks' policy capability has already been 
queued for merge [1][2], I think this one will have to be bumped to the 
next policy capability bit after it.

[1] 
https://lore.kernel.org/selinux/20200124184221.322248-1-cgzones@googlemail.com/
[2] 
https://lore.kernel.org/selinux/20200131183900.3507-1-cgzones@googlemail.com/

> ---
>   libsepol/include/sepol/policydb/polcaps.h | 1 +
>   libsepol/src/polcaps.c                    | 1 +
>   2 files changed, 2 insertions(+)
> 
> diff --git a/libsepol/include/sepol/policydb/polcaps.h b/libsepol/include/sepol/policydb/polcaps.h
> index dc9356a6..de0c67b6 100644
> --- a/libsepol/include/sepol/policydb/polcaps.h
> +++ b/libsepol/include/sepol/policydb/polcaps.h
> @@ -13,6 +13,7 @@ enum {
>   	POLICYDB_CAPABILITY_ALWAYSNETWORK,
>   	POLICYDB_CAPABILITY_CGROUPSECLABEL,
>   	POLICYDB_CAPABILITY_NNP_NOSUID_TRANSITION,
> +	POLICYDB_CAPABILITY_KEYPERMS,
>   	__POLICYDB_CAPABILITY_MAX
>   };
>   #define POLICYDB_CAPABILITY_MAX (__POLICYDB_CAPABILITY_MAX - 1)
> diff --git a/libsepol/src/polcaps.c b/libsepol/src/polcaps.c
> index b9dc3526..48213c54 100644
> --- a/libsepol/src/polcaps.c
> +++ b/libsepol/src/polcaps.c
> @@ -12,6 +12,7 @@ static const char *polcap_names[] = {
>   	"always_check_network",		/* POLICYDB_CAPABILITY_ALWAYSNETWORK */
>   	"cgroup_seclabel",		/* POLICYDB_CAPABILITY_SECLABEL */
>   	"nnp_nosuid_transition",	/* POLICYDB_CAPABILITY_NNP_NOSUID_TRANSITION */
> +	"key_perms",			/* POLICYDB_CAPABILITY_KEYPERMS */
>   	NULL
>   };
>   
> 

