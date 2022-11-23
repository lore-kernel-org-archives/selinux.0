Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65445C433FE
	for <selinux@archiver.kernel.org>; Wed, 23 Nov 2022 15:04:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235632AbiKWPE1 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 23 Nov 2022 10:04:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235918AbiKWPEO (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 23 Nov 2022 10:04:14 -0500
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07F11B82
        for <selinux@vger.kernel.org>; Wed, 23 Nov 2022 07:04:12 -0800 (PST)
Received: by mail-ej1-x62e.google.com with SMTP id f18so43442804ejz.5
        for <selinux@vger.kernel.org>; Wed, 23 Nov 2022 07:04:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+OcoS6QPWH6IBmGC+05q1xmLA4vdS47RVktCCWNeIAg=;
        b=ChYqImjL1xueFyfw8imEH4Asyj/omwSvOk9qxzulhsRd1SRdNZu4YDyNBmGhU0BQhQ
         Um2R+5dSZ58NLzo1wBRGMXsJ5FjkHqjqsArCBbdM/wblIGwWDWObM4tXOtiPzDVz1puz
         GxwC5oAyePkyn/P22KPoV4YfLjlsZ2fGZxHm0/lLWmPHL/0PbneLmP8DTSwyFyTnANVi
         MNtEhm0vQ47b3l8BApDPVqFWNl2bru/qqhl/qU2IgxYoBUfLaIhEC2OneuL6foJMSMxW
         nXtatiRIO34rVpERI684baaX2VG+44tm2zTRD6k5aK5lPfTUdf7rtC+k6l9iKyQ7CrE/
         tt1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+OcoS6QPWH6IBmGC+05q1xmLA4vdS47RVktCCWNeIAg=;
        b=YoJvr7pwOs6XtXNMW6NTuMU5YL4mZG8Oq8KN4CxSMIJr2BuXov5jnkDDRtp454FCZx
         mdW+1PXXCx2OsJKpCyTdod97w/zYGaJQ7wdPXspEG0IsT+M91tpIc2I4XkSisxQqGILa
         gLB+RrNRRjZWPV4/KF/DAqlasiiQkLZI1HzLO1wZFGSpL5X2qFU0PjCuAp2aDRUC+1hq
         bA0R9cM+WlMtTGVO9p6s99CkLX91Ctt4QuXoKrLTe78C6kV8SRDPG1hjcO2qpfQwzopP
         SOJzqhx3NEtFBiHJitWy0RLg+UaOTBue1o7S8rCmBOgs1zHnuC2G4AMsUVx4YwC+r8il
         vfCw==
X-Gm-Message-State: ANoB5pn7TuRNayt2rgw2DaQEHcvZpuhWj6aU8F2aI1fVkZrrmcPAWSm/
        ZMZKGMBrbozgzphC5hoyZcMCrWCe1eRzFcZC7D9V8Xly
X-Google-Smtp-Source: AA0mqf7SE8Jzkt/Vys4VjyMGMfgTT+o2z1vZp0JkSxamYjPZkSVk3XP4I7o6MJj09Dl7B8ELpQ2SsGensIBBpccREx8=
X-Received: by 2002:a17:906:9da4:b0:7ae:100a:8dc0 with SMTP id
 fq36-20020a1709069da400b007ae100a8dc0mr23051460ejc.424.1669215850347; Wed, 23
 Nov 2022 07:04:10 -0800 (PST)
MIME-Version: 1.0
References: <20221109195640.60484-3-cgzones@googlemail.com>
 <20221114193208.9413-1-cgzones@googlemail.com> <CAP+JOzRRSqJ9HKWHY3f+ieP4dutb6OKS8FzbVhs8ejTU3i7RAQ@mail.gmail.com>
In-Reply-To: <CAP+JOzRRSqJ9HKWHY3f+ieP4dutb6OKS8FzbVhs8ejTU3i7RAQ@mail.gmail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Wed, 23 Nov 2022 10:03:58 -0500
Message-ID: <CAP+JOzTHPHCZTR8k39_MFfvAoX+VrsPXsK7r6v+nw3wrzyZH1Q@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] libselinux: filter arguments with path separators
To:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Nov 21, 2022 at 4:39 PM James Carter <jwcart2@gmail.com> wrote:
>
> On Mon, Nov 14, 2022 at 2:36 PM Christian G=C3=B6ttsche
> <cgzones@googlemail.com> wrote:
> >
> > Boolean names, taken by security_get_boolean_pending(3),
> > security_get_boolean_active(3) and security_set_boolean(3), as well as
> > user names, taken by security_get_initial_context(3), are used in path
> > constructions.  Ensure they do not contain path separators to avoid
> > unwanted path traversal.
> >
> > Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>
> For this series of patches (v1 for patch 1, v2 for patch 2, and this
> v3 for patch 3):
> Acked-by: James Carter <jwcart2@gmail.com>
>
These three patches have been merged.
Thanks,
Jim

> > ---
> > v3:
> >   - move check for translated boolean name into selinux_boolean_sub()
> > Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
> > ---
> >  libselinux/src/booleans.c            | 5 +++--
> >  libselinux/src/get_initial_context.c | 5 +++++
> >  2 files changed, 8 insertions(+), 2 deletions(-)
> >
> > diff --git a/libselinux/src/booleans.c b/libselinux/src/booleans.c
> > index dbcccd70..e34b39ff 100644
> > --- a/libselinux/src/booleans.c
> > +++ b/libselinux/src/booleans.c
> > @@ -131,7 +131,8 @@ char *selinux_boolean_sub(const char *name)
> >                         ptr++;
> >                 *ptr =3D '\0';
> >
> > -               sub =3D strdup(dst);
> > +               if (!strchr(dst, '/'))
> > +                       sub =3D strdup(dst);
> >
> >                 break;
> >         }
> > @@ -151,7 +152,7 @@ static int bool_open(const char *name, int flag) {
> >         int ret;
> >         char *ptr;
> >
> > -       if (!name) {
> > +       if (!name || strchr(name, '/')) {
> >                 errno =3D EINVAL;
> >                 return -1;
> >         }
> > diff --git a/libselinux/src/get_initial_context.c b/libselinux/src/get_=
initial_context.c
> > index 87c8adfa..0f25ba3f 100644
> > --- a/libselinux/src/get_initial_context.c
> > +++ b/libselinux/src/get_initial_context.c
> > @@ -23,6 +23,11 @@ int security_get_initial_context_raw(const char * na=
me, char ** con)
> >                 return -1;
> >         }
> >
> > +       if (strchr(name, '/')) {
> > +               errno =3D EINVAL;
> > +               return -1;
> > +       }
> > +
> >         ret =3D snprintf(path, sizeof path, "%s%s%s", selinux_mnt, SELI=
NUX_INITCON_DIR, name);
> >         if (ret < 0 || (size_t)ret >=3D sizeof path) {
> >                 errno =3D EOVERFLOW;
> > --
> > 2.38.1
> >
