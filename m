Return-Path: <SRS0=4tRG=2H=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFBA4C43603
	for <selinux@archiver.kernel.org>; Tue, 17 Dec 2019 17:43:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1ABF206D8
	for <selinux@archiver.kernel.org>; Tue, 17 Dec 2019 17:43:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="S1Ss1IcK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727346AbfLQRnp (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 17 Dec 2019 12:43:45 -0500
Received: from UHIL19PA37.eemsg.mail.mil ([214.24.21.196]:32805 "EHLO
        UHIL19PA37.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726764AbfLQRnp (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 17 Dec 2019 12:43:45 -0500
X-EEMSG-check-017: 58221859|UHIL19PA37_ESA_OUT03.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.69,326,1571702400"; 
   d="scan'208";a="58221859"
Received: from emsm-gh1-uea10.ncsc.mil ([214.29.60.2])
  by UHIL19PA37.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 17 Dec 2019 17:41:41 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1576604501; x=1608140501;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=co6TcGeMQxfjZEyD5G5fVjN6fKqoWfXRGbdVEApBA4I=;
  b=S1Ss1IcKCUpjgRYSfQsR8mJFc+x6whOA1AEatK5hiA+HM5Ay13u6vsVG
   i1v2dBiJb42UW+1Jmu2BqRLfru1jF/se7E/Vgf5EpFn9PNq6nY3iNpjPG
   UA/PuAfUDodJmYrUM8YeYUiwuhyItTv3HmbbGPhpV9GpqwHlqOM11mkDC
   cgZm9Ei0/Q1mh8u6hCnNPsx8oThmfhyzYBnhFdB/zg/+5cw7dRhZ5yTGF
   VT6pqb7iolrjLI7sJ5MCUj+eQ3lbBshOLFivQAwWNpkURzIRetaVo0xiO
   sz2saOpLhOR1q7lv4WPvCfgrK246Cqc58yPcxGXXBEUKOe38DV208mRXc
   w==;
X-IronPort-AV: E=Sophos;i="5.69,326,1571702400"; 
   d="scan'208";a="31196852"
IronPort-PHdr: =?us-ascii?q?9a23=3ArYAWaReyb5RSNF79Cds+t72tlGMj4u6mDksu8p?=
 =?us-ascii?q?Mizoh2WeGdxc2+YxCN2/xhgRfzUJnB7Loc0qyK6vumAzRfqs/Z6DgrS99lb1?=
 =?us-ascii?q?c9k8IYnggtUoauKHbQC7rUVRE8B9lIT1R//nu2YgB/Ecf6YEDO8DXptWZBUh?=
 =?us-ascii?q?rwOhBoKevrB4Xck9q41/yo+53Ufg5EmCexbal9IRmrowjdrNcajZdgJ6o+1x?=
 =?us-ascii?q?fFvmdEcPlKyG11Il6egwzy7dqq8p559CRQtfMh98peXqj/Yq81U79WAik4Pm?=
 =?us-ascii?q?4s/MHkugXNQgWJ5nsHT2UZiQFIDBTf7BH7RZj+rC33vfdg1SaAPM32Sbc0WS?=
 =?us-ascii?q?m+76puVRTlhjsLOyI//WrKkcF7kr5Vrwy9qBx+247UYZ+aNPxifqPGYNgWQX?=
 =?us-ascii?q?NNUttNWyBdB4+xaYUAD/AFPe1FsYfzoVUApga6CQW1Gu/izjpEi3nr1qM4zu?=
 =?us-ascii?q?shCxnL0hE+EdIAsHrar9v7O6kdXu+30KbGwi7Ob+9U1Drn9ITEbh4srPOKUL?=
 =?us-ascii?q?ltccTR004vFwbdg1uNtYzqISuV1uQTvGid8uFuSOevhHQjqwF1vDeuxtonh4?=
 =?us-ascii?q?7Sho0I0VDJ7jl5wYYpKt24T053e9ikEIBKuC2AOIt2Rd0iTnhutS0nybMGoY?=
 =?us-ascii?q?a2cDUFxZko3RLSa+GLf5KW7h/sSuqdOyp0iXR4c7ylnRmy61KvyujkW8mx11?=
 =?us-ascii?q?ZFszRKn8HXtnAIyxzT8s+HSuZh/ku52TaAyQTT6uZcLEAoj6XbMZ8hwqMrlp?=
 =?us-ascii?q?YJsETDGCH2mELtjKCIakoo4PSo6uT7bbXmoZ+QLYl0hR3lMqsygMC/BOU4Mg?=
 =?us-ascii?q?wWU2ia/+SzyqHj8FXkTLhFgfA6iKnUvI3AKcgFqaO1HRVZ3ps75xa6FTim0d?=
 =?us-ascii?q?AYnXcdLFJCfRKKl5PpNEzVIP3jEfe+g0ijkDdsx/zcOL3hGY/CImLMkLfmY7?=
 =?us-ascii?q?Zx81RcxxYrzdBD+5JUDakML+7pVU/qqtPZDgQ0MxeozObnEtp9y40eWWaRDa?=
 =?us-ascii?q?+DKa/drUWH6vgzLOmLYY8foCz9JOQ95/7ykX85nkcQcrWz0psMdn+5Hu5qI1?=
 =?us-ascii?q?6FbnrsmNgBDGkKvg4gQ+zwk1CCUDhTZ2qsUKI4/D00FIWmDYLbTIC3nLOBxD?=
 =?us-ascii?q?u7HoFRZm1eCFCMFHDod5+eW/cNcyKfOclhnSYBVbe/So8tzxautBX1y7B/NO?=
 =?us-ascii?q?rb5jUYtY7/1Nhy/+DTkRAy9TppD8WSym2NVH97kX8VRz8s3aB/vUx8xk6G0a?=
 =?us-ascii?q?h/nvNYCNhT6O1SXwckOp7T0fZ6B8rxWg3fZNeJTkipQtG8DTE2VNIxzMcEY1?=
 =?us-ascii?q?xhFNW6khDDwy2qDqcOl7OVAJw086Tc32X+Jstm1XbG27cuj0M8TstMK2KmnK?=
 =?us-ascii?q?h/+BbXB4LTlEWZjamqf7wG3CHR7GeD0XaOvEZAXQ5zT6rKQ2sfaVfRrdT+5U?=
 =?us-ascii?q?PPVKOhCbQ9MgtGzM6CK7ZKatjzgVVBXvfjN8zUY3itlGeoGRaI2rSMYZLoe2?=
 =?us-ascii?q?Ua3CXdDlIIkwIU/XaGLwc+ADyhrHzYDDF1CV3geUXs8e54qHO6UkA71QWKY1?=
 =?us-ascii?q?d92Lqy/x4fneacRO8L3rIYpCchrC15HE6j0NLQBNqAugthfKNFbdM+/lhHz2?=
 =?us-ascii?q?TZuBJ5PpG7LqBun1oecwNpv0zwzRl3EZ9Pkcs3rHMw1gV+M6SY301bezOaxZ?=
 =?us-ascii?q?D6IqfXJXXq/BCzd67W3UnT0M6M9acS7PQ1sE3jsxu0Fkom6nln1t5V03yG5p?=
 =?us-ascii?q?rUFgYdTZXxUkNkvyR98prTeSQsr7jf1XRxP625qHeW0NsyCfoN0R2gdspRNK?=
 =?us-ascii?q?6eUQT7VcYdAp7qYOcjgFW4KAkPPOlP+qo5JeunceeL3OigO+Mk1DCjin5d4Z?=
 =?us-ascii?q?tV1EuJ+is6TfTHm94BwveFzk6cWjzhlla9o4XynoxZYTw6AGWy027nCZRXa6?=
 =?us-ascii?q?k0epwETS+1Lsm2wMhur4DiVmQe91O5AV4Cnsizdkm8dVv4iDZM2FwXrHrvoi?=
 =?us-ascii?q?6xyzh5gnl9taaE9DDfyOTlMhwcMyhEQ3c03gSkGpS9k91PBBvgVAMujhbwoB?=
 =?us-ascii?q?+glqU=3D?=
X-IPAS-Result: =?us-ascii?q?A2BIAAAhEvld/wHyM5BlHAEBAQEBBwEBEQEEBAEBgWwFA?=
 =?us-ascii?q?QELAYFzgW0gEiqEBIkDhngGgTeJao9KgXsJAQEBAQEBAQEBNwEBhEACgjw2B?=
 =?us-ascii?q?w4CEAEBAQQBAQEBAQUDAQFshUOCOykBgnoBBSMEEUEQCxgCAiYCAlcGAQwGA?=
 =?us-ascii?q?gEBgl8/glMlrjR/M4VPgz2BSIEOKAGMMXmBB4ERJw+CLy4+h1mCXgSXDEaXM?=
 =?us-ascii?q?4I+gkKTSAYbgkOYBo5NgUaVG4VtCSmBWCsIAhgIIQ87gmxQERSKK4JzF45BI?=
 =?us-ascii?q?wMwkX0BAQ?=
Received: from tarius.tycho.ncsc.mil (HELO tarius.infosec.tycho.ncsc.mil) ([144.51.242.1])
  by EMSM-GH1-UEA10.NCSC.MIL with ESMTP; 17 Dec 2019 17:41:40 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.infosec.tycho.ncsc.mil (8.14.7/8.14.4) with ESMTP id xBHHfFZD151623;
        Tue, 17 Dec 2019 12:41:17 -0500
Subject: Re: [PATCH v12 05/25] net: Prepare UDS for security module stacking
To:     Casey Schaufler <casey@schaufler-ca.com>,
        casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com
References: <20191216223621.5127-1-casey@schaufler-ca.com>
 <20191216223621.5127-6-casey@schaufler-ca.com>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <3d63974e-50f9-26ba-0b08-b537716f062b@tycho.nsa.gov>
Date:   Tue, 17 Dec 2019 12:41:54 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191216223621.5127-6-casey@schaufler-ca.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 12/16/19 5:36 PM, Casey Schaufler wrote:
> Change the data used in UDS SO_PEERSEC processing from a
> secid to a more general struct lsmblob. Update the
> security_socket_getpeersec_dgram() interface to use the
> lsmblob. There is a small amount of scaffolding code
> that will come out when the security_secid_to_secctx()
> code is brought in line with the lsmblob.
> 
> Reviewed-by: Kees Cook <keescook@chromium.org>
> Reviewed-by: John Johansen <john.johansen@canonical.com>
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
> cc: netdev@vger.kernel.org

You list netdev in the body but it isn't on the cc list AFAICT.  It was 
copied on an earlier, possibly identical version of the series I 
believe.  Not sure what is required here and I know you've had problems 
with bounces.  Regardless, with respect to the code:

Acked-by: Stephen Smalley <sds@tycho.nsa.gov>

> ---
>   include/linux/security.h |  7 +++++--
>   include/net/af_unix.h    |  2 +-
>   include/net/scm.h        |  8 +++++---
>   net/ipv4/ip_sockglue.c   |  8 +++++---
>   net/unix/af_unix.c       |  6 +++---
>   security/security.c      | 18 +++++++++++++++---
>   6 files changed, 34 insertions(+), 15 deletions(-)
> 
> diff --git a/include/linux/security.h b/include/linux/security.h
> index 322ed9622819..995faba7393f 100644
> --- a/include/linux/security.h
> +++ b/include/linux/security.h
> @@ -1356,7 +1356,8 @@ int security_socket_shutdown(struct socket *sock, int how);
>   int security_sock_rcv_skb(struct sock *sk, struct sk_buff *skb);
>   int security_socket_getpeersec_stream(struct socket *sock, char __user *optval,
>   				      int __user *optlen, unsigned len);
> -int security_socket_getpeersec_dgram(struct socket *sock, struct sk_buff *skb, u32 *secid);
> +int security_socket_getpeersec_dgram(struct socket *sock, struct sk_buff *skb,
> +				     struct lsmblob *blob);
>   int security_sk_alloc(struct sock *sk, int family, gfp_t priority);
>   void security_sk_free(struct sock *sk);
>   void security_sk_clone(const struct sock *sk, struct sock *newsk);
> @@ -1494,7 +1495,9 @@ static inline int security_socket_getpeersec_stream(struct socket *sock, char __
>   	return -ENOPROTOOPT;
>   }
>   
> -static inline int security_socket_getpeersec_dgram(struct socket *sock, struct sk_buff *skb, u32 *secid)
> +static inline int security_socket_getpeersec_dgram(struct socket *sock,
> +						   struct sk_buff *skb,
> +						   struct lsmblob *blob)
>   {
>   	return -ENOPROTOOPT;
>   }
> diff --git a/include/net/af_unix.h b/include/net/af_unix.h
> index 3426d6dacc45..933492c08b8c 100644
> --- a/include/net/af_unix.h
> +++ b/include/net/af_unix.h
> @@ -36,7 +36,7 @@ struct unix_skb_parms {
>   	kgid_t			gid;
>   	struct scm_fp_list	*fp;		/* Passed files		*/
>   #ifdef CONFIG_SECURITY_NETWORK
> -	u32			secid;		/* Security ID		*/
> +	struct lsmblob		lsmblob;	/* Security LSM data	*/
>   #endif
>   	u32			consumed;
>   } __randomize_layout;
> diff --git a/include/net/scm.h b/include/net/scm.h
> index 1ce365f4c256..e2e71c4bf9d0 100644
> --- a/include/net/scm.h
> +++ b/include/net/scm.h
> @@ -33,7 +33,7 @@ struct scm_cookie {
>   	struct scm_fp_list	*fp;		/* Passed files		*/
>   	struct scm_creds	creds;		/* Skb credentials	*/
>   #ifdef CONFIG_SECURITY_NETWORK
> -	u32			secid;		/* Passed security ID 	*/
> +	struct lsmblob		lsmblob;	/* Passed LSM data	*/
>   #endif
>   };
>   
> @@ -46,7 +46,7 @@ struct scm_fp_list *scm_fp_dup(struct scm_fp_list *fpl);
>   #ifdef CONFIG_SECURITY_NETWORK
>   static __inline__ void unix_get_peersec_dgram(struct socket *sock, struct scm_cookie *scm)
>   {
> -	security_socket_getpeersec_dgram(sock, NULL, &scm->secid);
> +	security_socket_getpeersec_dgram(sock, NULL, &scm->lsmblob);
>   }
>   #else
>   static __inline__ void unix_get_peersec_dgram(struct socket *sock, struct scm_cookie *scm)
> @@ -97,7 +97,9 @@ static inline void scm_passec(struct socket *sock, struct msghdr *msg, struct sc
>   	int err;
>   
>   	if (test_bit(SOCK_PASSSEC, &sock->flags)) {
> -		err = security_secid_to_secctx(scm->secid, &secdata, &seclen);
> +		/* Scaffolding - it has to be element 0 for now */
> +		err = security_secid_to_secctx(scm->lsmblob.secid[0],
> +					       &secdata, &seclen);
>   
>   		if (!err) {
>   			put_cmsg(msg, SOL_SOCKET, SCM_SECURITY, seclen, secdata);
> diff --git a/net/ipv4/ip_sockglue.c b/net/ipv4/ip_sockglue.c
> index aa3fd61818c4..6cf57d5ac899 100644
> --- a/net/ipv4/ip_sockglue.c
> +++ b/net/ipv4/ip_sockglue.c
> @@ -130,15 +130,17 @@ static void ip_cmsg_recv_checksum(struct msghdr *msg, struct sk_buff *skb,
>   
>   static void ip_cmsg_recv_security(struct msghdr *msg, struct sk_buff *skb)
>   {
> +	struct lsmblob lb;
>   	char *secdata;
> -	u32 seclen, secid;
> +	u32 seclen;
>   	int err;
>   
> -	err = security_socket_getpeersec_dgram(NULL, skb, &secid);
> +	err = security_socket_getpeersec_dgram(NULL, skb, &lb);
>   	if (err)
>   		return;
>   
> -	err = security_secid_to_secctx(secid, &secdata, &seclen);
> +	/* Scaffolding - it has to be element 0 */
> +	err = security_secid_to_secctx(lb.secid[0], &secdata, &seclen);
>   	if (err)
>   		return;
>   
> diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
> index 7cfdce10de36..73d32f655f18 100644
> --- a/net/unix/af_unix.c
> +++ b/net/unix/af_unix.c
> @@ -138,17 +138,17 @@ static struct hlist_head *unix_sockets_unbound(void *addr)
>   #ifdef CONFIG_SECURITY_NETWORK
>   static void unix_get_secdata(struct scm_cookie *scm, struct sk_buff *skb)
>   {
> -	UNIXCB(skb).secid = scm->secid;
> +	UNIXCB(skb).lsmblob = scm->lsmblob;
>   }
>   
>   static inline void unix_set_secdata(struct scm_cookie *scm, struct sk_buff *skb)
>   {
> -	scm->secid = UNIXCB(skb).secid;
> +	scm->lsmblob = UNIXCB(skb).lsmblob;
>   }
>   
>   static inline bool unix_secdata_eq(struct scm_cookie *scm, struct sk_buff *skb)
>   {
> -	return (scm->secid == UNIXCB(skb).secid);
> +	return lsmblob_equal(&scm->lsmblob, &(UNIXCB(skb).lsmblob));
>   }
>   #else
>   static inline void unix_get_secdata(struct scm_cookie *scm, struct sk_buff *skb)
> diff --git a/security/security.c b/security/security.c
> index cee032b5ce29..a3be3929a60a 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -2108,10 +2108,22 @@ int security_socket_getpeersec_stream(struct socket *sock, char __user *optval,
>   				optval, optlen, len);
>   }
>   
> -int security_socket_getpeersec_dgram(struct socket *sock, struct sk_buff *skb, u32 *secid)
> +int security_socket_getpeersec_dgram(struct socket *sock, struct sk_buff *skb,
> +				     struct lsmblob *blob)
>   {
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
>   }
>   EXPORT_SYMBOL(security_socket_getpeersec_dgram);
>   
> 

