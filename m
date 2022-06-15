Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F248C433EF
	for <selinux@archiver.kernel.org>; Wed, 15 Jun 2022 13:46:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344054AbiFONqs (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 15 Jun 2022 09:46:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244347AbiFONqr (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 15 Jun 2022 09:46:47 -0400
Received: from mail-oa1-x2f.google.com (mail-oa1-x2f.google.com [IPv6:2001:4860:4864:20::2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6ADE22CCB4
        for <selinux@vger.kernel.org>; Wed, 15 Jun 2022 06:46:46 -0700 (PDT)
Received: by mail-oa1-x2f.google.com with SMTP id 586e51a60fabf-10113b4c2b5so14870834fac.6
        for <selinux@vger.kernel.org>; Wed, 15 Jun 2022 06:46:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=MT8vdOi69oDWdVKw8GAa1IrXY0Y0CH3xRnKdy5WotAI=;
        b=B2p0t/uWoTUZpSNuCzXIaWmGpDT97ncg6JGLbJJtGDgBAPPBdGHiF6g9EKNf9AMp3P
         yyEm9x5uSOFtPBBn83w6PnVIaaZEB9BAuFU2xvL+0YOCXGs1B8z+eCgxYI0z7XmEBcZ2
         XmQtO/Fn0DBCaujsts4BQ++LYPLqiA9ZaSId9gF4svBVQDehk1fcytzQDVTJ0IOIhGLD
         GClsRPnh6FbbTlrUvP3dWBxtYnnkeQ1/ZKQXU7WAYq4qJIjHd+sIKnlRYTaskdi0AU4y
         jrwvcJUWXXfzCK7m55o+HkV1CLq7Q5h/1vdmkjsGHCsul7hlnxxM12OGJBekK1G0WJ9I
         /poA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=MT8vdOi69oDWdVKw8GAa1IrXY0Y0CH3xRnKdy5WotAI=;
        b=T6OzW1divL03+c2qUPswnMJ2NTiwaUh0Ky/cKrdP8fa7+XfmGdokuIgo5zUZzP0PWd
         +dVWVwj8+bxpv/EDAYa9ewQ2pzFvjn1t6cQFwKbl6eOyrlJwmCRqvUOm9vPwZ/szWa3K
         6nJCfstrdqXg9qy7c1T/G/rFDmHQqRqvIfb0thAvSuENPQYvCr1IKHkAKv10or/ps8KQ
         9nQTYNCUuqslFvpSj7sTG+K9WWzQvRT10E/IgDF9W/U5rstetszy/fTsLrDsE7XwUnZG
         BJP11sxidbE476IkNRHKlNL/5l8Lk9TPV0sukqmLrHKaeltKUeX8XAx6OqOMKEQu2H5W
         /xpw==
X-Gm-Message-State: AJIora9UGYohiUluu0u3W399bLvz0Pud4B9gXVSl/pqwWOrOYDAjnTD0
        U42bD0MzcGoIllForGLtcydM3a/9H2C0QmclHaSzwBfg
X-Google-Smtp-Source: AGRyM1s3WBiX6WulSY+sIfvX0zzeFb/NP0vh0UDvvUgbUrvXkT4dbz+yYilXHLTwXzR84uySy/n1CJK4zorbsjPk0G0=
X-Received: by 2002:a05:6870:4604:b0:f2:5b64:fad9 with SMTP id
 z4-20020a056870460400b000f25b64fad9mr5663413oao.182.1655300805782; Wed, 15
 Jun 2022 06:46:45 -0700 (PDT)
MIME-Version: 1.0
References: <20220520125107.8423-1-cgzones@googlemail.com> <CAP+JOzQgBDg5dJPLvMON9MOnqFsaOSjLZoQ6cpPEkbr=2N-S7A@mail.gmail.com>
In-Reply-To: <CAP+JOzQgBDg5dJPLvMON9MOnqFsaOSjLZoQ6cpPEkbr=2N-S7A@mail.gmail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Wed, 15 Jun 2022 09:46:35 -0400
Message-ID: <CAP+JOzREhaJkfoaUWyaavrEdgTPVYcxnhjW1PGyYQbww2NQAgw@mail.gmail.com>
Subject: Re: [PATCH] python/audit2allow: close file stream on error
To:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Jun 8, 2022 at 2:03 PM James Carter <jwcart2@gmail.com> wrote:
>
> On Mon, May 23, 2022 at 4:10 AM Christian G=C3=B6ttsche
> <cgzones@googlemail.com> wrote:
> >
> >     sepolgen-ifgen-attr-helper.c: In function =E2=80=98load_policy=E2=
=80=99:
> >     sepolgen-ifgen-attr-helper.c:196:17: warning: leak of FILE =E2=80=
=98fp=E2=80=99 [CWE-775] [-Wanalyzer-file-leak]
> >       196 |                 fprintf(stderr, "Out of memory!\n");
> >           |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> >
> > Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>
> Acked-by: James Carter <jwcart2@gmail.com>
>
Merged.
Thanks,
Jim

> > ---
> >  python/audit2allow/sepolgen-ifgen-attr-helper.c | 3 +++
> >  1 file changed, 3 insertions(+)
> >
> > diff --git a/python/audit2allow/sepolgen-ifgen-attr-helper.c b/python/a=
udit2allow/sepolgen-ifgen-attr-helper.c
> > index 6f3ba962..5e6cffc1 100644
> > --- a/python/audit2allow/sepolgen-ifgen-attr-helper.c
> > +++ b/python/audit2allow/sepolgen-ifgen-attr-helper.c
> > @@ -194,12 +194,14 @@ static policydb_t *load_policy(const char *filena=
me)
> >         policydb =3D malloc(sizeof(policydb_t));
> >         if (policydb =3D=3D NULL) {
> >                 fprintf(stderr, "Out of memory!\n");
> > +               fclose(fp);
> >                 return NULL;
> >         }
> >
> >         if (policydb_init(policydb)) {
> >                 fprintf(stderr, "Out of memory!\n");
> >                 free(policydb);
> > +               fclose(fp);
> >                 return NULL;
> >         }
> >
> > @@ -208,6 +210,7 @@ static policydb_t *load_policy(const char *filename=
)
> >                 fprintf(stderr,
> >                         "error(s) encountered while parsing configurati=
on\n");
> >                 free(policydb);
> > +               fclose(fp);
> >                 return NULL;
> >         }
> >
> > --
> > 2.36.1
> >
