Return-Path: <SRS0=jI/q=3F=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0480C3F68F
	for <selinux@archiver.kernel.org>; Thu, 16 Jan 2020 17:18:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CB242192A
	for <selinux@archiver.kernel.org>; Thu, 16 Jan 2020 17:18:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="YCn1bAif"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391354AbgAPRSE (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 16 Jan 2020 12:18:04 -0500
Received: from USFB19PA33.eemsg.mail.mil ([214.24.26.196]:65441 "EHLO
        USFB19PA33.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391341AbgAPRSD (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 16 Jan 2020 12:18:03 -0500
X-EEMSG-check-017: 45416219|USFB19PA33_ESA_OUT03.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.70,327,1574121600"; 
   d="scan'208";a="45416219"
Received: from emsm-gh1-uea11.ncsc.mil ([214.29.60.3])
  by USFB19PA33.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 16 Jan 2020 17:18:00 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1579195080; x=1610731080;
  h=subject:to:references:from:message-id:date:mime-version:
   in-reply-to:content-transfer-encoding;
  bh=I5WhR3Dg6g++zZ8FRywrh7Gkb1gmOmYZ2Zs32EUSWYY=;
  b=YCn1bAifw4qCNwICM7JV0dOm3QvynpaHt1xvwrDNF9hifqJjSkKrHR8u
   igEZHR0EDg8Mr0pyW8fqzqnJwcpfm8gQVse7JqubXOOmqXGXqXj5g7fIQ
   1ATIf/tr6GmPw7zWS9Euua/vcpxLy3mFHRofTCB4UK8OrDQ1gvUs7p1bP
   HU746+CVSstA1s7eDPyAARM8Lc6iSlFfIBTI7rmO16i/a6Oet54b1rVDD
   2bPsBzQWsuf3jNngctCQcdcpLK2+WOXBBSUUfMmeaaEzFtns+Vqf4ZAir
   k7OoI3xyXTY1cE2SAfquemdF/JdYBF1QWVHP0s5IGrrnoCUQx/R8cC5Q+
   A==;
X-IronPort-AV: E=Sophos;i="5.70,327,1574121600"; 
   d="scan'208";a="37887018"
IronPort-PHdr: =?us-ascii?q?9a23=3ABmYsaBJon4FNj02GoNmcpTZWNBhigK39O0sv0r?=
 =?us-ascii?q?FitYgXKv79rarrMEGX3/hxlliBBdydt6sYzbKL+PG6ESxYuNDd6StEKMQNHz?=
 =?us-ascii?q?Y+yuwu1zQ6B8CEDUCpZNXLVAcdWPp4aVl+4nugOlJUEsutL3fbo3m18CJAUk?=
 =?us-ascii?q?6nbVk9Kev6AJPdgNqq3O6u5ZLTfx9IhD2gar9uMRm6twrcutQZjId4Nqo8yh?=
 =?us-ascii?q?TFr39Wd+9LwW9kOU+fkwzz68ut8pNv6Thct+4k+8VdTaj0YqM0QKBCAj87KW?=
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
X-IPAS-Result: =?us-ascii?q?A2DTBADXmCBe/wHyM5BlHAEBAQEBBwEBEQEEBAEBgXuBf?=
 =?us-ascii?q?YFtIBIqhBCJA4ZfAQEBBoESJYluiiWHJAkBAQEBAQEBAQE3AQGEQAKCJjgTA?=
 =?us-ascii?q?hABAQEEAQEBAQEFAwEBbIVDgjspAYJ6AQUjBBFRCw4KAgImAgJXBgEMBgIBA?=
 =?us-ascii?q?YJjP4JXJaxNfzOFSoNXgT6BDiiMNnmBB4E4DAOCXT6HWYJeBJcwRpdWgkOCS?=
 =?us-ascii?q?ZNhBhuacC2OL50VIoFYKwgCGAghDzuCbFAYDYgNF45BIwMwjWwBAQ?=
Received: from tarius.tycho.ncsc.mil (HELO tarius.infosec.tycho.ncsc.mil) ([144.51.242.1])
  by emsm-gh1-uea11.NCSC.MIL with ESMTP; 16 Jan 2020 17:17:58 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.infosec.tycho.ncsc.mil (8.14.7/8.14.4) with ESMTP id 00GHHHBx037748;
        Thu, 16 Jan 2020 12:17:18 -0500
Subject: Re: [PATCH 6/6] selinux: generalize evaluate_cond_node()
To:     Ondrej Mosnacek <omosnace@redhat.com>, selinux@vger.kernel.org,
        Paul Moore <paul@paul-moore.com>
References: <20200116120439.303034-1-omosnace@redhat.com>
 <20200116120439.303034-7-omosnace@redhat.com>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <a05af421-42f1-3298-28a7-a3a88c1984e9@tycho.nsa.gov>
Date:   Thu, 16 Jan 2020 12:18:37 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <20200116120439.303034-7-omosnace@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 1/16/20 7:04 AM, Ondrej Mosnacek wrote:
> Both callers iterate the cond_list and call it for each node - turn it
> into evaluate_cond_nodes(), which does the iteration for them.
> 
> Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>

Reviewed-by: Stephen Smalley <sds@tycho.nsa.gov>

> ---
>   security/selinux/ss/conditional.c | 10 +++++++++-
>   security/selinux/ss/conditional.h |  2 +-
>   security/selinux/ss/services.c    |  6 ++----
>   3 files changed, 12 insertions(+), 6 deletions(-)
> 
> diff --git a/security/selinux/ss/conditional.c b/security/selinux/ss/conditional.c
> index 8f9f2f3c86a0..ad709ccea036 100644
> --- a/security/selinux/ss/conditional.c
> +++ b/security/selinux/ss/conditional.c
> @@ -86,7 +86,7 @@ static int cond_evaluate_expr(struct policydb *p, struct cond_expr *expr)
>    * list appropriately. If the result of the expression is undefined
>    * all of the rules are disabled for safety.
>    */
> -void evaluate_cond_node(struct policydb *p, struct cond_node *node)
> +static void evaluate_cond_node(struct policydb *p, struct cond_node *node)
>   {
>   	struct avtab_node *avnode;
>   	int new_state;
> @@ -117,6 +117,14 @@ void evaluate_cond_node(struct policydb *p, struct cond_node *node)
>   	}
>   }
>   
> +void evaluate_cond_nodes(struct policydb *p)
> +{
> +	u32 i;
> +
> +	for (i = 0; i < p->cond_list_len; i++)
> +		evaluate_cond_node(p, &p->cond_list[i]);
> +}
> +
>   int cond_policydb_init(struct policydb *p)
>   {
>   	int rc;
> diff --git a/security/selinux/ss/conditional.h b/security/selinux/ss/conditional.h
> index 4677c6ff7450..b9eb888ffa76 100644
> --- a/security/selinux/ss/conditional.h
> +++ b/security/selinux/ss/conditional.h
> @@ -78,6 +78,6 @@ void cond_compute_av(struct avtab *ctab, struct avtab_key *key,
>   		struct av_decision *avd, struct extended_perms *xperms);
>   void cond_compute_xperms(struct avtab *ctab, struct avtab_key *key,
>   		struct extended_perms_decision *xpermd);
> -void evaluate_cond_node(struct policydb *p, struct cond_node *node);
> +void evaluate_cond_nodes(struct policydb *p);
>   
>   #endif /* _CONDITIONAL_H_ */
> diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
> index b0f71afcf4b8..887331a0cc3c 100644
> --- a/security/selinux/ss/services.c
> +++ b/security/selinux/ss/services.c
> @@ -2954,8 +2954,7 @@ int security_set_bools(struct selinux_state *state, u32 len, int *values)
>   			policydb->bool_val_to_struct[i]->state = 0;
>   	}
>   
> -	for (i = 0; i < policydb->cond_list_len; i++)
> -		evaluate_cond_node(policydb, &policydb->cond_list[i]);
> +	evaluate_cond_nodes(policydb);
>   
>   	seqno = ++state->ss->latest_granting;
>   	rc = 0;
> @@ -3006,8 +3005,7 @@ static void security_preserve_bools(struct policydb *oldpolicydb,
>   		if (booldatum)
>   			booldatum->state = value;
>   	}
> -	for (i = 0; i < newpolicydb->cond_list_len; i++)
> -		evaluate_cond_node(newpolicydb, &newpolicydb->cond_list[i]);
> +	evaluate_cond_nodes(newpolicydb);
>   }
>   
>   /*
> 

