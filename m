Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E6A3C433DB
	for <selinux@archiver.kernel.org>; Wed, 17 Mar 2021 08:52:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 590E964E27
	for <selinux@archiver.kernel.org>; Wed, 17 Mar 2021 08:52:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229472AbhCQIwW (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 17 Mar 2021 04:52:22 -0400
Received: from mx1.polytechnique.org ([129.104.30.34]:44348 "EHLO
        mx1.polytechnique.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229584AbhCQIwO (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 17 Mar 2021 04:52:14 -0400
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by ssl.polytechnique.org (Postfix) with ESMTPSA id 64FA1564B13
        for <selinux@vger.kernel.org>; Wed, 17 Mar 2021 09:52:12 +0100 (CET)
Received: by mail-pl1-f172.google.com with SMTP id e2so433305pld.9
        for <selinux@vger.kernel.org>; Wed, 17 Mar 2021 01:52:12 -0700 (PDT)
X-Gm-Message-State: AOAM532ePQ2nwvAYnSBBswInPbthFhbBaGWFzFdHlst6Gu8lmcT6HN5K
        obtKkLXeaEmqwvjfXGaRQ0XqWCj2/CdcYMh3ZAc=
X-Google-Smtp-Source: ABdhPJx0ytJhmr/qAZ001yJfbQWqYYQAk+HdkKC+Yo9pK9WkDLioRhyiVfivWaYSnHJP9BSdZ/i3igYWMIeQ7I7GRrQ=
X-Received: by 2002:a17:90a:4d81:: with SMTP id m1mr3464656pjh.143.1615971130938;
 Wed, 17 Mar 2021 01:52:10 -0700 (PDT)
MIME-Version: 1.0
From:   Nicolas Iooss <nicolas.iooss@m4x.org>
Date:   Wed, 17 Mar 2021 09:52:00 +0100
X-Gmail-Original-Message-ID: <CAJfZ7==tXhRhmtsJA5HDiqqgFkq5v0BcG0hu_-4tjVJztojQEA@mail.gmail.com>
Message-ID: <CAJfZ7==tXhRhmtsJA5HDiqqgFkq5v0BcG0hu_-4tjVJztojQEA@mail.gmail.com>
Subject: libsepol/cil: use after free with optional classpermissionset
To:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-AV-Checked: ClamAV using ClamSMTP at svoboda.polytechnique.org (Wed Mar 17 09:52:12 2021 +0100 (CET))
X-Org-Mail: nicolas.iooss.2010@polytechnique.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Hello,

A few months ago, OSS-Fuzz found a crash in the CIL compiler, which
got reported as
https://bugs.chromium.org/p/oss-fuzz/issues/detail?id=28648 (the title
is misleading, or is caused by another issue that conflicts with the
one I report in this message). Here is a minimized CIL policy which
reproduces the issue:

(class CLASS (PERM))
(classorder (CLASS))
(sid SID)
(sidorder (SID))
(user USER)
(role ROLE)
(type TYPE)
(category CAT)
(categoryorder (CAT))
(sensitivity SENS)
(sensitivityorder (SENS))
(sensitivitycategory SENS (CAT))
(allow TYPE self (CLASS (PERM)))
(roletype ROLE TYPE)
(userrole USER ROLE)
(userlevel USER (SENS))
(userrange USER ((SENS)(SENS (CAT))))
(sidcontext SID (USER ROLE TYPE ((SENS)(SENS))))

(classpermission CLAPERM)

(optional OPT
    (roletype nonexistingrole nonexistingtype)
    (classpermissionset CLAPERM (CLASS (PERM)))
)

The CIL policy fuzzer (which mimics secilc built with clang Address
Sanitizer) reports:

==36541==ERROR: AddressSanitizer: heap-use-after-free on address
0x603000004f98 at pc 0x56445134c842 bp 0x7ffe2a256590 sp
0x7ffe2a256588
READ of size 8 at 0x603000004f98 thread T0
    #0 0x56445134c841 in __cil_verify_classperms
/selinux/libsepol/src/../cil/src/cil_verify.c:1620:8
    #1 0x56445134a43e in __cil_verify_classpermission
/selinux/libsepol/src/../cil/src/cil_verify.c:1650:9
    #2 0x56445134a43e in __cil_pre_verify_helper
/selinux/libsepol/src/../cil/src/cil_verify.c:1715:8
    #3 0x5644513225ac in cil_tree_walk_core
/selinux/libsepol/src/../cil/src/cil_tree.c:272:9
    #4 0x564451322ab1 in cil_tree_walk
/selinux/libsepol/src/../cil/src/cil_tree.c:316:7
    #5 0x5644513226af in cil_tree_walk_core
/selinux/libsepol/src/../cil/src/cil_tree.c:284:9
    #6 0x564451322ab1 in cil_tree_walk
/selinux/libsepol/src/../cil/src/cil_tree.c:316:7
    #7 0x5644512b88fd in cil_pre_verify
/selinux/libsepol/src/../cil/src/cil_post.c:2510:7
    #8 0x5644512b88fd in cil_post_process
/selinux/libsepol/src/../cil/src/cil_post.c:2524:7
    #9 0x5644511856ff in cil_compile
/selinux/libsepol/src/../cil/src/cil.c:564:7

It seems that cil_resolve_classpermissionset() copies pointers to
classperms objects into the classpermission CLAPERM (in
libsepol/cil/src/cil_resolve_ast.c), and that the resolution of the
optional block destroys these objects without removing references to
them in CLAPERM. This leads to a use-after-free issue which is
reproducible.

Could you please take a look at this issue?

Thanks,
Nicolas

