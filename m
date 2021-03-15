Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4A65C433DB
	for <selinux@archiver.kernel.org>; Mon, 15 Mar 2021 22:11:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9087A64F58
	for <selinux@archiver.kernel.org>; Mon, 15 Mar 2021 22:11:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229948AbhCOWKl (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 15 Mar 2021 18:10:41 -0400
Received: from mx1.polytechnique.org ([129.104.30.34]:39687 "EHLO
        mx1.polytechnique.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232515AbhCOWKS (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 15 Mar 2021 18:10:18 -0400
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by ssl.polytechnique.org (Postfix) with ESMTPSA id 90B825605E5
        for <selinux@vger.kernel.org>; Mon, 15 Mar 2021 23:10:15 +0100 (CET)
Received: by mail-pf1-f180.google.com with SMTP id c17so3884176pfv.12
        for <selinux@vger.kernel.org>; Mon, 15 Mar 2021 15:10:15 -0700 (PDT)
X-Gm-Message-State: AOAM533wqRCxeDSOcheTaJN6KxDVezvnX/JgrKXlbfPtr1QTRKC7SehW
        zbdwDdQ3dyTwe5wALnI2AaoiB7L2TKn4+iq61DE=
X-Google-Smtp-Source: ABdhPJyDFYsOlb7htakTQBAsycAwitIiZRbTPFXyl5HNac8qWVSA1YfbMISkSepdwws90j02hAYhtJZhGCfSCuVfMdE=
X-Received: by 2002:a62:1c86:0:b029:205:5428:41eb with SMTP id
 c128-20020a621c860000b0290205542841ebmr10042161pfc.33.1615846214190; Mon, 15
 Mar 2021 15:10:14 -0700 (PDT)
MIME-Version: 1.0
From:   Nicolas Iooss <nicolas.iooss@m4x.org>
Date:   Mon, 15 Mar 2021 23:10:03 +0100
X-Gmail-Original-Message-ID: <CAJfZ7==bgZOKifb0Va65VPZjNNLiWcx=zS=G4uQc_nzpuTvJkQ@mail.gmail.com>
Message-ID: <CAJfZ7==bgZOKifb0Va65VPZjNNLiWcx=zS=G4uQc_nzpuTvJkQ@mail.gmail.com>
Subject: libsepol/cil: type confusion between macro and optional leads to
 heap-buffer-overflow in cil_copy_macro
To:     SElinux list <selinux@vger.kernel.org>
Cc:     Evgeny Vereshchagin <evvers@ya.ru>
Content-Type: text/plain; charset="UTF-8"
X-AV-Checked: ClamAV using ClamSMTP at svoboda.polytechnique.org (Mon Mar 15 23:10:16 2021 +0100 (CET))
X-Org-Mail: nicolas.iooss.2010@polytechnique.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Hello,

A few months ago, OSS-Fuzz found a crash in the CIL compiler, which
got reported as
https://bugs.chromium.org/p/oss-fuzz/issues/detail?id=28525. It was
quite complex to minimize and understand, but thanks to the work of
Evgeny Vereshchagin
(https://github.com/google/oss-fuzz/issues/5388#issuecomment-799402426),
the reproducer was minimized to the following CIL policy which
triggers a heap-buffer-overflow detected by clang's address sanitizer:

(macro MACRO1 ()
    (optional OPT
        (allow TYPE TYPE (CLASS (PERM)))
    )
)

(in MACRO1
    (macro OPT ())
)

It is possible to reproduce the crash in an Arch Linux container
(launched for example with "podman run  --rm -ti
docker.io/library/archlinux") by running the following commands:

pacman -Syu git make clang llvm python flex bison xmlto docbook-xml docbook-xsl
git clone https://github.com/SELinuxProject/selinux
cd selinux
ln -s $(pwd)/libsepol/cil/include/cil libsepol/include/sepol/cil
make -C libsepol/src CC=clang \
    CFLAGS='-O2 -g -ggdb3 -fsanitize=address' \
    LDFLAGS='-g -ggdb3 -fsanitize=address' libsepol.a
make -C secilc CC=clang \
    CFLAGS='-O2 -g -ggdb3 -fsanitize=address -I../libsepol/include' \
    LDFLAGS='-g -ggdb3 -fsanitize=address -L../libsepol/src'
./secilc/secilc crash.cil

This leads to the following Address Sanitizer report:

=================================================================
==519==ERROR: AddressSanitizer: heap-buffer-overflow on address
0x6040000001a0 at pc 0x5619403dcf51 bp 0x7ffdce0395d0 sp
0x7ffdce0395c8
READ of size 8 at 0x6040000001a0 thread T0
    #0 0x5619403dcf50 in cil_copy_macro
/selinux/libsepol/src/../cil/src/cil_copy_ast.c:1529:35
    #1 0x5619403dedc9 in __cil_copy_node_helper
/selinux/libsepol/src/../cil/src/cil_copy_ast.c:2055:7
    #2 0x561940425d13 in cil_tree_walk_core
/selinux/libsepol/src/../cil/src/cil_tree.c:272:9
    #3 0x561940425fc5 in cil_tree_walk
/selinux/libsepol/src/../cil/src/cil_tree.c:316:7
    #4 0x5619403dca2a in cil_copy_ast
/selinux/libsepol/src/../cil/src/cil_copy_ast.c:2160:7
    #5 0x561940417ae4 in cil_resolve_in
/selinux/libsepol/src/../cil/src/cil_resolve_ast.c:2499:7
    #6 0x561940417ed4 in cil_resolve_in_list
/selinux/libsepol/src/../cil/src/cil_resolve_ast.c:2545:10
    #7 0x561940420ed0 in cil_resolve_ast
/selinux/libsepol/src/../cil/src/cil_resolve_ast.c:4025:9
    #8 0x561940383e08 in cil_compile
/selinux/libsepol/src/../cil/src/cil.c:550:7
    #9 0x56194036bcee in main /selinux/secilc/secilc.c:291:7
    #10 0x7f5db9156b24 in __libc_start_main (/usr/lib/libc.so.6+0x27b24)
    #11 0x56194028f28d in _start (/selinux/secilc/secilc+0x5828d)

Address 0x6040000001a0 is a wild pointer.
SUMMARY: AddressSanitizer: heap-buffer-overflow
/selinux/libsepol/src/../cil/src/cil_copy_ast.c:1529:35 in
cil_copy_macro
Shadow bytes around the buggy address:
  0x0c087fff7fe0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  0x0c087fff7ff0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  0x0c087fff8000: fa fa 00 00 00 00 00 00 fa fa 00 00 00 00 00 fa
  0x0c087fff8010: fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa
  0x0c087fff8020: fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa
=>0x0c087fff8030: fa fa fa fa[fa]fa fa fa fa fa fa fa fa fa fa fa
  0x0c087fff8040: fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa
  0x0c087fff8050: fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa
  0x0c087fff8060: fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa
  0x0c087fff8070: fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa
  0x0c087fff8080: fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa
Shadow byte legend (one shadow byte represents 8 application bytes):
  Addressable:           00
  Partially addressable: 01 02 03 04 05 06 07
  Heap left redzone:       fa
  Freed heap region:       fd
  Stack left redzone:      f1
  Stack mid redzone:       f2
  Stack right redzone:     f3
  Stack after return:      f5
  Stack use after scope:   f8
  Global redzone:          f9
  Global init order:       f6
  Poisoned by user:        f7
  Container overflow:      fc
  Array cookie:            ac
  Intra object redzone:    bb
  ASan internal:           fe
  Left alloca redzone:     ca
  Right alloca redzone:    cb
  Shadow gap:              cc
==519==ABORTING

It seems that the CIL compiler does not detect that "macro OPT"
conflicts with "optional OPT" when resolving "in MACRO1". I am not
familiar with this part of the code but it seems that this issue could
be fixed by adding a check at the right place.

If someone has some time to take a look in the next days, it would be
very appreciated :) Otherwise I will spend some time next week-end to
debug more the CIL compiler.

Thanks,
Nicolas

