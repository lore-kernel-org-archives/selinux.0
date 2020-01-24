Return-Path: <SRS0=mP8O=3N=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9CEFC47409
	for <selinux@archiver.kernel.org>; Fri, 24 Jan 2020 14:29:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE8052087E
	for <selinux@archiver.kernel.org>; Fri, 24 Jan 2020 14:29:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="gu8hDz5b"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391128AbgAXO3E (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 24 Jan 2020 09:29:04 -0500
Received: from UPDC19PA24.eemsg.mail.mil ([214.24.27.199]:28619 "EHLO
        UPDC19PA24.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390967AbgAXO3D (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 24 Jan 2020 09:29:03 -0500
X-EEMSG-check-017: 49352935|UPDC19PA24_ESA_OUT06.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.70,357,1574121600"; 
   d="scan'208";a="49352935"
Received: from emsm-gh1-uea10.ncsc.mil ([214.29.60.2])
  by UPDC19PA24.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 24 Jan 2020 14:28:59 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1579876139; x=1611412139;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=y/MifIdzpslyux55djl130lL5OFeBNcPDNU3yOPrKM8=;
  b=gu8hDz5bqCj/WBlcU2rhjm0/bA7nRcfcu7rv9uYrO+qdwXV6ktBrmstn
   iX9Vdu2LHx1bGmb46RHQ+sq5ssu84BpJ/Z5lj0wbBbccI8s/OBM82TWVj
   iGYL+0FLVDGB6i9NeHLiOu3RxnTwRayzGnPCkm62f6UmwGpnoNFRPbhFe
   0d2PyM3ezQu8u/dDWhMRHhyDI6ayrGAX+c3X0oCPOcamepJwZGxIYRrZb
   FkyCsFvHelC6sk6ItvKL4tn5TRdZ5pYSvS6b8RvqSkgFiDAKnZZasIDWL
   QT2sbzoozmWup88LT8iMub17IkALHFuH3o9YJOvGfzIvl/kVfxSiXOFiK
   A==;
X-IronPort-AV: E=Sophos;i="5.70,357,1574121600"; 
   d="scan'208";a="32294364"
IronPort-PHdr: =?us-ascii?q?9a23=3A3sUJ6xfy1ZDpINdZauSA9NHKlGMj4u6mDksu8p?=
 =?us-ascii?q?Mizoh2WeGdxc2/ZBCN2/xhgRfzUJnB7Loc0qyK6vymAzBLv8zJ8ChbNsAVDF?=
 =?us-ascii?q?ld0YRetjdjKfbNMVf8Iv/uYn5yN+V5f3ghwUuGN1NIEt31fVzYry76xzcTHh?=
 =?us-ascii?q?LiKVg9fbytScbdgMutyu+95YDYbRlWizqhe7NyKwi9oRnMusUMjoZuN6k8xg?=
 =?us-ascii?q?HXrnZHdOhbxH1kLk+Xkxrg+8u85pFu/zletv4768JMTaD2dLkkQLJFCzgrL3?=
 =?us-ascii?q?o779DxuxnZSguP6HocUmEInRdNHgPI8hL0UIrvvyXjruZy1zWUMsPwTbAvRD?=
 =?us-ascii?q?St9LxrRwPyiCcGLDE27mfagdFtga1BoRKhoxt/w5PIYIyQKfFzcL/Rcc8cSG?=
 =?us-ascii?q?FcRctaSTBPDZ2gYIsOF+oBPPhXr4/hp1sVsBCyARCgCP7zxjNUg3P726M10/?=
 =?us-ascii?q?4lEQrbwgIuGdwAu2nQoNnsKqsfVeW5wa/VxjvBcvxWwy/w5pXWfBAvof+CXr?=
 =?us-ascii?q?x+fsTexkYtCwzLgU6dqZDnMj6PyugBr2aW4uhmWOmyi2AnsQZxoj23y8kxlo?=
 =?us-ascii?q?nGmJoVylDa+iV/3Y07ONi4R1R/Yd6gDpRRtzyROoxtQsw/WGFlozo6y70atp?=
 =?us-ascii?q?67eygG0pInxwXFZPCdfIiI5QzjWf+XLDxlh3xlYKqyiwu9/EWv0OHxVtS43E?=
 =?us-ascii?q?xUoidKjNXArG0B2hrO4cadUPR95F2u2TOX2gDW7eFLPF47mLLAK54k3r4wjp?=
 =?us-ascii?q?0TsVnfHiPumEX5kquWdkI89+i08evneLTmpoKHN4NuiwH+NKoumsukAesmLg?=
 =?us-ascii?q?cCRXSb+OSg273j+k31WrNKgeEtkqbFqpzaIMUbpqqhDw9U1IYs9Qq/Ai+73N?=
 =?us-ascii?q?kXknQLNlJIdA+dg4T3NFzCPur0Aeqnj1SpijhrxvTGPrP7ApXKK3jOiKzhcq?=
 =?us-ascii?q?tm60NH1AoyzcxQ55JTCr0bJvLzQVX+uMbXDh8+LQy42/znB8ll1oMCRWKPBb?=
 =?us-ascii?q?eUP7/Ivl+T+O0uI/KBZJQJtzb9Mfcl+vDujXsnll8HZKWmwYEYZGqkEfRhJk?=
 =?us-ascii?q?WTeWDsjcsZEWcWogo+S/Tnh0GYXj5IeXmzX7gw5ionB4KmF4jDW46tgLif0y?=
 =?us-ascii?q?ehBZBWZ2ZGCkySHnfsbYmLR/AMaCeKKM97jjMETaShS5Mm1Ry2tg/6zr1nLv?=
 =?us-ascii?q?DO+i0ZrpLuz9516PfWlR4s9Dx4FcOd03uCT2tshGMHWyc23LxjoUx60lqD1a?=
 =?us-ascii?q?l4g/pFFd1c/v9JSRk1OoLBz+xgCtDyRgLAcs6MSFahX9qmHDUxQcwqzt8QbE?=
 =?us-ascii?q?ZyBc+iggrA3yW0Gb8VkaKEBJgu/qLbxXjxKN53y2za26k5k1kmXsxPOHW9hq?=
 =?us-ascii?q?Fh8wjTBojJk1iWlquxa6Qc0zDC9H2ZwWqNok5YSghwXrvBXXwFYUvWt9v57F?=
 =?us-ascii?q?vYT7CyEbQnLhdBycmaJ6tJdNLmk05GS+vkONTZYGK8gHu/BRaSxrOLaYrqen?=
 =?us-ascii?q?gd3CDHBEgDiQAT8m6MNRIiCSe5v2LeEDtuGErtY0Pr8el+rmm3Tk0zzwGKdU?=
 =?us-ascii?q?Jh0aG19QAThfGHV/wcxLQEuCAnqzV1AFmyxdbWB8CcqApmeaVWeck970tf1W?=
 =?us-ascii?q?LFqwx9OYStL7h8iV4YfAR3okLu1xNuBoVDj8cqtnUqwxR2Ka+D0VNNbjeY3Z?=
 =?us-ascii?q?fuOrLJMGXy5wqga63L2lHEytma4KEP5+oip1XhpAGjDlAi/Gl/09lJz3uc4Y?=
 =?us-ascii?q?3HDBIIXpLsVkY67AB6qKvHYik5/o/U0HpsMa6usjDcwd4mGOwlyhPzN+tYZY?=
 =?us-ascii?q?iNDwLjW/YRB8GzJugngRD9ZRsfMfF676U0Nt6oc/acnaWieu1nmWTixW9O+4?=
 =?us-ascii?q?1slFmH9yNhROrFxb4Exe2V2k2MUDK4xFWktdrtmJtsYzgXE2v5zjLrQMZVZ6?=
 =?us-ascii?q?tvbcMQBGyzOcyr15B7gJLwX3Nw6lGuHRUF1dWvdB7UaEbymUVL2EAWp2G3sT?=
 =?us-ascii?q?W3wiYykDwzqKebmivUzLfMbh0Cb1VXSXFigFGkGo29i9QXTQD8dAQyvAe07k?=
 =?us-ascii?q?b9ga5AreJwKHeFEhQARDT/M2w3Cvj4jbGFecMarcpy4Cg=3D?=
X-IPAS-Result: =?us-ascii?q?A2BrAgDP/Spe/wHyM5BlHAEBAQEBBwEBEQEEBAEBgXuBf?=
 =?us-ascii?q?YFtIBIqhBKJA4Z3BoE3iW+KJYckCQEBAQEBAQEBATcBAYRAAoJGOBMCEAEBA?=
 =?us-ascii?q?QQBAQEBAQUDAQFshUOCOykBgnoBBSMEEUEQCxgCAiYCAlcGAQwGAgEBgmM/g?=
 =?us-ascii?q?lclrQB/M4VKgzGBPoEOKowxeYEHgREnD4JdPodZgl4EllNhRpdegkOCTJNlB?=
 =?us-ascii?q?huafC2OM50eIoFYKwgCGAghDzuCbFAYDYgNF45BIwMwjHdfAQE?=
Received: from tarius.tycho.ncsc.mil (HELO tarius.infosec.tycho.ncsc.mil) ([144.51.242.1])
  by EMSM-GH1-UEA10.NCSC.MIL with ESMTP; 24 Jan 2020 14:28:58 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.infosec.tycho.ncsc.mil (8.14.7/8.14.4) with ESMTP id 00OESC5D238741;
        Fri, 24 Jan 2020 09:28:15 -0500
Subject: Re: [PATCH v14 06/23] Use lsmblob in security_secctx_to_secid
To:     Casey Schaufler <casey@schaufler-ca.com>,
        casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com
References: <20200124002306.3552-1-casey@schaufler-ca.com>
 <20200124002306.3552-7-casey@schaufler-ca.com>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <79e2f4d8-ea0a-b255-8b07-258a6d8da673@tycho.nsa.gov>
Date:   Fri, 24 Jan 2020 09:29:49 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <20200124002306.3552-7-casey@schaufler-ca.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 1/23/20 7:22 PM, Casey Schaufler wrote:
> Change security_secctx_to_secid() to fill in a lsmblob instead
> of a u32 secid. Multiple LSMs may be able to interpret the
> string, and this allows for setting whichever secid is
> appropriate. In some cases there is scaffolding where other
> interfaces have yet to be converted.
> 
> Reviewed-by: Kees Cook <keescook@chromium.org>
> Reviewed-by: John Johansen <john.johansen@canonical.com>
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>

I acked v13 of this patch and don't see any real change here, so:
Acked-by: Stephen Smalley <sds@tycho.nsa.gov>

> ---
>   include/linux/security.h          |  5 +++--
>   kernel/cred.c                     |  4 +---
>   net/netfilter/nft_meta.c          | 12 +++++++-----
>   net/netfilter/xt_SECMARK.c        |  5 ++++-
>   net/netlabel/netlabel_unlabeled.c | 14 ++++++++------
>   security/security.c               | 18 +++++++++++++++---
>   6 files changed, 38 insertions(+), 20 deletions(-)
> 
> diff --git a/include/linux/security.h b/include/linux/security.h
> index e53ff7eebcc5..5ad7cc8abd55 100644
> --- a/include/linux/security.h
> +++ b/include/linux/security.h
> @@ -496,7 +496,8 @@ int security_setprocattr(const char *lsm, const char *name, void *value,
>   int security_netlink_send(struct sock *sk, struct sk_buff *skb);
>   int security_ismaclabel(const char *name);
>   int security_secid_to_secctx(u32 secid, char **secdata, u32 *seclen);
> -int security_secctx_to_secid(const char *secdata, u32 seclen, u32 *secid);
> +int security_secctx_to_secid(const char *secdata, u32 seclen,
> +			     struct lsmblob *blob);
>   void security_release_secctx(char *secdata, u32 seclen);
>   void security_inode_invalidate_secctx(struct inode *inode);
>   int security_inode_notifysecctx(struct inode *inode, void *ctx, u32 ctxlen);
> @@ -1302,7 +1303,7 @@ static inline int security_secid_to_secctx(u32 secid, char **secdata, u32 *secle
>   
>   static inline int security_secctx_to_secid(const char *secdata,
>   					   u32 seclen,
> -					   u32 *secid)
> +					   struct lsmblob *blob)
>   {
>   	return -EOPNOTSUPP;
>   }
> diff --git a/kernel/cred.c b/kernel/cred.c
> index 490d72825aa5..b41c2bbd357f 100644
> --- a/kernel/cred.c
> +++ b/kernel/cred.c
> @@ -756,14 +756,12 @@ EXPORT_SYMBOL(set_security_override);
>   int set_security_override_from_ctx(struct cred *new, const char *secctx)
>   {
>   	struct lsmblob blob;
> -	u32 secid;
>   	int ret;
>   
> -	ret = security_secctx_to_secid(secctx, strlen(secctx), &secid);
> +	ret = security_secctx_to_secid(secctx, strlen(secctx), &blob);
>   	if (ret < 0)
>   		return ret;
>   
> -	lsmblob_init(&blob, secid);
>   	return set_security_override(new, &blob);
>   }
>   EXPORT_SYMBOL(set_security_override_from_ctx);
> diff --git a/net/netfilter/nft_meta.c b/net/netfilter/nft_meta.c
> index 9740b554fdb3..259c78d2f371 100644
> --- a/net/netfilter/nft_meta.c
> +++ b/net/netfilter/nft_meta.c
> @@ -625,21 +625,23 @@ static const struct nla_policy nft_secmark_policy[NFTA_SECMARK_MAX + 1] = {
>   
>   static int nft_secmark_compute_secid(struct nft_secmark *priv)
>   {
> -	u32 tmp_secid = 0;
> +	struct lsmblob blob;
>   	int err;
>   
> -	err = security_secctx_to_secid(priv->ctx, strlen(priv->ctx), &tmp_secid);
> +	err = security_secctx_to_secid(priv->ctx, strlen(priv->ctx), &blob);
>   	if (err)
>   		return err;
>   
> -	if (!tmp_secid)
> +	if (!lsmblob_is_set(&blob))
>   		return -ENOENT;
>   
> -	err = security_secmark_relabel_packet(tmp_secid);
> +	/* Using le[0] is scaffolding */
> +	err = security_secmark_relabel_packet(blob.secid[0]);
>   	if (err)
>   		return err;
>   
> -	priv->secid = tmp_secid;
> +	/* Using le[0] is scaffolding */
> +	priv->secid = blob.secid[0];
>   	return 0;
>   }
>   
> diff --git a/net/netfilter/xt_SECMARK.c b/net/netfilter/xt_SECMARK.c
> index 2317721f3ecb..2d68416b4552 100644
> --- a/net/netfilter/xt_SECMARK.c
> +++ b/net/netfilter/xt_SECMARK.c
> @@ -45,13 +45,14 @@ secmark_tg(struct sk_buff *skb, const struct xt_action_param *par)
>   
>   static int checkentry_lsm(struct xt_secmark_target_info *info)
>   {
> +	struct lsmblob blob;
>   	int err;
>   
>   	info->secctx[SECMARK_SECCTX_MAX - 1] = '\0';
>   	info->secid = 0;
>   
>   	err = security_secctx_to_secid(info->secctx, strlen(info->secctx),
> -				       &info->secid);
> +				       &blob);
>   	if (err) {
>   		if (err == -EINVAL)
>   			pr_info_ratelimited("invalid security context \'%s\'\n",
> @@ -59,6 +60,8 @@ static int checkentry_lsm(struct xt_secmark_target_info *info)
>   		return err;
>   	}
>   
> +	/* scaffolding during the transition */
> +	info->secid = blob.secid[0];
>   	if (!info->secid) {
>   		pr_info_ratelimited("unable to map security context \'%s\'\n",
>   				    info->secctx);
> diff --git a/net/netlabel/netlabel_unlabeled.c b/net/netlabel/netlabel_unlabeled.c
> index d2e4ab8d1cb1..7a5a87f15736 100644
> --- a/net/netlabel/netlabel_unlabeled.c
> +++ b/net/netlabel/netlabel_unlabeled.c
> @@ -881,7 +881,7 @@ static int netlbl_unlabel_staticadd(struct sk_buff *skb,
>   	void *addr;
>   	void *mask;
>   	u32 addr_len;
> -	u32 secid;
> +	struct lsmblob blob;
>   	struct netlbl_audit audit_info;
>   
>   	/* Don't allow users to add both IPv4 and IPv6 addresses for a
> @@ -905,12 +905,13 @@ static int netlbl_unlabel_staticadd(struct sk_buff *skb,
>   	ret_val = security_secctx_to_secid(
>   		                  nla_data(info->attrs[NLBL_UNLABEL_A_SECCTX]),
>   				  nla_len(info->attrs[NLBL_UNLABEL_A_SECCTX]),
> -				  &secid);
> +				  &blob);
>   	if (ret_val != 0)
>   		return ret_val;
>   
> +	/* scaffolding with the [0] */
>   	return netlbl_unlhsh_add(&init_net,
> -				 dev_name, addr, mask, addr_len, secid,
> +				 dev_name, addr, mask, addr_len, blob.secid[0],
>   				 &audit_info);
>   }
>   
> @@ -932,7 +933,7 @@ static int netlbl_unlabel_staticadddef(struct sk_buff *skb,
>   	void *addr;
>   	void *mask;
>   	u32 addr_len;
> -	u32 secid;
> +	struct lsmblob blob;
>   	struct netlbl_audit audit_info;
>   
>   	/* Don't allow users to add both IPv4 and IPv6 addresses for a
> @@ -954,12 +955,13 @@ static int netlbl_unlabel_staticadddef(struct sk_buff *skb,
>   	ret_val = security_secctx_to_secid(
>   		                  nla_data(info->attrs[NLBL_UNLABEL_A_SECCTX]),
>   				  nla_len(info->attrs[NLBL_UNLABEL_A_SECCTX]),
> -				  &secid);
> +				  &blob);
>   	if (ret_val != 0)
>   		return ret_val;
>   
> +	/* scaffolding with the [0] */
>   	return netlbl_unlhsh_add(&init_net,
> -				 NULL, addr, mask, addr_len, secid,
> +				 NULL, addr, mask, addr_len, blob.secid[0],
>   				 &audit_info);
>   }
>   
> diff --git a/security/security.c b/security/security.c
> index b7404bfc8938..c722cd495517 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -1970,10 +1970,22 @@ int security_secid_to_secctx(u32 secid, char **secdata, u32 *seclen)
>   }
>   EXPORT_SYMBOL(security_secid_to_secctx);
>   
> -int security_secctx_to_secid(const char *secdata, u32 seclen, u32 *secid)
> +int security_secctx_to_secid(const char *secdata, u32 seclen,
> +			     struct lsmblob *blob)
>   {
> -	*secid = 0;
> -	return call_int_hook(secctx_to_secid, 0, secdata, seclen, secid);
> +	struct security_hook_list *hp;
> +	int rc;
> +
> +	lsmblob_init(blob, 0);
> +	hlist_for_each_entry(hp, &security_hook_heads.secctx_to_secid, list) {
> +		if (WARN_ON(hp->lsmid->slot < 0 || hp->lsmid->slot >= lsm_slot))
> +			continue;
> +		rc = hp->hook.secctx_to_secid(secdata, seclen,
> +					      &blob->secid[hp->lsmid->slot]);
> +		if (rc != 0)
> +			return rc;
> +	}
> +	return 0;
>   }
>   EXPORT_SYMBOL(security_secctx_to_secid);
>   
> 

