Return-Path: <SRS0=xVDs=2I=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D983C43603
	for <selinux@archiver.kernel.org>; Wed, 18 Dec 2019 17:10:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E83E22082E
	for <selinux@archiver.kernel.org>; Wed, 18 Dec 2019 17:10:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="pZJD61KJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727025AbfLRRKe (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 18 Dec 2019 12:10:34 -0500
Received: from USFB19PA36.eemsg.mail.mil ([214.24.26.199]:48029 "EHLO
        USFB19PA36.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726960AbfLRRKe (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 18 Dec 2019 12:10:34 -0500
X-EEMSG-check-017: 36886583|USFB19PA36_ESA_OUT06.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.69,330,1571702400"; 
   d="scan'208";a="36886583"
Received: from emsm-gh1-uea11.ncsc.mil ([214.29.60.3])
  by USFB19PA36.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 18 Dec 2019 17:10:32 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1576689032; x=1608225032;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=X7XEuTbLCiKdg3A+9tmOBdCYC7v7W+GwywtBfIE+7y8=;
  b=pZJD61KJ2xNTJ4Bdi+3JqwWJ1Vp9yKKd/02xsIGPO9/gyEHN4qAFpSzx
   XVnpcxxlhIZ+c3OcQcLYW1nZqZxMrGsV2c7QkezTyYPvxXjH9r9ViYg+M
   OOn08uAYjO+V162jfJ3aQvD/5gD5E0FcBwZ7bq3Fv1GLKeBOKGOVOnDtZ
   OslHkZmcJEpxNn+CIp0lWSBB/p4DkORIhBBm3m05Wd2pZ4WgVkc1I1zwm
   aKdQw+PTwQzuCXVjrblO7nOoyFvTN0xFOnfm0KZZsQVguyFX94Bc8rFwD
   JOEr3PRUjaIytzRe+RNl2WgsMvvPkqfXWh1JyUVPc7gzrlCJIu5zjA7dX
   g==;
X-IronPort-AV: E=Sophos;i="5.69,330,1571702400"; 
   d="scan'208";a="36917433"
IronPort-PHdr: =?us-ascii?q?9a23=3A4iWCjBXnFK25YuVs7RlEmKD/jtfV8LGtZVwlr6?=
 =?us-ascii?q?E/grcLSJyIuqrYZRCAvKdThVPEFb/W9+hDw7KP9fy5AipaucfK4SpKWacPfi?=
 =?us-ascii?q?dNsd8RkQ0kDZzNImzAB9muURYHGt9fXkRu5XCxPBsdMs//Y1rPvi/6tmZKSV?=
 =?us-ascii?q?3wOgVvO+v6BJPZgdip2OCu4Z3TZBhDiCagbb9oIxi6sAvcutMIjYd+Lqs9xR?=
 =?us-ascii?q?/ErmVVcOlK2G1kIk6ekQzh7cmq5p5j9CpQu/Ml98FeVKjxYro1Q79FAjk4Km?=
 =?us-ascii?q?45/MLkuwXNQguJ/XscT34ZkgFUDAjf7RH1RYn+vy3nvedgwiaaPMn2TbcpWT?=
 =?us-ascii?q?S+6qpgVRHlhDsbOzM/7WrakdJ7gr5Frx29phx/24/Ub5+TNPpiZaPWYNcWSX?=
 =?us-ascii?q?NcUspNSyBNB4WxYIUVD+oFIO1WsY/zqVUTphe6HAWgGufixjpOi3Tr36M1zv?=
 =?us-ascii?q?4hHBnb0gI+EdIAsHfaotv7O6gdU++60KbGwC7fb/5Uwzrx9JTEfx4jrPyKQL?=
 =?us-ascii?q?l+cdDRyU4qFw7dk1uQtZLqPyuV1usTtWiQ8vduVee1hG4jrwF+vDiuzdorh4?=
 =?us-ascii?q?nSm40V0UvJ9Tl5wYkpJd24T1R3Ydi/EJRKrS2aOIx2Qt07TmxupS00yaUGtI?=
 =?us-ascii?q?amcCUFx5kr3R7SZ+Gdf4SW7R/vSvydLSp+iXl4YrywnQyy/lKlyuDkU8m010?=
 =?us-ascii?q?tFoTRdn9nXs3ANywTT6s+aSvth5kuh2SiA1wTU6uxcPUA7j7DbK588wr4rjJ?=
 =?us-ascii?q?YTsELDHiHxmEXtkqCZal8o+vSo6uv7YrXmoYWQN4lohQHlLqsigMm/AeU8Mg?=
 =?us-ascii?q?QWXmib//qz1KH78EHkT7hHgec6n6nEvJzAO8gWqbC1DxVI3oo77hawFTam0N?=
 =?us-ascii?q?AWnXkdK1JFfQqKj5P0NFHVO/34Efe+jEiskDds3fzGOKbhDY/XInjMl7fhY6?=
 =?us-ascii?q?5x61RAxwor0dBf+5VUB6kdL/3pQU/+qtzZAwQiMwOow+boEsh91o0aWW2RGK?=
 =?us-ascii?q?+VKb/dvkWS6u0zJOmMYZcfuCzhJPg9+/7ukXg5lEcBcqazxpsYdnC5Eu59I0?=
 =?us-ascii?q?qFYXrjmMoBEWkOvgUgVuznk1yCUThPZ3msW6Iw/C00CIWjDY3bXICinKSB3D?=
 =?us-ascii?q?unHp1Rfm1GCFWMEXDyd4WeWvcMczmfIsl7nTwBS7ehSpUt1Ra0tA/107BnNP?=
 =?us-ascii?q?bb+jUEtZL/09h4/+nTlRA09TxpAMWRynqNQH9okWMVXT823bx/oExkxleG1q?=
 =?us-ascii?q?h3nuFYFdhN6P5STAc6OoDTz/ZgB9DxRA3BZNGJR0iiQtm8BjExVN0xyccUY0?=
 =?us-ascii?q?lhA9WikgzD3y2yDr8OibOLAJ008qTB33n+PMt91XnG27c7j1U8QctAK3emhq?=
 =?us-ascii?q?hh+AjXHYLJlF+Zl6myf6QGwCHN7HuDzXaJvExAUw5/T7vKXWsDaUvRqtT55V?=
 =?us-ascii?q?jPQKOuCbQ9NQtBzM+CKrZPatHzilVGXvjjMszEY22tg2ewGQqIxrSUYYrofG?=
 =?us-ascii?q?Ud3CPdBFIGkwAU/XaJLw4+Bjy/rGLYFzFhCUjgY0Xr8el4qXO0UlU7zwWQY0?=
 =?us-ascii?q?J90Lq1/wYfheaARPMLwrIEpCAhpi1sHFmj2dLWBMeApwtnfKlFYtMy/k1H1W?=
 =?us-ascii?q?THuAx5JZGgLrluhloZcwRpoUzizQ53BZ9Dkcg3tnMl1hB+KaSG319bdTOYxY?=
 =?us-ascii?q?j6OqfLJWnq4BCvd6nW10nG0NmM56cP7O81q035swG0Ekou6nBn095S03uG+J?=
 =?us-ascii?q?rGFhYdUZX0UhV/yx8vjLjBbzh13IjU3GBiNaSu+mvJ0skkFcM+wRapYtlbPb?=
 =?us-ascii?q?nBHwa0GMofUYzmI+UxlknvdRkENf1c8KMuF8Kga/aCnqWsOaIonjehl35G+6?=
 =?us-ascii?q?h720eB9mx7UOGMl5IExeyImxCKXCrmjUuw98XwlZ1AaBkMEWeljyvpHohcYu?=
 =?us-ascii?q?t1Z4lPQXyjJ8yx28VWmZHgQThb+USlCldA39WmKjSIaFmo5hFdzUQapzScnC?=
 =?us-ascii?q?K8yzFl22UyorG3wD3Fw+OkcgEOfGFMWj8x3h/XPYGogoVCDwCTZA8zmU7gvB?=
 =?us-ascii?q?yryg=3D=3D?=
X-IPAS-Result: =?us-ascii?q?A2DIAACeXPpd/wHyM5BlGwEBAQEBAQEFAQEBEQEBAwMBA?=
 =?us-ascii?q?QGBfIF2gW0gEiqEBIkDhlkGgTeJaooihyMJAQEBAQEBAQEBNwEBhEACgj04E?=
 =?us-ascii?q?wIQAQEBBAEBAQEBBQMBAWyFQ4I7KQGCegEFIwQRQRALGAICJgICVwYBDAYCA?=
 =?us-ascii?q?QGCXz+CUyWtcX8zhU+DPYFBgQ4ojDJ5gQeBEScPgl0+h1mCXgSNQolMRpc1g?=
 =?us-ascii?q?j+CQ5NKBhuaTi2OIZxfIoFYKwgCGAghD4MnUBgNm3YjAzCPLQEB?=
Received: from tarius.tycho.ncsc.mil (HELO tarius.infosec.tycho.ncsc.mil) ([144.51.242.1])
  by emsm-gh1-uea11.NCSC.MIL with ESMTP; 18 Dec 2019 17:10:30 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.infosec.tycho.ncsc.mil (8.14.7/8.14.4) with ESMTP id xBIHA7J2047077;
        Wed, 18 Dec 2019 12:10:09 -0500
Subject: Re: [PATCH v12 18/25] LSM: security_secid_to_secctx in netlink
 netfilter
To:     Casey Schaufler <casey@schaufler-ca.com>,
        casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com
References: <20191216223621.5127-1-casey@schaufler-ca.com>
 <20191216223621.5127-19-casey@schaufler-ca.com>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <5c5038f7-e523-78f8-2e81-5b4195d9cd94@tycho.nsa.gov>
Date:   Wed, 18 Dec 2019 12:10:58 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191216223621.5127-19-casey@schaufler-ca.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 12/16/19 5:36 PM, Casey Schaufler wrote:
> Change netlink netfilter interfaces to use lsmcontext
> pointers, and remove scaffolding.
> 
> Reviewed-by: Kees Cook <keescook@chromium.org>
> Reviewed-by: John Johansen <john.johansen@canonical.com>
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
> cc: netdev@vger.kernel.org

Acked-by: Stephen Smalley <sds@tycho.nsa.gov>

> ---
>   net/netfilter/nfnetlink_queue.c | 32 +++++++++++++-------------------
>   1 file changed, 13 insertions(+), 19 deletions(-)
> 
> diff --git a/net/netfilter/nfnetlink_queue.c b/net/netfilter/nfnetlink_queue.c
> index 2d6668fd026c..a1296453d8f2 100644
> --- a/net/netfilter/nfnetlink_queue.c
> +++ b/net/netfilter/nfnetlink_queue.c
> @@ -301,12 +301,10 @@ static int nfqnl_put_sk_uidgid(struct sk_buff *skb, struct sock *sk)
>   	return -1;
>   }
>   
> -static u32 nfqnl_get_sk_secctx(struct sk_buff *skb, char **secdata)
> +static u32 nfqnl_get_sk_secctx(struct sk_buff *skb, struct lsmcontext *context)
>   {
> -	u32 seclen = 0;
>   #if IS_ENABLED(CONFIG_NETWORK_SECMARK)
>   	struct lsmblob blob;
> -	struct lsmcontext context = { };
>   
>   	if (!skb || !sk_fullsock(skb->sk))
>   		return 0;
> @@ -314,15 +312,16 @@ static u32 nfqnl_get_sk_secctx(struct sk_buff *skb, char **secdata)
>   	read_lock_bh(&skb->sk->sk_callback_lock);
>   
>   	if (skb->secmark) {
> +		/* Any LSM might be looking for the secmark */
>   		lsmblob_init(&blob, skb->secmark);
> -		security_secid_to_secctx(&blob, &context);
> -		*secdata = context.context;
> +		security_secid_to_secctx(&blob, context);
>   	}
>   
>   	read_unlock_bh(&skb->sk->sk_callback_lock);
> -	seclen = context.len;
> +	return context->len;
> +#else
> +	return 0;
>   #endif
> -	return seclen;
>   }
>   
>   static u32 nfqnl_get_bridge_size(struct nf_queue_entry *entry)
> @@ -398,8 +397,7 @@ nfqnl_build_packet_message(struct net *net, struct nfqnl_instance *queue,
>   	enum ip_conntrack_info uninitialized_var(ctinfo);
>   	struct nfnl_ct_hook *nfnl_ct;
>   	bool csum_verify;
> -	struct lsmcontext scaff; /* scaffolding */
> -	char *secdata = NULL;
> +	struct lsmcontext context = { };
>   	u32 seclen = 0;
>   
>   	size = nlmsg_total_size(sizeof(struct nfgenmsg))
> @@ -466,7 +464,7 @@ nfqnl_build_packet_message(struct net *net, struct nfqnl_instance *queue,
>   	}
>   
>   	if ((queue->flags & NFQA_CFG_F_SECCTX) && entskb->sk) {
> -		seclen = nfqnl_get_sk_secctx(entskb, &secdata);
> +		seclen = nfqnl_get_sk_secctx(entskb, &context);
>   		if (seclen)
>   			size += nla_total_size(seclen);
>   	}
> @@ -601,7 +599,7 @@ nfqnl_build_packet_message(struct net *net, struct nfqnl_instance *queue,
>   	    nfqnl_put_sk_uidgid(skb, entskb->sk) < 0)
>   		goto nla_put_failure;
>   
> -	if (seclen && nla_put(skb, NFQA_SECCTX, seclen, secdata))
> +	if (seclen && nla_put(skb, NFQA_SECCTX, context.len, context.context))
>   		goto nla_put_failure;
>   
>   	if (ct && nfnl_ct->build(skb, ct, ctinfo, NFQA_CT, NFQA_CT_INFO) < 0)
> @@ -629,10 +627,8 @@ nfqnl_build_packet_message(struct net *net, struct nfqnl_instance *queue,
>   	}
>   
>   	nlh->nlmsg_len = skb->len;
> -	if (seclen) {
> -		lsmcontext_init(&scaff, secdata, seclen, 0);
> -		security_release_secctx(&scaff);
> -	}
> +	if (seclen)
> +		security_release_secctx(&context);
>   	return skb;
>   
>   nla_put_failure:
> @@ -640,10 +636,8 @@ nfqnl_build_packet_message(struct net *net, struct nfqnl_instance *queue,
>   	kfree_skb(skb);
>   	net_err_ratelimited("nf_queue: error creating packet message\n");
>   nlmsg_failure:
> -	if (seclen) {
> -		lsmcontext_init(&scaff, secdata, seclen, 0);
> -		security_release_secctx(&scaff);
> -	}
> +	if (seclen)
> +		security_release_secctx(&context);
>   	return NULL;
>   }
>   
> 

