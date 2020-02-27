Return-Path: <SRS0=cYHv=4P=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4379BC3F2C2
	for <selinux@archiver.kernel.org>; Thu, 27 Feb 2020 21:34:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15F5B24677
	for <selinux@archiver.kernel.org>; Thu, 27 Feb 2020 21:34:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GcW053if"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729534AbgB0Vey (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 27 Feb 2020 16:34:54 -0500
Received: from mail-il1-f180.google.com ([209.85.166.180]:43910 "EHLO
        mail-il1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726460AbgB0Vey (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 27 Feb 2020 16:34:54 -0500
Received: by mail-il1-f180.google.com with SMTP id p78so889593ilb.10
        for <selinux@vger.kernel.org>; Thu, 27 Feb 2020 13:34:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=K6Spdyi5VN+EFMiFz445u9kJ1zzBqzRRsob+1EIfEsU=;
        b=GcW053if2TDUuMnT1AvzLayyIqg9O5wKpqQg/Fmb3iYCYfqrc4wwo9TtkfxUoJO0vz
         yxpSdjrjtf2nlHSdhOQ28x80jyd5V1gjXLpOfcunDBWGxdjTmBVuOFgoJ1Gwdr5WFAdF
         gyY++8ekvX3T6mAeY7aZT95F/PyMuxMeWpBp22y0i4PD8ZBWJ9gRVzrPCwoUm0xp+gPE
         OZc3EeEUxhKgRJsoN6OW4Q19/c0yjYSemIhxd8KCwQZMxFh3auCmRgCrND9bvWzJ9E7c
         kvn2G6myBAY7kzQA32u4jueWoYOxd9HKFjkXnlJ06G9B8yiajxeIebJzJ371VNlybXx4
         MBxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=K6Spdyi5VN+EFMiFz445u9kJ1zzBqzRRsob+1EIfEsU=;
        b=tA6ic2mp6UjHf9dBSYabLaPdT3B9OGqMR4J9UtEHuol3tsF7Ko8/zjXYYQ3mwEqoYA
         msaiWCW2AMGd6csuC4yFb+Z/DMvAgXk7jkYQ3Stfm7g6xbg4ytdzattb2XfeewYoAfnc
         Mhi7+po5RtBNvEaPQ0LopyLJGfiN7WLZj4NkFFUYlzKv/tDrYyltcL/H2Al/Nx7r+54Y
         e3ZnAYmn8Mv7IiwYgcF79aPfR+7m8x3gX6rEZOWAA5VFU0qyewkRaDudHw3iRD1HK+5c
         639YdUPq/crPkCK2cEyFgzCTIBHdG8rlEdsZh4edpOjCqN4RuWvJ3lVSM6yLJWnjBmkr
         WHqg==
X-Gm-Message-State: APjAAAUNqmanGFV6SfmkIDbq18YFuWSI+TBUffQ1kbVUR21p1s8zcyQO
        yq26VQlXsri/vHtHTZ3a7QKFSoHRP6wQ17/QzgIV/Q==
X-Google-Smtp-Source: APXvYqzHnHoESEuuF/SasAW273A9ij7FNu1CpUwSBQVBQosJy1oQaJJYirCEKSL7cjani0c1JbVyBZ1iaMBK80jlSNA=
X-Received: by 2002:a92:811c:: with SMTP id e28mr1384325ild.22.1582839293707;
 Thu, 27 Feb 2020 13:34:53 -0800 (PST)
MIME-Version: 1.0
References: <20200225200219.6163-1-william.c.roberts@intel.com>
 <CAEjxPJ42+p_Ppo6SqJCu-em2HXv1hyaY6ziCb0TrqTMBLg_Gag@mail.gmail.com>
 <CAFftDdpG-t4Zo9Ro8xJyxkd6zQ8FoyaTqfQrvG8kcbtP94Xf1Q@mail.gmail.com>
 <CAFftDdomj5C35JLZCx9ATaUcS7Lg3izWx8M5CAX6DPhNuZs62g@mail.gmail.com>
 <CAEjxPJ4wZw=g1QW9gSPL_2tu9E12oJnX2OYPmTKCZqZQH6StKw@mail.gmail.com>
 <CAFqZXNtRmp-TiNupX3xgOWiBYun4gK0E3TJcoo4-_b2RF2+Duw@mail.gmail.com>
 <19b672ed-e4d6-5c14-6839-a9203690b7e1@redhat.com> <CAFftDdri97VAa8jwN+3JcLW90mFXjEBMfPnynix=ZpYW6R51rA@mail.gmail.com>
 <CAEjxPJ7=WO0CO3Wj=KLMzH56Fg=WMbjjJHN+qAh+e30juKdVgw@mail.gmail.com>
 <CAFftDdpx7UsNqgSUwZsQBnTGHUTrOkT5d7n-rGCn1djTVTjvFQ@mail.gmail.com> <CAEjxPJ7aR_bd79yQMb+KwJUZBMkOFRfntgqjDpTh1zrV5nw4sw@mail.gmail.com>
In-Reply-To: <CAEjxPJ7aR_bd79yQMb+KwJUZBMkOFRfntgqjDpTh1zrV5nw4sw@mail.gmail.com>
From:   William Roberts <bill.c.roberts@gmail.com>
Date:   Thu, 27 Feb 2020 15:34:41 -0600
Message-ID: <CAFftDdqtjac92yfbumnGXjfa4tba3ghN0WBqbn9dM7myhjQ4Nw@mail.gmail.com>
Subject: Re: Annotate Deprecated Functions in libselinux
To:     Stephen Smalley <stephen.smalley.work@gmail.com>
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

On Thu, Feb 27, 2020 at 3:31 PM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Thu, Feb 27, 2020 at 4:19 PM William Roberts
> <bill.c.roberts@gmail.com> wrote:
> >
> > On Thu, Feb 27, 2020 at 3:11 PM Stephen Smalley
> > <stephen.smalley.work@gmail.com> wrote:
> > > That just controls what is exported.  The hidden_proto/hidden_def
> > > stuff is to ensure that when libselinux calls one of its own exported
> > > symbols, that symbol resolves to the actual libselinux implementation
> > > and not something provided by some other DSO earlier in the search
> > > path, which is otherwise possible.
> >
> > Sure, but do we actually care about that?
> >
> > If we actually do care, we could throw a script in the build to make sure
> > anything in the linker script map is not used internally.
> >
> > Right now, all this DSO hygiene and look up protection is opt-in, which
> > usually always results in missed cases. With the linker script, it's opt-out,
> > which is usually always how you want to do things.
>
> There are lots of cases where libselinux calls one of its own exported
> symbols, so you can't just prohibit that.
> -fno-semantic-interposition sounds like the right solution to me, and
> appears to be the default in clang.

Interesting to note.

> Dropping the hidden_def/hidden_proto stuff without enabling
> -fno-semantic-interposition could potentially break because
> libselinux could suddenly start using some external implementation of
> one of its own functions.

Conjecture.

> Adding a map file and defaulting to hidden visibility would be a good
> idea but is separate.

IIUC, not really, the current code attempts to limit our exported symbols.

You would need both the compiler option and a map file to keep functional
parity with whats there. Which is fine, that's easy enough to do and should
be some welcome housekeeping.
