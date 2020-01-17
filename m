Return-Path: <SRS0=ftCu=3G=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CA5AC33C9E
	for <selinux@archiver.kernel.org>; Fri, 17 Jan 2020 19:38:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C046420748
	for <selinux@archiver.kernel.org>; Fri, 17 Jan 2020 19:38:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="V13pf65J"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727519AbgAQTiL (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 17 Jan 2020 14:38:11 -0500
Received: from UPDC19PA24.eemsg.mail.mil ([214.24.27.199]:21236 "EHLO
        UPDC19PA24.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726897AbgAQTiL (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 17 Jan 2020 14:38:11 -0500
X-EEMSG-check-017: 47088675|UPDC19PA24_ESA_OUT06.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.70,331,1574121600"; 
   d="scan'208";a="47088675"
Received: from emsm-gh1-uea11.ncsc.mil ([214.29.60.3])
  by UPDC19PA24.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 17 Jan 2020 19:38:07 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1579289888; x=1610825888;
  h=subject:to:references:from:message-id:date:mime-version:
   in-reply-to:content-transfer-encoding;
  bh=mXJwDhKUm+rTLf7vnMNRYH0M3iqMzlaZqrl2QnFHBLA=;
  b=V13pf65Jcu0r7uZgPJL4E3IsbP6y7Ot/K78waGQ6VNAi3WzMC/GLw0T+
   XgOxZdQ95hue92muz1YrjmLFtCZsit7/E+TFMaS2R0buZImKL9numnFPf
   ZYOHqeHwR7pVb3VQ9SKEJNOCb6OnCn7wRbiucHLo3UX+zXyQA6OVsnlpQ
   MB1dO4MkGw629Nmnf8+7+AZ0TziHQ6HjKXnKIXqc63Rz4NfFdwJBHPLTY
   83e5pSNS934IVJWKOgd715QLi9A8Na0+MYx+QZqoirr3MFb7mzpCsiw/v
   qz60KwbAA7mpaLQG8EqM9R8zUzcsaZNPTnhtXr04F/CYW+s1VX57R4E2k
   w==;
X-IronPort-AV: E=Sophos;i="5.70,331,1574121600"; 
   d="scan'208";a="37959027"
IronPort-PHdr: =?us-ascii?q?9a23=3A0D9ldhcI8V2InBcbhSvZ/pF9lGMj4u6mDksu8p?=
 =?us-ascii?q?Mizoh2WeGdxc26ZhKN2/xhgRfzUJnB7Loc0qyK6vymATxLuszJ8ChbNsAVDF?=
 =?us-ascii?q?ld0YRetjdjKfbNMVf8Iv/uYn5yN+V5f3ghwUuGN1NIEt31fVzYry76xzcTHh?=
 =?us-ascii?q?LiKVg9fbytScbdgMutyu+95YDYbRlWizqhe7NyKwi9oRnMusUMjoZuN6k8xg?=
 =?us-ascii?q?HVrnZLdOhby31kLk+Xkxrg+8u85pFu/zletv4768JMTaD2dLkkQLJFCzgrL3?=
 =?us-ascii?q?o779DxuxnZSguP6HocUmEInRdNHgPI8hL0UIrvvyXjruZy1zWUMsPwTbAvRD?=
 =?us-ascii?q?St9LxrRwPyiCcGLDE27mfagdFtga1BoRKhoxt/w5PIYIyQKfFzcL/Rcc8cSG?=
 =?us-ascii?q?FcRctaSTBPDZ2gYIsOF+oBPPhXr4/hp1sVsBCyARCgCP7zxjNUg3P726M10/?=
 =?us-ascii?q?4lEQrbwgIuGdwAu2nQoNnsOqofVeW5wa/VxjvBcvxWwy/w5pXWfBAvof+CXr?=
 =?us-ascii?q?x+fsTexkYtCwzLgU6dqZDnMj6PyugBr2aW4uhmWOmyi2AnsQZxoj23y8kxlo?=
 =?us-ascii?q?nGmJoVylDa+iV/3Y07ONi4R1R/Yd6gDpRRtzyROoxtQsw/WGFlozo6y70atp?=
 =?us-ascii?q?67eygG0pInxwXFZPCdfIiI5QzjWf+XLDxlh3xlYKqyiwu9/EWv0OHxVtS43E?=
 =?us-ascii?q?xUoidKjNXArG0B2hrO4cadUPR95F2u2TOX2gDW7eFLPF47mLLAK54k3r4wjp?=
 =?us-ascii?q?0TsVnfHiPumEX5kquWdkI89+i08evneLTmpoKHN4NuiwH+NKoumsukAesmLg?=
 =?us-ascii?q?cCRXSb+OSg273j+k31WrNKgeEtkqbFqpzaIMUbpqqhDw9U1IYs9Qq/Ai+73N?=
 =?us-ascii?q?kXknQLNlJIdA+dg4T3NFzCPur0Aeqnj1SpijhrxvTGPrP7ApXKK3jOiKzhcq?=
 =?us-ascii?q?tm60NH1AoyzcxQ55JTCr0bJvLzQVX+uMbXDh8+LQy42/znB8ll1oMCRWKPBb?=
 =?us-ascii?q?eUMKTXsV+P/eIvJfODa5MLtzvmMfgq+ePhjX8jll8BZ6WmwZwXaHWgFPR8P0?=
 =?us-ascii?q?qZeWbsgssGEWoSpQoxUujqiFyEUT5OaHe/RLw85j4lB4K8F4vDRZ6igKaH3C?=
 =?us-ascii?q?ilGp1afGdGCkqDEX3wbYWLR+8MaD6OIs9mijEETaKuS5Il1Ry1rA/10adnLu?=
 =?us-ascii?q?7N9i0dspLj08J16PPJmR4u8jx0CpfV72bYaGd4hG4KDxoxx6Z2qkF+ggOE1K?=
 =?us-ascii?q?9jhfVTGPRJ6v9JWxt8PpnZmagyEN32WwTcbv+XR1u8BNarGzc8SpQ22dBKK3?=
 =?us-ascii?q?50BtHqqxfExSfiV6ccirijHJUp9ufZ2H/rKoB2zHOQh4c7iFxzeddCLW2rgO?=
 =?us-ascii?q?ZE8gHXA4PY2xGCm72CabUX3CmL8nyKi2WJohcLA0ZLTazZUCVHNQPtptPj6x?=
 =?us-ascii?q?aHFuT/BA=3D=3D?=
X-IPAS-Result: =?us-ascii?q?A2AVBACDDCJe/wHyM5BlHAEBAQEBBwEBEQEEBAEBgXuBf?=
 =?us-ascii?q?YINEiqEEYkDhmIGgRIliW6RSQkBAQEBAQEBAQE3AQGEQAKCLjgTAhABAQEEA?=
 =?us-ascii?q?QEBAQEFAwEBbIVDgjspAYJ6AQUjBBFRCw4KAgImAgJXBgEMBgIBAYJjP4JXJ?=
 =?us-ascii?q?a1lfzOFSoMvgT6BDiiMLnmBB4ERJwwDgl0+h1mCXgSNWolWRpdWgkOCSZNhB?=
 =?us-ascii?q?huaci2OL50WIoFYKwgCGAghDzuCbFAYDYgNF45BIwMwjWcBAQ?=
Received: from tarius.tycho.ncsc.mil (HELO tarius.infosec.tycho.ncsc.mil) ([144.51.242.1])
  by emsm-gh1-uea11.NCSC.MIL with ESMTP; 17 Jan 2020 19:38:06 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.infosec.tycho.ncsc.mil (8.14.7/8.14.4) with ESMTP id 00HJbS4f012051;
        Fri, 17 Jan 2020 14:37:28 -0500
Subject: Re: [PATCH v2 2/5] selinux: convert cond_list to array
To:     Ondrej Mosnacek <omosnace@redhat.com>, selinux@vger.kernel.org,
        Paul Moore <paul@paul-moore.com>
References: <20200117085836.445797-1-omosnace@redhat.com>
 <20200117085836.445797-3-omosnace@redhat.com>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <22cc3b13-2df2-1588-44aa-4dd3326ba598@tycho.nsa.gov>
Date:   Fri, 17 Jan 2020 14:38:48 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <20200117085836.445797-3-omosnace@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 1/17/20 3:58 AM, Ondrej Mosnacek wrote:
> Since it is fixed-size after allocation and we know the size beforehand,
> using a plain old array is simpler and more efficient.
> 
> While there, also fix signedness of some related variables/parameters.
> 
> Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>

Reviewed-by: Stephen Smalley <sds@tycho.nsa.gov>

> ---
>   security/selinux/include/conditional.h |  6 +--
>   security/selinux/selinuxfs.c           |  4 +-
>   security/selinux/ss/conditional.c      | 54 ++++++++++----------------
>   security/selinux/ss/conditional.h      |  3 +-
>   security/selinux/ss/policydb.c         |  2 +-
>   security/selinux/ss/policydb.h         |  3 +-
>   security/selinux/ss/services.c         | 28 ++++++-------
>   7 files changed, 43 insertions(+), 57 deletions(-)
> 
> diff --git a/security/selinux/include/conditional.h b/security/selinux/include/conditional.h
> index 0ab316f61da0..ffb9a33341f8 100644
> --- a/security/selinux/include/conditional.h
> +++ b/security/selinux/include/conditional.h
> @@ -14,12 +14,12 @@
>   #include "security.h"
>   
>   int security_get_bools(struct selinux_state *state,
> -		       int *len, char ***names, int **values);
> +		       u32 *len, char ***names, int **values);
>   
>   int security_set_bools(struct selinux_state *state,
> -		       int len, int *values);
> +		       u32 len, int *values);
>   
>   int security_get_bool_value(struct selinux_state *state,
> -			    int index);
> +			    u32 index);
>   
>   #endif
> diff --git a/security/selinux/selinuxfs.c b/security/selinux/selinuxfs.c
> index 79c710911a3c..296ce86e8b1f 100644
> --- a/security/selinux/selinuxfs.c
> +++ b/security/selinux/selinuxfs.c
> @@ -1327,14 +1327,14 @@ static void sel_remove_entries(struct dentry *de)
>   
>   static int sel_make_bools(struct selinux_fs_info *fsi)
>   {
> -	int i, ret;
> +	int ret;
>   	ssize_t len;
>   	struct dentry *dentry = NULL;
>   	struct dentry *dir = fsi->bool_dir;
>   	struct inode *inode = NULL;
>   	struct inode_security_struct *isec;
>   	char **names = NULL, *page;
> -	int num;
> +	u32 i, num;
>   	int *values = NULL;
>   	u32 sid;
>   
> diff --git a/security/selinux/ss/conditional.c b/security/selinux/ss/conditional.c
> index 04593062008d..c8a02c9b23ee 100644
> --- a/security/selinux/ss/conditional.c
> +++ b/security/selinux/ss/conditional.c
> @@ -119,6 +119,7 @@ int cond_policydb_init(struct policydb *p)
>   
>   	p->bool_val_to_struct = NULL;
>   	p->cond_list = NULL;
> +	p->cond_list_len = 0;
>   
>   	rc = avtab_init(&p->te_cond_avtab);
>   	if (rc)
> @@ -147,27 +148,22 @@ static void cond_node_destroy(struct cond_node *node)
>   	}
>   	cond_av_list_destroy(node->true_list);
>   	cond_av_list_destroy(node->false_list);
> -	kfree(node);
>   }
>   
> -static void cond_list_destroy(struct cond_node *list)
> +static void cond_list_destroy(struct policydb *p)
>   {
> -	struct cond_node *next, *cur;
> +	u32 i;
>   
> -	if (list == NULL)
> -		return;
> -
> -	for (cur = list; cur; cur = next) {
> -		next = cur->next;
> -		cond_node_destroy(cur);
> -	}
> +	for (i = 0; i < p->cond_list_len; i++)
> +		cond_node_destroy(&p->cond_list[i]);
> +	kfree(p->cond_list);
>   }
>   
>   void cond_policydb_destroy(struct policydb *p)
>   {
>   	kfree(p->bool_val_to_struct);
>   	avtab_destroy(&p->te_cond_avtab);
> -	cond_list_destroy(p->cond_list);
> +	cond_list_destroy(p);
>   }
>   
>   int cond_init_bool_indexes(struct policydb *p)
> @@ -447,7 +443,6 @@ err:
>   
>   int cond_read_list(struct policydb *p, void *fp)
>   {
> -	struct cond_node *node, *last = NULL;
>   	__le32 buf[1];
>   	u32 i, len;
>   	int rc;
> @@ -458,29 +453,24 @@ int cond_read_list(struct policydb *p, void *fp)
>   
>   	len = le32_to_cpu(buf[0]);
>   
> +	p->cond_list = kcalloc(len, sizeof(*p->cond_list), GFP_KERNEL);
> +	if (!p->cond_list)
> +		return rc;
> +
>   	rc = avtab_alloc(&(p->te_cond_avtab), p->te_avtab.nel);
>   	if (rc)
>   		goto err;
>   
>   	for (i = 0; i < len; i++) {
> -		rc = -ENOMEM;
> -		node = kzalloc(sizeof(*node), GFP_KERNEL);
> -		if (!node)
> -			goto err;
> -
> -		rc = cond_read_node(p, node, fp);
> +		rc = cond_read_node(p, &p->cond_list[i], fp);
>   		if (rc)
>   			goto err;
> -
> -		if (i == 0)
> -			p->cond_list = node;
> -		else
> -			last->next = node;
> -		last = node;
>   	}
> +
> +	p->cond_list_len = len;
>   	return 0;
>   err:
> -	cond_list_destroy(p->cond_list);
> +	cond_list_destroy(p);
>   	p->cond_list = NULL;
>   	return rc;
>   }
> @@ -585,23 +575,19 @@ static int cond_write_node(struct policydb *p, struct cond_node *node,
>   	return 0;
>   }
>   
> -int cond_write_list(struct policydb *p, struct cond_node *list, void *fp)
> +int cond_write_list(struct policydb *p, void *fp)
>   {
> -	struct cond_node *cur;
> -	u32 len;
> +	u32 i;
>   	__le32 buf[1];
>   	int rc;
>   
> -	len = 0;
> -	for (cur = list; cur != NULL; cur = cur->next)
> -		len++;
> -	buf[0] = cpu_to_le32(len);
> +	buf[0] = cpu_to_le32(p->cond_list_len);
>   	rc = put_entry(buf, sizeof(u32), 1, fp);
>   	if (rc)
>   		return rc;
>   
> -	for (cur = list; cur != NULL; cur = cur->next) {
> -		rc = cond_write_node(p, cur, fp);
> +	for (i = 0; i < p->cond_list_len; i++) {
> +		rc = cond_write_node(p, &p->cond_list[i], fp);
>   		if (rc)
>   			return rc;
>   	}
> diff --git a/security/selinux/ss/conditional.h b/security/selinux/ss/conditional.h
> index d86ef286ca84..e474bdd3a0ed 100644
> --- a/security/selinux/ss/conditional.h
> +++ b/security/selinux/ss/conditional.h
> @@ -55,7 +55,6 @@ struct cond_node {
>   	struct cond_expr *expr;
>   	struct cond_av_list *true_list;
>   	struct cond_av_list *false_list;
> -	struct cond_node *next;
>   };
>   
>   int cond_policydb_init(struct policydb *p);
> @@ -69,7 +68,7 @@ int cond_index_bool(void *key, void *datum, void *datap);
>   int cond_read_bool(struct policydb *p, struct hashtab *h, void *fp);
>   int cond_read_list(struct policydb *p, void *fp);
>   int cond_write_bool(void *key, void *datum, void *ptr);
> -int cond_write_list(struct policydb *p, struct cond_node *list, void *fp);
> +int cond_write_list(struct policydb *p, void *fp);
>   
>   void cond_compute_av(struct avtab *ctab, struct avtab_key *key,
>   		struct av_decision *avd, struct extended_perms *xperms);
> diff --git a/security/selinux/ss/policydb.c b/security/selinux/ss/policydb.c
> index 2aa7f2e1a8e7..8ac9b9ffc83c 100644
> --- a/security/selinux/ss/policydb.c
> +++ b/security/selinux/ss/policydb.c
> @@ -3483,7 +3483,7 @@ int policydb_write(struct policydb *p, void *fp)
>   	if (rc)
>   		return rc;
>   
> -	rc = cond_write_list(p, p->cond_list, fp);
> +	rc = cond_write_list(p, fp);
>   	if (rc)
>   		return rc;
>   
> diff --git a/security/selinux/ss/policydb.h b/security/selinux/ss/policydb.h
> index 69b24191fa38..6459616f8487 100644
> --- a/security/selinux/ss/policydb.h
> +++ b/security/selinux/ss/policydb.h
> @@ -272,8 +272,9 @@ struct policydb {
>   	struct cond_bool_datum **bool_val_to_struct;
>   	/* type enforcement conditional access vectors and transitions */
>   	struct avtab te_cond_avtab;
> -	/* linked list indexing te_cond_avtab by conditional */
> +	/* array indexing te_cond_avtab by conditional */
>   	struct cond_node *cond_list;
> +	u32 cond_list_len;
>   
>   	/* role allows */
>   	struct role_allow *role_allow;
> diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
> index ff43a35bb874..8fc8ec317bb6 100644
> --- a/security/selinux/ss/services.c
> +++ b/security/selinux/ss/services.c
> @@ -2868,10 +2868,11 @@ out:
>   }
>   
>   int security_get_bools(struct selinux_state *state,
> -		       int *len, char ***names, int **values)
> +		       u32 *len, char ***names, int **values)
>   {
>   	struct policydb *policydb;
> -	int i, rc;
> +	u32 i;
> +	int rc;
>   
>   	if (!selinux_initialized(state)) {
>   		*len = 0;
> @@ -2925,12 +2926,11 @@ err:
>   }
>   
>   
> -int security_set_bools(struct selinux_state *state, int len, int *values)
> +int security_set_bools(struct selinux_state *state, u32 len, int *values)
>   {
>   	struct policydb *policydb;
> -	int i, rc;
> -	int lenp, seqno = 0;
> -	struct cond_node *cur;
> +	int rc;
> +	u32 i, lenp, seqno = 0;
>   
>   	write_lock_irq(&state->ss->policy_rwlock);
>   
> @@ -2958,8 +2958,8 @@ int security_set_bools(struct selinux_state *state, int len, int *values)
>   			policydb->bool_val_to_struct[i]->state = 0;
>   	}
>   
> -	for (cur = policydb->cond_list; cur; cur = cur->next)
> -		evaluate_cond_node(policydb, cur);
> +	for (i = 0; i < policydb->cond_list_len; i++)
> +		evaluate_cond_node(policydb, &policydb->cond_list[i]);
>   
>   	seqno = ++state->ss->latest_granting;
>   	rc = 0;
> @@ -2975,11 +2975,11 @@ out:
>   }
>   
>   int security_get_bool_value(struct selinux_state *state,
> -			    int index)
> +			    u32 index)
>   {
>   	struct policydb *policydb;
>   	int rc;
> -	int len;
> +	u32 len;
>   
>   	read_lock(&state->ss->policy_rwlock);
>   
> @@ -2999,10 +2999,10 @@ out:
>   static int security_preserve_bools(struct selinux_state *state,
>   				   struct policydb *policydb)
>   {
> -	int rc, nbools = 0, *bvalues = NULL, i;
> +	int rc, *bvalues = NULL;
>   	char **bnames = NULL;
>   	struct cond_bool_datum *booldatum;
> -	struct cond_node *cur;
> +	u32 i, nbools = 0;
>   
>   	rc = security_get_bools(state, &nbools, &bnames, &bvalues);
>   	if (rc)
> @@ -3012,8 +3012,8 @@ static int security_preserve_bools(struct selinux_state *state,
>   		if (booldatum)
>   			booldatum->state = bvalues[i];
>   	}
> -	for (cur = policydb->cond_list; cur; cur = cur->next)
> -		evaluate_cond_node(policydb, cur);
> +	for (i = 0; i < policydb->cond_list_len; i++)
> +		evaluate_cond_node(policydb, &policydb->cond_list[i]);
>   
>   out:
>   	if (bnames) {
> 

