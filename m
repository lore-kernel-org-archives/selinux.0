Return-Path: <SRS0=XvAr=4Q=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73823C3F2D2
	for <selinux@archiver.kernel.org>; Fri, 28 Feb 2020 13:38:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3CDF224699
	for <selinux@archiver.kernel.org>; Fri, 28 Feb 2020 13:38:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P++ZTZA5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726602AbgB1NiQ (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 28 Feb 2020 08:38:16 -0500
Received: from mail-il1-f195.google.com ([209.85.166.195]:42747 "EHLO
        mail-il1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725796AbgB1NiP (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 28 Feb 2020 08:38:15 -0500
Received: by mail-il1-f195.google.com with SMTP id x2so2701795ila.9
        for <selinux@vger.kernel.org>; Fri, 28 Feb 2020 05:38:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=e4Yuu28GJt2hLKyKc1Qgej2/TiMhuQGewOT7QYqR2SQ=;
        b=P++ZTZA5U/7VYXY8FFBcE+Sk77S80m1COY1l/8GkGFYfAL5jq7GrUUAZnx3Rb12Bjo
         l0/EsdwnJ40Yo3wN6PGJp1uMmK2KmzngQFRMwMxHF4F2fuiM0b29m4dZsicRNAz1WAI6
         38vyMBOrL0K5Aa7u7Wr51BTCmcr//aLO5n10S+y0xWb5jA17A4zmqtpKp6ACTcuRejSQ
         tUobmzUZxeAL6pO7y2XT3Rhbxwf7wmpCrd8VNH2NQL7PwFwAdzxY9tjv3DDKX0sV5YYx
         PM2LVkWR5Zvwrmv1fM6ryKTq9IX9rce4r7QGGU79304SbWwhOsZ8OZ6gqcE92H+CKKBa
         GtlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=e4Yuu28GJt2hLKyKc1Qgej2/TiMhuQGewOT7QYqR2SQ=;
        b=R0AYDVczsv74MGAbJ3O9BhIEEw6Ki9J4Qkow9zqFUCaqlUUobqzZ6PgG71lLPtekQN
         Qvb0of04UOWHkZ/HlHKF6bI3i2gthsnbYcbG5LvaLQo6VwkIvXNxGQ7a6TXpKDO7NFWE
         MCn5Q1/kOQdva/g3wQ+HGykvkWL9/VM3hp8qWDPBAlhZRrxKJLVDdb8sRTEY2+0L03z2
         55R8EigSUd1aM38hNacFmz6CfGnhqi3jAwdY69oSJuhYkfTGZwflGFN3qLPJVWk1RAAi
         qQmh5LP3Uz5F2kJfL5aGPC4kgUxtxEXmr5x0OftZ8bfaVd8YicnyD5udS4s4n/0vmApP
         BSUw==
X-Gm-Message-State: APjAAAUoJDQ8CDg4aUWbMI96JwC8oA6GQrgfbd0kPAcrSAjutbUgJ4QZ
        t1Za/7nWKoBnyNeu5GkHq17YHmpC8GjkuiY9J5ajog==
X-Google-Smtp-Source: APXvYqzLudQ811Ly2JV3kttxMqw0PnoZg0n7D0zRosT+/1iOO5fB2P9pGY3rGpvwepDDbkK6Wa2oUtxUsGCrMyodUts=
X-Received: by 2002:a05:6e02:14e:: with SMTP id j14mr4140516ilr.129.1582897094771;
 Fri, 28 Feb 2020 05:38:14 -0800 (PST)
MIME-Version: 1.0
References: <20200227230129.31166-1-william.c.roberts@intel.com>
 <20200227230129.31166-4-william.c.roberts@intel.com> <CAEjxPJ4ae=FLqEDofLwSP0PEeqUqh1WtoSVFb9TrafMhawfhPg@mail.gmail.com>
In-Reply-To: <CAEjxPJ4ae=FLqEDofLwSP0PEeqUqh1WtoSVFb9TrafMhawfhPg@mail.gmail.com>
From:   William Roberts <bill.c.roberts@gmail.com>
Date:   Fri, 28 Feb 2020 07:38:03 -0600
Message-ID: <CAFftDdqo3M_dU7NboUvFRT4t6yhF+mtHDH6viadJHfDdoTRH7w@mail.gmail.com>
Subject: Re: [PATCH 3/3] Makefile: add linker script to minimize exports
To:     Stephen Smalley <stephen.smalley.work@gmail.com>
Cc:     SElinux list <selinux@vger.kernel.org>,
        Ulrich Drepper <drepper@redhat.com>,
        Ondrej Mosnacek <omosnace@redhat.com>,
        Petr Lautrbach <plautrba@redhat.com>,
        William Roberts <william.c.roberts@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Feb 28, 2020 at 7:34 AM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Thu, Feb 27, 2020 at 6:01 PM <bill.c.roberts@gmail.com> wrote:
> >
> > From: William Roberts <william.c.roberts@intel.com>
> >
> > Add a linker script that exports only what was previosly exported by
> > libselinux.
> >
> > This was checked by generating an old export map (from master):
> > nm --defined-only -g ./src/libselinux.so | cut -d' ' -f 3-3 | grep -v '^_' > old.map
> >
> > Then creating a new one for this library after this patch is applied:
> > nm --defined-only -g ./src/libselinux.so | cut -d' ' -f 3-3 | grep -v '^_' > new.map
> >
> > And diffing them:
> > diff old.map new.map
> >
> > Fixes: #179
> >
> > Signed-off-by: William Roberts <william.c.roberts@intel.com>
> > ---
> >  libselinux/src/Makefile       |   2 +-
> >  libselinux/src/libselinux.map | 249 ++++++++++++++++++++++++++++++++++
> >  2 files changed, 250 insertions(+), 1 deletion(-)
> >  create mode 100644 libselinux/src/libselinux.map
> >
>
> > diff --git a/libselinux/src/libselinux.map b/libselinux/src/libselinux.map
> > new file mode 100644
> > index 000000000000..823abeee9a36
> > --- /dev/null
> > +++ b/libselinux/src/libselinux.map
> > @@ -0,0 +1,249 @@
> > +{
> > +  global:
>
> Our other map files (for libsepol and libsemanage) have a versioned
> symbolic name before the {, ala
> LIBSELINUX_1.0 {

Ok will add.

>
> > +    dir_xattr_list;
>
> I doubt this was intentionally made public and certainly isn't
> declared in the public headers.  Can we hide it?
>
> > +    map_class;
> > +    map_decision;
> > +    map_perm;
>
> Ditto for these three.
>
> > +    myprintf_compat;
>
> And again.
>
> > +    unmap_class;
> > +    unmap_perm;
>
> Likewise.

Perfect, I was wondering if this was overzealous, but I didn't want to
break things.
Will drop these. This provides evidence that opting in to hide symbols, wasn't
doing what we expected.
