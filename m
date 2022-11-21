Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0663C4332F
	for <selinux@archiver.kernel.org>; Mon, 21 Nov 2022 20:57:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229553AbiKUU5R (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 21 Nov 2022 15:57:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229782AbiKUU5R (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 21 Nov 2022 15:57:17 -0500
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 715FED02DA
        for <selinux@vger.kernel.org>; Mon, 21 Nov 2022 12:57:15 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id z20so16475964edc.13
        for <selinux@vger.kernel.org>; Mon, 21 Nov 2022 12:57:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EQ/QYuuDlM3/K3G/w+U4rtON6y/qGWjgneHz3DC9lVU=;
        b=KuTWSA5esPaCsbpIccFlQg6Ke0D0b0K7NcxKTvnKLWOT3ligZ7eMLoWj8AB5qHSPwl
         kO9BLSJWfUlU0WYak2rDlZLWQ2xS42vontUbRZNGy5g6e/6plIPl5pEp73Po18gTmumP
         vHzv35CgLNUZAKH5L8GT+W8d3DLpI/4hqqb1eonkN4pTopPGGhwPzwtbQIcWfxJ33Eir
         5LEbOt9QmgSvZg8Fka0ViE60S+hlZUNglNnH8HTohL7XgQEFOdTRSMyyDrBDzH/AVYeO
         yYQzRhKlEZu/QE0t8VDhgp4a5OSbuCdyKZvdzLhtJt79YsINd7brltmmA2DnGgZ4fFjN
         jbtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EQ/QYuuDlM3/K3G/w+U4rtON6y/qGWjgneHz3DC9lVU=;
        b=zt07TvpPd/xydcPgXN6dg15znAUca5cYLpTLNHhG0J0TqbUFVkhbfhVtrCwyVnl4qq
         ZashU8ih1/VR7gmX55zXCyKgbJeQEYNatp7H2JaPKMu5FzqkE5pSjcZ9RndY250Uik5G
         SVtjymSUPBrJ3RUfVTbYSrf5PRsa+1ZxotohQWxzOZXAUjHcaPlyN0ztZlEWS0K6SpTf
         8KZIhjWyIiP7dUY9nJZnS88Lsx4psaIqeTfEay5gFP7oYhy93/iAin/jEdIxOHTB3QON
         Zp0Xa5zUpfI6/p7x6dkeiiwlAukGqM0msK+Ml/Qh3prOTLM+ejlQtx9Udr1WkU+VAcfJ
         kKkQ==
X-Gm-Message-State: ANoB5pkZh6yXpjAyaLELUfKF075zpGbKIA5M4zm9HbZFjSU1Qg5sN7xE
        rYIFPJHic9GmbXsKofrgqes2oITcgRUlDDWBaTQ=
X-Google-Smtp-Source: AA0mqf52kUTc1kOFaK6jyK/Nd8X70cdTAM5B4ES0tReUGVTnf0VDn4PmIAC/0CcALn135FQnVCyDfX1IuSUVdkwVLCY=
X-Received: by 2002:a05:6402:2b87:b0:45b:c731:b683 with SMTP id
 fj7-20020a0564022b8700b0045bc731b683mr18935890edb.251.1669064235018; Mon, 21
 Nov 2022 12:57:15 -0800 (PST)
MIME-Version: 1.0
References: <20221114194031.12245-1-cgzones@googlemail.com> <CAP+JOzTTB1vSnjza25P0HkCVXQKe+YaaNERGQav9LU6Pkv1O_Q@mail.gmail.com>
In-Reply-To: <CAP+JOzTTB1vSnjza25P0HkCVXQKe+YaaNERGQav9LU6Pkv1O_Q@mail.gmail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Mon, 21 Nov 2022 15:57:03 -0500
Message-ID: <CAP+JOzRHYqij6df4ebQu=4ZEooHox39DO-FY8gZ93WGE2gxxeQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] libsepol/tests: use more strict compiler options
To:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Nov 17, 2022 at 4:25 PM James Carter <jwcart2@gmail.com> wrote:
>
> On Mon, Nov 14, 2022 at 2:42 PM Christian G=C3=B6ttsche
> <cgzones@googlemail.com> wrote:
> >
> > Use the more strict C compiler warnings from the root Makefile.
> >
> > Also fail on warnings from the m4 macro processor.
> >
> > Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>
> For these two patches:
> Acked-by: James Carter <jwcart2@gmail.com>
>
These two patches have been merged.
Thanks,
Jim

> > ---
> >  libsepol/tests/Makefile            | 19 +++++++++++++++++--
> >  libsepol/tests/test-linker-roles.c |  2 +-
> >  2 files changed, 18 insertions(+), 3 deletions(-)
> >
> > diff --git a/libsepol/tests/Makefile b/libsepol/tests/Makefile
> > index a72c327d..273373b0 100644
> > --- a/libsepol/tests/Makefile
> > +++ b/libsepol/tests/Makefile
> > @@ -1,9 +1,24 @@
> >  ENV ?=3D env
> > -M4 ?=3D m4
> > +M4 ?=3D m4 -E -E
> >  MKDIR ?=3D mkdir
> >  EXE ?=3D libsepol-tests
> >
> > -CFLAGS +=3D -g3 -gdwarf-2 -O0 -Wall -W -Wundef -Wmissing-noreturn -Wmi=
ssing-format-attribute -Wno-unused-parameter -Werror
> > +CFLAGS +=3D -g3 -gdwarf-2 -O0 \
> > +       -Werror -Wall -Wextra \
> > +       -Wfloat-equal \
> > +       -Wformat=3D2 \
> > +       -Winit-self \
> > +       -Wmissing-format-attribute \
> > +       -Wmissing-noreturn \
> > +       -Wmissing-prototypes \
> > +       -Wnull-dereference \
> > +       -Wpointer-arith \
> > +       -Wshadow \
> > +       -Wstrict-prototypes \
> > +       -Wundef \
> > +       -Wunused \
> > +       -Wwrite-strings \
> > +       -fno-common
> >
> >  # Statically link libsepol on the assumption that we are going to
> >  # be testing internal functions.
> > diff --git a/libsepol/tests/test-linker-roles.c b/libsepol/tests/test-l=
inker-roles.c
> > index 2b17dffd..b35bdbe6 100644
> > --- a/libsepol/tests/test-linker-roles.c
> > +++ b/libsepol/tests/test-linker-roles.c
> > @@ -53,7 +53,7 @@
> >
> >  /* this simply tests whether the passed in role only has its own
> >   * value in its dominates ebitmap */
> > -static void only_dominates_self(policydb_t * p, role_datum_t * role)
> > +static void only_dominates_self(policydb_t * p __attribute__ ((unused)=
), role_datum_t * role)
> >  {
> >         ebitmap_node_t *tnode;
> >         unsigned int i;
> > --
> > 2.38.1
> >
