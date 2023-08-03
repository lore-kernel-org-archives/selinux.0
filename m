Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 697AAC04A94
	for <selinux@archiver.kernel.org>; Thu,  3 Aug 2023 12:53:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231461AbjHCMxu (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 3 Aug 2023 08:53:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234146AbjHCMxt (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 3 Aug 2023 08:53:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13AD535A8;
        Thu,  3 Aug 2023 05:53:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9AA8161D91;
        Thu,  3 Aug 2023 12:53:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4BBEC433C8;
        Thu,  3 Aug 2023 12:53:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691067227;
        bh=r4FB9C3DbyML50THOYSEoMjiyY77SgxV2l1qtwpxE3Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nN0wvvfqkt0Oh2vmUhgUKxgefq2fjGdBl3Xc1C0D1Hv1tbt26iNf+M/ps2GN9QKkh
         Zzp8aOGK4IJdtlp78ZHErfGc3btpdICVz9a69a8tzFGauOoN8QRlkjiHUSFeerQaeC
         MdNTQg6Pa+W0RXdTbE4nmWBys5er8hvo3aWE9i+uJVTn1EuIMDRakpkWVWdIvGwVBR
         u39lif0pHj6/7hYmNeWAWnbvQigCf8NtUwdzAMM1pCGbXbsHLQuRd/S3zTD7E8ZVlf
         34m/8LH+0HMVIBO9P+jMC2OqUTOdeAPbVnnepr2zeM4fkSbPChud+iiZ1nHCngAz2C
         OoZ/H55FwCmhw==
Date:   Thu, 3 Aug 2023 14:53:38 +0200
From:   Simon Horman <horms@kernel.org>
To:     Geliang Tang <geliang.tang@suse.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
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
        bpf@vger.kernel.org, netdev@vger.kernel.org, mptcp@lists.linux.dev,
        apparmor@lists.ubuntu.com, linux-security-module@vger.kernel.org,
        selinux@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH bpf-next v8 1/4] bpf: Add update_socket_protocol hook
Message-ID: <ZMujUofDnb8wMb36@kernel.org>
References: <cover.1691047403.git.geliang.tang@suse.com>
 <120b307aacd1791fac016d33e112069ffb7db21a.1691047403.git.geliang.tang@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <120b307aacd1791fac016d33e112069ffb7db21a.1691047403.git.geliang.tang@suse.com>
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Aug 03, 2023 at 03:30:39PM +0800, Geliang Tang wrote:
> Add a hook named update_socket_protocol in __sys_socket(), for bpf
> progs to attach to and update socket protocol. One user case is to
> force legacy TCP apps to create and use MPTCP sockets instead of
> TCP ones.
> 
> Define a mod_ret set named bpf_mptcp_fmodret_ids, add the hook
> update_socket_protocol into this set, and register it in
> bpf_mptcp_kfunc_init().
> 
> Signed-off-by: Geliang Tang <geliang.tang@suse.com>

...

> diff --git a/net/socket.c b/net/socket.c
> index 2b0e54b2405c..586a437d7a5e 100644
> --- a/net/socket.c
> +++ b/net/socket.c
> @@ -1644,11 +1644,36 @@ struct file *__sys_socket_file(int family, int type, int protocol)
>  	return sock_alloc_file(sock, flags, NULL);
>  }
>  
> +/**

Hi Geliang Tang,

nit: The format of the text below is not in kernel doc format,
     so it is probably better if the comment begins with '/*'
     rather than '/**'.

> + *	A hook for bpf progs to attach to and update socket protocol.
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

...
