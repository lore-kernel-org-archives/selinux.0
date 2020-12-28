Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A043FC433E0
	for <selinux@archiver.kernel.org>; Mon, 28 Dec 2020 10:36:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 640F92242A
	for <selinux@archiver.kernel.org>; Mon, 28 Dec 2020 10:36:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727018AbgL1KgY (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 28 Dec 2020 05:36:24 -0500
Received: from mx1.polytechnique.org ([129.104.30.34]:37829 "EHLO
        mx1.polytechnique.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726958AbgL1KgY (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 28 Dec 2020 05:36:24 -0500
Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by ssl.polytechnique.org (Postfix) with ESMTPSA id DD6275650AB
        for <selinux@vger.kernel.org>; Mon, 28 Dec 2020 11:35:38 +0100 (CET)
Received: by mail-oi1-f171.google.com with SMTP id f132so11020585oib.12
        for <selinux@vger.kernel.org>; Mon, 28 Dec 2020 02:35:38 -0800 (PST)
X-Gm-Message-State: AOAM533toRed8lfL+auQuVyRr83MlWQeU1mN8yn5275HBt0yYIG9E0EV
        DU+KrOe1NczWCE3LAZRni8BHJocAXuOrMDRlhws=
X-Google-Smtp-Source: ABdhPJwL39hqmbb4Ee+tEmD0VYop6XpZYcjt0FB6bs9p2iiLUcGi78kv7TQKqnFFYgzv0KdT8z/2EDCYmdvmV/MBzkQ=
X-Received: by 2002:aca:51d8:: with SMTP id f207mr11555181oib.20.1609151737448;
 Mon, 28 Dec 2020 02:35:37 -0800 (PST)
MIME-Version: 1.0
From:   Nicolas Iooss <nicolas.iooss@m4x.org>
Date:   Mon, 28 Dec 2020 11:35:25 +0100
X-Gmail-Original-Message-ID: <CAJfZ7=m8qNK2fbO2idPKt1zwYp2XeeCB6R-8ZDmPM1SLEoTpqQ@mail.gmail.com>
Message-ID: <CAJfZ7=m8qNK2fbO2idPKt1zwYp2XeeCB6R-8ZDmPM1SLEoTpqQ@mail.gmail.com>
Subject: libsepol/cil: heap-use-after-free in __class_reset_perm_values
To:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-AV-Checked: ClamAV using ClamSMTP at svoboda.polytechnique.org (Mon Dec 28 11:35:39 2020 +0100 (CET))
X-Org-Mail: nicolas.iooss.2010@polytechnique.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Hello,

A few weeks ago, OSS-Fuzz got configured in order to fuzz the CIL
policy compiler (cf.
https://github.com/SELinuxProject/selinux/issues/215 and
https://github.com/google/oss-fuzz/pull/4790). It reported a bunch of
simple issues, for which I will submit patches. There are also more
subtle bugs, like the one triggered by this CIL policy:

(class CLASS (PERM))
(classorder (CLASS))
(sid SID)
(sidorder (SID))
(sensitivity SENS)
(sensitivityorder (SENS))
(type TYPE)
(allow TYPE self (CLASS (PERM)))

(block b
    (optional o
        (sensitivitycategory SENS (C)) ; Non-existing category
triggers disabling the optional
        (common COMMON (PERM1))
        (classcommon CLASS COMMON)
        (allow TYPE self (CLASS (PERM1)))
    )
)

On my computer, secilc manages to build this policy fine, but when
clang's Address Sanitizer is enabled, running secilc leads to the
following report:

$ make -C libsepol/src CC=clang CFLAGS='-g -fsanitize=address' libsepol.a
$ clang -g -fsanitize=address secilc/secilc.c libsepol/src/libsepol.a
-o my_secilc
$ ./my_secilc -vv testcase.cil
Parsing testcase.cil
Building AST from Parse Tree
Destroying Parse Tree
Resolving AST
Failed to resolve sensitivitycategory statement at testcase.cil:12
Disabling optional 'o' at testcase.cil:11
Resetting declarations
=================================================================
==181743==ERROR: AddressSanitizer: heap-use-after-free on address
0x6070000000c0 at pc 0x55ff7e445d24 bp 0x7ffe7eecfba0 sp
0x7ffe7eecfb98
READ of size 4 at 0x6070000000c0 thread T0
    #0 0x55ff7e445d23 in __class_reset_perm_values
/git/selinux-userspace/libsepol/src/../cil/src/cil_reset_ast.c:17:17
    #1 0x55ff7e3e6dd7 in hashtab_map
/git/selinux-userspace/libsepol/src/hashtab.c:234:10
    #2 0x55ff7e376f3c in cil_symtab_map
/git/selinux-userspace/libsepol/src/../cil/src/cil_symtab.c:131:9
    #3 0x55ff7e443baf in cil_reset_class
/git/selinux-userspace/libsepol/src/../cil/src/cil_reset_ast.c:26:3
    #4 0x55ff7e442e58 in __cil_reset_node
/git/selinux-userspace/libsepol/src/../cil/src/cil_reset_ast.c:416:3
    #5 0x55ff7e37ba2a in cil_tree_walk_core
/git/selinux-userspace/libsepol/src/../cil/src/cil_tree.c:272:9
    #6 0x55ff7e37bddb in cil_tree_walk
/git/selinux-userspace/libsepol/src/../cil/src/cil_tree.c:316:7
    #7 0x55ff7e37bb7f in cil_tree_walk_core
/git/selinux-userspace/libsepol/src/../cil/src/cil_tree.c:284:9
    #8 0x55ff7e37bddb in cil_tree_walk
/git/selinux-userspace/libsepol/src/../cil/src/cil_tree.c:316:7
    #9 0x55ff7e445c71 in cil_reset_ast
/git/selinux-userspace/libsepol/src/../cil/src/cil_reset_ast.c:585:7
    #10 0x55ff7e3748e0 in cil_resolve_ast
/git/selinux-userspace/libsepol/src/../cil/src/cil_resolve_ast.c:4008:9
    #11 0x55ff7e285bed in cil_compile
/git/selinux-userspace/libsepol/src/../cil/src/cil.c:550:7
    #12 0x55ff7e261cf5 in main /git/selinux-userspace/secilc/secilc.c:291:7
    #13 0x7fb567dc1151 in __libc_start_main (/usr/lib/libc.so.6+0x28151)
    #14 0x55ff7e18424d in _start (/git/selinux-userspace/my_secilc+0x5924d)

0x6070000000c0 is located 48 bytes inside of 72-byte region
[0x607000000090,0x6070000000d8)
freed by thread T0 here:
    #0 0x55ff7e22a109 in free (/git/selinux-userspace/my_secilc+0xff109)
    #1 0x55ff7e2cb662 in cil_destroy_class
/git/selinux-userspace/libsepol/src/../cil/src/cil_build_ast.c:443:2
    #2 0x55ff7e286978 in cil_destroy_data
/git/selinux-userspace/libsepol/src/../cil/src/cil.c:672:3
    #3 0x55ff7e37b731 in cil_tree_node_destroy
/git/selinux-userspace/libsepol/src/../cil/src/cil_tree.c:235:4
    #4 0x55ff7e37b403 in cil_tree_children_destroy
/git/selinux-userspace/libsepol/src/../cil/src/cil_tree.c:201:5
    #5 0x55ff7e3737d1 in __cil_resolve_ast_last_child_helper
/git/selinux-userspace/libsepol/src/../cil/src/cil_resolve_ast.c:3855:4
    #6 0x55ff7e37be4a in cil_tree_walk
/git/selinux-userspace/libsepol/src/../cil/src/cil_tree.c:322:8
    #7 0x55ff7e37bb7f in cil_tree_walk_core
/git/selinux-userspace/libsepol/src/../cil/src/cil_tree.c:284:9
    #8 0x55ff7e37bddb in cil_tree_walk
/git/selinux-userspace/libsepol/src/../cil/src/cil_tree.c:316:7
    #9 0x55ff7e37bb7f in cil_tree_walk_core
/git/selinux-userspace/libsepol/src/../cil/src/cil_tree.c:284:9
    #10 0x55ff7e37bddb in cil_tree_walk
/git/selinux-userspace/libsepol/src/../cil/src/cil_tree.c:316:7
    #11 0x55ff7e37bb7f in cil_tree_walk_core
/git/selinux-userspace/libsepol/src/../cil/src/cil_tree.c:284:9
    #12 0x55ff7e37bddb in cil_tree_walk
/git/selinux-userspace/libsepol/src/../cil/src/cil_tree.c:316:7
    #13 0x55ff7e374334 in cil_resolve_ast
/git/selinux-userspace/libsepol/src/../cil/src/cil_resolve_ast.c:3926:8
    #14 0x55ff7e285bed in cil_compile
/git/selinux-userspace/libsepol/src/../cil/src/cil.c:550:7
    #15 0x55ff7e261cf5 in main /git/selinux-userspace/secilc/secilc.c:291:7
    #16 0x7fb567dc1151 in __libc_start_main (/usr/lib/libc.so.6+0x28151)

previously allocated by thread T0 here:
    #0 0x55ff7e22a439 in malloc (/git/selinux-userspace/my_secilc+0xff439)
    #1 0x55ff7e322394 in cil_malloc
/git/selinux-userspace/libsepol/src/../cil/src/cil_mem.c:39:14
    #2 0x55ff7e28f055 in cil_class_init
/git/selinux-userspace/libsepol/src/../cil/src/cil.c:2031:11
    #3 0x55ff7e2ce95a in cil_gen_common
/git/selinux-userspace/libsepol/src/../cil/src/cil_build_ast.c:979:2
    #4 0x55ff7e2fa33f in __cil_build_ast_node_helper
/git/selinux-userspace/libsepol/src/../cil/src/cil_build_ast.c:6174:8
    #5 0x55ff7e37ba2a in cil_tree_walk_core
/git/selinux-userspace/libsepol/src/../cil/src/cil_tree.c:272:9
    #6 0x55ff7e37bddb in cil_tree_walk
/git/selinux-userspace/libsepol/src/../cil/src/cil_tree.c:316:7
    #7 0x55ff7e37bb7f in cil_tree_walk_core
/git/selinux-userspace/libsepol/src/../cil/src/cil_tree.c:284:9
    #8 0x55ff7e37bddb in cil_tree_walk
/git/selinux-userspace/libsepol/src/../cil/src/cil_tree.c:316:7
    #9 0x55ff7e37bb7f in cil_tree_walk_core
/git/selinux-userspace/libsepol/src/../cil/src/cil_tree.c:284:9
    #10 0x55ff7e37bddb in cil_tree_walk
/git/selinux-userspace/libsepol/src/../cil/src/cil_tree.c:316:7
    #11 0x55ff7e37bb7f in cil_tree_walk_core
/git/selinux-userspace/libsepol/src/../cil/src/cil_tree.c:284:9
    #12 0x55ff7e37bddb in cil_tree_walk
/git/selinux-userspace/libsepol/src/../cil/src/cil_tree.c:316:7
    #13 0x55ff7e37bb7f in cil_tree_walk_core
/git/selinux-userspace/libsepol/src/../cil/src/cil_tree.c:284:9
    #14 0x55ff7e37bddb in cil_tree_walk
/git/selinux-userspace/libsepol/src/../cil/src/cil_tree.c:316:7
    #15 0x55ff7e301a2f in cil_build_ast
/git/selinux-userspace/libsepol/src/../cil/src/cil_build_ast.c:6521:7
    #16 0x55ff7e285b2d in cil_compile
/git/selinux-userspace/libsepol/src/../cil/src/cil.c:540:7
    #17 0x55ff7e261cf5 in main /git/selinux-userspace/secilc/secilc.c:291:7
    #18 0x7fb567dc1151 in __libc_start_main (/usr/lib/libc.so.6+0x28151)

SUMMARY: AddressSanitizer: heap-use-after-free
/git/selinux-userspace/libsepol/src/../cil/src/cil_reset_ast.c:17:17
in __class_reset_perm_values
Shadow bytes around the buggy address:
  0x0c0e7fff7fc0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  0x0c0e7fff7fd0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  0x0c0e7fff7fe0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  0x0c0e7fff7ff0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  0x0c0e7fff8000: fa fa fa fa 00 00 00 00 00 00 00 00 00 fa fa fa
=>0x0c0e7fff8010: fa fa fd fd fd fd fd fd[fd]fd fd fa fa fa fa fa
  0x0c0e7fff8020: fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa
  0x0c0e7fff8030: fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa
  0x0c0e7fff8040: fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa
  0x0c0e7fff8050: fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa
  0x0c0e7fff8060: fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa
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
==181743==ABORTING

It seems that cil_reset_class() uses some permissions after they were
freed somewhere else. How should this be fixed?

By the way, the reference of this issue is
https://bugs.chromium.org/p/oss-fuzz/issues/detail?id=28467 (right now
it is behind authentication, but this report will be public on
2021-03-09).

Nicolas

