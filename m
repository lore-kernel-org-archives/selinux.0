Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F33F2C433EF
	for <selinux@archiver.kernel.org>; Fri, 25 Mar 2022 15:25:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348287AbiCYP1Y (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 25 Mar 2022 11:27:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378881AbiCYP0A (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 25 Mar 2022 11:26:00 -0400
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA323652C9
        for <selinux@vger.kernel.org>; Fri, 25 Mar 2022 08:24:02 -0700 (PDT)
Received: by mail-oi1-x234.google.com with SMTP id v75so8516348oie.1
        for <selinux@vger.kernel.org>; Fri, 25 Mar 2022 08:24:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=yOaGPD10N4xqqinT4SffRW77l5hs7C56R4yx94ki1QA=;
        b=G3MGyIuMDVQwzrcaKjL8ffFGCfL2r1YpnyUBNnXgs+aD/kH5ONDM6tFz/+fOIIs0KL
         0bg8jonl6VTevYP6pmoW8TyMwfHfzE/eXRPezKiyws99Pts/EnSGv2t4JqCF3Jwnhztj
         BjuZMOaaKpbL/ZXp2n0HLQ0nV+VMn/UO3C8xNAIMWC+Ucda0lInOKGuQ/ca1WfcqlCtx
         BebayWckat6ap8J0uQem9b6mwd2bQvuq2G6rbF2qKZjkuxm9ZJXtHtJgb9LSzgd695cS
         566+LpldWDpsoCCgw+NtaR4dAvnUuxnNK/KKBhC0DUO3EpuMOeeGgb192y83T+YNmuyo
         rdAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=yOaGPD10N4xqqinT4SffRW77l5hs7C56R4yx94ki1QA=;
        b=vyimNfNXoCEeaSXEMdEBRhffR1jwpp5g2vEcmNn/J48cI1VODR6NJqIyRF0bJMULqf
         MNCtGDGBMH3LJPR/g1mQJ0+vm5MSKL7xcAhA6qVB6678xPsR9Y7HAzywM8gVlunLrtM5
         JlsUN+RkCciP9AvnsHR6Ru8Z2Flkv3+y5Oa/Jg4DEJ/EATcFH8NsDD04vePPOXeEgtvD
         f8lLfc15TsYgIQ6QesfaWnnhMRZfxAQaTJ/KzzuLuP9QrIZpHWEb/rnepndGQ/kygTci
         JT8O6k2Bwzgez9fEcOtH9Lx9+7IRatx1fttONQmL2Ss+ZaIxVFEWKZDNFz9VEJoRI0TW
         FPNA==
X-Gm-Message-State: AOAM533JkINSX1Z9YRxq6qmZowRKDAI6TSKDich4MZ/a+pbz+7SOv/a6
        tvS1ddDSILA0VxyrQhgzn9UEKkkKeWh08XlDJOU=
X-Google-Smtp-Source: ABdhPJwa24r9FL4YowOT95Bq1xHAl+rbb4arFjYy6efVP8zkTJ6vYdoE2+KJgG48YgkL9d2TrdL43l4grSX38CnzIOs=
X-Received: by 2002:aca:c184:0:b0:2ef:6652:5584 with SMTP id
 r126-20020acac184000000b002ef66525584mr9839083oif.156.1648221842320; Fri, 25
 Mar 2022 08:24:02 -0700 (PDT)
MIME-Version: 1.0
References: <20220311115330.922386-1-plautrba@redhat.com> <CAP+JOzQp63qBgu47OpOwkAF-yg6Tu89HSB68B2HcjSsrKAnsKQ@mail.gmail.com>
In-Reply-To: <CAP+JOzQp63qBgu47OpOwkAF-yg6Tu89HSB68B2HcjSsrKAnsKQ@mail.gmail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Fri, 25 Mar 2022 11:23:51 -0400
Message-ID: <CAP+JOzSA=UKc=i8TqeQ8r1TABo=f-BTtc0J5A5_8R1miKKgvSQ@mail.gmail.com>
Subject: Re: [PATCH] libselinux: Close leaked FILEs
To:     Petr Lautrbach <plautrba@redhat.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Mar 14, 2022 at 3:48 PM James Carter <jwcart2@gmail.com> wrote:
>
> On Fri, Mar 11, 2022 at 5:10 PM Petr Lautrbach <plautrba@redhat.com> wrot=
e:
> >
> > Fixes:
> > label_media.c:94:24: warning: leak of FILE =E2=80=98fopen (path_28, "re=
")=E2=80=99 [CWE-775] [-Wanalyzer-file-leak]
> > label_x.c:121:24: warning: leak of FILE =E2=80=98fopen (path_28, "re")=
=E2=80=99 [CWE-775] [-Wanalyzer-file-leak]
> >
> > Signed-off-by: Petr Lautrbach <plautrba@redhat.com>
>
> Acked-by: James Carter <jwcart2@gmail.com>
>

Merged.
Thanks,
Jim

> > ---
> >  libselinux/src/label_media.c | 4 ++--
> >  libselinux/src/label_x.c     | 4 ++--
> >  2 files changed, 4 insertions(+), 4 deletions(-)
> >
> > diff --git a/libselinux/src/label_media.c b/libselinux/src/label_media.=
c
> > index eb27deaf510e..3137c18edc19 100644
> > --- a/libselinux/src/label_media.c
> > +++ b/libselinux/src/label_media.c
> > @@ -95,10 +95,10 @@ static int init(struct selabel_handle *rec, const s=
truct selinux_opt *opts,
> >         __fsetlocking(fp, FSETLOCKING_BYCALLER);
> >
> >         if (fstat(fileno(fp), &sb) < 0)
> > -               return -1;
> > +               goto finish;
> >         if (!S_ISREG(sb.st_mode)) {
> >                 errno =3D EINVAL;
> > -               return -1;
> > +               goto finish;
> >         }
> >         rec->spec_file =3D strdup(path);
> >
> > diff --git a/libselinux/src/label_x.c b/libselinux/src/label_x.c
> > index e9fa063fafff..e6e8d9f60bff 100644
> > --- a/libselinux/src/label_x.c
> > +++ b/libselinux/src/label_x.c
> > @@ -122,10 +122,10 @@ static int init(struct selabel_handle *rec, const=
 struct selinux_opt *opts,
> >         __fsetlocking(fp, FSETLOCKING_BYCALLER);
> >
> >         if (fstat(fileno(fp), &sb) < 0)
> > -               return -1;
> > +               goto finish;
> >         if (!S_ISREG(sb.st_mode)) {
> >                 errno =3D EINVAL;
> > -               return -1;
> > +               goto finish;
> >         }
> >         rec->spec_file =3D strdup(path);
> >
> > --
> > 2.35.1
> >
