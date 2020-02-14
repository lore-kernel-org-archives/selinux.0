Return-Path: <SRS0=qygk=4C=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C86FC3B1A6
	for <selinux@archiver.kernel.org>; Fri, 14 Feb 2020 17:38:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6DEAE2187F
	for <selinux@archiver.kernel.org>; Fri, 14 Feb 2020 17:38:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="owirVQyb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390075AbgBNRh7 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 14 Feb 2020 12:37:59 -0500
Received: from USFB19PA33.eemsg.mail.mil ([214.24.26.196]:40201 "EHLO
        USFB19PA33.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387566AbgBNRh6 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 14 Feb 2020 12:37:58 -0500
X-EEMSG-check-017: 56190395|USFB19PA33_ESA_OUT03.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.70,441,1574121600"; 
   d="scan'208";a="56190395"
Received: from emsm-gh1-uea10.ncsc.mil ([214.29.60.2])
  by USFB19PA33.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 14 Feb 2020 17:37:45 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1581701866; x=1613237866;
  h=subject:to:references:from:message-id:date:mime-version:
   in-reply-to:content-transfer-encoding;
  bh=S919K1rLRq+cDGAmlvMS0P3NsOjXPe7efRX4FBizyuY=;
  b=owirVQybpgqphvt++r9yI8j5z1Irt/agDx8W65WSmv3l2Fkc2xglHRk3
   G2kXTnwFMQJ0+gNSqD5fKOwSQioK2OAsTxgvCnylTyRYv8HNDl9CyJmiG
   1aFhbB4ziQkmvA8wXucaxfvgI1zcyz9g8XRFhbUNV2kBx0tItD5130xMD
   AQCJn1mFoNfiDlXs3y0zIPAw8dgB2JA4yUQsl++D39ThMRAeF8+lb27uT
   yVx5AW0eqewvUu31G9ut3yF+7me8Nb8FZTDmolFOrJ637XnNAKXl59TDV
   3oWLR1tiZRzw0Df22Jmndd3V8v5drtlyHBUK8/GNZYcVuQwqxyk5woFqn
   A==;
X-IronPort-AV: E=Sophos;i="5.70,441,1574121600"; 
   d="scan'208";a="33086506"
IronPort-PHdr: =?us-ascii?q?9a23=3AVvddyxHajAQAdNpbq9Mgk51GYnF86YWxBRYc79?=
 =?us-ascii?q?8ds5kLTJ7yos6wAkXT6L1XgUPTWs2DsrQY0raQ7PirADRbqb+681k8M7V0Hy?=
 =?us-ascii?q?cfjssXmwFySOWkMmbcaMDQUiohAc5ZX0Vk9XzoeWJcGcL5ekGA6ibqtW1aFR?=
 =?us-ascii?q?rwLxd6KfroEYDOkcu3y/qy+5rOaAlUmTaxe7x/IAi5oAnLtMQanYRuJrstxh?=
 =?us-ascii?q?bHv3BFZ/lYyWR0KF2cmBrx+t2+94N5/SRKvPIh+c9AUaHkcKk9ULdVEjcoPX?=
 =?us-ascii?q?0r6cPyrRXMQheB6XUaUmUNjxpHGBPF4w3gXpfwqST1qOxw0zSHMMLsTLA0XT?=
 =?us-ascii?q?Oi77p3SBLtlSwKOSI1/H3Rh8dtl69Qvg6vqAJjzI7VeIGVNeRxfqXBfdMBWG?=
 =?us-ascii?q?FNWt9dWzFdDo+gaocCCeQOPfxcr4LguVUAqxWwDhSoCO/2xDJFgnr60Ksn2O?=
 =?us-ascii?q?ojDA7GxhQtEc8QvnTarNv7N6kcXu66w6bK0TrNYOhb2Sv/5YXSbhwtvf+BUL?=
 =?us-ascii?q?B2fMHMyUcvDQTFjlCIpIL4IzOayPwNs2iF4OpmSOmhlmsnpBt1ojir2Mgtip?=
 =?us-ascii?q?TCi4UOyl/Z7iV025o1JN2kR057Zt6oCp1QtzqAOIdsTcMiRH9otT88x7Ybup?=
 =?us-ascii?q?C7ZDAHxIkoyhPQcfCKc5WE7gj9WOuePzt0nm9pdbSijBio60eg0PfzVsys3V?=
 =?us-ascii?q?ZPqSpKj8fDu2gW1xzW9siHUvx9/lq92TqX1wDc9OVEIUcsmKrHMZEh2L8wlo?=
 =?us-ascii?q?cIsUjZHy/2nkv2jKiNdko65uek8fjnY7X6qZ+cMI94kAf+Pbg1msOjG+g4Nw?=
 =?us-ascii?q?kOX2yD9eS90r3s41H5Ta1XgvA5naTVqpDXKdkBqqKnDAJZzJwv5wunAzejyt?=
 =?us-ascii?q?sYnH0HLFxfeBKAiojkI0rOL+3jDfqkn1StkCtkx/DBPrH7BJXNNWLMnK3ufb?=
 =?us-ascii?q?Z69U5Q0BAzwsxH55JIFrEBJ+r+Wkj0tNzfFR85NRa7zPr5B9hmzIMRR3+AAq?=
 =?us-ascii?q?+DP6POq1OH+uUvI+yUbo8PpDn9M+Ql5+LpjXIhgl8SY62p3ZoRaHClEfVrOF?=
 =?us-ascii?q?uZYXXyjdcbC2sKvRQxTPbsiFKcVT5ffXGyX7gz5mJzNIXzKoHPXI2vyJmGxy?=
 =?us-ascii?q?GyFZBVLjRBD1eXF37jeq2eVvsMYT7UKchkxHhMTrWlSok8xTmwuwLgjblqNO?=
 =?us-ascii?q?zZ/msfr52nnPp84uDI3To77yB5FYzJ0X6GRntoxEsUVjQ22+Z5ukU7xVCdh/?=
 =?us-ascii?q?tWmftdQOdP6utJXwFyDpvVy+h3GpimQQ7aVsuYQ1ahBNO9CHc+ScxnkIxGWF?=
 =?us-ascii?q?p0B9j31kOL5CGtGbJA0uXQVZE=3D?=
X-IPAS-Result: =?us-ascii?q?A2BzAgBl2kZe/wHyM5BmHAEBAQEBBwEBEQEEBAEBgXuBf?=
 =?us-ascii?q?YFtIBIqhBSJA4ZZAQEEBoESJYlwkUoJAQEBAQEBAQEBNwQBAYRAAoIlOBMCE?=
 =?us-ascii?q?AEBAQUBAQEBAQUDAQFshUOCOykBgwIBBSMEEVELDgoCAiYCAlcGAQwGAgEBg?=
 =?us-ascii?q?mM/glclri1/M4VKg06BPoEOKow+eYEHgTgMA4JdPodbgl4El0dGl22CRIJPk?=
 =?us-ascii?q?3wGHJsYjmidPyKBWCsIAhgIIQ+DJ1AYDY4pF45BIwMwkFgBAQ?=
Received: from tarius.tycho.ncsc.mil (HELO tarius.infosec.tycho.ncsc.mil) ([144.51.242.1])
  by EMSM-GH1-UEA10.NCSC.MIL with ESMTP; 14 Feb 2020 17:37:42 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.infosec.tycho.ncsc.mil (8.14.7/8.14.4) with ESMTP id 01EHai1P214335;
        Fri, 14 Feb 2020 12:36:44 -0500
Subject: Re: [PATCH userspace v2] libsepol: cache ebitmap cardinality value
To:     Ondrej Mosnacek <omosnace@redhat.com>, selinux@vger.kernel.org,
        James Carter <jwcart2@tycho.nsa.gov>
References: <20200213133959.14217-1-omosnace@redhat.com>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <1a11d058-eee1-41c5-9686-da01ecf6ea33@tycho.nsa.gov>
Date:   Fri, 14 Feb 2020 12:38:52 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200213133959.14217-1-omosnace@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 2/13/20 8:39 AM, Ondrej Mosnacek wrote:
> According to profiling of semodule -BN, ebitmap_cardinality() is called
> quite often and contributes a lot to the total runtime. Cache its result
> in the ebitmap struct to reduce this overhead. The cached value is
> invalidated on most modifying operations, but ebitmap_cardinality() is
> usually called once the ebitmap doesn't change any more.
> 
> After this patch, the time to do 'semodule -BN' on Fedora Rawhide has
> decreased from ~14.6s to ~12.4s (2.2s saved).
> 
> Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>

This seems fine but I was wondering how many of the callers of 
ebitmap_cardinality() actually need anything more than ebitmap_length()?

> ---
> 
> v2: corrected time values in commit message
> 
>   libsepol/include/sepol/policydb/ebitmap.h |  1 +
>   libsepol/src/ebitmap.c                    | 10 ++++++++++
>   2 files changed, 11 insertions(+)
> 
> diff --git a/libsepol/include/sepol/policydb/ebitmap.h b/libsepol/include/sepol/policydb/ebitmap.h
> index e62df01c..53fafdaa 100644
> --- a/libsepol/include/sepol/policydb/ebitmap.h
> +++ b/libsepol/include/sepol/policydb/ebitmap.h
> @@ -37,6 +37,7 @@ typedef struct ebitmap_node {
>   typedef struct ebitmap {
>   	ebitmap_node_t *node;	/* first node in the bitmap */
>   	uint32_t highbit;	/* highest position in the total bitmap */
> +	unsigned int cardinality;	/* cached value of cardinality */
>   } ebitmap_t;
>   
>   #define ebitmap_length(e) ((e)->highbit)
> diff --git a/libsepol/src/ebitmap.c b/libsepol/src/ebitmap.c
> index 6c9951b7..d23444ce 100644
> --- a/libsepol/src/ebitmap.c
> +++ b/libsepol/src/ebitmap.c
> @@ -67,6 +67,7 @@ int ebitmap_union(ebitmap_t * dst, const ebitmap_t * e1)
>   	ebitmap_destroy(dst);
>   	dst->node = tmp.node;
>   	dst->highbit = tmp.highbit;
> +	dst->cardinality = 0;
>   
>   	return 0;
>   }
> @@ -128,9 +129,14 @@ int ebitmap_andnot(ebitmap_t *dst, ebitmap_t *e1, ebitmap_t *e2, unsigned int ma
>   unsigned int ebitmap_cardinality(ebitmap_t *e1)
>   {
>   	unsigned int i, count = 0;
> +
> +	if (e1->cardinality || e1->highbit == 0)
> +		return e1->cardinality;
> +
>   	for (i=ebitmap_startbit(e1); i < ebitmap_length(e1); i++)
>   		if (ebitmap_get_bit(e1, i))
>   			count++;
> +	e1->cardinality = count;
>   	return count;
>   }
>   
> @@ -194,6 +200,7 @@ int ebitmap_cpy(ebitmap_t * dst, const ebitmap_t * src)
>   	}
>   
>   	dst->highbit = src->highbit;
> +	dst->cardinality = src->cardinality;
>   	return 0;
>   }
>   
> @@ -309,6 +316,7 @@ int ebitmap_set_bit(ebitmap_t * e, unsigned int bit, int value)
>   					free(n);
>   				}
>   			}
> +			e->cardinality = 0; /* invalidate cached cardinality */
>   			return 0;
>   		}
>   		prev = n;
> @@ -339,6 +347,7 @@ int ebitmap_set_bit(ebitmap_t * e, unsigned int bit, int value)
>   		e->node = new;
>   	}
>   
> +	e->cardinality = 0; /* invalidate cached cardinality */
>   	return 0;
>   }
>   
> @@ -358,6 +367,7 @@ void ebitmap_destroy(ebitmap_t * e)
>   
>   	e->highbit = 0;
>   	e->node = 0;
> +	e->cardinality = 0;
>   	return;
>   }
>   
> 

