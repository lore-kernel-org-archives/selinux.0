Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 535B3C433E0
	for <selinux@archiver.kernel.org>; Wed, 30 Dec 2020 17:45:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 19A382220B
	for <selinux@archiver.kernel.org>; Wed, 30 Dec 2020 17:45:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726419AbgL3Rpb (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 30 Dec 2020 12:45:31 -0500
Received: from mx1.polytechnique.org ([129.104.30.34]:57333 "EHLO
        mx1.polytechnique.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726337AbgL3Rpb (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 30 Dec 2020 12:45:31 -0500
Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by ssl.polytechnique.org (Postfix) with ESMTPSA id E6E9D56128B
        for <selinux@vger.kernel.org>; Wed, 30 Dec 2020 18:44:47 +0100 (CET)
Received: by mail-ot1-f42.google.com with SMTP id w3so15986893otp.13
        for <selinux@vger.kernel.org>; Wed, 30 Dec 2020 09:44:47 -0800 (PST)
X-Gm-Message-State: AOAM530/R9Dk04TOXv4VLBWGFj5xW9+rXrULDegUBT4CY827J7ESmxMw
        +cb1Ch+ILkuLYgJnG7EvKupKE9zmMwJlW4VjTSc=
X-Google-Smtp-Source: ABdhPJzzehVh2hqYi80NooUR390tbyxe1JIB8nfAGutYY190ERt5ZDUg6nxRU2dv2J+d2JJaGT+Rf5bDILnikhe1GGM=
X-Received: by 2002:a05:6830:1e62:: with SMTP id m2mr39242434otr.279.1609350286597;
 Wed, 30 Dec 2020 09:44:46 -0800 (PST)
MIME-Version: 1.0
From:   Nicolas Iooss <nicolas.iooss@m4x.org>
Date:   Wed, 30 Dec 2020 18:44:35 +0100
X-Gmail-Original-Message-ID: <CAJfZ7=kiMYKgEn1YvxgVjxh=ud5Nd==bOmYnRVEqfc=hDDX1ZA@mail.gmail.com>
Message-ID: <CAJfZ7=kiMYKgEn1YvxgVjxh=ud5Nd==bOmYnRVEqfc=hDDX1ZA@mail.gmail.com>
Subject: libsepol/cil: infinite loop using invalid block/blockabstract
To:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-AV-Checked: ClamAV using ClamSMTP at svoboda.polytechnique.org (Wed Dec 30 18:44:48 2020 +0100 (CET))
X-Org-Mail: nicolas.iooss.2010@polytechnique.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Hello,

A few weeks ago, OSS-Fuzz got configured in order to fuzz the CIL
policy compiler. One of the issue it reported was a "Stack-overflow in
__cil_resolve_name_with_parents", which seemed strange
(https://bugs.chromium.org/p/oss-fuzz/issues/detail?id=28491, for
future reference).

By looking into it, the reduced test-case is the following CIL policy:

(optional o
    (block b
        (block b
            (blockabstract b0)
        )
        (blockinherit b)
    )
)
(blockinherit b)

When building this policy with secilc, the command seems to be caught
in a loop that never ends. Using gdb to break somewhere leads to the
following call stack:

#0  0x0000555555bab646 in __cil_resolve_name_with_parents
(node=0x606000000fe0, name=<optimized out>, sym_index=<optimized out>,
datum=<optimized out>) at ../cil/src/cil_resolve_ast.c:4070
#1  0x0000555555baae73 in __cil_resolve_name_helper (db=<optimized
out>, node=<optimized out>, name=0x602000002850 "b0",
sym_index=CIL_SYM_BLOCKS, datum=0x7fffffffcd80) at
../cil/src/cil_resolve_ast.c:4122
#2  0x0000555555b7865b in cil_resolve_name_keep_aliases
(ast_node=<optimized out>, name=<optimized out>, sym_index=<optimized
out>, extra_args=<optimized out>, datum=<optimized out>) at
../cil/src/cil_resolve_ast.c:4173
#3  0x0000555555b70384 in cil_resolve_name (ast_node=0x0, name=0x0,
sym_index=CIL_SYM_BLOCKS, extra_args=0x7fffffffcd80,
datum=0x7fffffffcd80) at ../cil/src/cil_resolve_ast.c:4134
#4  0x0000555555b96b9f in cil_resolve_blockabstract
(current=0x606000001040, extra_args=<optimized out>) at
../cil/src/cil_resolve_ast.c:2457
#5  0x0000555555ba4c2c in __cil_resolve_ast_node (node=<optimized
out>, extra_args=<optimized out>) at ../cil/src/cil_resolve_ast.c:3450
#6  0x0000555555ba6e00 in __cil_resolve_ast_node_helper
(node=<optimized out>, finished=<optimized out>, extra_args=<optimized
out>) at ../cil/src/cil_resolve_ast.c:3769
#7  0x0000555555bb86ed in cil_tree_walk_core (node=0x606000001040,
process_node=<optimized out>, first_child=<optimized out>,
last_child=<optimized out>, extra_args=<optimized out>) at
../cil/src/cil_tree.c:272
#8  0x0000555555bb8bf2 in cil_tree_walk (node=0x606000000fe0,
process_node=<optimized out>, first_child=<optimized out>,
last_child=<optimized out>, extra_args=<optimized out>) at
../cil/src/cil_tree.c:316
#9  0x0000555555bb87f0 in cil_tree_walk_core (node=0x606000000fe0,
process_node=<optimized out>, first_child=<optimized out>,
last_child=<optimized out>, extra_args=<optimized out>) at
../cil/src/cil_tree.c:284
#10 0x0000555555bb8bf2 in cil_tree_walk (node=0x606000000bc0,
process_node=<optimized out>, first_child=<optimized out>,
last_child=<optimized out>, extra_args=<optimized out>) at
../cil/src/cil_tree.c:316
#11 0x0000555555bb87f0 in cil_tree_walk_core (node=0x606000000bc0,
process_node=<optimized out>, first_child=<optimized out>,
last_child=<optimized out>, extra_args=<optimized out>) at
../cil/src/cil_tree.c:284
#12 0x0000555555bb8bf2 in cil_tree_walk (node=0x606000000980,
process_node=<optimized out>, first_child=<optimized out>,
last_child=<optimized out>, extra_args=<optimized out>) at
../cil/src/cil_tree.c:316
#13 0x0000555555bb87f0 in cil_tree_walk_core (node=0x606000000980,
process_node=<optimized out>, first_child=<optimized out>,
last_child=<optimized out>, extra_args=<optimized out>) at
../cil/src/cil_tree.c:284
#14 0x0000555555bb8bf2 in cil_tree_walk (node=0x606000000080,
process_node=<optimized out>, first_child=<optimized out>,
last_child=<optimized out>, extra_args=<optimized out>) at
../cil/src/cil_tree.c:316
#15 0x0000555555ba9dd1 in cil_resolve_ast (db=<optimized out>,
current=<optimized out>) at ../cil/src/cil_resolve_ast.c:3937
#16 0x0000555555a1d64a in cil_compile (db=0x6120000001c0) at
../cil/src/cil.c:550
#17 0x00005555559e9d06 in main ()

However, if I understand correctly the documentation
(https://github.com/SELinuxProject/selinux/blob/master/secilc/docs/cil_container_statements.md),
having two "(block b)" and a "(blockabstract b0)" that does not
reference "b" are not supposed to work. Maybe the CIL compiler needs
to detect such issues and fail instead of entering some kind of loop.
How should this issue be fixed?

Nicolas

