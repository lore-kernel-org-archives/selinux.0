Return-Path: <SRS0=Wrvk=XF=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68A4BC49ED9
	for <selinux@archiver.kernel.org>; Tue, 10 Sep 2019 18:51:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31D992084D
	for <selinux@archiver.kernel.org>; Tue, 10 Sep 2019 18:51:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="gb0eSoT4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725932AbfIJSv4 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 10 Sep 2019 14:51:56 -0400
Received: from USAT19PA24.eemsg.mail.mil ([214.24.22.198]:40518 "EHLO
        USAT19PA24.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725880AbfIJSv4 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 10 Sep 2019 14:51:56 -0400
X-EEMSG-check-017: 26313941|USAT19PA24_ESA_OUT05.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.64,490,1559520000"; 
   d="scan'208";a="26313941"
Received: from emsm-gh1-uea11.ncsc.mil ([214.29.60.3])
  by USAT19PA24.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 10 Sep 2019 18:50:33 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1568141433; x=1599677433;
  h=subject:to:references:from:message-id:date:mime-version:
   in-reply-to:content-transfer-encoding;
  bh=r2E/qp6DUqCfrYo2VakiBX2DMGfwokZu95Q1qss67yo=;
  b=gb0eSoT4PPE3sZ7s5wfeCTbYl9scbR1gSDVWbnJrR48tv76y/W4xJ2vg
   uo2wZtbZJgQVaUt4G/8BwkWn4mGvFDnn1VQ6fMfP0XB1rbuBZHvFULiGk
   zPLe23ymkygCoRHUSchBwk/dwF+/m6wDFJ1m8cbbf2NGmGAJRKH1FiZkx
   QVAq5iXl3z22ThnQY2W4sg5H9BxSholYv06++Pqubsy6R1tqXl+qfn3DD
   MRlfoinxAaLirxK5OK7SXD+dZ1/kDvK/+uVBahu0myllsvLd8AY3JqXoC
   qeqIzKrr6+1HvovL8ZmBakDUOZchk0lzbknM0ClJR+Ctm4gH+XySUvZuO
   A==;
X-IronPort-AV: E=Sophos;i="5.64,490,1559520000"; 
   d="scan'208";a="32653405"
IronPort-PHdr: =?us-ascii?q?9a23=3A+eorgRO0+fExzRHK/uEl6mtUPXoX/o7sNwtQ0K?=
 =?us-ascii?q?IMzox0I/7+rarrMEGX3/hxlliBBdydt6sfzbKO+Pm4BiRAuc/H7ClYNsQUFl?=
 =?us-ascii?q?cssoY/p0QYGsmLCEn2frbBThcRO4B8bmJj5GyxKkNPGczzNBX4q3y26iMOSF?=
 =?us-ascii?q?2kbVImbuv6FZTPgMupyuu854PcYxlShDq6fLh+MAi6oR/eu8ULj4ZuMLo9xg?=
 =?us-ascii?q?fGrndVZ+hbx35jKVaPkxrh/Mu984Nv/zpKt/4968JMVLjxcrglQ7BfEDkoKX?=
 =?us-ascii?q?0+6tfxtRnEQwuP538cXXsTnxFVHQXL7wz0U4novCfiueVzxCeVPcvtTbApQj?=
 =?us-ascii?q?ui9LtkSAXpiCgcKTE09nzch9Fqg6JapBKhoAF/w5LRbYqIOvdyYr/RcNUHTm?=
 =?us-ascii?q?daQM1fSzJODZ+9b4sXDuoOI+BYr5Xmp1ATqReyHBSgCP/zxjNNgHL507c60+?=
 =?us-ascii?q?A8Gg/Y2gIuEc8FvHDNoNj7MKoeVOa4x7TKwzredfNbwSrz5pbGch4hov+CU7?=
 =?us-ascii?q?x/fsXTxkYzGA3IlUmQpI7/Mj+JyugAvWqW4ux9XuyvkW4nrARxryCtxsYilo?=
 =?us-ascii?q?bGnJgVykza+S5kx4s1J9O5R1Jhbt6+DJtcqTqXN5d2Q8w+Q2Fovzw2yrsduZ?=
 =?us-ascii?q?GhZiQKx5MnxwDGZvGBboOG4QrjWf6MLTp3i39pYrKyiwuo/US+xeDwSNO43E?=
 =?us-ascii?q?tMoyFYiNfDrGoN2AbW6sWfT/t9+Vqu1iiX2gDI7+FEPVg0la3GK5492rIwlo?=
 =?us-ascii?q?QcsUDEHiLuhEX5lrWWdkQ5+uiz8ejnfrXnqYOcN49zkA3+NLghmtejDugiNw?=
 =?us-ascii?q?gOXmyb9fy91L3l40L5XK1HguA5n6TWqpzXJdkXqrSnDwJazIov8QuzAy+j0N?=
 =?us-ascii?q?sCnHkHKFxFeAiAj4jsI1zOIv75AuuljFS2jDdn2evLPqHhA5rRLnjDl63tfb?=
 =?us-ascii?q?Bm60FG0gYzwtdf54xMBrEbPP3zQlPxtMDfDhIhNQy0wvroCNJ51owEQmKDGK?=
 =?us-ascii?q?6ZMKTVsV+T/eIiOOyMaYAauTrnLPgl/fHuh2cjmVABZampwYcXaHegE/R9PU?=
 =?us-ascii?q?qZZXvsgtEcEWYFpQc+UuPqh0OYUTJJZHa9Qbg85jclB4KiF4vDQZqtgLPSlB?=
 =?us-ascii?q?u8S7tXbWdCA0vEMHDvbJ7MD/ENYyWWK9QnkzsDTqOJTtMxkxa0u1m+g6FqKu?=
 =?us-ascii?q?vS5z0wq53uzp526vfVmBV08iZ7XOqH1GTYTX5/l3kUHXdi3r90qFZhkH+fwK?=
 =?us-ascii?q?N4hLpeDtUV6PRXBFRpfaXAxvB3XoihEjnKec2EHRP/GYSr?=
X-IPAS-Result: =?us-ascii?q?A2BVAgDI73dd/wHyM5BlHgEGBwaBVgYLAYFtKoE/ATIqh?=
 =?us-ascii?q?CGPEoFqJZsZCQEBAQEBAQEBATQBAgEBghKCLQKCSSM3Bg4CDAEBAQQBAQEBA?=
 =?us-ascii?q?QYDAQFshTqCOikBgmYBAQEBAgEjFUYLCwkPAgImAgJXBgEMBgIBAYJfP4F8D?=
 =?us-ascii?q?6hTgTKFS4MtgUmBDCiLeIFXQIERJwyCXz6HT4JYBIEvAYsiiQ2BMZU3BoIll?=
 =?us-ascii?q?HEGG5kKjX+afiKBWCsKQYFogU6Ceo4pJAMwgQYBAY8gAQE?=
Received: from tarius.tycho.ncsc.mil ([144.51.242.1])
  by emsm-gh1-uea11.NCSC.MIL with ESMTP; 10 Sep 2019 18:50:32 +0000
Received: from moss-lions.infosec.tycho.ncsc.mil (moss-lions [192.168.25.4])
        by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id x8AIoWNj023758;
        Tue, 10 Sep 2019 14:50:32 -0400
Subject: Re: [Non-DoD Source] [PATCH 3/9] libsepol: do not dereference a
 failed allocated pointer
To:     Nicolas Iooss <nicolas.iooss@m4x.org>, selinux@vger.kernel.org
References: <20190901180636.31586-1-nicolas.iooss@m4x.org>
 <20190901180636.31586-4-nicolas.iooss@m4x.org>
From:   jwcart2 <jwcart2@tycho.nsa.gov>
Message-ID: <18ca1f8d-6934-f3e3-31aa-a2a5d1493ffc@tycho.nsa.gov>
Date:   Tue, 10 Sep 2019 14:52:29 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190901180636.31586-4-nicolas.iooss@m4x.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 9/1/19 2:06 PM, Nicolas Iooss wrote:
> When strs_stack_init(&stack) fails to allocate memory and stack is still
> NULL, it should not be dereferenced with strs_stack_pop(stack).
> 
> This issue has been found using Infer static analyzer.
> 
> Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>
> ---
>   libsepol/src/kernel_to_cil.c  | 8 +++++---
>   libsepol/src/kernel_to_conf.c | 8 +++++---
>   2 files changed, 10 insertions(+), 6 deletions(-)
> 
> diff --git a/libsepol/src/kernel_to_cil.c b/libsepol/src/kernel_to_cil.c
> index 320af37b2bc8..9fcc254707ba 100644
> --- a/libsepol/src/kernel_to_cil.c
> +++ b/libsepol/src/kernel_to_cil.c
> @@ -108,10 +108,12 @@ static char *cond_expr_to_str(struct policydb *pdb, struct cond_expr *expr)
>   	return str;
>   
>   exit:
> -	while ((new_val = strs_stack_pop(stack)) != NULL) {
> -		free(new_val);
> +	if (stack) {
> +		while ((new_val = strs_stack_pop(stack)) != NULL) {
> +			free(new_val);
> +		}
> +		strs_stack_destroy(&stack);
>   	}
> -	strs_stack_destroy(&stack);
>   
>   	return NULL;
>   }

constraint_expr_to_str() has the same problem.

> diff --git a/libsepol/src/kernel_to_conf.c b/libsepol/src/kernel_to_conf.c
> index 930bafabdd4b..2c8da49a11ab 100644
> --- a/libsepol/src/kernel_to_conf.c
> +++ b/libsepol/src/kernel_to_conf.c
> @@ -106,10 +106,12 @@ static char *cond_expr_to_str(struct policydb *pdb, struct cond_expr *expr)
>   	return str;
>   
>   exit:
> -	while ((new_val = strs_stack_pop(stack)) != NULL) {
> -		free(new_val);
> +	if (stack != NULL) {
> +		while ((new_val = strs_stack_pop(stack)) != NULL) {
> +			free(new_val);
> +		}
> +		strs_stack_destroy(&stack);
>   	}
> -	strs_stack_destroy(&stack);
>   
>   	return NULL;
>   }
> 

Same comment here. constraint_expr_to_str() also needs to be fixed.

-- 
James Carter <jwcart2@tycho.nsa.gov>
National Security Agency
