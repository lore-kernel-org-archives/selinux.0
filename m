Return-Path: <SRS0=cYHv=4P=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BFAAC3F2C2
	for <selinux@archiver.kernel.org>; Thu, 27 Feb 2020 21:31:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5BEC824677
	for <selinux@archiver.kernel.org>; Thu, 27 Feb 2020 21:31:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="t/Mhq+Sm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729649AbgB0Vbk (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 27 Feb 2020 16:31:40 -0500
Received: from mail-ot1-f45.google.com ([209.85.210.45]:34811 "EHLO
        mail-ot1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726758AbgB0Vbj (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 27 Feb 2020 16:31:39 -0500
Received: by mail-ot1-f45.google.com with SMTP id j16so661847otl.1
        for <selinux@vger.kernel.org>; Thu, 27 Feb 2020 13:31:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=e00DtrmoNRlIdmT1VDi70gbbGHpjoruQVSiVeaJbol8=;
        b=t/Mhq+Sm/CXIRkBjiMk6fYo/3dbOl3tLkdlm1+n6BM64FG7InN059cGfFg6M5kaXT2
         CA1CCN9F826ogZHwJ4OVeSV8rNxDByoEetza0QYBEOQt/ak6v0XnMjcWLTzeAeVxcWdR
         01JJBN4qmK+581d9OyFiFIm18e7LEHE0jsYGKVyY6ZgPshKy1ZEgHSV37Xp1KUgm5b5b
         3YZLrjDfbTUuN/iiQHpbfO7mNgXMGxwP+mfZqaYXERMkEjt0oe6AiPU1R5TFtieEIdSG
         fTKkl2CaNBzvOQwxDVezgBcGfKFt7YWGJFvwsZpw7TvLnfIiRYsHlm7ldfcTGA/tLzie
         O7mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=e00DtrmoNRlIdmT1VDi70gbbGHpjoruQVSiVeaJbol8=;
        b=fBxmiJrHvW6mFL3B3WSnnQbhaRrDajSR4LNOCXhiADWNv9TPuduopUfnBzuMx8U4ym
         CAK3LlbuQitPgSgX/fgNJaL7UcDY4IjpmbzNNuCK/MvF6UPdGRQpmb7PNTgcNzp6JIUz
         ond2lrbvxYasaM9PVgxGxBnn4bYtvGFr1dywUfR13GoCjsaLJZK4uvlEcUhntUrvMZ3p
         ykyEZ3mMLqocl+jUq+elo2ifYpPi5R0y1dK05i065SgBW/ZcJBfhMtYQyTPG5SS6tQI7
         3aTXu8EupXRrCk1+xjvg9QazbtGEBw6KUovv4/HdfLK1c0o8gKFp44rvrC2IP3WeHBXm
         2Bjg==
X-Gm-Message-State: APjAAAUq0oEDw0WnjFFTPN8mvIlyiaGuYgFtc/DSpVi3PP/tAxGmugeV
        +5RJYA+0IylO2/v5syxXtX6Cl1lJ52PaXQPsdxo=
X-Google-Smtp-Source: APXvYqwt91SSs/fCpWvt5NtOTAoVpqXXvMGfeQjEEO+V3HRmWzfTNcmHN5Fs07ix3up48LhXCIcTL2WMM59AVtfk9q8=
X-Received: by 2002:a05:6830:16c5:: with SMTP id l5mr752095otr.165.1582839098764;
 Thu, 27 Feb 2020 13:31:38 -0800 (PST)
MIME-Version: 1.0
References: <20200225200219.6163-1-william.c.roberts@intel.com>
 <CAEjxPJ42+p_Ppo6SqJCu-em2HXv1hyaY6ziCb0TrqTMBLg_Gag@mail.gmail.com>
 <CAFftDdpG-t4Zo9Ro8xJyxkd6zQ8FoyaTqfQrvG8kcbtP94Xf1Q@mail.gmail.com>
 <CAFftDdomj5C35JLZCx9ATaUcS7Lg3izWx8M5CAX6DPhNuZs62g@mail.gmail.com>
 <CAEjxPJ4wZw=g1QW9gSPL_2tu9E12oJnX2OYPmTKCZqZQH6StKw@mail.gmail.com>
 <CAFqZXNtRmp-TiNupX3xgOWiBYun4gK0E3TJcoo4-_b2RF2+Duw@mail.gmail.com>
 <19b672ed-e4d6-5c14-6839-a9203690b7e1@redhat.com> <CAFftDdri97VAa8jwN+3JcLW90mFXjEBMfPnynix=ZpYW6R51rA@mail.gmail.com>
 <CAEjxPJ7=WO0CO3Wj=KLMzH56Fg=WMbjjJHN+qAh+e30juKdVgw@mail.gmail.com> <CAFftDdpx7UsNqgSUwZsQBnTGHUTrOkT5d7n-rGCn1djTVTjvFQ@mail.gmail.com>
In-Reply-To: <CAFftDdpx7UsNqgSUwZsQBnTGHUTrOkT5d7n-rGCn1djTVTjvFQ@mail.gmail.com>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Thu, 27 Feb 2020 16:32:48 -0500
Message-ID: <CAEjxPJ7aR_bd79yQMb+KwJUZBMkOFRfntgqjDpTh1zrV5nw4sw@mail.gmail.com>
Subject: Re: Annotate Deprecated Functions in libselinux
To:     William Roberts <bill.c.roberts@gmail.com>
Cc:     Ulrich Drepper <drepper@redhat.com>,
        Ondrej Mosnacek <omosnace@redhat.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        Petr Lautrbach <plautrba@redhat.com>,
        SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Feb 27, 2020 at 4:19 PM William Roberts
<bill.c.roberts@gmail.com> wrote:
>
> On Thu, Feb 27, 2020 at 3:11 PM Stephen Smalley
> <stephen.smalley.work@gmail.com> wrote:
> > That just controls what is exported.  The hidden_proto/hidden_def
> > stuff is to ensure that when libselinux calls one of its own exported
> > symbols, that symbol resolves to the actual libselinux implementation
> > and not something provided by some other DSO earlier in the search
> > path, which is otherwise possible.
>
> Sure, but do we actually care about that?
>
> If we actually do care, we could throw a script in the build to make sure
> anything in the linker script map is not used internally.
>
> Right now, all this DSO hygiene and look up protection is opt-in, which
> usually always results in missed cases. With the linker script, it's opt-out,
> which is usually always how you want to do things.

There are lots of cases where libselinux calls one of its own exported
symbols, so you can't just prohibit that.
-fno-semantic-interposition sounds like the right solution to me, and
appears to be the default in clang.
Dropping the hidden_def/hidden_proto stuff without enabling
-fno-semantic-interposition could potentially break because
libselinux could suddenly start using some external implementation of
one of its own functions.
Adding a map file and defaulting to hidden visibility would be a good
idea but is separate.
