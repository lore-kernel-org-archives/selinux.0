Return-Path: <SRS0=BI9l=UV=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A093C43613
	for <selinux@archiver.kernel.org>; Sat, 22 Jun 2019 22:44:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 538112084E
	for <selinux@archiver.kernel.org>; Sat, 22 Jun 2019 22:44:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="iP3/oVhT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726372AbfFVWoQ (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sat, 22 Jun 2019 18:44:16 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:33007 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726417AbfFVWoQ (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sat, 22 Jun 2019 18:44:16 -0400
Received: by mail-pf1-f193.google.com with SMTP id x15so5405717pfq.0
        for <selinux@vger.kernel.org>; Sat, 22 Jun 2019 15:44:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=8iXFFkbGb5LLc6uCuGSZQDnLRw/GfZOd9DZnbDJJW+8=;
        b=iP3/oVhTWbXJwvOepRvIlLAOfL02XOwGb5v7J7zT3Er+NngBEuxq/WDu3FEs0q9/NO
         bgl4eyn1wEc11gqf55SzmBLQUcGWuNinP6d6WgGrDboPASYE1f6QdexGVoDOEeBnn5ln
         ARAC8vu1wU2TLUYkdZTuxZW7mlVyGXQ8C/u9Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=8iXFFkbGb5LLc6uCuGSZQDnLRw/GfZOd9DZnbDJJW+8=;
        b=l/Wah1EuH1QvLugcGzH7omuooHm7lw8ybDydij8hFwrfKsP2B2COvUywcn5ipgS/kg
         Zt4hR/rNIaqnjdNZjuWpOgxEbEYcf2zXZWF7enJkbgY/rby19YPLHBAy44qAcD71kOFD
         NpKDJ92lu6A7AledbqdqqEAd4a3HVlYgai/JfNqJbTNgmdhdWhH238WI/WQ0zV5n1bKF
         Zg4uv4GYB9G98qSqan02VPe8PBc4PXE1r7VkXApt4v6g8qY3mKJHlzbhQUC6h8+jo7PM
         lOsan/42iO+OWoaiyQ22uJ0F4YeTRZW36aviJxEJMzndEb8ISsLJSvhKpGmVA5ZWezUh
         EnNw==
X-Gm-Message-State: APjAAAXBwT/4ZyzHssMKQweSZDZFlHHHhedGFuKVXhE7rrPl19us6AOn
        +savgKydi9LoY1WndVXuH8PgyGmeQ1U=
X-Google-Smtp-Source: APXvYqz2vvt4nUlGh8uiwpxD3gKjH1NTPqADtfSHZ7lTyjWCu1OZcoHtUy7/sISndD+7n7lqryd/jA==
X-Received: by 2002:a65:5c88:: with SMTP id a8mr7676872pgt.388.1561243455801;
        Sat, 22 Jun 2019 15:44:15 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id u10sm3186149pfh.54.2019.06.22.15.44.14
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 22 Jun 2019 15:44:15 -0700 (PDT)
Date:   Sat, 22 Jun 2019 15:44:14 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        paul@paul-moore.com, sds@tycho.nsa.gov
Subject: Re: [PATCH v3 08/24] LSM: Use lsmblob in security_secctx_to_secid
Message-ID: <201906221544.8F71D60A@keescook>
References: <20190621185233.6766-1-casey@schaufler-ca.com>
 <20190621185233.6766-9-casey@schaufler-ca.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190621185233.6766-9-casey@schaufler-ca.com>
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Jun 21, 2019 at 11:52:17AM -0700, Casey Schaufler wrote:
> Change security_secctx_to_secid() to fill in a lsmblob instead
> of a u32 secid. Multiple LSMs may be able to interpret the
> string, and this allows for setting whichever secid is
> appropriate. In some cases there is scaffolding where other
> interfaces have yet to be converted.
> 
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

> ---
>  include/linux/security.h          |  5 +++--
>  kernel/cred.c                     |  4 +---
>  net/netfilter/nft_meta.c          | 13 ++++++-------
>  net/netfilter/xt_SECMARK.c        |  5 ++++-
>  net/netlabel/netlabel_unlabeled.c | 14 ++++++++------
>  security/security.c               | 16 +++++++++++++---
>  6 files changed, 35 insertions(+), 22 deletions(-)
> 
> diff --git a/include/linux/security.h b/include/linux/security.h
> index 905830a90745..b0395d224c43 100644
> --- a/include/linux/security.h
> +++ b/include/linux/security.h
> @@ -443,7 +443,8 @@ int security_setprocattr(const char *lsm, const char *name, void *value,
>  int security_netlink_send(struct sock *sk, struct sk_buff *skb);
>  int security_ismaclabel(const char *name);
>  int security_secid_to_secctx(u32 secid, char **secdata, u32 *seclen);
> -int security_secctx_to_secid(const char *secdata, u32 seclen, u32 *secid);
> +int security_secctx_to_secid(const char *secdata, u32 seclen,
> +			     struct lsmblob *blob);
>  void security_release_secctx(char *secdata, u32 seclen);
>  
>  void security_inode_invalidate_secctx(struct inode *inode);
> @@ -1226,7 +1227,7 @@ static inline int security_secid_to_secctx(u32 secid, char **secdata, u32 *secle
>  
>  static inline int security_secctx_to_secid(const char *secdata,
>  					   u32 seclen,
> -					   u32 *secid)
> +					   struct lsmblob *blob)
>  {
>  	return -EOPNOTSUPP;
>  }
> diff --git a/kernel/cred.c b/kernel/cred.c
> index 71c14dda107e..d70a2c02ced4 100644
> --- a/kernel/cred.c
> +++ b/kernel/cred.c
> @@ -725,14 +725,12 @@ EXPORT_SYMBOL(set_security_override);
>  int set_security_override_from_ctx(struct cred *new, const char *secctx)
>  {
>  	struct lsmblob blob;
> -	u32 secid;
>  	int ret;
>  
> -	ret = security_secctx_to_secid(secctx, strlen(secctx), &secid);
> +	ret = security_secctx_to_secid(secctx, strlen(secctx), &blob);
>  	if (ret < 0)
>  		return ret;
>  
> -	lsmblob_init(&blob, secid);
>  	return set_security_override(new, &blob);
>  }
>  EXPORT_SYMBOL(set_security_override_from_ctx);
> diff --git a/net/netfilter/nft_meta.c b/net/netfilter/nft_meta.c
> index 987d2d6ce624..91973d3a5f6a 100644
> --- a/net/netfilter/nft_meta.c
> +++ b/net/netfilter/nft_meta.c
> @@ -576,21 +576,20 @@ static const struct nla_policy nft_secmark_policy[NFTA_SECMARK_MAX + 1] = {
>  
>  static int nft_secmark_compute_secid(struct nft_secmark *priv)
>  {
> -	u32 tmp_secid = 0;
> +	struct lsmblob blob;
>  	int err;
>  
> -	err = security_secctx_to_secid(priv->ctx, strlen(priv->ctx), &tmp_secid);
> +	err = security_secctx_to_secid(priv->ctx, strlen(priv->ctx), &blob);
>  	if (err)
>  		return err;
>  
> -	if (!tmp_secid)
> -		return -ENOENT;
> -
> -	err = security_secmark_relabel_packet(tmp_secid);
> +	/* Using le[0] is scaffolding */
> +	err = security_secmark_relabel_packet(blob.secid[0]);
>  	if (err)
>  		return err;
>  
> -	priv->secid = tmp_secid;
> +	/* Using le[1] is scaffolding */
> +	priv->secid = blob.secid[0];
>  	return 0;
>  }
>  
> diff --git a/net/netfilter/xt_SECMARK.c b/net/netfilter/xt_SECMARK.c
> index f16202d26c20..8081fadc30e9 100644
> --- a/net/netfilter/xt_SECMARK.c
> +++ b/net/netfilter/xt_SECMARK.c
> @@ -49,13 +49,14 @@ secmark_tg(struct sk_buff *skb, const struct xt_action_param *par)
>  
>  static int checkentry_lsm(struct xt_secmark_target_info *info)
>  {
> +	struct lsmblob blob;
>  	int err;
>  
>  	info->secctx[SECMARK_SECCTX_MAX - 1] = '\0';
>  	info->secid = 0;
>  
>  	err = security_secctx_to_secid(info->secctx, strlen(info->secctx),
> -				       &info->secid);
> +				       &blob);
>  	if (err) {
>  		if (err == -EINVAL)
>  			pr_info_ratelimited("invalid security context \'%s\'\n",
> @@ -63,6 +64,8 @@ static int checkentry_lsm(struct xt_secmark_target_info *info)
>  		return err;
>  	}
>  
> +	/* scaffolding during the transition */
> +	info->secid = blob.secid[0];
>  	if (!info->secid) {
>  		pr_info_ratelimited("unable to map security context \'%s\'\n",
>  				    info->secctx);
> diff --git a/net/netlabel/netlabel_unlabeled.c b/net/netlabel/netlabel_unlabeled.c
> index c92894c3e40a..2976370e41aa 100644
> --- a/net/netlabel/netlabel_unlabeled.c
> +++ b/net/netlabel/netlabel_unlabeled.c
> @@ -895,7 +895,7 @@ static int netlbl_unlabel_staticadd(struct sk_buff *skb,
>  	void *addr;
>  	void *mask;
>  	u32 addr_len;
> -	u32 secid;
> +	struct lsmblob blob;
>  	struct netlbl_audit audit_info;
>  
>  	/* Don't allow users to add both IPv4 and IPv6 addresses for a
> @@ -919,12 +919,13 @@ static int netlbl_unlabel_staticadd(struct sk_buff *skb,
>  	ret_val = security_secctx_to_secid(
>  		                  nla_data(info->attrs[NLBL_UNLABEL_A_SECCTX]),
>  				  nla_len(info->attrs[NLBL_UNLABEL_A_SECCTX]),
> -				  &secid);
> +				  &blob);
>  	if (ret_val != 0)
>  		return ret_val;
>  
> +	/* scaffolding with the [0] */
>  	return netlbl_unlhsh_add(&init_net,
> -				 dev_name, addr, mask, addr_len, secid,
> +				 dev_name, addr, mask, addr_len, blob.secid[0],
>  				 &audit_info);
>  }
>  
> @@ -946,7 +947,7 @@ static int netlbl_unlabel_staticadddef(struct sk_buff *skb,
>  	void *addr;
>  	void *mask;
>  	u32 addr_len;
> -	u32 secid;
> +	struct lsmblob blob;
>  	struct netlbl_audit audit_info;
>  
>  	/* Don't allow users to add both IPv4 and IPv6 addresses for a
> @@ -968,12 +969,13 @@ static int netlbl_unlabel_staticadddef(struct sk_buff *skb,
>  	ret_val = security_secctx_to_secid(
>  		                  nla_data(info->attrs[NLBL_UNLABEL_A_SECCTX]),
>  				  nla_len(info->attrs[NLBL_UNLABEL_A_SECCTX]),
> -				  &secid);
> +				  &blob);
>  	if (ret_val != 0)
>  		return ret_val;
>  
> +	/* scaffolding with the [0] */
>  	return netlbl_unlhsh_add(&init_net,
> -				 NULL, addr, mask, addr_len, secid,
> +				 NULL, addr, mask, addr_len, blob.secid[0],
>  				 &audit_info);
>  }
>  
> diff --git a/security/security.c b/security/security.c
> index c7b3d1a294ad..cb1545bfe8c5 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -1999,10 +1999,20 @@ int security_secid_to_secctx(u32 secid, char **secdata, u32 *seclen)
>  }
>  EXPORT_SYMBOL(security_secid_to_secctx);
>  
> -int security_secctx_to_secid(const char *secdata, u32 seclen, u32 *secid)
> +int security_secctx_to_secid(const char *secdata, u32 seclen,
> +			     struct lsmblob *blob)
>  {
> -	*secid = 0;
> -	return call_int_hook(secctx_to_secid, 0, secdata, seclen, secid);
> +	struct security_hook_list *hp;
> +	int rc;
> +
> +	lsmblob_init(blob, 0);
> +	hlist_for_each_entry(hp, &security_hook_heads.secctx_to_secid, list) {
> +		rc = hp->hook.secctx_to_secid(secdata, seclen,
> +					      &blob->secid[hp->slot]);
> +		if (rc != 0)
> +			return rc;
> +	}
> +	return 0;
>  }
>  EXPORT_SYMBOL(security_secctx_to_secid);
>  
> -- 
> 2.20.1
> 

-- 
Kees Cook
