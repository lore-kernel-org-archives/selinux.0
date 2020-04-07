Return-Path: <SRS0=OuNA=5X=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8068FC2BA1A
	for <selinux@archiver.kernel.org>; Tue,  7 Apr 2020 18:36:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B26C20768
	for <selinux@archiver.kernel.org>; Tue,  7 Apr 2020 18:36:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="OMuO/BTX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726277AbgDGSga (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 7 Apr 2020 14:36:30 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:36197 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726386AbgDGSga (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 7 Apr 2020 14:36:30 -0400
Received: by mail-pg1-f195.google.com with SMTP id c23so2137662pgj.3
        for <selinux@vger.kernel.org>; Tue, 07 Apr 2020 11:36:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=aHnRL++sQeIzIG4uOoaQVOsp/SJs7CMC+RGF+Q09CSs=;
        b=OMuO/BTXDYhynN9QvrsKfX9BtHHmcfhVAIsVWgx4NV8jQ4XTQFZtx/YZQMId6p3jv9
         TrGo8h518sAuvVecMiPzr5RBvK+B28NCUSrtyAMA1W7k/aWcu7NDm7wsMBIpq28tscX6
         FOlD7ThJfCo1dJmAaC2GIE6QWZ0Z0NpYwsEXA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=aHnRL++sQeIzIG4uOoaQVOsp/SJs7CMC+RGF+Q09CSs=;
        b=eeKrVqmHYQt4PRKBp92mFXsrEArVVS3yv3yRwWZfCYxzw2GD+26CgpeL2x5KmrRBW7
         U/vj1VAr6V+Wtw/huHulBXDaaSkxznOCgm71R0abL8xjoCxj0gRW+2juHMbhWN4EEF5G
         IQg4KkKBcImdvgYijzxpNuoUekkXC9cV2FmEtf6yhW8BmDOplsE36Yzpjtjf6v3mCE9s
         9LxQa8+bgLuBUyum2Nqa1HVyMF5oOmwOjEjoiJLeRt9/DlbPblBWpaSra4prprCsIdZO
         dcnkfAQ69Zm1c+Byfa49J6SYSyYR5jQopZpZ7PkkBNhijrQiqajSrYprZk5Hj8Q3KQb4
         FVbw==
X-Gm-Message-State: AGi0PubE8r/pEEND/XyKt9YGg//ER1pUREm3woZ4tkDM33vXaCdxJyW/
        wK9ckfsYpsVdPuIIjBHoglw35w==
X-Google-Smtp-Source: APiQypLnXrP5UBZa+Ix8QihYZWzGch3sH+UT2i++hPq0fSIx0Me4vkk4P1WotRNKueZeRSDGVNl2ug==
X-Received: by 2002:a62:7a82:: with SMTP id v124mr3693734pfc.10.1586284587788;
        Tue, 07 Apr 2020 11:36:27 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id y207sm14844397pfb.189.2020.04.07.11.36.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2020 11:36:26 -0700 (PDT)
Date:   Tue, 7 Apr 2020 11:36:25 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        paul@paul-moore.com, sds@tycho.nsa.gov, linux-audit@redhat.com
Subject: Re: [PATCH v16 05/23] net: Prepare UDS for security module stacking
Message-ID: <202004071136.02DAD485@keescook>
References: <20200407000159.43602-1-casey@schaufler-ca.com>
 <20200407000159.43602-6-casey@schaufler-ca.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200407000159.43602-6-casey@schaufler-ca.com>
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Apr 06, 2020 at 05:01:41PM -0700, Casey Schaufler wrote:
> Change the data used in UDS SO_PEERSEC processing from a
> secid to a more general struct lsmblob. Update the
> security_socket_getpeersec_dgram() interface to use the
> lsmblob. There is a small amount of scaffolding code
> that will come out when the security_secid_to_secctx()
> code is brought in line with the lsmblob.
> 
> The secid field of the unix_skb_parms structure has been
> replaced with a pointer to an lsmblob structure, and the
> lsmblob is allocated as needed. This is similar to how the
> list of passed files is managed. While an lsmblob structure
> will fit in the available space today, there is no guarantee
> that the addition of other data to the unix_skb_parms or
> support for additional security modules wouldn't exceed what
> is available.
> 
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

> cc: netdev@vger.kernel.org
> ---
>  include/linux/security.h |  7 +++++--
>  include/net/af_unix.h    |  2 +-
>  include/net/scm.h        |  8 +++++---
>  net/ipv4/ip_sockglue.c   |  8 +++++---
>  net/unix/af_unix.c       |  7 ++++---
>  net/unix/scm.c           |  6 ++++++
>  security/security.c      | 18 +++++++++++++++---
>  7 files changed, 41 insertions(+), 15 deletions(-)
> 
> diff --git a/include/linux/security.h b/include/linux/security.h
> index 1bfaf9ece13e..2ad58e2900e7 100644
> --- a/include/linux/security.h
> +++ b/include/linux/security.h
> @@ -1358,7 +1358,8 @@ int security_socket_shutdown(struct socket *sock, int how);
>  int security_sock_rcv_skb(struct sock *sk, struct sk_buff *skb);
>  int security_socket_getpeersec_stream(struct socket *sock, char __user *optval,
>  				      int __user *optlen, unsigned len);
> -int security_socket_getpeersec_dgram(struct socket *sock, struct sk_buff *skb, u32 *secid);
> +int security_socket_getpeersec_dgram(struct socket *sock, struct sk_buff *skb,
> +				     struct lsmblob *blob);
>  int security_sk_alloc(struct sock *sk, int family, gfp_t priority);
>  void security_sk_free(struct sock *sk);
>  void security_sk_clone(const struct sock *sk, struct sock *newsk);
> @@ -1496,7 +1497,9 @@ static inline int security_socket_getpeersec_stream(struct socket *sock, char __
>  	return -ENOPROTOOPT;
>  }
>  
> -static inline int security_socket_getpeersec_dgram(struct socket *sock, struct sk_buff *skb, u32 *secid)
> +static inline int security_socket_getpeersec_dgram(struct socket *sock,
> +						   struct sk_buff *skb,
> +						   struct lsmblob *blob)
>  {
>  	return -ENOPROTOOPT;
>  }
> diff --git a/include/net/af_unix.h b/include/net/af_unix.h
> index 17e10fba2152..83c3b3034030 100644
> --- a/include/net/af_unix.h
> +++ b/include/net/af_unix.h
> @@ -36,7 +36,7 @@ struct unix_skb_parms {
>  	kgid_t			gid;
>  	struct scm_fp_list	*fp;		/* Passed files		*/
>  #ifdef CONFIG_SECURITY_NETWORK
> -	u32			secid;		/* Security ID		*/
> +	struct lsmblob		*lsmdata;	/* Security LSM data	*/
>  #endif
>  	u32			consumed;
>  } __randomize_layout;
> diff --git a/include/net/scm.h b/include/net/scm.h
> index 1ce365f4c256..e2e71c4bf9d0 100644
> --- a/include/net/scm.h
> +++ b/include/net/scm.h
> @@ -33,7 +33,7 @@ struct scm_cookie {
>  	struct scm_fp_list	*fp;		/* Passed files		*/
>  	struct scm_creds	creds;		/* Skb credentials	*/
>  #ifdef CONFIG_SECURITY_NETWORK
> -	u32			secid;		/* Passed security ID 	*/
> +	struct lsmblob		lsmblob;	/* Passed LSM data	*/
>  #endif
>  };
>  
> @@ -46,7 +46,7 @@ struct scm_fp_list *scm_fp_dup(struct scm_fp_list *fpl);
>  #ifdef CONFIG_SECURITY_NETWORK
>  static __inline__ void unix_get_peersec_dgram(struct socket *sock, struct scm_cookie *scm)
>  {
> -	security_socket_getpeersec_dgram(sock, NULL, &scm->secid);
> +	security_socket_getpeersec_dgram(sock, NULL, &scm->lsmblob);
>  }
>  #else
>  static __inline__ void unix_get_peersec_dgram(struct socket *sock, struct scm_cookie *scm)
> @@ -97,7 +97,9 @@ static inline void scm_passec(struct socket *sock, struct msghdr *msg, struct sc
>  	int err;
>  
>  	if (test_bit(SOCK_PASSSEC, &sock->flags)) {
> -		err = security_secid_to_secctx(scm->secid, &secdata, &seclen);
> +		/* Scaffolding - it has to be element 0 for now */
> +		err = security_secid_to_secctx(scm->lsmblob.secid[0],
> +					       &secdata, &seclen);
>  
>  		if (!err) {
>  			put_cmsg(msg, SOL_SOCKET, SCM_SECURITY, seclen, secdata);
> diff --git a/net/ipv4/ip_sockglue.c b/net/ipv4/ip_sockglue.c
> index aa3fd61818c4..6cf57d5ac899 100644
> --- a/net/ipv4/ip_sockglue.c
> +++ b/net/ipv4/ip_sockglue.c
> @@ -130,15 +130,17 @@ static void ip_cmsg_recv_checksum(struct msghdr *msg, struct sk_buff *skb,
>  
>  static void ip_cmsg_recv_security(struct msghdr *msg, struct sk_buff *skb)
>  {
> +	struct lsmblob lb;
>  	char *secdata;
> -	u32 seclen, secid;
> +	u32 seclen;
>  	int err;
>  
> -	err = security_socket_getpeersec_dgram(NULL, skb, &secid);
> +	err = security_socket_getpeersec_dgram(NULL, skb, &lb);
>  	if (err)
>  		return;
>  
> -	err = security_secid_to_secctx(secid, &secdata, &seclen);
> +	/* Scaffolding - it has to be element 0 */
> +	err = security_secid_to_secctx(lb.secid[0], &secdata, &seclen);
>  	if (err)
>  		return;
>  
> diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
> index 68debcb28fa4..179876573d6d 100644
> --- a/net/unix/af_unix.c
> +++ b/net/unix/af_unix.c
> @@ -138,17 +138,18 @@ static struct hlist_head *unix_sockets_unbound(void *addr)
>  #ifdef CONFIG_SECURITY_NETWORK
>  static void unix_get_secdata(struct scm_cookie *scm, struct sk_buff *skb)
>  {
> -	UNIXCB(skb).secid = scm->secid;
> +	UNIXCB(skb).lsmdata = kmemdup(&scm->lsmblob, sizeof(scm->lsmblob),
> +				      GFP_KERNEL);
>  }
>  
>  static inline void unix_set_secdata(struct scm_cookie *scm, struct sk_buff *skb)
>  {
> -	scm->secid = UNIXCB(skb).secid;
> +	scm->lsmblob = *(UNIXCB(skb).lsmdata);
>  }
>  
>  static inline bool unix_secdata_eq(struct scm_cookie *scm, struct sk_buff *skb)
>  {
> -	return (scm->secid == UNIXCB(skb).secid);
> +	return lsmblob_equal(&scm->lsmblob, UNIXCB(skb).lsmdata);
>  }
>  #else
>  static inline void unix_get_secdata(struct scm_cookie *scm, struct sk_buff *skb)
> diff --git a/net/unix/scm.c b/net/unix/scm.c
> index 8c40f2b32392..3094323935a4 100644
> --- a/net/unix/scm.c
> +++ b/net/unix/scm.c
> @@ -142,6 +142,12 @@ void unix_destruct_scm(struct sk_buff *skb)
>  	scm.pid  = UNIXCB(skb).pid;
>  	if (UNIXCB(skb).fp)
>  		unix_detach_fds(&scm, skb);
> +#ifdef CONFIG_SECURITY_NETWORK
> +	if (UNIXCB(skb).lsmdata) {
> +		kfree(UNIXCB(skb).lsmdata);
> +		UNIXCB(skb).lsmdata = NULL;
> +	}
> +#endif
>  
>  	/* Alas, it calls VFS */
>  	/* So fscking what? fput() had been SMP-safe since the last Summer */
> diff --git a/security/security.c b/security/security.c
> index 914aecd89822..2fa826000889 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -2140,10 +2140,22 @@ int security_socket_getpeersec_stream(struct socket *sock, char __user *optval,
>  				optval, optlen, len);
>  }
>  
> -int security_socket_getpeersec_dgram(struct socket *sock, struct sk_buff *skb, u32 *secid)
> +int security_socket_getpeersec_dgram(struct socket *sock, struct sk_buff *skb,
> +				     struct lsmblob *blob)
>  {
> -	return call_int_hook(socket_getpeersec_dgram, -ENOPROTOOPT, sock,
> -			     skb, secid);
> +	struct security_hook_list *hp;
> +	int rc = -ENOPROTOOPT;
> +
> +	hlist_for_each_entry(hp, &security_hook_heads.socket_getpeersec_dgram,
> +			     list) {
> +		if (WARN_ON(hp->lsmid->slot < 0 || hp->lsmid->slot >= lsm_slot))
> +			continue;
> +		rc = hp->hook.socket_getpeersec_dgram(sock, skb,
> +						&blob->secid[hp->lsmid->slot]);
> +		if (rc != 0)
> +			break;
> +	}
> +	return rc;
>  }
>  EXPORT_SYMBOL(security_socket_getpeersec_dgram);
>  
> -- 
> 2.24.1
> 

-- 
Kees Cook
