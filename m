Return-Path: <SRS0=wECs=7L=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 081A7C433E0
	for <selinux@archiver.kernel.org>; Fri, 29 May 2020 18:18:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D5AA62074D
	for <selinux@archiver.kernel.org>; Fri, 29 May 2020 18:18:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dKVU/qo4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725865AbgE2SSx (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 29 May 2020 14:18:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725839AbgE2SSw (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 29 May 2020 14:18:52 -0400
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9690BC03E969
        for <selinux@vger.kernel.org>; Fri, 29 May 2020 11:18:52 -0700 (PDT)
Received: by mail-oi1-x233.google.com with SMTP id m67so3426847oif.4
        for <selinux@vger.kernel.org>; Fri, 29 May 2020 11:18:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=NtytoMKrGjuZkNAiozNVwKSu45dkNFdNMYy7oBi1nAI=;
        b=dKVU/qo4xTvW8zYRkMctZ35dzpq4pwOkvQNDOw/iIpOBaBzKvNlaiz2i8FqIyvW47e
         jpPg1N89yKNmCTWkx75z8zbujUjpHzf9lZLqaGWthHalRxK42TzbiXeFYMTJwXVTfrq0
         x/bF12Pl56Db2JCZGE4mjf6Qu7KlV/m3j2ubq8K+B8JWnWYukbf/vfTke9+CDSAd88B0
         qwsZrmgQukKbbzHrS4ZpuRojhRZtQXs2+9UvGV8GJVEh4Bo+O/ul/s+vdBcz0viul5j4
         QJrJdKBw+nJ3+vHF9aBY8CB/14xbePVu/8PJU9epN9cNmzzVWZok3iuGVdVNrSZFlEK5
         e3HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=NtytoMKrGjuZkNAiozNVwKSu45dkNFdNMYy7oBi1nAI=;
        b=B3VJXuZyU2nrdCPzTGshg7VN/K01v0TqnzbK+m1nN1/JB1T9/XNfQSBX7mDObiymS+
         qmnu6FfDollgoSc+PT3GoJ7I9QJOvzvi38OaZeBQxlEVda2yGk0vQ3FZVAtW0pkPttYn
         0QJoTKtUFixcXBPpjN4CgOAjNCvbxC+rBzGEekDMOQw3X6V+rQX6eFh6m2YTAsIqHvFa
         6IG8FdjMBUqg+AWim7p35B+YsDPOfIDf92CgSutmlpTeLt/ivxHzSbhFGphPR4hGijvI
         ZtIR8nQom4zOR0BxmJrg7S+yKG0RQcCbbn/6KDtu7YynjnnFV2wGlCgbCy8mnF9RTHyQ
         BuCA==
X-Gm-Message-State: AOAM531o7hpFgKkgdGanzMeoGKelLbJOU1N0+D/bfWURIacMTk2KSs+w
        0luqQRMof+Vl+iRbr+0aeagphKkQyKTBD3FMFco=
X-Google-Smtp-Source: ABdhPJxRw+nDG/UiGNZm5PQ22H6O+/Wn7oRdTVk6SH4OmddPUuJNo/T/SJvjRywNGzGJiArX/vzAg1KqTWDsvOHECAM=
X-Received: by 2002:aca:3d09:: with SMTP id k9mr6540950oia.160.1590776327125;
 Fri, 29 May 2020 11:18:47 -0700 (PDT)
MIME-Version: 1.0
References: <d0fd6970-7aa6-c576-fb8a-1d1293416e97@debian.org>
 <CAFftDdobT3E1MvFptyAKLBJ73KyrMOSS3m8DCnPX9+QF-Rk24Q@mail.gmail.com>
 <CAEjxPJ6XwXLBKYFaNO-kZz-Vgvbb2B7VKqD3DKQFf_ebBuNiBg@mail.gmail.com>
 <CAFftDdovpeFWnmKGDnTOY4AmwzSW0sCZoRwePX-q=NW1HV2c8w@mail.gmail.com>
 <CAEjxPJ5weFXrFpyjWdW7D4tgOnK+jHMyD37Zb4JFEzDt1rQ8Dw@mail.gmail.com> <CAFftDdr3A=rKcbzWcMDmz-XrqBTGd7mNbLLxt2vzU71DsqZ_9w@mail.gmail.com>
In-Reply-To: <CAFftDdr3A=rKcbzWcMDmz-XrqBTGd7mNbLLxt2vzU71DsqZ_9w@mail.gmail.com>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Fri, 29 May 2020 14:18:35 -0400
Message-ID: <CAEjxPJ5N8Htq0uEekR7M7mt17_h7rRSzHU=kRBU_F02JfxO4ew@mail.gmail.com>
Subject: Re: CFLAGS overridden by distribution build system
To:     William Roberts <bill.c.roberts@gmail.com>
Cc:     Laurent Bigonville <bigon@debian.org>,
        SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, May 29, 2020 at 1:15 PM William Roberts
<bill.c.roberts@gmail.com> wrote:
>
> On Fri, May 29, 2020 at 11:40 AM Stephen Smalley
> <stephen.smalley.work@gmail.com> wrote:
> >
> > On Fri, May 29, 2020 at 12:05 PM William Roberts
> > <bill.c.roberts@gmail.com> wrote:
> > >
> > > On Fri, May 29, 2020 at 8:31 AM Stephen Smalley
> > > <stephen.smalley.work@gmail.com> wrote:
> > > >
> > > > On Sat, May 23, 2020 at 11:59 AM William Roberts
> > > > <bill.c.roberts@gmail.com> wrote:
> > > > >
> > > > > On Sat, May 23, 2020 at 5:57 AM Laurent Bigonville <bigon@debian.=
org> wrote:
> > > > > >
> > > > > > Hello,
> > > > > >
> > > > > > The current build system of the userspace is setting a lot of C=
FLAGS,
> > > > > > but most of these are overridden by the distributions when buil=
ding.
> > > > > >
> > > > > > Today I received a bug report[0] from Christian G=C3=B6ttsche a=
sking me to
> > > > > > set -fno-semantic-interposition again in libsepol. I see also t=
he same
> > > > > > flag and also a lot of others set in libselinux and libsemanage=
 build
> > > > > > system.
> > > > >
> > > > > Why would it be again? The old DSO design made that option impote=
nt.
> > > > > Clang does it by default.
> > > > >
> > > > > >
> > > > > > For what I understand some of these are just needed for code qu=
ality
> > > > > > (-W) and could be controlled by distributions but others might =
actually
> > > > > > need to be always set (-f?).
> > > > >
> > > > > If you look at the Makefiles overall in all the projects, you'll =
see hardening
> > > > > flags, etc. Libsepol has a pretty minimal set compared to say lib=
selinux, but
> > > > > they all get overridden by build time CFLAGS if you want.
> > > > >
> > > > > >
> > > > > > Shouldn't the flags that always need to be set (which ones?) be=
 moved to
> > > > > > a "override CFLAGS" directive to avoid these to be unset by dis=
tributions?
> > > > >
> > > > > If you we're cleaver with CFLAGS before, you could acually circum=
vent
> > > > > the buildtime
> > > > > DSO stuff. While i'm not opposed to adding it to immutable flag, =
if
> > > > > you're setting
> > > > > CFLAGS, you're on your own. At least with the current design.
> > > > >
> > > > > I have no issues with adding it to override, but we would have to
> > > > > overhaul a bunch
> > > > > of them and make them consistent.
> > > >
> > > > I'm inclined to agree with Laurent here - we should always set this
> > > > flag in order to preserve the same behavior prior to the patches th=
at
> > > > removed hidden_def/hidden_proto and switched to relying on this
> > > > instead.
> > >
> > > Theirs a lot of features that rely on particular cflags, consider har=
dening
> > > options. A lot of the warnings/error stuff is not just a code hygiene=
, but also
> > > spotting potential issues that could arise as security issues. If one=
 starts
> > > tinkering with cflags, you can really change the code quite a bit. Th=
is is why
> > > some places only approve sanctioned builds of crypto libraries.
> >
> > I think the difference here is that we made a change in the source
> > code (hidden_def/hidden_proto removal) that requires use of
> > -fno-semantic-interposition to preserve existing behavior.
> >
> > > But one of the things to consider is that for clang builds, clang
> > > doesn't support
> > > this option, so we would need to move the compiler checking code into=
 each
> > > projects root makefile and ensure any consuming subordinate leafs add=
 a
> > > default, or move it to the global makefile and make sure each leaf th=
at needs it
> > > has a default.
> >
> > I think clang does support it now? https://reviews.llvm.org/D72724
>
> Yeah but that bug is all 2020 stuff. It is in the clang-10 release. I
> verified that
> with a local build from here:
>   - https://apt.llvm.org/
> So anything sub clang-10 won't support it, do you want to tie us to that
> new of a clang?

No, I guess not.  So I guess our options are to leave it alone and
just make sure it is well documented or complicate the Makefiles.
