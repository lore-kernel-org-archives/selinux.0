Return-Path: <SRS0=BI9l=UV=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C72F6C43613
	for <selinux@archiver.kernel.org>; Sat, 22 Jun 2019 22:43:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9138B2084E
	for <selinux@archiver.kernel.org>; Sat, 22 Jun 2019 22:43:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Z0+cnpnv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726388AbfFVWn6 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sat, 22 Jun 2019 18:43:58 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:46180 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726286AbfFVWn5 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sat, 22 Jun 2019 18:43:57 -0400
Received: by mail-pf1-f196.google.com with SMTP id 81so5364632pfy.13
        for <selinux@vger.kernel.org>; Sat, 22 Jun 2019 15:43:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=UO+KVxGSRtQMFAiud20WkloSYHb2BhZe1eWL/FGyHJQ=;
        b=Z0+cnpnvW34paCjBcXgdo+CcZttNQ0i/B3yGuHrzarwuSbDKIdlm34Puy8xUo+DkLJ
         1ne8M772nmj/HVBJHGIwbBxAoNBQvCf9k8GTqDsY/e7SDywsmo3eVau8XQawm98hkX4I
         Imki5Ua1Mx/YC69Xqz/B28P2AbLZdyfNRT/PA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=UO+KVxGSRtQMFAiud20WkloSYHb2BhZe1eWL/FGyHJQ=;
        b=WXMa/Vkqsytivr0oetrXwhWfWpHYLYi+jIe24iFThG9nfSZDn7KiaVLTTMqvP/vtFQ
         gu6zJtJZu/Ak8X+QTv3JZVqlHxM20DZbfKOimJDmXH4gi7z0Mxpw6/dhDTdO9lQprGEk
         JXjHCSkMkAXnl3MbBR05CJ782yxSVNHV3lRVDl5CuIjZVSNGa50SLXErEeN1xFHflsTO
         zB0TMmx6sWCwUYInDlL5LdT44CGZABRKcMosA7FMD7WiF7RS+4SJCNtHxYS6lskFFH2B
         C3QFR3BzXvgGFVIzVpZOy6bZ8Cc3MZN8dOag1QW+L34XG+JFlpYA9dMTSyF5u9vIBnvN
         bgfQ==
X-Gm-Message-State: APjAAAUYmDa8b7Gh5A02CSkFgcRloz/IXS/EfDWOKOVI/7wQ9+FtkrPs
        //JKMxGI72tzsMRuWWZHIYU3L5iITSk=
X-Google-Smtp-Source: APXvYqyD9JB86uyaUINYbcN8LFEYvofaKm1tlm3ZtqaHlo4Q4FyxkI9/8bYx0piB2SYfB6XcfzX1TQ==
X-Received: by 2002:a17:90a:5887:: with SMTP id j7mr15124938pji.136.1561243437092;
        Sat, 22 Jun 2019 15:43:57 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id g62sm2184857pje.11.2019.06.22.15.43.56
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 22 Jun 2019 15:43:56 -0700 (PDT)
Date:   Sat, 22 Jun 2019 15:43:55 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        paul@paul-moore.com, sds@tycho.nsa.gov
Subject: Re: [PATCH v3 07/24] net: Prepare UDS for secuirty module stacking
Message-ID: <201906221543.E8BDBFFB@keescook>
References: <20190621185233.6766-1-casey@schaufler-ca.com>
 <20190621185233.6766-8-casey@schaufler-ca.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190621185233.6766-8-casey@schaufler-ca.com>
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Jun 21, 2019 at 11:52:16AM -0700, Casey Schaufler wrote:
> Change the data used in UDS SO_PEERSEC processing from a
> secid to a more general struct lsmblob. Update the
> security_socket_getpeersec_dgram() interface to use the
> lsmblob. There is a small amount of scaffolding code
> that will come out when the security_secid_to_secctx()
> code is brought in line with the lsmblob.
> 
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

> ---
>  include/linux/security.h |  7 +++++--
>  include/net/af_unix.h    |  2 +-
>  include/net/scm.h        |  8 +++++---
>  net/ipv4/ip_sockglue.c   |  8 +++++---
>  net/unix/af_unix.c       |  6 +++---
>  security/security.c      | 16 +++++++++++++---
>  6 files changed, 32 insertions(+), 15 deletions(-)
> 
> diff --git a/include/linux/security.h b/include/linux/security.h
> index 4a78516cc74a..905830a90745 100644
> --- a/include/linux/security.h
> +++ b/include/linux/security.h
> @@ -1276,7 +1276,8 @@ int security_socket_shutdown(struct socket *sock, int how);
>  int security_sock_rcv_skb(struct sock *sk, struct sk_buff *skb);
>  int security_socket_getpeersec_stream(struct socket *sock, char __user *optval,
>  				      int __user *optlen, unsigned len);
> -int security_socket_getpeersec_dgram(struct socket *sock, struct sk_buff *skb, u32 *secid);
> +int security_socket_getpeersec_dgram(struct socket *sock, struct sk_buff *skb,
> +				     struct lsmblob *blob);
>  int security_sk_alloc(struct sock *sk, int family, gfp_t priority);
>  void security_sk_free(struct sock *sk);
>  void security_sk_clone(const struct sock *sk, struct sock *newsk);
> @@ -1414,7 +1415,9 @@ static inline int security_socket_getpeersec_stream(struct socket *sock, char __
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
> index 3426d6dacc45..933492c08b8c 100644
> --- a/include/net/af_unix.h
> +++ b/include/net/af_unix.h
> @@ -36,7 +36,7 @@ struct unix_skb_parms {
>  	kgid_t			gid;
>  	struct scm_fp_list	*fp;		/* Passed files		*/
>  #ifdef CONFIG_SECURITY_NETWORK
> -	u32			secid;		/* Security ID		*/
> +	struct lsmblob		lsmblob;	/* Security LSM data	*/
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
> index 82f341e84fae..2a5c868ce135 100644
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
> index ddb838a1b74c..c50a004a1389 100644
> --- a/net/unix/af_unix.c
> +++ b/net/unix/af_unix.c
> @@ -143,17 +143,17 @@ static struct hlist_head *unix_sockets_unbound(void *addr)
>  #ifdef CONFIG_SECURITY_NETWORK
>  static void unix_get_secdata(struct scm_cookie *scm, struct sk_buff *skb)
>  {
> -	UNIXCB(skb).secid = scm->secid;
> +	UNIXCB(skb).lsmblob = scm->lsmblob;
>  }
>  
>  static inline void unix_set_secdata(struct scm_cookie *scm, struct sk_buff *skb)
>  {
> -	scm->secid = UNIXCB(skb).secid;
> +	scm->lsmblob = UNIXCB(skb).lsmblob;
>  }
>  
>  static inline bool unix_secdata_eq(struct scm_cookie *scm, struct sk_buff *skb)
>  {
> -	return (scm->secid == UNIXCB(skb).secid);
> +	return lsmblob_equal(&scm->lsmblob, &(UNIXCB(skb).lsmblob));
>  }
>  #else
>  static inline void unix_get_secdata(struct scm_cookie *scm, struct sk_buff *skb)
> diff --git a/security/security.c b/security/security.c
> index 43f8018b9e13..c7b3d1a294ad 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -2137,10 +2137,20 @@ int security_socket_getpeersec_stream(struct socket *sock, char __user *optval,
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
> +		rc = hp->hook.socket_getpeersec_dgram(sock, skb,
> +						      &blob->secid[hp->slot]);
> +		if (rc != 0)
> +			break;
> +	}
> +	return rc;
>  }
>  EXPORT_SYMBOL(security_socket_getpeersec_dgram);
>  
> -- 
> 2.20.1
> 

-- 
Kees Cook
