Return-Path: <SRS0=6SNF=45=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E69A8C10DCE
	for <selinux@archiver.kernel.org>; Thu, 12 Mar 2020 14:05:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD4AA206E7
	for <selinux@archiver.kernel.org>; Thu, 12 Mar 2020 14:05:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FWGwv3Bo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727365AbgCLOF6 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 12 Mar 2020 10:05:58 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:41413 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727123AbgCLOF6 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 12 Mar 2020 10:05:58 -0400
Received: by mail-io1-f65.google.com with SMTP id m25so5770326ioo.8
        for <selinux@vger.kernel.org>; Thu, 12 Mar 2020 07:05:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NmCtvPVoO4mgxUNi3BdBWx/fyR7O+SZ7peUQ1OBCvyI=;
        b=FWGwv3BoGEABlFz2WkRNXg2yrD3CGqMVHYjm/IZHUJiH3WRqu7gr+wLVz26sQA+8oo
         u8PTHpJJA1YjF4biw3Lj//1p0vIPLywgvxl/cRyzMBnOcUzk4exeRCJHwICr8wY927Kv
         PFSkK+5mVovwkl+zElsbkdE86yHN+ZMb+r/HGgyzrqzqjp/2zkhF6HbSSQDHjath6k0A
         76BEQ0ITN9CKnBl5zQsJpnPrNQmPns6O5goA4NTkndH4K5vu2Pma/rIEIniyWQi3ch4v
         G/a5STrfc4RD1Xkq9aQgPOCWzX1c59ydp1erh43JWs0j2852WHwyfIafY7WA6apxiSjM
         ZxRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NmCtvPVoO4mgxUNi3BdBWx/fyR7O+SZ7peUQ1OBCvyI=;
        b=k6uZGXKEOa72KIb9XZ0Muv7Hmz9MeZpGDj6x6Eoetmr9R+QVoKHG4MXrEfh6lQPqEp
         gM4FnlfXauGCJgYjr807JMpszoSOMSIBLzeYpfUsglPQo99IHxwi3qQHd9npUO+jWTNe
         UDQUOEC8jY5hYVGe8FtXNJhyYxUvWMAA2jiQQ3BY6z3uEVrkJCnX0xlCCq5spKK/Fvw2
         NxXo3B01YxxsgSJF9L3vIv8n8UAguIXxZNGSCUutMFtLjok8dSMdzGWUzDutdsYF//RU
         hcSGGolxQF277Ihcqy/bcMBoJQFvNC7KblgdL0TRWdJzngv9OQok8KEP61DrKkIydauD
         jOxw==
X-Gm-Message-State: ANhLgQ297bKXNMMg3dOBoY4B0nMcBTBq7hopQmRI94BOmmC+ScIEwegl
        mbQbUWYZLQlhcHUyF8urkxdO27LBJ+icAc3BcQI=
X-Google-Smtp-Source: ADFU+vtM144PtBRD8bLEpOQcOSY+spgMb5zk4y0h9589Pb3etmW0UM35PnFoRfWBgHNR+z4cJWsU7CPTnijE+81RRiw=
X-Received: by 2002:a02:7a07:: with SMTP id a7mr7731205jac.77.1584021956795;
 Thu, 12 Mar 2020 07:05:56 -0700 (PDT)
MIME-Version: 1.0
References: <CAJfZ7==wU4R7VG3=gKpEoWKFKpP6tHiwN-0_O89-vp0w-ByPRw@mail.gmail.com>
 <20200302164112.10669-1-william.c.roberts@intel.com> <CAEjxPJ4sURPgJuTzGX_MBu-nThwn9NCWDKj0z39Pum8Mhh3axg@mail.gmail.com>
 <pjdd09r6ki8.fsf@redhat.com> <CAFftDdob6kA2XbsaLLKPND7uRFPFJyBwnzcPQPJ+pZsNw+vBzg@mail.gmail.com>
 <CAFftDdo2grFfgkFhSmw_XSeyu3Eo9wKvThqNyAjD73EoJdXJYQ@mail.gmail.com> <CAEjxPJ7wqdhF5G_2n1EsGjuvHdZhLG6Ww4dEkZ+HJjbffFjDVA@mail.gmail.com>
In-Reply-To: <CAEjxPJ7wqdhF5G_2n1EsGjuvHdZhLG6Ww4dEkZ+HJjbffFjDVA@mail.gmail.com>
From:   William Roberts <bill.c.roberts@gmail.com>
Date:   Thu, 12 Mar 2020 09:05:44 -0500
Message-ID: <CAFftDdpQ2LFifgD4j=usv8WUpN1=xV2S_aOQcbN+MFomYQGrYg@mail.gmail.com>
Subject: Re: [V4] libselinux: drop dso.h
To:     Stephen Smalley <stephen.smalley.work@gmail.com>
Cc:     Petr Lautrbach <plautrba@redhat.com>,
        Nicolas Iooss <nicolas.iooss@m4x.org>,
        Ulrich Drepper <drepper@redhat.com>,
        Ondrej Mosnacek <omosnace@redhat.com>,
        SElinux list <selinux@vger.kernel.org>,
        William Roberts <william.c.roberts@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Mar 11, 2020 at 1:14 PM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Thu, Mar 5, 2020 at 2:09 PM William Roberts <bill.c.roberts@gmail.com> wrote:
> >
> > On Thu, Mar 5, 2020 at 10:12 AM William Roberts
> > <bill.c.roberts@gmail.com> wrote:
> > >
> > > On Thu, Mar 5, 2020 at 6:42 AM Petr Lautrbach <plautrba@redhat.com> wrote:
> > > >
> > > >
> > > > Stephen Smalley <stephen.smalley.work@gmail.com> writes:
> > > >
> > > > > On Mon, Mar 2, 2020 at 11:41 AM <bill.c.roberts@gmail.com> wrote:
> > > > >> [PATCH v4 1/4] dso: drop hidden_proto and hidden_def
> > > > >> [PATCH v4 2/4] Makefile: add -fno-semantic-interposition
> > > > >> [PATCH v4 3/4] Makefile: add linker script to minimize exports
> > > > >> [PATCH v4 4/4] libselinux: drop symbols from map
> > > > >
> > > > > This looks fine to me but I'd like at least one of the distro
> > > > > maintainers to ack it (especially the last one).
> > > >
> > > > Acked-by: Petr Lautrbach <plautrba@redhat.com>
> > > >
> > >
> > > Thanks staged:
> > > https://github.com/SELinuxProject/selinux/pull/205
> >
> > merged.
>
> I've noticed a change since this was applied; if I build userspace
> against the updated libselinux, the dynamic loader will
> print a warning if it is run on a system with the older libselinux, ala:
> $ /sbin/restorecon -v /etc
> /sbin/restorecon: /lib64/libselinux.so.1: no version information
> available (required by /sbin/restorecon)
> It still works since there was no real change in the ABI but I don't
> know if this is a concern for distros.

I replicated this and looked into it, AFAICT its relatively harmless since,
as you point out, we're not breaking ABI.

But If I understand your comment (paraphrasing), "userspace should all
be updated together"
from:
  - https://lore.kernel.org/selinux/CAEjxPJ4UPBWSP0E4pjR+F6uKMZNHK9J7LTL1gVznpwyJh9UWNA@mail.gmail.com/

Then it really shouldn't be an issue.

A lot of what I read on the version stuff was written by Urlich, so he
might weigh in with more
information and perhaps a way to correct this.
