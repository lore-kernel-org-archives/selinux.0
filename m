Return-Path: <SRS0=NbdY=4T=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8011BC3F2D1
	for <selinux@archiver.kernel.org>; Mon,  2 Mar 2020 15:32:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51A332084E
	for <selinux@archiver.kernel.org>; Mon,  2 Mar 2020 15:32:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NQI0bop9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727140AbgCBPcO (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 2 Mar 2020 10:32:14 -0500
Received: from mail-il1-f193.google.com ([209.85.166.193]:34088 "EHLO
        mail-il1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726751AbgCBPcN (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 2 Mar 2020 10:32:13 -0500
Received: by mail-il1-f193.google.com with SMTP id n11so4635137ild.1
        for <selinux@vger.kernel.org>; Mon, 02 Mar 2020 07:32:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZiNHfOSEUX5p/rPnVNqfD5fs3PsJpZoLDw1MZ99DgQI=;
        b=NQI0bop9ZXD6mV1hTAbadL4bVTwpSivb6STiAOEZRk97gJcPd//f5heOTQjT0FwAf2
         lu5bHIkXor9C0KTyZyqyrI/N5aBaoT2pkFyTH7tbPcP2vtlDb2dGZV7WbOzHS04ngq87
         dFnAN+uAYD/jraGuqh1SLgK9Mu/Er/ak5PmIo9XwdzLnCGKN/uxkxanU7u8jlQQn6K7n
         +PTCrzQqczmMiiQ5fCi4er8pwBtM0+Xvgx2jBUIO/YYK9PnrQvfueltLkZW/TLtsLXQ6
         u6aTzU1Cl2+zgcu/4oa6zUbmQDqZS3Wj/N1sjZtC+4jul20MOqLk4NvOhW46WPcQxmNk
         Xxag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZiNHfOSEUX5p/rPnVNqfD5fs3PsJpZoLDw1MZ99DgQI=;
        b=iiVaICELuJd/rx9V2vJf1FOAImKWSU/nOc8VDFUcvm1Gj/jZn1h+uRoKXZH5IBz09E
         MVnGN1vLTWtcxH6nMfrDbemVrGQY4la5piDn0RiLzGL9ZVrkSuOuFSxz+8KAVWnQTKjL
         QR7r0Rq/idiyN0NNmrGHOaCFBglvDw8TvcXXmWjMB9einSMp7ITmyUTXXblKXut9uPHS
         A053ZMxBdRgVzw1dJYAP+aRrmK8saY1y+8etJAnDrl27DIV5idtWOroonXluuV4QpXBF
         INxMa5r1AWI6RuzWG6WQzl1LrJ2sLG6LKBmCjqUXCv88JI2d8+UY/XD5UbE4i+l8QNgi
         oJpQ==
X-Gm-Message-State: ANhLgQ0TdXscCS7o6K11K3SBE0v6G8C8OdlxFkU1bp374N1g4f0+Gr7k
        3FebyEqhp5egIAqTrv3eilTGlwFuxUahz806vzk=
X-Google-Smtp-Source: ADFU+vt1irBl8d5moNZxXjnWQeSBMmKfknjtcrPjWxe4whe6VPd3xzqv8ekquqq53Z8pjAPf6ZR3g7kb1JjhkkXznXs=
X-Received: by 2002:a92:5cc7:: with SMTP id d68mr155161ilg.163.1583163133136;
 Mon, 02 Mar 2020 07:32:13 -0800 (PST)
MIME-Version: 1.0
References: <CAFftDdr0uCE106AYCgs27nubTntevz40WiFzMr7rn4sFrdWazQ@mail.gmail.com>
 <20200228133207.32441-1-william.c.roberts@intel.com> <CAJfZ7==oAidx6pT5jK1C-r=i-qEM2tESVLWiCkN-v53u7uXtEw@mail.gmail.com>
 <CAFftDdo6ndA=uHW9Ujr2WA4cvMMN_+tJezZYaTL7vXNnafK0ig@mail.gmail.com>
 <CAJfZ7=mtc=9NdK=rs_BenvG2O1n6KG=Gb7oPYTdrzu9KdRBxRw@mail.gmail.com>
 <CAFftDdrdanf2a1=pJ7BWUE0osRJGjYq1TYpS4+1fHvX5vkdGBQ@mail.gmail.com>
 <CAJfZ7=kocVtoWs2fo8JkH+7FicnORGGVQEH51tG95u2nGoaPTw@mail.gmail.com>
 <CAFftDdpkV9furWPR1VzuSV6ew93+Rij3bF7gw2Lup9aa8VMrSw@mail.gmail.com>
 <CAJfZ7=kB1i0ULzcC-EXNkUpRVbw+TCMzZGiV3EcNPsbqZ-hL1A@mail.gmail.com> <CAEjxPJ4UPBWSP0E4pjR+F6uKMZNHK9J7LTL1gVznpwyJh9UWNA@mail.gmail.com>
In-Reply-To: <CAEjxPJ4UPBWSP0E4pjR+F6uKMZNHK9J7LTL1gVznpwyJh9UWNA@mail.gmail.com>
From:   William Roberts <bill.c.roberts@gmail.com>
Date:   Mon, 2 Mar 2020 09:32:02 -0600
Message-ID: <CAFftDdqE7YRQRhfFuWNrUuSrzG7on-UeHV=KYBXu=-UNAkUKNg@mail.gmail.com>
Subject: Re: [PATCH] libsemanage: check libsepol version
To:     Stephen Smalley <stephen.smalley.work@gmail.com>
Cc:     Nicolas Iooss <nicolas.iooss@m4x.org>,
        SElinux list <selinux@vger.kernel.org>,
        Ondrej Mosnacek <omosnace@redhat.com>,
        William Roberts <william.c.roberts@intel.com>,
        Petr Lautrbach <plautrba@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Mar 2, 2020 at 9:22 AM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Sun, Mar 1, 2020 at 4:43 PM Nicolas Iooss <nicolas.iooss@m4x.org> wrote:
> > > > > > On the other hand, since I began packaging SELinux libraries for Arch
> > > > > > Linux, I found several releases that needed to bump such a dependency
> > > > > > version. For example, if I remember correctly libsemanage 2.4 requires
> > > > > > libsepol>=2.4, same for 2.5, 2.6... but libsemanage 2.9 could work
> > > > > > with libsepol 2.8 (I usually tries building with older versions when
> > > > > > packaging a release for Arch Linux, and the history is available for
> > > > > > example on https://aur.archlinux.org/cgit/aur.git/log/?h=libsemanage).
>
> In practice, there is really only a single version for the entire
> selinux userspace these days, and one should always
> upgrade all components at the same time.

I guess we could take the VERSION file for dependencies and use this
in the requires private dependency versions and then run the
pkg-config tool to make sure they we're building against the right
version and that the PC file has no other errors.

>
> > > diff --git a/libsemanage/src/libsemanage.pc.in
> > > b/libsemanage/src/libsemanage.pc.in
> > > index 43681ddb8652..5b25e467393a 100644
> > > --- a/libsemanage/src/libsemanage.pc.in
> > > +++ b/libsemanage/src/libsemanage.pc.in
> > > @@ -7,7 +7,7 @@ Name: libsemanage
> > >  Description: SELinux management library
> > >  Version: @VERSION@
> > >  URL: http://userspace.selinuxproject.org/
>
> Not related to this per se, but these URLs need to be updated to point
> to the GitHub releases.

Sounds like the PC files could use some general housekeeping.

Ill put some more patches together at some point this week.
