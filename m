Return-Path: <SRS0=smjq=NY=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A598C43441
	for <selinux@archiver.kernel.org>; Tue, 13 Nov 2018 21:10:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 807B92084C
	for <selinux@archiver.kernel.org>; Tue, 13 Nov 2018 21:10:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 807B92084C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tycho.nsa.gov
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=selinux-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726295AbeKNHKb (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 14 Nov 2018 02:10:31 -0500
Received: from uphb19pa12.eemsg.mail.mil ([214.24.26.86]:24666 "EHLO
        usfb19pa15.eemsg.mail.mil" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725748AbeKNHKb (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 14 Nov 2018 02:10:31 -0500
X-EEMSG-check-008: 159589522|USFB19PA15_EEMSG_MP11.csd.disa.mil
Received: from emsm-gh1-uea11.ncsc.mil ([214.29.60.3])
  by usfb19pa15.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 13 Nov 2018 21:10:29 +0000
X-IronPort-AV: E=Sophos;i="5.56,229,1539648000"; 
   d="scan'208";a="20577991"
IronPort-PHdr: =?us-ascii?q?9a23=3AZT5TmxEKlDFMKvdITjBhT51GYnF86YWxBRYc79?=
 =?us-ascii?q?8ds5kLTJ7yocmwAkXT6L1XgUPTWs2DsrQY07WQ6/iocFdDyK7JiGoFfp1IWk?=
 =?us-ascii?q?1NouQttCtkPvS4D1bmJuXhdS0wEZcKflZk+3amLRodQ56mNBXdrXKo8DEdBA?=
 =?us-ascii?q?j0OxZrKeTpAI7SiNm82/yv95HJbAhEmDiwbaluIBmqsA7cqtQYjYx+J6gr1x?=
 =?us-ascii?q?DHuGFIe+NYxWNpIVKcgRPx7dqu8ZBg7ipdpesv+9ZPXqvmcas4S6dYDCk9PG?=
 =?us-ascii?q?Au+MLrrxjDQhCR6XYaT24bjwBHAwnB7BH9Q5fxri73vfdz1SWGIcH7S60/VC?=
 =?us-ascii?q?+85Kl3VhDnlCYHNyY48G7JjMxwkLlbqw+lqxBm3oLYfJ2ZOP94c6zTZ9MaQX?=
 =?us-ascii?q?dKUNhXWSJPH4iwa5IDA/QdMepdqYT2ulkAogakBQS0Ge3h1DFIiH/106M03e?=
 =?us-ascii?q?suHgPJ0xAvEd8VrHTZrs/4OLsOXe27zqTFyyjIYfNM2Tf67YjFag0voe2SUr?=
 =?us-ascii?q?Joccre108vHB7YgFWVs4PlOzeV2foNsmOG6OdgTv+gi3U8pgFtojmg2scsio?=
 =?us-ascii?q?7TioIT0VDL7z91wIkyJd2mUUN2Z8OvHphItyyCKod7TcwvT3totSon0LEKp5?=
 =?us-ascii?q?G2cDYQxJg6wRPUduaJfJKS4h35UeacOTJ4hHV4d72hnxuy6k2gyvHkVsmzzV?=
 =?us-ascii?q?ZKsjJJktnSuXAJ0Bze8tSHReFn/kegxDaPzBrf6v1EIE8olarbLIQtwrgsmZ?=
 =?us-ascii?q?oIrUvPBCr2mETyjKOOd0Uk/Pan6/j/b7n7qZKROJV4hwHjPqg0hMCyDvo0Ph?=
 =?us-ascii?q?ITU2SD/OSzzrzj/Un3QLVQif02l7HUsIvHKsQAvaO5Hw9U3Zoj6xa4FTum1s?=
 =?us-ascii?q?8YkmMdIFJKfxKHkZDlO0vSL/DgEfe/n1OsnS9sx/DDOb3hGZPNIWLfn7j/Zr?=
 =?us-ascii?q?t98VBTxxczzd9F+5JYEK0OIPX2WkXprtzXEgc5MxCow+bgENh9zZ0RWWaOAq?=
 =?us-ascii?q?+fLaPTvkSF5vwgI+aSfo8ZojX9JOY/5/7ok3A5nUURfa6z3ZsYcHq4BOhpI1?=
 =?us-ascii?q?2FYXrwhdcMCX8KsRAjTOzuk1CCSSRcZ2u2X64l4zE7D4WmDZ3dSYy3nLOB2y?=
 =?us-ascii?q?K7TdVqYTVhDFyWHHWgUoKfXf4HZSHadshklScCXLOsY5Us2RGnqEnxzL8xaq?=
 =?us-ascii?q?LP9ykZs4/z/MZ66veVlhwo8zFwScOH3CXFd2hpmistQDgs0egruUVgzn+b2L?=
 =?us-ascii?q?V8xvlfEsZeofhOV1FpG4TbyrlBF93qWg/HNuyMQVKiT8TuVSo9Vfot0tQOZA?=
 =?us-ascii?q?B7ANzkgRfdiXn5S4QJnqCGUcRnupnX2GL8coMkkS7L?=
X-IPAS-Result: =?us-ascii?q?A2AtAADLPOtb/wHyM5BjGwEBAQEDAQEBBwMBAQGBUgUBA?=
 =?us-ascii?q?QELAYFaKYE1MyeDeJQVTQEBAQEBBoE1iRWJKYR3gXo4AYRAAoM8IjUMDQEDA?=
 =?us-ascii?q?QEBAQEBAgFsKII2JAGCYAEFIwQRQRALDgoCAiYCAlcGAQwGAgEBgl4/gXUNq?=
 =?us-ascii?q?HV8M4VAhGSBC4p3F3iBB4ERJ4JrhHGDEYJXAokUhjQzj1sJkRwGGIFYiCaGd?=
 =?us-ascii?q?SyZFgI0gVUrCAIYCCEPgyeCJBqOOiEDMIEFAQGKT4JLAQE?=
Received: from tarius.tycho.ncsc.mil ([144.51.242.1])
  by emsm-gh1-uea11.NCSC.MIL with ESMTP; 13 Nov 2018 21:10:28 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id wADLARtK018429;
        Tue, 13 Nov 2018 16:10:27 -0500
Subject: Re: [PATCH v3] selinux: simplify mls_context_to_sid()
To:     Ondrej Mosnacek <omosnace@redhat.com>, selinux@vger.kernel.org,
        Paul Moore <paul@paul-moore.com>
Cc:     selinux@tycho.nsa.gov
References: <20181112114426.20887-1-omosnace@redhat.com>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <6eab4acd-a802-efba-db19-9593419025e2@tycho.nsa.gov>
Date:   Tue, 13 Nov 2018 16:12:42 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181112114426.20887-1-omosnace@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 11/12/18 6:44 AM, Ondrej Mosnacek wrote:
> This function has only two callers, but only one of them actually needs
> the special logic at the beginning. Factoring this logic out into
> string_to_context_struct() allows us to drop the arguments 'oldc', 's',
> and 'def_sid'.
> 
> Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> ---
> 
> Changes in v3:
>   - correct the comment about policy read lock
> 
> Changes in v2:
>   - also drop unneeded #include's from mls.c
> 
>   security/selinux/ss/mls.c      | 49 +++++-----------------------------
>   security/selinux/ss/mls.h      |  5 +---
>   security/selinux/ss/services.c | 32 +++++++++++++++++++---
>   3 files changed, 36 insertions(+), 50 deletions(-)
> 
> diff --git a/security/selinux/ss/mls.c b/security/selinux/ss/mls.c
> index 2fe459df3c85..d1da928a7e77 100644
> --- a/security/selinux/ss/mls.c
> +++ b/security/selinux/ss/mls.c
> @@ -24,10 +24,7 @@
>   #include <linux/string.h>
>   #include <linux/errno.h>
>   #include <net/netlabel.h>
> -#include "sidtab.h"
>   #include "mls.h"
> -#include "policydb.h"
> -#include "services.h"
>   
>   /*
>    * Return the length in bytes for the MLS fields of the
> @@ -223,20 +220,12 @@ int mls_context_isvalid(struct policydb *p, struct context *c)
>    * This function modifies the string in place, inserting
>    * NULL characters to terminate the MLS fields.
>    *
> - * If a def_sid is provided and no MLS field is present,
> - * copy the MLS field of the associated default context.
> - * Used for upgraded to MLS systems where objects may lack
> - * MLS fields.
> - *
> - * Policy read-lock must be held for sidtab lookup.
> + * Policy read-lock must be held for policy data lookup.
>    *
>    */
>   int mls_context_to_sid(struct policydb *pol,
> -		       char oldc,
>   		       char *scontext,
> -		       struct context *context,
> -		       struct sidtab *s,
> -		       u32 def_sid)
> +		       struct context *context)
>   {
>   	char *sensitivity, *cur_cat, *next_cat, *rngptr;
>   	struct level_datum *levdatum;
> @@ -244,29 +233,6 @@ int mls_context_to_sid(struct policydb *pol,
>   	int l, rc, i;
>   	char *rangep[2];
>   
> -	if (!pol->mls_enabled) {
> -		if ((def_sid != SECSID_NULL && oldc) || (*scontext) == '\0')
> -			return 0;
> -		return -EINVAL;
> -	}
> -
> -	/*
> -	 * No MLS component to the security context, try and map to
> -	 * default if provided.
> -	 */
> -	if (!oldc) {
> -		struct context *defcon;
> -
> -		if (def_sid == SECSID_NULL)
> -			return -EINVAL;
> -
> -		defcon = sidtab_search(s, def_sid);
> -		if (!defcon)
> -			return -EINVAL;
> -
> -		return mls_context_cpy(context, defcon);
> -	}
> -
>   	/*
>   	 * If we're dealing with a range, figure out where the two parts
>   	 * of the range begin.
> @@ -364,14 +330,11 @@ int mls_from_string(struct policydb *p, char *str, struct context *context,
>   		return -EINVAL;
>   
>   	tmpstr = kstrdup(str, gfp_mask);
> -	if (!tmpstr) {
> -		rc = -ENOMEM;
> -	} else {
> -		rc = mls_context_to_sid(p, ':', tmpstr, context,
> -					NULL, SECSID_NULL);
> -		kfree(tmpstr);
> -	}
> +	if (!tmpstr)
> +		return -ENOMEM;
>   
> +	rc = mls_context_to_sid(p, tmpstr, context);
> +	kfree(tmpstr);
>   	return rc;
>   }
>   
> diff --git a/security/selinux/ss/mls.h b/security/selinux/ss/mls.h
> index 67093647576d..e2498f78e100 100644
> --- a/security/selinux/ss/mls.h
> +++ b/security/selinux/ss/mls.h
> @@ -33,11 +33,8 @@ int mls_range_isvalid(struct policydb *p, struct mls_range *r);
>   int mls_level_isvalid(struct policydb *p, struct mls_level *l);
>   
>   int mls_context_to_sid(struct policydb *p,
> -		       char oldc,
>   		       char *scontext,
> -		       struct context *context,
> -		       struct sidtab *s,
> -		       u32 def_sid);
> +		       struct context *context);
>   
>   int mls_from_string(struct policydb *p, char *str, struct context *context,
>   		    gfp_t gfp_mask);
> diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
> index 12e414394530..ccad4334f99d 100644
> --- a/security/selinux/ss/services.c
> +++ b/security/selinux/ss/services.c
> @@ -1425,9 +1425,35 @@ static int string_to_context_struct(struct policydb *pol,
>   
>   	ctx->type = typdatum->value;
>   
> -	rc = mls_context_to_sid(pol, oldc, p, ctx, sidtabp, def_sid);
> -	if (rc)
> -		goto out;
> +	if (!pol->mls_enabled) {
> +		rc = -EINVAL;
> +		if ((def_sid == SECSID_NULL || !oldc) && (*p) != '\0')
> +			goto out;

I don't think this is your bug, but unless I'm mistaken, p could be OOB 
and be dereferenced here.  Seems to have been introduced by 
95ffe194204ae3cef88d0b59be209204bbe9b3be.  Likely not caught in testing 
since both Linux distributions and Android enable MLS to use the 
category sets for isolation.

> +	} else if (!oldc) {
> +		/*
> +		 * If a def_sid is provided and no MLS field is present,
> +		 * copy the MLS field of the associated default context.
> +		 * Used for upgrading to MLS systems where objects may lack
> +		 * MLS fields.
> +		 */
> +		struct context *defcon;
> +
> +		rc = -EINVAL;
> +		if (def_sid == SECSID_NULL)
> +			goto out;
> +
> +		defcon = sidtab_search(sidtabp, def_sid);
> +		if (!defcon)
> +			goto out;
> +
> +		rc = mls_context_cpy(ctx, defcon);
> +		if (rc)
> +			goto out;
> +	} else {
> +		rc = mls_context_to_sid(pol, p, ctx);
> +		if (rc)
> +			goto out;
> +	}
>   
>   	/* Check the validity of the new context. */
>   	rc = -EINVAL;
> 

