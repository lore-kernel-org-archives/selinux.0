Return-Path: <SRS0=wECs=7L=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4544C433DF
	for <selinux@archiver.kernel.org>; Fri, 29 May 2020 17:15:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B27362074D
	for <selinux@archiver.kernel.org>; Fri, 29 May 2020 17:15:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WrBkbpNW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726907AbgE2RPs (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 29 May 2020 13:15:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726898AbgE2RPr (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 29 May 2020 13:15:47 -0400
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C10D2C03E969
        for <selinux@vger.kernel.org>; Fri, 29 May 2020 10:15:44 -0700 (PDT)
Received: by mail-io1-xd2f.google.com with SMTP id k18so173750ion.0
        for <selinux@vger.kernel.org>; Fri, 29 May 2020 10:15:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=6nM23MI8M02bwSPNiRL7KOQXREzwJEV3ED3HkTSIJKc=;
        b=WrBkbpNW9RMfFYX2JkrFPztzv9UuX678bm7f3MRQltHjR2/8SIPAl01hQ8puMHyGfH
         peJzh89IQ+fTI2jPb4fZ9/L0b8gbFIgJwWac1QhX5O/dKmW1SoRvUmjnz3y6cPzEiyuq
         x4HAm1ITxrk4ncs9z6WK7E6u0ngtj7Knh5lol/LwbiLhu+WDIr5ZIeb6lXeJiLQy3cyt
         AUP33mnUs/Xa9XeXGkbRqZlfv0DddEKMKX+KFUs0hTQZlFsrTrKTrB3q+PilJwfJo87l
         cBnoyk4bn9LJ0TDG2HGlpCo+wPAXkNCTvPR6642SfJ3n042vMzX2b0DYtv7Ff0fSWgZN
         t2AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=6nM23MI8M02bwSPNiRL7KOQXREzwJEV3ED3HkTSIJKc=;
        b=SSPrCjlC/qV2HfFDmOgghSMyZ5g8D6J2uZcXgbwlpxkzAU6NBpoJhKC8yQKzULMeBM
         ij+kn6xTZLXlK3fYbfruYwv5cPqUk0+MvN28GCXaqTwE2av1QFxRjwk2R9iT5QdwUf9N
         6lm6tnpHTU3p7eVWwVYA21AmUWWc0ctP0+h6c2/BadRNvi3JkqMg2CmM/UNPVL337KJH
         U5/DlL2iqs2pZPgYPWs+A2ixK67EZeJ2YcNpt3yeYUJhOUgkupaCH1zSUmAZeNoMWMel
         SdO85IAfeWQPyYTRGG4N/5e/0gLueow3ufLGmV+4gTNqpEOeJJ1NbPawf/P4u4XuTknd
         G+5w==
X-Gm-Message-State: AOAM531wiYvFG6fJPESwdogw+Jn7xEDiaMsxgiLDnZTXHs/XuTSpFC9L
        Yr2A1V/ZcEHuhUHoApdY2Mc9GSsXUVenblBbGFk=
X-Google-Smtp-Source: ABdhPJwveoTj/FFtSm0Nkesqrgv4g0s/AYjV7rgXbIcYPNPNDhOlDFXHuMJIPUffnwG35u0Wd5M0FZGj6Cvoiqfn6AE=
X-Received: by 2002:a02:a805:: with SMTP id f5mr8510496jaj.130.1590772542449;
 Fri, 29 May 2020 10:15:42 -0700 (PDT)
MIME-Version: 1.0
References: <d0fd6970-7aa6-c576-fb8a-1d1293416e97@debian.org>
 <CAFftDdobT3E1MvFptyAKLBJ73KyrMOSS3m8DCnPX9+QF-Rk24Q@mail.gmail.com>
 <CAEjxPJ6XwXLBKYFaNO-kZz-Vgvbb2B7VKqD3DKQFf_ebBuNiBg@mail.gmail.com>
 <CAFftDdovpeFWnmKGDnTOY4AmwzSW0sCZoRwePX-q=NW1HV2c8w@mail.gmail.com> <CAEjxPJ5weFXrFpyjWdW7D4tgOnK+jHMyD37Zb4JFEzDt1rQ8Dw@mail.gmail.com>
In-Reply-To: <CAEjxPJ5weFXrFpyjWdW7D4tgOnK+jHMyD37Zb4JFEzDt1rQ8Dw@mail.gmail.com>
From:   William Roberts <bill.c.roberts@gmail.com>
Date:   Fri, 29 May 2020 12:15:31 -0500
Message-ID: <CAFftDdr3A=rKcbzWcMDmz-XrqBTGd7mNbLLxt2vzU71DsqZ_9w@mail.gmail.com>
Subject: Re: CFLAGS overridden by distribution build system
To:     Stephen Smalley <stephen.smalley.work@gmail.com>
Cc:     Laurent Bigonville <bigon@debian.org>,
        SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, May 29, 2020 at 11:40 AM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Fri, May 29, 2020 at 12:05 PM William Roberts
> <bill.c.roberts@gmail.com> wrote:
> >
> > On Fri, May 29, 2020 at 8:31 AM Stephen Smalley
> > <stephen.smalley.work@gmail.com> wrote:
> > >
> > > On Sat, May 23, 2020 at 11:59 AM William Roberts
> > > <bill.c.roberts@gmail.com> wrote:
> > > >
> > > > On Sat, May 23, 2020 at 5:57 AM Laurent Bigonville <bigon@debian.or=
g> wrote:
> > > > >
> > > > > Hello,
> > > > >
> > > > > The current build system of the userspace is setting a lot of CFL=
AGS,
> > > > > but most of these are overridden by the distributions when buildi=
ng.
> > > > >
> > > > > Today I received a bug report[0] from Christian G=C3=B6ttsche ask=
ing me to
> > > > > set -fno-semantic-interposition again in libsepol. I see also the=
 same
> > > > > flag and also a lot of others set in libselinux and libsemanage b=
uild
> > > > > system.
> > > >
> > > > Why would it be again? The old DSO design made that option impotent=
.
> > > > Clang does it by default.
> > > >
> > > > >
> > > > > For what I understand some of these are just needed for code qual=
ity
> > > > > (-W) and could be controlled by distributions but others might ac=
tually
> > > > > need to be always set (-f?).
> > > >
> > > > If you look at the Makefiles overall in all the projects, you'll se=
e hardening
> > > > flags, etc. Libsepol has a pretty minimal set compared to say libse=
linux, but
> > > > they all get overridden by build time CFLAGS if you want.
> > > >
> > > > >
> > > > > Shouldn't the flags that always need to be set (which ones?) be m=
oved to
> > > > > a "override CFLAGS" directive to avoid these to be unset by distr=
ibutions?
> > > >
> > > > If you we're cleaver with CFLAGS before, you could acually circumve=
nt
> > > > the buildtime
> > > > DSO stuff. While i'm not opposed to adding it to immutable flag, if
> > > > you're setting
> > > > CFLAGS, you're on your own. At least with the current design.
> > > >
> > > > I have no issues with adding it to override, but we would have to
> > > > overhaul a bunch
> > > > of them and make them consistent.
> > >
> > > I'm inclined to agree with Laurent here - we should always set this
> > > flag in order to preserve the same behavior prior to the patches that
> > > removed hidden_def/hidden_proto and switched to relying on this
> > > instead.
> >
> > Theirs a lot of features that rely on particular cflags, consider harde=
ning
> > options. A lot of the warnings/error stuff is not just a code hygiene, =
but also
> > spotting potential issues that could arise as security issues. If one s=
tarts
> > tinkering with cflags, you can really change the code quite a bit. This=
 is why
> > some places only approve sanctioned builds of crypto libraries.
>
> I think the difference here is that we made a change in the source
> code (hidden_def/hidden_proto removal) that requires use of
> -fno-semantic-interposition to preserve existing behavior.
>
> > But one of the things to consider is that for clang builds, clang
> > doesn't support
> > this option, so we would need to move the compiler checking code into e=
ach
> > projects root makefile and ensure any consuming subordinate leafs add a
> > default, or move it to the global makefile and make sure each leaf that=
 needs it
> > has a default.
>
> I think clang does support it now? https://reviews.llvm.org/D72724

Yeah but that bug is all 2020 stuff. It is in the clang-10 release. I
verified that
with a local build from here:
  - https://apt.llvm.org/
So anything sub clang-10 won't support it, do you want to tie us to that
new of a clang?
