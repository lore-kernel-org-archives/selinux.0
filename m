Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB8B2C43334
	for <selinux@archiver.kernel.org>; Mon, 25 Jul 2022 20:40:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237101AbiGYUkS (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 25 Jul 2022 16:40:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235916AbiGYUkQ (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 25 Jul 2022 16:40:16 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F2C42653
        for <selinux@vger.kernel.org>; Mon, 25 Jul 2022 13:40:14 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id c187-20020a1c35c4000000b003a30d88fe8eso10131735wma.2
        for <selinux@vger.kernel.org>; Mon, 25 Jul 2022 13:40:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EY+cZsCVuPUMipuVmrmAmJOTH4HYerax9O85jtChljI=;
        b=ztTdpy+pt6ELpcig/7HKX5VZUlsw+Y7kozcgokBUZc97dIgcB0yjGGPvVQ1AApzXDP
         BskTcNzPgACRR2Gst4PjvEeLMCXjFX3dP9EraxyLNwQEuCU5dhS8i0s4IjpO2u3R5p4N
         vbwUAgSmJwV8j1t+miT4By2vFbMM/Lq0V/iL6vVCodzt0/vXERTRrqL9sOOg1XhkeEGi
         HCHJiX0pfv7KjkX/GLBj71aHTWdshekQ8TilsMsygVsPHZ25UxgI+BcVZH3NDm3Wdpbd
         GOV8gReklcLq5rWu7IYewd7vOR5KMJh3bz4YInaAbFWb4vMesl1W8JJIm5uS0xzALL/T
         SQLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EY+cZsCVuPUMipuVmrmAmJOTH4HYerax9O85jtChljI=;
        b=g07aujYizoj2R0Yd4uG8GujzGFohvSkcATAneJzcoCHGZp7eUNGbWFeSPe5zrx9hhA
         X+4uuSQtytND7U/u+WQ3/lwYKXIghbSeWrB7C1PYMDgLz/lIYHNEAAgKTdH8Ncz7vlt+
         aJmcuif74zIKjplmsIXYoETOBYAgdZBlr/9KjWd8UxDd7sZkirgd4WsXSaHn6Bcd3kBx
         VlWzoediF2ov+fcMzBP46DrOoEQTD565KQGOazYigKpVOEaLJsvEjb1QF6BEuYtvIVg3
         DlCuM7e63/iCODacdwi4R+lh74f0A1aKtAMpNXYwwdLLhVMyzvPx1VR32RdPT865EYGF
         ABDg==
X-Gm-Message-State: AJIora9VcBrS7QNUCPdJp7rZ4UoRzHQ0wJotpu6LADnhHg967Q1XJuP9
        bXHv3My1nZLljlVGciQYWmekWyDF9UQ4INnDDsUc
X-Google-Smtp-Source: AGRyM1tgHgYwogyIAENImPAboOxpjdFAbVx35EIdD+BIQvbOFpu5qeAScjegrF8+ibmmJKouwbwvokfi1k6RQOga6uE=
X-Received: by 2002:a05:600c:34c2:b0:3a3:62d3:de5 with SMTP id
 d2-20020a05600c34c200b003a362d30de5mr3649563wmq.29.1658781612625; Mon, 25 Jul
 2022 13:40:12 -0700 (PDT)
MIME-Version: 1.0
References: <165818338297.423746.2325119921845739520.stgit@olly>
 <CAFqZXNvit5QK5zGjwp1tzFKSEyz0t85iqoE=Qv_yYnNYO1tsDQ@mail.gmail.com>
 <CAHC9VhRCyo6Fuq1iorFJpjn2wvN2VQba87tSfNwBdjyULZc-2Q@mail.gmail.com>
 <CAFqZXNus=Rnn=5qpQ4goLWvuinAA__ayjBCT0W3tR2HwtgOm=Q@mail.gmail.com>
 <CAHC9VhTg2jB_9F74yRsW59bHdMKQPPftV6EWGM0rK0zh0xeNuA@mail.gmail.com>
 <CAFqZXNs3+wcA_g0aojkmPACKM9tLwxxYV7OjiSjBfZNOnJeLrA@mail.gmail.com>
 <CAHC9VhT_JvJfafywYiHHdV93TAvgKZAPKQooshpG3CWyF+870w@mail.gmail.com> <CAFqZXNuCb+ugR0btKdBbQb7-MiHhEnm2L7XEKByVBf8+yb-x9Q@mail.gmail.com>
In-Reply-To: <CAFqZXNuCb+ugR0btKdBbQb7-MiHhEnm2L7XEKByVBf8+yb-x9Q@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 25 Jul 2022 16:40:01 -0400
Message-ID: <CAHC9VhTEG7DLqy4PiuJJuSgAR7L_zvMpoJauRYc_i99UjO=jWg@mail.gmail.com>
Subject: Re: [PATCH] tests/sctp: remove assumptions in the SCTP tests
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Jul 25, 2022 at 5:52 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> On Thu, Jul 21, 2022 at 3:51 PM Paul Moore <paul@paul-moore.com> wrote:
> > On Thu, Jul 21, 2022 at 4:14 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> > > On Thu, Jul 21, 2022 at 12:17 AM Paul Moore <paul@paul-moore.com> wrote:
> > > > On Wed, Jul 20, 2022 at 7:14 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> > > > > On Tue, Jul 19, 2022 at 4:28 PM Paul Moore <paul@paul-moore.com> wrote:
> > > > > > On Tue, Jul 19, 2022 at 7:58 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> > > > > > > On Tue, Jul 19, 2022 at 12:31 AM Paul Moore <paul@paul-moore.com> wrote:

...

> Ok, I'm going to merge this patch with some minor edits (see [1]) if
> you're okay with them and then I'll look into further improvements.
>
> [1] https://github.com/WOnder93/selinux-testsuite/commit/0f7bb1696a15972a555d997377348b8e4ae56b38

Whatever you need to do so you'll merge it is fine with me.  My goal
is a functional test suite, I don't care that much how we arrive at
that point :)

> > The difference being that with SCTP an association exists whereas
> > there is no similar state for UDP.
>
> That's irrelevant ...

It's not, but since we both agree the behavior isn't changing, let's
"agree to disagree" and move on.

-- 
paul-moore.com
