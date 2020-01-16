Return-Path: <SRS0=jI/q=3F=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79DACC33CB1
	for <selinux@archiver.kernel.org>; Thu, 16 Jan 2020 16:41:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42FCE2073A
	for <selinux@archiver.kernel.org>; Thu, 16 Jan 2020 16:41:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="iIVpMKFl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726785AbgAPQlu (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 16 Jan 2020 11:41:50 -0500
Received: from UHIL19PA36.eemsg.mail.mil ([214.24.21.195]:2814 "EHLO
        UHIL19PA36.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726440AbgAPQlu (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 16 Jan 2020 11:41:50 -0500
X-EEMSG-check-017: 67339807|UHIL19PA36_ESA_OUT02.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.70,326,1574121600"; 
   d="scan'208";a="67339807"
Received: from emsm-gh1-uea10.ncsc.mil ([214.29.60.2])
  by UHIL19PA36.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 16 Jan 2020 16:41:48 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1579192908; x=1610728908;
  h=subject:to:references:from:message-id:date:mime-version:
   in-reply-to:content-transfer-encoding;
  bh=PEEnY1h1wIuBVgR9n8fY+n8HSo8ZxoMj9Y/6p6e7H/c=;
  b=iIVpMKFlj6gp4MNX+gshaov+f9mnACoO0ffcJPkKsb8Gm1+/At9e5kOS
   mav5xw2gKoG6mWavFiD2H77gzUHxZUGr27Nz8VpCsL7ONh2Wym69glZPv
   ZQxnTKKjxPukNRkopkStUqECjmbJD3CY80FjhSm9co9CgavraQssdboKr
   qBG3KX0FZq8634L2NuW450jRHZY9QG0REtbRAY0iXi8bfQU0HZJkSdVEo
   Rm54A10wmLEkjOJ+aHdOaPB7JQKbVv9O6NR4h8CLuF+Lpc8RazOZXlrQU
   O8YHsom1+hEzQECSulTwPxJRcsg5FE7R6Z3C5ysZzBAqvRerMErmls9Ty
   g==;
X-IronPort-AV: E=Sophos;i="5.70,326,1574121600"; 
   d="scan'208";a="32035143"
IronPort-PHdr: =?us-ascii?q?9a23=3AMbmlhRy1A65sOFPXCy+O+j09IxM/srCxBDY+r6?=
 =?us-ascii?q?Qd0uoULPad9pjvdHbS+e9qxAeQG9mCt7Qc1qGG7uigATVGvc/a9ihaMdRlbF?=
 =?us-ascii?q?wssY0uhQsuAcqIWwXQDcXBSGgEJvlET0Jv5HqhMEJYS47UblzWpWCuv3ZJQk?=
 =?us-ascii?q?2sfQV6Kf7oFYHMks+5y/69+4HJYwVPmTGxfa5+IA+5oAnMucQam5duJ6Y+xh?=
 =?us-ascii?q?bKonZDZuBayX91KV6JkBvw+8m98IR//yhMvv4q6tJNX7j9c6kkV7JTES4oM3?=
 =?us-ascii?q?oy5M3ltBnDSRWA634BWWgIkRRGHhbI4gjiUpj+riX1uOx92DKHPcLtVrA7RS?=
 =?us-ascii?q?6i76ZwRxD2jioMKiM0/3vWisx0i6JbvQ6hqhliyIPafI2ZKPxzdb7GcNgEWW?=
 =?us-ascii?q?ROQNpeVy1ZAoO9cYQPCfYBPf1FpIX5vlcCsAeyCRWpCO7pxDBInHv21rAk3e?=
 =?us-ascii?q?onHw/NwQgsE8sAvXnQqdn4MroZX+Kow6nS1TjNcu1Y2Tn95obLfB4ur/6DUr?=
 =?us-ascii?q?BsfsTe0kQvCwHIg0+MpYD5MT6Y1OIAuHWb4ep6UuKvjnYqpRxtojex3scsip?=
 =?us-ascii?q?fGhoQIwV7Z8CV22oI1JdmmR097fNWpF4BQuDyBN4ZtXsMjQ31nuCY9yrEcv5?=
 =?us-ascii?q?67ZzIFxI4oxx7YdfyKao6F6Q/gWuaJOTp0mX1odb2lixuy7ESs0PPwW8aq3F?=
 =?us-ascii?q?pQsyZIlMTHuGoX2BzJ8MeHT+Nw/kKm2TmSyQ/e8vpEIUUolarDLJ4h36Iwmo?=
 =?us-ascii?q?ITsUvdGi/2n137jLOMeUU+++io9v/nbq/npp+aOY90jRr+PboylcClHeQ5Mh?=
 =?us-ascii?q?QBX2ic+eim0r3s4Vb5T6lQgv0zk6nZtIjWJcUdpqGnHw9Yypsv5hmwAju80N?=
 =?us-ascii?q?kUgGMLIExKdR6ZlYTlJknCIPXiAve+h1Ssni1rx/fDPrD5GZXCM2PDnaz9fb?=
 =?us-ascii?q?d990FcyA0zwcpZ55JPEL4NOv3zWkjvtNDAFB82LxS0w/r7CNV6zo4eXmePAq?=
 =?us-ascii?q?iCMKPUq1CH+vwgLvKWZIALpTn9K+Iq5+L0gXAlnl8deLGj3YELZ3CgAvRmP0?=
 =?us-ascii?q?KZbGL3gtgfFWcKvww+TPHliVCZTz5TaGi9X7gm6jE4Fo2mF4HDSZ6pgLCb2y?=
 =?us-ascii?q?e7BJJWbHhcCl+QCXfoa5mEW/AUZSKKOMBhjzgEWKO5S4A7yBGusBb2y79gLu?=
 =?us-ascii?q?rT4C0Xq4jv28Ry5+3WxlkO8mlTCciH3mPFamZvmGoDSjx+iKd6pld7w1yO+b?=
 =?us-ascii?q?J1j/xRCZpY4PYfFk8hOJrdyfFqI879VxiHfdqTTluiBNK8DnV5dtssx5crZE?=
 =?us-ascii?q?FnFp32lhne2wKyCqIR0rmMA4Y5tKnb2i6iCdx6ziP9yKQ5j1QgCvBKPGmii7?=
 =?us-ascii?q?83oxPfHKbVgk6ZkOCsbq1a0ynTojTQhVGStV1VBVYjGZ7OWmoSMw6P9oX0?=
X-IPAS-Result: =?us-ascii?q?A2DTBADGkCBe/wHyM5BlHAEBAQEBBwEBEQEEBAEBgXuBf?=
 =?us-ascii?q?YFtIBIqhBCJA4ZeAQEBBoESJYEBiG2KJYckCQEBAQEBAQEBATcBAYRAAoImO?=
 =?us-ascii?q?BMCEAEBAQQBAQEBAQUDAQFshUOCOykBgnoBBSMEEVELDgoCAiYCAlcGAQwGA?=
 =?us-ascii?q?gEBgmM/glclrDV/M4VKg0mBPoEOKIw2eYEHgREnDAOCKDU+h1mCXgSNWoh1Y?=
 =?us-ascii?q?UaXVoJDgkmTYQYbgkeMSIthLY4vnRUigVgrCAIYCCEPO4JsUBgNiA0XjkEjA?=
 =?us-ascii?q?zCNDV8BAQ?=
Received: from tarius.tycho.ncsc.mil (HELO tarius.infosec.tycho.ncsc.mil) ([144.51.242.1])
  by EMSM-GH1-UEA10.NCSC.MIL with ESMTP; 16 Jan 2020 16:41:47 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.infosec.tycho.ncsc.mil (8.14.7/8.14.4) with ESMTP id 00GGf3p7028168;
        Thu, 16 Jan 2020 11:41:07 -0500
Subject: Re: [PATCH 2/6] selinux: simplify security_preserve_bools()
To:     Ondrej Mosnacek <omosnace@redhat.com>, selinux@vger.kernel.org,
        Paul Moore <paul@paul-moore.com>
References: <20200116120439.303034-1-omosnace@redhat.com>
 <20200116120439.303034-3-omosnace@redhat.com>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <1aa7f437-7b34-4097-2af8-6f519e16d916@tycho.nsa.gov>
Date:   Thu, 16 Jan 2020 11:42:31 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <20200116120439.303034-3-omosnace@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 1/16/20 7:04 AM, Ondrej Mosnacek wrote:
> First, evaluate_cond_node() never returns an error. Make it just return
> void.
> 
> Second, drop the use of security_get_bools() from
> security_preserve_bools() and read from the old policydb directly. This
> saves some useless allocations and together with the first change makes
> security_preserve_bools() no longer possibly return an error. Again the
> return type is changed to void.
> 
> Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>

Dropping use of security_get_bools() means we are no longer reading the 
boolean values with the policy read-lock held so they could in theory 
change underneath us.  However, this is presently prevented via the 
fsi->mutex taken by selinuxfs so I believe this is safe.

Reviewed-by: Stephen Smalley <sds@tycho.nsa.gov>

> ---
>   security/selinux/ss/conditional.c |  3 +-
>   security/selinux/ss/conditional.h |  2 +-
>   security/selinux/ss/services.c    | 52 ++++++++++---------------------
>   3 files changed, 18 insertions(+), 39 deletions(-)
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
> index 42ca9f6dbbf4..b9eda7d89e22 100644
> --- a/security/selinux/ss/services.c
> +++ b/security/selinux/ss/services.c
> @@ -2157,8 +2157,8 @@ static void security_load_policycaps(struct selinux_state *state)
>   	}
>   }
>   
> -static int security_preserve_bools(struct selinux_state *state,
> -				   struct policydb *newpolicydb);
> +static void security_preserve_bools(struct policydb *oldpolicydb,
> +				    struct policydb *newpolicydb);
>   
>   /**
>    * security_load_policy - Load a security policy configuration.
> @@ -2257,11 +2257,7 @@ int security_load_policy(struct selinux_state *state, void *data, size_t len)
>   	if (rc)
>   		goto err;
>   
> -	rc = security_preserve_bools(state, newpolicydb);
> -	if (rc) {
> -		pr_err("SELinux:  unable to preserve booleans\n");
> -		goto err;
> -	}
> +	security_preserve_bools(policydb, newpolicydb);
>   
>   	oldsidtab = state->ss->sidtab;
>   
> @@ -2958,11 +2954,8 @@ int security_set_bools(struct selinux_state *state, int len, int *values)
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
> @@ -2999,36 +2992,23 @@ out:
>   	return rc;
>   }
>   
> -static int security_preserve_bools(struct selinux_state *state,
> -				   struct policydb *policydb)
> +static void security_preserve_bools(struct policydb *oldpolicydb,
> +				    struct policydb *newpolicydb)
>   {
> -	int rc, nbools = 0, *bvalues = NULL, i;
> -	char **bnames = NULL;
>   	struct cond_bool_datum *booldatum;
>   	struct cond_node *cur;
> +	int i;
>   
> -	rc = security_get_bools(state, &nbools, &bnames, &bvalues);
> -	if (rc)
> -		goto out;
> -	for (i = 0; i < nbools; i++) {
> -		booldatum = hashtab_search(policydb->p_bools.table, bnames[i]);
> -		if (booldatum)
> -			booldatum->state = bvalues[i];
> -	}
> -	for (cur = policydb->cond_list; cur; cur = cur->next) {
> -		rc = evaluate_cond_node(policydb, cur);
> -		if (rc)
> -			goto out;
> -	}
> +	for (i = 0; i < oldpolicydb->p_bools.nprim; i++) {
> +		const char *name = sym_name(oldpolicydb, SYM_BOOLS, i);
> +		int value = oldpolicydb->bool_val_to_struct[i]->state;
>   
> -out:
> -	if (bnames) {
> -		for (i = 0; i < nbools; i++)
> -			kfree(bnames[i]);
> +		booldatum = hashtab_search(newpolicydb->p_bools.table, name);
> +		if (booldatum)
> +			booldatum->state = value;
>   	}
> -	kfree(bnames);
> -	kfree(bvalues);
> -	return rc;
> +	for (cur = newpolicydb->cond_list; cur; cur = cur->next)
> +		evaluate_cond_node(newpolicydb, cur);
>   }
>   
>   /*
> 

