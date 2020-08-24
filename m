Return-Path: <SRS0=rjXy=CC=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F4ABC433E3
	for <selinux@archiver.kernel.org>; Mon, 24 Aug 2020 14:15:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 72BA6206F0
	for <selinux@archiver.kernel.org>; Mon, 24 Aug 2020 14:15:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EafwTqMx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726138AbgHXOPn (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 24 Aug 2020 10:15:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726086AbgHXOPi (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 24 Aug 2020 10:15:38 -0400
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com [IPv6:2607:f8b0:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B404BC061573
        for <selinux@vger.kernel.org>; Mon, 24 Aug 2020 07:15:38 -0700 (PDT)
Received: by mail-ot1-x32a.google.com with SMTP id h16so7398301oti.7
        for <selinux@vger.kernel.org>; Mon, 24 Aug 2020 07:15:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fuGu2i8CF9Ys0gGkXZV6L3m80UZuKrRrjlBajOLl6YY=;
        b=EafwTqMxXFDxv4BGOUgFflriFvQUXirdtAQ+PSRceAGV8lH9zmmbDSotRXD53br//d
         ftj80+70W1JHzsi8Q0lbEoJAYZ6OOOM4goDdCcj6e7xXsyEE56xd2/XIO4vZM1y3XjGY
         3OAEZAevQ+pzpyIJfRBylvw5UasVhYExclk5p9XmN7lW/e0/N1v4jXyGUKdpu6YctEpd
         SiWleHRJa7v9GlyQBdpGr+tvz0DUnSCgOCiS4Fuhwa2S5SZuodkcIrUwWZJCFngQaDZg
         EHMxAhTS9Hh4hjd4LZpQI6HdMMXD5M2UbfWhzJdPgCUF0nmb9KIObpBWQqpUqgCec6dC
         EhtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fuGu2i8CF9Ys0gGkXZV6L3m80UZuKrRrjlBajOLl6YY=;
        b=RhXxQc2opDbG1m4aERd3PaVyTGE2+8sAu9UqsbuMfGkm9gFROc4hZt27kXe1BIlU3R
         LE19TAsRUMyZhLz6DaIqTtch/IqmnHzainBjTlUlWSLT6AeUPdLzY3kYPryeCHryiZCR
         A47x+WPYtX1JzYM1irFAnYROrj87k6J2PKuKMMpMlEmZ3XNAZzdAWxxmJaxSO/INm3uS
         fXkwVjt96xZuqA12A1W/f2RIVvLBqaYiJishzBv2GMDNg5MnU8EZrR5YCpkNmZSfm2Jr
         UwVrltvMALKEy9PIgSJviXeEel5TDsGULLeTmTA32gILdkEY48N76ihqKAxMaSougZE1
         z82w==
X-Gm-Message-State: AOAM531r8iO1vGUZb9mRPsxV1Ghw+MRPpZlMVnO/RKW9hf4jRTSXvHRK
        3NT7196zmRd/xr9OMT7qWYcLLbSsXYceeHqn/3z6x4dsuu4=
X-Google-Smtp-Source: ABdhPJyqgru5YMa7kB4+aiPn+6cRJKTIM+eF61rDyG8a0gDGbQ8UVEILp7XGdB/J56zxMvP3wqbSb8vBiUX6saiWdEQ=
X-Received: by 2002:a05:6830:16d8:: with SMTP id l24mr3470351otr.89.1598278538123;
 Mon, 24 Aug 2020 07:15:38 -0700 (PDT)
MIME-Version: 1.0
References: <CAEjxPJ7khd7dprzEKgc5zeyaHWWRQ7P8pOg09LtiBVaOi6jYTg@mail.gmail.com>
 <20200813174722.GA14310@localhost.localdomain> <CAEjxPJ6_V9Uo7XwY89WKX9NBp4ACd5Sn3m7pDf2n+hYH0QYkMw@mail.gmail.com>
 <20200818134036.GB26265@localhost.localdomain>
In-Reply-To: <20200818134036.GB26265@localhost.localdomain>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Mon, 24 Aug 2020 10:15:27 -0400
Message-ID: <CAEjxPJ5U4tGTwiPA9+ZCA_DJ88vO8YpAJmUNhfgEJNuaug_hBA@mail.gmail.com>
Subject: Re: drop symbol versioning from libsepol and libsemanage?
To:     Petr Lautrbach <plautrba@redhat.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Aug 18, 2020 at 9:40 AM Petr Lautrbach <plautrba@redhat.com> wrote:
>
> On Thu, Aug 13, 2020 at 01:56:57PM -0400, Stephen Smalley wrote:
> > On Thu, Aug 13, 2020 at 1:47 PM Petr Lautrbach <plautrba@redhat.com> wrote:
> > >
> > > On Fri, Aug 07, 2020 at 02:54:18PM -0400, Stephen Smalley wrote:
> > > > As noted in https://github.com/SELinuxProject/selinux/issues/245,
> > > > symbol versioning in libsepol causes problems for LTO.  libsepol and
> > > > libsemanage have a handful of versioned symbols due to incompatible
> > > > ABI changes made early in the CIL integration.  However, as far as I
> > > > can tell, these symbols were only used by other components of the
> > > > selinux userspace, not externally.  Should we stop supporting the old
> > > > versions going forward and simplify the maps? If so, does this truly
> > > > require bumping the .so version or can we omit that since there are no
> > > > external users?  Thoughts?
> > > >
> > >
> > > AFAIK libsemanage is used by some 3rd parties. We've had requests to ship
> > > libsemanage-devel in RHEL-8 repositories in order customers build their
> > > applications.
> > >
> > >
> > > From my packager POV I like symbol versioning - it helps to prevent some
> > > dependency issues in development branches, e.g. when libsemanage is built with
> > > new libsepol symbol but the new package doesn't require newer libsepol. rpm is
> > > able to solve that:
> > >
> > > $ rpm -q --requires libsemanage
> > > ...
> > > libselinux(x86-64) >= 3.1-2
> > > libselinux.so.1()(64bit)
> > > libselinux.so.1(LIBSELINUX_1.0)(64bit)
> > > libsepol.so.1()(64bit)
> > > libsepol.so.1(LIBSEPOL_1.0)(64bit)
> > > libsepol.so.1(LIBSEPOL_1.1)(64bit)
> > > libsepol.so.1(LIBSEPOL_3.0)(64bit)
> > > ...
> > >
> > > $ rpm -q --provides libsemanage
> > > config(libsemanage) = 3.1-2.fc33
> > > libsemanage = 3.1-2.fc33
> > > libsemanage(x86-64) = 3.1-2.fc33
> > > libsemanage.so.1()(64bit)
> > > libsemanage.so.1(LIBSEMANAGE_1.0)(64bit)
> > > libsemanage.so.1(LIBSEMANAGE_1.1)(64bit)
> > >
> > >
> > > LTO seems to cause problems to other projects as well
> > > https://lists.fedoraproject.org/archives/list/devel@lists.fedoraproject.org/message/XMIQMN5KNAZUPX6O3LN6JJGTCZTP4B7J/
> > >
> > > So I'd prefer if we try to do and use symbol versioning correctly, but it's not
> > > hard requirement from my side.
> >
> > Ok.  An alternative to dropping it altogether is just to try to fix
> > the particular problem he is seeing with the duplicated symbols in
> > LIBSEPOL_1_0 and LIBSEPOL_1_1.  If we can remove the duplicate without
> > breaking anything, then that might suffice for LTO.  I'm not actually
> > clear on whether it is correct - there are technically two different
> > versions of the symbol aliased via symver.  If the seeming duplicate
> > is required then I guess we just have to wait for LTO support to catch
> > up with symbol versioning.
> >
>
> In this particular case I'd drop duplicate symbols from libsepol. It's about 4
> years and 5 releases since it was added and it would slightly clean the code. It
> would be properly announced in release notes. And if there's anybody else then
> libsemage who uses it they would need either to rebuild their sources or stay
> with the current version.

Not entirely sure what this means.  We can do either of the following options:

1.  Just remove the duplicated symbol names from libsepol.map.in (i.e.
only define them once in either LIBSEPOL_1.0 or LIBSEPOL_1.1 not in
both).  That might solve the problem for LTO without creating any
compatibility issues for non-LTO; I'm not sure.

-or-

2. Get rid of the duplicated symbols in libsepol.map.in AND drop the
old symbol definitions and the old functions from cil/src/cil.c,
renaming the new symbols to the exported name and dropping use of
symver there.  This is an ABI change for libsepol but likely only
affects libsemanage. If we do this, do we bump its .so version to
reflect the incompatible change?
