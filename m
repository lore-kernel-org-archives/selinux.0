Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 451F9C433E0
	for <selinux@archiver.kernel.org>; Thu, 18 Mar 2021 22:04:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 12B8764F30
	for <selinux@archiver.kernel.org>; Thu, 18 Mar 2021 22:04:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231280AbhCRWEW (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 18 Mar 2021 18:04:22 -0400
Received: from mx1.polytechnique.org ([129.104.30.34]:52905 "EHLO
        mx1.polytechnique.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230333AbhCRWEA (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 18 Mar 2021 18:04:00 -0400
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by ssl.polytechnique.org (Postfix) with ESMTPSA id 69B4D564E44
        for <selinux@vger.kernel.org>; Thu, 18 Mar 2021 23:03:52 +0100 (CET)
Received: by mail-pf1-f170.google.com with SMTP id g15so4456150pfq.3
        for <selinux@vger.kernel.org>; Thu, 18 Mar 2021 15:03:52 -0700 (PDT)
X-Gm-Message-State: AOAM530nYKrDdq2KS/NGvCCloLdHHclZtsvC5OVS5TOF+0kCw2S0fina
        PB78d6JRO6VuodiwSDJ5Br+6s2HPpvMG/8fSTZY=
X-Google-Smtp-Source: ABdhPJyQNTSlz9nweGsj7W3sK5zot2+hwjAOzrA8KgoTpLswqqQBJcwUUz7IpTZ/jj0bubMijBD/2SGCgW00TFSn+Rw=
X-Received: by 2002:a63:c90c:: with SMTP id o12mr8910302pgg.210.1616105031037;
 Thu, 18 Mar 2021 15:03:51 -0700 (PDT)
MIME-Version: 1.0
References: <20210317190002.81465-1-jwcart2@gmail.com>
In-Reply-To: <20210317190002.81465-1-jwcart2@gmail.com>
From:   Nicolas Iooss <nicolas.iooss@m4x.org>
Date:   Thu, 18 Mar 2021 23:03:40 +0100
X-Gmail-Original-Message-ID: <CAJfZ7==R5Gpvxpb--nErHb7ZP3LvCZYP-fPZOpg1ZJsQG_Fi5w@mail.gmail.com>
Message-ID: <CAJfZ7==R5Gpvxpb--nErHb7ZP3LvCZYP-fPZOpg1ZJsQG_Fi5w@mail.gmail.com>
Subject: Re: [PATCH] libsepol/cil: Destroy classperms list when resetting classpermission
To:     James Carter <jwcart2@gmail.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-AV-Checked: ClamAV using ClamSMTP at svoboda.polytechnique.org (Thu Mar 18 23:03:53 2021 +0100 (CET))
X-Org-Mail: nicolas.iooss.2010@polytechnique.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Mar 17, 2021 at 8:00 PM James Carter <jwcart2@gmail.com> wrote:
>
> Nicolas Iooss reports:
>   A few months ago, OSS-Fuzz found a crash in the CIL compiler, which
>   got reported as
>   https://bugs.chromium.org/p/oss-fuzz/issues/detail?id=28648 (the title
>   is misleading, or is caused by another issue that conflicts with the
>   one I report in this message). Here is a minimized CIL policy which
>   reproduces the issue:
>
>   (class CLASS (PERM))
>   (classorder (CLASS))
>   (sid SID)
>   (sidorder (SID))
>   (user USER)
>   (role ROLE)
>   (type TYPE)
>   (category CAT)
>   (categoryorder (CAT))
>   (sensitivity SENS)
>   (sensitivityorder (SENS))
>   (sensitivitycategory SENS (CAT))
>   (allow TYPE self (CLASS (PERM)))
>   (roletype ROLE TYPE)
>   (userrole USER ROLE)
>   (userlevel USER (SENS))
>   (userrange USER ((SENS)(SENS (CAT))))
>   (sidcontext SID (USER ROLE TYPE ((SENS)(SENS))))
>
>   (classpermission CLAPERM)
>
>   (optional OPT
>       (roletype nonexistingrole nonexistingtype)
>       (classpermissionset CLAPERM (CLASS (PERM)))
>   )
>
>   The CIL policy fuzzer (which mimics secilc built with clang Address
>   Sanitizer) reports:
>
>   ==36541==ERROR: AddressSanitizer: heap-use-after-free on address
>   0x603000004f98 at pc 0x56445134c842 bp 0x7ffe2a256590 sp
>   0x7ffe2a256588
>   READ of size 8 at 0x603000004f98 thread T0
>       #0 0x56445134c841 in __cil_verify_classperms
>   /selinux/libsepol/src/../cil/src/cil_verify.c:1620:8
>       #1 0x56445134a43e in __cil_verify_classpermission
>   /selinux/libsepol/src/../cil/src/cil_verify.c:1650:9
>       #2 0x56445134a43e in __cil_pre_verify_helper
>   /selinux/libsepol/src/../cil/src/cil_verify.c:1715:8
>       #3 0x5644513225ac in cil_tree_walk_core
>   /selinux/libsepol/src/../cil/src/cil_tree.c:272:9
>       #4 0x564451322ab1 in cil_tree_walk
>   /selinux/libsepol/src/../cil/src/cil_tree.c:316:7
>       #5 0x5644513226af in cil_tree_walk_core
>   /selinux/libsepol/src/../cil/src/cil_tree.c:284:9
>       #6 0x564451322ab1 in cil_tree_walk
>   /selinux/libsepol/src/../cil/src/cil_tree.c:316:7
>       #7 0x5644512b88fd in cil_pre_verify
>   /selinux/libsepol/src/../cil/src/cil_post.c:2510:7
>       #8 0x5644512b88fd in cil_post_process
>   /selinux/libsepol/src/../cil/src/cil_post.c:2524:7
>       #9 0x5644511856ff in cil_compile
>   /selinux/libsepol/src/../cil/src/cil.c:564:7
>
> The classperms list of a classpermission rule is created and filled
> in when classpermissionset rules are processed, so it doesn't own any
> part of the list and shouldn't retain any of it when it is reset.
>
> Destroy the classperms list (without destroying the data in it)  when
> resetting a classpermission rule.
>
> Reported-by: Nicolas Iooss <nicolas.iooss@m4x.org>
> Signed-off-by: James Carter <jwcart2@gmail.com>
> ---
>  libsepol/cil/src/cil_reset_ast.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/libsepol/cil/src/cil_reset_ast.c b/libsepol/cil/src/cil_reset_ast.c
> index 3da1b9a6..db70a535 100644
> --- a/libsepol/cil/src/cil_reset_ast.c
> +++ b/libsepol/cil/src/cil_reset_ast.c
> @@ -54,7 +54,7 @@ static void cil_reset_classpermission(struct cil_classpermission *cp)
>                 return;
>         }
>
> -       cil_reset_classperms_list(cp->classperms);
> +       cil_list_destroy(&cp->classperms, CIL_FALSE);
>  }
>
>  static void cil_reset_classperms_set(struct cil_classperms_set *cp_set)

Hello,
This patch seems to make secilc segfault on a test policy, for example
on GitHub Actions:

make[1]: Entering directory '/home/runner/work/selinux/selinux/secilc'
./secilc test/policy.cil
make[1]: *** [Makefile:32: test] Segmentation fault (core dumped)

(from https://github.com/fishilico/selinux/runs/2135040809?check_suite_focus=true#step:9:2645).
It also produces a segmentation fault on my Arch Linux development
system (building with gcc or clang and the default compilation flags
of the project).

Is this segfault fixed by the other patches you sent?

Thanks,
Nicolas

