Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADADAC433F5
	for <selinux@archiver.kernel.org>; Fri, 15 Oct 2021 12:38:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 925086108E
	for <selinux@archiver.kernel.org>; Fri, 15 Oct 2021 12:38:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233954AbhJOMkD (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 15 Oct 2021 08:40:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235674AbhJOMjv (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 15 Oct 2021 08:39:51 -0400
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F13BC061570
        for <selinux@vger.kernel.org>; Fri, 15 Oct 2021 05:37:45 -0700 (PDT)
Received: by mail-ot1-x32e.google.com with SMTP id w12-20020a056830410c00b0054e7ceecd88so12677642ott.2
        for <selinux@vger.kernel.org>; Fri, 15 Oct 2021 05:37:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sVGN4mfI+syzqYzn6HQs+Ibnu9v0Q+CmDeMN+Sxhruk=;
        b=B2ncrUC6OFBUDpOLzD54LW0VVXfIB+lU8q/B8JENTcpESpURtMGvsD6ypAQt2jmJ4p
         O5FJXNSN6t+VMAkxCi8KDX18zkbhF7b7WySguVN/I1Lai/FPXiSh/m1GBR+mXlbZGB+J
         3LvnF0TQ+7P871/2psw2p6ZzD/hHexLvdDZiKVeY4y0qBUMynDHbTwJDFp9GJzIgDvQT
         G9E0gwqTD+L7pCxJ/Yote2ZNsIGlSZom9dtgZbx4tHgfiISAuELTSIUHuKpSavsjq6qS
         2mx2M0orRe+BFKZ5HPclJDZq93eYG4p1C111DVdnjYwpsS90yCfmEl+uaDlMd6YX1qK0
         YRSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sVGN4mfI+syzqYzn6HQs+Ibnu9v0Q+CmDeMN+Sxhruk=;
        b=qMtkDzwU5jbqwk9fNI6dzA91WTM0ZEG1x2oYcLK1l0n7mN5FARUb7Slt6Uz4jHiuof
         38M8jBxTTo9AHgsTW0/baWvukDyM7xJp1JvD5YJWVX/SWToijPeeK4KqLXN1mk4Ydc/Q
         ZR4jQTwz8i24Mird/866TrdPQ80V1LyvlgaPHm++AEgpf31xRtobPVZtSfpukVs2/8ka
         nh1M2TUN2DFFmj1Xsl4bzMFrhFsIWAUMBWaK6PWjkKJnwPu3s+gX6L+5yWlY6b3dR/5x
         gFVEpywmBvo4CKj0Ht6vmkPi5JTvGlH9wZKRPE1cVQoYHvUi1Yt8uojumocXSTnQOorK
         tVjw==
X-Gm-Message-State: AOAM531alyDqd9RUn4O0BNcpHl8ERS93YhMb1dOI0sCZdWjaqwNvwhwF
        YwE41mMN3M7U7Ae1NcKIFksHqjkl3MX1F3epZoE6ddiTAFo=
X-Google-Smtp-Source: ABdhPJwqRtZSpQ6B46SMgRE/xA8ZTnnmV+YA0SAIimRrGj7oVYdVGngJrL+aSaQwv4Dac/FlmZNfrc5RLKW8yoca13o=
X-Received: by 2002:a05:6830:1dd8:: with SMTP id a24mr7988149otj.56.1634301464139;
 Fri, 15 Oct 2021 05:37:44 -0700 (PDT)
MIME-Version: 1.0
References: <20211014145319.798740-1-omosnace@redhat.com>
In-Reply-To: <20211014145319.798740-1-omosnace@redhat.com>
From:   =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Date:   Fri, 15 Oct 2021 14:37:32 +0200
Message-ID: <CAJ2a_DdKTg8qoFV6HG71d_3Ufbpn6=xiYJ-M8UDcUrkqVEm80g@mail.gmail.com>
Subject: Re: [PATCH userspace v2 0/6] Parallel setfiles/restorecon
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, 14 Oct 2021 at 16:53, Ondrej Mosnacek <omosnace@redhat.com> wrote:
>
> This series adds basic support for parallel relabeling to the libselinux
> API and the setfiles/restorecon CLI tools. It turns out that doing the
> relabeling in parallel can significantly reduce the time even with a
> relatively simple approach.
>
> The first patch is a small cleanup that was found along the way and can
> be applied independently. Patches 2-4 are small incremental changes that
> make the internal selinux_restorecon functions more thread-safe (I kept
> them separate for ease of of review, but maybe they should be rather
> folded into the netx patch...). Patch 5 then completes the parallel
> relabeling implementation at libselinux level and adds a new function
> to the API that allows to make use of it. Finally, patch 6 adds parallel
> relabeling support to he setfiles/restorecon tools.
>
> The relevant man pages are also updated to reflect the new
> functionality.
>
> The patch descriptions contain more details, namely the last patch has
> also some benchmark numbers.
>
> Changes v1->v2:
> - make selinux_log() synchronized instead of introducing selinux_log_sync()
> - fix -Wcomma warning
> - update the swig files as well
> - bump new symbol version to LIBSELINUX_3.3 (this may need further update
>   depending on when this gets merged)
>
> Ondrej Mosnacek (6):
>   selinux_restorecon: simplify fl_head allocation by using calloc()
>   selinux_restorecon: protect file_spec list with a mutex
>   libselinux: make selinux_log() thread-safe
>   selinux_restorecon: add a global mutex to synchronize progress output
>   selinux_restorecon: introduce selinux_restorecon_parallel(3)
>   setfiles/restorecon: support parallel relabeling
>
>  libselinux/include/selinux/restorecon.h       |  14 +
>  libselinux/man/man3/selinux_restorecon.3      |  29 ++
>  .../man/man3/selinux_restorecon_parallel.3    |   1 +
>  libselinux/src/callbacks.c                    |   8 +-
>  libselinux/src/callbacks.h                    |  13 +-
>  libselinux/src/libselinux.map                 |   5 +
>  libselinux/src/selinux_internal.h             |  14 +
>  libselinux/src/selinux_restorecon.c           | 466 ++++++++++++------
>  libselinux/src/selinuxswig_python.i           |   6 +-
>  libselinux/src/selinuxswig_python_exception.i |   8 +
>  policycoreutils/setfiles/Makefile             |   2 +-
>  policycoreutils/setfiles/restore.c            |   7 +-
>  policycoreutils/setfiles/restore.h            |   2 +-
>  policycoreutils/setfiles/restorecon.8         |   9 +
>  policycoreutils/setfiles/setfiles.8           |   9 +
>  policycoreutils/setfiles/setfiles.c           |  28 +-
>  16 files changed, 444 insertions(+), 177 deletions(-)
>  create mode 100644 libselinux/man/man3/selinux_restorecon_parallel.3
>
> --
> 2.31.1
>


Running under ThreadSanitizer shows multiple instances of the following issue:

==================
WARNING: ThreadSanitizer: data race (pid=16933)
  Read of size 4 at 0x7f8790d636f4 by thread T2:
    #0 lookup_all ./libselinux/src/label_file.c:954 (libselinux.so.1+0x14d1b)
    #1 lookup_common ./libselinux/src/label_file.c:997 (libselinux.so.1+0x14f62)
    #2 lookup ./libselinux/src/label_file.c:1095 (libselinux.so.1+0x14fff)
    #3 selabel_lookup_common ./libselinux/src/label.c:167
(libselinux.so.1+0x12291)
    #4 selabel_lookup_raw ./libselinux/src/label.c:256 (libselinux.so.1+0x126ca)
    #5 restorecon_sb ./libselinux/src/selinux_restorecon.c:638
(libselinux.so.1+0x20c76)
    #6 selinux_restorecon_thread
./libselinux/src/selinux_restorecon.c:947 (libselinux.so.1+0x21e99)

  Previous write of size 4 at 0x7f8790d636f4 by thread T1:
    #0 lookup_all ./libselinux/src/label_file.c:954 (libselinux.so.1+0x14d29)
    #1 lookup_common ./libselinux/src/label_file.c:997 (libselinux.so.1+0x14f62)
    #2 lookup ./libselinux/src/label_file.c:1095 (libselinux.so.1+0x14fff)
    #3 selabel_lookup_common ./libselinux/src/label.c:167
(libselinux.so.1+0x12291)
    #4 selabel_lookup_raw ./libselinux/src/label.c:256 (libselinux.so.1+0x126ca)
    #5 restorecon_sb ./libselinux/src/selinux_restorecon.c:638
(libselinux.so.1+0x20c76)
    #6 selinux_restorecon_thread
./libselinux/src/selinux_restorecon.c:947 (libselinux.so.1+0x21e99)

  Location is heap block of size 267120 at 0x7f8790d45000 allocated by
main thread:
    #0 malloc ../../../../src/libsanitizer/tsan/tsan_interceptors_posix.cpp:655
(libtsan.so.0+0x31799)
    #1 sort_specs ./libselinux/src/label_file.h:207 (libselinux.so.1+0x17bd9)
    #2 init ./libselinux/src/label_file.c:795 (libselinux.so.1+0x17bd9)
    #3 selabel_file_init ./libselinux/src/label_file.c:1293
(libselinux.so.1+0x1835b)
    #4 selabel_open ./libselinux/src/label.c:228 (libselinux.so.1+0x125d8)
    #5 restore_init ./policycoreutils/setfiles/restore.c:30 (setfiles+0x3886)
    #6 main ./policycoreutils/setfiles/setfiles.c:434 (setfiles+0x344e)

  Thread T2 (tid=16940, running) created by main thread at:
    #0 pthread_create
../../../../src/libsanitizer/tsan/tsan_interceptors_posix.cpp:969
(libtsan.so.0+0x5ad75)
    #1 selinux_restorecon_common
./libselinux/src/selinux_restorecon.c:1197 (libselinux.so.1+0x2341c)
    #2 selinux_restorecon_parallel
./libselinux/src/selinux_restorecon.c:1306 (libselinux.so.1+0x23985)
    #3 process_glob ./policycoreutils/setfiles/restore.c:94 (setfiles+0x3ba4)
    #4 main ./policycoreutils/setfiles/setfiles.c:463 (setfiles+0x362a)

  Thread T1 (tid=16939, running) created by main thread at:
    #0 pthread_create
../../../../src/libsanitizer/tsan/tsan_interceptors_posix.cpp:969
(libtsan.so.0+0x5ad75)
    #1 selinux_restorecon_common
./libselinux/src/selinux_restorecon.c:1197 (libselinux.so.1+0x2341c)
    #2 selinux_restorecon_parallel
./libselinux/src/selinux_restorecon.c:1306 (libselinux.so.1+0x23985)
    #3 process_glob ./policycoreutils/setfiles/restore.c:94 (setfiles+0x3ba4)
    #4 main ./policycoreutils/setfiles/setfiles.c:463 (setfiles+0x362a)

SUMMARY: ThreadSanitizer: data race ./libselinux/src/label_file.c:954
in lookup_all
==================

Also some thread joins seems to be missing:

==================
WARNING: ThreadSanitizer: thread leak (pid=16933)
  Thread T1 (tid=16939, finished) created by main thread at:
    #0 pthread_create
../../../../src/libsanitizer/tsan/tsan_interceptors_posix.cpp:969
(libtsan.so.0+0x5ad75)
    #1 selinux_restorecon_common
./libselinux/src/selinux_restorecon.c:1197 (libselinux.so.1+0x2341c)
    #2 selinux_restorecon_parallel
./libselinux/src/selinux_restorecon.c:1306 (libselinux.so.1+0x23985)
    #3 process_glob ./policycoreutils/setfiles/restore.c:94 (setfiles+0x3ba4)
    #4 main ./policycoreutils/setfiles/setfiles.c:463 (setfiles+0x362a)

  And 2 more similar thread leaks.

SUMMARY: ThreadSanitizer: thread leak
./libselinux/src/selinux_restorecon.c:1197 in
selinux_restorecon_common
==================


Performance on 4 cores:

real    0m27.323s
user    0m20.824s
sys     0m4.029s

vs

real    0m12.462s
user    0m31.220s
sys     0m4.316s
