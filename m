Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32877C197A0
	for <selinux@archiver.kernel.org>; Thu, 16 Nov 2023 14:57:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229785AbjKPO5D (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 16 Nov 2023 09:57:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235331AbjKPO5C (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 16 Nov 2023 09:57:02 -0500
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 396C193
        for <selinux@vger.kernel.org>; Thu, 16 Nov 2023 06:56:59 -0800 (PST)
Received: by mail-lf1-x136.google.com with SMTP id 2adb3069b0e04-507975d34e8so1266366e87.1
        for <selinux@vger.kernel.org>; Thu, 16 Nov 2023 06:56:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700146617; x=1700751417; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dznCtozSizrnMwBv+mkyD7mNLFulylYQnyDBQXGl8uU=;
        b=knIY7eSvnPSMjXUXucMfKeziPW3M89IoiVXmNObVlgsgpDAfbpHLSTTEloASj9Qq+X
         12ejOTmPhsKoUWEyPMv/5BW9NMf3Arfh9HjWr1BUF1dcRLQtaUOlqR8BHemVCz4JYXLs
         GaZuQuttMPJdRbPaPyrQUej5eCuyosunfEreNY6TEESerIBk6ndJwmNEQPVtBgFliWds
         yIsp99+0KvGUDq+AeRTr21/xgwm1a0aRoSmWIOCu2brtRepn+x0dxs8VJLfUkkVcxSHC
         J4e5ryzX638wY+oQkS1aKGyKMHFuVil5gIvtnJdHmnNs85B31yqLOuLj8EBcI1B5Ybt/
         xqPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700146617; x=1700751417;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dznCtozSizrnMwBv+mkyD7mNLFulylYQnyDBQXGl8uU=;
        b=eVwF46vTsaCvO44egctditoNk/Ob0Hp6aEvaCimv9IVb+n3OsFyCMWlg4mrFTu37VA
         XZF3ITkMthbc5/ekNJvh28e98z7X3b4YKr9v97OtKAiZQtJdy5al5dUXYZ4k8Seaj6Bx
         /zpID64PlNYjRGrEZeJVL1oiZpEKVxZ7WOyh1JtzXmpD+9lc0aAoJ/784h10N8EtzuX2
         X5LnR5pTRfxP+cXyhowR42MTBPnJodlMoJxEMiAyZi/bEiUHYyx2m/E6cAQUvpMWi3rY
         4PlQPpTnbdoz9q30ThTRX/Odr/KBYNf3bM2JwVx//6LVTJ8tfB7wIZHz5Fe3htdx3/KH
         nb1Q==
X-Gm-Message-State: AOJu0YzrvavjOwSp+JZJpcGM4CEkwSvitZAqcKOBBNV5sqspB0EBJn/X
        SIXXsmd+Hqx7nE0JcducprGBnGtn5IsyviJCW5I=
X-Google-Smtp-Source: AGHT+IHpkE5lu24MJnk2tO125ACwmnSUONW/msTiFEMbb++VCeLTzkU2e1zwCWuOroDUNOwvDiZK5UaIPWrDMVIjBpA=
X-Received: by 2002:ac2:5302:0:b0:507:aa44:28fa with SMTP id
 c2-20020ac25302000000b00507aa4428famr10757551lfh.26.1700146617181; Thu, 16
 Nov 2023 06:56:57 -0800 (PST)
MIME-Version: 1.0
References: <20231109135315.44095-1-cgzones@googlemail.com> <CAP+JOzRd6GbNJXykF-0jCscXyvxntBvZpF-sE1wiKwSt3paZRw@mail.gmail.com>
In-Reply-To: <CAP+JOzRd6GbNJXykF-0jCscXyvxntBvZpF-sE1wiKwSt3paZRw@mail.gmail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Thu, 16 Nov 2023 09:56:45 -0500
Message-ID: <CAP+JOzSZXP-4HbwSe=k9ixnVk0f1JV6dob-AWtcpaeGNFUKX_A@mail.gmail.com>
Subject: Re: [PATCH 1/5] semodule_link: avoid NULL dereference on OOM
To:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Nov 13, 2023 at 4:43=E2=80=AFPM James Carter <jwcart2@gmail.com> wr=
ote:
>
> On Thu, Nov 9, 2023 at 8:53=E2=80=AFAM Christian G=C3=B6ttsche
> <cgzones@googlemail.com> wrote:
> >
> > In case the initial calloc(3) call fails the variable mods is still NUL=
L
> > while its size hint num_mods is set.
> >
> > Reported by Clang Analyzer:
> >
> >     semodule_link.c:182:29: warning: Array access (from variable 'mods'=
) results in a null pointer dereference [core.NullDereference]
> >       182 |                 sepol_module_package_free(mods[i]);
> >           |                                           ^~~~~~~
> >
> > Fixes: 63e798a2034a ("semodule_link: update")
> >
> > Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>
> For these five patches:
> Acked-by: James Carter <jwcart2@gmail.com>
>

These five patches have been merged.
Thanks,
Jim

> > ---
> >  semodule-utils/semodule_link/semodule_link.c | 8 +++++---
> >  1 file changed, 5 insertions(+), 3 deletions(-)
> >
> > diff --git a/semodule-utils/semodule_link/semodule_link.c b/semodule-ut=
ils/semodule_link/semodule_link.c
> > index 0f157bd9..58fca34d 100644
> > --- a/semodule-utils/semodule_link/semodule_link.c
> > +++ b/semodule-utils/semodule_link/semodule_link.c
> > @@ -178,9 +178,11 @@ failure:
> >         ret =3D EXIT_FAILURE;
> >
> >  cleanup:
> > -       for (i =3D 0; i < num_mods; i++)
> > -               sepol_module_package_free(mods[i]);
> > -       free(mods);
> > +       if (mods) {
> > +               for (i =3D 0; i < num_mods; i++)
> > +                       sepol_module_package_free(mods[i]);
> > +               free(mods);
> > +       }
> >         sepol_module_package_free(base);
> >
> >         return ret;
> > --
> > 2.42.0
> >
