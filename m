Return-Path: <SRS0=26Hx=W2=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43EDAC3A5A4
	for <selinux@archiver.kernel.org>; Fri, 30 Aug 2019 15:44:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0522321897
	for <selinux@archiver.kernel.org>; Fri, 30 Aug 2019 15:44:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="CyFJ0Z2T"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728072AbfH3Pog (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 30 Aug 2019 11:44:36 -0400
Received: from UHIL19PA40.eemsg.mail.mil ([214.24.21.199]:16432 "EHLO
        UHIL19PA40.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728415AbfH3Pog (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 30 Aug 2019 11:44:36 -0400
X-EEMSG-check-017: 20121010|UHIL19PA40_ESA_OUT06.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.64,447,1559520000"; 
   d="scan'208";a="20121010"
Received: from emsm-gh1-uea11.ncsc.mil ([214.29.60.3])
  by UHIL19PA40.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 30 Aug 2019 15:44:34 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1567179874; x=1598715874;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=j0ncfvefTeg+//nTCANqw7swJ+MixUVh85g9WCH1Tos=;
  b=CyFJ0Z2TiEeccfYXjCLbf5gffc87IUY1qCH+VtZiUxmW10lkSHQIpPWX
   fRe1adXHZ0/cPqmymJeDI8sTptvig3Rr5/7jyeyimlHLpFouWGvNmC77P
   jXgFQHsnrGz/Cw2jfR9PN+iEfEO1xHrJ0gHVkQjnzWMUJxqg7F29Vy8UY
   x406p/BPTVgEkIE6ITnTpH4uWjrzRAy1NtmZs0YcHJLPJlPr9l0mEIlV1
   6NfVoULOFIT9OmvuLP0PWfK2kdz8yq7FpbzIxvtiVqJ6FCjqFpmy09Q0P
   iiSiKpheqmk9narNt0FzCbEZuT8mwWakn0ovWvtasMtFCnbAu+d3JrAl2
   Q==;
X-IronPort-AV: E=Sophos;i="5.64,447,1559520000"; 
   d="scan'208";a="32186255"
IronPort-PHdr: =?us-ascii?q?9a23=3AjzBSoxcg5/MjeD3HvjJ9FDpPlGMj4u6mDksu8p?=
 =?us-ascii?q?Mizoh2WeGdxcW9YR7h7PlgxGXEQZ/co6odzbaP6ea5BzBLscfJmUtBWaQEbw?=
 =?us-ascii?q?UCh8QSkl5oK+++Imq/EsTXaTcnFt9JTl5v8iLzG0FUHMHjew+a+SXqvnYdFR?=
 =?us-ascii?q?rlKAV6OPn+FJLMgMSrzeCy/IDYbxlViDanbr5+MQu6oR/MusQXjoZuJaU8xx?=
 =?us-ascii?q?/UqXZUZupawn9lK0iOlBjm/Mew+5Bj8yVUu/0/8sNLTLv3caclQ7FGFToqK2?=
 =?us-ascii?q?866tHluhnFVguP+2ATUn4KnRpSAgjK9w/1U5HsuSbnrOV92S2aPcrrTbAoXD?=
 =?us-ascii?q?mp8qlmRAP0hCoBKjU063/chNBug61HoRKhvx1/zJDSYIGJL/p1Y6fRccoHSW?=
 =?us-ascii?q?ZdQspdUipMDY2mb4sLEuEPI+BWoYfgrFcKtBezCw2hCObpxzRVhHH5wLc63v?=
 =?us-ascii?q?w8Hw/Y0gwuH9EAvnrao9r6NqgdTe+7wbLUzTjBdf5axSvx5YbKfx0nvPqCXa?=
 =?us-ascii?q?hwcc3UyUQ3Cg3FkkufqZTlPzyL0OQGrnWV7+96WuKrj24otQFwqSWoy8c3l4?=
 =?us-ascii?q?bJnZkYykzE9CplwIY1Ise0SEhgYdG+CpdQuCaaN5VvT84kXmpmuz46x6UbtZ?=
 =?us-ascii?q?O0cyUG0pQqywPFZ/CZfIWE/AjvWPuXLDxlnnxqYqi/iAy38UW4z+38UdS730?=
 =?us-ascii?q?hSoypel9nMqmgN1xvO6sibUvd9/lmu2TKI1w3L9uFLO1o0lavGK5462LIwip?=
 =?us-ascii?q?oSvljDHi/xgkn2irOZdl449eSy7uTnY7HmqoedN49ylA7+LrwjltGwDOk3KA?=
 =?us-ascii?q?QDX3WX9f6i2LDs40H1WqhGguUzkqbDsZDaIcobprS+Aw9Qyosj8AuwDyy93d?=
 =?us-ascii?q?QEnXgIMFJFeBWdg4jvIFHBOur0Dfi4g1SyiDtr3ezJPqX9ApXRKXjOiLXhfb?=
 =?us-ascii?q?Fm605c1Qo818pT6IlOCrEAJvL8R0vxu8LDAxAlKQy03uDnB8l91oIeRG2AGL?=
 =?us-ascii?q?OZP7nIvVCU4eIvJvGGZJUJtzblN/gl+/nugGcimVADeamp3J0XaG23H/l9PU?=
 =?us-ascii?q?WZbmTjgs0bHWcJoAU+Vurqh0OGUTJJYHayRa087CkhCI26FYfDWpytgLuZ0S?=
 =?us-ascii?q?ejBJJWe2RGB0uUEXjyaoWEX+4AaCeVIs9miDwLS6KtRJMm1RGr50fGzO9FKf?=
 =?us-ascii?q?HU5yRQn4ji0tRx6qWHlxYp9SF9Sc6H0meBS2xclXkVQTQ2zax2vUU7wVCGh+?=
 =?us-ascii?q?wwmPFcFNpO99tXXQogc53R1ep3D5b1QA2SUM2OTQOdXti+ATw3Buk0ytsKbl?=
 =?us-ascii?q?c1T86ulTjfziGqBPkTjLXNC5sqpPGPl0PtLtpwni6VnJIqiEMrF44Wbjyr?=
X-IPAS-Result: =?us-ascii?q?A2BIAQACRGld/wHyM5BmHAEBAQQBAQcEAQGBVgQBAQsBg?=
 =?us-ascii?q?W0qgUAyKoQhj1gBAQEBAQaBNolvkSYJAQEBAQEBAQEBNAECAQGEPwKCYCM3B?=
 =?us-ascii?q?g4CCwEBAQQBAQEBAQYDAQFshTqCOikBgmcBBSMEEUEQCxgCAiYCAlcGAQwGA?=
 =?us-ascii?q?gEBF4JIP4F3FK0ZfzOFSoM2gUmBDCgBi3cYeIEHgTiCaz6EDYNCglgEjEmIe?=
 =?us-ascii?q?ZVgbYIpgieSKgYbgjKLUopeLY1FmlIigVgrCAIYCCEPgyeCTheOIR0jAzCBB?=
 =?us-ascii?q?gEBi1eCVAEB?=
Received: from tarius.tycho.ncsc.mil ([144.51.242.1])
  by emsm-gh1-uea11.NCSC.MIL with ESMTP; 30 Aug 2019 15:44:22 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id x7UFiLtb014949;
        Fri, 30 Aug 2019 11:44:21 -0400
Subject: Re: [PATCH v3] default_range glblub implementation
To:     Joshua Brindle <joshua.brindle@crunchydata.com>,
        selinux@vger.kernel.org
Cc:     paul@paul-moore.com
References: <20190830153946.28159-1-joshua.brindle@crunchydata.com>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <85c1aba4-39ce-ba21-bb8c-30aa71bab06c@tycho.nsa.gov>
Date:   Fri, 30 Aug 2019 11:44:21 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190830153946.28159-1-joshua.brindle@crunchydata.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 8/30/19 11:39 AM, Joshua Brindle wrote:
> A policy developer can now specify glblub as a default_range default and
> the computed transition will be the intersection of the mls range of
> the two contexts.
> 
> The glb (greatest lower bound) lub (lowest upper bound) of a range is calculated
> as the greater of the low sensitivities and the lower of the high sensitivities
> and the and of each category bitmap.
> 
> This can be used by MLS solution developers to compute a context that satisfies,
> for example, the range of a network interface and the range of a user logging in.
> 
> Some examples are:
> 
> User Permitted Range | Network Device Label | Computed Label
> ---------------------|----------------------|----------------
> S0-S1:c0.c12         | S0                   | S0
> S0-S1:c0.c12         | S0-S1:c0.c1024       | S0-S1:c0.c12
> S0-S4:c0.c512        | S1-S1:c0.c1024       | S1-S1:c0.c512
> S0-S16:c0,c2         | S4-S6:c0.c128        | S4-S6:c0,c2
> S0-S4                | S2-S6                | S2-S4
> S0-S4                | S5-S8                | INVALID
> S5-S8                | S0-S4                | INVALID
> S6:c0,c2-S7:c4,c5    | S0:c2,c4-S6:c5.c100  | S6:c2-S6:c5
> 
> Signed-off-by: Joshua Brindle <joshua.brindle@crunchydata.com>
> ---
>   security/selinux/include/security.h |  3 ++-
>   security/selinux/ss/context.h       | 28 ++++++++++++++++++++++++++++
>   security/selinux/ss/ebitmap.c       | 18 ++++++++++++++++++
>   security/selinux/ss/ebitmap.h       |  1 +
>   security/selinux/ss/mls.c           |  2 ++
>   security/selinux/ss/policydb.c      |  5 +++++
>   security/selinux/ss/policydb.h      |  1 +
>   7 files changed, 57 insertions(+), 1 deletion(-)
> 
> diff --git a/security/selinux/include/security.h b/security/selinux/include/security.h
> index 111121281c47..ae840634e3c7 100644
> --- a/security/selinux/include/security.h
> +++ b/security/selinux/include/security.h
> @@ -40,10 +40,11 @@
>   #define POLICYDB_VERSION_CONSTRAINT_NAMES	29
>   #define POLICYDB_VERSION_XPERMS_IOCTL	30
>   #define POLICYDB_VERSION_INFINIBAND		31
> +#define POLICYDB_VERSION_GLBLUB		32
>   
>   /* Range of policy versions we understand*/
>   #define POLICYDB_VERSION_MIN   POLICYDB_VERSION_BASE
> -#define POLICYDB_VERSION_MAX   POLICYDB_VERSION_INFINIBAND
> +#define POLICYDB_VERSION_MAX   POLICYDB_VERSION_GLBLUB
>   
>   /* Mask for just the mount related flags */
>   #define SE_MNTMASK	0x0f
> diff --git a/security/selinux/ss/context.h b/security/selinux/ss/context.h
> index 2260c44a568c..ea2a56d910a5 100644
> --- a/security/selinux/ss/context.h
> +++ b/security/selinux/ss/context.h
> @@ -95,6 +95,34 @@ static inline int mls_context_cpy_high(struct context *dst, struct context *src)
>   	return rc;
>   }
>   
> +
> +static inline int mls_context_glblub(struct context *dst, struct context *c1, struct context *c2)
> +{
> +	struct mls_range *dr = &dst->range, *r1 = &c1->range, *r2 = &c2->range;
> +	int rc = 0;
> +
> +	if (r1->level[1].sens < r2->level[0].sens || r2->level[1].sens < r1->level[0].sens)
> +		/* These ranges have no common sensitivities */
> +		return -1;

I mentioned this on the prior patch, but perhaps you didn't read past 
the first comment: I think you need to return -EINVAL or some other 
-errno value here since this will get propagated up to the userspace 
caller as an errno if I am not mistaken.

> +
> +	/* Take the greatest of the low */
> +	dr->level[0].sens = max(r1->level[0].sens, r2->level[0].sens);
> +
> +	/* Take the least of the high */
> +	dr->level[1].sens = min(r1->level[1].sens, r2->level[1].sens);
> +
> +	rc = ebitmap_and(&dr->level[0].cat, &r1->level[0].cat, &r2->level[0].cat);
> +	if (rc)
> +		goto out;
> +
> +	rc = ebitmap_and(&dr->level[1].cat, &r1->level[1].cat, &r2->level[1].cat);
> +	if (rc)
> +		goto out;
> +
> +out:
> +	return rc;
> +}
> +
>   static inline int mls_context_cmp(struct context *c1, struct context *c2)
>   {
>   	return ((c1->range.level[0].sens == c2->range.level[0].sens) &&
> diff --git a/security/selinux/ss/ebitmap.c b/security/selinux/ss/ebitmap.c
> index 09929fc5ab47..c8c3663111e2 100644
> --- a/security/selinux/ss/ebitmap.c
> +++ b/security/selinux/ss/ebitmap.c
> @@ -77,6 +77,24 @@ int ebitmap_cpy(struct ebitmap *dst, struct ebitmap *src)
>   	return 0;
>   }
>   
> +int ebitmap_and(struct ebitmap *dst, struct ebitmap *e1, struct ebitmap *e2)
> +{
> +	struct ebitmap_node *n;
> +	int bit, rc;
> +
> +	ebitmap_init(dst);
> +
> +	ebitmap_for_each_positive_bit(e1, n, bit) {
> +		if (ebitmap_get_bit(e2, bit)) {
> +			rc = ebitmap_set_bit(dst, bit, 1);
> +			if (rc < 0)
> +				return rc;
> +		}
> +	}
> +	return 0;
> +}
> +
> +
>   #ifdef CONFIG_NETLABEL
>   /**
>    * ebitmap_netlbl_export - Export an ebitmap into a NetLabel category bitmap
> diff --git a/security/selinux/ss/ebitmap.h b/security/selinux/ss/ebitmap.h
> index 6aa7cf6a2197..9a23b81b8832 100644
> --- a/security/selinux/ss/ebitmap.h
> +++ b/security/selinux/ss/ebitmap.h
> @@ -124,6 +124,7 @@ static inline void ebitmap_node_clr_bit(struct ebitmap_node *n,
>   
>   int ebitmap_cmp(struct ebitmap *e1, struct ebitmap *e2);
>   int ebitmap_cpy(struct ebitmap *dst, struct ebitmap *src);
> +int ebitmap_and(struct ebitmap *dst, struct ebitmap *e1, struct ebitmap *e2);
>   int ebitmap_contains(struct ebitmap *e1, struct ebitmap *e2, u32 last_e2bit);
>   int ebitmap_get_bit(struct ebitmap *e, unsigned long bit);
>   int ebitmap_set_bit(struct ebitmap *e, unsigned long bit, int value);
> diff --git a/security/selinux/ss/mls.c b/security/selinux/ss/mls.c
> index 5e05f5b902d7..76c8ad014ac9 100644
> --- a/security/selinux/ss/mls.c
> +++ b/security/selinux/ss/mls.c
> @@ -529,6 +529,8 @@ int mls_compute_sid(struct policydb *p,
>   			return mls_context_cpy_high(newcontext, tcontext);
>   		case DEFAULT_TARGET_LOW_HIGH:
>   			return mls_context_cpy(newcontext, tcontext);
> +		case DEFAULT_GLBLUB:
> +			return mls_context_glblub(newcontext, scontext, tcontext);
>   		}
>   
>   		/* Fallthrough */
> diff --git a/security/selinux/ss/policydb.c b/security/selinux/ss/policydb.c
> index f8efaa9f647c..1b59f72effbb 100644
> --- a/security/selinux/ss/policydb.c
> +++ b/security/selinux/ss/policydb.c
> @@ -160,6 +160,11 @@ static struct policydb_compat_info policydb_compat[] = {
>   		.sym_num	= SYM_NUM,
>   		.ocon_num	= OCON_NUM,
>   	},
> +	{
> +		.version	= POLICYDB_VERSION_GLBLUB,
> +		.sym_num	= SYM_NUM,
> +		.ocon_num	= OCON_NUM,
> +	},
>   };
>   
>   static struct policydb_compat_info *policydb_lookup_compat(int version)
> diff --git a/security/selinux/ss/policydb.h b/security/selinux/ss/policydb.h
> index fcc6366b447f..0c41d0b4da96 100644
> --- a/security/selinux/ss/policydb.h
> +++ b/security/selinux/ss/policydb.h
> @@ -69,6 +69,7 @@ struct class_datum {
>   #define DEFAULT_TARGET_LOW     4
>   #define DEFAULT_TARGET_HIGH    5
>   #define DEFAULT_TARGET_LOW_HIGH        6
> +#define DEFAULT_GLBLUB		7
>   	char default_range;
>   };
>   
> 

