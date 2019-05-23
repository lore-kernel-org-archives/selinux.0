Return-Path: <SRS0=8MrU=TX=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE5BAC282DD
	for <selinux@archiver.kernel.org>; Thu, 23 May 2019 14:08:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA2A520863
	for <selinux@archiver.kernel.org>; Thu, 23 May 2019 14:08:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730601AbfEWOIf (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 23 May 2019 10:08:35 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:44043 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730323AbfEWOIf (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 23 May 2019 10:08:35 -0400
Received: by mail-ot1-f67.google.com with SMTP id g18so5495255otj.11
        for <selinux@vger.kernel.org>; Thu, 23 May 2019 07:08:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+AQbOxNVsVuJwDCvZNN0XTv7I2z3BC51YvCRtMnZQFs=;
        b=J6ICKQpSQl62Wcy18vu1+JTCSIE3o1auPPdZusOhlip0Rcrah6yckywUV0nApi7Rxn
         cla7k+21nmRejmXnngMja7h1VgcNEoV3fbxVGGoXPzcxp6qD41Yrqb9GtehzVu4WPZnt
         +aot5qoWDadeGu3NBUwVWeFlRrNMsvFRH+Z+vwc7Q1PKMP0cCRg0EN8cmb8QLHyB9isp
         IfKVYL1x4BCPJQA6Z32mHGg4POz+9waDLf2lW87dRiN8Wy8hK2YJKeOW8+m6NsHpMm69
         Py53l5/2GiaWGL9T670ylXCUIs866NWMzuYXiyJ4bGCvbIv9fsxuTB8tpFSRR9+67a8U
         aACw==
X-Gm-Message-State: APjAAAWdRcF/5Q9jrRaqZyEVMnNFzQ27iCgkYZ4bkdZyX8c/lzFg32pd
        V6cx2MuMtns74C84wJC6jKsTXpMmZistJbL5XC5uhA==
X-Google-Smtp-Source: APXvYqwuJFJuY8XGi8icDcQ2AqvFwGxSmcZoRihUdzCXxr85ddp7cUhPMvI4RY4ndQ3gCkoyIWpqf8JXAwwdAdZM19c=
X-Received: by 2002:a9d:6a8a:: with SMTP id l10mr8397991otq.197.1558620513871;
 Thu, 23 May 2019 07:08:33 -0700 (PDT)
MIME-Version: 1.0
References: <20190523102449.9621-1-omosnace@redhat.com> <20190523131455.GA30512@brutus.lan>
 <20190523133947.GB30512@brutus.lan>
In-Reply-To: <20190523133947.GB30512@brutus.lan>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Thu, 23 May 2019 16:08:22 +0200
Message-ID: <CAFqZXNv0cWnp3urHhCowFVKiypzsb52a2+dQ4G+0cjRdcEUwAg@mail.gmail.com>
Subject: Re: [PATCH userspace 0/4] Remove redundant rules when building policydb
To:     Dominick Grift <dac.override@gmail.com>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, May 23, 2019 at 3:40 PM Dominick Grift <dac.override@gmail.com> wrote:
> On Thu, May 23, 2019 at 03:14:55PM +0200, Dominick Grift wrote:
> > On Thu, May 23, 2019 at 12:24:45PM +0200, Ondrej Mosnacek wrote:
> > > This series implements an optional optimization step when building
> > > a policydb via semodule or secilc, which identifies and removes rules
> > > that are redundant -- i.e. they are already covered by a more general
> > > rule based on attribute inheritance.
> >
> > Some stats with dssp2-standard:
> >
> > [kcinimod@myguest dssp2-standard]$ time secilc -n `find . -name *.cil` -o policy.31.noopt
> >
> > real    0m9.278s
> > user    0m7.036s
> > sys     0m2.017s
> > [kcinimod@myguest dssp2-standard]$ time secilc `find . -name *.cil` -o policy.31.opt
> >
> > real    0m19.343s
> > user    0m16.939s
> > sys     0m2.027s
> > [kcinimod@myguest dssp2-standard]$ ls -lh policy.*
> > -rw-rw-r--. 1 kcinimod kcinimod 2.4M May 23 15:11 policy.31.noopt
> > -rw-rw-r--. 1 kcinimod kcinimod 2.3M May 23 15:12 policy.31.opt
> >
> > Was unable to see the actual diff as sediff got oom-killed on me
>
> According to percentage calculator thats roughly a 4 percent gain size-wise at a 47 percent performance penalty.
> Looks like dssp2-standard is pretty efficient as it is.

Hmm, yeah, looks like I'll have to make it opt-in after all... or add
some heuristic to decide if running the optimization is really worth
it.

>
> >
> > >
> > > Since the performance penalty of this additional step is very small
> > > (it adds about 1 s to the current running time of ~20-30 s [1]) and
> > > it can have a big positive effect on the number of rules in policy
> > > (it manages to remove ~40% AV rules from Fedora 29 policy), the
> > > optimization is enabled by default and can be turned off using a
> > > command-line option (--no-optimize) in secilc and semodule [2].
> > >
> > > The optimization routine eliminates:
> > >  * all allow/neverallow/dontaudit/auditallow rules (including xperm
> > >    variants) that are covered by another more general rule,
> > >  * all conditional versions of the above rules that are covered by a
> > >    more general rule either in the unconditional table or in the same
> > >    branch of the same conditional.
> > >
> > > The optimization doesn't process other rules, since they currently
> > > do not support attributes. There is some room left for more precise
> > > optimization of conditional rules, but it would likely bring only
> > > little additional benefit.
> > >
> > > When the policy is mostly or fully expanded, the optimization should
> > > be turned off. If it isn't, the policy build time will increase a lot
> > > for no benefit. However, the complexity of optimization will be only
> > > linear w.r.t. the number of rules and so the impact should not be
> > > catastrophic. (When testing with secilc on a subset of Fedora policy
> > > with -X 100000 the build time was 1.7 s with optimization vs. 1 s
> > > without it.)
> > >
> > > Tested live on my Fedora 29 devel machine under normal use. No unusual
> > > AVCs were observed with optimized policy loaded.
> > >
> > > Travis build passed: https://travis-ci.org/WOnder93/selinux/builds/536157427
> > >
> > > NOTE: The xperm rule support wasn't tested -- I would welcome some
> > >       peer review/testing of this part.
> > >
> > > [1] As measured on my machine (Fedora 29 policy, x86_64).
> > > [2] I have no problem with switching it to opt-in if that is preferred.
> > >
> > > Ondrej Mosnacek (4):
> > >   libsepol: add a function to optimize kernel policy
> > >   secilc: optimize policy before writing
> > >   libsemanage: optimize policy on rebuild
> > >   semodule: add flag to disable policy optimization
> > >
> > >  libsemanage/include/semanage/handle.h      |   4 +
> > >  libsemanage/src/direct_api.c               |   7 +
> > >  libsemanage/src/handle.c                   |  13 +
> > >  libsemanage/src/handle.h                   |   1 +
> > >  libsemanage/src/libsemanage.map            |   5 +
> > >  libsepol/include/sepol/policydb.h          |   5 +
> > >  libsepol/include/sepol/policydb/policydb.h |   2 +
> > >  libsepol/src/libsepol.map.in               |   5 +
> > >  libsepol/src/optimize.c                    | 370 +++++++++++++++++++++
> > >  libsepol/src/policydb_public.c             |   5 +
> > >  policycoreutils/semodule/semodule.c        |  12 +-
> > >  secilc/secilc.c                            |  16 +-
> > >  12 files changed, 442 insertions(+), 3 deletions(-)
> > >  create mode 100644 libsepol/src/optimize.c
> > >
> > > --
> > > 2.20.1
> > >
> >
> > --
> > Key fingerprint = 5F4D 3CDB D3F8 3652 FBD8 02D5 3B6C 5F1D 2C7B 6B02
> > https://sks-keyservers.net/pks/lookup?op=get&search=0x3B6C5F1D2C7B6B02
> > Dominick Grift
>
>
>
> --
> Key fingerprint = 5F4D 3CDB D3F8 3652 FBD8 02D5 3B6C 5F1D 2C7B 6B02
> https://sks-keyservers.net/pks/lookup?op=get&search=0x3B6C5F1D2C7B6B02
> Dominick Grift



-- 
Ondrej Mosnacek <omosnace at redhat dot com>
Software Engineer, Security Technologies
Red Hat, Inc.
