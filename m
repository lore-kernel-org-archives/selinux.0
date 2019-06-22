Return-Path: <SRS0=BI9l=UV=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E42DBC43613
	for <selinux@archiver.kernel.org>; Sat, 22 Jun 2019 22:57:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B846F2073F
	for <selinux@archiver.kernel.org>; Sat, 22 Jun 2019 22:57:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Jegslib+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726317AbfFVW5M (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sat, 22 Jun 2019 18:57:12 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:42962 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726296AbfFVW5M (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sat, 22 Jun 2019 18:57:12 -0400
Received: by mail-pg1-f195.google.com with SMTP id l19so5074590pgh.9
        for <selinux@vger.kernel.org>; Sat, 22 Jun 2019 15:57:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=sqha2utqvS7jEDuaSANIP+IQgbDijQvpcyiultNgG4c=;
        b=Jegslib++7gU5iwNNP993QtdTa1uzkEdA8m1R1sXVnvaNqaPDh/aws9sAP6TOpsCFW
         Uf5Ry8f9wgGpWsBWjpjlRGrJJ3iy4lPEl1d0EI3+HXX41s+N9jF2p+TX1hgsV0u8y9Z9
         HttKqK/eK5N1IwZ21+5+UUXDVvBswQbiGFJLE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=sqha2utqvS7jEDuaSANIP+IQgbDijQvpcyiultNgG4c=;
        b=m3yTAda1HqgCVYgsaNhhiSPDNIIu+bkkFtHWcsJs5JbdrxQnvDPfyidcyn+Zkc/75S
         8YDa5ovPRDSSZDPhkfgYPzz4qaVFWvC2PWGR8xRby7ygy7FlRtsIYYJLPwwYs6cYdy4x
         TlqHahETfc0N+lLir9evM3CcPac9sXeHkoFnl7th17CaUFa5H7V3w9PGW+6Z+KBU4TbS
         ivsPev1OWCN+7tSDNu1UUfkP2hRgOQ/Jz4FbENavGykeOjHD5hz+dSmVu1RqFIuqmy9r
         uDJrAPLWJJL/aedp29yCx7K4mWG7+aRogbLxTOVefwkiIwgVjwVGLWT+8FPOkRAlbVmw
         aVxQ==
X-Gm-Message-State: APjAAAW1EpCtBGG9gD0ZxZ6Mieb172/KVi6uxfdsGpUd7LHSbHNR8Kcm
        ZFL5bg0BovSScvU2jv6txWmx0g==
X-Google-Smtp-Source: APXvYqzqRu98gAacIS5qmRffSqqC6N4yBzw8By5aYqJxNHHiKkyKGJ/h2SuY3r/FjkGD9zJpsYTFag==
X-Received: by 2002:a17:90a:3724:: with SMTP id u33mr15191894pjb.19.1561244231772;
        Sat, 22 Jun 2019 15:57:11 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id k8sm7143780pfk.177.2019.06.22.15.57.10
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 22 Jun 2019 15:57:11 -0700 (PDT)
Date:   Sat, 22 Jun 2019 15:57:10 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        paul@paul-moore.com, sds@tycho.nsa.gov
Subject: Re: [PATCH v3 20/24] LSM: security_secid_to_secctx in netlink
 netfilter
Message-ID: <201906221557.C043141@keescook>
References: <20190621185233.6766-1-casey@schaufler-ca.com>
 <20190621185233.6766-21-casey@schaufler-ca.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190621185233.6766-21-casey@schaufler-ca.com>
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Jun 21, 2019 at 11:52:29AM -0700, Casey Schaufler wrote:
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
