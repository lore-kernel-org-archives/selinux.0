Return-Path: <SRS0=Ig95=CM=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F23B0C433E2
	for <selinux@archiver.kernel.org>; Thu,  3 Sep 2020 16:28:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D747920758
	for <selinux@archiver.kernel.org>; Thu,  3 Sep 2020 16:28:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728304AbgICQ2z (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 3 Sep 2020 12:28:55 -0400
Received: from namei.org ([65.99.196.166]:55102 "EHLO namei.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726990AbgICQ2y (ORCPT <rfc822;selinux@vger.kernel.org>);
        Thu, 3 Sep 2020 12:28:54 -0400
Received: from localhost (localhost [127.0.0.1])
        by namei.org (8.14.4/8.14.4) with ESMTP id 083GSUkN003994;
        Thu, 3 Sep 2020 16:28:30 GMT
Date:   Fri, 4 Sep 2020 02:28:30 +1000 (AEST)
From:   James Morris <jmorris@namei.org>
To:     Casey Schaufler <casey@schaufler-ca.com>
cc:     casey.schaufler@intel.com, linux-security-module@vger.kernel.org,
        selinux@vger.kernel.org, linux-audit@redhat.com,
        keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com,
        sds@tycho.nsa.gov
Subject: Re: [PATCH v20 05/23] net: Prepare UDS for security module
 stacking
In-Reply-To: <20200826145247.10029-6-casey@schaufler-ca.com>
Message-ID: <alpine.LRH.2.21.2009040227440.1484@namei.org>
References: <20200826145247.10029-1-casey@schaufler-ca.com> <20200826145247.10029-6-casey@schaufler-ca.com>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, 26 Aug 2020, Casey Schaufler wrote:

> Change the data used in UDS SO_PEERSEC processing from a
> secid to a more general struct lsmblob. Update the
> security_socket_getpeersec_dgram() interface to use the
> lsmblob. There is a small amount of scaffolding code
> that will come out when the security_secid_to_secctx()
> code is brought in line with the lsmblob.
> 
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>

This needs some review by networking folk, and/or LSM maintainers. You 
should probably cc netdev on anything touching the networking code.

> ---
>  include/linux/security.h |  7 +++++--
>  include/net/af_unix.h    |  2 +-
>  include/net/scm.h        |  8 +++++---
>  net/ipv4/ip_sockglue.c   |  8 +++++---
>  net/unix/af_unix.c       |  6 +++---
>  security/security.c      | 18 +++++++++++++++---
>  6 files changed, 34 insertions(+), 15 deletions(-)
> 
> diff --git a/include/linux/security.h b/include/linux/security.h
> index e2ef982b3dd7..ae623b89cdf4 100644
> --- a/include/linux/security.h
> +++ b/include/linux/security.h
> @@ -1398,7 +1398,8 @@ int security_socket_shutdown(struct socket *sock, int how);
>  int security_sock_rcv_skb(struct sock *sk, struct sk_buff *skb);
>  int security_socket_getpeersec_stream(struct socket *sock, char __user *optval,
>  				      int __user *optlen, unsigned len);
> -int security_socket_getpeersec_dgram(struct socket *sock, struct sk_buff *skb, u32 *secid);
> +int security_socket_getpeersec_dgram(struct socket *sock, struct sk_buff *skb,
> +				     struct lsmblob *blob);
>  int security_sk_alloc(struct sock *sk, int family, gfp_t priority);
>  void security_sk_free(struct sock *sk);
>  void security_sk_clone(const struct sock *sk, struct sock *newsk);
> @@ -1536,7 +1537,9 @@ static inline int security_socket_getpeersec_stream(struct socket *sock, char __
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
> index f42fdddecd41..a86da0cb5ec1 100644
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
> index d2c223554ff7..551dfbc717e9 100644
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
> index 181ea6fb56a6..c15668b80d1d 100644
> --- a/net/unix/af_unix.c
> +++ b/net/unix/af_unix.c
> @@ -138,17 +138,17 @@ static struct hlist_head *unix_sockets_unbound(void *addr)
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
> index d6d882b1f7d5..c42873876954 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -2219,10 +2219,22 @@ int security_socket_getpeersec_stream(struct socket *sock, char __user *optval,
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
> 

-- 
James Morris
<jmorris@namei.org>

