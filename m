Return-Path: <SRS0=d3z6=4V=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E848C3F2CD
	for <selinux@archiver.kernel.org>; Wed,  4 Mar 2020 13:48:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2348D2073D
	for <selinux@archiver.kernel.org>; Wed,  4 Mar 2020 13:48:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KaEc19P8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729334AbgCDNsp (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 4 Mar 2020 08:48:45 -0500
Received: from mail-il1-f170.google.com ([209.85.166.170]:37851 "EHLO
        mail-il1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729302AbgCDNsp (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 4 Mar 2020 08:48:45 -0500
Received: by mail-il1-f170.google.com with SMTP id a6so1853273ilc.4
        for <selinux@vger.kernel.org>; Wed, 04 Mar 2020 05:48:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Wof/E3kXP4svsf8VZwrVwJERFW2EU+6kIWXDNGE7wig=;
        b=KaEc19P8RYP4eodOf49MZjutmlggLFNjrgqI4ghZaOInfgi8Imum6CW1Y39nf364Pb
         X5ZjR7YQUdOZx/WVzWTJTGW8FGxyd0rE3t8PJljs/8d0L8D1H2S4gqbS9GEicDEIoHnH
         wQ46T2fizSzGK62DisSlFWXHER5nJNy/BoU2OP8G6YQMdBKorMYGPKMr9IaTu5Ppnon0
         MEyp9++g0M94/i2LE6mRxU7rXUre30TF0t5YUqzRZjDgEGY1FzQZamFn2VW9Dv7oGgyF
         FxR06/M0j8QWA6lfip5nDu6kdacDkgeAZJ2K5M69D1uaBb26/krg7J4tSSL9Ccj1793M
         f70w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Wof/E3kXP4svsf8VZwrVwJERFW2EU+6kIWXDNGE7wig=;
        b=Bv4o4CIpDrT340HAShUTtn3I2/Fnz2aDav2DCugRMSrRx9nL6jrz9ZAzBDDI2oUNcu
         MbwopMrqPr3XyHtlB0yg3jyscr7PIFnFS7WnZ+PEkeExhhKq95GvZwjXMSZCJDZSyy3l
         w/A6+otUY157uSgLGoz8Lg1hCWr3Yk7wxAIWH1QajbbmfN8KT/3FrAelcw2GHdVwjO7k
         5bXuBEzjmezFn2ZcJ4VvXFcnOmQ5uI2WlZKaOAf1Bni5kuGiPWTAQv/NK7tQOTFonZgq
         l40LvwcNJgKU37DTpqNXhpBMG5S9msv5UZbr9uxdr8ZTBu2bW5Gakdz/T31tlDYEPDRl
         rprg==
X-Gm-Message-State: ANhLgQ1Y2VHefO+Crc4QZx1bbvjbBvjsY+Kjw+lYxjait3HmF6mIUwTl
        1qz1gJoPJ9HJY9ERfCpVdvd9gk64HRIXJFO8XvM=
X-Google-Smtp-Source: ADFU+vv69X4orox+PWX1nqjBSKMGTbnED0TDqggJzc+VPBrs4ILOS76RVOezSvTiPdDucr1nMRL22H+4Nh2PrgHs5QU=
X-Received: by 2002:a05:6e02:14e:: with SMTP id j14mr2693182ilr.129.1583329723264;
 Wed, 04 Mar 2020 05:48:43 -0800 (PST)
MIME-Version: 1.0
References: <CAJfZ7==wU4R7VG3=gKpEoWKFKpP6tHiwN-0_O89-vp0w-ByPRw@mail.gmail.com>
 <20200302164112.10669-1-william.c.roberts@intel.com> <CAEjxPJ4sURPgJuTzGX_MBu-nThwn9NCWDKj0z39Pum8Mhh3axg@mail.gmail.com>
 <CAFqZXNuUjXwD=k65ACy_fuiYyq3r1rWSV8UpBQEr-+1a8vbXvQ@mail.gmail.com>
In-Reply-To: <CAFqZXNuUjXwD=k65ACy_fuiYyq3r1rWSV8UpBQEr-+1a8vbXvQ@mail.gmail.com>
From:   William Roberts <bill.c.roberts@gmail.com>
Date:   Wed, 4 Mar 2020 07:48:32 -0600
Message-ID: <CAFftDdrbK314k3dOUA=mEgo=B_tBjwpBx5npCXUWYGJjc+v8fQ@mail.gmail.com>
Subject: Re: [V4] libselinux: drop dso.h
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     Stephen Smalley <stephen.smalley.work@gmail.com>,
        Nicolas Iooss <nicolas.iooss@m4x.org>,
        Ulrich Drepper <drepper@redhat.com>,
        Petr Lautrbach <plautrba@redhat.com>,
        SElinux list <selinux@vger.kernel.org>,
        William Roberts <william.c.roberts@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

<snip>

> > This looks fine to me but I'd like at least one of the distro
> > maintainers to ack it (especially the last one).
>
> FWIW, I scanned all Fedora (32) packages that Require: libselinux
> using this script and it seems that nothing is using the symbols
> mentioned in patch 4/4 on Fedora:
>
> https://gitlab.com/omos/selinux-misc/-/blob/master/scan_imports.sh
>
> BTW, the same dso.h infrastructure is used also in libsepol and
> libsemanage - are there plans to do the same thing for those two?

Yes I can queue that up. I'd like to get through some of the other
updates first.
