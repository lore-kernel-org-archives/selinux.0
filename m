Return-Path: <SRS0=kJgC=YC=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08669C47404
	for <selinux@archiver.kernel.org>; Wed,  9 Oct 2019 22:13:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D525220B7C
	for <selinux@archiver.kernel.org>; Wed,  9 Oct 2019 22:13:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731158AbfJIWNL (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 9 Oct 2019 18:13:11 -0400
Received: from namei.org ([65.99.196.166]:53338 "EHLO namei.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729535AbfJIWNL (ORCPT <rfc822;selinux@vger.kernel.org>);
        Wed, 9 Oct 2019 18:13:11 -0400
Received: from localhost (localhost [127.0.0.1])
        by namei.org (8.14.4/8.14.4) with ESMTP id x99MBdMw030060;
        Wed, 9 Oct 2019 22:11:39 GMT
Date:   Thu, 10 Oct 2019 09:11:39 +1100 (AEDT)
From:   James Morris <jmorris@namei.org>
To:     "Joel Fernandes (Google)" <joel@joelfernandes.org>
cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>, rostedt@goodmis.org,
        primiano@google.com, rsavitski@google.com, jeffv@google.com,
        kernel-team@android.com, Alexei Starovoitov <ast@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        bpf@vger.kernel.org, Daniel Borkmann <daniel@iogearbox.net>,
        Ingo Molnar <mingo@redhat.com>, Jiri Olsa <jolsa@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        linux-security-module@vger.kernel.org,
        Matthew Garrett <matthewgarrett@google.com>,
        Namhyung Kim <namhyung@kernel.org>, selinux@vger.kernel.org,
        Song Liu <songliubraving@fb.com>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        Yonghong Song <yhs@fb.com>
Subject: Re: [PATCH RFC] perf_event: Add support for LSM and SELinux checks
In-Reply-To: <20191009203657.6070-1-joel@joelfernandes.org>
Message-ID: <alpine.LRH.2.21.1910100908260.29840@namei.org>
References: <20191009203657.6070-1-joel@joelfernandes.org>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, 9 Oct 2019, Joel Fernandes (Google) wrote:

>  
> +#ifdef CONFIG_SECURITY
> +	err = security_perf_event_alloc(event);
> +	if (err)
> +		goto err_security;
> +#endif

You should not need this ifdef.

> diff --git a/security/security.c b/security/security.c
> index 1bc000f834e2..7639bca1db59 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -2373,26 +2373,32 @@ int security_bpf(int cmd, union bpf_attr *attr, unsigned int size)
>  {
>  	return call_int_hook(bpf, 0, cmd, attr, size);
>  }
> +
>  int security_bpf_map(struct bpf_map *map, fmode_t fmode)
>  {
>  	return call_int_hook(bpf_map, 0, map, fmode);
>  }
> +
>  int security_bpf_prog(struct bpf_prog *prog)
>  {
>  	return call_int_hook(bpf_prog, 0, prog);
>  }
> +
>  int security_bpf_map_alloc(struct bpf_map *map)
>  {
>  	return call_int_hook(bpf_map_alloc_security, 0, map);
>  }
> +
>  int security_bpf_prog_alloc(struct bpf_prog_aux *aux)
>  {
>  	return call_int_hook(bpf_prog_alloc_security, 0, aux);
>  }
> +
>  void security_bpf_map_free(struct bpf_map *map)
>  {
>  	call_void_hook(bpf_map_free_security, map);
>  }
> +
>  void security_bpf_prog_free(struct bpf_prog_aux *aux)
>  {
>  	call_void_hook(bpf_prog_free_security, aux);
> @@ -2404,3 +2410,30 @@ int security_locked_down(enum lockdown_reason what)
>  	return call_int_hook(locked_down, 0, what);
>  }
>  EXPORT_SYMBOL(security_locked_down);

Please avoid unrelated whitespace changes.


-- 
James Morris
<jmorris@namei.org>

