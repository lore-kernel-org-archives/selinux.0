Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3658CC433ED
	for <selinux@archiver.kernel.org>; Mon, 19 Apr 2021 18:24:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EA04D611F2
	for <selinux@archiver.kernel.org>; Mon, 19 Apr 2021 18:24:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232005AbhDSSZG (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 19 Apr 2021 14:25:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230488AbhDSSZF (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 19 Apr 2021 14:25:05 -0400
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06DB0C06174A
        for <selinux@vger.kernel.org>; Mon, 19 Apr 2021 11:24:36 -0700 (PDT)
Received: by mail-oi1-x22a.google.com with SMTP id l17so5051688oil.11
        for <selinux@vger.kernel.org>; Mon, 19 Apr 2021 11:24:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=U8wv9W86Y+s8Gs6sOx13PU+77mTCymmaMidHMHRzacU=;
        b=oxDD//qmXNrlH4SOa97dszvuRZBv+tEPvD9+UTB6QRAAkR4sPupuX2aCvZYujl3Tp5
         UCW2gffpCu4TL769sYIaFdW2px8WDmQII93dBoGPOhmGiCtudmlfc0HW+dOZrsbZGibW
         z/tAiKFefJ71Jwb/DiYJt8CvH4OP5MrDRIVik9+SUoiNQQ+qmrrw8A4LIcFy4+xNiew8
         qIClN5tRGqL6j7dr4rNHBAlxriobAhLaaLE6OqUUM0TxpMaLlT/w23JHzZNImobD+HP+
         bC62+B0ZREh3lseAy7Ygnb8cJDUMIzxctZM4zIOZHCNO13BTpuRwgjLLxZOoQefE8jUk
         Mntw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=U8wv9W86Y+s8Gs6sOx13PU+77mTCymmaMidHMHRzacU=;
        b=S8k4sIc+09aB5KuUw/qHfhZ5yNbRk5S7oarTXmpFQHHzC0jtmmuw7MX6fIt2cazDO+
         ZpfcLcgUQ+b9KrEie70ieM+ZH9CDCe4VSaXIQ31Ox4MyJfQvc/gpsLllCoPnRjmXOVZ5
         kw23/WpW9A+tdRc1XBJ+ion3aH+3n3kurpcUGorGjcKMkAohz6XhaYyAR+uCyBRh8k1+
         69cX4lh8ljOmnqnnJ0i4FSR4C8S6qjEE6Lb53GW3K8IjTLPNFWOHJmEMJBTXZ1CAbYeO
         sbmQ6Wy7K916cDQkmgYcuFOLISjhLvAP0ubbbcb31Dhjn0XZr8UyFmn/ny/6zjIx6SLz
         ffYg==
X-Gm-Message-State: AOAM532kZK5rIUCWETgi9aQc8IvJDQc2drssf8YFiMoTgcL4ZHch4Gp2
        lbgEK8QEPTmX3vMAQ4Kp9OrIRKuc3jIeLmKuZ1Y=
X-Google-Smtp-Source: ABdhPJzQEbZ19lOJx9gQ5DTaGku/a9rgh3I27bgzhOjqsDTtAAv2OfWpwwqSfJzh2fh8Rp17/Vhc24JzxbLiGqwn/t0=
X-Received: by 2002:aca:5ad6:: with SMTP id o205mr295775oib.128.1618856675425;
 Mon, 19 Apr 2021 11:24:35 -0700 (PDT)
MIME-Version: 1.0
References: <20210408191614.262173-1-jwcart2@gmail.com> <CAP+JOzQo6qA9cd8a_KgDTLF3m0qip=WZaH482fG74BD6imQCCA@mail.gmail.com>
 <87lf9e9rgt.fsf@redhat.com>
In-Reply-To: <87lf9e9rgt.fsf@redhat.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Mon, 19 Apr 2021 14:24:24 -0400
Message-ID: <CAP+JOzQn+u9daDSmA1-uobnHrdW_VYoNH2eYHQYFBdKQBS0eZQ@mail.gmail.com>
Subject: Re: [PATCH 00/11] Various CIL patches
To:     Petr Lautrbach <plautrba@redhat.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Apr 19, 2021 at 12:20 PM Petr Lautrbach <plautrba@redhat.com> wrote:
>
> James Carter <jwcart2@gmail.com> writes:
>
> > On Thu, Apr 8, 2021 at 3:16 PM James Carter <jwcart2@gmail.com> wrote:
> >>
> >> All of these patches (except the first) have been sent to the list in the
> >> last month. The first patch is a slight modification of an earlier patch
> >> sent by Nicolas Iooss. I also corrected a couple of whitespace errors and
> >> updated one patch that would not apply cleanly with one of the earlier
> >> patches applied.
> >>
> >> James Carter (11):
> >>   libsepol/cil: Fix out-of-bound read of file context pattern ending
> >>     with "\"
> >>   libsepol/cil: Destroy classperms list when resetting classpermission
> >>   libsepol/cil: Destroy classperm list when resetting map perms
> >>   libsepol/cil: cil_reset_classperms_set() should not reset
> >>     classpermission
> >>   libsepol/cil: Set class field to NULL when resetting struct
> >>     cil_classperms
> >>   libsepol/cil: More strict verification of constraint leaf expressions
> >>   libsepol/cil: Exit with an error if declaration name is a reserved
> >>     word
> >>   libsepol/cil: Allow permission expressions when using map classes
> >>   libsepol/cil: Refactor helper function for cil_gen_node()
> >>   libsepol/cil: Create function cil_add_decl_to_symtab() and refactor
> >>   libsepol/cil: Move check for the shadowing of macro parameters
> >>
> >>  libsepol/cil/src/cil_build_ast.c | 132 ++++++++++++-------------------
> >>  libsepol/cil/src/cil_build_ast.h |   2 +
> >>  libsepol/cil/src/cil_copy_ast.c  |  26 +++---
> >>  libsepol/cil/src/cil_post.c      |  11 +++
> >>  libsepol/cil/src/cil_reset_ast.c |  11 ++-
> >>  libsepol/cil/src/cil_verify.c    |  78 +++++++++++++++++-
> >>  libsepol/cil/src/cil_verify.h    |   3 +-
> >>  7 files changed, 160 insertions(+), 103 deletions(-)
> >>
> >> --
> >> 2.26.3
> >>
> >
> > Most of these patches were sent out almost a month ago. I am planning
> > on merging them next week.
> > Jim
>
> I didn't check the content of the changes, but I ran a regression test
> suite we use in Red Hat on this and "Update checks for invalid rules in
> blocks" patchsets and it didn't discover any problem (just a minor
> trailing whitespace I reported last week)
>
> Acked-by: Petr Lautrbach <plautrba@redhat.com>
>
> I believe you can merge it/
>
> Thanks!
>
>
> Petr
>

I have merged both of these.
Thanks,
Jim
