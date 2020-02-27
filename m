Return-Path: <SRS0=cYHv=4P=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E4F0C3F2C0
	for <selinux@archiver.kernel.org>; Thu, 27 Feb 2020 21:05:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9F8624690
	for <selinux@archiver.kernel.org>; Thu, 27 Feb 2020 21:05:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LYHR5Bno"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729590AbgB0VFh (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 27 Feb 2020 16:05:37 -0500
Received: from mail-io1-f68.google.com ([209.85.166.68]:34570 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726758AbgB0VFh (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 27 Feb 2020 16:05:37 -0500
Received: by mail-io1-f68.google.com with SMTP id z190so1075441iof.1
        for <selinux@vger.kernel.org>; Thu, 27 Feb 2020 13:05:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ILsDnDG3K4Zy8w7Fs08X5UP211sKfnJO11ffRCaPD+A=;
        b=LYHR5BnoEsRR6ywHMn19g7m37p4wHHURIPgZx7RwJPN6nCSTSXJmv8+poEFmexFmcF
         InMarxeHz6bzHBr90xYPkyRyKAsKUJAvAQ20XmP534i80B1qlGL8J7eVJP0pFRFimi75
         r8427s2XIfcY/R6zWYrLOzUaVIwOhFCyNs9uycvA3iJRFMfMyKVBzogfQW9r+9rC0acZ
         In6S5/kT5JPJxgq/i1DmPFK5IotpcpHBXIWpGhMqbcXHRESAkTCs7Z53sTq9e46EiQxt
         Bc9LP+rXPlUhF5dSuk1sMGNFtctQmciPFC3DRnYMqPP3nVw+OwTSEm7JZT5YVluIn5jV
         IOYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ILsDnDG3K4Zy8w7Fs08X5UP211sKfnJO11ffRCaPD+A=;
        b=ZwmamVmb2X/HCiKnqgwKQG0RgBrxnsZhpnWFRPYtU5ctg6ZwBowNNhxWqJ3fjXHWyQ
         svVxetZcm4mR5Ej8Wh9egpS2fGrq3yuLojNbvAKdDQ5ELwey5I7BQ+thaHkSpgxJFNjN
         zlyYUR2KkPPhZE2S8D3i/w62DXNDSIB/OZL8m3WXQlByzOt2/hEf9vUizrxyRPAoWoox
         mYx5O5zSRpKCTyrPgHqw8Pu46RUFhnwmHei+zoWV5Q0mWz4B2kNuN4xyG4Deq1f24dAQ
         JOqqiOmM7G6op0jQ0uYRqNMpBoiogkd/oXOeOL1CDxmM4lwejXe8B5aAHfZmSnzgpBKp
         ZQEQ==
X-Gm-Message-State: APjAAAVH7gcfVb/nRhqfAraWK2uSlDHsIEWWSZjLoqmNVPk2FJ8TqNl6
        SYk/eiPKyVCTllca9iSg7vckHC5D+IqbckW4ttU=
X-Google-Smtp-Source: APXvYqzTJDi0jcJit2ceewPFkvDAotKB6NXKpR6inUMP5H6hXLxPWzjGg/veB/3vfOkSwG0faYT9pFI+z48hcOhTTiU=
X-Received: by 2002:a5d:9708:: with SMTP id h8mr984112iol.141.1582837536397;
 Thu, 27 Feb 2020 13:05:36 -0800 (PST)
MIME-Version: 1.0
References: <20200225200219.6163-1-william.c.roberts@intel.com>
 <CAEjxPJ42+p_Ppo6SqJCu-em2HXv1hyaY6ziCb0TrqTMBLg_Gag@mail.gmail.com>
 <CAFftDdpG-t4Zo9Ro8xJyxkd6zQ8FoyaTqfQrvG8kcbtP94Xf1Q@mail.gmail.com>
 <CAFftDdomj5C35JLZCx9ATaUcS7Lg3izWx8M5CAX6DPhNuZs62g@mail.gmail.com>
 <CAEjxPJ4wZw=g1QW9gSPL_2tu9E12oJnX2OYPmTKCZqZQH6StKw@mail.gmail.com>
 <CAFqZXNtRmp-TiNupX3xgOWiBYun4gK0E3TJcoo4-_b2RF2+Duw@mail.gmail.com> <19b672ed-e4d6-5c14-6839-a9203690b7e1@redhat.com>
In-Reply-To: <19b672ed-e4d6-5c14-6839-a9203690b7e1@redhat.com>
From:   William Roberts <bill.c.roberts@gmail.com>
Date:   Thu, 27 Feb 2020 15:05:24 -0600
Message-ID: <CAFftDdri97VAa8jwN+3JcLW90mFXjEBMfPnynix=ZpYW6R51rA@mail.gmail.com>
Subject: Re: Annotate Deprecated Functions in libselinux
To:     Ulrich Drepper <drepper@redhat.com>
Cc:     Ondrej Mosnacek <omosnace@redhat.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        Petr Lautrbach <plautrba@redhat.com>,
        SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Feb 27, 2020 at 2:43 PM Ulrich Drepper <drepper@redhat.com> wrote:
>
> On 2/27/20 9:03 PM, Ondrej Mosnacek wrote:
> > Ulrich, could you help us understand the macros you proposed to add to
> > the SELinux libraries (probably a very long time ago)? Specifically,
> > we are talking about those defined in "dso.h" header files such as
> > this one [1]. See also GH issue 204 [2] for related discussion.
>
> The use of the hidden infrastructure is not just a means to reduce
> overhead in the form of PLTs.  It also ensures that internals for the
> library don't leak out.

Linker script? We just use a map file that has everything local except for what
we want to export.

> If calls between functions within the same DSO
> use the PLT they can be intercepted by DSO earlier in the search path of
> the dynamic linker.  This can have unwanted consequences.

Huh? I'm not following? If we just remove this, what would actually
break in libselinux?

>
> I advise that this isn't changed.  The infrastructure to do this should
> change, though.  You could look at the code glibc uses today.  The
> functionality is still there, just slightly changed.
>
> An alternative is to use gcc's -fno-semantic-interposition option.  This
> should ensure that PLT entries are avoided.  For Python this was used to
> achieve significant speedups due to the PLT reduction.  I know you don't
> care about speed that much but this is a way to achieve it.  Python uses
> LTO but since the compiler is told about the symbol use there are not
> problems.

This minor overhead on the first call to a routine to resolve the symbol isn't
really much overhead. After it's resolved its like an extra jmp or something.

If you really wanted to avoid relocation, couldn't you just link statically?

This seems like it might be good for specific issues, but I don't see how this
infrastructure really prevents or fixes anything besides complicating the code,
perhaps enlighten me?

I can see how perhaps for large things like python/glibc it could be
useful but for
libselinux this just seems like an over-engineered solution to a
non-existent problem.
