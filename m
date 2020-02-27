Return-Path: <SRS0=cYHv=4P=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A724AC11D3D
	for <selinux@archiver.kernel.org>; Thu, 27 Feb 2020 18:41:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 807D724695
	for <selinux@archiver.kernel.org>; Thu, 27 Feb 2020 18:41:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CPn1dc7l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729402AbgB0Slz (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 27 Feb 2020 13:41:55 -0500
Received: from mail-io1-f67.google.com ([209.85.166.67]:34271 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729297AbgB0Slz (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 27 Feb 2020 13:41:55 -0500
Received: by mail-io1-f67.google.com with SMTP id z190so610348iof.1
        for <selinux@vger.kernel.org>; Thu, 27 Feb 2020 10:41:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=CCshew0TWqkhvpz1FPg7Hb5fw6A1hQQarAix8oFd/OI=;
        b=CPn1dc7l9MS1gTfZNB1Q5P18LRbppP6CZrind6dyJL4/juyQMrcvTfsaWLKMRNC6uX
         6ts2bTvQR5d5XThN9751p4SObT8YtzmHr1IN8XzYwGoTfpK0tMrKIdFsybF7lO/kfPLN
         0vBk/y0O2kKiPSafBe5XWjcALkO/I7gKBUjqhCByzj8cpudVhk1AXILEp/r6I+YJWflB
         LWBvF0z2R/1UU3/SSsE/vvnLlV5Ur/wb4ip86pnvQ8XANaGSvBkccaUGpCOoOKPBI4RS
         MPtXPVy+9hKdUBMiOv8fXyPLWPbsrOYyJfhPR5AMeHubrD5MgwR++ijtWo7H+9LpcBtT
         UZXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=CCshew0TWqkhvpz1FPg7Hb5fw6A1hQQarAix8oFd/OI=;
        b=jAkrmIFXCDc19B5Pj0O7glSo5Twxg/8a2wHYq7AxTxRYF+Ki0niBGqkXzUJCkniLY1
         3qszPUsRle6oD0pveSCstw+iQd7Mlsthl25AsUxqmtAnWe/zqVJT76+7jC8UqjUgIHsG
         UdHl261quezMQJdeKSfB6p4UBZC47bk7V/2WE0rfznxnGQVuhmEkK+7UK+l5HYqTNcLT
         3sIRLkOuDLgsOSQOtturXJogwstDFIaNxkjc5i/bD180xn/AH0wijUHHyH2/FB+HqdI9
         Qahsafl/WNQh3+GgFPb+8W9vOf3OD/y0YXMvu0GRsOkmpiCiuv8bF9EoUYAwtKuqyHl/
         QfKg==
X-Gm-Message-State: APjAAAWtLM3UD3Rze5RqgAhTivk8OdHS2kxk5ZvCrfNxAB4R4c9uzT4x
        /EMRzl0rg8XWXx3Zl8tVPsZXkk57VrbN/2jLIvo=
X-Google-Smtp-Source: APXvYqxyUyf04a/Kwu2ysgeZnrRUAUM0Yy3N4kTUd6GEOlzWW8InnbVXhT6/T6kfqR2oXDef1fyIsqAj0rEiYt2Proo=
X-Received: by 2002:a6b:6e02:: with SMTP id d2mr597478ioh.22.1582828914246;
 Thu, 27 Feb 2020 10:41:54 -0800 (PST)
MIME-Version: 1.0
References: <20200225200219.6163-1-william.c.roberts@intel.com>
 <CAEjxPJ42+p_Ppo6SqJCu-em2HXv1hyaY6ziCb0TrqTMBLg_Gag@mail.gmail.com> <CAFftDdpG-t4Zo9Ro8xJyxkd6zQ8FoyaTqfQrvG8kcbtP94Xf1Q@mail.gmail.com>
In-Reply-To: <CAFftDdpG-t4Zo9Ro8xJyxkd6zQ8FoyaTqfQrvG8kcbtP94Xf1Q@mail.gmail.com>
From:   William Roberts <bill.c.roberts@gmail.com>
Date:   Thu, 27 Feb 2020 12:41:42 -0600
Message-ID: <CAFftDdomj5C35JLZCx9ATaUcS7Lg3izWx8M5CAX6DPhNuZs62g@mail.gmail.com>
Subject: Re: Annotate Deprecated Functions in libselinux
To:     Stephen Smalley <stephen.smalley.work@gmail.com>
Cc:     Stephen Smalley <sds@tycho.nsa.gov>,
        Petr Lautrbach <plautrba@redhat.com>,
        SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Feb 25, 2020 at 3:06 PM William Roberts
<bill.c.roberts@gmail.com> wrote:
>
> On Tue, Feb 25, 2020 at 2:49 PM Stephen Smalley
> <stephen.smalley.work@gmail.com> wrote:
> >
> > On Tue, Feb 25, 2020 at 3:03 PM <bill.c.roberts@gmail.com> wrote:
> > > The annoying part is internal users of the routines. We could always =
make
> > > a v2 version of the function for internal callers, and leave the old
> > > interfaces intact to work around the warnings, or just pragma them ou=
t.
> > > This series pragma's them out.
> > >
> > > diagnostic push has been supported since GCC v4.6. Earlier versions w=
ill
> > > warn on this, and the sideffect is that the diagnostic ignored pragma
> > > will be valid for the rest of the file. Clang has similair support th=
ats
> > > been around *at least* since clang 6.0.
> >
> > My inclination (and others are free to disagree) would be to rename
> > the deprecated functions for internal users (and mark them hidden),
> > and add stubs for the old interfaces that call the hidden functions to
> > avoid the need for this pragma.
>
> I'm actually leaning that way myself after thinking about it more.

It doesn't get us around all the issues, anything marked deprecated in seli=
nux.h
and marked hidden_proto in selinux_internal.h, will still need a pragma.

This would be much simpler if we drop the whole hidden_proto stuff, I guess
kloczek is proposing patches? Who is that, I see the Github name as:
Tomasz K=C5=82oczko

But I can't find any matching author in the git logs to CC them.

I'm looking at those macros:
hidden_def
hidden_proto

They both seem to take a function and create an _internal symbol, and
set the global symbol equal to the internal one. Essentially, both the
normal and _internal functions are pointing to the same address.

$ readelf -s ./src/libselinux.so | grep setexeccon_raw
   176: 0000000000017c26    63 FUNC    GLOBAL DEFAULT   12 setexeccon_raw
   279: 0000000000017c26    63 FUNC    LOCAL  DEFAULT   12
setexeccon_raw_internal
   606: 0000000000017c26    63 FUNC    GLOBAL DEFAULT   12 setexeccon_raw

The hidden one, additionally
sets the visibility to hidden, which if IIUC, just requires one to
statically link. We can see above the
visibility is local.

What I don't understand, is why one would do this? What actual
performance enhancement do we get?

>
> > Also, FWIW, there is a push to remove
> > the hidden_def/hidden_proto stuff for LTO, see
> > https://github.com/SELinuxProject/selinux/issues/204, although I don't
> > yet know how that will turn out for libselinux.
>
> Good to know.
