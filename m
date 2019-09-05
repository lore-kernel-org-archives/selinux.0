Return-Path: <SRS0=j8XY=XA=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F513C43331
	for <selinux@archiver.kernel.org>; Thu,  5 Sep 2019 18:09:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D74C206BA
	for <selinux@archiver.kernel.org>; Thu,  5 Sep 2019 18:09:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="Mx2+1Ps/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728356AbfIESJD (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 5 Sep 2019 14:09:03 -0400
Received: from USAT19PA24.eemsg.mail.mil ([214.24.22.198]:34803 "EHLO
        USAT19PA24.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726837AbfIESJC (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 5 Sep 2019 14:09:02 -0400
X-EEMSG-check-017: 24452249|USAT19PA24_ESA_OUT05.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.64,470,1559520000"; 
   d="scan'208";a="24452249"
Received: from emsm-gh1-uea10.ncsc.mil ([214.29.60.2])
  by USAT19PA24.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 05 Sep 2019 18:08:22 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1567706902; x=1599242902;
  h=subject:to:references:from:message-id:date:mime-version:
   in-reply-to:content-transfer-encoding;
  bh=1v1D8DZDjyKiWQwsC+fkm7rOYl3/OEib2WbspCSyOdY=;
  b=Mx2+1Ps/FUh7bWC8VXjD7WwpQhSc0BGp8kwIeW7+nQ4DayB8d9u7DGBc
   m7mNEE/fkm6bDg0DrtWaE7XwyM8irWO8kJTtbfYrmEztrSN9NIYt+ZePy
   h7FCNEfWk6OveTuzB02u/uviXX3e9GSRQohO1owUBozocW4OTEx2fSER5
   /26d+RreYYj3cYVcI9gp2WxIznqzaPdI/gObxDC4CobhWKrN+z8ooFA0r
   W3f8/q0nbmut3ZiN+UGyHOf2acnLGRdHsbIQzNfeyvyp6HKQDNhXpiDAw
   xgeR2LPpAy6iG7LlG13VQt/6YfQRNBOk2UL3RVodRuUMwsn7NvBkuHXBw
   w==;
X-IronPort-AV: E=Sophos;i="5.64,470,1559520000"; 
   d="scan'208";a="27572040"
IronPort-PHdr: =?us-ascii?q?9a23=3AtegGbR9vCFZ09v9uRHKM819IXTAuvvDOBiVQ1K?=
 =?us-ascii?q?B21+McTK2v8tzYMVDF4r011RmVBN+dsq0bwLuJ+4nbGkU4qa6bt34DdJEeHz?=
 =?us-ascii?q?Qksu4x2zIaPcieFEfgJ+TrZSFpVO5LVVti4m3peRMNQJW2aFLduGC94iAPER?=
 =?us-ascii?q?vjKwV1Ov71GonPhMiryuy+4ZLebxhWiDanfL9/Lhe7oQrVu8QUnIBvNrs/xh?=
 =?us-ascii?q?zVr3VSZu9Y33loJVWdnxb94se/4ptu+DlOtvwi6sBNT7z0c7w3QrJEAjsmNX?=
 =?us-ascii?q?s15NDwuhnYUQSP/HocXX4InRdOHgPI8Qv1Xpb1siv9q+p9xCyXNtD4QLwoRT?=
 =?us-ascii?q?iv6bpgRQT2gykbKTE27GDXitRxjK1FphKhuwd/yJPQbI2MKfZyYr/RcdYcSG?=
 =?us-ascii?q?VPRMZRUzFKDJ26YYUBEuENOf9Uoof5qlcLqxa1GAuiC/71yjJQm3H4w6M63e?=
 =?us-ascii?q?QiHw/I0gMvENABv2jbotjuKKcfU/q4wLXUwTjNbf5b3yr25ojSchAmpPGBRb?=
 =?us-ascii?q?BwcMTNxkY1DQPFkkucopHiMjOX2OUCr3KU7/B8Ve6xkGMntwFwrSSvxscrkI?=
 =?us-ascii?q?XJgJkVxUre+SV2x4Y1O8S1RUhmatCqF5tQsjuVN4pwQs46WGFnpDw1yrsctZ?=
 =?us-ascii?q?6/ZycHzoksyR3Ha/GfboSF7R3uWPyRLDtlnn5pZr2yiwio/US9zOD3S9O630?=
 =?us-ascii?q?xQriVfl9nBrnUN1xvO5ceZUvZ95UKh2SqX1wDU9+FEPVg4larFJJ4lxb49jo?=
 =?us-ascii?q?YTvl7ZHi/3hUX2l7Wadlkk++e06+TnZa/qppmAOI9vlg7yKKEums27AeggMw?=
 =?us-ascii?q?gOWXaU+fik2bH+8kD0T69Gg/0rnqXDrpzXKtoXqrSkDwNN14Ys8Re/DzOo0N?=
 =?us-ascii?q?QCmnkHKUpIeBCJjof1IV7OOuz4AemkjlSwkDZk2/DGPrr7DpXLNXjMiq3tfb?=
 =?us-ascii?q?l6605C0AYz18xQ54pICrEdJ/L+Qk3xtNvDDh85Lgy72fzrB85n1oMfX2KAH6?=
 =?us-ascii?q?uZP73JvFCU/OIvPu+Ma5MVuDf9Nvcq/eLugmUjlVABeqmp2IMdaGqkEfR+P0?=
 =?us-ascii?q?WZfX3sj88aEWgUugo+TerqiECNUDNIeXayULwz5ishBIKlE4jDXIatj6KF3C?=
 =?us-ascii?q?uhGZ1WfG9GWRiwFiLKcJ6ERv5EQjiTJMNln3RQV7+6S5Iokxu0tQn2z7dPJf?=
 =?us-ascii?q?DJ/CYYpJ7qyNEz7OrWw1V67jFwDsKAw0mTQGxu2GAFXTk72OZ4u0Mu5E2E1P?=
 =?us-ascii?q?16nPdRD8AJr6dLTQwzL4KG5/BrAND1HATad5GGT0jwEYbuOi04Ut9km4xGWE?=
 =?us-ascii?q?16Adj3y0mYjic=3D?=
X-IPAS-Result: =?us-ascii?q?A2CxAACUTnFd/wHyM5BlHAEBAQQBAQcEAQGBVQUBAQsBA?=
 =?us-ascii?q?YFsKm1TMiqEIY8MgWolfpgcgXsJAQEBAQEBAQEBKwkBAgEBghKCLQKCNiM2B?=
 =?us-ascii?q?w4CDAEBAQQBAQEBAQYDAQFshTpCARABgWYpAYJmAQEBAQIBIwQRRgsLCQ8CA?=
 =?us-ascii?q?iYCAlcGAQwGAgEBgl8/AYF7Dw+qZX8zhUuDPIFJgQwoAYt3gVdAgREnDIIqN?=
 =?us-ascii?q?T6HT4JYBIEvAYsgBIkBlW1uBoIjhneNawYbmHYtjU2aXgwlgVgrCkGBaIFOC?=
 =?us-ascii?q?YJFF44hHSQDMIEGAQGESIoAAQE?=
Received: from tarius.tycho.ncsc.mil ([144.51.242.1])
  by EMSM-GH1-UEA10.NCSC.MIL with ESMTP; 05 Sep 2019 18:08:04 +0000
Received: from moss-lions.infosec.tycho.ncsc.mil (moss-lions [192.168.25.4])
        by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id x85I83DT003023;
        Thu, 5 Sep 2019 14:08:03 -0400
Subject: Re: [Non-DoD Source] [PATCH v3] Add default_range glblub support
To:     Joshua Brindle <joshua.brindle@crunchydata.com>,
        selinux@vger.kernel.org
References: <20190904210214.1454-1-joshua.brindle@crunchydata.com>
From:   jwcart2 <jwcart2@tycho.nsa.gov>
Message-ID: <3aebdd9a-3617-ee0b-24fe-5b4567a2f405@tycho.nsa.gov>
Date:   Thu, 5 Sep 2019 14:09:56 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190904210214.1454-1-joshua.brindle@crunchydata.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 9/4/19 5:02 PM, Joshua Brindle wrote:
> Policy developers can set a default_range default to glblub and
> computed contexts will be the intersection of the ranges of the
> source and target contexts. This can be used by MLS userspace
> object managers to find the range of clearances that two contexts
> have in common. An example usage is computing a transition between
> the network context and the context of a user logging into an MLS
> application.
> 
> For example, one can add a default with
> this cil:
> 
> (defaultrange db_table glblub);
> 
No ";" at the end for cil.

> or in te (base module only):
> 
> default_range db_table glblub;
> 
> and then test using the compute_create utility:
> 
> $ ./compute_create system_u:system_r:kernel_t:s0:c1,c2,c5-s0:c1.c20 system_u:system_r:kernel_t:s0:c0.c20-s0:c0.c36 db_table
> system_u:object_r:kernel_t:s0:c1,c2,c5-s0:c1.c20
> 
> Some example range transitions are:
> 
> User Permitted Range | Network Device Label | Computed Label
> ---------------------|----------------------|----------------
> s0-s1:c0.c12         | s0                   | s0
> s0-s1:c0.c12         | s0-s1:c0.c1023       | s0-s1:c0.c12
> s0-s4:c0.c512        | s1-s1:c0.c1023       | s1-s1:c0.c512
> s0-s15:c0,c2         | s4-s6:c0.c128        | s4-s6:c0,c2
> s0-s4                | s2-s6                | s2-s4
> s0-s4                | s5-s8                | INVALID
> s5-s8                | s0-s4                | INVALID
> 
> Signed-off-by: Joshua Brindle <joshua.brindle@crunchydata.com>
> ---
>   checkpolicy/policy_parse.y                   |  4 +++-
>   checkpolicy/policy_scan.l                    |  2 ++
>   libsepol/cil/src/cil.c                       |  1 +
>   libsepol/cil/src/cil_build_ast.c             | 11 +++++----
>   libsepol/cil/src/cil_internal.h              |  2 ++
>   libsepol/cil/src/cil_policy.c                |  3 +++
>   libsepol/include/sepol/policydb/context.h    |  5 ++++
>   libsepol/include/sepol/policydb/mls_types.h  | 25 ++++++++++++++++++++
>   libsepol/include/sepol/policydb/policydb.h   |  7 ++++--
>   libsepol/src/kernel_to_cil.c                 |  3 +++
>   libsepol/src/kernel_to_conf.c                |  3 +++
>   libsepol/src/mls.c                           |  2 ++
>   libsepol/src/module_to_cil.c                 |  1 +
>   libsepol/src/policydb.c                      | 22 +++++++++++++++++
>   libsepol/src/write.c                         | 12 ++++++++++
>   secilc/docs/cil_default_object_statements.md | 12 ++++++----
>   16 files changed, 104 insertions(+), 11 deletions(-)
> 
> diff --git a/checkpolicy/policy_parse.y b/checkpolicy/policy_parse.y
> index 247bd4ee..abb7d885 100644
> --- a/checkpolicy/policy_parse.y
> +++ b/checkpolicy/policy_parse.y
> @@ -155,7 +155,7 @@ typedef int (* require_func_t)(int pass);
>   %token PERMISSIVE
>   %token FILESYSTEM
>   %token DEFAULT_USER DEFAULT_ROLE DEFAULT_TYPE DEFAULT_RANGE
> -%token LOW_HIGH LOW HIGH
> +%token LOW_HIGH LOW HIGH GLBLUB
>   
>   %left OR
>   %left XOR
> @@ -247,6 +247,8 @@ default_range_def	: DEFAULT_RANGE names SOURCE LOW ';'
>   			{if (define_default_range(DEFAULT_TARGET_HIGH)) return -1; }
>   			| DEFAULT_RANGE names TARGET LOW_HIGH ';'
>   			{if (define_default_range(DEFAULT_TARGET_LOW_HIGH)) return -1; }
> +			| DEFAULT_RANGE names GLBLUB';'
> +			{if (define_default_range(DEFAULT_GLBLUB)) return -1; }
>   			;
>   opt_mls			: mls
>                           |
> diff --git a/checkpolicy/policy_scan.l b/checkpolicy/policy_scan.l
> index e93ccb64..e2f676e4 100644
> --- a/checkpolicy/policy_scan.l
> +++ b/checkpolicy/policy_scan.l
> @@ -256,6 +256,8 @@ high |
>   HIGH				{ return(HIGH); }
>   low |
>   LOW				{ return(LOW); }
> +glblub |
> +GLBLUB				{ return(GLBLUB); }
>   "/"[^ \n\r\t\f]*	        { return(PATH); }
>   \""/"[^\"\n]*\" 		{ return(QPATH); }
>   \"[^"/"\"\n]+\"	{ return(FILENAME); }
> diff --git a/libsepol/cil/src/cil.c b/libsepol/cil/src/cil.c
> index 2a7ec063..de729cf8 100644
> --- a/libsepol/cil/src/cil.c
> +++ b/libsepol/cil/src/cil.c
> @@ -227,6 +227,7 @@ static void cil_init_keys(void)
>   	CIL_KEY_LOW = cil_strpool_add("low");
>   	CIL_KEY_HIGH = cil_strpool_add("high");
>   	CIL_KEY_LOW_HIGH = cil_strpool_add("low-high");
> +	CIL_KEY_GLBLUB = cil_strpool_add("glblub");
>   	CIL_KEY_ROOT = cil_strpool_add("<root>");
>   	CIL_KEY_NODE = cil_strpool_add("<node>");
>   	CIL_KEY_PERM = cil_strpool_add("perm");
> diff --git a/libsepol/cil/src/cil_build_ast.c b/libsepol/cil/src/cil_build_ast.c
> index b90b0f60..ee1c51ce 100644
> --- a/libsepol/cil/src/cil_build_ast.c
> +++ b/libsepol/cil/src/cil_build_ast.c
> @@ -5894,7 +5894,7 @@ int cil_gen_defaultrange(struct cil_tree_node *parse_current, struct cil_tree_no
>   		CIL_SYN_STRING,
>   		CIL_SYN_STRING | CIL_SYN_LIST,
>   		CIL_SYN_STRING,
> -		CIL_SYN_STRING,
> +		CIL_SYN_STRING | CIL_SYN_END,
>   		CIL_SYN_END
>   	};
>   	int syntax_len = sizeof(syntax)/sizeof(*syntax);
> @@ -5917,8 +5917,8 @@ int cil_gen_defaultrange(struct cil_tree_node *parse_current, struct cil_tree_no
>   	}
>   
>   	object = parse_current->next->next->data;
> -	range = parse_current->next->next->next->data;
>   	if (object == CIL_KEY_SOURCE) {
> +		range = parse_current->next->next->next->data;
>   		if (range == CIL_KEY_LOW) {
>   			def->object_range = CIL_DEFAULT_SOURCE_LOW;
>   		} else if (range == CIL_KEY_HIGH) {
> @@ -5930,7 +5930,8 @@ int cil_gen_defaultrange(struct cil_tree_node *parse_current, struct cil_tree_no
>   			rc = SEPOL_ERR;
>   			goto exit;
>   		}
> -	} else if (parse_current->next->next->data == CIL_KEY_TARGET) {
> +	} else if (object == CIL_KEY_TARGET) {
> +		range = parse_current->next->next->next->data;
>   		if (range == CIL_KEY_LOW) {
>   			def->object_range = CIL_DEFAULT_TARGET_LOW;
>   		} else if (range == CIL_KEY_HIGH) {
> @@ -5942,8 +5943,10 @@ int cil_gen_defaultrange(struct cil_tree_node *parse_current, struct cil_tree_no
>   			rc = SEPOL_ERR;
>   			goto exit;
>   		}
> +	} else if (object == CIL_KEY_GLBLUB) {
> +		def->object_range = CIL_DEFAULT_GLBLUB;
>   	} else {
> -		cil_log(CIL_ERR,"Expected either \'source\' or \'target\'\n");
> +		cil_log(CIL_ERR,"Expected \'source\', \'target\', or \'glblub\'\n");
>   		rc = SEPOL_ERR;
>   		goto exit;
>   	}
> diff --git a/libsepol/cil/src/cil_internal.h b/libsepol/cil/src/cil_internal.h
> index 6ff32285..30fab649 100644
> --- a/libsepol/cil/src/cil_internal.h
> +++ b/libsepol/cil/src/cil_internal.h
> @@ -149,6 +149,7 @@ char *CIL_KEY_TARGET;
>   char *CIL_KEY_LOW;
>   char *CIL_KEY_HIGH;
>   char *CIL_KEY_LOW_HIGH;
> +char *CIL_KEY_GLBLUB;
>   char *CIL_KEY_HANDLEUNKNOWN;
>   char *CIL_KEY_HANDLEUNKNOWN_ALLOW;
>   char *CIL_KEY_HANDLEUNKNOWN_DENY;
> @@ -941,6 +942,7 @@ enum cil_default_object_range {
>   	CIL_DEFAULT_TARGET_LOW      = DEFAULT_TARGET_LOW,
>   	CIL_DEFAULT_TARGET_HIGH     = DEFAULT_TARGET_HIGH,
>   	CIL_DEFAULT_TARGET_LOW_HIGH = DEFAULT_TARGET_LOW_HIGH,
> +	CIL_DEFAULT_GLBLUB          = DEFAULT_GLBLUB,
>   };
>   
>   /* Default labeling behavior for range */
> diff --git a/libsepol/cil/src/cil_policy.c b/libsepol/cil/src/cil_policy.c
> index 1adf22a3..06d7d74e 100644
> --- a/libsepol/cil/src/cil_policy.c
> +++ b/libsepol/cil/src/cil_policy.c
> @@ -834,6 +834,9 @@ static void cil_default_ranges_to_policy(FILE *out, struct cil_list *defaults)
>   		case CIL_DEFAULT_TARGET_LOW_HIGH:
>   			fprintf(out," %s %s", CIL_KEY_TARGET, CIL_KEY_LOW_HIGH);
>   			break;
> +		case CIL_DEFAULT_GLBLUB:
> +			fprintf(out," %s", CIL_KEY_GLBLUB);
> +			break;
>   		default:
>   			break;
>   		}
> diff --git a/libsepol/include/sepol/policydb/context.h b/libsepol/include/sepol/policydb/context.h
> index c27c3341..37cdc591 100644
> --- a/libsepol/include/sepol/policydb/context.h
> +++ b/libsepol/include/sepol/policydb/context.h
> @@ -92,6 +92,11 @@ out:
>   	return rc;
>   }
>   
> +static inline int mls_context_glblub(context_struct_t *dst, context_struct_t *c1, context_struct_t *c2)
> +{
> +	return mls_range_glblub(&dst->range, &c1->range, &c2->range);
> +}
> +
>   static inline int mls_context_cmp(context_struct_t * c1, context_struct_t * c2)
>   {
>   	return (mls_level_eq(&c1->range.level[0], &c2->range.level[0]) &&
> diff --git a/libsepol/include/sepol/policydb/mls_types.h b/libsepol/include/sepol/policydb/mls_types.h
> index a06723be..5e82f1a5 100644
> --- a/libsepol/include/sepol/policydb/mls_types.h
> +++ b/libsepol/include/sepol/policydb/mls_types.h
> @@ -32,6 +32,7 @@
>   
>   #include <stdint.h>
>   #include <stdlib.h>
> +#include <sys/param.h>
>   #include <sepol/policydb/ebitmap.h>
>   #include <sepol/policydb/flask_types.h>
>   
> @@ -48,6 +49,30 @@ typedef struct mls_range {
>   	mls_level_t level[2];	/* low == level[0], high == level[1] */
>   } mls_range_t;
>   
> +static inline int mls_range_glblub(struct mls_range *dst, struct mls_range *r1, struct mls_range *r2)
> +{
> +	if (r1->level[1].sens < r2->level[0].sens || r2->level[1].sens < r1->level[0].sens) {
> +		/* These ranges have no common sensitivities */
> +		return -EINVAL;
> +	}
> +

Need to include <errno.h>

Everything else looks good. I did test the v2 patch set and everything seems to 
work.

Jim

> +	/* Take the greatest of the low */
> +	dst->level[0].sens = MAX(r1->level[0].sens, r2->level[0].sens);
> +	/* Take the least of the high */
> +	dst->level[1].sens = MIN(r1->level[1].sens, r2->level[1].sens);
> +
> +	if (ebitmap_and(&dst->level[0].cat, &r1->level[0].cat, &r2->level[0].cat) < 0) {
> +		return -1;
> +	}
> +
> +	if (ebitmap_and(&dst->level[1].cat, &r1->level[1].cat, &r2->level[1].cat) < 0) {
> +		return -1;
> +	}
> +
> +	return 0;
> +}
> +
> +
>   static inline int mls_level_cpy(struct mls_level *dst, struct mls_level *src)
>   {
>   
> diff --git a/libsepol/include/sepol/policydb/policydb.h b/libsepol/include/sepol/policydb/policydb.h
> index a279382e..b0d2fdfc 100644
> --- a/libsepol/include/sepol/policydb/policydb.h
> +++ b/libsepol/include/sepol/policydb/policydb.h
> @@ -130,6 +130,7 @@ typedef struct class_datum {
>   #define DEFAULT_TARGET_LOW	4
>   #define DEFAULT_TARGET_HIGH	5
>   #define DEFAULT_TARGET_LOW_HIGH	6
> +#define DEFAULT_GLBLUB 		7
>   	char default_range;
>   } class_datum_t;
>   
> @@ -741,10 +742,11 @@ extern int policydb_set_target_platform(policydb_t *p, int platform);
>   #define POLICYDB_VERSION_XEN_DEVICETREE		30 /* Xen-specific */
>   #define POLICYDB_VERSION_XPERMS_IOCTL	30 /* Linux-specific */
>   #define POLICYDB_VERSION_INFINIBAND		31 /* Linux-specific */
> +#define POLICYDB_VERSION_GLBLUB		32
>   
>   /* Range of policy versions we understand*/
>   #define POLICYDB_VERSION_MIN	POLICYDB_VERSION_BASE
> -#define POLICYDB_VERSION_MAX	POLICYDB_VERSION_INFINIBAND
> +#define POLICYDB_VERSION_MAX	POLICYDB_VERSION_GLBLUB
>   
>   /* Module versions and specific changes*/
>   #define MOD_POLICYDB_VERSION_BASE		4
> @@ -765,9 +767,10 @@ extern int policydb_set_target_platform(policydb_t *p, int platform);
>   #define MOD_POLICYDB_VERSION_CONSTRAINT_NAMES  17
>   #define MOD_POLICYDB_VERSION_XPERMS_IOCTL  18
>   #define MOD_POLICYDB_VERSION_INFINIBAND		19
> +#define MOD_POLICYDB_VERSION_GLBLUB		20
>   
>   #define MOD_POLICYDB_VERSION_MIN MOD_POLICYDB_VERSION_BASE
> -#define MOD_POLICYDB_VERSION_MAX MOD_POLICYDB_VERSION_INFINIBAND
> +#define MOD_POLICYDB_VERSION_MAX MOD_POLICYDB_VERSION_GLBLUB
>   
>   #define POLICYDB_CONFIG_MLS    1
>   
> diff --git a/libsepol/src/kernel_to_cil.c b/libsepol/src/kernel_to_cil.c
> index 320af37b..01f5bc5b 100644
> --- a/libsepol/src/kernel_to_cil.c
> +++ b/libsepol/src/kernel_to_cil.c
> @@ -698,6 +698,9 @@ static int write_default_range_to_cil(FILE *out, char *class_name, class_datum_t
>   	case DEFAULT_TARGET_LOW_HIGH:
>   		dft = "target low-high";
>   		break;
> +	case DEFAULT_GLBLUB:
> +		dft = "glblub";
> +		break;
>   	default:
>   		sepol_log_err("Unknown default type value: %i", class->default_range);
>   		return -1;
> diff --git a/libsepol/src/kernel_to_conf.c b/libsepol/src/kernel_to_conf.c
> index 930bafab..a44ba30a 100644
> --- a/libsepol/src/kernel_to_conf.c
> +++ b/libsepol/src/kernel_to_conf.c
> @@ -673,6 +673,9 @@ static int write_default_range_to_conf(FILE *out, char *class_name, class_datum_
>   	case DEFAULT_TARGET_LOW_HIGH:
>   		dft = "target low-high";
>   		break;
> +	case DEFAULT_GLBLUB:
> +		dft = "glblub";
> +		break;
>   	default:
>   		sepol_log_err("Unknown default type value: %i", class->default_range);
>   		return -1;
> diff --git a/libsepol/src/mls.c b/libsepol/src/mls.c
> index 63ad1bcb..6ff9a846 100644
> --- a/libsepol/src/mls.c
> +++ b/libsepol/src/mls.c
> @@ -643,6 +643,8 @@ int mls_compute_sid(policydb_t * policydb,
>   			return mls_context_cpy_high(newcontext, tcontext);
>   		case DEFAULT_TARGET_LOW_HIGH:
>   			return mls_context_cpy(newcontext, tcontext);
> +		case DEFAULT_GLBLUB:
> +			return mls_context_glblub(newcontext, scontext, tcontext);
>   		}
>   
>   		/* Fallthrough */
> diff --git a/libsepol/src/module_to_cil.c b/libsepol/src/module_to_cil.c
> index 1af166c9..c48a897d 100644
> --- a/libsepol/src/module_to_cil.c
> +++ b/libsepol/src/module_to_cil.c
> @@ -2033,6 +2033,7 @@ static int class_to_cil(int indent, struct policydb *pdb, struct avrule_block *U
>   		case DEFAULT_TARGET_LOW:		dflt = "target low";	break;
>   		case DEFAULT_TARGET_HIGH:		dflt = "target high";	break;
>   		case DEFAULT_TARGET_LOW_HIGH:	dflt = "target low-high";	break;
> +		case DEFAULT_GLBLUB:		dflt = "glblub";		break;
>   		default:
>   			log_err("Unknown default range value: %i", class->default_range);
>   			rc = -1;
> diff --git a/libsepol/src/policydb.c b/libsepol/src/policydb.c
> index 69bcb4d5..67037b6d 100644
> --- a/libsepol/src/policydb.c
> +++ b/libsepol/src/policydb.c
> @@ -194,6 +194,13 @@ static struct policydb_compat_info policydb_compat[] = {
>   	 .ocon_num = OCON_IBENDPORT + 1,
>   	 .target_platform = SEPOL_TARGET_SELINUX,
>   	},
> +	{
> +	 .type = POLICY_KERN,
> +	 .version = POLICYDB_VERSION_GLBLUB,
> +	 .sym_num = SYM_NUM,
> +	 .ocon_num = OCON_IBENDPORT + 1,
> +	 .target_platform = SEPOL_TARGET_SELINUX,
> +	},
>   	{
>   	 .type = POLICY_BASE,
>   	 .version = MOD_POLICYDB_VERSION_BASE,
> @@ -306,6 +313,13 @@ static struct policydb_compat_info policydb_compat[] = {
>   	 .ocon_num = OCON_IBENDPORT + 1,
>   	 .target_platform = SEPOL_TARGET_SELINUX,
>   	},
> +	{
> +	 .type = POLICY_BASE,
> +	 .version = MOD_POLICYDB_VERSION_GLBLUB,
> +	 .sym_num = SYM_NUM,
> +	 .ocon_num = OCON_IBENDPORT + 1,
> +	 .target_platform = SEPOL_TARGET_SELINUX,
> +	},
>   	{
>   	 .type = POLICY_MOD,
>   	 .version = MOD_POLICYDB_VERSION_BASE,
> @@ -418,6 +432,14 @@ static struct policydb_compat_info policydb_compat[] = {
>   	 .ocon_num = 0,
>   	 .target_platform = SEPOL_TARGET_SELINUX,
>   	},
> +	{
> +	 .type = POLICY_MOD,
> +	 .version = MOD_POLICYDB_VERSION_GLBLUB,
> +	 .sym_num = SYM_NUM,
> +	 .ocon_num = 0,
> +	 .target_platform = SEPOL_TARGET_SELINUX,
> +	},
> +
>   };
>   
>   #if 0
> diff --git a/libsepol/src/write.c b/libsepol/src/write.c
> index dee7b4a3..c6be2be2 100644
> --- a/libsepol/src/write.c
> +++ b/libsepol/src/write.c
> @@ -46,6 +46,11 @@
>   #include "private.h"
>   #include "mls.h"
>   
> +#define glblub_version ((p->policy_type == POLICY_KERN && \
> +		     p->policyvers >= POLICYDB_VERSION_GLBLUB) || \
> +		    (p->policy_type == POLICY_BASE && \
> +		     p->policyvers >= MOD_POLICYDB_VERSION_GLBLUB))
> +
>   struct policy_data {
>   	struct policy_file *fp;
>   	struct policydb *p;
> @@ -1034,6 +1039,13 @@ static int class_write(hashtab_key_t key, hashtab_datum_t datum, void *ptr)
>   	     p->policyvers >= MOD_POLICYDB_VERSION_NEW_OBJECT_DEFAULTS)) {
>   		buf[0] = cpu_to_le32(cladatum->default_user);
>   		buf[1] = cpu_to_le32(cladatum->default_role);
> +		if (!glblub_version && cladatum->default_range == DEFAULT_GLBLUB) {
> +			WARN(fp->handle,
> +                             "class %s default_range set to GLBLUB but policy version is %d (%d required), discarding",
> +                             p->p_class_val_to_name[cladatum->s.value - 1], p->policyvers,
> +                             p->policy_type == POLICY_KERN? POLICYDB_VERSION_GLBLUB:MOD_POLICYDB_VERSION_GLBLUB);
> +                        cladatum->default_range = 0;
> +                }
>   		buf[2] = cpu_to_le32(cladatum->default_range);
>   		items = put_entry(buf, sizeof(uint32_t), 3, fp);
>   		if (items != 3)
> diff --git a/secilc/docs/cil_default_object_statements.md b/secilc/docs/cil_default_object_statements.md
> index 73d84d6d..80ccabe7 100644
> --- a/secilc/docs/cil_default_object_statements.md
> +++ b/secilc/docs/cil_default_object_statements.md
> @@ -143,11 +143,11 @@ When creating a new `socket` object, the [`type`](cil_type_statements.md#type) c
>   defaultrange
>   ------------
>   
> -Allows the default level or range to be taken from the source or target context when computing a new context for the object [`class`](cil_class_and_permission_statements.md#class) identifier. Requires policy version 27.
> +Allows the default level or range to be taken from the source, target, or both contexts when computing a new context for the object [`class`](cil_class_and_permission_statements.md#class) identifier. Requires policy version 27. glblub as the default requires policy version 32.
>   
>   **Statement definition:**
>   
> -    (defaultrange class_id default range)
> +    (defaultrange class_id default <range>)
>   
>   **Where:**
>   
> @@ -167,11 +167,11 @@ Allows the default level or range to be taken from the source or target context
>   </tr>
>   <tr class="odd">
>   <td align="left"><p><code>default</code></p></td>
> -<td align="left"><p>A keyword of either <code>source</code> or <code>target</code>.</p></td>
> +<td align="left"><p>A keyword of either <code>source</code>, <code>target</code>, or <code>glblub</code>.</p></td>
>   </tr>
>   <tr class="even">
>   <td align="left"><p><code>range</code></p></td>
> -<td align="left"><p>A keyword of either <code>low</code>, <code>high</code> or <code>low-high</code>.</p></td>
> +<td align="left"><p>A keyword of either <code>low</code>, <code>high</code>, or <code>low-high</code>.</p></td>
>   </tr>
>   </tbody>
>   </table>
> @@ -181,3 +181,7 @@ Allows the default level or range to be taken from the source or target context
>   When creating a new `file` object, the appropriate `range` component of the new security context will be taken from the `target` context:
>   
>       (defaultrange file target low_high)
> +
> +MLS userspace object managers may need to compute the common parts of a range such that the object is created with the range common to the subject and containing object:
> +
> +    (defaultrange db_table glblub)
> 


-- 
James Carter <jwcart2@tycho.nsa.gov>
National Security Agency
