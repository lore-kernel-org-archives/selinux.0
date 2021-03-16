Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B45EBC433DB
	for <selinux@archiver.kernel.org>; Tue, 16 Mar 2021 13:40:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 825DE64DD8
	for <selinux@archiver.kernel.org>; Tue, 16 Mar 2021 13:40:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229841AbhCPNkU (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 16 Mar 2021 09:40:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231501AbhCPNjs (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 16 Mar 2021 09:39:48 -0400
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A744DC06174A
        for <selinux@vger.kernel.org>; Tue, 16 Mar 2021 06:39:47 -0700 (PDT)
Received: by mail-oi1-x22d.google.com with SMTP id u6so30791942oic.2
        for <selinux@vger.kernel.org>; Tue, 16 Mar 2021 06:39:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LGiDekmRiZApcD5efuQRaqFtviQxBaF2/YHrPvMlV0U=;
        b=PWJEE4KBlQ5pxFFQoWjhml21ZXhmYTF+crtyKZ5FVle6z0bKCaP+5/OeJHdkrtl3Yk
         x0m7riYX8aFqC4XJUVJeiCV069Nb1e72YIaxZpZufSvY/YkjhgE/+vkqLAmSU6DxviHQ
         GhIawkydiXeW+U7WnvUdAQ5HTiK39N4VfotaDlrMDJ1RG7isO7znx5Ualcc9kns7ITtY
         W60tcWyHeO4RyB1wXQtu60T21N6GQ05iWOomhfKstbxxLh0cYrnsSHppbqqLTZ57yH83
         KJRcWnOrHzzhAm/aHz0wZXCAA8BsUBanTGP252X0hNX4VySA+HWQc5lv4ZPVmH7IcW4K
         Q4vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LGiDekmRiZApcD5efuQRaqFtviQxBaF2/YHrPvMlV0U=;
        b=NRpBBXv0H/EkEjobuRFnxdQviRzrCk0wHqBWarKrMweDByx0laFosDb4TjZsEhxqlv
         KCmX+BQPWJ6n/7u/kVwquqepitbzy+/cCIoCG8p9PcuPjdN62kN46dk2TwQZMxo3UYYA
         KwJoKqur4Sy8m/KOnfS5X0jXkcPIKP1aRmouGp6J1zubrH06h4x2umUblIU3vGMS9+xG
         sBLNgU4SjPeak1WdgYIhedHYEqKm4EALTQpCzDWyS1EAlGJ5Y3Lmk7q3E95bDg3rP/dn
         56VEfTuSYl9EAMWGq4DsXHPocRS6TViv1WLpviUigIRoeAFUm9fbqEOxIEonDeAnPYhU
         h5hA==
X-Gm-Message-State: AOAM530xGqUaVFYBCLl8PyffmUr281AiuBCNyaN5tqrzIvM2LrZNhETi
        x7m3LJYutlBaQ6BFhZ2sTds93TbmySVRlMJybQ88eSDh
X-Google-Smtp-Source: ABdhPJxuYCDTpNXJo52ajV2y3JugZmXHbmni72CHjJFNrFjnpXUY6USA4umlaLO0sX+oo0OctDmGhXVnoJE80/xBmM8=
X-Received: by 2002:a05:6808:14d5:: with SMTP id f21mr3385796oiw.16.1615901987108;
 Tue, 16 Mar 2021 06:39:47 -0700 (PDT)
MIME-Version: 1.0
References: <CAJfZ7==bgZOKifb0Va65VPZjNNLiWcx=zS=G4uQc_nzpuTvJkQ@mail.gmail.com>
In-Reply-To: <CAJfZ7==bgZOKifb0Va65VPZjNNLiWcx=zS=G4uQc_nzpuTvJkQ@mail.gmail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Tue, 16 Mar 2021 09:39:36 -0400
Message-ID: <CAP+JOzS2tsA1vg+8y3cgWmdSY_PLhWMvZBSO=LEsejenZD+x_Q@mail.gmail.com>
Subject: Re: libsepol/cil: type confusion between macro and optional leads to
 heap-buffer-overflow in cil_copy_macro
To:     Nicolas Iooss <nicolas.iooss@m4x.org>
Cc:     SElinux list <selinux@vger.kernel.org>,
        Evgeny Vereshchagin <evvers@ya.ru>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Mar 15, 2021 at 6:13 PM Nicolas Iooss <nicolas.iooss@m4x.org> wrote:
>
> Hello,
>
> A few months ago, OSS-Fuzz found a crash in the CIL compiler, which
> got reported as
> https://bugs.chromium.org/p/oss-fuzz/issues/detail?id=28525. It was
> quite complex to minimize and understand, but thanks to the work of
> Evgeny Vereshchagin
> (https://github.com/google/oss-fuzz/issues/5388#issuecomment-799402426),
> the reproducer was minimized to the following CIL policy which
> triggers a heap-buffer-overflow detected by clang's address sanitizer:
>
> (macro MACRO1 ()
>     (optional OPT
>         (allow TYPE TYPE (CLASS (PERM)))
>     )
> )
>
> (in MACRO1
>     (macro OPT ())
> )
>
> It is possible to reproduce the crash in an Arch Linux container
> (launched for example with "podman run  --rm -ti
> docker.io/library/archlinux") by running the following commands:
>
> pacman -Syu git make clang llvm python flex bison xmlto docbook-xml docbook-xsl
> git clone https://github.com/SELinuxProject/selinux
> cd selinux
> ln -s $(pwd)/libsepol/cil/include/cil libsepol/include/sepol/cil
> make -C libsepol/src CC=clang \
>     CFLAGS='-O2 -g -ggdb3 -fsanitize=address' \
>     LDFLAGS='-g -ggdb3 -fsanitize=address' libsepol.a
> make -C secilc CC=clang \
>     CFLAGS='-O2 -g -ggdb3 -fsanitize=address -I../libsepol/include' \
>     LDFLAGS='-g -ggdb3 -fsanitize=address -L../libsepol/src'
> ./secilc/secilc crash.cil
>
> This leads to the following Address Sanitizer report:
>
> =================================================================
> ==519==ERROR: AddressSanitizer: heap-buffer-overflow on address
> 0x6040000001a0 at pc 0x5619403dcf51 bp 0x7ffdce0395d0 sp
> 0x7ffdce0395c8
> READ of size 8 at 0x6040000001a0 thread T0
>     #0 0x5619403dcf50 in cil_copy_macro
> /selinux/libsepol/src/../cil/src/cil_copy_ast.c:1529:35
>     #1 0x5619403dedc9 in __cil_copy_node_helper
> /selinux/libsepol/src/../cil/src/cil_copy_ast.c:2055:7
>     #2 0x561940425d13 in cil_tree_walk_core
> /selinux/libsepol/src/../cil/src/cil_tree.c:272:9
>     #3 0x561940425fc5 in cil_tree_walk
> /selinux/libsepol/src/../cil/src/cil_tree.c:316:7
>     #4 0x5619403dca2a in cil_copy_ast
> /selinux/libsepol/src/../cil/src/cil_copy_ast.c:2160:7
>     #5 0x561940417ae4 in cil_resolve_in
> /selinux/libsepol/src/../cil/src/cil_resolve_ast.c:2499:7
>     #6 0x561940417ed4 in cil_resolve_in_list
> /selinux/libsepol/src/../cil/src/cil_resolve_ast.c:2545:10
>     #7 0x561940420ed0 in cil_resolve_ast
> /selinux/libsepol/src/../cil/src/cil_resolve_ast.c:4025:9
>     #8 0x561940383e08 in cil_compile
> /selinux/libsepol/src/../cil/src/cil.c:550:7
>     #9 0x56194036bcee in main /selinux/secilc/secilc.c:291:7
>     #10 0x7f5db9156b24 in __libc_start_main (/usr/lib/libc.so.6+0x27b24)
>     #11 0x56194028f28d in _start (/selinux/secilc/secilc+0x5828d)
>
> Address 0x6040000001a0 is a wild pointer.
> SUMMARY: AddressSanitizer: heap-buffer-overflow
> /selinux/libsepol/src/../cil/src/cil_copy_ast.c:1529:35 in
> cil_copy_macro
> Shadow bytes around the buggy address:
>   0x0c087fff7fe0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>   0x0c087fff7ff0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>   0x0c087fff8000: fa fa 00 00 00 00 00 00 fa fa 00 00 00 00 00 fa
>   0x0c087fff8010: fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa
>   0x0c087fff8020: fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa
> =>0x0c087fff8030: fa fa fa fa[fa]fa fa fa fa fa fa fa fa fa fa fa
>   0x0c087fff8040: fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa
>   0x0c087fff8050: fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa
>   0x0c087fff8060: fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa
>   0x0c087fff8070: fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa
>   0x0c087fff8080: fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa
> Shadow byte legend (one shadow byte represents 8 application bytes):
>   Addressable:           00
>   Partially addressable: 01 02 03 04 05 06 07
>   Heap left redzone:       fa
>   Freed heap region:       fd
>   Stack left redzone:      f1
>   Stack mid redzone:       f2
>   Stack right redzone:     f3
>   Stack after return:      f5
>   Stack use after scope:   f8
>   Global redzone:          f9
>   Global init order:       f6
>   Poisoned by user:        f7
>   Container overflow:      fc
>   Array cookie:            ac
>   Intra object redzone:    bb
>   ASan internal:           fe
>   Left alloca redzone:     ca
>   Right alloca redzone:    cb
>   Shadow gap:              cc
> ==519==ABORTING
>
> It seems that the CIL compiler does not detect that "macro OPT"
> conflicts with "optional OPT" when resolving "in MACRO1". I am not
> familiar with this part of the code but it seems that this issue could
> be fixed by adding a check at the right place.
>
> If someone has some time to take a look in the next days, it would be
> very appreciated :) Otherwise I will spend some time next week-end to
> debug more the CIL compiler.
>

I will take a look at this. The problem is probably in cil_copy_ast.

Thanks for the report,
Jim

> Thanks,
> Nicolas
>
