Return-Path: <SRS0=ftCu=3G=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54E6BC33C9E
	for <selinux@archiver.kernel.org>; Fri, 17 Jan 2020 19:37:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1EFDA20748
	for <selinux@archiver.kernel.org>; Fri, 17 Jan 2020 19:37:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="cd/aqVZV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729401AbgAQThG (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 17 Jan 2020 14:37:06 -0500
Received: from UPDC19PA23.eemsg.mail.mil ([214.24.27.198]:3954 "EHLO
        UPDC19PA23.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727573AbgAQThG (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 17 Jan 2020 14:37:06 -0500
X-EEMSG-check-017: 47256464|UPDC19PA23_ESA_OUT05.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.70,331,1574121600"; 
   d="scan'208";a="47256464"
Received: from emsm-gh1-uea10.ncsc.mil ([214.29.60.2])
  by UPDC19PA23.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 17 Jan 2020 19:37:03 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1579289823; x=1610825823;
  h=subject:to:references:from:message-id:date:mime-version:
   in-reply-to:content-transfer-encoding;
  bh=bPHT0UDzIl504dLiWWRrs3nrveq5rNJlx7gHl2rPly0=;
  b=cd/aqVZVm+ZDD5Mb7tCqMnr1vo58ALobcDGU8dGNEcw3rH4Y/VmcBISR
   c4wf9YZVAZQozjY/srg0otKUfZmtBrviWULZAvf8Sm9fULKuko+mh5lUJ
   Uu0N2QcXJ0WxPupvqhE8nIVSRLCNYmQqVcAM+bdmRo9cysoBNmiPHtCMP
   EcldiePiNiQtQV/TLfubcGj4G0uIY9ZNRUzCyLTCNfiSKd0uflzh+6pFD
   U+fbaJNwxZCjFxr3fTthf6riRb6r337GdR5sp3b746n4j+eX+YFpoA1UC
   6icNKTuHKxQAzm2V41USn9JiB0+H4DlT9zs4c4mX1TSJBO/jE42ELtC6H
   A==;
X-IronPort-AV: E=Sophos;i="5.70,331,1574121600"; 
   d="scan'208";a="32090853"
IronPort-PHdr: =?us-ascii?q?9a23=3AZyK4th1LSEyK/WocsmDT+DRfVm0co7zxezQtwd?=
 =?us-ascii?q?8ZsesWKPrxwZ3uMQTl6Ol3ixeRBMOHsq4C07qd6PmoGTRZp8rY6zZaKN0Efi?=
 =?us-ascii?q?RGoP1epxYnDs+BBB+zB9/RRAt+Iv5/UkR49WqwK0lfFZW2TVTTpnqv8WxaQU?=
 =?us-ascii?q?2nZkJ6KevvB4Hdkdm82fys9J3PeQVIgye2ba9vIBmsogjdq8YbjZF+JqsyxR?=
 =?us-ascii?q?fErGZEcPlSyW90OF6fhRnx6tq+8ZJ57yhcp/ct/NNcXKvneKg1UaZWByk8PW?=
 =?us-ascii?q?Av483ruxjDTQ+R6XYZT24bjBlGDRXb4R/jRpv+vTf0ueR72CmBIM35Vqs0Vi?=
 =?us-ascii?q?i476dqUxDnliEKPCMk/W7Ni8xwiKVboA+9pxF63oXZbp2ZOOZ4c6jAZt4RW3?=
 =?us-ascii?q?ZPUdhNWCxAGoO8bpUAD+wdPeZDsoLxo0ICoQaiCQWwAe/izDFHhmXy3aYnze?=
 =?us-ascii?q?ovFw/I1xEkE94XvnnZqND5OaEPWu630abI1y3OYe5I1zfz6IbGcR4vrv+DUr?=
 =?us-ascii?q?1ybcXfxlIiFx/Hg1iKtYDpIz2Y2+YLvmOG7+RgT+Wvi2s/pg9svjig2N8sio?=
 =?us-ascii?q?nXiYIT11vK6CB5z5wxJd28VkF6YcOvHZxLty6HLIt7Wd8iQmF0tyY6zb0Ko5?=
 =?us-ascii?q?i7fDMQx5g9yB7fbOKHfpGO7xn+V+iROS91iG9qdb+wnRq/8VWsxvfiWsS7zl?=
 =?us-ascii?q?pGtDdJn9/RvX4XzRPT8NKISv5l80ek3jaAyh7c5/lfIUAxiarbM5khwqMslp?=
 =?us-ascii?q?YLsUTMACv2mELuga+KbEok4Omo6/n8Yrn8p5+cMYF0igblMqswhsOzG/g4Mw?=
 =?us-ascii?q?gSUGib/uSwzrvj8lHiQLpWlPE2l6jZsJTCKcQaoK62HRNV354+5xuwADqqyt?=
 =?us-ascii?q?QVkWQdIF5bdx+LkZLlN0zWLPD9F/i/glCskDlxx/DBO73sGo7NIWXYkLr6Yb?=
 =?us-ascii?q?Z861JTyAo0zdxF4ZJUEasOLOj8Wk/2qtzUFgU5PBCsw+b7FNV90ZsTWWWKAq?=
 =?us-ascii?q?+eK6PSt0WH6f4xLOSXfo8apivyK/g/6P7yl3M2hVgdfayx15sNdH+4BuhmI1?=
 =?us-ascii?q?meYXf0mdcOD2MKvgs4TOz3h1yPSiBTZ3msUKIm/D07C5ypDZ3FRo+zhLyNxi?=
 =?us-ascii?q?C7HodZZmpeEFCDDW/od5mYW/cLcC+SOtVukiEAVbW6U48uzwyutAvjx7piKe?=
 =?us-ascii?q?rU/TcYuoz52Ndp4O3TkEJ6yTshKMKRyWyPB0RzhWUBTDI1lPR4pEtmzF6I3I?=
 =?us-ascii?q?BijvBYHMAV7PRMBENyLpPYzupnG/jsVQ/bONSEUlCrRpOhGz51Buo43ttGRk?=
 =?us-ascii?q?F6Adjq2gjKwi6CG7YIk/mOA5su/+TX2H2ndOhnzHOT77Usl1krRIN0MGSigq?=
 =?us-ascii?q?Nuv1zIC5Xhj1SSl6Hsc78VmiHK6jHQniK1oEhEXVsoAu3+VncFax6T9I+o6w?=
 =?us-ascii?q?=3D=3D?=
X-IPAS-Result: =?us-ascii?q?A2AiAwByCyJe/wHyM5BlHAEBAQEBBwEBEQEEBAEBgXuBf?=
 =?us-ascii?q?YINEiqEEYkDhmIGgTeJboolhyQJAQEBAQEBAQEBNwEBhEACgi44EwIQAQEBB?=
 =?us-ascii?q?AEBAQEBBQMBAWyFQ4I7KQGCegEFIwQRUQsOCgICJgICVwYBDAYCAQGCYz+CV?=
 =?us-ascii?q?yWtcH8zhUqDL4E+gQ4ojC55gQeBOA+CXT6HWYJeBI1aiVZGl1aCQ4JJk2EGG?=
 =?us-ascii?q?5pyLY4vnRYigVgrCAIYCCEPO4JsUBgNiA0XjkEjAzCNZwEB?=
Received: from tarius.tycho.ncsc.mil (HELO tarius.infosec.tycho.ncsc.mil) ([144.51.242.1])
  by EMSM-GH1-UEA10.NCSC.MIL with ESMTP; 17 Jan 2020 19:37:01 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.infosec.tycho.ncsc.mil (8.14.7/8.14.4) with ESMTP id 00HJaL4F012040;
        Fri, 17 Jan 2020 14:36:24 -0500
Subject: Re: [PATCH v2 1/5] selinux: simplify evaluate_cond_node()
To:     Ondrej Mosnacek <omosnace@redhat.com>, selinux@vger.kernel.org,
        Paul Moore <paul@paul-moore.com>
References: <20200117085836.445797-1-omosnace@redhat.com>
 <20200117085836.445797-2-omosnace@redhat.com>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <6ddef1a2-ba96-6d28-801e-a3758e3f7092@tycho.nsa.gov>
Date:   Fri, 17 Jan 2020 14:37:41 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <20200117085836.445797-2-omosnace@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 1/17/20 3:58 AM, Ondrej Mosnacek wrote:
> It never fails, so it can just return void.
> 
> Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>

Reviewed-by: Stephen Smalley <sds@tycho.nsa.gov>

> ---
>   security/selinux/ss/conditional.c |  3 +--
>   security/selinux/ss/conditional.h |  2 +-
>   security/selinux/ss/services.c    | 14 ++++----------
>   3 files changed, 6 insertions(+), 13 deletions(-)
> 
> diff --git a/security/selinux/ss/conditional.c b/security/selinux/ss/conditional.c
> index 70c378ee1a2f..04593062008d 100644
> --- a/security/selinux/ss/conditional.c
> +++ b/security/selinux/ss/conditional.c
> @@ -85,7 +85,7 @@ static int cond_evaluate_expr(struct policydb *p, struct cond_expr *expr)
>    * list appropriately. If the result of the expression is undefined
>    * all of the rules are disabled for safety.
>    */
> -int evaluate_cond_node(struct policydb *p, struct cond_node *node)
> +void evaluate_cond_node(struct policydb *p, struct cond_node *node)
>   {
>   	int new_state;
>   	struct cond_av_list *cur;
> @@ -111,7 +111,6 @@ int evaluate_cond_node(struct policydb *p, struct cond_node *node)
>   				cur->node->key.specified |= AVTAB_ENABLED;
>   		}
>   	}
> -	return 0;
>   }
>   
>   int cond_policydb_init(struct policydb *p)
> diff --git a/security/selinux/ss/conditional.h b/security/selinux/ss/conditional.h
> index ec846e45904c..d86ef286ca84 100644
> --- a/security/selinux/ss/conditional.h
> +++ b/security/selinux/ss/conditional.h
> @@ -75,6 +75,6 @@ void cond_compute_av(struct avtab *ctab, struct avtab_key *key,
>   		struct av_decision *avd, struct extended_perms *xperms);
>   void cond_compute_xperms(struct avtab *ctab, struct avtab_key *key,
>   		struct extended_perms_decision *xpermd);
> -int evaluate_cond_node(struct policydb *p, struct cond_node *node);
> +void evaluate_cond_node(struct policydb *p, struct cond_node *node);
>   
>   #endif /* _CONDITIONAL_H_ */
> diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
> index 216ce602a2b5..ff43a35bb874 100644
> --- a/security/selinux/ss/services.c
> +++ b/security/selinux/ss/services.c
> @@ -2958,11 +2958,8 @@ int security_set_bools(struct selinux_state *state, int len, int *values)
>   			policydb->bool_val_to_struct[i]->state = 0;
>   	}
>   
> -	for (cur = policydb->cond_list; cur; cur = cur->next) {
> -		rc = evaluate_cond_node(policydb, cur);
> -		if (rc)
> -			goto out;
> -	}
> +	for (cur = policydb->cond_list; cur; cur = cur->next)
> +		evaluate_cond_node(policydb, cur);
>   
>   	seqno = ++state->ss->latest_granting;
>   	rc = 0;
> @@ -3015,11 +3012,8 @@ static int security_preserve_bools(struct selinux_state *state,
>   		if (booldatum)
>   			booldatum->state = bvalues[i];
>   	}
> -	for (cur = policydb->cond_list; cur; cur = cur->next) {
> -		rc = evaluate_cond_node(policydb, cur);
> -		if (rc)
> -			goto out;
> -	}
> +	for (cur = policydb->cond_list; cur; cur = cur->next)
> +		evaluate_cond_node(policydb, cur);
>   
>   out:
>   	if (bnames) {
> 

