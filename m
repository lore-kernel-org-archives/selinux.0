Return-Path: <SRS0=wECs=7L=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17C54C433E0
	for <selinux@archiver.kernel.org>; Fri, 29 May 2020 20:59:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DED3F20897
	for <selinux@archiver.kernel.org>; Fri, 29 May 2020 20:59:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="s7QpvN5/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727106AbgE2U70 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 29 May 2020 16:59:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727024AbgE2U70 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 29 May 2020 16:59:26 -0400
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B754C03E969
        for <selinux@vger.kernel.org>; Fri, 29 May 2020 13:59:26 -0700 (PDT)
Received: by mail-io1-xd33.google.com with SMTP id k18so864899ion.0
        for <selinux@vger.kernel.org>; Fri, 29 May 2020 13:59:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=6Tljq3aeIC0pDLwN+h7GURyOMxhZ0IQyuEXN87uKAEY=;
        b=s7QpvN5/CtQHiSRikbi7B2vHy9EfSXIrgKYshdyreXqYV3WA7z0KrA8dJ7OlkH3T63
         ZN41xbBLvdNwPCbyJDVi/dEw/Gr3ZIggKhyYppkaZtHzLxsLfwEY0ndThIyYnX2o1sKS
         dAifm3hfjjfEhMqE4/3nQC6DvjiPpNFl8DX7xOXmnwPZ6l1/GRcq1fQQ8cTdUR4TvR92
         KRJjuOZp1zwh81sZMedCHIFAux+2ifCG3IQaooCx9OipfTe2NvTv9PXjplt5N2QHETB3
         vpokkvKpqRylyM/3jsKbBJFAQH8a6WbzEfVxZ5K7A8ZX+5ahuHzW4zLZVBzo//V70NW6
         R2/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=6Tljq3aeIC0pDLwN+h7GURyOMxhZ0IQyuEXN87uKAEY=;
        b=m40OX0HT9ZIZUGm66J3Ta25gxz6vn2rtV9gP4hLn2e9N7K8UwfrOat4q44faQ1+AxA
         xDJV6rdfcH45WXLsquVcIOD00kiXmKvfzGSgDQzzeBtBJ0ksV1F9eI4JmVhuIO08sEO4
         LVWv1kDipbloJ3MftKCZ1bP+nNlxe0ejO7d/QClsLOEdZhEYtuk9aU1YS/+/EyvOECtn
         ymsyu0UmnTurys2w/Iq1QlGgHPfpGRqN8sSyT4uEKGIklKIR/5gbFbh4WjiMLd/Vo+Bp
         d/CmhWz3VNaXEpj1boHyRiKNVoEuM4Y9BNHZjpba4SpoJSMxkATgyszgbyQlSd4fUCb2
         wFRQ==
X-Gm-Message-State: AOAM532jiQs/qEPG9JF3HhjrI3ONMkWEvL2rvdoC0Lr1p9o79RgqU3mJ
        UZ6/OgQBnSuUgtphJ2UYiyRm1+vHUvfmIywkE0YbhExo
X-Google-Smtp-Source: ABdhPJxhGMc6V5JoMa59wlLZNSXPeRff4BJYwXmX3t0voC/5yMMeQ1LuP8306bORW62fK5y5KTegQwgk5O/OW+adDQ0=
X-Received: by 2002:a02:a99a:: with SMTP id q26mr8855367jam.61.1590785965238;
 Fri, 29 May 2020 13:59:25 -0700 (PDT)
MIME-Version: 1.0
References: <d0fd6970-7aa6-c576-fb8a-1d1293416e97@debian.org>
 <CAFftDdobT3E1MvFptyAKLBJ73KyrMOSS3m8DCnPX9+QF-Rk24Q@mail.gmail.com>
 <CAEjxPJ6XwXLBKYFaNO-kZz-Vgvbb2B7VKqD3DKQFf_ebBuNiBg@mail.gmail.com>
 <CAFftDdovpeFWnmKGDnTOY4AmwzSW0sCZoRwePX-q=NW1HV2c8w@mail.gmail.com>
 <CAEjxPJ5weFXrFpyjWdW7D4tgOnK+jHMyD37Zb4JFEzDt1rQ8Dw@mail.gmail.com>
 <CAFftDdr3A=rKcbzWcMDmz-XrqBTGd7mNbLLxt2vzU71DsqZ_9w@mail.gmail.com> <CAEjxPJ5N8Htq0uEekR7M7mt17_h7rRSzHU=kRBU_F02JfxO4ew@mail.gmail.com>
In-Reply-To: <CAEjxPJ5N8Htq0uEekR7M7mt17_h7rRSzHU=kRBU_F02JfxO4ew@mail.gmail.com>
From:   William Roberts <bill.c.roberts@gmail.com>
Date:   Fri, 29 May 2020 15:59:13 -0500
Message-ID: <CAFftDdoe0dYSCYrxVfCCeCKwtUHCwNkE2pLPSXONF6FT5dFTUA@mail.gmail.com>
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

On Fri, May 29, 2020 at 1:18 PM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Fri, May 29, 2020 at 1:15 PM William Roberts
> <bill.c.roberts@gmail.com> wrote:
> >
> > On Fri, May 29, 2020 at 11:40 AM Stephen Smalley
> > <stephen.smalley.work@gmail.com> wrote:
> > >
> > > On Fri, May 29, 2020 at 12:05 PM William Roberts
> > > <bill.c.roberts@gmail.com> wrote:
> > > >
> > > > On Fri, May 29, 2020 at 8:31 AM Stephen Smalley
> > > > <stephen.smalley.work@gmail.com> wrote:
> > > > >
> > > > > On Sat, May 23, 2020 at 11:59 AM William Roberts
> > > > > <bill.c.roberts@gmail.com> wrote:
> > > > > >
> > > > > > On Sat, May 23, 2020 at 5:57 AM Laurent Bigonville <bigon@debia=
n.org> wrote:
> > > > > > >
> > > > > > > Hello,
> > > > > > >
> > > > > > > The current build system of the userspace is setting a lot of=
 CFLAGS,
> > > > > > > but most of these are overridden by the distributions when bu=
ilding.
> > > > > > >
> > > > > > > Today I received a bug report[0] from Christian G=C3=B6ttsche=
 asking me to
> > > > > > > set -fno-semantic-interposition again in libsepol. I see also=
 the same
> > > > > > > flag and also a lot of others set in libselinux and libsemana=
ge build
> > > > > > > system.
> > > > > >
> > > > > > Why would it be again? The old DSO design made that option impo=
tent.
> > > > > > Clang does it by default.
> > > > > >
> > > > > > >
> > > > > > > For what I understand some of these are just needed for code =
quality
> > > > > > > (-W) and could be controlled by distributions but others migh=
t actually
> > > > > > > need to be always set (-f?).
> > > > > >
> > > > > > If you look at the Makefiles overall in all the projects, you'l=
l see hardening
> > > > > > flags, etc. Libsepol has a pretty minimal set compared to say l=
ibselinux, but
> > > > > > they all get overridden by build time CFLAGS if you want.
> > > > > >
> > > > > > >
> > > > > > > Shouldn't the flags that always need to be set (which ones?) =
be moved to
> > > > > > > a "override CFLAGS" directive to avoid these to be unset by d=
istributions?
> > > > > >
> > > > > > If you we're cleaver with CFLAGS before, you could acually circ=
umvent
> > > > > > the buildtime
> > > > > > DSO stuff. While i'm not opposed to adding it to immutable flag=
, if
> > > > > > you're setting
> > > > > > CFLAGS, you're on your own. At least with the current design.
> > > > > >
> > > > > > I have no issues with adding it to override, but we would have =
to
> > > > > > overhaul a bunch
> > > > > > of them and make them consistent.
> > > > >
> > > > > I'm inclined to agree with Laurent here - we should always set th=
is
> > > > > flag in order to preserve the same behavior prior to the patches =
that
> > > > > removed hidden_def/hidden_proto and switched to relying on this
> > > > > instead.
> > > >
> > > > Theirs a lot of features that rely on particular cflags, consider h=
ardening
> > > > options. A lot of the warnings/error stuff is not just a code hygie=
ne, but also
> > > > spotting potential issues that could arise as security issues. If o=
ne starts
> > > > tinkering with cflags, you can really change the code quite a bit. =
This is why
> > > > some places only approve sanctioned builds of crypto libraries.
> > >
> > > I think the difference here is that we made a change in the source
> > > code (hidden_def/hidden_proto removal) that requires use of
> > > -fno-semantic-interposition to preserve existing behavior.
> > >
> > > > But one of the things to consider is that for clang builds, clang
> > > > doesn't support
> > > > this option, so we would need to move the compiler checking code in=
to each
> > > > projects root makefile and ensure any consuming subordinate leafs a=
dd a
> > > > default, or move it to the global makefile and make sure each leaf =
that needs it
> > > > has a default.
> > >
> > > I think clang does support it now? https://reviews.llvm.org/D72724
> >
> > Yeah but that bug is all 2020 stuff. It is in the clang-10 release. I
> > verified that
> > with a local build from here:
> >   - https://apt.llvm.org/
> > So anything sub clang-10 won't support it, do you want to tie us to tha=
t
> > new of a clang?
>
> No, I guess not.  So I guess our options are to leave it alone and
> just make sure it is well documented or complicate the Makefiles.

Pretty much, which is why I go back to, "If your setting CFLAGS, you better
make sure you get em right". There are so many options and so many things
that can affect the build output, you really need to get em right.
This is the one area autoconf/automake is nice (I have a hate/hate
relationship with it),
but it does give one easy-peasy feature test macros, so this problem
is simple to fix.

The problem with documentation is no one reads it :-p. We could do somethin=
g
like issue a warning, compiler agnostic, from make if we don't detect the
-fsemantic-interposition option (easy). That would be simple, or I can
work up the
gcc/clang split patches (slightly harder).

Or we can just say, if your messing with CFLAGS do it right and you should
probably add -fsemantic-interposition if your using gcc documentation (easi=
est).

If they didn't change the CFLAGS for their build, they wouldn't have this i=
ssue.
Which brings up the question, "can they add the flags they need to the
Makefile?"
or "What do they need added/removed/changed in CFLAGS overall?"

I'd like to start with why they need to change CFLAGS, and can we just
make that the default?
