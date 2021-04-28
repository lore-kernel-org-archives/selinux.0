Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D9C8C433B4
	for <selinux@archiver.kernel.org>; Wed, 28 Apr 2021 21:11:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E281461408
	for <selinux@archiver.kernel.org>; Wed, 28 Apr 2021 21:11:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229549AbhD1VMe (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 28 Apr 2021 17:12:34 -0400
Received: from mx1.polytechnique.org ([129.104.30.34]:33870 "EHLO
        mx1.polytechnique.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229632AbhD1VMe (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 28 Apr 2021 17:12:34 -0400
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by ssl.polytechnique.org (Postfix) with ESMTPSA id A1947560618
        for <selinux@vger.kernel.org>; Wed, 28 Apr 2021 23:11:40 +0200 (CEST)
Received: by mail-pg1-f181.google.com with SMTP id s22so24537788pgk.6
        for <selinux@vger.kernel.org>; Wed, 28 Apr 2021 14:11:40 -0700 (PDT)
X-Gm-Message-State: AOAM533HzmmcrHsazIYoW63Bx7c6RV1pqm+ohqID9yIXjxO6pkzzjo+y
        sFt7sVjRDShDDxOm7AWuc+IkQc9rW0qtFSp+vAo=
X-Google-Smtp-Source: ABdhPJyn2k1z55MxmMavOiwK+uju3XHIqt78xIfXkWV17toMBSg8xA1PNVPF4OtsqjNa6z4Wnxsm7BcC16b/k2ambLo=
X-Received: by 2002:a63:5d18:: with SMTP id r24mr29741005pgb.94.1619644299335;
 Wed, 28 Apr 2021 14:11:39 -0700 (PDT)
MIME-Version: 1.0
References: <20210323170830.182553-1-omosnace@redhat.com> <cd8c8721-0194-e2d3-b7a5-2f00834b5f60@sony.com>
 <CAFqZXNvvDypzgzzbsBp9zQ1wOV=P9XmEPidmH_-8Zn2hGp-A5Q@mail.gmail.com>
In-Reply-To: <CAFqZXNvvDypzgzzbsBp9zQ1wOV=P9XmEPidmH_-8Zn2hGp-A5Q@mail.gmail.com>
From:   Nicolas Iooss <nicolas.iooss@m4x.org>
Date:   Wed, 28 Apr 2021 23:11:28 +0200
X-Gmail-Original-Message-ID: <CAJfZ7=mG+8RzeFD3ZOEuPFAhX+acc1YY3wOVi5k2tO9m6YgprA@mail.gmail.com>
Message-ID: <CAJfZ7=mG+8RzeFD3ZOEuPFAhX+acc1YY3wOVi5k2tO9m6YgprA@mail.gmail.com>
Subject: Re: [RFC PATCH userspace 0/6] Parallel setfiles/restorecon
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     peter enderborg <peter.enderborg@sony.com>,
        SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-AV-Checked: ClamAV using ClamSMTP at svoboda.polytechnique.org (Wed Apr 28 23:11:41 2021 +0200 (CEST))
X-Org-Mail: nicolas.iooss.2010@polytechnique.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Mar 24, 2021 at 12:05 PM Ondrej Mosnacek <omosnace@redhat.com> wrote:
>
> On Wed, Mar 24, 2021 at 10:59 AM peter enderborg
> <peter.enderborg@sony.com> wrote:
> > On 3/23/21 6:08 PM, Ondrej Mosnacek wrote:
> > > This series adds basic support for parallel relabeling to the libselinux
> > > API and the setfiles/restorecon CLI tools. It turns out that doing the
> > > relabeling in parallel can significantly reduce the time even with a
> > > relatively simple approach.
> > Nice! Have you any figures? Is it valid for both solid state and mechanical storage?
>
> They are in the last patch :) The VM setup I measured that on probably
> had the storage backed up by an SSD (or something with similar
> characteristics). I haven't tried it on an HDD yet.
>
> > > The first patch is a small cleanup that was found along the way and can
> > > be applied independently. Patches 2-4 are small incremental changes that
> > > make the internal selinux_restorecon functions more thread-safe (I kept
> > > them separate for ease of of review, but maybe they should be rather
> > > folded into the netx patch...). Patch 5 then completes the parallel
> > > relabeling implementation at libselinux level and adds a new function
> > > to the API that allows to make use of it. Finally, patch 6 adds parallel
> > > relabeling support to he setfiles/restorecon tools.
> > >
> > > The relevant man pages are also updated to reflect the new
> > > functionality.
> > >
> > > The patch descriptions contain more details, namely the last patch has
> > > also some benchmark numbers.
> > >
> > > Please test and review. I'm still not fully confident I got everything
> > > right (esp. regarding error handling), but I wanted to put this forward
> > > as an RFC to get some early feedback.
> > >
> > > Ondrej Mosnacek (6):
> > >   selinux_restorecon: simplify fl_head allocation by using calloc()
> > >   selinux_restorecon: protect file_spec list with a mutex
> > >   selinux_restorecon: introduce selinux_log_sync()
> > >   selinux_restorecon: add a global mutex to synchronize progress output
> > >   selinux_restorecon: introduce selinux_restorecon_parallel(3)
> > >   setfiles/restorecon: support parallel relabeling
> > >
> > >  libselinux/include/selinux/restorecon.h       |  14 +
> > >  libselinux/man/man3/selinux_restorecon.3      |  29 +
> > >  .../man/man3/selinux_restorecon_parallel.3    |   1 +
> > >  libselinux/src/libselinux.map                 |   5 +
> > >  libselinux/src/selinux_internal.h             |  14 +
> > >  libselinux/src/selinux_restorecon.c           | 498 ++++++++++++------
> > >  policycoreutils/setfiles/Makefile             |   2 +-
> > >  policycoreutils/setfiles/restore.c            |   7 +-
> > >  policycoreutils/setfiles/restore.h            |   2 +-
> > >  policycoreutils/setfiles/restorecon.8         |   9 +
> > >  policycoreutils/setfiles/setfiles.8           |   9 +
> > >  policycoreutils/setfiles/setfiles.c           |  28 +-
> > >  12 files changed, 436 insertions(+), 182 deletions(-)
> > >  create mode 100644 libselinux/man/man3/selinux_restorecon_parallel.3
> > >
> >

Hello,
I haven't seen any review of this RFC, so I decided to take a look.
The result looks quite good :) What is the current status of this
series, and can it become a "to-be-merged" patch series?

Anyway, here are some comments.

First, I was a little puzzled by the introduction of
selinux_log_sync() and the fact that it is used by
selinux_restorecon_common(), which means that callers of
selinux_restorecon() will also take the mutex log_mutex. This
surprised me because the description of one commit was very clear
about not depending very hard on libpthread... but in fact your code
is right there. I have just re-discovered the pthread helpers in
libselinux/src/selinux_internal.h :)

Nevertheless, now that I saw the pthread helpers, which enable using
libselinux without linking with libpthread, I am wondering: why is
introducing selinux_log_sync() like you do (and keeping calls to
selinux_log_sync() and selinux_log() in the code and praying that all
invocations from parallel code are converted to selinux_log_sync() )
better than introducing the mutex directly "in selinux_log()"? I
understand this is not so easy, because selinux_log is in fact a
function pointer... what I have in my mind consists in renaming the
pointer and in renaming a selinux_log_sync() to selinux_log(). This
would make the code less error-prone, regarding the issue of ensuring
to never call selinux_log callback in two parallel threads. What do
you think?

Then, when I compiled your patches with clang and some warning flags,
I got this warning:

selinux_restorecon.c:867:19: error: possible misuse of comma operator
here [-Werror,-Wcomma]
        while ((errno = 0, ftsent = fts_read(fts)) != NULL) {
                         ^
selinux_restorecon.c:867:10: note: cast expression to void to silence warning
        while ((errno = 0, ftsent = fts_read(fts)) != NULL) {
                ^~~~~~~~~
                (void)(  )
/usr/include/errno.h:38:16: note: expanded from macro 'errno'
# define errno (*__errno_location ())
               ^
1 error generated.

Using a comma operator seems to be right, here, and using the
suggested workaround to silence the compiler warning seems to be fine.

Finally, the generated file
libselinux/src/selinuxswig_python_exception.i needs to be upgraded,
because the new function selinux_restorecon_parallel is being added to
it. It would be nice to have a patch which updates this file, or to
have this update in patch "selinux_restorecon: introduce
selinux_restorecon_parallel(3)" (your choice).

Thanks!
Nicolas

