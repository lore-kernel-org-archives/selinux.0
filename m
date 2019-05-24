Return-Path: <SRS0=UID1=TY=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86946C072B5
	for <selinux@archiver.kernel.org>; Fri, 24 May 2019 20:04:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58271217D7
	for <selinux@archiver.kernel.org>; Fri, 24 May 2019 20:04:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391765AbfEXUEm (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 24 May 2019 16:04:42 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:44058 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391612AbfEXUEm (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 24 May 2019 16:04:42 -0400
Received: by mail-ot1-f65.google.com with SMTP id g18so9755489otj.11
        for <selinux@vger.kernel.org>; Fri, 24 May 2019 13:04:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UzIKL6jhHH7nEddh9cOjgUt4cKUIGQyWWtvgA/0X0yk=;
        b=mOB7uVfGbVo4SULtenp6iIpo9H3PVxTLRM2ZU1+B7HzDrCz9An2w3ZiUEIznQyUmqO
         n9yDjq5T9ZJM0c/WMyC6yF8BkhvutFuYvyRQ3Dw5S1X8E3T/ft02F2BgstRqNkriSnsK
         OBx5DUknyfJZgcrLyb0Bjw82GOtkCEW/ZptzogLLv3eFLAM2JTbmER83RkszyQRpjmoF
         TsYUlCRX1sMK4rixqpasSTwdtj5+7uth3m1gvPOJ26ITizbV8bc81jfTVe9JYx7TCzB2
         0ZpE+t8wtnClMixhWM/codX3nGdNBHEg0g484jW0UMpZ0Nnx77AwGjF3oyiFNJYE6yIr
         xhew==
X-Gm-Message-State: APjAAAXMp92cJiIrDqMXgFkPXMPRc87Y4P6FGAt65+Uq5n2XPhY2PCEm
        hb1r1axTtMbAk4PU3f8lAN+7wHmfXE1h1JuDIwYYhQ==
X-Google-Smtp-Source: APXvYqzO159d8hb33Kv9kJs/xXW56nkNgAye6ULACk38hNuq7mDSYkU9/mOgfbTGwGtqxkeKQjCNhjONJQ9HWiFYY6I=
X-Received: by 2002:a9d:6a8a:: with SMTP id l10mr13819011otq.197.1558728281598;
 Fri, 24 May 2019 13:04:41 -0700 (PDT)
MIME-Version: 1.0
References: <20190523102449.9621-1-omosnace@redhat.com> <20190523131455.GA30512@brutus.lan>
 <20190523133947.GB30512@brutus.lan> <CAFqZXNv0cWnp3urHhCowFVKiypzsb52a2+dQ4G+0cjRdcEUwAg@mail.gmail.com>
 <1c3321c9-f7d2-815a-c288-07ae7409b8d8@tycho.nsa.gov>
In-Reply-To: <1c3321c9-f7d2-815a-c288-07ae7409b8d8@tycho.nsa.gov>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Fri, 24 May 2019 22:04:30 +0200
Message-ID: <CAFqZXNv0QziNYgN0miinGAgX71UO+u0uGZt_U9BMoWbsX7Ns3Q@mail.gmail.com>
Subject: Re: [Non-DoD Source] Re: [PATCH userspace 0/4] Remove redundant rules
 when building policydb
To:     jwcart2 <jwcart2@tycho.nsa.gov>
Cc:     Dominick Grift <dac.override@gmail.com>, selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, May 24, 2019 at 6:02 PM jwcart2 <jwcart2@tycho.nsa.gov> wrote:
> On 5/23/19 10:08 AM, Ondrej Mosnacek wrote:
> > On Thu, May 23, 2019 at 3:40 PM Dominick Grift <dac.override@gmail.com> wrote:
> >> On Thu, May 23, 2019 at 03:14:55PM +0200, Dominick Grift wrote:
> >>> On Thu, May 23, 2019 at 12:24:45PM +0200, Ondrej Mosnacek wrote:
> >>>> This series implements an optional optimization step when building
> >>>> a policydb via semodule or secilc, which identifies and removes rules
> >>>> that are redundant -- i.e. they are already covered by a more general
> >>>> rule based on attribute inheritance.
> >>>
> >>> Some stats with dssp2-standard:
> >>>
> >>> [kcinimod@myguest dssp2-standard]$ time secilc -n `find . -name *.cil` -o policy.31.noopt
> >>>
> >>> real    0m9.278s
> >>> user    0m7.036s
> >>> sys     0m2.017s
> >>> [kcinimod@myguest dssp2-standard]$ time secilc `find . -name *.cil` -o policy.31.opt
> >>>
> >>> real    0m19.343s
> >>> user    0m16.939s
> >>> sys     0m2.027s
> >>> [kcinimod@myguest dssp2-standard]$ ls -lh policy.*
> >>> -rw-rw-r--. 1 kcinimod kcinimod 2.4M May 23 15:11 policy.31.noopt
> >>> -rw-rw-r--. 1 kcinimod kcinimod 2.3M May 23 15:12 policy.31.opt
> >>>
> >>> Was unable to see the actual diff as sediff got oom-killed on me
> >>
> >> According to percentage calculator thats roughly a 4 percent gain size-wise at a 47 percent performance penalty.
> >> Looks like dssp2-standard is pretty efficient as it is.
> >
> > Hmm, yeah, looks like I'll have to make it opt-in after all... or add
> > some heuristic to decide if running the optimization is really worth
> > it.
> >
>
> Opt-in makes sense. How about just using 'O' for the option?

Sure, I already have patches to convert to opt-in ready in my devel
branch [1]. Expect them to be incorporated in v2 respin.

[1] https://github.com/WOnder93/selinux/compare/master...optimize-policy-v2

>
> Jim
>
> >>
> >>>
> >>>>
> >>>> Since the performance penalty of this additional step is very small
> >>>> (it adds about 1 s to the current running time of ~20-30 s [1]) and
> >>>> it can have a big positive effect on the number of rules in policy
> >>>> (it manages to remove ~40% AV rules from Fedora 29 policy), the
> >>>> optimization is enabled by default and can be turned off using a
> >>>> command-line option (--no-optimize) in secilc and semodule [2].
> >>>>
> >>>> The optimization routine eliminates:
> >>>>   * all allow/neverallow/dontaudit/auditallow rules (including xperm
> >>>>     variants) that are covered by another more general rule,
> >>>>   * all conditional versions of the above rules that are covered by a
> >>>>     more general rule either in the unconditional table or in the same
> >>>>     branch of the same conditional.
> >>>>
> >>>> The optimization doesn't process other rules, since they currently
> >>>> do not support attributes. There is some room left for more precise
> >>>> optimization of conditional rules, but it would likely bring only
> >>>> little additional benefit.
> >>>>
> >>>> When the policy is mostly or fully expanded, the optimization should
> >>>> be turned off. If it isn't, the policy build time will increase a lot
> >>>> for no benefit. However, the complexity of optimization will be only
> >>>> linear w.r.t. the number of rules and so the impact should not be
> >>>> catastrophic. (When testing with secilc on a subset of Fedora policy
> >>>> with -X 100000 the build time was 1.7 s with optimization vs. 1 s
> >>>> without it.)
> >>>>
> >>>> Tested live on my Fedora 29 devel machine under normal use. No unusual
> >>>> AVCs were observed with optimized policy loaded.
> >>>>
> >>>> Travis build passed: https://travis-ci.org/WOnder93/selinux/builds/536157427
> >>>>
> >>>> NOTE: The xperm rule support wasn't tested -- I would welcome some
> >>>>        peer review/testing of this part.
> >>>>
> >>>> [1] As measured on my machine (Fedora 29 policy, x86_64).
> >>>> [2] I have no problem with switching it to opt-in if that is preferred.
> >>>>
> >>>> Ondrej Mosnacek (4):
> >>>>    libsepol: add a function to optimize kernel policy
> >>>>    secilc: optimize policy before writing
> >>>>    libsemanage: optimize policy on rebuild
> >>>>    semodule: add flag to disable policy optimization
> >>>>
> >>>>   libsemanage/include/semanage/handle.h      |   4 +
> >>>>   libsemanage/src/direct_api.c               |   7 +
> >>>>   libsemanage/src/handle.c                   |  13 +
> >>>>   libsemanage/src/handle.h                   |   1 +
> >>>>   libsemanage/src/libsemanage.map            |   5 +
> >>>>   libsepol/include/sepol/policydb.h          |   5 +
> >>>>   libsepol/include/sepol/policydb/policydb.h |   2 +
> >>>>   libsepol/src/libsepol.map.in               |   5 +
> >>>>   libsepol/src/optimize.c                    | 370 +++++++++++++++++++++
> >>>>   libsepol/src/policydb_public.c             |   5 +
> >>>>   policycoreutils/semodule/semodule.c        |  12 +-
> >>>>   secilc/secilc.c                            |  16 +-
> >>>>   12 files changed, 442 insertions(+), 3 deletions(-)
> >>>>   create mode 100644 libsepol/src/optimize.c
> >>>>
> >>>> --
> >>>> 2.20.1
> >>>>
> >>>
> >>> --
> >>> Key fingerprint = 5F4D 3CDB D3F8 3652 FBD8 02D5 3B6C 5F1D 2C7B 6B02
> >>> https://sks-keyservers.net/pks/lookup?op=get&search=0x3B6C5F1D2C7B6B02
> >>> Dominick Grift
> >>
> >>
> >>
> >> --
> >> Key fingerprint = 5F4D 3CDB D3F8 3652 FBD8 02D5 3B6C 5F1D 2C7B 6B02
> >> https://sks-keyservers.net/pks/lookup?op=get&search=0x3B6C5F1D2C7B6B02
> >> Dominick Grift
> >
> >
> >
>
>
> --
> James Carter <jwcart2@tycho.nsa.gov>
> National Security Agency



-- 
Ondrej Mosnacek <omosnace at redhat dot com>
Software Engineer, Security Technologies
Red Hat, Inc.
