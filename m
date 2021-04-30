Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1756C43460
	for <selinux@archiver.kernel.org>; Fri, 30 Apr 2021 12:49:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A66F061477
	for <selinux@archiver.kernel.org>; Fri, 30 Apr 2021 12:49:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232802AbhD3MuR (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 30 Apr 2021 08:50:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:21994 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232760AbhD3MuQ (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 30 Apr 2021 08:50:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1619786967;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Wfh7FD1RjB4FyGrepjn8dad0KOH7vFty2NJvwcbb83s=;
        b=VbdxqtyQZxOgBULFDsQP0HDKEdSTd7K9FDtCYcqmZvY/0I7QNoB1JKBnPE1N3hRPqbgHYI
        IxDE8FEbmu3nqKnfUiKoIVvFfPPBdNcsCt8KSRx9cikeR/Dtxa1Y0HJ1pS0NMp+uIN+PTG
        f3k/VG2wm1k4nZCMkDJ7+T3kOo6wTl4=
Received: from mail-yb1-f199.google.com (mail-yb1-f199.google.com
 [209.85.219.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-588-YXpvIWykOHqxznkbMF81hg-1; Fri, 30 Apr 2021 08:49:25 -0400
X-MC-Unique: YXpvIWykOHqxznkbMF81hg-1
Received: by mail-yb1-f199.google.com with SMTP id s8-20020a5b04480000b029049fb35700b9so50115620ybp.5
        for <selinux@vger.kernel.org>; Fri, 30 Apr 2021 05:49:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Wfh7FD1RjB4FyGrepjn8dad0KOH7vFty2NJvwcbb83s=;
        b=AKmrMN3smYAlJgJC1nfpGPb61jmkRYd8OoKn4YURfDa9chf7CcrhEC34W4x4oH7dWh
         atTvcTxzF+Gslu7sUeud6I8H2Xy3a7FRa07I6CweGr9xJe8OOiy1QEB06NjnLRFEOab+
         zjdH8zLSIBgOn9y9QPL3qn3kfwua2LYcECqMkWT9ypq5GS4p+lWo4UdegIUZPGvvRcDF
         1JElu8hOjLBeN6wm5JSXnUSnNx3Infxp/JbMl6RWn1dmXMGlfudmCSMFJ4Lw4+Qk9x/q
         0ii8HBydZ/am/ki1M8s+HnSxJGi3X81fb1W+Gq3jwlWfTPX1Ai0Z7iesEeLIXyUS57dM
         IMpQ==
X-Gm-Message-State: AOAM5329kBmVR/ddh5BjSluNIDDYoXfnCfKb1CZla4Y8vA+VuQ4GEgDr
        Kyk9ArZvHAPuh0+E3WyQlEkbpX7DPk4dk3vBH0Kv/P+UcP3YbMfZQBL8+UBjJJURKVgHTYZC6TK
        CeTo6LjlMEkslckX6o4vqtFJDs6aYf4zMWQ==
X-Received: by 2002:a25:cccd:: with SMTP id l196mr7184808ybf.26.1619786964927;
        Fri, 30 Apr 2021 05:49:24 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJymM82n2QEcacVzVPXn/5DIQqNdz7oO7YQ8iMR/Qg464HVSyvNp6up1ETh1rbBiv2cLvFfFqIrgeQDiMeU0Cck=
X-Received: by 2002:a25:cccd:: with SMTP id l196mr7184781ybf.26.1619786964682;
 Fri, 30 Apr 2021 05:49:24 -0700 (PDT)
MIME-Version: 1.0
References: <20210323170830.182553-1-omosnace@redhat.com> <cd8c8721-0194-e2d3-b7a5-2f00834b5f60@sony.com>
 <CAFqZXNvvDypzgzzbsBp9zQ1wOV=P9XmEPidmH_-8Zn2hGp-A5Q@mail.gmail.com> <CAJfZ7=mG+8RzeFD3ZOEuPFAhX+acc1YY3wOVi5k2tO9m6YgprA@mail.gmail.com>
In-Reply-To: <CAJfZ7=mG+8RzeFD3ZOEuPFAhX+acc1YY3wOVi5k2tO9m6YgprA@mail.gmail.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Fri, 30 Apr 2021 14:49:13 +0200
Message-ID: <CAFqZXNuehsMNk+zvHs_=688-U0LeEta7V+-=BsT0FXTsvQA4Cw@mail.gmail.com>
Subject: Re: [RFC PATCH userspace 0/6] Parallel setfiles/restorecon
To:     Nicolas Iooss <nicolas.iooss@m4x.org>
Cc:     peter enderborg <peter.enderborg@sony.com>,
        SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Apr 28, 2021 at 11:12 PM Nicolas Iooss <nicolas.iooss@m4x.org> wrote:
> On Wed, Mar 24, 2021 at 12:05 PM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> >
> > On Wed, Mar 24, 2021 at 10:59 AM peter enderborg
> > <peter.enderborg@sony.com> wrote:
> > > On 3/23/21 6:08 PM, Ondrej Mosnacek wrote:
> > > > This series adds basic support for parallel relabeling to the libselinux
> > > > API and the setfiles/restorecon CLI tools. It turns out that doing the
> > > > relabeling in parallel can significantly reduce the time even with a
> > > > relatively simple approach.
> > > Nice! Have you any figures? Is it valid for both solid state and mechanical storage?
> >
> > They are in the last patch :) The VM setup I measured that on probably
> > had the storage backed up by an SSD (or something with similar
> > characteristics). I haven't tried it on an HDD yet.
> >
> > > > The first patch is a small cleanup that was found along the way and can
> > > > be applied independently. Patches 2-4 are small incremental changes that
> > > > make the internal selinux_restorecon functions more thread-safe (I kept
> > > > them separate for ease of of review, but maybe they should be rather
> > > > folded into the netx patch...). Patch 5 then completes the parallel
> > > > relabeling implementation at libselinux level and adds a new function
> > > > to the API that allows to make use of it. Finally, patch 6 adds parallel
> > > > relabeling support to he setfiles/restorecon tools.
> > > >
> > > > The relevant man pages are also updated to reflect the new
> > > > functionality.
> > > >
> > > > The patch descriptions contain more details, namely the last patch has
> > > > also some benchmark numbers.
> > > >
> > > > Please test and review. I'm still not fully confident I got everything
> > > > right (esp. regarding error handling), but I wanted to put this forward
> > > > as an RFC to get some early feedback.
> > > >
> > > > Ondrej Mosnacek (6):
> > > >   selinux_restorecon: simplify fl_head allocation by using calloc()
> > > >   selinux_restorecon: protect file_spec list with a mutex
> > > >   selinux_restorecon: introduce selinux_log_sync()
> > > >   selinux_restorecon: add a global mutex to synchronize progress output
> > > >   selinux_restorecon: introduce selinux_restorecon_parallel(3)
> > > >   setfiles/restorecon: support parallel relabeling
> > > >
> > > >  libselinux/include/selinux/restorecon.h       |  14 +
> > > >  libselinux/man/man3/selinux_restorecon.3      |  29 +
> > > >  .../man/man3/selinux_restorecon_parallel.3    |   1 +
> > > >  libselinux/src/libselinux.map                 |   5 +
> > > >  libselinux/src/selinux_internal.h             |  14 +
> > > >  libselinux/src/selinux_restorecon.c           | 498 ++++++++++++------
> > > >  policycoreutils/setfiles/Makefile             |   2 +-
> > > >  policycoreutils/setfiles/restore.c            |   7 +-
> > > >  policycoreutils/setfiles/restore.h            |   2 +-
> > > >  policycoreutils/setfiles/restorecon.8         |   9 +
> > > >  policycoreutils/setfiles/setfiles.8           |   9 +
> > > >  policycoreutils/setfiles/setfiles.c           |  28 +-
> > > >  12 files changed, 436 insertions(+), 182 deletions(-)
> > > >  create mode 100644 libselinux/man/man3/selinux_restorecon_parallel.3
> > > >
> > >
>
> Hello,
> I haven't seen any review of this RFC, so I decided to take a look.
> The result looks quite good :) What is the current status of this
> series, and can it become a "to-be-merged" patch series?

I hope it can :) I posted it as an RFC initially mainly to get some
high-level feedback whether I'm going in the right direction. But
based on your reply it seems it's already close enough to
acceptability that I could drop the RFC in the next revision. I also
didn't test it all that thoroughly, especially w.r.t. various
corner-cases...

>
> Anyway, here are some comments.
>
> First, I was a little puzzled by the introduction of
> selinux_log_sync() and the fact that it is used by
> selinux_restorecon_common(), which means that callers of
> selinux_restorecon() will also take the mutex log_mutex. This
> surprised me because the description of one commit was very clear
> about not depending very hard on libpthread... but in fact your code
> is right there. I have just re-discovered the pthread helpers in
> libselinux/src/selinux_internal.h :)
>
> Nevertheless, now that I saw the pthread helpers, which enable using
> libselinux without linking with libpthread, I am wondering: why is
> introducing selinux_log_sync() like you do (and keeping calls to
> selinux_log_sync() and selinux_log() in the code and praying that all
> invocations from parallel code are converted to selinux_log_sync() )
> better than introducing the mutex directly "in selinux_log()"? I
> understand this is not so easy, because selinux_log is in fact a
> function pointer... what I have in my mind consists in renaming the
> pointer and in renaming a selinux_log_sync() to selinux_log(). This
> would make the code less error-prone, regarding the issue of ensuring
> to never call selinux_log callback in two parallel threads. What do
> you think?

That's a good question. Since this will be the first function in
libselinux with some internal parallelism, I guess I just didn't want
to affect the status quo of existing code too much... Indeed the lock
would be taken also in the single-threaded implementation, but since
in selinux_restorecon() selinux_log() is called only in non-hot paths,
I didn't bother optimizing that.

Anyway, I agree that making selinux_log() synchronized globally may be
a good idea. The cost should be minimal and it would prevent
accidental race conditions. If some reasonable quorum of maintainers
agrees, I will make that change in v2.

> Then, when I compiled your patches with clang and some warning flags,
> I got this warning:
>
> selinux_restorecon.c:867:19: error: possible misuse of comma operator
> here [-Werror,-Wcomma]
>         while ((errno = 0, ftsent = fts_read(fts)) != NULL) {
>                          ^
> selinux_restorecon.c:867:10: note: cast expression to void to silence warning
>         while ((errno = 0, ftsent = fts_read(fts)) != NULL) {
>                 ^~~~~~~~~
>                 (void)(  )
> /usr/include/errno.h:38:16: note: expanded from macro 'errno'
> # define errno (*__errno_location ())
>                ^
> 1 error generated.
>
> Using a comma operator seems to be right, here, and using the
> suggested workaround to silence the compiler warning seems to be fine.

Hm, yes, I think I'll just add the cast to void there... Not a big fan
of the comma operator, but I couldn't resist the temptation to use it
here :)

> Finally, the generated file
> libselinux/src/selinuxswig_python_exception.i needs to be upgraded,
> because the new function selinux_restorecon_parallel is being added to
> it. It would be nice to have a patch which updates this file, or to
> have this update in patch "selinux_restorecon: introduce
> selinux_restorecon_parallel(3)" (your choice).

Ah, thanks for pointing that out. I'll address it in v2.

--
Ondrej Mosnacek
Software Engineer, Linux Security - SELinux kernel
Red Hat, Inc.

