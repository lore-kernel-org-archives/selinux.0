Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D461EC001DB
	for <selinux@archiver.kernel.org>; Fri,  4 Aug 2023 18:38:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229564AbjHDSiB (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 4 Aug 2023 14:38:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230060AbjHDShH (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 4 Aug 2023 14:37:07 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D32C5254
        for <selinux@vger.kernel.org>; Fri,  4 Aug 2023 11:36:36 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id 38308e7fff4ca-2ba0f27a4c2so34744711fa.2
        for <selinux@vger.kernel.org>; Fri, 04 Aug 2023 11:36:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691174194; x=1691778994;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xiWD7fsxgHNHT2bOYaDqjsO4OoIfZu4ul6+R5HKBdPk=;
        b=QMbEyS33au3RulKUjqoSzKRdRIHjAfxivuA7xPQJicDLOyU7RTn7uk3CgndUbO4fbE
         pJdMDFBYpbKEifr65F/Y/Hd8XQdxd7lDcWtosQlCKzyQIN5rS7LpQmKKUJXXwgx4Tsnb
         ueJjEIogxEA5sKELh/kkaal/3bWc4OiEzVDE2zLIZzCNOoyIZH0QSSlm/oMFwbd8Tz3F
         gKb2hh0SElLQ9cFbVI/W0XfKiHJJrV8gucQbq7CHiEAcmovRymzUDguRnsJHMIkyJgzA
         MHqxkBTixiyDge0DFpDyQ9138TzhgHQrwFaG/syKyWLAdIUSC2i05e3Rc6Vi20Lx6XEv
         +h1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691174194; x=1691778994;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xiWD7fsxgHNHT2bOYaDqjsO4OoIfZu4ul6+R5HKBdPk=;
        b=lLCO7XuyMoVUzKUSl2X2MD+67wXkcMNuZ6ivitNcpKCAv1Co6tqk3AM2fJQ6wtNBSp
         3HaW9Mx+Ub4E1Xncoh++Wpv4mWbaUA6w2Z2plqbs9eOEinWdsjQG69rUsZD+G13gVce/
         tm2Ekvgi8v1vnrLIr+UOsVSFtTlb6xNLd3NZWb6IA4j/XHmP/ZwHn4B17wp8KyfaeE3p
         h2NNc/BK0avrkjvkekV9DcsVBwAJq0Dd9X7sbOQpqS85ToDlel7OatxnEFfN0TYDfKUX
         0SQAF/ew0BOIFqh+b2yqLSO7y0VNL+jecPtO16Q1Sk+7Pg97e+f3u84rDzuCN0ShzsVV
         oJbQ==
X-Gm-Message-State: AOJu0YzmRop+j1Lq4VppLOFYUjNwBKR6XEXhl890LRVhLAh2jU0/TdAZ
        9aTq9HzG/6av2ZZPA4neUMN65UjH1QezZsIaVPyuDxjG
X-Google-Smtp-Source: AGHT+IF5EW1sYvvS8OPRh15v9kWnE8xZ1q/4Zj6Nh+t9vLWCL05GSm8nolXW4x8H5mkYy6caxssTpxhVWFseEcnPLAA=
X-Received: by 2002:a2e:959a:0:b0:2b9:c005:c1e5 with SMTP id
 w26-20020a2e959a000000b002b9c005c1e5mr2179523ljh.34.1691174194313; Fri, 04
 Aug 2023 11:36:34 -0700 (PDT)
MIME-Version: 1.0
References: <20230706141801.58737-1-cgzones@googlemail.com> <CAP+JOzR7zmVzTPdM5dBrbwKGuBZFw2C+Uxa_eLGV=RSjKiMUJw@mail.gmail.com>
In-Reply-To: <CAP+JOzR7zmVzTPdM5dBrbwKGuBZFw2C+Uxa_eLGV=RSjKiMUJw@mail.gmail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Fri, 4 Aug 2023 14:36:22 -0400
Message-ID: <CAP+JOzSjkFjbRPOfUFkNk71+28S=9DGj2JduXaMCtO8KHXuJaA@mail.gmail.com>
Subject: Re: [PATCH] setsebool: drop unnecessary linking against libsepol
To:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Aug 2, 2023 at 3:21=E2=80=AFPM James Carter <jwcart2@gmail.com> wro=
te:
>
> On Thu, Jul 6, 2023 at 10:43=E2=80=AFAM Christian G=C3=B6ttsche
> <cgzones@googlemail.com> wrote:
> >
> > setsebool does not directly use any symbols from libsepol.  Any
> > transitional ones, via libsemanage, are available by linking against
> > libsemanage.
> >
> > Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>
> Acked-by: James Carter <jwcart2@gmail.com>
>

Merged.
Thanks,
Jim

> > ---
> >  policycoreutils/setsebool/Makefile | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/policycoreutils/setsebool/Makefile b/policycoreutils/setse=
bool/Makefile
> > index 4b55046c..c1440c1c 100644
> > --- a/policycoreutils/setsebool/Makefile
> > +++ b/policycoreutils/setsebool/Makefile
> > @@ -6,7 +6,7 @@ MANDIR =3D $(PREFIX)/share/man
> >  BASHCOMPLETIONDIR ?=3D $(PREFIX)/share/bash-completion/completions
> >
> >  CFLAGS ?=3D -Werror -Wall -W
> > -override LDLIBS +=3D -lsepol -lselinux -lsemanage
> > +override LDLIBS +=3D -lselinux -lsemanage
> >  SETSEBOOL_OBJS =3D setsebool.o
> >
> >  BASHCOMPLETIONS=3Dsetsebool-bash-completion.sh
> > --
> > 2.40.1
> >
