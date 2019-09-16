Return-Path: <SRS0=qBB/=XL=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D84ACC49ED7
	for <selinux@archiver.kernel.org>; Mon, 16 Sep 2019 18:42:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76B2320830
	for <selinux@archiver.kernel.org>; Mon, 16 Sep 2019 18:42:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="OBb61I2V"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730036AbfIPSms (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 16 Sep 2019 14:42:48 -0400
Received: from UHIL19PA37.eemsg.mail.mil ([214.24.21.196]:47916 "EHLO
        UHIL19PA37.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730015AbfIPSmr (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 16 Sep 2019 14:42:47 -0400
X-EEMSG-check-017: 25836504|UHIL19PA37_ESA_OUT03.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.64,513,1559520000"; 
   d="scan'208";a="25836504"
Received: from emsm-gh1-uea11.ncsc.mil ([214.29.60.3])
  by UHIL19PA37.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 16 Sep 2019 18:42:42 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1568659362; x=1600195362;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=GYVDyBwJcJIbe2DWe3BgwXnSha4JiQAXCthnyZpJ98w=;
  b=OBb61I2VGHRv33iGkpwtW7wC7U3w7rZQoh0pc1A/4byTEM3ZvKcA7kcg
   JtWn8v6V6dCM8u7Pd3S7aqAVrw7CM1+meKUCrCpdLmjZW2wDcAKp/xZga
   /+L+G6LiyiqMukKSNcUwAjxXRRqVMYNnrxI+SQq8Bs+awTJGzMS7sRzaD
   /WDGkc1vnSQmduSi4THbW4oyyTJI2wU7KYrbfotS7szLkm/i6SP5b9VF6
   PpPxbhnvMDcM2lJaJrWksdRqcgkiV2uptBIidftcaHg5V9RymLWenzk4O
   cuSlnAj5wgWNwdf9ugvQVH5SDZJ9luurGlWlJcUR2OcCGm1p49vgdeTOO
   A==;
X-IronPort-AV: E=Sophos;i="5.64,513,1559520000"; 
   d="scan'208";a="32910585"
IronPort-PHdr: =?us-ascii?q?9a23=3AmfpSSRNNY4L4sfDFqPsl6mtUPXoX/o7sNwtQ0K?=
 =?us-ascii?q?IMzox0K/jypsbcNUDSrc9gkEXOFd2Cra4d0KyP6Ou5AzNIoc7Y9ixbKtoUD1?=
 =?us-ascii?q?5NoP5VtjRoONSCB0z/IayiRA0BN+MGamVY+WqmO1NeAsf0ag6aiHSz6TkPBk?=
 =?us-ascii?q?e3blItdaz6FYHIksu4yf259YHNbAVUnjq9Zq55IAmroQnLucQanIVvJrwsxh?=
 =?us-ascii?q?bHrXdEZvpayGF1Ll6Xgxrw+9288ZF+/yhOof4t69JMXaDndKkkULJUCygrPX?=
 =?us-ascii?q?oo78PxrxnDSgWP5noYUmoIlxdDHhbI4hLnUJrvqyX2ruVy1jWUMs3wVrA0RC?=
 =?us-ascii?q?+t77x3Rx/yiScILCA2/WfKgcFtlq1boRahpxtiw47IZYyeKfRzcr/Bcd4cWG?=
 =?us-ascii?q?FMRdhaWTBfDYygbosPF+sBMvher4nhvFsFsB+yCRCxCO/z1jNEg3n70qMg0+?=
 =?us-ascii?q?QlDArIwgouEdwTu3jQtdn5KqMfXeWzwaLVzzvMculW1C/g5obWfBAvofKCU7?=
 =?us-ascii?q?x+fsXey0YgCwzLg06MqYHnJT6ZyvgBvmaZ4udmSOmhi3QnqwZ0ojW328kslp?=
 =?us-ascii?q?fGhpoVyl/a8yVy3Zs7JdiiR05/Zd6rDptRvDydOottX8wiWHpluDo6y7IauZ?=
 =?us-ascii?q?67ezIGyJI8xxHFcfCHfI+I4gz6WeuXPDx2h2pldaqiixu9/kWs0O3xWtSu3F?=
 =?us-ascii?q?pUoSdJjMPAum0L2hfO8MaIUOF98V2k2TuX0gDT7fxLLl4smKrALp4h3qYwlp?=
 =?us-ascii?q?0OsUTfBiP2mFv5jKuRdkg85uin8f7nYrT7pp+HLYN0lgH/Pbgumsy4G+g4NB?=
 =?us-ascii?q?QBX3OH9uim0b3j/En5TK1Ljv0wjKbZrIjXKdkUq6O2GQNY0psv5wyhAzqpzt?=
 =?us-ascii?q?gUh2QLIEpAeB2djojpP1/OIOr/Dfe6m1msiypkx+vdM739ApTCMnjDkLD7cb?=
 =?us-ascii?q?Z78E5T0hA/zd9Y55JKEr0BOu78WlfttNzECR80KxC7zPz8CNpj1oITQnmPDb?=
 =?us-ascii?q?OZMKzIrF+I6OYvLPeWZIMMpDnyMeIp6OLpjX88gVUdZ7Wm3YMLaHCkGfRrO1?=
 =?us-ascii?q?mWbmD3gtgfEWYGpBE+Q/DqiFKYTD5TaXKyULwm5jwgCYKmC5vDSZ6pgLCbwC?=
 =?us-ascii?q?i7GZhWbHhcCl+QCXfoa5mEW/AUZSKQJ89hlSYEVaKgS486zhyushX1y795Ie?=
 =?us-ascii?q?rV4CEYsojj1Ndt7e3JiR4y7SB0D9ia02yVS2F0n2UIRyI53axmukxy1EuM0b?=
 =?us-ascii?q?Vig/xZCdxS5+pFUgI9NZHB0ux6D879VxnffteGVlmmWM+qATIvQdIrxd8BfU?=
 =?us-ascii?q?J9F8+ljhDZ0CqgG6UVmKCTBJwo7qLc2GD8J91jxHbC1akhiUQmQ8RUOG24ia?=
 =?us-ascii?q?5w6RLTC5TKk0qHjaaqc7oT3CrX+GeE12qOs1lSUBRsXqXdQXAfekzWoMz65k?=
 =?us-ascii?q?zcUbCuEqgoMgxGyc6BMaZFdt3pjU9BRPfmOdTefmexl323BRaSybOGdJDqdH?=
 =?us-ascii?q?kF3CXBFEgElBge/XSBNQg+ACetuWDeDDtuFV31ZUPs6vdxqHWgQ0Ao1Q6KaU?=
 =?us-ascii?q?ph17y0+hEJn/OcT+kf0a4DuCcksz90Bkqy38rKC9qcoApsZL1cbs074FdIyG?=
 =?us-ascii?q?LZtgp9MoWjL698nF4edRp4v0f12hV2E4lAlc8qrG00wwZoMqKXylBBdy6C3Z?=
 =?us-ascii?q?/qILHXLHf98Aqta67OwlveysqZ+r8T6PQkrFXupBmpGVA/83VjyNRVy2GT5o?=
 =?us-ascii?q?jODAYLVJLxVUE39wJkqL3AfiY94IbUhjVQNvyfuyTPypoSD+ss1xikcs0XZK?=
 =?us-ascii?q?iNDwLjO9YRB8GzJugngR2iZ1QPO+UEsOY/NtirZr2d066iIehkkSiOjGJb7Y?=
 =?us-ascii?q?Q72UWJs2J+T+nSxZce6/eR2waGETDmgxPptsHxhJABfjwZA3C+1TmhAYlde6?=
 =?us-ascii?q?l/VZgEBH3oIMCtwNh6wZn3VDoQ71OnBlUbyOe3dheIKV/wxwtd0QIQu3P0tz?=
 =?us-ascii?q?G/ymlPjzwxrqeZlBfLyuDmeQtPbnVHX0F+nFzsJs6ylNlcU0+2OVt63CC57F?=
 =?us-ascii?q?r3kvAI7J90KHPeFAIRJXn7?=
X-IPAS-Result: =?us-ascii?q?A2DFBwAN139d/wHyM5BmHAEBAQQBAQcEAQGBZ4FuKm1SA?=
 =?us-ascii?q?TIqhCGOUYEFAQEBAQEBBoERJX6IdY9AgWcJAQEBAQEBAQEBIxEBAgEBhD8Cg?=
 =?us-ascii?q?m8jOBMCDAEBAQQBAQEBAQUDAQFshS4MgjopAYJmAQEBAQIBGgEIBBFBEAsYA?=
 =?us-ascii?q?gImAgJXBgEMBgIBAYJfPwGBdgUPrTt/M4VMgzKBSYEMKIt4GHiBBxJ/JwyCK?=
 =?us-ascii?q?jU+gReDFQYSgwuCWASMXQYEiCxegTKVR4Isgi6EV411BhuZGY4JlSqFaSGBW?=
 =?us-ascii?q?CsIAhgIIQ+DJwmCRReIKIYWJAMwgQYBAY9uAQE?=
Received: from tarius.tycho.ncsc.mil ([144.51.242.1])
  by emsm-gh1-uea11.NCSC.MIL with ESMTP; 16 Sep 2019 18:42:41 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id x8GIgd0h011626;
        Mon, 16 Sep 2019 14:42:39 -0400
Subject: Re: [PATCH v8 02/28] LSM: Infrastructure management of the sock
 security
To:     Casey Schaufler <casey@schaufler-ca.com>,
        casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com
References: <20190829232935.7099-1-casey@schaufler-ca.com>
 <20190829232935.7099-3-casey@schaufler-ca.com>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <5fde58fe-3925-c9d6-39bf-9adb318f7186@tycho.nsa.gov>
Date:   Mon, 16 Sep 2019 14:42:39 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190829232935.7099-3-casey@schaufler-ca.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 8/29/19 7:29 PM, Casey Schaufler wrote:
> Move management of the sock->sk_security blob out
> of the individual security modules and into the security
> infrastructure. Instead of allocating the blobs from within
> the modules the modules tell the infrastructure how much
> space is required, and the space is allocated there.
> 
> Reviewed-by: Kees Cook <keescook@chromium.org>
> Reviewed-by: John Johansen <john.johansen@canonical.com>
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>

One oddity noted below, but it isn't introduced by this patch so you can 
add my:

Reviewed-by: Stephen Smalley <sds@tycho.nsa.gov>

> ---
>   include/linux/lsm_hooks.h         |  1 +
>   security/apparmor/include/net.h   |  6 ++-
>   security/apparmor/lsm.c           | 38 ++++-----------
>   security/security.c               | 36 +++++++++++++-
>   security/selinux/hooks.c          | 78 +++++++++++++++----------------
>   security/selinux/include/objsec.h |  5 ++
>   security/selinux/netlabel.c       | 23 ++++-----
>   security/smack/smack.h            |  5 ++
>   security/smack/smack_lsm.c        | 64 ++++++++++++-------------
>   security/smack/smack_netfilter.c  |  8 ++--
>   10 files changed, 144 insertions(+), 120 deletions(-)
> 
> diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
> index f9222a04968d..b353482ea348 100644
> --- a/include/linux/lsm_hooks.h
> +++ b/include/linux/lsm_hooks.h
> @@ -2047,6 +2047,7 @@ struct lsm_blob_sizes {
>   	int	lbs_cred;
>   	int	lbs_file;
>   	int	lbs_inode;
> +	int	lbs_sock;
>   	int	lbs_superblock;
>   	int	lbs_ipc;
>   	int	lbs_msg_msg;
> diff --git a/security/apparmor/include/net.h b/security/apparmor/include/net.h
> index 7334ac966d01..adac04e3b3cc 100644
> --- a/security/apparmor/include/net.h
> +++ b/security/apparmor/include/net.h
> @@ -55,7 +55,11 @@ struct aa_sk_ctx {
>   	struct aa_label *peer;
>   };
>   
> -#define SK_CTX(X) ((X)->sk_security)
> +static inline struct aa_sk_ctx *aa_sock(const struct sock *sk)
> +{
> +	return sk->sk_security + apparmor_blob_sizes.lbs_sock;
> +}
> +
>   #define SOCK_ctx(X) SOCK_INODE(X)->i_security

This use of i_security looks suspicious, but SOCK_ctx doesn't appear to 
be used presently.  Probably should be removed in a separate patch.

>   #define DEFINE_AUDIT_NET(NAME, OP, SK, F, T, P)				  \
>   	struct lsm_network_audit NAME ## _net = { .sk = (SK),		  \
> diff --git a/security/apparmor/lsm.c b/security/apparmor/lsm.c
> index 49d664ddff44..2716e7731279 100644
> --- a/security/apparmor/lsm.c
> +++ b/security/apparmor/lsm.c
> @@ -757,33 +757,15 @@ static int apparmor_task_kill(struct task_struct *target, struct kernel_siginfo
>   	return error;
>   }
>   
> -/**
> - * apparmor_sk_alloc_security - allocate and attach the sk_security field
> - */
> -static int apparmor_sk_alloc_security(struct sock *sk, int family, gfp_t flags)
> -{
> -	struct aa_sk_ctx *ctx;
> -
> -	ctx = kzalloc(sizeof(*ctx), flags);
> -	if (!ctx)
> -		return -ENOMEM;
> -
> -	SK_CTX(sk) = ctx;
> -
> -	return 0;
> -}
> -
>   /**
>    * apparmor_sk_free_security - free the sk_security field
>    */
>   static void apparmor_sk_free_security(struct sock *sk)
>   {
> -	struct aa_sk_ctx *ctx = SK_CTX(sk);
> +	struct aa_sk_ctx *ctx = aa_sock(sk);
>   
> -	SK_CTX(sk) = NULL;
>   	aa_put_label(ctx->label);
>   	aa_put_label(ctx->peer);
> -	kfree(ctx);
>   }
>   
>   /**
> @@ -792,8 +774,8 @@ static void apparmor_sk_free_security(struct sock *sk)
>   static void apparmor_sk_clone_security(const struct sock *sk,
>   				       struct sock *newsk)
>   {
> -	struct aa_sk_ctx *ctx = SK_CTX(sk);
> -	struct aa_sk_ctx *new = SK_CTX(newsk);
> +	struct aa_sk_ctx *ctx = aa_sock(sk);
> +	struct aa_sk_ctx *new = aa_sock(newsk);
>   
>   	new->label = aa_get_label(ctx->label);
>   	new->peer = aa_get_label(ctx->peer);
> @@ -844,7 +826,7 @@ static int apparmor_socket_post_create(struct socket *sock, int family,
>   		label = aa_get_current_label();
>   
>   	if (sock->sk) {
> -		struct aa_sk_ctx *ctx = SK_CTX(sock->sk);
> +		struct aa_sk_ctx *ctx = aa_sock(sock->sk);
>   
>   		aa_put_label(ctx->label);
>   		ctx->label = aa_get_label(label);
> @@ -1029,7 +1011,7 @@ static int apparmor_socket_shutdown(struct socket *sock, int how)
>    */
>   static int apparmor_socket_sock_rcv_skb(struct sock *sk, struct sk_buff *skb)
>   {
> -	struct aa_sk_ctx *ctx = SK_CTX(sk);
> +	struct aa_sk_ctx *ctx = aa_sock(sk);
>   
>   	if (!skb->secmark)
>   		return 0;
> @@ -1042,7 +1024,7 @@ static int apparmor_socket_sock_rcv_skb(struct sock *sk, struct sk_buff *skb)
>   
>   static struct aa_label *sk_peer_label(struct sock *sk)
>   {
> -	struct aa_sk_ctx *ctx = SK_CTX(sk);
> +	struct aa_sk_ctx *ctx = aa_sock(sk);
>   
>   	if (ctx->peer)
>   		return ctx->peer;
> @@ -1126,7 +1108,7 @@ static int apparmor_socket_getpeersec_dgram(struct socket *sock,
>    */
>   static void apparmor_sock_graft(struct sock *sk, struct socket *parent)
>   {
> -	struct aa_sk_ctx *ctx = SK_CTX(sk);
> +	struct aa_sk_ctx *ctx = aa_sock(sk);
>   
>   	if (!ctx->label)
>   		ctx->label = aa_get_current_label();
> @@ -1136,7 +1118,7 @@ static void apparmor_sock_graft(struct sock *sk, struct socket *parent)
>   static int apparmor_inet_conn_request(struct sock *sk, struct sk_buff *skb,
>   				      struct request_sock *req)
>   {
> -	struct aa_sk_ctx *ctx = SK_CTX(sk);
> +	struct aa_sk_ctx *ctx = aa_sock(sk);
>   
>   	if (!skb->secmark)
>   		return 0;
> @@ -1153,6 +1135,7 @@ struct lsm_blob_sizes apparmor_blob_sizes __lsm_ro_after_init = {
>   	.lbs_cred = sizeof(struct aa_task_ctx *),
>   	.lbs_file = sizeof(struct aa_file_ctx),
>   	.lbs_task = sizeof(struct aa_task_ctx),
> +	.lbs_sock = sizeof(struct aa_sk_ctx),
>   };
>   
>   static struct security_hook_list apparmor_hooks[] __lsm_ro_after_init = {
> @@ -1189,7 +1172,6 @@ static struct security_hook_list apparmor_hooks[] __lsm_ro_after_init = {
>   	LSM_HOOK_INIT(getprocattr, apparmor_getprocattr),
>   	LSM_HOOK_INIT(setprocattr, apparmor_setprocattr),
>   
> -	LSM_HOOK_INIT(sk_alloc_security, apparmor_sk_alloc_security),
>   	LSM_HOOK_INIT(sk_free_security, apparmor_sk_free_security),
>   	LSM_HOOK_INIT(sk_clone_security, apparmor_sk_clone_security),
>   
> @@ -1581,7 +1563,7 @@ static unsigned int apparmor_ip_postroute(void *priv,
>   	if (sk == NULL)
>   		return NF_ACCEPT;
>   
> -	ctx = SK_CTX(sk);
> +	ctx = aa_sock(sk);
>   	if (!apparmor_secmark_check(ctx->label, OP_SENDMSG, AA_MAY_SEND,
>   				    skb->secmark, sk))
>   		return NF_ACCEPT;
> diff --git a/security/security.c b/security/security.c
> index 86198e303203..2c0834db7976 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -32,6 +32,7 @@
>   #include <linux/string.h>
>   #include <linux/msg.h>
>   #include <net/flow.h>
> +#include <net/sock.h>
>   
>   #define MAX_LSM_EVM_XATTR	2
>   
> @@ -172,6 +173,7 @@ static void __init lsm_set_blob_sizes(struct lsm_blob_sizes *needed)
>   	lsm_set_blob_size(&needed->lbs_inode, &blob_sizes.lbs_inode);
>   	lsm_set_blob_size(&needed->lbs_ipc, &blob_sizes.lbs_ipc);
>   	lsm_set_blob_size(&needed->lbs_msg_msg, &blob_sizes.lbs_msg_msg);
> +	lsm_set_blob_size(&needed->lbs_sock, &blob_sizes.lbs_sock);
>   	lsm_set_blob_size(&needed->lbs_superblock, &blob_sizes.lbs_superblock);
>   	lsm_set_blob_size(&needed->lbs_task, &blob_sizes.lbs_task);
>   }
> @@ -306,6 +308,7 @@ static void __init ordered_lsm_init(void)
>   	init_debug("inode blob size      = %d\n", blob_sizes.lbs_inode);
>   	init_debug("ipc blob size        = %d\n", blob_sizes.lbs_ipc);
>   	init_debug("msg_msg blob size    = %d\n", blob_sizes.lbs_msg_msg);
> +	init_debug("sock blob size       = %d\n", blob_sizes.lbs_sock);
>   	init_debug("superblock blob size = %d\n", blob_sizes.lbs_superblock);
>   	init_debug("task blob size       = %d\n", blob_sizes.lbs_task);
>   
> @@ -605,6 +608,28 @@ static void __init lsm_early_task(struct task_struct *task)
>   		panic("%s: Early task alloc failed.\n", __func__);
>   }
>   
> +/**
> + * lsm_sock_alloc - allocate a composite sock blob
> + * @sock: the sock that needs a blob
> + * @priority: allocation mode
> + *
> + * Allocate the sock blob for all the modules
> + *
> + * Returns 0, or -ENOMEM if memory can't be allocated.
> + */
> +static int lsm_sock_alloc(struct sock *sock, gfp_t priority)
> +{
> +	if (blob_sizes.lbs_sock == 0) {
> +		sock->sk_security = NULL;
> +		return 0;
> +	}
> +
> +	sock->sk_security = kzalloc(blob_sizes.lbs_sock, priority);
> +	if (sock->sk_security == NULL)
> +		return -ENOMEM;
> +	return 0;
> +}
> +
>   /**
>    * lsm_superblock_alloc - allocate a composite superblock blob
>    * @sb: the superblock that needs a blob
> @@ -2048,12 +2073,21 @@ EXPORT_SYMBOL(security_socket_getpeersec_dgram);
>   
>   int security_sk_alloc(struct sock *sk, int family, gfp_t priority)
>   {
> -	return call_int_hook(sk_alloc_security, 0, sk, family, priority);
> +	int rc = lsm_sock_alloc(sk, priority);
> +
> +	if (unlikely(rc))
> +		return rc;
> +	rc = call_int_hook(sk_alloc_security, 0, sk, family, priority);
> +	if (unlikely(rc))
> +		security_sk_free(sk);
> +	return rc;
>   }
>   
>   void security_sk_free(struct sock *sk)
>   {
>   	call_void_hook(sk_free_security, sk);
> +	kfree(sk->sk_security);
> +	sk->sk_security = NULL;
>   }
>   
>   void security_sk_clone(const struct sock *sk, struct sock *newsk)
> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index 7478d8eda00a..5d74ed35b728 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -4319,7 +4319,7 @@ static int socket_sockcreate_sid(const struct task_security_struct *tsec,
>   
>   static int sock_has_perm(struct sock *sk, u32 perms)
>   {
> -	struct sk_security_struct *sksec = sk->sk_security;
> +	struct sk_security_struct *sksec = selinux_sock(sk);
>   	struct common_audit_data ad;
>   	struct lsm_network_audit net = {0,};
>   
> @@ -4376,7 +4376,7 @@ static int selinux_socket_post_create(struct socket *sock, int family,
>   	isec->initialized = LABEL_INITIALIZED;
>   
>   	if (sock->sk) {
> -		sksec = sock->sk->sk_security;
> +		sksec = selinux_sock(sock->sk);
>   		sksec->sclass = sclass;
>   		sksec->sid = sid;
>   		/* Allows detection of the first association on this socket */
> @@ -4392,8 +4392,8 @@ static int selinux_socket_post_create(struct socket *sock, int family,
>   static int selinux_socket_socketpair(struct socket *socka,
>   				     struct socket *sockb)
>   {
> -	struct sk_security_struct *sksec_a = socka->sk->sk_security;
> -	struct sk_security_struct *sksec_b = sockb->sk->sk_security;
> +	struct sk_security_struct *sksec_a = selinux_sock(socka->sk);
> +	struct sk_security_struct *sksec_b = selinux_sock(sockb->sk);
>   
>   	sksec_a->peer_sid = sksec_b->sid;
>   	sksec_b->peer_sid = sksec_a->sid;
> @@ -4408,7 +4408,7 @@ static int selinux_socket_socketpair(struct socket *socka,
>   static int selinux_socket_bind(struct socket *sock, struct sockaddr *address, int addrlen)
>   {
>   	struct sock *sk = sock->sk;
> -	struct sk_security_struct *sksec = sk->sk_security;
> +	struct sk_security_struct *sksec = selinux_sock(sk);
>   	u16 family;
>   	int err;
>   
> @@ -4540,7 +4540,7 @@ static int selinux_socket_connect_helper(struct socket *sock,
>   					 struct sockaddr *address, int addrlen)
>   {
>   	struct sock *sk = sock->sk;
> -	struct sk_security_struct *sksec = sk->sk_security;
> +	struct sk_security_struct *sksec = selinux_sock(sk);
>   	int err;
>   
>   	err = sock_has_perm(sk, SOCKET__CONNECT);
> @@ -4711,9 +4711,9 @@ static int selinux_socket_unix_stream_connect(struct sock *sock,
>   					      struct sock *other,
>   					      struct sock *newsk)
>   {
> -	struct sk_security_struct *sksec_sock = sock->sk_security;
> -	struct sk_security_struct *sksec_other = other->sk_security;
> -	struct sk_security_struct *sksec_new = newsk->sk_security;
> +	struct sk_security_struct *sksec_sock = selinux_sock(sock);
> +	struct sk_security_struct *sksec_other = selinux_sock(other);
> +	struct sk_security_struct *sksec_new = selinux_sock(newsk);
>   	struct common_audit_data ad;
>   	struct lsm_network_audit net = {0,};
>   	int err;
> @@ -4745,8 +4745,8 @@ static int selinux_socket_unix_stream_connect(struct sock *sock,
>   static int selinux_socket_unix_may_send(struct socket *sock,
>   					struct socket *other)
>   {
> -	struct sk_security_struct *ssec = sock->sk->sk_security;
> -	struct sk_security_struct *osec = other->sk->sk_security;
> +	struct sk_security_struct *ssec = selinux_sock(sock->sk);
> +	struct sk_security_struct *osec = selinux_sock(other->sk);
>   	struct common_audit_data ad;
>   	struct lsm_network_audit net = {0,};
>   
> @@ -4788,7 +4788,7 @@ static int selinux_sock_rcv_skb_compat(struct sock *sk, struct sk_buff *skb,
>   				       u16 family)
>   {
>   	int err = 0;
> -	struct sk_security_struct *sksec = sk->sk_security;
> +	struct sk_security_struct *sksec = selinux_sock(sk);
>   	u32 sk_sid = sksec->sid;
>   	struct common_audit_data ad;
>   	struct lsm_network_audit net = {0,};
> @@ -4821,7 +4821,7 @@ static int selinux_sock_rcv_skb_compat(struct sock *sk, struct sk_buff *skb,
>   static int selinux_socket_sock_rcv_skb(struct sock *sk, struct sk_buff *skb)
>   {
>   	int err;
> -	struct sk_security_struct *sksec = sk->sk_security;
> +	struct sk_security_struct *sksec = selinux_sock(sk);
>   	u16 family = sk->sk_family;
>   	u32 sk_sid = sksec->sid;
>   	struct common_audit_data ad;
> @@ -4889,13 +4889,15 @@ static int selinux_socket_sock_rcv_skb(struct sock *sk, struct sk_buff *skb)
>   	return err;
>   }
>   
> -static int selinux_socket_getpeersec_stream(struct socket *sock, char __user *optval,
> -					    int __user *optlen, unsigned len)
> +static int selinux_socket_getpeersec_stream(struct socket *sock,
> +					    char __user *optval,
> +					    int __user *optlen,
> +					    unsigned int len)
>   {
>   	int err = 0;
>   	char *scontext;
>   	u32 scontext_len;
> -	struct sk_security_struct *sksec = sock->sk->sk_security;
> +	struct sk_security_struct *sksec = selinux_sock(sock->sk);
>   	u32 peer_sid = SECSID_NULL;
>   
>   	if (sksec->sclass == SECCLASS_UNIX_STREAM_SOCKET ||
> @@ -4955,34 +4957,27 @@ static int selinux_socket_getpeersec_dgram(struct socket *sock, struct sk_buff *
>   
>   static int selinux_sk_alloc_security(struct sock *sk, int family, gfp_t priority)
>   {
> -	struct sk_security_struct *sksec;
> -
> -	sksec = kzalloc(sizeof(*sksec), priority);
> -	if (!sksec)
> -		return -ENOMEM;
> +	struct sk_security_struct *sksec = selinux_sock(sk);
>   
>   	sksec->peer_sid = SECINITSID_UNLABELED;
>   	sksec->sid = SECINITSID_UNLABELED;
>   	sksec->sclass = SECCLASS_SOCKET;
>   	selinux_netlbl_sk_security_reset(sksec);
> -	sk->sk_security = sksec;
>   
>   	return 0;
>   }
>   
>   static void selinux_sk_free_security(struct sock *sk)
>   {
> -	struct sk_security_struct *sksec = sk->sk_security;
> +	struct sk_security_struct *sksec = selinux_sock(sk);
>   
> -	sk->sk_security = NULL;
>   	selinux_netlbl_sk_security_free(sksec);
> -	kfree(sksec);
>   }
>   
>   static void selinux_sk_clone_security(const struct sock *sk, struct sock *newsk)
>   {
> -	struct sk_security_struct *sksec = sk->sk_security;
> -	struct sk_security_struct *newsksec = newsk->sk_security;
> +	struct sk_security_struct *sksec = selinux_sock(sk);
> +	struct sk_security_struct *newsksec = selinux_sock(newsk);
>   
>   	newsksec->sid = sksec->sid;
>   	newsksec->peer_sid = sksec->peer_sid;
> @@ -4996,7 +4991,7 @@ static void selinux_sk_getsecid(struct sock *sk, u32 *secid)
>   	if (!sk)
>   		*secid = SECINITSID_ANY_SOCKET;
>   	else {
> -		struct sk_security_struct *sksec = sk->sk_security;
> +		struct sk_security_struct *sksec = selinux_sock(sk);
>   
>   		*secid = sksec->sid;
>   	}
> @@ -5006,7 +5001,7 @@ static void selinux_sock_graft(struct sock *sk, struct socket *parent)
>   {
>   	struct inode_security_struct *isec =
>   		inode_security_novalidate(SOCK_INODE(parent));
> -	struct sk_security_struct *sksec = sk->sk_security;
> +	struct sk_security_struct *sksec = selinux_sock(sk);
>   
>   	if (sk->sk_family == PF_INET || sk->sk_family == PF_INET6 ||
>   	    sk->sk_family == PF_UNIX)
> @@ -5021,7 +5016,7 @@ static void selinux_sock_graft(struct sock *sk, struct socket *parent)
>   static int selinux_sctp_assoc_request(struct sctp_endpoint *ep,
>   				      struct sk_buff *skb)
>   {
> -	struct sk_security_struct *sksec = ep->base.sk->sk_security;
> +	struct sk_security_struct *sksec = selinux_sock(ep->base.sk);
>   	struct common_audit_data ad;
>   	struct lsm_network_audit net = {0,};
>   	u8 peerlbl_active;
> @@ -5172,8 +5167,8 @@ static int selinux_sctp_bind_connect(struct sock *sk, int optname,
>   static void selinux_sctp_sk_clone(struct sctp_endpoint *ep, struct sock *sk,
>   				  struct sock *newsk)
>   {
> -	struct sk_security_struct *sksec = sk->sk_security;
> -	struct sk_security_struct *newsksec = newsk->sk_security;
> +	struct sk_security_struct *sksec = selinux_sock(sk);
> +	struct sk_security_struct *newsksec = selinux_sock(newsk);
>   
>   	/* If policy does not support SECCLASS_SCTP_SOCKET then call
>   	 * the non-sctp clone version.
> @@ -5190,7 +5185,7 @@ static void selinux_sctp_sk_clone(struct sctp_endpoint *ep, struct sock *sk,
>   static int selinux_inet_conn_request(struct sock *sk, struct sk_buff *skb,
>   				     struct request_sock *req)
>   {
> -	struct sk_security_struct *sksec = sk->sk_security;
> +	struct sk_security_struct *sksec = selinux_sock(sk);
>   	int err;
>   	u16 family = req->rsk_ops->family;
>   	u32 connsid;
> @@ -5211,7 +5206,7 @@ static int selinux_inet_conn_request(struct sock *sk, struct sk_buff *skb,
>   static void selinux_inet_csk_clone(struct sock *newsk,
>   				   const struct request_sock *req)
>   {
> -	struct sk_security_struct *newsksec = newsk->sk_security;
> +	struct sk_security_struct *newsksec = selinux_sock(newsk);
>   
>   	newsksec->sid = req->secid;
>   	newsksec->peer_sid = req->peer_secid;
> @@ -5228,7 +5223,7 @@ static void selinux_inet_csk_clone(struct sock *newsk,
>   static void selinux_inet_conn_established(struct sock *sk, struct sk_buff *skb)
>   {
>   	u16 family = sk->sk_family;
> -	struct sk_security_struct *sksec = sk->sk_security;
> +	struct sk_security_struct *sksec = selinux_sock(sk);
>   
>   	/* handle mapped IPv4 packets arriving via IPv6 sockets */
>   	if (family == PF_INET6 && skb->protocol == htons(ETH_P_IP))
> @@ -5312,7 +5307,7 @@ static int selinux_tun_dev_attach_queue(void *security)
>   static int selinux_tun_dev_attach(struct sock *sk, void *security)
>   {
>   	struct tun_security_struct *tunsec = security;
> -	struct sk_security_struct *sksec = sk->sk_security;
> +	struct sk_security_struct *sksec = selinux_sock(sk);
>   
>   	/* we don't currently perform any NetLabel based labeling here and it
>   	 * isn't clear that we would want to do so anyway; while we could apply
> @@ -5353,7 +5348,7 @@ static int selinux_nlmsg_perm(struct sock *sk, struct sk_buff *skb)
>   	int err = 0;
>   	u32 perm;
>   	struct nlmsghdr *nlh;
> -	struct sk_security_struct *sksec = sk->sk_security;
> +	struct sk_security_struct *sksec = selinux_sock(sk);
>   
>   	if (skb->len < NLMSG_HDRLEN) {
>   		err = -EINVAL;
> @@ -5494,7 +5489,7 @@ static unsigned int selinux_ip_output(struct sk_buff *skb,
>   			return NF_ACCEPT;
>   
>   		/* standard practice, label using the parent socket */
> -		sksec = sk->sk_security;
> +		sksec = selinux_sock(sk);
>   		sid = sksec->sid;
>   	} else
>   		sid = SECINITSID_KERNEL;
> @@ -5533,7 +5528,7 @@ static unsigned int selinux_ip_postroute_compat(struct sk_buff *skb,
>   
>   	if (sk == NULL)
>   		return NF_ACCEPT;
> -	sksec = sk->sk_security;
> +	sksec = selinux_sock(sk);
>   
>   	ad.type = LSM_AUDIT_DATA_NET;
>   	ad.u.net = &net;
> @@ -5625,7 +5620,7 @@ static unsigned int selinux_ip_postroute(struct sk_buff *skb,
>   		u32 skb_sid;
>   		struct sk_security_struct *sksec;
>   
> -		sksec = sk->sk_security;
> +		sksec = selinux_sock(sk);
>   		if (selinux_skb_peerlbl_sid(skb, family, &skb_sid))
>   			return NF_DROP;
>   		/* At this point, if the returned skb peerlbl is SECSID_NULL
> @@ -5654,7 +5649,7 @@ static unsigned int selinux_ip_postroute(struct sk_buff *skb,
>   	} else {
>   		/* Locally generated packet, fetch the security label from the
>   		 * associated socket. */
> -		struct sk_security_struct *sksec = sk->sk_security;
> +		struct sk_security_struct *sksec = selinux_sock(sk);
>   		peer_sid = sksec->sid;
>   		secmark_perm = PACKET__SEND;
>   	}
> @@ -6633,6 +6628,7 @@ struct lsm_blob_sizes selinux_blob_sizes __lsm_ro_after_init = {
>   	.lbs_inode = sizeof(struct inode_security_struct),
>   	.lbs_ipc = sizeof(struct ipc_security_struct),
>   	.lbs_msg_msg = sizeof(struct msg_security_struct),
> +	.lbs_sock = sizeof(struct sk_security_struct),
>   	.lbs_superblock = sizeof(struct superblock_security_struct),
>   };
>   
> diff --git a/security/selinux/include/objsec.h b/security/selinux/include/objsec.h
> index d08d7e5d2f93..29f02b8f8f31 100644
> --- a/security/selinux/include/objsec.h
> +++ b/security/selinux/include/objsec.h
> @@ -194,4 +194,9 @@ static inline struct superblock_security_struct *selinux_superblock(
>   	return superblock->s_security + selinux_blob_sizes.lbs_superblock;
>   }
>   
> +static inline struct sk_security_struct *selinux_sock(const struct sock *sock)
> +{
> +	return sock->sk_security + selinux_blob_sizes.lbs_sock;
> +}
> +
>   #endif /* _SELINUX_OBJSEC_H_ */
> diff --git a/security/selinux/netlabel.c b/security/selinux/netlabel.c
> index 186e727b737b..c40914a157b7 100644
> --- a/security/selinux/netlabel.c
> +++ b/security/selinux/netlabel.c
> @@ -31,6 +31,7 @@
>   #include <linux/gfp.h>
>   #include <linux/ip.h>
>   #include <linux/ipv6.h>
> +#include <linux/lsm_hooks.h>
>   #include <net/sock.h>
>   #include <net/netlabel.h>
>   #include <net/ip.h>
> @@ -81,7 +82,7 @@ static int selinux_netlbl_sidlookup_cached(struct sk_buff *skb,
>   static struct netlbl_lsm_secattr *selinux_netlbl_sock_genattr(struct sock *sk)
>   {
>   	int rc;
> -	struct sk_security_struct *sksec = sk->sk_security;
> +	struct sk_security_struct *sksec = selinux_sock(sk);
>   	struct netlbl_lsm_secattr *secattr;
>   
>   	if (sksec->nlbl_secattr != NULL)
> @@ -114,7 +115,7 @@ static struct netlbl_lsm_secattr *selinux_netlbl_sock_getattr(
>   							const struct sock *sk,
>   							u32 sid)
>   {
> -	struct sk_security_struct *sksec = sk->sk_security;
> +	struct sk_security_struct *sksec = selinux_sock(sk);
>   	struct netlbl_lsm_secattr *secattr = sksec->nlbl_secattr;
>   
>   	if (secattr == NULL)
> @@ -249,7 +250,7 @@ int selinux_netlbl_skbuff_setsid(struct sk_buff *skb,
>   	 * being labeled by it's parent socket, if it is just exit */
>   	sk = skb_to_full_sk(skb);
>   	if (sk != NULL) {
> -		struct sk_security_struct *sksec = sk->sk_security;
> +		struct sk_security_struct *sksec = selinux_sock(sk);
>   
>   		if (sksec->nlbl_state != NLBL_REQSKB)
>   			return 0;
> @@ -287,7 +288,7 @@ int selinux_netlbl_sctp_assoc_request(struct sctp_endpoint *ep,
>   {
>   	int rc;
>   	struct netlbl_lsm_secattr secattr;
> -	struct sk_security_struct *sksec = ep->base.sk->sk_security;
> +	struct sk_security_struct *sksec = selinux_sock(ep->base.sk);
>   	struct sockaddr *addr;
>   	struct sockaddr_in addr4;
>   #if IS_ENABLED(CONFIG_IPV6)
> @@ -370,7 +371,7 @@ int selinux_netlbl_inet_conn_request(struct request_sock *req, u16 family)
>    */
>   void selinux_netlbl_inet_csk_clone(struct sock *sk, u16 family)
>   {
> -	struct sk_security_struct *sksec = sk->sk_security;
> +	struct sk_security_struct *sksec = selinux_sock(sk);
>   
>   	if (family == PF_INET)
>   		sksec->nlbl_state = NLBL_LABELED;
> @@ -388,8 +389,8 @@ void selinux_netlbl_inet_csk_clone(struct sock *sk, u16 family)
>    */
>   void selinux_netlbl_sctp_sk_clone(struct sock *sk, struct sock *newsk)
>   {
> -	struct sk_security_struct *sksec = sk->sk_security;
> -	struct sk_security_struct *newsksec = newsk->sk_security;
> +	struct sk_security_struct *sksec = selinux_sock(sk);
> +	struct sk_security_struct *newsksec = selinux_sock(newsk);
>   
>   	newsksec->nlbl_state = sksec->nlbl_state;
>   }
> @@ -407,7 +408,7 @@ void selinux_netlbl_sctp_sk_clone(struct sock *sk, struct sock *newsk)
>   int selinux_netlbl_socket_post_create(struct sock *sk, u16 family)
>   {
>   	int rc;
> -	struct sk_security_struct *sksec = sk->sk_security;
> +	struct sk_security_struct *sksec = selinux_sock(sk);
>   	struct netlbl_lsm_secattr *secattr;
>   
>   	if (family != PF_INET && family != PF_INET6)
> @@ -522,7 +523,7 @@ int selinux_netlbl_socket_setsockopt(struct socket *sock,
>   {
>   	int rc = 0;
>   	struct sock *sk = sock->sk;
> -	struct sk_security_struct *sksec = sk->sk_security;
> +	struct sk_security_struct *sksec = selinux_sock(sk);
>   	struct netlbl_lsm_secattr secattr;
>   
>   	if (selinux_netlbl_option(level, optname) &&
> @@ -560,7 +561,7 @@ static int selinux_netlbl_socket_connect_helper(struct sock *sk,
>   						struct sockaddr *addr)
>   {
>   	int rc;
> -	struct sk_security_struct *sksec = sk->sk_security;
> +	struct sk_security_struct *sksec = selinux_sock(sk);
>   	struct netlbl_lsm_secattr *secattr;
>   
>   	/* connected sockets are allowed to disconnect when the address family
> @@ -599,7 +600,7 @@ static int selinux_netlbl_socket_connect_helper(struct sock *sk,
>   int selinux_netlbl_socket_connect_locked(struct sock *sk,
>   					 struct sockaddr *addr)
>   {
> -	struct sk_security_struct *sksec = sk->sk_security;
> +	struct sk_security_struct *sksec = selinux_sock(sk);
>   
>   	if (sksec->nlbl_state != NLBL_REQSKB &&
>   	    sksec->nlbl_state != NLBL_CONNLABELED)
> diff --git a/security/smack/smack.h b/security/smack/smack.h
> index caecbcba9942..4ac4bf3310d7 100644
> --- a/security/smack/smack.h
> +++ b/security/smack/smack.h
> @@ -375,6 +375,11 @@ static inline struct smack_known **smack_ipc(const struct kern_ipc_perm *ipc)
>   	return ipc->security + smack_blob_sizes.lbs_ipc;
>   }
>   
> +static inline struct socket_smack *smack_sock(const struct sock *sock)
> +{
> +	return sock->sk_security + smack_blob_sizes.lbs_sock;
> +}
> +
>   static inline struct superblock_smack *smack_superblock(
>   					const struct super_block *superblock)
>   {
> diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
> index 807eff2ccce9..fd69e1bd841b 100644
> --- a/security/smack/smack_lsm.c
> +++ b/security/smack/smack_lsm.c
> @@ -1439,7 +1439,7 @@ static int smack_inode_getsecurity(struct inode *inode,
>   		if (sock == NULL || sock->sk == NULL)
>   			return -EOPNOTSUPP;
>   
> -		ssp = sock->sk->sk_security;
> +		ssp = smack_sock(sock->sk);
>   
>   		if (strcmp(name, XATTR_SMACK_IPIN) == 0)
>   			isp = ssp->smk_in;
> @@ -1821,7 +1821,7 @@ static int smack_file_receive(struct file *file)
>   
>   	if (inode->i_sb->s_magic == SOCKFS_MAGIC) {
>   		sock = SOCKET_I(inode);
> -		ssp = sock->sk->sk_security;
> +		ssp = smack_sock(sock->sk);
>   		tsp = smack_cred(current_cred());
>   		/*
>   		 * If the receiving process can't write to the
> @@ -2231,11 +2231,7 @@ static void smack_task_to_inode(struct task_struct *p, struct inode *inode)
>   static int smack_sk_alloc_security(struct sock *sk, int family, gfp_t gfp_flags)
>   {
>   	struct smack_known *skp = smk_of_current();
> -	struct socket_smack *ssp;
> -
> -	ssp = kzalloc(sizeof(struct socket_smack), gfp_flags);
> -	if (ssp == NULL)
> -		return -ENOMEM;
> +	struct socket_smack *ssp = smack_sock(sk);
>   
>   	/*
>   	 * Sockets created by kernel threads receive web label.
> @@ -2249,11 +2245,10 @@ static int smack_sk_alloc_security(struct sock *sk, int family, gfp_t gfp_flags)
>   	}
>   	ssp->smk_packet = NULL;
>   
> -	sk->sk_security = ssp;
> -
>   	return 0;
>   }
>   
> +#ifdef SMACK_IPV6_PORT_LABELING
>   /**
>    * smack_sk_free_security - Free a socket blob
>    * @sk: the socket
> @@ -2262,7 +2257,6 @@ static int smack_sk_alloc_security(struct sock *sk, int family, gfp_t gfp_flags)
>    */
>   static void smack_sk_free_security(struct sock *sk)
>   {
> -#ifdef SMACK_IPV6_PORT_LABELING
>   	struct smk_port_label *spp;
>   
>   	if (sk->sk_family == PF_INET6) {
> @@ -2275,9 +2269,8 @@ static void smack_sk_free_security(struct sock *sk)
>   		}
>   		rcu_read_unlock();
>   	}
> -#endif
> -	kfree(sk->sk_security);
>   }
> +#endif
>   
>   /**
>   * smack_ipv4host_label - check host based restrictions
> @@ -2395,7 +2388,7 @@ static struct smack_known *smack_ipv6host_label(struct sockaddr_in6 *sip)
>   static int smack_netlabel(struct sock *sk, int labeled)
>   {
>   	struct smack_known *skp;
> -	struct socket_smack *ssp = sk->sk_security;
> +	struct socket_smack *ssp = smack_sock(sk);
>   	int rc = 0;
>   
>   	/*
> @@ -2440,7 +2433,7 @@ static int smack_netlabel_send(struct sock *sk, struct sockaddr_in *sap)
>   	int rc;
>   	int sk_lbl;
>   	struct smack_known *hkp;
> -	struct socket_smack *ssp = sk->sk_security;
> +	struct socket_smack *ssp = smack_sock(sk);
>   	struct smk_audit_info ad;
>   
>   	rcu_read_lock();
> @@ -2516,7 +2509,7 @@ static void smk_ipv6_port_label(struct socket *sock, struct sockaddr *address)
>   {
>   	struct sock *sk = sock->sk;
>   	struct sockaddr_in6 *addr6;
> -	struct socket_smack *ssp = sock->sk->sk_security;
> +	struct socket_smack *ssp = smack_sock(sock->sk);
>   	struct smk_port_label *spp;
>   	unsigned short port = 0;
>   
> @@ -2603,7 +2596,7 @@ static int smk_ipv6_port_check(struct sock *sk, struct sockaddr_in6 *address,
>   				int act)
>   {
>   	struct smk_port_label *spp;
> -	struct socket_smack *ssp = sk->sk_security;
> +	struct socket_smack *ssp = smack_sock(sk);
>   	struct smack_known *skp = NULL;
>   	unsigned short port;
>   	struct smack_known *object;
> @@ -2697,7 +2690,7 @@ static int smack_inode_setsecurity(struct inode *inode, const char *name,
>   	if (sock == NULL || sock->sk == NULL)
>   		return -EOPNOTSUPP;
>   
> -	ssp = sock->sk->sk_security;
> +	ssp = smack_sock(sock->sk);
>   
>   	if (strcmp(name, XATTR_SMACK_IPIN) == 0)
>   		ssp->smk_in = skp;
> @@ -2745,7 +2738,7 @@ static int smack_socket_post_create(struct socket *sock, int family,
>   	 * Sockets created by kernel threads receive web label.
>   	 */
>   	if (unlikely(current->flags & PF_KTHREAD)) {
> -		ssp = sock->sk->sk_security;
> +		ssp = smack_sock(sock->sk);
>   		ssp->smk_in = &smack_known_web;
>   		ssp->smk_out = &smack_known_web;
>   	}
> @@ -2770,8 +2763,8 @@ static int smack_socket_post_create(struct socket *sock, int family,
>   static int smack_socket_socketpair(struct socket *socka,
>   		                   struct socket *sockb)
>   {
> -	struct socket_smack *asp = socka->sk->sk_security;
> -	struct socket_smack *bsp = sockb->sk->sk_security;
> +	struct socket_smack *asp = smack_sock(socka->sk);
> +	struct socket_smack *bsp = smack_sock(sockb->sk);
>   
>   	asp->smk_packet = bsp->smk_out;
>   	bsp->smk_packet = asp->smk_out;
> @@ -2825,7 +2818,7 @@ static int smack_socket_connect(struct socket *sock, struct sockaddr *sap,
>   		return 0;
>   
>   #ifdef SMACK_IPV6_SECMARK_LABELING
> -	ssp = sock->sk->sk_security;
> +	ssp = smack_sock(sock->sk);
>   #endif
>   
>   	switch (sock->sk->sk_family) {
> @@ -3566,9 +3559,9 @@ static int smack_unix_stream_connect(struct sock *sock,
>   {
>   	struct smack_known *skp;
>   	struct smack_known *okp;
> -	struct socket_smack *ssp = sock->sk_security;
> -	struct socket_smack *osp = other->sk_security;
> -	struct socket_smack *nsp = newsk->sk_security;
> +	struct socket_smack *ssp = smack_sock(sock);
> +	struct socket_smack *osp = smack_sock(other);
> +	struct socket_smack *nsp = smack_sock(newsk);
>   	struct smk_audit_info ad;
>   	int rc = 0;
>   #ifdef CONFIG_AUDIT
> @@ -3614,8 +3607,8 @@ static int smack_unix_stream_connect(struct sock *sock,
>    */
>   static int smack_unix_may_send(struct socket *sock, struct socket *other)
>   {
> -	struct socket_smack *ssp = sock->sk->sk_security;
> -	struct socket_smack *osp = other->sk->sk_security;
> +	struct socket_smack *ssp = smack_sock(sock->sk);
> +	struct socket_smack *osp = smack_sock(other->sk);
>   	struct smk_audit_info ad;
>   	int rc;
>   
> @@ -3652,7 +3645,7 @@ static int smack_socket_sendmsg(struct socket *sock, struct msghdr *msg,
>   	struct sockaddr_in6 *sap = (struct sockaddr_in6 *) msg->msg_name;
>   #endif
>   #ifdef SMACK_IPV6_SECMARK_LABELING
> -	struct socket_smack *ssp = sock->sk->sk_security;
> +	struct socket_smack *ssp = smack_sock(sock->sk);
>   	struct smack_known *rsp;
>   #endif
>   	int rc = 0;
> @@ -3817,7 +3810,7 @@ static int smk_skb_to_addr_ipv6(struct sk_buff *skb, struct sockaddr_in6 *sip)
>   static int smack_socket_sock_rcv_skb(struct sock *sk, struct sk_buff *skb)
>   {
>   	struct netlbl_lsm_secattr secattr;
> -	struct socket_smack *ssp = sk->sk_security;
> +	struct socket_smack *ssp = smack_sock(sk);
>   	struct smack_known *skp = NULL;
>   	int rc = 0;
>   	struct smk_audit_info ad;
> @@ -3934,7 +3927,7 @@ static int smack_socket_getpeersec_stream(struct socket *sock,
>   	int slen = 1;
>   	int rc = 0;
>   
> -	ssp = sock->sk->sk_security;
> +	ssp = smack_sock(sock->sk);
>   	if (ssp->smk_packet != NULL) {
>   		rcp = ssp->smk_packet->smk_known;
>   		slen = strlen(rcp) + 1;
> @@ -3984,7 +3977,7 @@ static int smack_socket_getpeersec_dgram(struct socket *sock,
>   
>   	switch (family) {
>   	case PF_UNIX:
> -		ssp = sock->sk->sk_security;
> +		ssp = smack_sock(sock->sk);
>   		s = ssp->smk_out->smk_secid;
>   		break;
>   	case PF_INET:
> @@ -3997,7 +3990,7 @@ static int smack_socket_getpeersec_dgram(struct socket *sock,
>   		 * Translate what netlabel gave us.
>   		 */
>   		if (sock != NULL && sock->sk != NULL)
> -			ssp = sock->sk->sk_security;
> +			ssp = smack_sock(sock->sk);
>   		netlbl_secattr_init(&secattr);
>   		rc = netlbl_skbuff_getattr(skb, family, &secattr);
>   		if (rc == 0) {
> @@ -4035,7 +4028,7 @@ static void smack_sock_graft(struct sock *sk, struct socket *parent)
>   	    (sk->sk_family != PF_INET && sk->sk_family != PF_INET6))
>   		return;
>   
> -	ssp = sk->sk_security;
> +	ssp = smack_sock(sk);
>   	ssp->smk_in = skp;
>   	ssp->smk_out = skp;
>   	/* cssp->smk_packet is already set in smack_inet_csk_clone() */
> @@ -4055,7 +4048,7 @@ static int smack_inet_conn_request(struct sock *sk, struct sk_buff *skb,
>   {
>   	u16 family = sk->sk_family;
>   	struct smack_known *skp;
> -	struct socket_smack *ssp = sk->sk_security;
> +	struct socket_smack *ssp = smack_sock(sk);
>   	struct netlbl_lsm_secattr secattr;
>   	struct sockaddr_in addr;
>   	struct iphdr *hdr;
> @@ -4154,7 +4147,7 @@ static int smack_inet_conn_request(struct sock *sk, struct sk_buff *skb,
>   static void smack_inet_csk_clone(struct sock *sk,
>   				 const struct request_sock *req)
>   {
> -	struct socket_smack *ssp = sk->sk_security;
> +	struct socket_smack *ssp = smack_sock(sk);
>   	struct smack_known *skp;
>   
>   	if (req->peer_secid != 0) {
> @@ -4558,6 +4551,7 @@ struct lsm_blob_sizes smack_blob_sizes __lsm_ro_after_init = {
>   	.lbs_inode = sizeof(struct inode_smack),
>   	.lbs_ipc = sizeof(struct smack_known *),
>   	.lbs_msg_msg = sizeof(struct smack_known *),
> +	.lbs_sock = sizeof(struct socket_smack),
>   	.lbs_superblock = sizeof(struct superblock_smack),
>   };
>   
> @@ -4667,7 +4661,9 @@ static struct security_hook_list smack_hooks[] __lsm_ro_after_init = {
>   	LSM_HOOK_INIT(socket_getpeersec_stream, smack_socket_getpeersec_stream),
>   	LSM_HOOK_INIT(socket_getpeersec_dgram, smack_socket_getpeersec_dgram),
>   	LSM_HOOK_INIT(sk_alloc_security, smack_sk_alloc_security),
> +#ifdef SMACK_IPV6_PORT_LABELING
>   	LSM_HOOK_INIT(sk_free_security, smack_sk_free_security),
> +#endif
>   	LSM_HOOK_INIT(sock_graft, smack_sock_graft),
>   	LSM_HOOK_INIT(inet_conn_request, smack_inet_conn_request),
>   	LSM_HOOK_INIT(inet_csk_clone, smack_inet_csk_clone),
> diff --git a/security/smack/smack_netfilter.c b/security/smack/smack_netfilter.c
> index e36d17835d4f..701a1cc1bdcc 100644
> --- a/security/smack/smack_netfilter.c
> +++ b/security/smack/smack_netfilter.c
> @@ -31,8 +31,8 @@ static unsigned int smack_ipv6_output(void *priv,
>   	struct socket_smack *ssp;
>   	struct smack_known *skp;
>   
> -	if (sk && sk->sk_security) {
> -		ssp = sk->sk_security;
> +	if (sk && smack_sock(sk)) {
> +		ssp = smack_sock(sk);
>   		skp = ssp->smk_out;
>   		skb->secmark = skp->smk_secid;
>   	}
> @@ -49,8 +49,8 @@ static unsigned int smack_ipv4_output(void *priv,
>   	struct socket_smack *ssp;
>   	struct smack_known *skp;
>   
> -	if (sk && sk->sk_security) {
> -		ssp = sk->sk_security;
> +	if (sk && smack_sock(sk)) {
> +		ssp = smack_sock(sk);
>   		skp = ssp->smk_out;
>   		skb->secmark = skp->smk_secid;
>   	}
> 

