Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9122FC47087
	for <selinux@archiver.kernel.org>; Fri, 28 May 2021 22:52:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 68D0361205
	for <selinux@archiver.kernel.org>; Fri, 28 May 2021 22:52:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229575AbhE1Wy0 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 28 May 2021 18:54:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229589AbhE1WyY (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 28 May 2021 18:54:24 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0B2FC061574
        for <selinux@vger.kernel.org>; Fri, 28 May 2021 15:52:47 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id jt22so7565860ejb.7
        for <selinux@vger.kernel.org>; Fri, 28 May 2021 15:52:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hYw5L9uovAkFsfHnHeXQzSMU5L4IRTMjhY6/K5rzT9U=;
        b=yuNgeXWN+6xWyHkZN3hopiuhLwOwLkMW4jfx/Ke9qnP+4D2F8F70wSggXfODvDfJTi
         ILz10rk+8ClZi8HbQdGtQbcSvgtB1sGOONGOZStOBth62K6Hz5gg9CX1vrt+j4VA5tlX
         Ix+Nfa7RDnmnOhfUmMbJi+8cg+u3ye37cM6IYBcAIMHhRDDaEBkVCskOi0kOs7gnKSdI
         mXKdCDDvyo3dLsxWV8KBORTR/cOBJBOknrc9qVd3Bzm0TtTxq1bM5m5gMw8Uhs9lgJXG
         aX1MQzG+pMBsWwu0lszw5ECGLix/RDqMzdlR8Bx+v92dGBI1vhRO3aOIv5eom6bntiJ4
         /j8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hYw5L9uovAkFsfHnHeXQzSMU5L4IRTMjhY6/K5rzT9U=;
        b=da55e4XQW8ogu05cgVWvJhFP07/3G6uG5RJ/7mxQ76MnfLAHpu90lpdZMJ2nvJ5Pds
         n66GtgrC/TIhtUCFKNt8mTmVj/KUSi7nRzfqjhZrvdF8fkk7XV2gLtTjaZKgCUS/99Hq
         vpAVpQZuMYYbAE7bNGoZLjTGg3xgxMUx63swvGX0gpuPpopboKWRxrybHemBdnmV2oD4
         YtpS6upiWReOK7HArCmNEwVDWf8gUKC6qAssU7gM4M9yQKXxc28f9gLPa2yV0pGYX+Sw
         hVjc4bK5fwmQp3NzaaqiQ0Jn3bzAZiORWTECYdw3KfWN8iHbyRCkwLoJFIJ7GelTXLor
         12BQ==
X-Gm-Message-State: AOAM530G8dKml3pqcaB4nGefKjh5ZnSQ4hjVr5xdFyJDoue1wipiNFP1
        TUAoD4+sKhWA9oXenxanPVYu1apXjIzrg5IDpI3q
X-Google-Smtp-Source: ABdhPJyM59D/3ndTZ2tM5xKxQiqHabnQvuoHlfDxd+J5YttV0ukxr9SsE/gZ/BunSIgaPf5x9SH6g251CYE//WbdFbc=
X-Received: by 2002:a17:906:4111:: with SMTP id j17mr1665351ejk.488.1622242365987;
 Fri, 28 May 2021 15:52:45 -0700 (PDT)
MIME-Version: 1.0
References: <20210517092006.803332-1-omosnace@redhat.com> <CAHC9VhTasra0tU=bKwVqAwLRYaC+hYakirRz0Mn5jbVMuDkwrA@mail.gmail.com>
 <01135120-8bf7-df2e-cff0-1d73f1f841c3@iogearbox.net> <CAHC9VhR-kYmMA8gsqkiL5=poN9FoL-uCyx1YOLCoG2hRiUBYug@mail.gmail.com>
 <c7c2d7e1-e253-dce0-d35c-392192e4926e@iogearbox.net>
In-Reply-To: <c7c2d7e1-e253-dce0-d35c-392192e4926e@iogearbox.net>
From:   Paul Moore <paul@paul-moore.com>
Date:   Fri, 28 May 2021 18:52:34 -0400
Message-ID: <CAHC9VhRkz48MLv_QNfnRWFPvFxEV7oJH5eNHGUtvWdjG4M1YFA@mail.gmail.com>
Subject: Re: [PATCH v2] lockdown,selinux: avoid bogus SELinux lockdown
 permission checks
To:     Daniel Borkmann <daniel@iogearbox.net>
Cc:     Ondrej Mosnacek <omosnace@redhat.com>,
        linux-security-module@vger.kernel.org,
        James Morris <jmorris@namei.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        selinux@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-fsdevel@vger.kernel.org, bpf@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Casey Schaufler <casey@schaufler-ca.com>, jolsa@redhat.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, May 28, 2021 at 2:28 PM Daniel Borkmann <daniel@iogearbox.net> wrote:
> On 5/28/21 5:47 PM, Paul Moore wrote:
> > Let's reset.
>
> Sure, yep, lets shortly take one step back. :)
>
> > What task_struct is running the BPF tracing program which is calling
> > into security_locked_down()?  My current feeling is that it is this
> > context/domain/cred that should be used for the access control check;
> > in the cases where it is a kernel thread, I think passing NULL is
> > reasonable, but I think the proper thing for SELinux is to interpret
> > NULL as kernel_t.
>
> If this was a typical LSM hook and, say, your app calls into bind(2) where
> we then invoke security_socket_bind() and check 'current' task, then I'm all
> with you, because this was _explicitly initiated_ by the httpd app, so that
> allow/deny policy belongs in the context of httpd.
>
> In the case of tracing, it's different. You install small programs that are
> triggered when certain events fire. Random example from bpftrace's README [0],
> you want to generate a histogram of syscall counts by program. One-liner is:
>
>    bpftrace -e 'tracepoint:raw_syscalls:sys_enter { @[comm] = count(); }'
>
> bpftrace then goes and generates a BPF prog from this internally. One way of
> doing it could be to call bpf_get_current_task() helper and then access
> current->comm via one of bpf_probe_read_kernel{,_str}() helpers. So the
> program itself has nothing to do with httpd or any other random app doing
> a syscall here. The BPF prog _explicitly initiated_ the lockdown check.
> The allow/deny policy belongs in the context of bpftrace: meaning, you want
> to grant bpftrace access to use these helpers, but other tracers on the
> systems like my_random_tracer not. While this works for prior mentioned
> cases of security_locked_down() with open_kcore() for /proc/kcore access
> or the module_sig_check(), it is broken for tracing as-is, and the patch
> I sent earlier fixes this.

Sigh.

Generally it's helpful when someone asks a question if you answer it
directly before going off and answering your own questions.  Listen, I
get it, you wrote a patch and it fixes your problem (you've mentioned
that already) and it's wonderful and all that, but the rest of us
(maybe just me) need to sort this out too and talking past questions
isn't a great way to help us get there (once again, maybe just me).  I
think I can infer an answer from you, but you've made me grumpy now so
I'm not ACK'ing or NACK'ing anything right now; I clearly need to go
spend some time reading through BPF code.  Woo.

>    [0] https://github.com/iovisor/bpftrace

-- 
paul moore
www.paul-moore.com
