Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15684C433F5
	for <selinux@archiver.kernel.org>; Tue, 19 Oct 2021 15:34:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ED240610A1
	for <selinux@archiver.kernel.org>; Tue, 19 Oct 2021 15:34:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230127AbhJSPgc (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 19 Oct 2021 11:36:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229789AbhJSPgc (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 19 Oct 2021 11:36:32 -0400
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BC99C06161C
        for <selinux@vger.kernel.org>; Tue, 19 Oct 2021 08:34:19 -0700 (PDT)
Received: by mail-ot1-x329.google.com with SMTP id x27-20020a9d459b000000b0055303520cc4so4508625ote.13
        for <selinux@vger.kernel.org>; Tue, 19 Oct 2021 08:34:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=x9/j+syPkdIOjuqay/fxm4lSQMA12AzHEhkon3Vh6F4=;
        b=mCXScg+8fmA/fT04DNQGOiHWt/blkqPp91GsFAgzH4w0A98EPjaqkY8eWlLazs8MlO
         4jgrpnzcqzSKFye7GhW395SS0E3D3U4Uz0R3iJ0TpLtMi1CyF214L8R/3tsFcAGDSjy0
         WyTlrfDC2hE1E3HmzCQLyMhLSWdVkhKGFYw2xSCR6tPeOvMa+JWhZD6wjK6O68prQBsB
         LhFcPjZOJFeI+N7bLdejBdjCFeJn3elBrQs+q+Z2wMG0PHoJcnV4yD+ltn7yUaj3l4/3
         EGHAnhNVmCOza6kjY5u+FL3vCH50foJSc5ReAuntqHpUPFDQmQDCixwA8VWtLxlgANrz
         5eIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=x9/j+syPkdIOjuqay/fxm4lSQMA12AzHEhkon3Vh6F4=;
        b=LSJzHMPk6TPByCHevy7sykWHvkn8CK+HB8Az1zio/xi9oV/FupSgw/6pIYAFQDTtH4
         NvhhCvF3wkppbV6crlKpCpQbHWwHLbH+2bgSPwrBfMs+eLrRqmTG3HaVzs1eloB0ihEA
         y5tJGb+6NZ857omcmzcc7I4v8DLHhCaqW/ItxZtS/TVbvqRIKLdinUwR/2ITo5TfTVqU
         M7MrCYDGjWDl5d8ML2PuO9PGpGQEcrwDs5eutOgkUmgLKfN8bR/kcei8soLAaFO6fy62
         jR1h0VPV86KVHDvpZNvTSq+QedXRoF6S8lqQbdhQCtODYxeRBdKZXhK+3q08Menfy7PY
         ah9Q==
X-Gm-Message-State: AOAM530YFwLslFo+8HFVToebaPhFoPsqGZWczW5L2uOZrN0t+frou/g4
        H1wzN4Y9WMcIm5oatmi30OJ/334RtSkYoBW9ckY=
X-Google-Smtp-Source: ABdhPJzgw6bdcTPWBJGq4d4gepM5krHezw4yDnj645Jj7m3eSxq2XZIHB23GuaqrL7HX+5WLcYGFXB2xqtEjKF9mjDA=
X-Received: by 2002:a05:6830:1c26:: with SMTP id f6mr5745909ote.28.1634657658247;
 Tue, 19 Oct 2021 08:34:18 -0700 (PDT)
MIME-Version: 1.0
References: <20211019150122.459722-1-omosnace@redhat.com>
In-Reply-To: <20211019150122.459722-1-omosnace@redhat.com>
From:   =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Date:   Tue, 19 Oct 2021 17:34:07 +0200
Message-ID: <CAJ2a_DeU=wo10JQ=98BHh3fNGKNY3d+SYfWoAzYMqeaQOU+OLQ@mail.gmail.com>
Subject: Re: [PATCH userspace v3 0/7] Parallel setfiles/restorecon
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, 19 Oct 2021 at 17:01, Ondrej Mosnacek <omosnace@redhat.com> wrote:
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

There seems to be another data race, which however does not occur every time:


==================
WARNING: ThreadSanitizer: data race (pid=4189)
  Read of size 8 at 0x7f72252e5908 by thread T3:
    #0 is_context_customizable
/home/debianuser/workspace/selinux/selinux/libselinux/src/is_customizable_type.c:70:7
(libselinux.so.1+0x12d86)
    #1 restorecon_sb
/home/debianuser/workspace/selinux/selinux/libselinux/src/selinux_restorecon.c:696:10
(libselinux.so.1+0x24b41)
    #2 selinux_restorecon_thread
/home/debianuser/workspace/selinux/selinux/libselinux/src/selinux_restorecon.c:943:12
(libselinux.so.1+0x25695)

  Previous write of size 8 at 0x7f72252e5908 by thread T1:
    #0 get_customizable_type_list
/home/debianuser/workspace/selinux/selinux/libselinux/src/is_customizable_type.c:58:11
(libselinux.so.1+0x13027)
    #1 is_context_customizable
/home/debianuser/workspace/selinux/selinux/libselinux/src/is_customizable_type.c:71:7
(libselinux.so.1+0x13027)
    #2 restorecon_sb
/home/debianuser/workspace/selinux/selinux/libselinux/src/selinux_restorecon.c:696:10
(libselinux.so.1+0x24b41)
    #3 selinux_restorecon_thread
/home/debianuser/workspace/selinux/selinux/libselinux/src/selinux_restorecon.c:943:12
(libselinux.so.1+0x25695)

  Location is global 'customizable_list' of size 8 at 0x7f72252e5908
(libselinux.so.1+0x000000036908)

  Thread T3 (tid=4197, running) created by main thread at:
    #0 pthread_create <null> (setfiles+0x44c6ed)
    #1 selinux_restorecon_common
/home/debianuser/workspace/selinux/selinux/libselinux/src/selinux_restorecon.c:1193:8
(libselinux.so.1+0x22ba6)
    #2 selinux_restorecon_parallel
/home/debianuser/workspace/selinux/selinux/libselinux/src/selinux_restorecon.c:1310:9
(libselinux.so.1+0x22da2)
    #3 process_glob
/home/debianuser/workspace/selinux/selinux/policycoreutils/setfiles/restore.c:94:8
(setfiles+0x4c13b7)
    #4 main /home/debianuser/workspace/selinux/selinux/policycoreutils/setfiles/setfiles.c:463:14
(setfiles+0x4c0938)

  Thread T1 (tid=4195, running) created by main thread at:
    #0 pthread_create <null> (setfiles+0x44c6ed)
    #1 selinux_restorecon_common
/home/debianuser/workspace/selinux/selinux/libselinux/src/selinux_restorecon.c:1193:8
(libselinux.so.1+0x22ba6)
    #2 selinux_restorecon_parallel
/home/debianuser/workspace/selinux/selinux/libselinux/src/selinux_restorecon.c:1310:9
(libselinux.so.1+0x22da2)
    #3 process_glob
/home/debianuser/workspace/selinux/selinux/policycoreutils/setfiles/restore.c:94:8
(setfiles+0x4c13b7)
    #4 main /home/debianuser/workspace/selinux/selinux/policycoreutils/setfiles/setfiles.c:463:14
(setfiles+0x4c0938)

SUMMARY: ThreadSanitizer: data race
/home/debianuser/workspace/selinux/selinux/libselinux/src/is_customizable_type.c:70:7
in is_context_customizable
==================
==================
WARNING: ThreadSanitizer: data race (pid=4189)
  Read of size 8 at 0x7b080000c000 by thread T3:
    #0 is_context_customizable
/home/debianuser/workspace/selinux/selinux/libselinux/src/is_customizable_type.c:85:14
(libselinux.so.1+0x12ddc)
    #1 restorecon_sb
/home/debianuser/workspace/selinux/selinux/libselinux/src/selinux_restorecon.c:696:10
(libselinux.so.1+0x24b41)
    #2 selinux_restorecon_thread
/home/debianuser/workspace/selinux/selinux/libselinux/src/selinux_restorecon.c:943:12
(libselinux.so.1+0x25695)

  Previous write of size 8 at 0x7b080000c000 by thread T1:
    [failed to restore the stack]

  Location is heap block of size 32 at 0x7b080000c000 allocated by thread T1:
    #0 calloc <null> (setfiles+0x44b249)
    #1 get_customizable_type_list
/home/debianuser/workspace/selinux/selinux/libselinux/src/is_customizable_type.c:34:17
(libselinux.so.1+0x12ed7)
    #2 is_context_customizable
/home/debianuser/workspace/selinux/selinux/libselinux/src/is_customizable_type.c:71:7
(libselinux.so.1+0x12ed7)
    #3 restorecon_sb
/home/debianuser/workspace/selinux/selinux/libselinux/src/selinux_restorecon.c:696:10
(libselinux.so.1+0x24b41)
    #4 selinux_restorecon_thread
/home/debianuser/workspace/selinux/selinux/libselinux/src/selinux_restorecon.c:943:12
(libselinux.so.1+0x25695)

  Thread T3 (tid=4197, running) created by main thread at:
    #0 pthread_create <null> (setfiles+0x44c6ed)
    #1 selinux_restorecon_common
/home/debianuser/workspace/selinux/selinux/libselinux/src/selinux_restorecon.c:1193:8
(libselinux.so.1+0x22ba6)
    #2 selinux_restorecon_parallel
/home/debianuser/workspace/selinux/selinux/libselinux/src/selinux_restorecon.c:1310:9
(libselinux.so.1+0x22da2)
    #3 process_glob
/home/debianuser/workspace/selinux/selinux/policycoreutils/setfiles/restore.c:94:8
(setfiles+0x4c13b7)
    #4 main /home/debianuser/workspace/selinux/selinux/policycoreutils/setfiles/setfiles.c:463:14
(setfiles+0x4c0938)

  Thread T1 (tid=4195, running) created by main thread at:
    #0 pthread_create <null> (setfiles+0x44c6ed)
    #1 selinux_restorecon_common
/home/debianuser/workspace/selinux/selinux/libselinux/src/selinux_restorecon.c:1193:8
(libselinux.so.1+0x22ba6)
    #2 selinux_restorecon_parallel
/home/debianuser/workspace/selinux/selinux/libselinux/src/selinux_restorecon.c:1310:9
(libselinux.so.1+0x22da2)
    #3 process_glob
/home/debianuser/workspace/selinux/selinux/policycoreutils/setfiles/restore.c:94:8
(setfiles+0x4c13b7)
    #4 main /home/debianuser/workspace/selinux/selinux/policycoreutils/setfiles/setfiles.c:463:14
(setfiles+0x4c0938)

SUMMARY: ThreadSanitizer: data race
/home/debianuser/workspace/selinux/selinux/libselinux/src/is_customizable_type.c:85:14
in is_context_customizable
==================
==================
WARNING: ThreadSanitizer: data race (pid=4189)
  Read of size 1 at 0x7b080000c040 by thread T3:
    #0 strcmp <null> (setfiles+0x4545d4)
    #1 is_context_customizable
/home/debianuser/workspace/selinux/selinux/libselinux/src/is_customizable_type.c:86:7
(libselinux.so.1+0x12df7)
    #2 restorecon_sb
/home/debianuser/workspace/selinux/selinux/libselinux/src/selinux_restorecon.c:696:10
(libselinux.so.1+0x24b41)
    #3 selinux_restorecon_thread
/home/debianuser/workspace/selinux/selinux/libselinux/src/selinux_restorecon.c:943:12
(libselinux.so.1+0x25695)

  Previous write of size 8 at 0x7b080000c040 by thread T1:
    [failed to restore the stack]

  Location is heap block of size 17 at 0x7b080000c040 allocated by thread T1:
    #0 malloc <null> (setfiles+0x44b05d)
    #1 strdup <null> (libc.so.6+0x8e4aa)
    #2 get_customizable_type_list
/home/debianuser/workspace/selinux/selinux/libselinux/src/is_customizable_type.c:41:15
(libselinux.so.1+0x12f45)
    #3 is_context_customizable
/home/debianuser/workspace/selinux/selinux/libselinux/src/is_customizable_type.c:71:7
(libselinux.so.1+0x12f45)
    #4 restorecon_sb
/home/debianuser/workspace/selinux/selinux/libselinux/src/selinux_restorecon.c:696:10
(libselinux.so.1+0x24b41)
    #5 selinux_restorecon_thread
/home/debianuser/workspace/selinux/selinux/libselinux/src/selinux_restorecon.c:943:12
(libselinux.so.1+0x25695)

  Thread T3 (tid=4197, running) created by main thread at:
    #0 pthread_create <null> (setfiles+0x44c6ed)
    #1 selinux_restorecon_common
/home/debianuser/workspace/selinux/selinux/libselinux/src/selinux_restorecon.c:1193:8
(libselinux.so.1+0x22ba6)
    #2 selinux_restorecon_parallel
/home/debianuser/workspace/selinux/selinux/libselinux/src/selinux_restorecon.c:1310:9
(libselinux.so.1+0x22da2)
    #3 process_glob
/home/debianuser/workspace/selinux/selinux/policycoreutils/setfiles/restore.c:94:8
(setfiles+0x4c13b7)
    #4 main /home/debianuser/workspace/selinux/selinux/policycoreutils/setfiles/setfiles.c:463:14
(setfiles+0x4c0938)

  Thread T1 (tid=4195, running) created by main thread at:
    #0 pthread_create <null> (setfiles+0x44c6ed)
    #1 selinux_restorecon_common
/home/debianuser/workspace/selinux/selinux/libselinux/src/selinux_restorecon.c:1193:8
(libselinux.so.1+0x22ba6)
    #2 selinux_restorecon_parallel
/home/debianuser/workspace/selinux/selinux/libselinux/src/selinux_restorecon.c:1310:9
(libselinux.so.1+0x22da2)
    #3 process_glob
/home/debianuser/workspace/selinux/selinux/policycoreutils/setfiles/restore.c:94:8
(setfiles+0x4c13b7)
    #4 main /home/debianuser/workspace/selinux/selinux/policycoreutils/setfiles/setfiles.c:463:14
(setfiles+0x4c0938)

SUMMARY: ThreadSanitizer: data race
(/home/debianuser/destdir/sbin/setfiles+0x4545d4) in strcmp
==================
==================
WARNING: ThreadSanitizer: data race (pid=4189)
  Read of size 8 at 0x7b080000c008 by thread T3:
    #0 is_context_customizable
/home/debianuser/workspace/selinux/selinux/libselinux/src/is_customizable_type.c:85:14
(libselinux.so.1+0x12e07)
    #1 restorecon_sb
/home/debianuser/workspace/selinux/selinux/libselinux/src/selinux_restorecon.c:696:10
(libselinux.so.1+0x24b41)
    #2 selinux_restorecon_thread
/home/debianuser/workspace/selinux/selinux/libselinux/src/selinux_restorecon.c:943:12
(libselinux.so.1+0x25695)

  Previous write of size 8 at 0x7b080000c008 by thread T1:
    [failed to restore the stack]

  Location is heap block of size 32 at 0x7b080000c000 allocated by thread T1:
    #0 calloc <null> (setfiles+0x44b249)
    #1 get_customizable_type_list
/home/debianuser/workspace/selinux/selinux/libselinux/src/is_customizable_type.c:34:17
(libselinux.so.1+0x12ed7)
    #2 is_context_customizable
/home/debianuser/workspace/selinux/selinux/libselinux/src/is_customizable_type.c:71:7
(libselinux.so.1+0x12ed7)
    #3 restorecon_sb
/home/debianuser/workspace/selinux/selinux/libselinux/src/selinux_restorecon.c:696:10
(libselinux.so.1+0x24b41)
    #4 selinux_restorecon_thread
/home/debianuser/workspace/selinux/selinux/libselinux/src/selinux_restorecon.c:943:12
(libselinux.so.1+0x25695)

  Thread T3 (tid=4197, running) created by main thread at:
    #0 pthread_create <null> (setfiles+0x44c6ed)
    #1 selinux_restorecon_common
/home/debianuser/workspace/selinux/selinux/libselinux/src/selinux_restorecon.c:1193:8
(libselinux.so.1+0x22ba6)
    #2 selinux_restorecon_parallel
/home/debianuser/workspace/selinux/selinux/libselinux/src/selinux_restorecon.c:1310:9
(libselinux.so.1+0x22da2)
    #3 process_glob
/home/debianuser/workspace/selinux/selinux/policycoreutils/setfiles/restore.c:94:8
(setfiles+0x4c13b7)
    #4 main /home/debianuser/workspace/selinux/selinux/policycoreutils/setfiles/setfiles.c:463:14
(setfiles+0x4c0938)

  Thread T1 (tid=4195, running) created by main thread at:
    #0 pthread_create <null> (setfiles+0x44c6ed)
    #1 selinux_restorecon_common
/home/debianuser/workspace/selinux/selinux/libselinux/src/selinux_restorecon.c:1193:8
(libselinux.so.1+0x22ba6)
    #2 selinux_restorecon_parallel
/home/debianuser/workspace/selinux/selinux/libselinux/src/selinux_restorecon.c:1310:9
(libselinux.so.1+0x22da2)
    #3 process_glob
/home/debianuser/workspace/selinux/selinux/policycoreutils/setfiles/restore.c:94:8
(setfiles+0x4c13b7)
    #4 main /home/debianuser/workspace/selinux/selinux/policycoreutils/setfiles/setfiles.c:463:14
(setfiles+0x4c0938)

SUMMARY: ThreadSanitizer: data race
/home/debianuser/workspace/selinux/selinux/libselinux/src/is_customizable_type.c:85:14
in is_context_customizable
==================


> Changes v2->v3:
> - add a patch to fix pre-exiting data race in label_file
> - wait for threads to complete using pthread_join(3) to prevent thread leaks
>
> Changes v1->v2:
> - make selinux_log() synchronized instead of introducing selinux_log_sync()
> - fix -Wcomma warning
> - update the swig files as well
> - bump new symbol version to LIBSELINUX_3.3 (this may need further update
>   depending on when this gets merged)
>
> Ondrej Mosnacek (7):
>   label_file: fix a data race
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
>  libselinux/src/label_file.c                   |  15 +-
>  libselinux/src/label_file.h                   |   2 +-
>  libselinux/src/libselinux.map                 |   5 +
>  libselinux/src/selinux_internal.h             |  16 +
>  libselinux/src/selinux_restorecon.c           | 458 ++++++++++++------
>  libselinux/src/selinuxswig_python.i           |   6 +-
>  libselinux/src/selinuxswig_python_exception.i |   8 +
>  policycoreutils/setfiles/Makefile             |   2 +-
>  policycoreutils/setfiles/restore.c            |   7 +-
>  policycoreutils/setfiles/restore.h            |   2 +-
>  policycoreutils/setfiles/restorecon.8         |   9 +
>  policycoreutils/setfiles/setfiles.8           |   9 +
>  policycoreutils/setfiles/setfiles.c           |  28 +-
>  18 files changed, 458 insertions(+), 174 deletions(-)
>  create mode 100644 libselinux/man/man3/selinux_restorecon_parallel.3
>
> --
> 2.31.1
>
