Return-Path: <SRS0=wECs=7L=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8F78C433DF
	for <selinux@archiver.kernel.org>; Fri, 29 May 2020 16:05:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 85473207F9
	for <selinux@archiver.kernel.org>; Fri, 29 May 2020 16:05:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WdP2UAh4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727004AbgE2QFB (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 29 May 2020 12:05:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726838AbgE2QFA (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 29 May 2020 12:05:00 -0400
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com [IPv6:2607:f8b0:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2098C03E969
        for <selinux@vger.kernel.org>; Fri, 29 May 2020 09:05:00 -0700 (PDT)
Received: by mail-il1-x12f.google.com with SMTP id 17so3022380ilj.3
        for <selinux@vger.kernel.org>; Fri, 29 May 2020 09:05:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=mFyE5zbjm3TWSySXjXwb7hTQPGmVK9yNQ04QvdS4ZWU=;
        b=WdP2UAh4k0A7XGsTcjYTMd2ASofPQ7SY5PAruFDgzZHxR+/WBK8X5wU+JeFSMlWjlC
         yQmvtxYqe0cgQ+R/lsYwE3Z5lXpyD2UZ+XBuNcwDeKlDJ1FQcGv8HIObWt01tGhuYFhu
         smig7MhZQo08weqoEEuklNWP8gB/nXOgM0dkGVDzwIwcDveN9EUMkSCv7slvxv17gMvd
         2PPg3dQm/LJI0wUQUuPP1xLQ7dOe35coN4fOT65YWY7S2IIK+pYw1rn7WwTgcDMBFeYZ
         Sc3532ZAs8KHTqyKJo2EhLE8hoE+hQE0PzIXmjN+9P85ZgYXDT8pfeYx64e9xkFkKQyJ
         cw5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=mFyE5zbjm3TWSySXjXwb7hTQPGmVK9yNQ04QvdS4ZWU=;
        b=D81VNFnhzbfuAw1W4wXioLeakbDayyx3/sBZcgDnXsDhHzZWjLqqIBbId6PjSKVPBQ
         HTo0wNCtHPbuQmQhMYdKpBXRZTtrGjv22tCaP/u0qWyHbu+9T5OdDkdgj8eo9goy3LSQ
         5U8XgSHFWoWyzW4gATUJ2zX3AHfG578pkJyuIMDwULSRT25ivHkCnazHmCaT/pdLsZyw
         LHQRXsJYqQXGYyEuhcP79aBKk1JK63v43tKQSib8IMdGIEPKXjl0M+aS2sZfXYi/04yT
         xHJvlsfLZHpC8/kG5E6AWTkkaPPH0ax/qgASznumsFAAqLFXW3mxuNNYDfV6P1R8/6KM
         M5ug==
X-Gm-Message-State: AOAM530ARIT5aCMzpgCaQS9QSCFsdSyAvF5Wox8tpT7Wp7/VQDIISeAa
        G1Ktrw+AxeyuJ6dqmxFDTt1cgwyI3cQV3eSQxFubDX/Z
X-Google-Smtp-Source: ABdhPJzg+wBXkm3JYviTZJj6pbOjqaNRd13vqbjndeCzgFR7tVEF556flpNpBpIS/669NegwD3D2oVZq3+ruD8xvmx0=
X-Received: by 2002:a92:58d6:: with SMTP id z83mr7957799ilf.129.1590768299744;
 Fri, 29 May 2020 09:04:59 -0700 (PDT)
MIME-Version: 1.0
References: <d0fd6970-7aa6-c576-fb8a-1d1293416e97@debian.org>
 <CAFftDdobT3E1MvFptyAKLBJ73KyrMOSS3m8DCnPX9+QF-Rk24Q@mail.gmail.com> <CAEjxPJ6XwXLBKYFaNO-kZz-Vgvbb2B7VKqD3DKQFf_ebBuNiBg@mail.gmail.com>
In-Reply-To: <CAEjxPJ6XwXLBKYFaNO-kZz-Vgvbb2B7VKqD3DKQFf_ebBuNiBg@mail.gmail.com>
From:   William Roberts <bill.c.roberts@gmail.com>
Date:   Fri, 29 May 2020 11:04:48 -0500
Message-ID: <CAFftDdovpeFWnmKGDnTOY4AmwzSW0sCZoRwePX-q=NW1HV2c8w@mail.gmail.com>
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

On Fri, May 29, 2020 at 8:31 AM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Sat, May 23, 2020 at 11:59 AM William Roberts
> <bill.c.roberts@gmail.com> wrote:
> >
> > On Sat, May 23, 2020 at 5:57 AM Laurent Bigonville <bigon@debian.org> w=
rote:
> > >
> > > Hello,
> > >
> > > The current build system of the userspace is setting a lot of CFLAGS,
> > > but most of these are overridden by the distributions when building.
> > >
> > > Today I received a bug report[0] from Christian G=C3=B6ttsche asking =
me to
> > > set -fno-semantic-interposition again in libsepol. I see also the sam=
e
> > > flag and also a lot of others set in libselinux and libsemanage build
> > > system.
> >
> > Why would it be again? The old DSO design made that option impotent.
> > Clang does it by default.
> >
> > >
> > > For what I understand some of these are just needed for code quality
> > > (-W) and could be controlled by distributions but others might actual=
ly
> > > need to be always set (-f?).
> >
> > If you look at the Makefiles overall in all the projects, you'll see ha=
rdening
> > flags, etc. Libsepol has a pretty minimal set compared to say libselinu=
x, but
> > they all get overridden by build time CFLAGS if you want.
> >
> > >
> > > Shouldn't the flags that always need to be set (which ones?) be moved=
 to
> > > a "override CFLAGS" directive to avoid these to be unset by distribut=
ions?
> >
> > If you we're cleaver with CFLAGS before, you could acually circumvent
> > the buildtime
> > DSO stuff. While i'm not opposed to adding it to immutable flag, if
> > you're setting
> > CFLAGS, you're on your own. At least with the current design.
> >
> > I have no issues with adding it to override, but we would have to
> > overhaul a bunch
> > of them and make them consistent.
>
> I'm inclined to agree with Laurent here - we should always set this
> flag in order to preserve the same behavior prior to the patches that
> removed hidden_def/hidden_proto and switched to relying on this
> instead.

Theirs a lot of features that rely on particular cflags, consider hardening
options. A lot of the warnings/error stuff is not just a code hygiene, but =
also
spotting potential issues that could arise as security issues. If one start=
s
tinkering with cflags, you can really change the code quite a bit. This is =
why
some places only approve sanctioned builds of crypto libraries.

But one of the things to consider is that for clang builds, clang
doesn't support
this option, so we would need to move the compiler checking code into each
projects root makefile and ensure any consuming subordinate leafs add a
default, or move it to the global makefile and make sure each leaf that nee=
ds it
has a default.
