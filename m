Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FBA0C433DB
	for <selinux@archiver.kernel.org>; Fri, 19 Mar 2021 13:32:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 505B564F3B
	for <selinux@archiver.kernel.org>; Fri, 19 Mar 2021 13:32:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229914AbhCSNcR (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 19 Mar 2021 09:32:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229990AbhCSNcL (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 19 Mar 2021 09:32:11 -0400
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com [IPv6:2607:f8b0:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4D21C06174A
        for <selinux@vger.kernel.org>; Fri, 19 Mar 2021 06:32:11 -0700 (PDT)
Received: by mail-ot1-x32a.google.com with SMTP id y19-20020a0568301d93b02901b9f88a238eso8499484oti.11
        for <selinux@vger.kernel.org>; Fri, 19 Mar 2021 06:32:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AIdfzPmKoULK9bgTX3tU4ZnJOHZW9j+IIFuEOP75ytU=;
        b=e0MKHWVIS0gAXOuTBaf+EQifbLLAUnLwJ6G3CH2OnAUIRdMhluKj1tbGQKyMfbHMP6
         +HRfl6sVk8Hl+WmPOYzeDn7pZ8i1in1aVprRiSdwRIWLtyoIdxmApZcQB9T7NsSXwMQh
         qTwaF/cK+AE7QkC9dlDENoLJLYLyww89qGGuhdimU/cc6DeZI9zqovCepJi3w1Ei7lnD
         21GDxCuJlhyMZMgslZNS0aDbvMgYQ+nXahZos0ian5u+eCTGMnQgccIoAtfb/q45smrU
         IirMsxlmi7bkK6QCv6n3db7NQXt2ZmJlRlcb4THWW5gkNAc3DfODoiCTtIkoiJrEnGdm
         q48g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AIdfzPmKoULK9bgTX3tU4ZnJOHZW9j+IIFuEOP75ytU=;
        b=GsLPaeYfMHlqr1j0lxgCVbH0BQzGKboRegAOd8ebntE5yBVbViaZ67YAc3Qtuj8NxV
         LxEiQ7T07XU+7W8Bz4ZdXXfyCwmtE5uUl/mULZBBmk38FxaYiIQWArlyF6y2hfxqveN1
         xGZFl6ZdWFsd2gFG/rsOsEguylweH3BPuHGK1CXURoKqs471kxEnKFwChGK9aHVfIVMo
         J8hMduftri9niIVZNjUo4zPAZCidtNKjQQp9GIYLEPTmm+2VsUUgg6LriMcd0DfW4gg2
         9Kf5i6FHc3jD7JZ1YA6UQcucCNZQUhJvqjZjPWUScmyJJNddLTLqb8oXOqgYeApXfP8i
         O/iw==
X-Gm-Message-State: AOAM533Livzuc6xz9oSXnrj9btAePpqYtflDh/PVq9iU1raHVSQJ34QC
        wdhUfdsJRKvoJV2Ghl/jedJn/z2BFRaV04iL84gHfbzociI=
X-Google-Smtp-Source: ABdhPJwD4p62L5s8OVxrlUsvFfxsS7VR8qouUB2Gbp5F/khiZj222/RDiWk4psJ9CwUaSVac5p9VDeIZ3msuWeFz+gI=
X-Received: by 2002:a9d:6296:: with SMTP id x22mr1147075otk.196.1616160731151;
 Fri, 19 Mar 2021 06:32:11 -0700 (PDT)
MIME-Version: 1.0
References: <20210317190002.81465-1-jwcart2@gmail.com> <CAJfZ7==R5Gpvxpb--nErHb7ZP3LvCZYP-fPZOpg1ZJsQG_Fi5w@mail.gmail.com>
In-Reply-To: <CAJfZ7==R5Gpvxpb--nErHb7ZP3LvCZYP-fPZOpg1ZJsQG_Fi5w@mail.gmail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Fri, 19 Mar 2021 09:37:52 -0400
Message-ID: <CAP+JOzSi+Toirv=T07QfaCk0wa=z7azTVh3WVXh6XTd9wvgj_Q@mail.gmail.com>
Subject: Re: [PATCH] libsepol/cil: Destroy classperms list when resetting classpermission
To:     Nicolas Iooss <nicolas.iooss@m4x.org>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Mar 18, 2021 at 6:03 PM Nicolas Iooss <nicolas.iooss@m4x.org> wrote:
>
> On Wed, Mar 17, 2021 at 8:00 PM James Carter <jwcart2@gmail.com> wrote:
> >
> > Nicolas Iooss reports:
> >   A few months ago, OSS-Fuzz found a crash in the CIL compiler, which
> >   got reported as
> >   https://bugs.chromium.org/p/oss-fuzz/issues/detail?id=28648 (the title
> >   is misleading, or is caused by another issue that conflicts with the
> >   one I report in this message). Here is a minimized CIL policy which
> >   reproduces the issue:
> >
> >   (class CLASS (PERM))
> >   (classorder (CLASS))
> >   (sid SID)
> >   (sidorder (SID))
> >   (user USER)
> >   (role ROLE)
> >   (type TYPE)
> >   (category CAT)
> >   (categoryorder (CAT))
> >   (sensitivity SENS)
> >   (sensitivityorder (SENS))
> >   (sensitivitycategory SENS (CAT))
> >   (allow TYPE self (CLASS (PERM)))
> >   (roletype ROLE TYPE)
> >   (userrole USER ROLE)
> >   (userlevel USER (SENS))
> >   (userrange USER ((SENS)(SENS (CAT))))
> >   (sidcontext SID (USER ROLE TYPE ((SENS)(SENS))))
> >
> >   (classpermission CLAPERM)
> >
> >   (optional OPT
> >       (roletype nonexistingrole nonexistingtype)
> >       (classpermissionset CLAPERM (CLASS (PERM)))
> >   )
> >
> >   The CIL policy fuzzer (which mimics secilc built with clang Address
> >   Sanitizer) reports:
> >
> >   ==36541==ERROR: AddressSanitizer: heap-use-after-free on address
> >   0x603000004f98 at pc 0x56445134c842 bp 0x7ffe2a256590 sp
> >   0x7ffe2a256588
> >   READ of size 8 at 0x603000004f98 thread T0
> >       #0 0x56445134c841 in __cil_verify_classperms
> >   /selinux/libsepol/src/../cil/src/cil_verify.c:1620:8
> >       #1 0x56445134a43e in __cil_verify_classpermission
> >   /selinux/libsepol/src/../cil/src/cil_verify.c:1650:9
> >       #2 0x56445134a43e in __cil_pre_verify_helper
> >   /selinux/libsepol/src/../cil/src/cil_verify.c:1715:8
> >       #3 0x5644513225ac in cil_tree_walk_core
> >   /selinux/libsepol/src/../cil/src/cil_tree.c:272:9
> >       #4 0x564451322ab1 in cil_tree_walk
> >   /selinux/libsepol/src/../cil/src/cil_tree.c:316:7
> >       #5 0x5644513226af in cil_tree_walk_core
> >   /selinux/libsepol/src/../cil/src/cil_tree.c:284:9
> >       #6 0x564451322ab1 in cil_tree_walk
> >   /selinux/libsepol/src/../cil/src/cil_tree.c:316:7
> >       #7 0x5644512b88fd in cil_pre_verify
> >   /selinux/libsepol/src/../cil/src/cil_post.c:2510:7
> >       #8 0x5644512b88fd in cil_post_process
> >   /selinux/libsepol/src/../cil/src/cil_post.c:2524:7
> >       #9 0x5644511856ff in cil_compile
> >   /selinux/libsepol/src/../cil/src/cil.c:564:7
> >
> > The classperms list of a classpermission rule is created and filled
> > in when classpermissionset rules are processed, so it doesn't own any
> > part of the list and shouldn't retain any of it when it is reset.
> >
> > Destroy the classperms list (without destroying the data in it)  when
> > resetting a classpermission rule.
> >
> > Reported-by: Nicolas Iooss <nicolas.iooss@m4x.org>
> > Signed-off-by: James Carter <jwcart2@gmail.com>
> > ---
> >  libsepol/cil/src/cil_reset_ast.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/libsepol/cil/src/cil_reset_ast.c b/libsepol/cil/src/cil_reset_ast.c
> > index 3da1b9a6..db70a535 100644
> > --- a/libsepol/cil/src/cil_reset_ast.c
> > +++ b/libsepol/cil/src/cil_reset_ast.c
> > @@ -54,7 +54,7 @@ static void cil_reset_classpermission(struct cil_classpermission *cp)
> >                 return;
> >         }
> >
> > -       cil_reset_classperms_list(cp->classperms);
> > +       cil_list_destroy(&cp->classperms, CIL_FALSE);
> >  }
> >
> >  static void cil_reset_classperms_set(struct cil_classperms_set *cp_set)
>
> Hello,
> This patch seems to make secilc segfault on a test policy, for example
> on GitHub Actions:
>
> make[1]: Entering directory '/home/runner/work/selinux/selinux/secilc'
> ./secilc test/policy.cil
> make[1]: *** [Makefile:32: test] Segmentation fault (core dumped)
>
> (from https://github.com/fishilico/selinux/runs/2135040809?check_suite_focus=true#step:9:2645).
> It also produces a segmentation fault on my Arch Linux development
> system (building with gcc or clang and the default compilation flags
> of the project).
>
> Is this segfault fixed by the other patches you sent?
>

I believe this one does:
libsepol/cil: cil_reset_classperms_set() should not reset classpermission

I hadn't realized the connection when I sent the patches.

Thanks,
Jim

> Thanks,
> Nicolas
>
