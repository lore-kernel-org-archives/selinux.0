Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45B7CC433EF
	for <selinux@archiver.kernel.org>; Wed,  8 Jun 2022 13:40:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240270AbiFHNkx (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 8 Jun 2022 09:40:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240333AbiFHNkw (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 8 Jun 2022 09:40:52 -0400
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34E141D92C2
        for <selinux@vger.kernel.org>; Wed,  8 Jun 2022 06:40:46 -0700 (PDT)
Received: by mail-oi1-x229.google.com with SMTP id i66so28045889oia.11
        for <selinux@vger.kernel.org>; Wed, 08 Jun 2022 06:40:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=C7XXeH0bIvSuZTMyQ03g4bEsny6UERHyPSL+Y2dAjGo=;
        b=MvreLzyhmXI9oDT/PRR24fmBlXFeUw7ZDKc/imisu8MSHIVyDDMLjaAljYysChAOGp
         1aKvFiv3r1qArUt4u6Eee4waWI/iVczsAEgQlpZUca1g+MyLfLSO32hrUykTaf9N01pL
         FVDlibGn9Tl6YoR+7R6tTjA6jmsOzLHYAQKnjOZehnP4jsRcQWbFWers4g6QlghBYgbJ
         mmgnvtqciuq78edcvSimpZ/rM0ePvsetRei1md6abP9offRuCnBtmoby1BGS4+K/Lqxh
         Otkfz0hzn35yXWUeEmgVdyeFdRr7dDRw0oSf8Rj1cJWqJIZoM4GQ21LJ+bGx/xsAevBS
         eTvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=C7XXeH0bIvSuZTMyQ03g4bEsny6UERHyPSL+Y2dAjGo=;
        b=FkT5gneSaHZuSWt8GHyh/8hRezcdmsgp3F7R86aRTexQ9YlGvQqE9EBojIZPTt3qBl
         o9CGxIzoOvXUQtn0n0Rnc4lMd4DkEo8a5CImGb7EfhOsZKEsgtoxOkn1nbdrjGZrxbSP
         kgQg4bhn98SxYv5hTVRAXP+ofGMexsY+2nPk+rl4NgMd4jITiyGd8DZ/NINOTybfuLqx
         ZgeMtbitVa7DZygN0hzhrUkyoBHa027t1N9nLlC0lE7KiWYn5LIGBojaT4YwXeHHkDF2
         vuPVdmqf+3v9iCCEKfzSiENC8YCya9UVpo4icNlOx5ugHG/DwZ3CFuVm/TwJ0ZxoBTuT
         Gmjw==
X-Gm-Message-State: AOAM531LMn6E338Oa4MSA5hXsaSqERKwpQ7m/Lt4zJLDEmt3t9sgEj2G
        DzhwUDuAZR886HdRWXGRy6JsgrNen1p9OswgX3ruzmjz
X-Google-Smtp-Source: ABdhPJwhaoxhYlGY8EDYshHZ4TCzVrVd17C1fTBwCf8YkGsMwGLgP+s4e2z3KDG1hBiPLHKzGTbOa1c4vu/YUUcqthU=
X-Received: by 2002:a05:6808:ec5:b0:2f9:a7fb:4dfb with SMTP id
 q5-20020a0568080ec500b002f9a7fb4dfbmr2413973oiv.156.1654695645157; Wed, 08
 Jun 2022 06:40:45 -0700 (PDT)
MIME-Version: 1.0
References: <20220510182039.28771-1-cgzones@googlemail.com> <CAP+JOzSVrU+bg20mkKkT_qsVAh7ciKB_xa7s9XpEHGu0Pax_vA@mail.gmail.com>
In-Reply-To: <CAP+JOzSVrU+bg20mkKkT_qsVAh7ciKB_xa7s9XpEHGu0Pax_vA@mail.gmail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Wed, 8 Jun 2022 09:40:34 -0400
Message-ID: <CAP+JOzS_RdAT4oZa3iVu7H-Ud3GxYhzK9dQa_CHCYSucH8KJ0w@mail.gmail.com>
Subject: Re: [RFC PATCH 1/4] libselinux: simplify policy path logic to avoid
 uninitialized read
To:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, May 18, 2022 at 11:22 AM James Carter <jwcart2@gmail.com> wrote:
>
> On Tue, May 10, 2022 at 4:53 PM Christian G=C3=B6ttsche
> <cgzones@googlemail.com> wrote:
> >
> > In case the function __policy_init() gets called with a NULL pointer,
> > the stack variable path remains uninitialized (except at its last
> > index).  If parsing the binary policy fails in sepol_policydb_read() th=
e
> > error branch would access those uninitialized memory.
> >
> > Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>
> For the series with v2 of patch 4:
> Acked-by: James Carter <jwcart2@gmail.com>
>
Merged with v4 of patch 4.
Thanks,
Jim

> > ---
> >  libselinux/src/audit2why.c | 34 +++++++++++++---------------------
> >  1 file changed, 13 insertions(+), 21 deletions(-)
> >
> > diff --git a/libselinux/src/audit2why.c b/libselinux/src/audit2why.c
> > index ca38e13c..44a9a341 100644
> > --- a/libselinux/src/audit2why.c
> > +++ b/libselinux/src/audit2why.c
> > @@ -192,25 +192,16 @@ static PyObject *finish(PyObject *self __attribut=
e__((unused)), PyObject *args)
> >  static int __policy_init(const char *init_path)
> >  {
> >         FILE *fp;
> > -       char path[PATH_MAX];
> > +       const char *curpolicy;
> >         char errormsg[PATH_MAX+1024+20];
> >         struct sepol_policy_file *pf =3D NULL;
> >         int rc;
> >         unsigned int cnt;
> >
> > -       path[PATH_MAX-1] =3D '\0';
> >         if (init_path) {
> > -               strncpy(path, init_path, PATH_MAX-1);
> > -               fp =3D fopen(path, "re");
> > -               if (!fp) {
> > -                       snprintf(errormsg, sizeof(errormsg),
> > -                                "unable to open %s:  %m\n",
> > -                                path);
> > -                       PyErr_SetString( PyExc_ValueError, errormsg);
> > -                       return 1;
> > -               }
> > +               curpolicy =3D init_path;
> >         } else {
> > -               const char *curpolicy =3D selinux_current_policy_path()=
;
> > +               curpolicy =3D selinux_current_policy_path();
> >                 if (!curpolicy) {
> >                         /* SELinux disabled, must use -p option. */
> >                         snprintf(errormsg, sizeof(errormsg),
> > @@ -218,14 +209,15 @@ static int __policy_init(const char *init_path)
> >                         PyErr_SetString( PyExc_ValueError, errormsg);
> >                         return 1;
> >                 }
> > -               fp =3D fopen(curpolicy, "re");
> > -               if (!fp) {
> > -                       snprintf(errormsg, sizeof(errormsg),
> > -                                "unable to open %s:  %m\n",
> > -                                curpolicy);
> > -                       PyErr_SetString( PyExc_ValueError, errormsg);
> > -                       return 1;
> > -               }
> > +       }
> > +
> > +       fp =3D fopen(curpolicy, "re");
> > +       if (!fp) {
> > +               snprintf(errormsg, sizeof(errormsg),
> > +                        "unable to open %s:  %m\n",
> > +                        curpolicy);
> > +               PyErr_SetString( PyExc_ValueError, errormsg);
> > +               return 1;
> >         }
> >
> >         avc =3D calloc(sizeof(struct avc_t), 1);
> > @@ -249,7 +241,7 @@ static int __policy_init(const char *init_path)
> >         sepol_policy_file_set_fp(pf, fp);
> >         if (sepol_policydb_read(avc->policydb, pf)) {
> >                 snprintf(errormsg, sizeof(errormsg),
> > -                        "invalid binary policy %s\n", path);
> > +                        "invalid binary policy %s\n", curpolicy);
> >                 PyErr_SetString( PyExc_ValueError, errormsg);
> >                 fclose(fp);
> >                 return 1;
> > --
> > 2.36.1
> >
