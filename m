Return-Path: <SRS0=NbdY=4T=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BB7EC3F2CD
	for <selinux@archiver.kernel.org>; Mon,  2 Mar 2020 15:22:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F66220848
	for <selinux@archiver.kernel.org>; Mon,  2 Mar 2020 15:22:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NhZ+C7uL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726751AbgCBPWf (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 2 Mar 2020 10:22:35 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:37258 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726390AbgCBPWf (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 2 Mar 2020 10:22:35 -0500
Received: by mail-ot1-f66.google.com with SMTP id b3so10082438otp.4
        for <selinux@vger.kernel.org>; Mon, 02 Mar 2020 07:22:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EmVA5DRkl40h3IMn0eCspLoBN60JvZgt2ZRGrLhJPsU=;
        b=NhZ+C7uLLpFVmOJLtIxZrgbRPSoYAV1hWS2IU3c0yQ0pg3ZrzLOogdrncVCpikUZLA
         jPvdhB65kXXzLnKATjCNqU7Ysw8UY13t0HIa1r5X7E/JktGCp2e5L/zZSI+yuWLxyW2J
         x29p1yGWRsbGKmNowX0dxxB/yffzoeLqyEnOhrxDmh0BBiiKOduWeBwo8EABNbT9w+c6
         niTdXLKQiZeHUB3HkAaD+XRhuqcamDFKGqF5WCe/h0c9FjPy8Kns2QPKB6OSc8WK4Aw3
         r3mv2zvNkUMbPTWjX6PCfGYESYrlHSAv0/fqn0v57D29FudDGfYhHwFCflalV2w7ko7B
         bopg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EmVA5DRkl40h3IMn0eCspLoBN60JvZgt2ZRGrLhJPsU=;
        b=UHBPzKAEMWbvrIR64aej2YZoz8Xv7viQ+XWRIkPs61OoKnn2FX+Ap/tMD+nhI1j9ND
         F9skqT0wCx8/KRgzRcJvHOG4dxxs2neYqaC2FB9e/gP8VJJqBvnwsISx1yHn6ymLJaGA
         j6TJwwHjJzmTknQ4XO4VfUWkwg0Pz9CCCp9Z79tI1Bp8i5RGBkLPqVBikbioLmpPauIr
         ANzNyROL7AKfdK6JY2n/caL1A9gr1BAAt55H8ggiWRoiIKT+JJ4MvVGzobDoQSW1NCMX
         Qox/SMt2aqO3Bhs/K/ChN7REOfCOgYTYimjCs0U6J94zFmSqsSQoYw+0HcX7mQZ5MvXw
         Fo8A==
X-Gm-Message-State: APjAAAWo2Y+HByQj/Q7j5lbMewwxnL/5j9H9XPjE/wKTo5Mf3V4tQisH
        xXGXEPGLYNixoP8gOJFhEZWhxGUlA/9eCfKKiN4=
X-Google-Smtp-Source: APXvYqxIk4IVIOGECA/vt22b57NRh41ALvP+w8CVCa68so80CUAdiDtf0MNx3ANNG2ZVO8fDtqKTL7yMCEV5j+IAZAI=
X-Received: by 2002:a9d:68d9:: with SMTP id i25mr13590568oto.135.1583162554674;
 Mon, 02 Mar 2020 07:22:34 -0800 (PST)
MIME-Version: 1.0
References: <CAFftDdr0uCE106AYCgs27nubTntevz40WiFzMr7rn4sFrdWazQ@mail.gmail.com>
 <20200228133207.32441-1-william.c.roberts@intel.com> <CAJfZ7==oAidx6pT5jK1C-r=i-qEM2tESVLWiCkN-v53u7uXtEw@mail.gmail.com>
 <CAFftDdo6ndA=uHW9Ujr2WA4cvMMN_+tJezZYaTL7vXNnafK0ig@mail.gmail.com>
 <CAJfZ7=mtc=9NdK=rs_BenvG2O1n6KG=Gb7oPYTdrzu9KdRBxRw@mail.gmail.com>
 <CAFftDdrdanf2a1=pJ7BWUE0osRJGjYq1TYpS4+1fHvX5vkdGBQ@mail.gmail.com>
 <CAJfZ7=kocVtoWs2fo8JkH+7FicnORGGVQEH51tG95u2nGoaPTw@mail.gmail.com>
 <CAFftDdpkV9furWPR1VzuSV6ew93+Rij3bF7gw2Lup9aa8VMrSw@mail.gmail.com> <CAJfZ7=kB1i0ULzcC-EXNkUpRVbw+TCMzZGiV3EcNPsbqZ-hL1A@mail.gmail.com>
In-Reply-To: <CAJfZ7=kB1i0ULzcC-EXNkUpRVbw+TCMzZGiV3EcNPsbqZ-hL1A@mail.gmail.com>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Mon, 2 Mar 2020 10:24:19 -0500
Message-ID: <CAEjxPJ4UPBWSP0E4pjR+F6uKMZNHK9J7LTL1gVznpwyJh9UWNA@mail.gmail.com>
Subject: Re: [PATCH] libsemanage: check libsepol version
To:     Nicolas Iooss <nicolas.iooss@m4x.org>
Cc:     William Roberts <bill.c.roberts@gmail.com>,
        SElinux list <selinux@vger.kernel.org>,
        Ondrej Mosnacek <omosnace@redhat.com>,
        William Roberts <william.c.roberts@intel.com>,
        Petr Lautrbach <plautrba@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Sun, Mar 1, 2020 at 4:43 PM Nicolas Iooss <nicolas.iooss@m4x.org> wrote:
> > > > > On the other hand, since I began packaging SELinux libraries for Arch
> > > > > Linux, I found several releases that needed to bump such a dependency
> > > > > version. For example, if I remember correctly libsemanage 2.4 requires
> > > > > libsepol>=2.4, same for 2.5, 2.6... but libsemanage 2.9 could work
> > > > > with libsepol 2.8 (I usually tries building with older versions when
> > > > > packaging a release for Arch Linux, and the history is available for
> > > > > example on https://aur.archlinux.org/cgit/aur.git/log/?h=libsemanage).

In practice, there is really only a single version for the entire
selinux userspace these days, and one should always
upgrade all components at the same time.

> > diff --git a/libsemanage/src/libsemanage.pc.in
> > b/libsemanage/src/libsemanage.pc.in
> > index 43681ddb8652..5b25e467393a 100644
> > --- a/libsemanage/src/libsemanage.pc.in
> > +++ b/libsemanage/src/libsemanage.pc.in
> > @@ -7,7 +7,7 @@ Name: libsemanage
> >  Description: SELinux management library
> >  Version: @VERSION@
> >  URL: http://userspace.selinuxproject.org/

Not related to this per se, but these URLs need to be updated to point
to the GitHub releases.
