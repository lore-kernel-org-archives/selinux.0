Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 325D0C77B7A
	for <selinux@archiver.kernel.org>; Fri,  2 Jun 2023 12:54:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229538AbjFBMyn (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 2 Jun 2023 08:54:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234971AbjFBMym (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 2 Jun 2023 08:54:42 -0400
Received: from mail-ua1-x932.google.com (mail-ua1-x932.google.com [IPv6:2607:f8b0:4864:20::932])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54AB31A6
        for <selinux@vger.kernel.org>; Fri,  2 Jun 2023 05:54:40 -0700 (PDT)
Received: by mail-ua1-x932.google.com with SMTP id a1e0cc1a2514c-786e37900fbso385292241.1
        for <selinux@vger.kernel.org>; Fri, 02 Jun 2023 05:54:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20221208; t=1685710479; x=1688302479;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6oOjWOnZjOqxKTHRRdlxR1Oyh68pR+go1KcfMgbTVLo=;
        b=kttywS1xoZfJlhILKEF+6bq9nFjuKQtZhvx4hA7iDFejd2O3MsBnZZvuTNXJpOF5H4
         ymnpi9pOK11pvc2WH6LWz9v4CaaXiEAl/pjVT4+F8gU1JFKVRevqvHb1Av9RqaaPqQTD
         uJPlT6LMTZdAaHUpdhvIO+byUu1Xnwn+Q425n5yp+XbleKeMJnlCK3cNsZuri7zOr1Fi
         nKpdgnCqpnZMuy3gWOW93Us7LFkrmXpnX7CmksZlJBfuVBPghWKkjgK9gVDrD9R2qko7
         sWPTri/VveFbHdFK+L6arpYv0M+H1O/lYf2xhdsIYpmGuxJk6Lce77sa+WUdFLyd2z/r
         wN+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685710479; x=1688302479;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6oOjWOnZjOqxKTHRRdlxR1Oyh68pR+go1KcfMgbTVLo=;
        b=Ct59ww2ivvhJgvnuG3vRfUNOATPa5jxp1fXBTUDmS9J9ZB9NT8JDIxYzcqriUXrjrR
         9s6jPWEicLyG6+Nc/2ODeyyqw1kbarOCh3iQLSORIKMKkFESHulPBqwEsuukJul4su9y
         mwlj5w9SXRRckcbdXKi+koV089ZbyqYMp6g/iDeNEYDVUxjlcBr7v4OOR9YOdY4XHDtc
         4ArW2RDJtg7AnLPFRuQpOR7dBkt5xwwQtYfMfjPB2R5rSVoQM8XNByYUrENsiufbh8ox
         P/qLzOvVp8jlCQ5nKK5gTk/w3ngOZ6/hpRD+EKpFoSX61vAEWsIwVY3P0ZSEjw9xSyft
         MgRQ==
X-Gm-Message-State: AC+VfDzFWaAwb8Ev7o8Jzjrt5FZMtVIsZEKD66zn1EFKZl+ZyFOWB/cZ
        uue43tBovG7BB78UaYsE9TTu602TjGMWF0RcUTqzZKdM77Q7Zg==
X-Google-Smtp-Source: ACHHUZ5eQuJDajEwfe3GxKB/+xVJ7Nkr5YxEp2D00dx8wOSJZY6Td6br+YQqOYTbiF1McAj1gGkqzl+2hivsNljxkVs=
X-Received: by 2002:a67:f853:0:b0:434:5d46:f297 with SMTP id
 b19-20020a67f853000000b004345d46f297mr3502233vsp.31.1685710479171; Fri, 02
 Jun 2023 05:54:39 -0700 (PDT)
MIME-Version: 1.0
References: <20230531011548.1133249-1-yamato@redhat.com> <87o7lyjcim.fsf@redhat.com>
In-Reply-To: <87o7lyjcim.fsf@redhat.com>
From:   =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Date:   Fri, 2 Jun 2023 14:54:28 +0200
Message-ID: <CAJ2a_Dd5tCrgoNQvhD+BZ7M7HSmGp026i2GooT6-ytq7WqYSZA@mail.gmail.com>
Subject: Re: [PATCH] Makefile: expand ~ in DESTDIR
To:     Petr Lautrbach <plautrba@redhat.com>
Cc:     Masatake YAMATO <yamato@redhat.com>, selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, 2 Jun 2023 at 14:05, Petr Lautrbach <plautrba@redhat.com> wrote:
>
> Masatake YAMATO <yamato@redhat.com> writes:
>
> > Though instructed as
> >
> >     DESTDIR=3D~/obj ./scripts/env_use_destdir make test

Is that a valid use case of the script `env_use_destdir`?
I thought the script is just for executing binaries depending on the
shared libraries in DESTDIR (e.g. `DESTDIR=3D~/obj
./scripts/env_use_destdir seinfo`), not for make invocations.

> >
> > in README.md, compiling policy_define.c was failed with following error=
s:
> >
> >     make[1]: Entering directory '/home/yamato/var/selinux/checkpolicy'
> >     cc -O2 -Werror -Wall -Wextra -Wfloat-equal -Wformat=3D2 -Winit-self=
 \
> >        -Wmissing-format-attribute -Wmissing-noreturn -Wmissing-prototyp=
es \
> >        -Wnull-dereference -Wpointer-arith -Wshadow -Wstrict-prototypes =
\
> >        -Wundef -Wunused -Wwrite-strings -fno-common -I~/obj/usr/include=
 \
> >        -o policy_define.o -c policy_define.c
> >     policy_define.c: In function =E2=80=98define_te_avtab_xperms_helper=
=E2=80=99:
> >     policy_define.c:2083:61: error: =E2=80=98RULE_NOTSELF=E2=80=99 unde=
clared (first use in this function); did you mean =E2=80=98RULE_SELF=E2=80=
=99?
> >      2083 |                         avrule->flags |=3D (add ? RULE_SELF=
 : RULE_NOTSELF);
> >         |                                                             ^=
~~~~~~~~~~~
> >         |                                                             R=
ULE_SELF
> >
> > because cc cannot find the directory ~/obj/usr/include passed via -I op=
tion.
> >
> > cc doesn't expand "~".
> >
> > Signed-off-by: Masatake YAMATO <yamato@redhat.com>
>
> It doesn't work when DESTDIR does not exist -  If no existing file name
> matches a pattern, then that pattern is omitted from the output of the
> wildcard function, see
> https://www.gnu.org/software/make/manual/html_node/Wildcard-Function.html
>
>
> Petr
>
> > ---
> >  Makefile | 6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
> >
> > diff --git a/Makefile b/Makefile
> > index 2ffba8e9..053c6d3d 100644
> > --- a/Makefile
> > +++ b/Makefile
> > @@ -26,11 +26,11 @@ else
> >  endif
> >
> >  ifneq ($(DESTDIR),)
> > -     LIBDIR ?=3D $(DESTDIR)$(PREFIX)/lib
> > +     LIBDIR ?=3D $(wildcard $(DESTDIR))$(PREFIX)/lib
> >       LIBSEPOLA ?=3D $(LIBDIR)/libsepol.a
> >
> > -     CFLAGS +=3D -I$(DESTDIR)$(PREFIX)/include
> > -     LDFLAGS +=3D -L$(DESTDIR)$(PREFIX)/lib -L$(LIBDIR)
> > +     CFLAGS +=3D -I$(wildcard $(DESTDIR))$(PREFIX)/include
> > +     LDFLAGS +=3D -L$(wildcard $(DESTDIR))$(PREFIX)/lib -L$(LIBDIR)
> >       export CFLAGS
> >       export LDFLAGS
> >       export LIBSEPOLA
> > --
> > 2.40.1
>
