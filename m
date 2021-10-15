Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3544FC433F5
	for <selinux@archiver.kernel.org>; Fri, 15 Oct 2021 13:25:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1E47761090
	for <selinux@archiver.kernel.org>; Fri, 15 Oct 2021 13:25:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239374AbhJON16 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 15 Oct 2021 09:27:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:31807 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235985AbhJON16 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 15 Oct 2021 09:27:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634304351;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dHenlf9ra9shQEwPVA+CdkdHYcY/WXXraDBRXcDbZwo=;
        b=NYRpRJScjGC4yDE0Woo7k8wv6XawKziZwcBaw0n/urd7hyLJa7a4uoJtCZJpQ6n3rvt3Db
        8YRZUUGLzLbKQZQ/qr+YXilHAu9OrNdeWFIv+jqZ4BRXje9UKSF5Xfjsn9aucLqFcZXRF0
        yrESzjBTtLrqLKeK2+ETgaSN8zXXaeI=
Received: from mail-yb1-f200.google.com (mail-yb1-f200.google.com
 [209.85.219.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-185-0DQ43U4vNnSgCRy5CBwTdg-1; Fri, 15 Oct 2021 09:25:50 -0400
X-MC-Unique: 0DQ43U4vNnSgCRy5CBwTdg-1
Received: by mail-yb1-f200.google.com with SMTP id v70-20020a256149000000b005ba4d61ea0fso11132281ybb.22
        for <selinux@vger.kernel.org>; Fri, 15 Oct 2021 06:25:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=dHenlf9ra9shQEwPVA+CdkdHYcY/WXXraDBRXcDbZwo=;
        b=GnIYUOygqiO0BqC+yNRNP4dcE8UGK9Q70j7buRFmve1Blb9AFqgPlXmFvjEoU+GxOv
         5tHkt/ypM3tuJDs6PAY0Hl5fzzgtdESmsRlQgUbIpJ/7hv6oLOAm3fD3zastMDuN3cLg
         eb7wYAURERYFHchAUUznC5lHXtww49512wnRJTiIBLC+RmdNDWjfGu0UYwPXSNIqgmP3
         NwgKAa2TUEFcPd5+9u7iV+TAlXqdaQfhEYtXE/t9QxOa1eT4Qpv6oHcykao7QURVgd7q
         ue2UlfOzGkOnLY9VnwXGneWTNozanO3jlTUHgV8nUxMs70InRCrSZnhvSFaIUnc2+X/g
         9cCQ==
X-Gm-Message-State: AOAM532PqDUl7QaockVHSJO7jAS+JP2QWU3lTZ+/AGlJnVupMqNQWJPX
        y7Xq32FfC/BGOsnyZON6G9TKB8Bszt3DT8OXZYVfALD8JJny9SK3hZ+16HOxkKamHTM023DK5hw
        /pAdwwfyiv+bQcYX9XSkNAyvDfCtRhtoqlw==
X-Received: by 2002:a25:5484:: with SMTP id i126mr12978749ybb.25.1634304349110;
        Fri, 15 Oct 2021 06:25:49 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzVjAAh6BiDqeA4fscQoY+cXL6wQErj/xOoy8r27zfF4BF5bcG7ofS80qPoOeyBUiE2sY4J+niL1hnpZxFDjns=
X-Received: by 2002:a25:5484:: with SMTP id i126mr12978715ybb.25.1634304348794;
 Fri, 15 Oct 2021 06:25:48 -0700 (PDT)
MIME-Version: 1.0
References: <20211014145319.798740-1-omosnace@redhat.com> <CAJ2a_DdKTg8qoFV6HG71d_3Ufbpn6=xiYJ-M8UDcUrkqVEm80g@mail.gmail.com>
In-Reply-To: <CAJ2a_DdKTg8qoFV6HG71d_3Ufbpn6=xiYJ-M8UDcUrkqVEm80g@mail.gmail.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Fri, 15 Oct 2021 15:25:36 +0200
Message-ID: <CAFqZXNtWW+U+bNhM_AJ-A6WCj_jHo+=DXH1QHT7i7G-X+vYDqg@mail.gmail.com>
Subject: Re: [PATCH userspace v2 0/6] Parallel setfiles/restorecon
To:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Oct 15, 2021 at 2:37 PM Christian G=C3=B6ttsche
<cgzones@googlemail.com> wrote:
> On Thu, 14 Oct 2021 at 16:53, Ondrej Mosnacek <omosnace@redhat.com> wrote=
:
> >
> > This series adds basic support for parallel relabeling to the libselinu=
x
> > API and the setfiles/restorecon CLI tools. It turns out that doing the
> > relabeling in parallel can significantly reduce the time even with a
> > relatively simple approach.
> >
> > The first patch is a small cleanup that was found along the way and can
> > be applied independently. Patches 2-4 are small incremental changes tha=
t
> > make the internal selinux_restorecon functions more thread-safe (I kept
> > them separate for ease of of review, but maybe they should be rather
> > folded into the netx patch...). Patch 5 then completes the parallel
> > relabeling implementation at libselinux level and adds a new function
> > to the API that allows to make use of it. Finally, patch 6 adds paralle=
l
> > relabeling support to he setfiles/restorecon tools.
> >
> > The relevant man pages are also updated to reflect the new
> > functionality.
> >
> > The patch descriptions contain more details, namely the last patch has
> > also some benchmark numbers.
> >
> > Changes v1->v2:
> > - make selinux_log() synchronized instead of introducing selinux_log_sy=
nc()
> > - fix -Wcomma warning
> > - update the swig files as well
> > - bump new symbol version to LIBSELINUX_3.3 (this may need further upda=
te
> >   depending on when this gets merged)
> >
> > Ondrej Mosnacek (6):
> >   selinux_restorecon: simplify fl_head allocation by using calloc()
> >   selinux_restorecon: protect file_spec list with a mutex
> >   libselinux: make selinux_log() thread-safe
> >   selinux_restorecon: add a global mutex to synchronize progress output
> >   selinux_restorecon: introduce selinux_restorecon_parallel(3)
> >   setfiles/restorecon: support parallel relabeling
> >
> >  libselinux/include/selinux/restorecon.h       |  14 +
> >  libselinux/man/man3/selinux_restorecon.3      |  29 ++
> >  .../man/man3/selinux_restorecon_parallel.3    |   1 +
> >  libselinux/src/callbacks.c                    |   8 +-
> >  libselinux/src/callbacks.h                    |  13 +-
> >  libselinux/src/libselinux.map                 |   5 +
> >  libselinux/src/selinux_internal.h             |  14 +
> >  libselinux/src/selinux_restorecon.c           | 466 ++++++++++++------
> >  libselinux/src/selinuxswig_python.i           |   6 +-
> >  libselinux/src/selinuxswig_python_exception.i |   8 +
> >  policycoreutils/setfiles/Makefile             |   2 +-
> >  policycoreutils/setfiles/restore.c            |   7 +-
> >  policycoreutils/setfiles/restore.h            |   2 +-
> >  policycoreutils/setfiles/restorecon.8         |   9 +
> >  policycoreutils/setfiles/setfiles.8           |   9 +
> >  policycoreutils/setfiles/setfiles.c           |  28 +-
> >  16 files changed, 444 insertions(+), 177 deletions(-)
> >  create mode 100644 libselinux/man/man3/selinux_restorecon_parallel.3
> >
> > --
> > 2.31.1
> >
>
>
> Running under ThreadSanitizer shows multiple instances of the following i=
ssue:
>
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> WARNING: ThreadSanitizer: data race (pid=3D16933)
>   Read of size 4 at 0x7f8790d636f4 by thread T2:
>     #0 lookup_all ./libselinux/src/label_file.c:954 (libselinux.so.1+0x14=
d1b)
>     #1 lookup_common ./libselinux/src/label_file.c:997 (libselinux.so.1+0=
x14f62)
>     #2 lookup ./libselinux/src/label_file.c:1095 (libselinux.so.1+0x14fff=
)
>     #3 selabel_lookup_common ./libselinux/src/label.c:167
> (libselinux.so.1+0x12291)
>     #4 selabel_lookup_raw ./libselinux/src/label.c:256 (libselinux.so.1+0=
x126ca)
>     #5 restorecon_sb ./libselinux/src/selinux_restorecon.c:638
> (libselinux.so.1+0x20c76)
>     #6 selinux_restorecon_thread
> ./libselinux/src/selinux_restorecon.c:947 (libselinux.so.1+0x21e99)
>
>   Previous write of size 4 at 0x7f8790d636f4 by thread T1:
>     #0 lookup_all ./libselinux/src/label_file.c:954 (libselinux.so.1+0x14=
d29)
>     #1 lookup_common ./libselinux/src/label_file.c:997 (libselinux.so.1+0=
x14f62)
>     #2 lookup ./libselinux/src/label_file.c:1095 (libselinux.so.1+0x14fff=
)
>     #3 selabel_lookup_common ./libselinux/src/label.c:167
> (libselinux.so.1+0x12291)
>     #4 selabel_lookup_raw ./libselinux/src/label.c:256 (libselinux.so.1+0=
x126ca)
>     #5 restorecon_sb ./libselinux/src/selinux_restorecon.c:638
> (libselinux.so.1+0x20c76)
>     #6 selinux_restorecon_thread
> ./libselinux/src/selinux_restorecon.c:947 (libselinux.so.1+0x21e99)
>
>   Location is heap block of size 267120 at 0x7f8790d45000 allocated by
> main thread:
>     #0 malloc ../../../../src/libsanitizer/tsan/tsan_interceptors_posix.c=
pp:655
> (libtsan.so.0+0x31799)
>     #1 sort_specs ./libselinux/src/label_file.h:207 (libselinux.so.1+0x17=
bd9)
>     #2 init ./libselinux/src/label_file.c:795 (libselinux.so.1+0x17bd9)
>     #3 selabel_file_init ./libselinux/src/label_file.c:1293
> (libselinux.so.1+0x1835b)
>     #4 selabel_open ./libselinux/src/label.c:228 (libselinux.so.1+0x125d8=
)
>     #5 restore_init ./policycoreutils/setfiles/restore.c:30 (setfiles+0x3=
886)
>     #6 main ./policycoreutils/setfiles/setfiles.c:434 (setfiles+0x344e)
>
>   Thread T2 (tid=3D16940, running) created by main thread at:
>     #0 pthread_create
> ../../../../src/libsanitizer/tsan/tsan_interceptors_posix.cpp:969
> (libtsan.so.0+0x5ad75)
>     #1 selinux_restorecon_common
> ./libselinux/src/selinux_restorecon.c:1197 (libselinux.so.1+0x2341c)
>     #2 selinux_restorecon_parallel
> ./libselinux/src/selinux_restorecon.c:1306 (libselinux.so.1+0x23985)
>     #3 process_glob ./policycoreutils/setfiles/restore.c:94 (setfiles+0x3=
ba4)
>     #4 main ./policycoreutils/setfiles/setfiles.c:463 (setfiles+0x362a)
>
>   Thread T1 (tid=3D16939, running) created by main thread at:
>     #0 pthread_create
> ../../../../src/libsanitizer/tsan/tsan_interceptors_posix.cpp:969
> (libtsan.so.0+0x5ad75)
>     #1 selinux_restorecon_common
> ./libselinux/src/selinux_restorecon.c:1197 (libselinux.so.1+0x2341c)
>     #2 selinux_restorecon_parallel
> ./libselinux/src/selinux_restorecon.c:1306 (libselinux.so.1+0x23985)
>     #3 process_glob ./policycoreutils/setfiles/restore.c:94 (setfiles+0x3=
ba4)
>     #4 main ./policycoreutils/setfiles/setfiles.c:463 (setfiles+0x362a)
>
> SUMMARY: ThreadSanitizer: data race ./libselinux/src/label_file.c:954
> in lookup_all
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

Good catch, although this one seems to be pre-existing w.r.t. thread
safety of selinux_restorecon(3) (which seems to be implied by the
existence of struct spec::regex_lock). I spotted some existing usage
of GCC atomic builtins, so I'll try to fix it using those.

> Also some thread joins seems to be missing:
>
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> WARNING: ThreadSanitizer: thread leak (pid=3D16933)
>   Thread T1 (tid=3D16939, finished) created by main thread at:
>     #0 pthread_create
> ../../../../src/libsanitizer/tsan/tsan_interceptors_posix.cpp:969
> (libtsan.so.0+0x5ad75)
>     #1 selinux_restorecon_common
> ./libselinux/src/selinux_restorecon.c:1197 (libselinux.so.1+0x2341c)
>     #2 selinux_restorecon_parallel
> ./libselinux/src/selinux_restorecon.c:1306 (libselinux.so.1+0x23985)
>     #3 process_glob ./policycoreutils/setfiles/restore.c:94 (setfiles+0x3=
ba4)
>     #4 main ./policycoreutils/setfiles/setfiles.c:463 (setfiles+0x362a)
>
>   And 2 more similar thread leaks.
>
> SUMMARY: ThreadSanitizer: thread leak
> ./libselinux/src/selinux_restorecon.c:1197 in
> selinux_restorecon_common
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

Hm... My intention was to avoid the need for joins by synchronizing
via other means and just letting the threads exit on their own, but I
guess that doesn't fly with the sanitizer. Guess I'll have to allocate
an array for the handles and join the threads at the end after all...

--=20
Ondrej Mosnacek
Software Engineer, Linux Security - SELinux kernel
Red Hat, Inc.

