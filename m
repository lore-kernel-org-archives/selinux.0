Return-Path: <SRS0=qhvK=DJ=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 196EBC4363C
	for <selinux@archiver.kernel.org>; Fri,  2 Oct 2020 15:42:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D8C1220795
	for <selinux@archiver.kernel.org>; Fri,  2 Oct 2020 15:42:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726090AbgJBPmM (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 2 Oct 2020 11:42:12 -0400
Received: from mx1.polytechnique.org ([129.104.30.34]:47808 "EHLO
        mx1.polytechnique.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726176AbgJBPmJ (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 2 Oct 2020 11:42:09 -0400
Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by ssl.polytechnique.org (Postfix) with ESMTPSA id D550856079F
        for <selinux@vger.kernel.org>; Fri,  2 Oct 2020 17:42:05 +0200 (CEST)
Received: by mail-ot1-f41.google.com with SMTP id y5so1757898otg.5
        for <selinux@vger.kernel.org>; Fri, 02 Oct 2020 08:42:05 -0700 (PDT)
X-Gm-Message-State: AOAM532tfHECxgMGWez8qCg9zV0E//k4nD+joKyvXXUmZSzi/jiyDYnQ
        4crAS/3ugrTMtEwwnOmWgC46gqXt24XqO49eypw=
X-Google-Smtp-Source: ABdhPJzt/4qwQ9gQO5f72QoG18rWjjE4IcIfwVS38H0u5ulTBDyC5bcgkNcp8vEUKUr3p/DT+HvmXtCe6mw6vcJnFvw=
X-Received: by 2002:a9d:6e1:: with SMTP id 88mr2016905otx.279.1601653324786;
 Fri, 02 Oct 2020 08:42:04 -0700 (PDT)
MIME-Version: 1.0
References: <20200930145031.910190-1-plautrba@redhat.com> <20200930145031.910190-4-plautrba@redhat.com>
 <CAEjxPJ6PHe7DqYh6mLGu+mjMLY43r4tbQzoiXH0=wgSuyVSpcw@mail.gmail.com>
 <20200930155614.GA864960@fedora.redhat.com> <CAEjxPJ41ryHsDCnpX7qRLJNw5t=vYX_UEb1z=kW91O10Je6nDA@mail.gmail.com>
 <20201001165551.GA33342@localhost.localdomain> <CAEjxPJ7tsyBGm2hqiABF=HeJvX6PfWdT5BSn+L4-miqsqexo+A@mail.gmail.com>
 <20201001174837.GB33342@localhost.localdomain> <CAJfZ7=ksiWidL58wj2=qjvq4sWW9uxi-mF+YdZf_niuf8KHDBQ@mail.gmail.com>
 <CAEjxPJ4cca3sMyWv=ZeWGc62vt-=s+WhWFW0Y2g7nQeOX21C3g@mail.gmail.com>
In-Reply-To: <CAEjxPJ4cca3sMyWv=ZeWGc62vt-=s+WhWFW0Y2g7nQeOX21C3g@mail.gmail.com>
From:   Nicolas Iooss <nicolas.iooss@m4x.org>
Date:   Fri, 2 Oct 2020 17:41:53 +0200
X-Gmail-Original-Message-ID: <CAJfZ7=m5bwek=R_6gObMGdAKXNYSUwZU-rWv7EPAhw8SQU_vfg@mail.gmail.com>
Message-ID: <CAJfZ7=m5bwek=R_6gObMGdAKXNYSUwZU-rWv7EPAhw8SQU_vfg@mail.gmail.com>
Subject: Re: [PATCH 4/4] libsemanage: Bump libsemanage.so version
To:     Stephen Smalley <stephen.smalley.work@gmail.com>
Cc:     Petr Lautrbach <plautrba@redhat.com>,
        SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-AV-Checked: ClamAV using ClamSMTP at svoboda.polytechnique.org (Fri Oct  2 17:42:06 2020 +0200 (CEST))
X-Org-Mail: nicolas.iooss.2010@polytechnique.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Oct 2, 2020 at 4:50 PM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Fri, Oct 2, 2020 at 2:53 AM Nicolas Iooss <nicolas.iooss@m4x.org> wrote:
> >
> > Hello,
> > I have another question: why is bumping the .so version needed? As we
> > are not changing the ABI of a "linked symbol" (thanks to using
> > versioned symbols, with .map files), if we do not bump the .so
> > version, programs that were built with libsepol.so from years ago will
> > just stop working due to missing symbols, with an error message which
> > will be quite clear (and this only if they were using deprecated
> > symbols). In my humble opinion, bumping the .so version is most
> > required when the calling convention of a non-versioned symbol
> > changes, but this leads to unexpected execution paths.
> >
> > Nevertheless I did not spend time to search for a document that would
> > explain why bumping the .so version would be recommended when removing
> > symbols. If you know one, could you please add a reference to it in
> > the commit description ("Following guidelines from https://...) and/or
> > to some documentation?
> >
> > >From a "distro maintainer point of view" (for Arch Linux), having just
> > spent a considerable amount of time due to breaking changes in the
> > last release of PAM, I am not eager to spend time dealing with finding
> > clever ways to smoothly upgrade the system if there is no
> > easy&straightforward way to do this. Introducing a transition package
> > for each library which is bumped is acceptable to me, but if the
> > release after the next one bumps the version again, introducing
> > another set of transition packages will begin to be quite painful. In
> > short: I agree to remove the deprecated functions in order to "bump
> > the .so version only once", as suggested.
>
> My original understanding of library ABI compat requirements came from
> Ulrich Drepper's paper,
> https://www.akkadia.org/drepper/dsohowto.pdf
>
> Looks like Debian's policy is here:
> https://www.debian.org/doc/debian-policy/ch-sharedlibs.html#run-time-shared-libraries
>
> IIUC, if we follow the rules laid out by both, removing an old symbol
> version entirely is incompatible and requires a SONAME change.  That
> said, commit c3f9492d7ff05bdc8581817655ad05bc1e1174b8 ("selinux:
> Remove legacy local boolean and user code") was technically an
> incompatible change; it left the symbols in place but made them always
> fail or ignore no-longer-used parameters, which isn't truly
> compatible, and we didn't change the SONAMEs then.
>
> I'd personally be ok with not changing the SONAME as long as these
> interfaces were only ever used by the selinux userspace code itself or
> only by really ancient code that is no longer in use by any supported
> distribution but I don't think that flies with e.g. the Debian policy.

Thanks for the details. Debian policy makes sense and I agree with
bumping the version in the SONAME.

Nicolas

