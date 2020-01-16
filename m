Return-Path: <SRS0=jI/q=3F=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4083C33CAF
	for <selinux@archiver.kernel.org>; Thu, 16 Jan 2020 18:10:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E1A8214AF
	for <selinux@archiver.kernel.org>; Thu, 16 Jan 2020 18:10:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="BxSI4RNf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405442AbgAPRhp (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 16 Jan 2020 12:37:45 -0500
Received: from USAT19PA20.eemsg.mail.mil ([214.24.22.194]:53450 "EHLO
        USAT19PA20.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393125AbgAPRhp (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 16 Jan 2020 12:37:45 -0500
X-EEMSG-check-017: 70432054|USAT19PA20_ESA_OUT01.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.70,327,1574121600"; 
   d="scan'208";a="70432054"
Received: from emsm-gh1-uea11.ncsc.mil ([214.29.60.3])
  by USAT19PA20.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 16 Jan 2020 17:07:32 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1579194453; x=1610730453;
  h=subject:to:references:from:message-id:date:mime-version:
   in-reply-to:content-transfer-encoding;
  bh=FeuECCFs7RNbQ0adXAT0nwnM8Ea+soJIpFpLdXPb0gg=;
  b=BxSI4RNfMynNCKmJiPA+EMU4oOs7I+5s9wjqeU9Wtexis0xrwRaiy0yD
   hk3nCIamdCosAPeeNQdiewMsjpt5Uh4IBy0tCc6mzH2NGm2FjlSZWp1gA
   Ufa790/HOYnOnc3EXGuwefQUppJGz8tutDhCLf3O3w9v8CXUxi2Jj9K4g
   rgnd6rQiJTbtxI5Tuq6IJYj9aSfpurPjFhR7mzes3MIuS2aFNXiISruDp
   zfSXfy+V6fcb45rLsKYwpgVuYJ9hbpP8nH4V9AFXzbeRYk+n6+5YLYEPx
   sYr1Eyuak3ZN2QwINflp6JzivQaDu17s/90VBFQRZgcCSIOCpLL4igLHj
   g==;
X-IronPort-AV: E=Sophos;i="5.70,326,1574121600"; 
   d="scan'208";a="37886265"
IronPort-PHdr: =?us-ascii?q?9a23=3ADd1BJxKtLvBzhv3pKtmcpTZWNBhigK39O0sv0r?=
 =?us-ascii?q?FitYgXKv79rarrMEGX3/hxlliBBdydt6sYzbKL+PCxESxYuNDd6StEKMQNHz?=
 =?us-ascii?q?Y+yuwu1zQ6B8CEDUCpZNXLVAcdWPp4aVl+4nugOlJUEsutL3fbo3m18CJAUk?=
 =?us-ascii?q?6nbVk9Kev6AJPdgNqq3O6u5ZLTfx9IhD2gar9uMRm6twrcutQZjId4Nqo8yh?=
 =?us-ascii?q?TFr3hMdu9LwW9kOU+fkwzz68ut8pNv6Thct+4k+8VdTaj0YqM0QKBCAj87KW?=
 =?us-ascii?q?41/srrtRfCTQuL+HQRV3gdnwRLDQbY8hz0R4/9vSTmuOVz3imaJtD2QqsvWT?=
 =?us-ascii?q?u+9adrSQTnhzkBOjUk7WzYkM1wjKZcoBK8uxxyxpPfbY+JOPZieK7WYMgXTn?=
 =?us-ascii?q?RdUMlPSyNBA5u8b4oRAOoHIeZYtJT2q18XoRejGQWgGObjxzlGiX/s2a0xzv?=
 =?us-ascii?q?ovHwfI0gc9G94CqXrZodHwOKoUTOu7zrTHzS/bYv1Lxzn95ojGfBMvr/6CUr?=
 =?us-ascii?q?1/c9bex0Y0GgPZjFids5DpMy+b2+kPtWWQ8upuVfioi24iswx/vySvydk0io?=
 =?us-ascii?q?nJmI0VzE3P+zh8wIkvId24TFB0YN65G5ZXrCGVKpB2T9g+Q2BopCk6yroGtY?=
 =?us-ascii?q?S9fCgR0psr3RHfa/uZc4WR5B/oSeWfIS9giX54d7+yiAy+/Ei9xuHmSMW530?=
 =?us-ascii?q?hGojBYntTKq3sDzQbc6tKdRft45kqh3DGP2B3N5excOkA0kLbbK4Ymwr4tip?=
 =?us-ascii?q?ofqUTDETHymEXxlKKWal8r+vKp6+T6ebXqvJ6cN4l6igH5KaQhhNCwDf4kMg?=
 =?us-ascii?q?kOQ2eb+eO82Kfl/ULlW7VFkuc6kqzYsJDePcgbp6i5DBFJ0os79hqyADir3M?=
 =?us-ascii?q?4YkHUaNl5JZh2Kg5bzN13TOPz4CO2wg1WokDdl3fDGObjhD43WLnfei7fsZq?=
 =?us-ascii?q?p96k5AxwozytBT/ZRUCqobL/7pVU/xs8LYAgcjMwOo2+bnFMl91oQGVGKIB6?=
 =?us-ascii?q?+ZN7jSsVmS6e0zPeaBf5UVtyjgJPgl/fHukWU1lkMafamsxZEXcmy3Hux6I0?=
 =?us-ascii?q?WFZnrhmswBHnkOvgo/SuzqlVKDXCVNZ3a9Qa08/Cs3CIG4AofZQICinriB0D?=
 =?us-ascii?q?28Hp1MaWBMEkqMHmvwd4WYR/cMbzqfItd7nTwZUbisUJch2guztA/+0rZnK+?=
 =?us-ascii?q?3U+ioCtZ39ztR6++rTlRRhvQBzWuOb33uATSlRmXgOTjQ73+grpkl60VGK2q?=
 =?us-ascii?q?VQmfFUFdVPofhOV1F+fYXRy+18FsDaRA3MZJGKRUygT9HgBis+CpoJysIKK2?=
 =?us-ascii?q?N6HM+vxkTb1jeuK6ccirjOAZsz6K+a1H/0cZVT0XHDgZI9gkEmT80HDmivgq?=
 =?us-ascii?q?py5kCHHILSu1mInKatM6IH1WjC83nVnjnGh11RTAMlCfaNZnsYfEaD6I2it0?=
 =?us-ascii?q?4=3D?=
X-IPAS-Result: =?us-ascii?q?A2CuBAC7liBe/wHyM5BlHAEBAQEBBwEBEQEEBAEBgXuBf?=
 =?us-ascii?q?YFtIBIqhBCJA4ZfAQEBBoE3iW6RSQkBAQEBAQEBAQE3AQGEQAKCJjgTAhABA?=
 =?us-ascii?q?QEEAQEBAQEFAwEBbIVDgjspAYJ6AQUjBBFRCw4KAgImAgJXBgEMBgIBAYJjP?=
 =?us-ascii?q?4JXJaxKfzOFSoNWgT6BDiiMNnmBB4ERJw+CXT6HWYJeBI1aiHVhRpdWgkOCS?=
 =?us-ascii?q?ZNhBhuacC2OL50VIoFYKwgCGAghDzuCbFAYDYgNF45BIwMwjWwBAQ?=
Received: from tarius.tycho.ncsc.mil (HELO tarius.infosec.tycho.ncsc.mil) ([144.51.242.1])
  by emsm-gh1-uea11.NCSC.MIL with ESMTP; 16 Jan 2020 17:07:31 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.infosec.tycho.ncsc.mil (8.14.7/8.14.4) with ESMTP id 00GH6dvW037651;
        Thu, 16 Jan 2020 12:06:43 -0500
Subject: Re: [PATCH 3/6] selinux: convert cond_list to array
To:     Ondrej Mosnacek <omosnace@redhat.com>, selinux@vger.kernel.org,
        Paul Moore <paul@paul-moore.com>
References: <20200116120439.303034-1-omosnace@redhat.com>
 <20200116120439.303034-4-omosnace@redhat.com>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <75197d14-8b30-e74f-c908-5f2d8eafce57@tycho.nsa.gov>
Date:   Thu, 16 Jan 2020 12:07:59 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <20200116120439.303034-4-omosnace@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 1/16/20 7:04 AM, Ondrej Mosnacek wrote:
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
>   security/selinux/ss/services.c         | 27 +++++++------
>   7 files changed, 42 insertions(+), 57 deletions(-)
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
> index e369b0092cdf..ef1718394dee 100644
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
> index b9eda7d89e22..b0f71afcf4b8 100644
> --- a/security/selinux/ss/services.c
> +++ b/security/selinux/ss/services.c
> @@ -2864,10 +2864,11 @@ out:
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
>   	if (!state->initialized) {
>   		*len = 0;
> @@ -2921,12 +2922,11 @@ err:
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
> @@ -2954,8 +2954,8 @@ int security_set_bools(struct selinux_state *state, int len, int *values)
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
> @@ -2971,11 +2971,11 @@ out:
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
> @@ -2996,8 +2996,7 @@ static void security_preserve_bools(struct policydb *oldpolicydb,
>   				    struct policydb *newpolicydb)
>   {
>   	struct cond_bool_datum *booldatum;
> -	struct cond_node *cur;
> -	int i;
> +	u32 i;
>   
>   	for (i = 0; i < oldpolicydb->p_bools.nprim; i++) {
>   		const char *name = sym_name(oldpolicydb, SYM_BOOLS, i);
> @@ -3007,8 +3006,8 @@ static void security_preserve_bools(struct policydb *oldpolicydb,
>   		if (booldatum)
>   			booldatum->state = value;
>   	}
> -	for (cur = newpolicydb->cond_list; cur; cur = cur->next)
> -		evaluate_cond_node(newpolicydb, cur);
> +	for (i = 0; i < newpolicydb->cond_list_len; i++)
> +		evaluate_cond_node(newpolicydb, &newpolicydb->cond_list[i]);
>   }
>   
>   /*
> 

