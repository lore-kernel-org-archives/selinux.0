Return-Path: <SRS0=VF96=T5=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47182C28CC0
	for <selinux@archiver.kernel.org>; Wed, 29 May 2019 20:31:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F22712415A
	for <selinux@archiver.kernel.org>; Wed, 29 May 2019 20:31:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="EEfKEaaY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726121AbfE2Ubw (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 29 May 2019 16:31:52 -0400
Received: from upbd19pa12.eemsg.mail.mil ([214.24.27.87]:20935 "EHLO
        upbd19pa12.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726043AbfE2Ubw (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 29 May 2019 16:31:52 -0400
X-EEMSG-check-017: 217793835|UPBD19PA12_EEMSG_MP12.csd.disa.mil
Received: from emsm-gh1-uea10.ncsc.mil ([214.29.60.2])
  by upbd19pa12.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 29 May 2019 20:31:46 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1559161906; x=1590697906;
  h=subject:to:references:from:message-id:date:mime-version:
   in-reply-to:content-transfer-encoding;
  bh=A24nGiOzNjH4Fj0nyJDzf9XxMgvjwnLSZfblyNZsl2A=;
  b=EEfKEaaYTmaEdzd/S0zBOcab7dibT73oDNbZLrShDXN1KxH+ZbsY7juq
   qnZ1T0MTgKJZMsGmHSctFLe7LrGeVaiAR9m3J0DzK42KYSA9inrt0JFaN
   RNSJUxxz2uNf+5gpD/qjow6TRGFzVal3cjsYwQGP7U7sh5+nEN3ZLss26
   7ynQNkhCf5comlf5MleJyhNOZlbzb09wEpBsaFud6WkzZzKoYwGT8SKxQ
   YJoSbfbGqymkEVKWdL3ckji4v4AcFp5zjpzAWmnP9JefT86FC6DlWREaz
   wQv/aja+MMIOVqgQtsfnuESGy6z4uJTXgUIp8Lo79Isp5wtnHxWdyw2yu
   Q==;
X-IronPort-AV: E=Sophos;i="5.60,527,1549929600"; 
   d="scan'208";a="24199310"
IronPort-PHdr: =?us-ascii?q?9a23=3APC5pJBJOUVJoPp0cp9mcpTZWNBhigK39O0sv0r?=
 =?us-ascii?q?FitYgeIvTxwZ3uMQTl6Ol3ixeRBMOHsqsC0rCJ+Pm9ACQp2tWoiDg6aptCVh?=
 =?us-ascii?q?sI2409vjcLJ4q7M3D9N+PgdCcgHc5PBxdP9nC/NlVJSo6lPwWB6nK94iQPFR?=
 =?us-ascii?q?rhKAF7Ovr6GpLIj8Swyuu+54Dfbx9HiTagfL9+Ngi6oRvTu8UZnIdvKrs9wQ?=
 =?us-ascii?q?bVr3VVfOhb2XlmLk+JkRbm4cew8p9j8yBOtP8k6sVNT6b0cbkmQLJBFDgpPH?=
 =?us-ascii?q?w768PttRnYUAuA/WAcXXkMkhpJGAfK8hf3VYrsvyTgt+p93C6aPdDqTb0xRD?=
 =?us-ascii?q?+v4btnRAPuhSwaLDMy7n3ZhdJsg6JauBKhpgJww4jIYIGOKfFyerrRcc4GSW?=
 =?us-ascii?q?ZdW8pcUSJOApm4b4ASEeQPO+hWpJT5q1cXoxazAQygCeXywTFKm3D2x7U33f?=
 =?us-ascii?q?k/HwHI3AIuHNwAv3rbo9r3KKgcXvu4zLXKwDjZc/9axTnw5YrOfxs8of+MR7?=
 =?us-ascii?q?Vwcc/JxEktGQLKkk+fqZb5Pz+Ly+8AtGqb7uR8Wu21kW4ntx99ryOzxsYslo?=
 =?us-ascii?q?bJhoUVxkrC9SVi2ok5P9K4SEllYdO9FpZbqiKUN5NuT88/TGxltzw2x70btZ?=
 =?us-ascii?q?KhYiQHx4orywTCZ/GBboOG+AjsVPyLLjd9nH9lfbW/iAus/kW40e38U9W00E?=
 =?us-ascii?q?5NripYjtnArnAN2ALX6siAUvZ94l2u2SyO1wDO8eFIO1w0lKrHJJ4hxb48jJ?=
 =?us-ascii?q?wTvljYHiDqgkn2ia6WdkE89uip7eTofKnmq4eBO4J7hQzyKKQjltGlDegmPQ?=
 =?us-ascii?q?UCQXKX9fmk2L3m50L5QbFKjvMskqnetZDXPcYbp6ClDABPyIYj9wizAiy60N?=
 =?us-ascii?q?UYgXYHLFVFdAiBj4jyIV7COv/4DfChg1i0ijdk2+jGPqH9ApXKNnXDl7Lhfb?=
 =?us-ascii?q?Fm605a0gU80c5Q6olOCr4fPf3zWlX+tMDCAhAlNAy0xv7tCM9h2YMGRWKPHq?=
 =?us-ascii?q?iZPbvJsVCW4uIvIu+MZJIauTvmNfgl6ODhjWUjlV8eY6apx50XZ268Hvh8JE?=
 =?us-ascii?q?WZe3Xs0Z89FjItuAYkQe6irVqZVzdYanX6C6U54So9AYmrJZ3OSoCknPqK2y?=
 =?us-ascii?q?LtWtVNa2RHDE2cOWnnep/CWPoWbi+WZMh7nW8qT7+kHo0+3hi0qFWyn7h4Je?=
 =?us-ascii?q?PO5ncwqYPo1N8z4fba0x4162onXIymz2iRQjQszSszTDgs0fU6+Bcsxw=3D?=
 =?us-ascii?q?=3D?=
X-IPAS-Result: =?us-ascii?q?A2DHDQBf6+5c/wHyM5BlHgEGBwaBZYEqAjsqaVEzKIQTi?=
 =?us-ascii?q?HuLcSWJQo8tgWcJAQEBAQEBAQEBIxEBAgEBgUtHgi4CgnUjOBMBAwEBAQQBA?=
 =?us-ascii?q?QEBAwEBbBwMgjopAYJnAQUjBBFRCwkFCgICJgICITYGAQwGAgEBgl8/AYFqA?=
 =?us-ascii?q?x2qE3wzhUeCPA1dgUaBDCYCAotSgVZAgREnDIJfPoIagW8jgyKCWASBLQGJd?=
 =?us-ascii?q?BKILZQlHD4GA4IPhWFXiQKDXwYbgh9nigOJSox1iGGPLiGBWCsKQUqBHoFOC?=
 =?us-ascii?q?YISFxSGD4gZIwMwMlQBAY1EAQE?=
Received: from tarius.tycho.ncsc.mil ([144.51.242.1])
  by EMSM-GH1-UEA10.NCSC.MIL with ESMTP; 29 May 2019 20:31:45 +0000
Received: from localhost.localdomain (moss-lions [192.168.25.4])
        by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id x4TKVi0j008926;
        Wed, 29 May 2019 16:31:44 -0400
Subject: Re: [Non-DoD Source] [PATCH userspace v2 1/7] libsepol: add a
 function to optimize kernel policy
To:     Ondrej Mosnacek <omosnace@redhat.com>, selinux@vger.kernel.org
References: <20190528145912.13827-1-omosnace@redhat.com>
 <20190528145912.13827-2-omosnace@redhat.com>
From:   jwcart2 <jwcart2@tycho.nsa.gov>
Message-ID: <a7d1cf5d-6b88-d50c-5476-bf10cda0cb30@tycho.nsa.gov>
Date:   Wed, 29 May 2019 16:32:38 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190528145912.13827-2-omosnace@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 5/28/19 10:59 AM, Ondrej Mosnacek wrote:
> Add sepol_policydb_optimize(), which checks a kernel policy for
> redundant rules (i.e. those that are covered by an existing more general
> rule) and removes them.
> 
> Results on Fedora 29 policy:
> 
> WITHOUT OPTIMIZATION:
>      # time semodule -B
>      real    0m21,280s
>      user    0m18,636s
>      sys     0m2,525s
> 
>      $ wc -c /sys/fs/selinux/policy
>      8692158 /sys/fs/selinux/policy
> 
>      $ seinfo (edited)
>        Allow:            113159
>        Dontaudit:         10297
>        Total:            123156
> 
> WITH OPTIMIZATION ENABLED:
>      # time semodule -B
>      real    0m22,825s
>      user    0m20,178s
>      sys     0m2,520s
> 
>      $ wc -c /sys/fs/selinux/policy
>      8096158 /sys/fs/selinux/policy
> 
>      $ seinfo (edited)
>        Allow:             66334
>        Dontaudit:          7480
>        Total:             73814
> 
> Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> ---
>   libsepol/include/sepol/policydb.h          |   5 +
>   libsepol/include/sepol/policydb/policydb.h |   2 +
>   libsepol/src/libsepol.map.in               |   5 +
>   libsepol/src/optimize.c                    | 374 +++++++++++++++++++++
>   libsepol/src/policydb_public.c             |   5 +
>   5 files changed, 391 insertions(+)
>   create mode 100644 libsepol/src/optimize.c
> 
> diff --git a/libsepol/include/sepol/policydb.h b/libsepol/include/sepol/policydb.h
> index 6769b913..792913dd 100644
> --- a/libsepol/include/sepol/policydb.h
> +++ b/libsepol/include/sepol/policydb.h
> @@ -100,6 +100,11 @@ extern int sepol_policydb_set_handle_unknown(sepol_policydb_t * p,
>   extern int sepol_policydb_set_target_platform(sepol_policydb_t * p,
>   					     int target_platform);
>   
> +/*
> + * Optimize the policy by removing redundant rules.
> + */
> +extern int sepol_policydb_optimize(sepol_policydb_t * p);
> +
>   /*
>    * Read a policydb from a policy file.
>    * This automatically sets the type and version based on the
> diff --git a/libsepol/include/sepol/policydb/policydb.h b/libsepol/include/sepol/policydb/policydb.h
> index 591ce6e0..a279382e 100644
> --- a/libsepol/include/sepol/policydb/policydb.h
> +++ b/libsepol/include/sepol/policydb/policydb.h
> @@ -636,6 +636,8 @@ extern int policydb_user_cache(hashtab_key_t key,
>   
>   extern int policydb_reindex_users(policydb_t * p);
>   
> +extern int policydb_optimize(policydb_t * p);
> +
>   extern void policydb_destroy(policydb_t * p);
>   
>   extern int policydb_load_isids(policydb_t * p, sidtab_t * s);
> diff --git a/libsepol/src/libsepol.map.in b/libsepol/src/libsepol.map.in
> index d879016c..6358e51f 100644
> --- a/libsepol/src/libsepol.map.in
> +++ b/libsepol/src/libsepol.map.in
> @@ -59,3 +59,8 @@ LIBSEPOL_1.1 {
>   	sepol_polcap_getnum;
>   	sepol_polcap_getname;
>   } LIBSEPOL_1.0;
> +
> +LIBSEPOL_1.2 {
> +  global:
> +	sepol_optimize_policy;
> +} LIBSEPOL_1.1;
> diff --git a/libsepol/src/optimize.c b/libsepol/src/optimize.c
> new file mode 100644
> index 00000000..b3859b6c
> --- /dev/null
> +++ b/libsepol/src/optimize.c
> @@ -0,0 +1,374 @@
> +/*
> + * Author: Ondrej Mosnacek <omosnacek@gmail.com>
> + *
> + * Copyright (C) 2019 Red Hat Inc.
> + *
> + *  This library is free software; you can redistribute it and/or
> + *  modify it under the terms of the GNU Lesser General Public
> + *  License as published by the Free Software Foundation; either
> + *  version 2.1 of the License, or (at your option) any later version.
> + *
> + *  This library is distributed in the hope that it will be useful,
> + *  but WITHOUT ANY WARRANTY; without even the implied warranty of
> + *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> + *  Lesser General Public License for more details.
> + *
> + *  You should have received a copy of the GNU Lesser General Public
> + *  License along with this library; if not, write to the Free Software
> + *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
> + */
> +
> +/*
> + * Binary policy optimization.
> + *
> + * Defines the policydb_optimize() function, which finds and removes
> + * redundant rules from the binary policy to reduce its size and potentially
> + * improve rule matching times. Only rules that are already covered by a
> + * more general rule are removed. The resulting policy is functionally
> + * equivalent to the original one.
> + */
> +
> +#include <sepol/policydb/policydb.h>
> +#include <sepol/policydb/conditional.h>
> +
> +/* builds map: type/attribute -> {all attributes that are a superset of it} */
> +static ebitmap_t *build_type_map(const policydb_t *p)
> +{
> +	unsigned int i, k;
> +	ebitmap_t *map = malloc(p->p_types.nprim * sizeof(ebitmap_t));
> +	if (!map)
> +		return NULL;
> +
> +	for (i = 0; i < p->p_types.nprim; i++) {
> +		if (p->type_val_to_struct[i] &&
> +		    p->type_val_to_struct[i]->flavor != TYPE_ATTRIB) {
> +			if (ebitmap_cpy(&map[i], &p->type_attr_map[i]))
> +				goto err;
> +		} else {
> +			ebitmap_t *types_i = &p->attr_type_map[i];
> +
> +			ebitmap_init(&map[i]);
> +			for (k = 0; k < p->p_types.nprim; k++) {
> +				ebitmap_t *types_k = &p->attr_type_map[k];
> +
> +				if (ebitmap_contains(types_k, types_i)) {
> +					if (ebitmap_set_bit(&map[i], k, 1))
> +						goto err;
> +				}
> +			}
> +		}
> +	}
> +	return map;
> +err:
> +	for (k = 0; k < i; k++)
> +		ebitmap_destroy(&map[i]);

Should be &map[k]
If ebitmap_set_bit() fails then you need to ebitmap_destroy the ith map, so it 
should be k <= i in the for loop.

Still looking through this series. It does seem to produce the correct results.

Jim

> +	return NULL;
> +}
> +
> +static void destroy_type_map(const policydb_t *p, ebitmap_t *type_map)
> +{
> +	unsigned int i;
> +	for (i = 0; i < p->p_types.nprim; i++)
> +		ebitmap_destroy(&type_map[i]);
> +	free(type_map);
> +}
> +
> +static int match_xperms(const uint32_t *p1, const uint32_t *p2)
> +{
> +	size_t i;
> +
> +	for (i = 0; i < EXTENDED_PERMS_LEN; i++) {
> +		if ((p2[i] & p1[i]) != p1[i])
> +			return 0;
> +	}
> +	return 1;
> +}
> +
> +static int match_avtab_datum(uint16_t specified,
> +			     const avtab_datum_t *d1, const avtab_datum_t *d2)
> +{
> +	/* inverse logic needed for AUDITDENY rules */
> +	if (specified & AVTAB_AUDITDENY)
> +		return (d1->data & d2->data) == d2->data;
> +
> +	if (specified & AVTAB_AV)
> +		return (d2->data & d1->data) == d1->data;
> +
> +	if (specified & AVTAB_XPERMS) {
> +		const avtab_extended_perms_t *x1 = d1->xperms;
> +		const avtab_extended_perms_t *x2 = d2->xperms;
> +
> +		if (x1->specified == AVTAB_XPERMS_IOCTLFUNCTION) {
> +			if (x2->specified == AVTAB_XPERMS_IOCTLFUNCTION) {
> +				if (x1->driver != x2->driver)
> +					return 0;
> +				return match_xperms(x1->perms, x2->perms);
> +			}
> +			if (x2->specified == AVTAB_XPERMS_IOCTLDRIVER)
> +				return xperm_test(x1->driver, x2->perms);
> +		} else if (x1->specified == AVTAB_XPERMS_IOCTLDRIVER) {
> +			if (x2->specified == AVTAB_XPERMS_IOCTLFUNCTION)
> +				return 0;
> +
> +			if (x2->specified == AVTAB_XPERMS_IOCTLDRIVER)
> +				return match_xperms(x1->perms, x2->perms);
> +		}
> +		return 0;
> +	}
> +	return 0;
> +}
> +
> +/* checks if avtab contains a rule that covers the given rule */
> +static int is_avrule_redundant(avtab_ptr_t entry, avtab_t *tab,
> +			       const ebitmap_t *type_map)
> +{
> +	unsigned int i, k, s_idx, t_idx;
> +	ebitmap_node_t *snode, *tnode;
> +	avtab_datum_t *d1, *d2;
> +	avtab_key_t key;
> +
> +	/* we only care about AV rules */
> +	if (!(entry->key.specified & (AVTAB_AV|AVTAB_XPERMS)))
> +		return 0;
> +
> +	s_idx = entry->key.source_type - 1;
> +	t_idx = entry->key.target_type - 1;
> +
> +	key.target_class = entry->key.target_class;
> +	key.specified    = entry->key.specified;
> +
> +	d1 = &entry->datum;
> +
> +	ebitmap_for_each_positive_bit(&type_map[s_idx], snode, i) {
> +		key.source_type = i + 1;
> +
> +		ebitmap_for_each_positive_bit(&type_map[t_idx], tnode, k) {
> +			if (s_idx == i && t_idx == k)
> +				continue;
> +
> +			key.target_type = k + 1;
> +
> +			d2 = avtab_search(tab, &key);
> +			if (!d2)
> +				continue;
> +
> +			if (match_avtab_datum(key.specified, d1, d2))
> +				return 1;
> +		}
> +	}
> +	return 0;
> +}
> +
> +static int is_type_attr(policydb_t *p, unsigned int id)
> +{
> +	return p->type_val_to_struct[id]->flavor == TYPE_ATTRIB;
> +}
> +
> +static int is_avrule_with_attr(avtab_ptr_t entry, policydb_t *p)
> +{
> +	unsigned int s_idx = entry->key.source_type - 1;
> +	unsigned int t_idx = entry->key.target_type - 1;
> +
> +	return is_type_attr(p, s_idx) || is_type_attr(p, t_idx);
> +}
> +
> +/* checks if conditional list contains a rule that covers the given rule */
> +static int is_cond_rule_redundant(avtab_ptr_t e1, cond_av_list_t *list,
> +				  const ebitmap_t *type_map)
> +{
> +	unsigned int s1, t1, c1, k1, s2, t2, c2, k2;
> +
> +	/* we only care about AV rules */
> +	if (!(e1->key.specified & (AVTAB_AV|AVTAB_XPERMS)))
> +		return 0;
> +
> +	s1 = e1->key.source_type - 1;
> +	t1 = e1->key.target_type - 1;
> +	c1 = e1->key.target_class;
> +	k1 = e1->key.specified;
> +
> +	for (; list; list = list->next) {
> +		avtab_ptr_t e2 = list->node;
> +
> +		s2 = e2->key.source_type - 1;
> +		t2 = e2->key.target_type - 1;
> +		c2 = e2->key.target_class;
> +		k2 = e2->key.specified;
> +
> +		if (k1 != k2 || c1 != c2)
> +			continue;
> +
> +		if (s1 == s2 && t1 == t2)
> +			continue;
> +		if (!ebitmap_get_bit(&type_map[s1], s2))
> +			continue;
> +		if (!ebitmap_get_bit(&type_map[t1], t2))
> +			continue;
> +
> +		if (match_avtab_datum(k1, &e1->datum, &e2->datum))
> +			return 1;
> +	}
> +	return 0;
> +}
> +
> +static void optimize_avtab(policydb_t *p, const ebitmap_t *type_map)
> +{
> +	avtab_t *tab = &p->te_avtab;
> +	unsigned int i;
> +	avtab_ptr_t *cur;
> +
> +	for (i = 0; i < tab->nslot; i++) {
> +		cur = &tab->htable[i];
> +		while (*cur) {
> +			if (is_avrule_redundant(*cur, tab, type_map)) {
> +				/* redundant rule -> remove it */
> +				avtab_ptr_t tmp = *cur;
> +
> +				*cur = tmp->next;
> +				if (tmp->key.specified & AVTAB_XPERMS)
> +					free(tmp->datum.xperms);
> +				free(tmp);
> +
> +				tab->nel--;
> +			} else {
> +				/* rule not redundant -> move to next rule */
> +				cur = &(*cur)->next;
> +			}
> +		}
> +	}
> +}
> +
> +/* find redundant rules in (*cond) and put them into (*del) */
> +static void optimize_cond_av_list(cond_av_list_t **cond, cond_av_list_t **del,
> +				  policydb_t *p, const ebitmap_t *type_map)
> +{
> +	cond_av_list_t **listp = cond;
> +	cond_av_list_t *pcov = NULL;
> +	cond_av_list_t **pcov_cur = &pcov;
> +
> +	/*
> +	 * Separate out all "potentially covering" rules (src or tgt is an attr)
> +	 * and move them to the end of the list. This is needed to avoid
> +	 * polynomial complexity when almost all rules are expanded.
> +	 */
> +	while (*cond) {
> +		if (is_avrule_with_attr((*cond)->node, p)) {
> +			cond_av_list_t *tmp = *cond;
> +
> +			*cond = tmp->next;
> +			tmp->next = pcov;
> +			pcov = tmp;
> +		} else {
> +			cond = &(*cond)->next;
> +		}
> +	}
> +	/* link the "potentially covering" rules to the end of the list */
> +	*cond = pcov;
> +
> +	/* now go through the list and find the redundant rules */
> +	cond = listp;
> +	pcov_cur = &pcov;
> +	while (*cond) {
> +		/* needed because pcov itself may get deleted */
> +		if (*cond == pcov)
> +			pcov_cur = cond;
> +		/*
> +		 * First check if covered by an unconditional rule, then also
> +		 * check if covered by another rule in the same list.
> +		 */
> +		if (is_avrule_redundant((*cond)->node, &p->te_avtab, type_map) ||
> +		    is_cond_rule_redundant((*cond)->node, *pcov_cur, type_map)) {
> +			cond_av_list_t *tmp = *cond;
> +
> +			*cond = tmp->next;
> +			tmp->next = *del;
> +			*del = tmp;
> +		} else {
> +			cond = &(*cond)->next;
> +		}
> +	}
> +}
> +
> +static void optimize_cond_avtab(policydb_t *p, const ebitmap_t *type_map)
> +{
> +	avtab_t *tab = &p->te_cond_avtab;
> +	unsigned int i;
> +	avtab_ptr_t *cur;
> +	cond_node_t **cond;
> +	cond_av_list_t **avcond, *del = NULL;
> +
> +	/* First go through all conditionals and collect redundant rules. */
> +	cond = &p->cond_list;
> +	while (*cond) {
> +		optimize_cond_av_list(&(*cond)->true_list,  &del, p, type_map);
> +		optimize_cond_av_list(&(*cond)->false_list, &del, p, type_map);
> +		/* TODO: maybe also check for rules present in both lists */
> +
> +		/* nothing left in both lists -> remove the whole conditional */
> +		if (!(*cond)->true_list && !(*cond)->false_list) {
> +			cond_node_t *cond_tmp = *cond;
> +
> +			*cond = cond_tmp->next;
> +			cond_node_destroy(cond_tmp);
> +		} else {
> +			cond = &(*cond)->next;
> +		}
> +	}
> +
> +	if (!del)
> +		return;
> +
> +	/*
> +	 * Now go through the whole cond_avtab and remove all rules that are
> +	 * found in the 'del' list.
> +	 */
> +	for (i = 0; i < tab->nslot; i++) {
> +		cur = &tab->htable[i];
> +		while (*cur) {
> +			int redundant = 0;
> +			avcond = &del;
> +			while (*avcond) {
> +				if ((*avcond)->node == *cur) {
> +					cond_av_list_t *cond_tmp = *avcond;
> +
> +					*avcond = cond_tmp->next;
> +					free(cond_tmp);
> +					redundant = 1;
> +					break;
> +				} else {
> +					avcond = &(*avcond)->next;
> +				}
> +			}
> +			if (redundant) {
> +				avtab_ptr_t tmp = *cur;
> +
> +				*cur = tmp->next;
> +				if (tmp->key.specified & AVTAB_XPERMS)
> +					free(tmp->datum.xperms);
> +				free(tmp);
> +
> +				tab->nel--;
> +			} else {
> +				cur = &(*cur)->next;
> +			}
> +		}
> +	}
> +}
> +
> +int policydb_optimize(policydb_t *p)
> +{
> +	ebitmap_t *type_map;
> +
> +	if (p->policy_type != POLICY_KERN)
> +		return -1;
> +
> +	type_map = build_type_map(p);
> +	if (!type_map)
> +		return -1;
> +
> +	optimize_avtab(p, type_map);
> +	optimize_cond_avtab(p, type_map);
> +
> +	destroy_type_map(p, type_map);
> +	return 0;
> +}
> diff --git a/libsepol/src/policydb_public.c b/libsepol/src/policydb_public.c
> index e7218423..747a43ff 100644
> --- a/libsepol/src/policydb_public.c
> +++ b/libsepol/src/policydb_public.c
> @@ -169,6 +169,11 @@ int sepol_policydb_set_target_platform(sepol_policydb_t * sp,
>   	return 0;
>   }
>   
> +int sepol_policydb_optimize(sepol_policydb_t * p)
> +{
> +	return policydb_optimize(&p->p);
> +}
> +
>   int sepol_policydb_read(sepol_policydb_t * p, sepol_policy_file_t * pf)
>   {
>   	return policydb_read(&p->p, &pf->pf, 0);
> 


-- 
James Carter <jwcart2@tycho.nsa.gov>
National Security Agency
