Return-Path: <SRS0=cYHv=4P=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 480FEC11D3D
	for <selinux@archiver.kernel.org>; Thu, 27 Feb 2020 20:04:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B174246A0
	for <selinux@archiver.kernel.org>; Thu, 27 Feb 2020 20:04:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EreVqq1e"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729611AbgB0UEM (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 27 Feb 2020 15:04:12 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:33325 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730608AbgB0UEK (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 27 Feb 2020 15:04:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1582833849;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mwnPl4T0xGFcbsUS3+FeLSbsyj98OspkzaZr16d4XAc=;
        b=EreVqq1ewGYflVjQELpOmep56g5LoR7z+7BZlYamGek6RGq7OVu9/rrHlmqinPZ4v9ozV7
        SbGxmtb1s9KjXJi5jhNxfCRjNFDZnKX+MWrzHdg5gE1H188EfjJaC43ZR9Jkxr3fXi8REn
        EF4DmMWQS3YhcByVxlBv1g1lhUV41Qg=
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com
 [209.85.167.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-240-Jn60abHuNCaV-IMFAme5GQ-1; Thu, 27 Feb 2020 15:04:06 -0500
X-MC-Unique: Jn60abHuNCaV-IMFAme5GQ-1
Received: by mail-oi1-f199.google.com with SMTP id o5so178062oif.9
        for <selinux@vger.kernel.org>; Thu, 27 Feb 2020 12:04:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=mwnPl4T0xGFcbsUS3+FeLSbsyj98OspkzaZr16d4XAc=;
        b=VAk5/LfzBb4HUqNmYlsQjmzECc9cpMWaoze2HkDHh005gu1dU9+i0kEwpdcMdcoxew
         okAvBehdvDgZKxhKkvSLI1nXhZfwokXkSRHoJOb3ctnVZ58xApDgd7cCgq5gE1+Jg6/V
         F6h0fHrQejEOpGy0EIfEyMjE4/uTPKkhFeO+GG1RxcKxlnhOBGAqimVjWhqO+IPkBgfg
         7U8l+DLD4CYTZqutnUMZKRrQNnUUSB3GXvVFgC+6eOy4fZ2y/80OCcLwVFwIneR56egV
         ss0CNb+12bF5w8cWM++UFqbx/1CMqJMx9EfcWDFFpTb7ecNpyJXQ9gvc39mJo1wAgQdy
         r6UA==
X-Gm-Message-State: APjAAAWYd23wklKlbl1+HpLVuuEOVIHRMatz4S8y8i3W6KVErPMppkzf
        TKJxd2U9ryea0EyC/iwmaV4iBTAUzgQy9Trcv5FY2l8BGtXyraneuCBFAYS6chjVrDUBlmI7bUh
        /K1/pcnSxaAiDXZmH++6pZ17Az2XpRP1Fow==
X-Received: by 2002:a9d:7ccc:: with SMTP id r12mr527278otn.22.1582833845403;
        Thu, 27 Feb 2020 12:04:05 -0800 (PST)
X-Google-Smtp-Source: APXvYqyAmHQVVyxXGB1/s/ZfPMd0Ra4Bxkmyzw6EXqlvqToCxB2aq71FfKyBOfg6hVhrUKs0qfC77WVQTdyZT/3qcLg=
X-Received: by 2002:a9d:7ccc:: with SMTP id r12mr527251otn.22.1582833845086;
 Thu, 27 Feb 2020 12:04:05 -0800 (PST)
MIME-Version: 1.0
References: <20200225200219.6163-1-william.c.roberts@intel.com>
 <CAEjxPJ42+p_Ppo6SqJCu-em2HXv1hyaY6ziCb0TrqTMBLg_Gag@mail.gmail.com>
 <CAFftDdpG-t4Zo9Ro8xJyxkd6zQ8FoyaTqfQrvG8kcbtP94Xf1Q@mail.gmail.com>
 <CAFftDdomj5C35JLZCx9ATaUcS7Lg3izWx8M5CAX6DPhNuZs62g@mail.gmail.com> <CAEjxPJ4wZw=g1QW9gSPL_2tu9E12oJnX2OYPmTKCZqZQH6StKw@mail.gmail.com>
In-Reply-To: <CAEjxPJ4wZw=g1QW9gSPL_2tu9E12oJnX2OYPmTKCZqZQH6StKw@mail.gmail.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Thu, 27 Feb 2020 21:03:53 +0100
Message-ID: <CAFqZXNtRmp-TiNupX3xgOWiBYun4gK0E3TJcoo4-_b2RF2+Duw@mail.gmail.com>
Subject: Re: Annotate Deprecated Functions in libselinux
To:     Stephen Smalley <stephen.smalley.work@gmail.com>
Cc:     William Roberts <bill.c.roberts@gmail.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        Petr Lautrbach <plautrba@redhat.com>,
        SElinux list <selinux@vger.kernel.org>,
        Ulrich Drepper <drepper@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

(Adding Ulrich himself to Cc...)

On Thu, Feb 27, 2020 at 8:47 PM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Thu, Feb 27, 2020 at 1:41 PM William Roberts
> <bill.c.roberts@gmail.com> wrote:
> > It doesn't get us around all the issues, anything marked deprecated in =
selinux.h
> > and marked hidden_proto in selinux_internal.h, will still need a pragma=
.
> >
> > This would be much simpler if we drop the whole hidden_proto stuff, I g=
uess
> > kloczek is proposing patches? Who is that, I see the Github name as:
> > Tomasz K=C5=82oczko
> >
> > But I can't find any matching author in the git logs to CC them.
>
> I don't actually know him myself but he has opened a number of issues
> on the selinux userspace and appears to be involved in Fedora in some
> capacity.
>
> > I'm looking at those macros:
> > hidden_def
> > hidden_proto
> >
> > They both seem to take a function and create an _internal symbol, and
> > set the global symbol equal to the internal one. Essentially, both the
> > normal and _internal functions are pointing to the same address.
> >
> > $ readelf -s ./src/libselinux.so | grep setexeccon_raw
> >    176: 0000000000017c26    63 FUNC    GLOBAL DEFAULT   12 setexeccon_r=
aw
> >    279: 0000000000017c26    63 FUNC    LOCAL  DEFAULT   12
> > setexeccon_raw_internal
> >    606: 0000000000017c26    63 FUNC    GLOBAL DEFAULT   12 setexeccon_r=
aw
> >
> > The hidden one, additionally
> > sets the visibility to hidden, which if IIUC, just requires one to
> > statically link. We can see above the
> > visibility is local.
> >
> > What I don't understand, is why one would do this? What actual
> > performance enhancement do we get?
>
> The hidden_def/hidden_proto stuff originally came from Ulrich Drepper,
> glibc maintainer at the time, to eliminate unnecessary runtime
> relocations and PLT entries being used for local symbols.  Per the
> comments in https://github.com/SELinuxProject/selinux/issues/204,
> these might not be needed anymore and are breaking building with LTO.
> Willing to get rid of them if it doesn't produce a significant
> regression.

Ulrich, could you help us understand the macros you proposed to add to
the SELinux libraries (probably a very long time ago)? Specifically,
we are talking about those defined in "dso.h" header files such as
this one [1]. See also GH issue 204 [2] for related discussion.

Thanks,

[1] https://github.com/SELinuxProject/selinux/blob/master/libselinux/src/ds=
o.h
[2] https://github.com/SELinuxProject/selinux/issues/204

--=20
Ondrej Mosnacek <omosnace at redhat dot com>
Software Engineer, Security Technologies
Red Hat, Inc.

