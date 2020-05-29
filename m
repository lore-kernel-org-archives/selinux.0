Return-Path: <SRS0=wECs=7L=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE9FDC433E0
	for <selinux@archiver.kernel.org>; Fri, 29 May 2020 16:40:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B77EF207F5
	for <selinux@archiver.kernel.org>; Fri, 29 May 2020 16:40:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aOP577nJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726845AbgE2Qkm (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 29 May 2020 12:40:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725795AbgE2Qkm (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 29 May 2020 12:40:42 -0400
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6AC6C03E969
        for <selinux@vger.kernel.org>; Fri, 29 May 2020 09:40:41 -0700 (PDT)
Received: by mail-ot1-x334.google.com with SMTP id o13so2406237otl.5
        for <selinux@vger.kernel.org>; Fri, 29 May 2020 09:40:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=8znVkjt7+TqcA4g//VlTPuhGXu7xGn0m0+qD4xhnsL4=;
        b=aOP577nJksbVAxrbh0f1lapjFMCKKqpemNz1IlOUrLwvJTX4iEUAVV++DBPpsIUa2D
         diyMrluNN9+eZcadI5qnHNS/8t9uykfohgfJCshVv/+9Kz+zRgmMsJk9MFDGVtsH11bF
         SjccV1xPzfI9paGoRdHXK76HRUcr6S46c46n8GChLVx09gXHIW5IN+v8m/R7stDP+pDr
         nYOc/Jx3I8gs0U1kLFehvOIViITnvnYr96BnopXKJYNq1qkzJYEE9dCVEEmi2cOmx91/
         LQQ2gVsirmGN7BaSI+rFI4dkFHTn3GvrafkyCho46WSKFYQT6irvZD3zBddoI8i7illJ
         1aug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=8znVkjt7+TqcA4g//VlTPuhGXu7xGn0m0+qD4xhnsL4=;
        b=DKkabruRXoSTZ9TGuwobx8VPB3769IckZhaHgdlzwrPCgj7TWUXGt4i0HIfB8cQ161
         R30XnMsba1F8CB+edgeatLpQ1QPsebT/faoPYthzcvj5zq6K8RrquW/5WMTXruhI0LA9
         DdN2pfevnkKT3DCd5uq+tVqiRooofr8p68DJeT+TEPAooqwrRVSBcqOcCO5GVKoQAAKc
         JHMmWoTkpXlJeZtmWijc5D6jToiMTlWzHNw/sJ2LYyBLLC6Uxxw1nDxXagjj+0IIGkE+
         kVpJpy/Oa5GOybuYx/92wmSo86xtpvUvKUbVFKTYwqnqAlo+XTn2ztcQqvnapAQ4vL0K
         /w2Q==
X-Gm-Message-State: AOAM530gQ/tJjOo5vXOQakuWmjDuVABr5GB7t4uwfQLsUVeUhqWvLC2e
        Ushz7WK1cSNhQdvhVpzYqYounTsiEXkQSBoC4p+8HMm6PYo=
X-Google-Smtp-Source: ABdhPJzlcgmHraQfV4WVA4CX+/UqqWaFYAFEvAVQLiOzvvh3AIxHkYRRCp/bb4wT+vkD9D+3LK5SyNEShZEXfWEKekY=
X-Received: by 2002:a05:6830:2003:: with SMTP id e3mr4677483otp.89.1590770441007;
 Fri, 29 May 2020 09:40:41 -0700 (PDT)
MIME-Version: 1.0
References: <d0fd6970-7aa6-c576-fb8a-1d1293416e97@debian.org>
 <CAFftDdobT3E1MvFptyAKLBJ73KyrMOSS3m8DCnPX9+QF-Rk24Q@mail.gmail.com>
 <CAEjxPJ6XwXLBKYFaNO-kZz-Vgvbb2B7VKqD3DKQFf_ebBuNiBg@mail.gmail.com> <CAFftDdovpeFWnmKGDnTOY4AmwzSW0sCZoRwePX-q=NW1HV2c8w@mail.gmail.com>
In-Reply-To: <CAFftDdovpeFWnmKGDnTOY4AmwzSW0sCZoRwePX-q=NW1HV2c8w@mail.gmail.com>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Fri, 29 May 2020 12:40:30 -0400
Message-ID: <CAEjxPJ5weFXrFpyjWdW7D4tgOnK+jHMyD37Zb4JFEzDt1rQ8Dw@mail.gmail.com>
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

On Fri, May 29, 2020 at 12:05 PM William Roberts
<bill.c.roberts@gmail.com> wrote:
>
> On Fri, May 29, 2020 at 8:31 AM Stephen Smalley
> <stephen.smalley.work@gmail.com> wrote:
> >
> > On Sat, May 23, 2020 at 11:59 AM William Roberts
> > <bill.c.roberts@gmail.com> wrote:
> > >
> > > On Sat, May 23, 2020 at 5:57 AM Laurent Bigonville <bigon@debian.org>=
 wrote:
> > > >
> > > > Hello,
> > > >
> > > > The current build system of the userspace is setting a lot of CFLAG=
S,
> > > > but most of these are overridden by the distributions when building=
.
> > > >
> > > > Today I received a bug report[0] from Christian G=C3=B6ttsche askin=
g me to
> > > > set -fno-semantic-interposition again in libsepol. I see also the s=
ame
> > > > flag and also a lot of others set in libselinux and libsemanage bui=
ld
> > > > system.
> > >
> > > Why would it be again? The old DSO design made that option impotent.
> > > Clang does it by default.
> > >
> > > >
> > > > For what I understand some of these are just needed for code qualit=
y
> > > > (-W) and could be controlled by distributions but others might actu=
ally
> > > > need to be always set (-f?).
> > >
> > > If you look at the Makefiles overall in all the projects, you'll see =
hardening
> > > flags, etc. Libsepol has a pretty minimal set compared to say libseli=
nux, but
> > > they all get overridden by build time CFLAGS if you want.
> > >
> > > >
> > > > Shouldn't the flags that always need to be set (which ones?) be mov=
ed to
> > > > a "override CFLAGS" directive to avoid these to be unset by distrib=
utions?
> > >
> > > If you we're cleaver with CFLAGS before, you could acually circumvent
> > > the buildtime
> > > DSO stuff. While i'm not opposed to adding it to immutable flag, if
> > > you're setting
> > > CFLAGS, you're on your own. At least with the current design.
> > >
> > > I have no issues with adding it to override, but we would have to
> > > overhaul a bunch
> > > of them and make them consistent.
> >
> > I'm inclined to agree with Laurent here - we should always set this
> > flag in order to preserve the same behavior prior to the patches that
> > removed hidden_def/hidden_proto and switched to relying on this
> > instead.
>
> Theirs a lot of features that rely on particular cflags, consider hardeni=
ng
> options. A lot of the warnings/error stuff is not just a code hygiene, bu=
t also
> spotting potential issues that could arise as security issues. If one sta=
rts
> tinkering with cflags, you can really change the code quite a bit. This i=
s why
> some places only approve sanctioned builds of crypto libraries.

I think the difference here is that we made a change in the source
code (hidden_def/hidden_proto removal) that requires use of
-fno-semantic-interposition to preserve existing behavior.

> But one of the things to consider is that for clang builds, clang
> doesn't support
> this option, so we would need to move the compiler checking code into eac=
h
> projects root makefile and ensure any consuming subordinate leafs add a
> default, or move it to the global makefile and make sure each leaf that n=
eeds it
> has a default.

I think clang does support it now? https://reviews.llvm.org/D72724
