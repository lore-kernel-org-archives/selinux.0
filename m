Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E0A0C001DF
	for <selinux@archiver.kernel.org>; Thu,  3 Aug 2023 23:27:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230521AbjHCX1V (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 3 Aug 2023 19:27:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230471AbjHCX1U (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 3 Aug 2023 19:27:20 -0400
X-Greylist: delayed 558 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 03 Aug 2023 16:27:17 PDT
Received: from out-116.mta1.migadu.com (out-116.mta1.migadu.com [IPv6:2001:41d0:203:375::74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 084DE1BF6
        for <selinux@vger.kernel.org>; Thu,  3 Aug 2023 16:27:16 -0700 (PDT)
Message-ID: <b9c219e6-e42c-3772-fba8-e40afaad1465@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1691104672; h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5UcTW2ZerF3E/NIit4kPDouCVNTX9RBlsI5Ewa1ULsM=;
        b=Fsjc8Ltt0taLpi+MclSzQBt+8MTlUJ8c8vCqPf13fjSwgX7el+/jK+lMzp6L2Lw0CINOpz
        50OxThDABRzHVgXUkfNL3OZ+ItQ7RrAD0W0Vdm14Q38UTuGef0HnHmGb2an9ilV3nzU2gi
        RosNEGLXB9iKVo09A0d+mcpJ3il/vFg=
Date:   Thu, 3 Aug 2023 16:17:37 -0700
MIME-Version: 1.0
Reply-To: yonghong.song@linux.dev
Subject: Re: [PATCH bpf-next v9 1/4] bpf: Add update_socket_protocol hook
To:     Geliang Tang <geliang.tang@suse.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Florent Revest <revest@chromium.org>,
        Brendan Jackman <jackmanb@chromium.org>,
        Matthieu Baerts <matthieu.baerts@tessares.net>,
        Mat Martineau <martineau@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        John Johansen <john.johansen@canonical.com>,
        Paul Moore <paul@paul-moore.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>,
        Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>,
        Simon Horman <horms@kernel.org>
Cc:     bpf@vger.kernel.org, netdev@vger.kernel.org, mptcp@lists.linux.dev,
        apparmor@lists.ubuntu.com, linux-security-module@vger.kernel.org,
        selinux@vger.kernel.org, linux-kselftest@vger.kernel.org
References: <cover.1691069778.git.geliang.tang@suse.com>
 <fc284a49832630e4b908f11c7e07a8066b7bd789.1691069778.git.geliang.tang@suse.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <fc284a49832630e4b908f11c7e07a8066b7bd789.1691069778.git.geliang.tang@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org



On 8/3/23 6:41 AM, Geliang Tang wrote:
> Add a hook named update_socket_protocol in __sys_socket(), for bpf
> progs to attach to and update socket protocol. One user case is to
> force legacy TCP apps to create and use MPTCP sockets instead of
> TCP ones.
> 
> Define a mod_ret set named bpf_mptcp_fmodret_ids, add the hook
> update_socket_protocol into this set, and register it in
> bpf_mptcp_kfunc_init().
> 
> Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/79
> Acked-by: Matthieu Baerts <matthieu.baerts@tessares.net>
> Signed-off-by: Geliang Tang <geliang.tang@suse.com>
> ---
>   net/mptcp/bpf.c | 17 +++++++++++++++++
>   net/socket.c    | 24 ++++++++++++++++++++++++
>   2 files changed, 41 insertions(+)
> 
> diff --git a/net/mptcp/bpf.c b/net/mptcp/bpf.c
> index 5a0a84ad94af..c43aee31014d 100644
> --- a/net/mptcp/bpf.c
> +++ b/net/mptcp/bpf.c
> @@ -12,6 +12,23 @@
>   #include <linux/bpf.h>
>   #include "protocol.h"
>   
> +#ifdef CONFIG_BPF_JIT

Is this necessary? Most other register_btf_* functions do not have
a config like this.

> +BTF_SET8_START(bpf_mptcp_fmodret_ids)
> +BTF_ID_FLAGS(func, update_socket_protocol)
> +BTF_SET8_END(bpf_mptcp_fmodret_ids)
> +
> +static const struct btf_kfunc_id_set bpf_mptcp_fmodret_set = {
> +	.owner = THIS_MODULE,
> +	.set   = &bpf_mptcp_fmodret_ids,
> +};
> +
> +static int __init bpf_mptcp_kfunc_init(void)
> +{
> +	return register_btf_fmodret_id_set(&bpf_mptcp_fmodret_set);
> +}
> +late_initcall(bpf_mptcp_kfunc_init);
> +#endif /* CONFIG_BPF_JIT */
> +
>   struct mptcp_sock *bpf_mptcp_sock_from_subflow(struct sock *sk)
>   {
>   	if (sk && sk_fullsock(sk) && sk->sk_protocol == IPPROTO_TCP && sk_is_mptcp(sk))
> diff --git a/net/socket.c b/net/socket.c
> index 2b0e54b2405c..9f98ced88ac5 100644
> --- a/net/socket.c
> +++ b/net/socket.c
> @@ -1644,11 +1644,35 @@ struct file *__sys_socket_file(int family, int type, int protocol)
>   	return sock_alloc_file(sock, flags, NULL);
>   }
>   
> +/*	A hook for bpf progs to attach to and update socket protocol.
> + *
> + *	A static noinline declaration here could cause the compiler to
> + *	optimize away the function. A global noinline declaration will
> + *	keep the definition, but may optimize away the callsite.
> + *	Therefore, __weak is needed to ensure that the call is still
> + *	emitted, by telling the compiler that we don't know what the
> + *	function might eventually be.
> + *
> + *	__diag_* below are needed to dismiss the missing prototype warning.
> + */
> +
> +__diag_push();
> +__diag_ignore_all("-Wmissing-prototypes",
> +		  "kfuncs which will be used in BPF programs");
> +
> +__weak noinline int update_socket_protocol(int family, int type, int protocol)
> +{
> +	return protocol;
> +}
> +
> +__diag_pop();
> +
>   int __sys_socket(int family, int type, int protocol)
>   {
>   	struct socket *sock;
>   	int flags;
>   
> +	protocol = update_socket_protocol(family, type, protocol);
>   	sock = __sys_socket_create(family, type, protocol);
>   	if (IS_ERR(sock))
>   		return PTR_ERR(sock);
