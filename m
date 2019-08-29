Return-Path: <SRS0=Y9t7=WZ=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE4E4C3A5A3
	for <selinux@archiver.kernel.org>; Thu, 29 Aug 2019 22:05:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 842832070B
	for <selinux@archiver.kernel.org>; Thu, 29 Aug 2019 22:05:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="DvjhVJ+A"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728026AbfH2WFY (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 29 Aug 2019 18:05:24 -0400
Received: from USAT19PA23.eemsg.mail.mil ([214.24.22.197]:27758 "EHLO
        USAT19PA23.eemsg.mail.mil" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726894AbfH2WFY (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 29 Aug 2019 18:05:24 -0400
X-Greylist: delayed 626 seconds by postgrey-1.27 at vger.kernel.org; Thu, 29 Aug 2019 18:05:23 EDT
X-EEMSG-check-017: 22393809|USAT19PA23_ESA_OUT04.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.64,445,1559520000"; 
   d="scan'208";a="22393809"
Received: from emsm-gh1-uea11.ncsc.mil ([214.29.60.3])
  by USAT19PA23.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 29 Aug 2019 20:46:15 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1567111575; x=1598647575;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=cCwQipwradapd1jJ416jlS1TeeBrpVaByP4WzFp95ZQ=;
  b=DvjhVJ+ADuAgBksdCx+7jskojAh+kvLOui2fuYhBgQhZCuRTtPwDWizM
   0i/IirnDScmv7wVe7Sk2LdRvuTZFXOFQ0QfjB7EZZhC1AcmQt1Gzo6JUX
   ZX25tb807PTLcfbH5EFpUWgDGALPAkeOlunUuAujxiJAX2IFj4WFak0o6
   pvI2wPBvYoo6qlgRoxgETRvAr2ee3RH/3xaQw/KkI2d+p7wDe13XP1qKf
   8lM4bivM/URlNQzpVvjHKp254GKqq+PIwj3j43+fYTfxb3+JNNfPYE5SH
   jS8rkcFCOXP1GqBV7EA0l0qbE40MaZL/VA2sMKdGwjsQiuNOR0Xe0syQ/
   Q==;
X-IronPort-AV: E=Sophos;i="5.64,444,1559520000"; 
   d="scan'208";a="32153224"
IronPort-PHdr: =?us-ascii?q?9a23=3AHWcHShWXS1Zggi+W4NSvOCxj0vbV8LGtZVwlr6?=
 =?us-ascii?q?E/grcLSJyIuqrYZRSEtadThVPEFb/W9+hDw7KP9fy5AypZv8zK6SxcOLV3FD?=
 =?us-ascii?q?Y9wf0MmAIhBMPXQWbaF9XNKxIAIcJZSVV+9Gu6O0UGUOz3ZlnVv2HgpWVKQk?=
 =?us-ascii?q?a3OgV6PPn6FZDPhMqrye+y54fTYwJVjzahfL9+Nhq7oRjPusUMnIdvK7g9xh?=
 =?us-ascii?q?TUrnZHeuld2H9lK0+Ukxvg/Mm74YRt8z5Xu/Iv9s5AVbv1cqElRrFGDzooLn?=
 =?us-ascii?q?446tTzuRbMUQWA6H0cUn4LkhVTGAjK8Av6XpbqvSTksOd2xTSXMtf3TbAwXj?=
 =?us-ascii?q?Si8rtrRRr1gyoJKzI17GfagdFrgalFvByuuQBww4/MYIGUKvV+eL/dfcgHTm?=
 =?us-ascii?q?ZFR8pdSjBNDp+5Y4YJAeUBJ+JYpJTjqVUIoxW1GA2gCPrhxzJMg3P727Ax3e?=
 =?us-ascii?q?Y8HgHcxAEuAswAsHrUotv2OqkdX++6w6vUwjvMdP5WxTXw5ZLUfhw9r/yBX7?=
 =?us-ascii?q?R9etfRx0k1EAPFi02dp5H5PzyLzuQNs3aU7+x9Xuyyjm4osQVxojyxycYsl4?=
 =?us-ascii?q?LEgZkVxU3f9Shi3IY0JcG3SE58YdK+FptQrDuVO5F5QsMlXWFloSA3waAFt5?=
 =?us-ascii?q?6jZCUG1ZsqyhHFZ/GHboSE+AzvWemPLTtimX5ofq+0iQyo/ki60OL8U9G50F?=
 =?us-ascii?q?NNriVYjNbBrmsN1xnP6sifTft941uh1S6P1w/N7uFEJlg5lbbBJJ47w74wi4?=
 =?us-ascii?q?ETvV7fHi72hEr2jKiWel8i+ue08OTofq/qppqdN49wkg3+M6IuldKjAekgLw?=
 =?us-ascii?q?QDUGeW9f682bH+50H1XrpHguMsnqXEqJzaIN4Upq+9Aw9byIYj7BO/Ai+90N?=
 =?us-ascii?q?sFhnkKN05FeRKbgIjpPFHCOvb4DeyljFi2nzdrwO7GMqX7AprRNnjDjKvhfb?=
 =?us-ascii?q?Fl5k5ezwoz1tBf549OBb0bO/3zQE7xtNrFAR89LQO52ProCM9g1oMYRW2PAq?=
 =?us-ascii?q?+YP77Ivl+U/O0jOfWDZIgQuDzlMfgq++bujWMlmV8aZaSpxoUYaHS5HvRgPk?=
 =?us-ascii?q?WYbmHhgskOEWgUpAoyVu/qh0OYUT5VeXmyW7gw5jYhCIKpFY3DXJyigKSd3C?=
 =?us-ascii?q?enGZ1bfnhGBUqREXfsbIiEQ+0DaD+WIsN4lzwEUr+hS5U/2h20qAD6zL9nJP?=
 =?us-ascii?q?LO+iIErZLjyMR15+rLmB4u9Tx7FcKd03qKT2FyhW4ISTg23LpjrkNj0leD1q?=
 =?us-ascii?q?l4g/pEFdBJ+/xJVQI6ZtbgyLlYDMvyRwuJVM2ITlqiT53yAzYqTs84hdUUYk?=
 =?us-ascii?q?BxH9iKhQre2SGqErMci7XND5sxpOaUxHX1JsBg217Y26Q7yVorWM1CMSuhnK?=
 =?us-ascii?q?Es2RLUAtvyj0iBl6usPZ8Z1SrJ+XbLmXGCp2lEQQVwVuPDRnlZaUzI+4eqrn?=
 =?us-ascii?q?jeRqOjXOx0ejBKztSPf+4TMYzk?=
X-IPAS-Result: =?us-ascii?q?A2A5BwBVOWhd/wHyM5BmHQEBBQEHBQGBZ4FuKoE/ATIqh?=
 =?us-ascii?q?CGPWAEBAQEGgTaJbpElCQEBAQEBAQEBATQBAgEBhD8CglkjOBMCCwEBAQQBA?=
 =?us-ascii?q?QEBAQYDAQFshTqCOikBgmYBAQEBAgEjBBE6BxALGAICEgETAgJXBgEMBgIBA?=
 =?us-ascii?q?ReCSD+BdwUPrBh/M4VKgzuBSYEMKIt3GHiBB4E4gms+hA1/AoJBglgEjEeId?=
 =?us-ascii?q?5VdbQmCIIImjUmEXgYbmF0tjUKaRiGBWCsIAhgIIQ+DJ4JOF44hHSMDMIEGA?=
 =?us-ascii?q?QGMMgINF4IuAQE?=
Received: from tarius.tycho.ncsc.mil ([144.51.242.1])
  by emsm-gh1-uea11.NCSC.MIL with ESMTP; 29 Aug 2019 20:45:53 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id x7TKjmmH019969;
        Thu, 29 Aug 2019 16:45:49 -0400
Subject: Re: [PATCH v2] default_range glblub implementation
To:     Joshua Brindle <joshua.brindle@crunchydata.com>,
        selinux@vger.kernel.org
Cc:     paul@paul-moore.com, Chad Hanson <chanson@forcepoint.com>
References: <20190828204259.23160-1-joshua.brindle@crunchydata.com>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <bdab2922-a4e0-8d5b-514d-2874e0be1440@tycho.nsa.gov>
Date:   Thu, 29 Aug 2019 16:45:48 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190828204259.23160-1-joshua.brindle@crunchydata.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 8/28/19 4:43 PM, Joshua Brindle wrote:
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

I don't quite understand why it is an AND / intersection of the 
categories on both levels.  Normally lub would be an OR / union. 
Possibly it is just a terminology issue.  Is this "glblub" relation 
defined by anyone else, or used in any other MLS system?

Also, I'm left wondering whether certain cases of differing category 
sets ought to yield an INVALID state.  What if the user's permitted 
range was s0:c0,c5-s15:c0,c5 and the network device label was s0:c13? Or 
take your last example - is it really correct to let the user login w/o c0?

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
> index 2260c44a568c..0a0fbcc0d90c 100644
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

This error will get propagate to userspace as an errno? So it should be 
-EINVAL?

> +
> +	// Take the greatest of the low
> +	dr->level[0].sens = max(r1->level[0].sens, r2->level[0].sens);
> +
> +        // Take the least of the high
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
> index 09929fc5ab47..c0a9f8ecffc3 100644
> --- a/security/selinux/ss/ebitmap.c
> +++ b/security/selinux/ss/ebitmap.c
> @@ -77,6 +77,24 @@ int ebitmap_cpy(struct ebitmap *dst, struct ebitmap *src)
>   	return 0;
>   }
>   
> +int ebitmap_and(struct ebitmap *dst, struct ebitmap *e1, struct ebitmap *e2)
> +{
> +	struct ebitmap_node *n;
> +	int bit;
> +
> +	ebitmap_init(dst);
> +
> +	ebitmap_for_each_positive_bit(e1, n, bit) {
> +		if (ebitmap_get_bit(e2, bit)) {
> +			int rc = ebitmap_set_bit(dst, bit, 1);
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

