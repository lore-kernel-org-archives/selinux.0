Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25941C4332F
	for <selinux@archiver.kernel.org>; Thu, 10 Nov 2022 17:54:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231442AbiKJRyS (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 10 Nov 2022 12:54:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231394AbiKJRyQ (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 10 Nov 2022 12:54:16 -0500
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E01D49B6E
        for <selinux@vger.kernel.org>; Thu, 10 Nov 2022 09:54:15 -0800 (PST)
Received: by mail-ej1-x634.google.com with SMTP id b2so6938220eja.6
        for <selinux@vger.kernel.org>; Thu, 10 Nov 2022 09:54:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=kfHz50Kg7kyBZpgLz1L+duIpLshaF3vQXrti1dXGZLQ=;
        b=himkAUve95kura1F4xyrjgF2Ao9L01DaBYcsivT7aKJ5J4AF6ajPklOMnZ88snF8S/
         Sm6FEemOqLF/MrgUC5yLIaXtMop2DLyIxPzRPUoUFaA5aKTYxAFSqWUMJk850gnqShNb
         wE7XZ4ZD0YABNLuFjY+X3KglYL7nJG8JNkkvLu3QJtRk3djhDQghiY7LCQX3IS7glCq2
         M3Z3rUTcmamKd9fp2ozIcuSHynhl1Xgi/GnqGciIWHpaSJNBKuTCOn3Ej65qPgsyN7ok
         8FB28sjmPUx11WchT1uogNEcf84eSNHyyoLzumQXLDUlwM/q3BMdB2xufOMmSmbksCWm
         YjnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kfHz50Kg7kyBZpgLz1L+duIpLshaF3vQXrti1dXGZLQ=;
        b=nyJ12Y2EuF8+hQYslyMOjXjablRpL8v5u+0UZFBy0TDwXxuG4CffuN5XXiqZyGa2Ey
         ddQ297QgPL4Fn32yX7FuKhcZPNfNe+sC/qswOCeNWNIPoHIR9tQmpfi7gUpa41j3icsS
         cMvUgfV/SWBy0J76VW9/LOmfl89fFZSRpC/ou3t+FIbfxFpVXE6KeBUoDNPR59OYHJ1R
         6YDiplk723cxmK2kan3cFyX6czU5XXEl6PZzFRueMGG2vwuuxmkGakrQUFQ+Tx0002S2
         7cgkcsL8rKvunAIhphREA3ZX+ucWHm1ztvRyrDevdd8iLCbOq0s4j5xKuv86YaLo36VN
         34/A==
X-Gm-Message-State: ACrzQf00XU9HAp6Xf3LGLKcBgB3Y6rK0lcIzw1Qgd0QcPQuC7vYXs89p
        CtWS2cwRDGtr4UvHu7Xp4LyMMEovFUy5mO0fSMh7WQ==
X-Google-Smtp-Source: AMsMyM6vrGhmh/p4SKFqy2anpSAGg2zavB8DiqImU+Pk6mNYMjVBxK6TvhzwwuErIW2caX7ljkBnR/t2VrPytOoRZ6I=
X-Received: by 2002:a17:906:b34b:b0:7ad:e8dd:837c with SMTP id
 cd11-20020a170906b34b00b007ade8dd837cmr3571084ejb.264.1668102853085; Thu, 10
 Nov 2022 09:54:13 -0800 (PST)
MIME-Version: 1.0
References: <20221107205754.2635439-1-cukie@google.com> <CAHC9VhTLBWkw2XzqdFx1LFVKDtaAL2pEfsmm+LEmS0OWM1mZgA@mail.gmail.com>
In-Reply-To: <CAHC9VhTLBWkw2XzqdFx1LFVKDtaAL2pEfsmm+LEmS0OWM1mZgA@mail.gmail.com>
From:   Jeffrey Vander Stoep <jeffv@google.com>
Date:   Thu, 10 Nov 2022 18:54:00 +0100
Message-ID: <CABXk95ChjusTneWJgj5a58CZceZv0Ay-P-FwBcH2o4rO0g2Ggw@mail.gmail.com>
Subject: Re: [PATCH v1 0/2] Add LSM access controls for io_uring_setup
To:     Paul Moore <paul@paul-moore.com>
Cc:     Gil Cukierman <cukie@google.com>, Jens Axboe <axboe@kernel.dk>,
        Pavel Begunkov <asml.silence@gmail.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>, kernel-team@android.com,
        linux-kernel@vger.kernel.org, io-uring@vger.kernel.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Hi Paul,

There are a few reasons why we want this particular hook.

1.  It aligns well with how other resources are managed by selinux
where access to the resource is the first control point (e.g. "create"
for files, sockets, or bpf_maps, "prog_load" for bpf programs, and
"open" for perf_event) and then additional functionality or
capabilities require additional permissions.
2. It aligns well with how resources are managed on Android. We often
do not grant direct access to resources (like memory buffers). For
example, a single domain on Android manages the loading of all bpf
programs and the creation of all bpf maps. Other domains can be
granted access to these only once they're created. We can enforce base
properties with MAC, while allowing the system to manage and grant
access to resources at run-time via DAC (e.g. using Android's
permission model). This allows us to do better management and
accounting of resources.
3. Attack surface management. One of the primary uses of selinux on
Android is to assess and limit attack surface (e.g.
https://twitter.com/jeffvanderstoep/status/1422771606309335043) . As
io_uring vulnerabilities have made their way through our vulnerability
management system, it's become apparent that it's complicated to
assess the impact. Is a use-after-free reachable? Creating
proof-of-concept exploits takes a lot of time, and often functionality
can be reached by multiple paths. How many of the known io_uring
vulnerabilities would be gated by the existing checks? How many future
ones will be gated by the existing checks? I don't know the answer to
either of these questions and it's not obvious. I believe some of them
currently are exploitable without any selinux permissions. But in any
case, this hook makes that initial assessment simple and effective.

On Mon, Nov 7, 2022 at 10:17 PM Paul Moore <paul@paul-moore.com> wrote:
>
> On Mon, Nov 7, 2022 at 3:58 PM Gil Cukierman <cukie@google.com> wrote:
> >
> > This patchset provides the changes required for controlling access to
> > the io_uring_setup system call by LSMs. It does this by adding a new
> > hook to io_uring. It also provides the SELinux implementation for a new
> > permission, io_uring { setup }, using the new hook.
> >
> > This is important because existing io_uring hooks only support limiting
> > the sharing of credentials and access to the sensitive uring_cmd file
> > op. Users of LSMs may also want the ability to tightly control which
> > callers can retrieve an io_uring capable fd from the kernel, which is
> > needed for all subsequent io_uring operations.
>
> It isn't immediately obvious to me why simply obtaining a io_uring fd
> from io_uring_setup() would present a problem, as the security
> relevant operations that are possible with that io_uring fd *should*
> still be controlled by other LSM hooks.  Can you help me understand
> what security issue you are trying to resolve with this control?


I think there are a few reasons why we want this particular hook.

1.  It aligns well with how other resources are managed by selinux
where access to the resource is the first control point (e.g. "create"
for files, sockets, or bpf_maps, "prog_load" for bpf programs, and
"open" for perf_event) and then additional functionality or
capabilities require additional permissions.
2. It aligns well with how resources are managed on Android. We often
do not grant direct access to resources (like memory buffers). For
example, a single domain on Android manages the loading of all bpf
programs and the creation of all bpf maps. Other domains can be
granted access to these only once they're created. We can enforce base
properties with MAC, while allowing the system to manage and grant
access to resources at run-time via DAC (e.g. using Android's
permission model). This allows us to do better management and
accounting of resources.
3. Attack surface management. One of the primary uses of selinux on
Android is to assess and limit attack surface (e.g.
https://twitter.com/jeffvanderstoep/status/1422771606309335043) . As
io_uring vulnerabilities have made their way through our vulnerability
management system, it's become apparent that it's complicated to
assess the impact. Is a use-after-free reachable? Creating
proof-of-concept exploits takes a lot of time, and often functionality
can be reached by multiple paths. How many of the known io_uring
vulnerabilities would be gated by the existing checks? How many future
ones will be gated by the existing checks? I don't know the answer to
either of these questions and it's not obvious. This hook makes that
initial assessment simple and effective.
>

>
> --
> paul-moore.com
