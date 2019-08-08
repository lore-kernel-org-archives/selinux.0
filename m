Return-Path: <SRS0=xPDW=WE=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F29C9C433FF
	for <selinux@archiver.kernel.org>; Thu,  8 Aug 2019 22:21:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8A132173C
	for <selinux@archiver.kernel.org>; Thu,  8 Aug 2019 22:21:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="NyasiYkV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404591AbfHHWV3 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 8 Aug 2019 18:21:29 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:34354 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404581AbfHHWV3 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 8 Aug 2019 18:21:29 -0400
Received: by mail-pf1-f193.google.com with SMTP id b13so44877485pfo.1
        for <selinux@vger.kernel.org>; Thu, 08 Aug 2019 15:21:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ZyGhNN0X1Q0Mj5Hdov7MUkoLP4RbgJ6Zp2CTsrgyij0=;
        b=NyasiYkVZaN+yrLZaSm+9Qd4n9rLb1oMMDe/NCuMkKzIvFThAcWo9gIoivpHwnjFU9
         b8oapIw+sVFpdgH744nnoYoyxfX7lzOmT4Z12x4/XiqI18jMQ3bG7Q00XSPs8lwvb79s
         A6+EwU6kokHsMfiT+2YCZwvFydBtkIBZgFzdI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ZyGhNN0X1Q0Mj5Hdov7MUkoLP4RbgJ6Zp2CTsrgyij0=;
        b=XGaX30knxv1tojpQWqt587CJBNtyNbXo67FYHm+QnmKuzh6HsRfMN1547i/cCPr88v
         UFM/4FCyYi23SZZz6gslT5ZSSTbg3oqBzQESk2yOgayyoP4i20hnjn9rAJ8EopaoGqtB
         PkHgtZsI6pfougYQsRKuqIpDSQmGK1B/gSh64ur8d9TSJvAL8dYBmfo+pEWFPjiOFepi
         whMVi2xBvQ9BVfflhdehHtNvhOlxSCBKkmr32HmemuEpSvykhjHEWvnEdUcugGs3NrWs
         OP99dAGR5WiEYZ3HgedtvPWFuNyplj+XxcyEeay7lBm8s0/1+MYWuPofLE/Nv5o9Ri05
         rORA==
X-Gm-Message-State: APjAAAXMJp0goDZyPDS3oUihJvGSb9I9RoEJAPowSAWnVKG/sjk6nvUl
        r/2GR0gWvf85ZVx3NOj7io8trQ==
X-Google-Smtp-Source: APXvYqxvMXKreEGqcbXWZc/Q+zPsxM/8+BDB15laoxtl1UQso7oWzbBcOEkEv0z7Ixxna1qkkpwg+g==
X-Received: by 2002:a65:5cca:: with SMTP id b10mr15066799pgt.365.1565302887904;
        Thu, 08 Aug 2019 15:21:27 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id u16sm3489768pjb.2.2019.08.08.15.21.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 08 Aug 2019 15:21:27 -0700 (PDT)
Date:   Thu, 8 Aug 2019 15:21:26 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        paul@paul-moore.com, sds@tycho.nsa.gov
Subject: Re: [PATCH v7 26/28] NET: Add SO_PEERCONTEXT for multiple LSMs
Message-ID: <201908081500.992E5330@keescook>
References: <20190807194410.9762-1-casey@schaufler-ca.com>
 <20190807194410.9762-27-casey@schaufler-ca.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190807194410.9762-27-casey@schaufler-ca.com>
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Aug 07, 2019 at 12:44:08PM -0700, Casey Schaufler wrote:
> The getsockopt SO_PEERSEC provides the LSM based security
> information for a single module, but for reasons of backward
> compatibility cannot include the information for multiple
> modules. A new option SO_PEERCONTEXT is added to report the
> security "context" of multiple modules using a "compound" format
> 
> 	lsm1\0value\0lsm2\0value\0
> 
> This is expected to be used by system services, including dbus-daemon.
> The exact format of a compound context has been the subject of
> considerable debate. This format was suggested by Simon McVittie,
> a dbus maintainer with a significant stake in the format being
> uasable.
> 
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
> ---
> [...]
> diff --git a/security/security.c b/security/security.c
> index 2f4a430a1126..0ea7ee27e331 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -2117,8 +2117,8 @@ int security_setprocattr(const char *lsm, const char *name, void *value,
>  	hlist_for_each_entry(hp, &security_hook_heads.setprocattr, list) {
>  		if (lsm != NULL && strcmp(lsm, hp->lsmid->lsm))
>  			continue;
> -		if (lsm == NULL && *display != LSMBLOB_INVALID &&
> -		    *display != hp->lsmid->slot)
> +		if (lsm == NULL && display != NULL &&
> +		    *display != LSMBLOB_INVALID && *display != hp->lsmid->slot)
>  			continue;
>  		return hp->hook.setprocattr(name, value, size);
>  	}
> @@ -2342,17 +2342,91 @@ int security_sock_rcv_skb(struct sock *sk, struct sk_buff *skb)
>  EXPORT_SYMBOL(security_sock_rcv_skb);
>  
>  int security_socket_getpeersec_stream(struct socket *sock, char __user *optval,
> -				      int __user *optlen, unsigned len)
> +				      int __user *optlen, unsigned len,
> +				      int display)
>  {
> -	int display = lsm_task_display(current);
>  	struct security_hook_list *hp;
> +	char *final = NULL;
> +	char *cp;
> +	char *tp;
> +	int rc = 0;
> +	unsigned finallen = 0;
> +	unsigned llen;
> +	unsigned clen = 0;
> +	unsigned tlen;

Please move the case-specific variables into the case scope, like (and
expand type names):

	case LSMBLOB_COMPOUND: {
		unsigned int clen ...;

> +
> +	switch (display) {
> +	case LSMBLOB_DISPLAY:
> +		rc = -ENOPROTOOPT;
> +		display = lsm_task_display(current);
> +		hlist_for_each_entry(hp,
> +				&security_hook_heads.socket_getpeersec_stream,
> +				list)
> +			if (display == LSMBLOB_INVALID ||
> +			    display == hp->lsmid->slot) {
> +				rc = hp->hook.socket_getpeersec_stream(sock,
> +							&final, &finallen, len);
> +				break;
> +			}
> +		break;
> +	case LSMBLOB_COMPOUND:
> +		/*
> +		 * A compound context, in the form [lsm\0value\0]...
> +		 */
> +		hlist_for_each_entry(hp,
> +				&security_hook_heads.socket_getpeersec_stream,
> +				list) {
> +			rc = hp->hook.socket_getpeersec_stream(sock, &cp, &clen,
> +							       len);

Is passing "len" here useful at all? It's kind of a lie, but nothing
else wouldn't also be a lie. :)

> +			if (rc == -EINVAL || rc == -ENOPROTOOPT) {
> +				rc = 0;
> +				continue;
> +			}
> +			if (rc) {
> +				kfree(final);
> +				return rc;
> +			}
> +			/*
> +			 * Don't propogate trailing nul bytes.

typo: propagate

> +			 */
> +			clen = strnlen(cp, clen) + 1;
> +			llen = strlen(hp->lsmid->lsm) + 1;
> +			tlen = llen + clen;
> +			if (final)
> +				tlen += finallen;

You can drop the "if (final)" since finallen is initialized to 0.

> +			tp = kzalloc(tlen, GFP_KERNEL);

I'm not a huge fan of "c", "l", and "t" prefixes -- can you just make
these a little more self-documenting? cp and clen could be value and
value_len. llen could be lsm_name_len. tp and tlen could be tuple and
tuple_len. (And maybe final and finallen could be compound and
compound_len?)

> +			if (tp == NULL) {
> +				kfree(cp);
> +				kfree(final);
> +				return -ENOMEM;
> +			}
> +			if (final)
> +				memcpy(tp, final, finallen);
> +			memcpy(tp + finallen, hp->lsmid->lsm, llen);
> +			memcpy(tp + finallen + llen, cp, clen);
> +			kfree(cp);
> +			if (final)
> +				kfree(final);

Just kfree(final) is safe here -- kfree(NULL) is valid.

> +			final = tp;
> +			finallen = tlen;
> +		}
> +		if (final == NULL)
> +			return -EINVAL;
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
>  
> -	hlist_for_each_entry(hp, &security_hook_heads.socket_getpeersec_stream,
> -			     list)
> -		if (display == LSMBLOB_INVALID || display == hp->lsmid->slot)
> -			return hp->hook.socket_getpeersec_stream(sock, optval,
> -								 optlen, len);
> -	return -ENOPROTOOPT;
> +	if (finallen > len)
> +		rc = -ERANGE;
> +	else if (copy_to_user(optval, final, finallen))
> +		rc = -EFAULT;
> +
> +	if (put_user(finallen, optlen))
> +		rc = -EFAULT;
> +
> +	kfree(final);
> +	return rc;
>  }

Otherwise, looks good.

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

>  
>  int security_socket_getpeersec_dgram(struct socket *sock, struct sk_buff *skb,
> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index fcad2e3432d2..5e7d61754798 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -4923,10 +4923,8 @@ static int selinux_socket_sock_rcv_skb(struct sock *sk, struct sk_buff *skb)
>  	return err;
>  }
>  
> -static int selinux_socket_getpeersec_stream(struct socket *sock,
> -					    char __user *optval,
> -					    int __user *optlen,
> -					    unsigned int len)
> +static int selinux_socket_getpeersec_stream(struct socket *sock, char **optval,
> +					    int *optlen, unsigned int len)
>  {
>  	int err = 0;
>  	char *scontext;
> @@ -4946,18 +4944,12 @@ static int selinux_socket_getpeersec_stream(struct socket *sock,
>  	if (err)
>  		return err;
>  
> -	if (scontext_len > len) {
> +	if (scontext_len > len)
>  		err = -ERANGE;
> -		goto out_len;
> -	}
> -
> -	if (copy_to_user(optval, scontext, scontext_len))
> -		err = -EFAULT;
> +	else
> +		*optval = scontext;
>  
> -out_len:
> -	if (put_user(scontext_len, optlen))
> -		err = -EFAULT;
> -	kfree(scontext);
> +	*optlen = scontext_len;
>  	return err;
>  }
>  
> diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
> index 7a30b8692b1e..40c75205a914 100644
> --- a/security/smack/smack_lsm.c
> +++ b/security/smack/smack_lsm.c
> @@ -3919,28 +3919,29 @@ static int smack_socket_sock_rcv_skb(struct sock *sk, struct sk_buff *skb)
>   *
>   * returns zero on success, an error code otherwise
>   */
> -static int smack_socket_getpeersec_stream(struct socket *sock,
> -					  char __user *optval,
> -					  int __user *optlen, unsigned len)
> +static int smack_socket_getpeersec_stream(struct socket *sock, char **optval,
> +					  int *optlen, unsigned len)
>  {
> -	struct socket_smack *ssp;
> -	char *rcp = "";
> -	int slen = 1;
> +	struct socket_smack *ssp = smack_sock(sock->sk);
> +	char *rcp;
> +	int slen;
>  	int rc = 0;
>  
> -	ssp = smack_sock(sock->sk);
> -	if (ssp->smk_packet != NULL) {
> -		rcp = ssp->smk_packet->smk_known;
> -		slen = strlen(rcp) + 1;
> +	if (ssp->smk_packet == NULL) {
> +		*optlen = 0;
> +		return -EINVAL;
>  	}
>  
> +	rcp = ssp->smk_packet->smk_known;
> +	slen = strlen(rcp) + 1;
>  	if (slen > len)
>  		rc = -ERANGE;
> -	else if (copy_to_user(optval, rcp, slen) != 0)
> -		rc = -EFAULT;
> -
> -	if (put_user(slen, optlen) != 0)
> -		rc = -EFAULT;
> +	else {
> +		*optval = kstrdup(rcp, GFP_KERNEL);
> +		if (*optval == NULL)
> +			rc = -ENOMEM;
> +	}
> +	*optlen = slen;
>  
>  	return rc;
>  }
> -- 
> 2.20.1
> 

-- 
Kees Cook
