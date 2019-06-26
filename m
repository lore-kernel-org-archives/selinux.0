Return-Path: <SRS0=8O8t=UZ=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35F50C48BD3
	for <selinux@archiver.kernel.org>; Wed, 26 Jun 2019 23:16:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08A892177B
	for <selinux@archiver.kernel.org>; Wed, 26 Jun 2019 23:16:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ZzR2UPGx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726605AbfFZXQT (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 26 Jun 2019 19:16:19 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:35589 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726572AbfFZXQT (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 26 Jun 2019 19:16:19 -0400
Received: by mail-pl1-f195.google.com with SMTP id w24so175941plp.2
        for <selinux@vger.kernel.org>; Wed, 26 Jun 2019 16:16:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=szPXVqwtG46VZD1dnN7XPQV5ryzfIvwdz59B8Nteh7w=;
        b=ZzR2UPGxmfl1yCdJSoaciRvEZKbFvOOT8EAExPj754V3yzY66UE8u8wlx1zR1iaSvd
         5tz4Us04RwSThuOY2o9CIbOwGYuf9p1XElfICaOxszGdJXeW5IlcHieRZL4prBa00fqa
         mBCTo6rI/JK57w5BGnBSZzxYSFgybG6Y0tuMA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=szPXVqwtG46VZD1dnN7XPQV5ryzfIvwdz59B8Nteh7w=;
        b=p80Ipf91kwUQ0UFaKxKLe3SaTy0aLLsIVUqajIqD+BOMMZvH3C15FXeBi9X9Q5OoOf
         /C1TKooFtcVKzbRJn/3fS2jXS6qvDH5Bzn9Qqy7MI8d+VvSkgi+WbEIgLtyMjxykw4n8
         GbIXibp8PjFCZmZAIWSmDuE+ju29Bbs8ZkaQ+QKczHtvFmaMRQF3/JSZZw9wB25SLOH1
         gs1HAoroiNhG5Y+PlPgjKQa/DLnUYWjKSTpQ+WrsioZZDi5HjrGVeDG2KZ2E5qBH/HYf
         bL1lh6vfmdBqHlbn/8RsJpMxWGylSifEunc5aCD2knhvvP+P+prY2i5bg7HMKNknMW49
         58FQ==
X-Gm-Message-State: APjAAAUQH+U+v5QH6Cw115uVAicJLXWK6OodilYiYGXBDWRDTmVFkEch
        VQpP9TnLPAtdBh2jHynVWJOESA==
X-Google-Smtp-Source: APXvYqzhtW0GZDXk4xB9wbnHkbH9RZJekFlhppZXOUmiZjXS9FARYtM0SKh/ETfxbGLzkhjLSjvi/Q==
X-Received: by 2002:a17:902:7c8e:: with SMTP id y14mr678914pll.298.1561590978974;
        Wed, 26 Jun 2019 16:16:18 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id 25sm316356pfp.76.2019.06.26.16.16.18
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 26 Jun 2019 16:16:18 -0700 (PDT)
Date:   Wed, 26 Jun 2019 16:16:17 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        paul@paul-moore.com, sds@tycho.nsa.gov
Subject: Re: [PATCH v4 20/23] LSM: security_secid_to_secctx in netlink
 netfilter
Message-ID: <201906261616.FB14505D9@keescook>
References: <20190626192234.11725-1-casey@schaufler-ca.com>
 <20190626192234.11725-21-casey@schaufler-ca.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190626192234.11725-21-casey@schaufler-ca.com>
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Jun 26, 2019 at 12:22:31PM -0700, Casey Schaufler wrote:
> Change netlink netfilter interfaces to use lsmcontext
> pointers, and remove scaffolding.
> 
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

> ---
>  net/netfilter/nfnetlink_queue.c | 32 +++++++++++++-------------------
>  1 file changed, 13 insertions(+), 19 deletions(-)
> 
> diff --git a/net/netfilter/nfnetlink_queue.c b/net/netfilter/nfnetlink_queue.c
> index 6da00c7add5b..69efb688383f 100644
> --- a/net/netfilter/nfnetlink_queue.c
> +++ b/net/netfilter/nfnetlink_queue.c
> @@ -305,12 +305,10 @@ static int nfqnl_put_sk_uidgid(struct sk_buff *skb, struct sock *sk)
>  	return -1;
>  }
>  
> -static u32 nfqnl_get_sk_secctx(struct sk_buff *skb, char **secdata)
> +static u32 nfqnl_get_sk_secctx(struct sk_buff *skb, struct lsmcontext *context)
>  {
> -	u32 seclen = 0;
>  #if IS_ENABLED(CONFIG_NETWORK_SECMARK)
>  	struct lsmblob blob;
> -	struct lsmcontext context;
>  
>  	if (!skb || !sk_fullsock(skb->sk))
>  		return 0;
> @@ -318,15 +316,16 @@ static u32 nfqnl_get_sk_secctx(struct sk_buff *skb, char **secdata)
>  	read_lock_bh(&skb->sk->sk_callback_lock);
>  
>  	if (skb->secmark) {
> +		/* Any LSM might be looking for the secmark */
>  		lsmblob_init(&blob, skb->secmark);
> -		security_secid_to_secctx(&blob, &context);
> -		*secdata = context.context;
> +		security_secid_to_secctx(&blob, context);
>  	}
>  
>  	read_unlock_bh(&skb->sk->sk_callback_lock);
> -	seclen = context.len;
> +	return context->len;
> +#else
> +	return 0;
>  #endif
> -	return seclen;
>  }
>  
>  static u32 nfqnl_get_bridge_size(struct nf_queue_entry *entry)
> @@ -402,8 +401,7 @@ nfqnl_build_packet_message(struct net *net, struct nfqnl_instance *queue,
>  	enum ip_conntrack_info uninitialized_var(ctinfo);
>  	struct nfnl_ct_hook *nfnl_ct;
>  	bool csum_verify;
> -	struct lsmcontext scaff; /* scaffolding */
> -	char *secdata = NULL;
> +	struct lsmcontext context;
>  	u32 seclen = 0;
>  
>  	size =    nlmsg_total_size(sizeof(struct nfgenmsg))
> @@ -470,7 +468,7 @@ nfqnl_build_packet_message(struct net *net, struct nfqnl_instance *queue,
>  	}
>  
>  	if ((queue->flags & NFQA_CFG_F_SECCTX) && entskb->sk) {
> -		seclen = nfqnl_get_sk_secctx(entskb, &secdata);
> +		seclen = nfqnl_get_sk_secctx(entskb, &context);
>  		if (seclen)
>  			size += nla_total_size(seclen);
>  	}
> @@ -605,7 +603,7 @@ nfqnl_build_packet_message(struct net *net, struct nfqnl_instance *queue,
>  	    nfqnl_put_sk_uidgid(skb, entskb->sk) < 0)
>  		goto nla_put_failure;
>  
> -	if (seclen && nla_put(skb, NFQA_SECCTX, seclen, secdata))
> +	if (seclen && nla_put(skb, NFQA_SECCTX, context.len, context.context))
>  		goto nla_put_failure;
>  
>  	if (ct && nfnl_ct->build(skb, ct, ctinfo, NFQA_CT, NFQA_CT_INFO) < 0)
> @@ -633,10 +631,8 @@ nfqnl_build_packet_message(struct net *net, struct nfqnl_instance *queue,
>  	}
>  
>  	nlh->nlmsg_len = skb->len;
> -	if (seclen) {
> -		lsmcontext_init(&scaff, secdata, seclen, 0);
> -		security_release_secctx(&scaff);
> -	}
> +	if (seclen)
> +		security_release_secctx(&context);
>  	return skb;
>  
>  nla_put_failure:
> @@ -644,10 +640,8 @@ nfqnl_build_packet_message(struct net *net, struct nfqnl_instance *queue,
>  	kfree_skb(skb);
>  	net_err_ratelimited("nf_queue: error creating packet message\n");
>  nlmsg_failure:
> -	if (seclen) {
> -		lsmcontext_init(&scaff, secdata, seclen, 0);
> -		security_release_secctx(&scaff);
> -	}
> +	if (seclen)
> +		security_release_secctx(&context);
>  	return NULL;
>  }
>  
> -- 
> 2.20.1
> 

-- 
Kees Cook
