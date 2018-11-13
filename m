Return-Path: <SRS0=smjq=NY=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC9A1C43441
	for <selinux@archiver.kernel.org>; Tue, 13 Nov 2018 21:17:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 770AB20869
	for <selinux@archiver.kernel.org>; Tue, 13 Nov 2018 21:17:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 770AB20869
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tycho.nsa.gov
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=selinux-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726291AbeKNHRP (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 14 Nov 2018 02:17:15 -0500
Received: from uhil19pa11.eemsg.mail.mil ([214.24.21.84]:58598 "EHLO
        uhil19pa11.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725748AbeKNHRP (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 14 Nov 2018 02:17:15 -0500
X-EEMSG-check-008: 356812534|UHIL19PA11_EEMSG_MP9.csd.disa.mil
Received: from emsm-gh1-uea11.ncsc.mil ([214.29.60.3])
  by uhil19pa11.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 13 Nov 2018 21:17:03 +0000
X-IronPort-AV: E=Sophos;i="5.56,229,1539648000"; 
   d="scan'208";a="20578350"
IronPort-PHdr: =?us-ascii?q?9a23=3ApXMtDRPuOr/pvhitD44l6mtUPXoX/o7sNwtQ0K?=
 =?us-ascii?q?IMzox0I/r+rarrMEGX3/hxlliBBdydt6obzbKO+4nbGkU4qa6bt34DdJEeHz?=
 =?us-ascii?q?Qksu4x2zIaPcieFEfgJ+TrZSFpVO5LVVti4m3peRMNQJW2aFLduGC94iAPER?=
 =?us-ascii?q?vjKwV1Ov71GonPhMiryuy+4ZLebxlKiTanfb9+MAi9oBnMuMURnYZsMLs6xA?=
 =?us-ascii?q?HTontPdeRWxGdoKkyWkh3h+Mq+/4Nt/jpJtf45+MFOTav1f6IjTbxFFzsmKH?=
 =?us-ascii?q?w65NfqtRbYUwSC4GYXX3gMnRpJBwjF6wz6Xov0vyDnuOdxxDWWMMvrRr0vRz?=
 =?us-ascii?q?+s87lkRwPpiCcfNj427mfXitBrjKlGpB6tvgFzz5LIbI2QMvdxcLndfdcHTm?=
 =?us-ascii?q?RfWMhfWTFKDoelY4cRE+YNOOBVpJT/qVQTtxuzHRSiCv3hyjFIhXH406M13O?=
 =?us-ascii?q?sjHg7a0wItBM4OvXbOodnpKKsfX+K4wa/VxjvDdfNW3jL95ZDVfBA9v/6MRb?=
 =?us-ascii?q?JwftTXyUIyCg3Fi0+fqYjhPzyL1uUGrm+W7/F9WuK0kGMntwFwrSSvxscrkI?=
 =?us-ascii?q?XJgJkVxUre+SV2x4Y1O8S1RUhmatCnCJtdrzyWOoR5T884Q2xkpTw2xqMJtJ?=
 =?us-ascii?q?KlZiQG1ZIqzAPFZfOdaYiH+BfjWf6UITd/mX1qZqqyhw238Ui80u38UdS00E?=
 =?us-ascii?q?pSoipFjNbMsncN2gTP6sedUPt9/1qh2S2V2wDP6uBLPUA0la3BJ54n3rEwjY?=
 =?us-ascii?q?YcvV7GHi/3nEX6lK6WdkM69ei08+nrf7rrq5CGO4J0lw3yKLoil8OhDegiLw?=
 =?us-ascii?q?QCR22b9v691L3n8035WrJKjvgun6nCrZ/aPt8WprK5AgBJ0oYj7AyzDzG90N?=
 =?us-ascii?q?sCh3UHI1VFeAyfg4jzJ17OOOz4Deu4g1m0lzdrwvfGPqbnAprXMnfMjqzsfa?=
 =?us-ascii?q?xj5EFByAo818xf64hIBbEGJfL5QlXxu8DADh8lLwy0xP7qCM5j2YMaWGKPBL?=
 =?us-ascii?q?KZMazJvF+W6eIgPfOMaJUWuDnjMfgl4eDhjXsjlV8aZ6mp0oMdaGqkEfR+P0?=
 =?us-ascii?q?WZfX3sj88ZEWgQowo+SPfniEWYXj5OY3a+Rqc85jY8CIK8E4jPXJyigLuE3H?=
 =?us-ascii?q?TzIpoDQWZKEF2OWVLvbIONUPoPIHaVJ8h6lDUPWJC7RoMh3A3ovwj/nf4vNe?=
 =?us-ascii?q?fQ+ysFpbr929Vvoe7ejxc/8XpzFcvZm1mEUmU8u2QPXTJ+iLh2vEhV0l6e1e?=
 =?us-ascii?q?19hPtCGJpY4PYfASkgMpuJ9PB3E9D/XEr6e96NTFu3CoG9DSoZUsM6w9hIZV?=
 =?us-ascii?q?10XdqlkEaQjGKRH7YJmunTV9QP+aXG0i20fpwlxg=3D=3D?=
X-IPAS-Result: =?us-ascii?q?A2CFAAA1Putb/wHyM5BjGwEBAQEDAQEBBwMBAQGBVAMBA?=
 =?us-ascii?q?QELAYFaKYE1MyeDeJQVTQEBAQEBBoEQJYkVkBo4AYRAAoM8IjcKDQEDAQEBA?=
 =?us-ascii?q?QEBAgFsKII2JAGCYAEFIwQRQRALDgoCAiYCAlcGAQwGAgEBFoJIP4F1Dah5f?=
 =?us-ascii?q?DOFQIRkgQuKdxd4gQeBEScMgl+IAoJXAokUhjQzj1sJkRwGGJBzmVYigVUrC?=
 =?us-ascii?q?AIYCCEPgyeCJxeOOiEDMIEFAQGNGgEB?=
Received: from tarius.tycho.ncsc.mil ([144.51.242.1])
  by emsm-gh1-uea11.NCSC.MIL with ESMTP; 13 Nov 2018 21:17:02 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id wADLGxvU018544;
        Tue, 13 Nov 2018 16:16:59 -0500
Subject: Re: [RFC PATCH 1/3] selinux: refactor sidtab conversion
To:     Ondrej Mosnacek <omosnace@redhat.com>, selinux@vger.kernel.org,
        Paul Moore <paul@paul-moore.com>
Cc:     selinux@tycho.nsa.gov
References: <20181113135255.26045-1-omosnace@redhat.com>
 <20181113135255.26045-2-omosnace@redhat.com>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <d461e212-2227-bd83-ca57-3b8d97bd23b6@tycho.nsa.gov>
Date:   Tue, 13 Nov 2018 16:19:14 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181113135255.26045-2-omosnace@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 11/13/18 8:52 AM, Ondrej Mosnacek wrote:
> This is a purely cosmetic change that encapsulates the three-step sidtab
> conversion logic (shutdown -> clone -> map) into a single function
> defined in sidtab.c (as opposed to services.c).
> 
> Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>

Acked-by: Stephen Smalley <sds@tycho.nsa.gov>

> ---
>   security/selinux/ss/services.c | 22 +--------------
>   security/selinux/ss/sidtab.c   | 50 ++++++++++++++++++++++++----------
>   security/selinux/ss/sidtab.h   | 11 ++++----
>   3 files changed, 42 insertions(+), 41 deletions(-)
> 
> diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
> index 12e414394530..7337db24a6a8 100644
> --- a/security/selinux/ss/services.c
> +++ b/security/selinux/ss/services.c
> @@ -1880,19 +1880,6 @@ int security_change_sid(struct selinux_state *state,
>   				    out_sid, false);
>   }
>   
> -/* Clone the SID into the new SID table. */
> -static int clone_sid(u32 sid,
> -		     struct context *context,
> -		     void *arg)
> -{
> -	struct sidtab *s = arg;
> -
> -	if (sid > SECINITSID_NUM)
> -		return sidtab_insert(s, sid, context);
> -	else
> -		return 0;
> -}
> -
>   static inline int convert_context_handle_invalid_context(
>   	struct selinux_state *state,
>   	struct context *context)
> @@ -2186,13 +2173,6 @@ int security_load_policy(struct selinux_state *state, void *data, size_t len)
>   		goto err;
>   	}
>   
> -	/* Clone the SID table. */
> -	sidtab_shutdown(sidtab);
> -
> -	rc = sidtab_map(sidtab, clone_sid, &newsidtab);
> -	if (rc)
> -		goto err;
> -
>   	/*
>   	 * Convert the internal representations of contexts
>   	 * in the new SID table.
> @@ -2200,7 +2180,7 @@ int security_load_policy(struct selinux_state *state, void *data, size_t len)
>   	args.state = state;
>   	args.oldp = policydb;
>   	args.newp = newpolicydb;
> -	rc = sidtab_map(&newsidtab, convert_context, &args);
> +	rc = sidtab_convert(sidtab, &newsidtab, convert_context, &args);
>   	if (rc) {
>   		pr_err("SELinux:  unable to convert the internal"
>   			" representation of contexts in the new SID"
> diff --git a/security/selinux/ss/sidtab.c b/security/selinux/ss/sidtab.c
> index fd75a12fa8fc..e66a2ab3d1c2 100644
> --- a/security/selinux/ss/sidtab.c
> +++ b/security/selinux/ss/sidtab.c
> @@ -116,11 +116,11 @@ struct context *sidtab_search_force(struct sidtab *s, u32 sid)
>   	return sidtab_search_core(s, sid, 1);
>   }
>   
> -int sidtab_map(struct sidtab *s,
> -	       int (*apply) (u32 sid,
> -			     struct context *context,
> -			     void *args),
> -	       void *args)
> +static int sidtab_map(struct sidtab *s,
> +		      int (*apply) (u32 sid,
> +				    struct context *context,
> +				    void *args),
> +		      void *args)
>   {
>   	int i, rc = 0;
>   	struct sidtab_node *cur;
> @@ -141,6 +141,37 @@ out:
>   	return rc;
>   }
>   
> +/* Clone the SID into the new SID table. */
> +static int clone_sid(u32 sid, struct context *context, void *arg)
> +{
> +	struct sidtab *s = arg;
> +
> +	if (sid > SECINITSID_NUM)
> +		return sidtab_insert(s, sid, context);
> +	else
> +		return 0;
> +}
> +
> +int sidtab_convert(struct sidtab *s, struct sidtab *news,
> +		   int (*convert) (u32 sid,
> +				   struct context *context,
> +				   void *args),
> +		   void *args)
> +{
> +	unsigned long flags;
> +	int rc;
> +
> +	spin_lock_irqsave(&s->lock, flags);
> +	s->shutdown = 1;
> +	spin_unlock_irqrestore(&s->lock, flags);
> +
> +	rc = sidtab_map(s, clone_sid, news);
> +	if (rc)
> +		return rc;
> +
> +	return sidtab_map(news, convert, args);
> +}
> +
>   static void sidtab_update_cache(struct sidtab *s, struct sidtab_node *n, int loc)
>   {
>   	BUG_ON(loc >= SIDTAB_CACHE_LEN);
> @@ -295,12 +326,3 @@ void sidtab_set(struct sidtab *dst, struct sidtab *src)
>   		dst->cache[i] = NULL;
>   	spin_unlock_irqrestore(&src->lock, flags);
>   }
> -
> -void sidtab_shutdown(struct sidtab *s)
> -{
> -	unsigned long flags;
> -
> -	spin_lock_irqsave(&s->lock, flags);
> -	s->shutdown = 1;
> -	spin_unlock_irqrestore(&s->lock, flags);
> -}
> diff --git a/security/selinux/ss/sidtab.h b/security/selinux/ss/sidtab.h
> index a1a1d2617b6f..26c74fe7afc0 100644
> --- a/security/selinux/ss/sidtab.h
> +++ b/security/selinux/ss/sidtab.h
> @@ -37,11 +37,11 @@ int sidtab_insert(struct sidtab *s, u32 sid, struct context *context);
>   struct context *sidtab_search(struct sidtab *s, u32 sid);
>   struct context *sidtab_search_force(struct sidtab *s, u32 sid);
>   
> -int sidtab_map(struct sidtab *s,
> -	       int (*apply) (u32 sid,
> -			     struct context *context,
> -			     void *args),
> -	       void *args);
> +int sidtab_convert(struct sidtab *s, struct sidtab *news,
> +		   int (*apply) (u32 sid,
> +				 struct context *context,
> +				 void *args),
> +		   void *args);
>   
>   int sidtab_context_to_sid(struct sidtab *s,
>   			  struct context *context,
> @@ -50,7 +50,6 @@ int sidtab_context_to_sid(struct sidtab *s,
>   void sidtab_hash_eval(struct sidtab *h, char *tag);
>   void sidtab_destroy(struct sidtab *s);
>   void sidtab_set(struct sidtab *dst, struct sidtab *src);
> -void sidtab_shutdown(struct sidtab *s);
>   
>   #endif	/* _SS_SIDTAB_H_ */
>   
> 

