Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3863EC433F5
	for <selinux@archiver.kernel.org>; Tue, 19 Oct 2021 12:29:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1D7EE61154
	for <selinux@archiver.kernel.org>; Tue, 19 Oct 2021 12:29:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235549AbhJSMb2 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 19 Oct 2021 08:31:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:59798 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230097AbhJSMb2 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 19 Oct 2021 08:31:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634646555;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+nHL836IcAIHCWCbQNh8RfCYaeiBItPgAiIWOYina5M=;
        b=MYz/Zb08ywBkbbXL39ZZ0xB7EIPvapdv8oHbbjvNNYTRg1AmVZqtoceEmjKmGfbqdRE+JP
        FUVKiBA756bTtdbGsQsQ8Mu7O+LrZQpFjnaCNJ2qwhUJHLzHwd6KbGN7xeBlXCehPTjuJY
        YmKIJiL0bg22Wcq+UG2cHYd4I+Z0CIo=
Received: from mail-yb1-f197.google.com (mail-yb1-f197.google.com
 [209.85.219.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-71-LWZ7gScYP7abwKQIjSJiZQ-1; Tue, 19 Oct 2021 08:29:13 -0400
X-MC-Unique: LWZ7gScYP7abwKQIjSJiZQ-1
Received: by mail-yb1-f197.google.com with SMTP id q193-20020a252aca000000b005ba63482993so24539426ybq.0
        for <selinux@vger.kernel.org>; Tue, 19 Oct 2021 05:29:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=+nHL836IcAIHCWCbQNh8RfCYaeiBItPgAiIWOYina5M=;
        b=PaTZpGXhVWW2UdptrLBEVKgfnQrA3+NXAno8jwRcBP/lk1nVEQPJ3NixvtGF1GS4wO
         AjR2C1Qnxzizm3RFqhCTOI7JVrqgQaU5KEY5C2zqNNRalCa0YQISpd154H8je0BLkHki
         FReYYeFeV4gm5/QYRvYJ52kmkSYd87dW6ihSvTLDjCNj7BYl4GdwyHprAuEmVoyoQk+o
         6tZl5bxQaSjxdQTHGe0seV/1EvTyV0VhnPByZdB3zoZLsFAj5GPQFdNJVyL8qdNk/58M
         0Hu2g6PfQxbySwXQeQPA5lFEc8Yo57kGJX/vgvEGpkjXXksOKclPXzqPsz8eG4inP1cB
         kFsA==
X-Gm-Message-State: AOAM530Fu8QBPEnsflQRsC95/LXXOex/UgqxVvMNrmzA0uZMJBl15P2U
        8bnaT/veWlY7DsgvSj0XD+3McsHK3H4QGrEIzgYU+OMYJDWeLlgpACe5rq5AlbJfRtjuoOJtgv5
        DcWEFWKiSErTfiXh+M0+mLuC74U18DppLjg==
X-Received: by 2002:a25:c0d2:: with SMTP id c201mr18185332ybf.467.1634646552546;
        Tue, 19 Oct 2021 05:29:12 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyBP/8xd8sl+YRGtqtvzRq6c9xu+Gr7TDF5hWj2Da1iBrV6/+eHNblP/2Y2VCtoZAtjlo4KEbDJnZ40JJRJJYQ=
X-Received: by 2002:a25:c0d2:: with SMTP id c201mr18185312ybf.467.1634646552292;
 Tue, 19 Oct 2021 05:29:12 -0700 (PDT)
MIME-Version: 1.0
References: <20211014145319.798740-1-omosnace@redhat.com> <CAJ2a_DdKTg8qoFV6HG71d_3Ufbpn6=xiYJ-M8UDcUrkqVEm80g@mail.gmail.com>
 <CAFqZXNtWW+U+bNhM_AJ-A6WCj_jHo+=DXH1QHT7i7G-X+vYDqg@mail.gmail.com> <CAFqZXNuL-jb=QptF2ZuQ8208j9g1-xJXTAkfPia7MwYZmfEbWA@mail.gmail.com>
In-Reply-To: <CAFqZXNuL-jb=QptF2ZuQ8208j9g1-xJXTAkfPia7MwYZmfEbWA@mail.gmail.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Tue, 19 Oct 2021 14:29:01 +0200
Message-ID: <CAFqZXNt2V21x7bAYGVQ_U818ZfShAYiyzzdU8D2L9uBZrsea1g@mail.gmail.com>
Subject: Re: [PATCH userspace v2 0/6] Parallel setfiles/restorecon
To:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Oct 18, 2021 at 10:56 AM Ondrej Mosnacek <omosnace@redhat.com> wrot=
e:
> On Fri, Oct 15, 2021 at 3:25 PM Ondrej Mosnacek <omosnace@redhat.com> wro=
te:
> > On Fri, Oct 15, 2021 at 2:37 PM Christian G=C3=B6ttsche
> > <cgzones@googlemail.com> wrote:
> > > On Thu, 14 Oct 2021 at 16:53, Ondrej Mosnacek <omosnace@redhat.com> w=
rote:
> > > >
> > > > This series adds basic support for parallel relabeling to the libse=
linux
> > > > API and the setfiles/restorecon CLI tools. It turns out that doing =
the
> > > > relabeling in parallel can significantly reduce the time even with =
a
> > > > relatively simple approach.
> > > >
> > > > The first patch is a small cleanup that was found along the way and=
 can
> > > > be applied independently. Patches 2-4 are small incremental changes=
 that
> > > > make the internal selinux_restorecon functions more thread-safe (I =
kept
> > > > them separate for ease of of review, but maybe they should be rathe=
r
> > > > folded into the netx patch...). Patch 5 then completes the parallel
> > > > relabeling implementation at libselinux level and adds a new functi=
on
> > > > to the API that allows to make use of it. Finally, patch 6 adds par=
allel
> > > > relabeling support to he setfiles/restorecon tools.
> > > >
> > > > The relevant man pages are also updated to reflect the new
> > > > functionality.
> > > >
> > > > The patch descriptions contain more details, namely the last patch =
has
> > > > also some benchmark numbers.
> > > >
> > > > Changes v1->v2:
> > > > - make selinux_log() synchronized instead of introducing selinux_lo=
g_sync()
> > > > - fix -Wcomma warning
> > > > - update the swig files as well
> > > > - bump new symbol version to LIBSELINUX_3.3 (this may need further =
update
> > > >   depending on when this gets merged)
> > > >
> > > > Ondrej Mosnacek (6):
> > > >   selinux_restorecon: simplify fl_head allocation by using calloc()
> > > >   selinux_restorecon: protect file_spec list with a mutex
> > > >   libselinux: make selinux_log() thread-safe
> > > >   selinux_restorecon: add a global mutex to synchronize progress ou=
tput
> > > >   selinux_restorecon: introduce selinux_restorecon_parallel(3)
> > > >   setfiles/restorecon: support parallel relabeling
> > > >
> > > >  libselinux/include/selinux/restorecon.h       |  14 +
> > > >  libselinux/man/man3/selinux_restorecon.3      |  29 ++
> > > >  .../man/man3/selinux_restorecon_parallel.3    |   1 +
> > > >  libselinux/src/callbacks.c                    |   8 +-
> > > >  libselinux/src/callbacks.h                    |  13 +-
> > > >  libselinux/src/libselinux.map                 |   5 +
> > > >  libselinux/src/selinux_internal.h             |  14 +
> > > >  libselinux/src/selinux_restorecon.c           | 466 ++++++++++++--=
----
> > > >  libselinux/src/selinuxswig_python.i           |   6 +-
> > > >  libselinux/src/selinuxswig_python_exception.i |   8 +
> > > >  policycoreutils/setfiles/Makefile             |   2 +-
> > > >  policycoreutils/setfiles/restore.c            |   7 +-
> > > >  policycoreutils/setfiles/restore.h            |   2 +-
> > > >  policycoreutils/setfiles/restorecon.8         |   9 +
> > > >  policycoreutils/setfiles/setfiles.8           |   9 +
> > > >  policycoreutils/setfiles/setfiles.c           |  28 +-
> > > >  16 files changed, 444 insertions(+), 177 deletions(-)
> > > >  create mode 100644 libselinux/man/man3/selinux_restorecon_parallel=
.3
> > > >
> > > > --
> > > > 2.31.1
> > > >
> > >
> > >
> > > Running under ThreadSanitizer shows multiple instances of the followi=
ng issue:
> > >
> > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > WARNING: ThreadSanitizer: data race (pid=3D16933)
> > >   Read of size 4 at 0x7f8790d636f4 by thread T2:
> > >     #0 lookup_all ./libselinux/src/label_file.c:954 (libselinux.so.1+=
0x14d1b)
> > >     #1 lookup_common ./libselinux/src/label_file.c:997 (libselinux.so=
.1+0x14f62)
> > >     #2 lookup ./libselinux/src/label_file.c:1095 (libselinux.so.1+0x1=
4fff)
> > >     #3 selabel_lookup_common ./libselinux/src/label.c:167
> > > (libselinux.so.1+0x12291)
> > >     #4 selabel_lookup_raw ./libselinux/src/label.c:256 (libselinux.so=
.1+0x126ca)
> > >     #5 restorecon_sb ./libselinux/src/selinux_restorecon.c:638
> > > (libselinux.so.1+0x20c76)
> > >     #6 selinux_restorecon_thread
> > > ./libselinux/src/selinux_restorecon.c:947 (libselinux.so.1+0x21e99)
> > >
> > >   Previous write of size 4 at 0x7f8790d636f4 by thread T1:
> > >     #0 lookup_all ./libselinux/src/label_file.c:954 (libselinux.so.1+=
0x14d29)
> > >     #1 lookup_common ./libselinux/src/label_file.c:997 (libselinux.so=
.1+0x14f62)
> > >     #2 lookup ./libselinux/src/label_file.c:1095 (libselinux.so.1+0x1=
4fff)
> > >     #3 selabel_lookup_common ./libselinux/src/label.c:167
> > > (libselinux.so.1+0x12291)
> > >     #4 selabel_lookup_raw ./libselinux/src/label.c:256 (libselinux.so=
.1+0x126ca)
> > >     #5 restorecon_sb ./libselinux/src/selinux_restorecon.c:638
> > > (libselinux.so.1+0x20c76)
> > >     #6 selinux_restorecon_thread
> > > ./libselinux/src/selinux_restorecon.c:947 (libselinux.so.1+0x21e99)
> > >
> > >   Location is heap block of size 267120 at 0x7f8790d45000 allocated b=
y
> > > main thread:
> > >     #0 malloc ../../../../src/libsanitizer/tsan/tsan_interceptors_pos=
ix.cpp:655
> > > (libtsan.so.0+0x31799)
> > >     #1 sort_specs ./libselinux/src/label_file.h:207 (libselinux.so.1+=
0x17bd9)
> > >     #2 init ./libselinux/src/label_file.c:795 (libselinux.so.1+0x17bd=
9)
> > >     #3 selabel_file_init ./libselinux/src/label_file.c:1293
> > > (libselinux.so.1+0x1835b)
> > >     #4 selabel_open ./libselinux/src/label.c:228 (libselinux.so.1+0x1=
25d8)
> > >     #5 restore_init ./policycoreutils/setfiles/restore.c:30 (setfiles=
+0x3886)
> > >     #6 main ./policycoreutils/setfiles/setfiles.c:434 (setfiles+0x344=
e)
> > >
> > >   Thread T2 (tid=3D16940, running) created by main thread at:
> > >     #0 pthread_create
> > > ../../../../src/libsanitizer/tsan/tsan_interceptors_posix.cpp:969
> > > (libtsan.so.0+0x5ad75)
> > >     #1 selinux_restorecon_common
> > > ./libselinux/src/selinux_restorecon.c:1197 (libselinux.so.1+0x2341c)
> > >     #2 selinux_restorecon_parallel
> > > ./libselinux/src/selinux_restorecon.c:1306 (libselinux.so.1+0x23985)
> > >     #3 process_glob ./policycoreutils/setfiles/restore.c:94 (setfiles=
+0x3ba4)
> > >     #4 main ./policycoreutils/setfiles/setfiles.c:463 (setfiles+0x362=
a)
> > >
> > >   Thread T1 (tid=3D16939, running) created by main thread at:
> > >     #0 pthread_create
> > > ../../../../src/libsanitizer/tsan/tsan_interceptors_posix.cpp:969
> > > (libtsan.so.0+0x5ad75)
> > >     #1 selinux_restorecon_common
> > > ./libselinux/src/selinux_restorecon.c:1197 (libselinux.so.1+0x2341c)
> > >     #2 selinux_restorecon_parallel
> > > ./libselinux/src/selinux_restorecon.c:1306 (libselinux.so.1+0x23985)
> > >     #3 process_glob ./policycoreutils/setfiles/restore.c:94 (setfiles=
+0x3ba4)
> > >     #4 main ./policycoreutils/setfiles/setfiles.c:463 (setfiles+0x362=
a)
> > >
> > > SUMMARY: ThreadSanitizer: data race ./libselinux/src/label_file.c:954
> > > in lookup_all
> > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >
> > Good catch, although this one seems to be pre-existing w.r.t. thread
> > safety of selinux_restorecon(3) (which seems to be implied by the
> > existence of struct spec::regex_lock). I spotted some existing usage
> > of GCC atomic builtins, so I'll try to fix it using those.
> >
> > > Also some thread joins seems to be missing:
> > >
> > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > WARNING: ThreadSanitizer: thread leak (pid=3D16933)
> > >   Thread T1 (tid=3D16939, finished) created by main thread at:
> > >     #0 pthread_create
> > > ../../../../src/libsanitizer/tsan/tsan_interceptors_posix.cpp:969
> > > (libtsan.so.0+0x5ad75)
> > >     #1 selinux_restorecon_common
> > > ./libselinux/src/selinux_restorecon.c:1197 (libselinux.so.1+0x2341c)
> > >     #2 selinux_restorecon_parallel
> > > ./libselinux/src/selinux_restorecon.c:1306 (libselinux.so.1+0x23985)
> > >     #3 process_glob ./policycoreutils/setfiles/restore.c:94 (setfiles=
+0x3ba4)
> > >     #4 main ./policycoreutils/setfiles/setfiles.c:463 (setfiles+0x362=
a)
> > >
> > >   And 2 more similar thread leaks.
> > >
> > > SUMMARY: ThreadSanitizer: thread leak
> > > ./libselinux/src/selinux_restorecon.c:1197 in
> > > selinux_restorecon_common
> > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >
> > Hm... My intention was to avoid the need for joins by synchronizing
> > via other means and just letting the threads exit on their own, but I
> > guess that doesn't fly with the sanitizer. Guess I'll have to allocate
> > an array for the handles and join the threads at the end after all...
>
> So I was able to get ThreadSanitizer to detect the race (by using only
> two threads and a very small number of files), but then the program
> just runs forever and I never get to see the thread leaks... Any hints
> on how you ran/compiled it to see the thread leaks? Or how long you
> had to wait for the program to finish? BTW, I only managed to get
> thread sanitizer to work with GCC. With CLang I always got some linker
> error...

Seems it was getting stuck because of the lack of joins. Once I
rewrote selinux_restorecon_common() to wait for the threads via
pthread_join(), setfiles built with -fsanitize=3Dthread exited quickly
and without warnings.

--=20
Ondrej Mosnacek
Software Engineer, Linux Security - SELinux kernel
Red Hat, Inc.

