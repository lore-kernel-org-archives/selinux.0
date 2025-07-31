Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F298D86338
	for <selinux@vger.kernel.org>; Thu, 31 Jul 2025 14:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753971460; cv=none; b=dtidsfXfAnE2vBgftYwM2u7Pxr8GKktKmfj/TGGjFiyussKQQindEvcDORZwPeMM+UW7zIp6ch3OpkIDDIHoHf3O+mmqLVZHBJ1w88XnV978dbkARln6OQwhwTBxtHqOh5+yQsuTqiF+sXP8J1lJtxdzXG3QpkEZMFVZR9nHJM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753971460; c=relaxed/simple;
	bh=OyjG6crtVWjs0OshdwtSX29rQjuA6eMen8JhDgiKBmc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PD3wCmFmPRPvs9XiEx2/eL/O/kO8PukrdtIOgBuxFkay7TBPP/p3VyWp2IP3aJO3WEL24BbjzRqhcIr+A5h/zn+HgiX73LZ3afpvee0mr4VASeGIvQUfr1decseZS9ol7ICR5f89sn2JneGID1Na7z4EOEv1OlL8xyC2kqG0Fkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a19j/aSZ; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a19j/aSZ"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-31c4a546cc2so909509a91.2
        for <selinux@vger.kernel.org>; Thu, 31 Jul 2025 07:17:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753971456; x=1754576256; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yysINEze4u3ia5NINuu0sTbtxP572Xm+x3PYf6FXQI4=;
        b=a19j/aSZxqN6ezKa1ySVpvYNQ+5WPAxXmswBw+rcfcG0KS93Fimc7GOSGNFxBzN79s
         z04I4NM6mfA0T/G9gHPP3qTmGqUTepn+D2BnI84WvOG7Pm44h95zZSrunai1vFZ80egz
         cD6QQh5Hqkp5Ncc4N+20PpZAPlnEqxW3aFMpTyZlkRqvJcEQrlcEaD3p1FvlUYvLbz1m
         sZyXRZMAeNU0BYfPvOD5wXcfgJbNr3/qyK/PtChH+aii2sGwW3Yx1xPcoeiHUp4PgNoG
         fXEN+UJy9Q8aRGEs9GA+G58OQjapGH5zukuuUc8iXp9Axjmw+Si3FHFKOGYlNCf3U7pu
         OQTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753971456; x=1754576256;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yysINEze4u3ia5NINuu0sTbtxP572Xm+x3PYf6FXQI4=;
        b=WISULfunyqV/1dZArsWng51Mbb9IV/WYA+o4SB+J+AbR+p8uoao82hAmbSpzkYJ+NC
         M3ffoQvYZLLgjwTvJFseeXPbmnqxLW8v7C3Ty8XjNrfRwAmJtDqhEu960oDC+gcoQW6u
         ZD/fGitQU/4Xq9X/UX+9GtiMcRCGuRc00shH+m6v0iXY4b7dtTJSrXcmIM9eYYqMaOxS
         5jI0f9JNtuurqVAvWuAbmX5gScrD1GlWP4ZwnRIRnSkuzHTu7Y4bGtDZEclZ0qsY8ZEn
         splPS/U2q/JPBQDN6rAFMj5QY/bl/QMa5zJy2LF7rMXy57nYe8OW1w7u92TGtmm490VE
         Wn5g==
X-Forwarded-Encrypted: i=1; AJvYcCV2ckVU4LS9MG5UbKDR44PMWhJcEoWlFWIeXfbnt//OjrqhdCRI34VirPmXRlj1Uh4C5RhfzMSf@vger.kernel.org
X-Gm-Message-State: AOJu0YwHC4gkl5o3paWeBa2OlPwoosU3kSUIwJ89cIwQtDuFbtP21n1H
	jDrReyl0l7VyusKhutxyhU7SlQOhg5ymHff9XRrgmi0GBf4pESefcy/TSVYBU2+N1RNagULDbly
	T1gdA6ZlS6pUutROgtcWYwvRxG4XGTTgqww==
X-Gm-Gg: ASbGncvX4YSeLVWHsILNMCltcSco0pDCZ9fA1J10PliDowmvAlackMX70+hSWx8Nyi5
	Fjj3nGso9N7Zz82HeHvk2dOX7jG4cTuxnauagUvz0d9dBgWfwBwEMlrB2nzRFJBAWki0sJN9ywn
	5f1UEVAt5ss21h7vSfkmijspv44bIpk3qKp9DHM8Lg8r10yVuHQcozNoLAHnJHw+VM92FJztT1i
	wmmljg=
X-Google-Smtp-Source: AGHT+IGH0ugKJl4d00l7LpXf23yofOmTWfBtWHftIPbKarIUu97cfRbRlkRgmu2JKAeZKsf5jnasS88wMriozyiEJzg=
X-Received: by 2002:a17:90b:5103:b0:313:f6fa:5bb5 with SMTP id
 98e67ed59e1d1-31f5de54a99mr10750293a91.18.1753971455980; Thu, 31 Jul 2025
 07:17:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <82e217c7-7124-4d49-ab98-074a6c2535c9@googlemail.com>
 <20250730074729.936489-1-nvraxn@gmail.com> <CAEjxPJ7m3Mj2NAntf2TUSrostQDmOeBtN4Ja67s5RFCnMXwFwA@mail.gmail.com>
In-Reply-To: <CAEjxPJ7m3Mj2NAntf2TUSrostQDmOeBtN4Ja67s5RFCnMXwFwA@mail.gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Thu, 31 Jul 2025 10:17:24 -0400
X-Gm-Features: Ac12FXzY0bTAxS8uBQ6jo63phodzgGh5CX6o27Uv_PKjh3FLadlcNJ8BKGzeGGI
Message-ID: <CAEjxPJ6cWZjfbUm1YP+HiMMXYoGrQ6CuUYKguNttHGPYkjPAYA@mail.gmail.com>
Subject: Re: [PATCH v2] libselinux: refactor selinux_getenforcemode
To: Rahul Sandhu <nvraxn@gmail.com>
Cc: cgzones@googlemail.com, selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 30, 2025 at 8:59=E2=80=AFAM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Wed, Jul 30, 2025 at 3:47=E2=80=AFAM Rahul Sandhu <nvraxn@gmail.com> w=
rote:
> >
> > Invert the check for cfg being a nullptr and early return.
> >
> > Signed-off-by: Rahul Sandhu <nvraxn@gmail.com>
>
> Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>

Thanks, applied.

>
> > ---
> >  libselinux/src/selinux_config.c | 75 ++++++++++++++++-----------------
> >  1 file changed, 37 insertions(+), 38 deletions(-)
> >
> > v2: Don't mark len static.
> >
> > diff --git a/libselinux/src/selinux_config.c b/libselinux/src/selinux_c=
onfig.c
> > index 75db14ba..e1bc1b79 100644
> > --- a/libselinux/src/selinux_config.c
> > +++ b/libselinux/src/selinux_config.c
> > @@ -88,47 +88,46 @@ static const uint16_t file_path_suffixes_idx[NEL] =
=3D {
> >
> >  int selinux_getenforcemode(int *enforce)
> >  {
> > -       int ret =3D -1;
> >         FILE *cfg =3D fopen(SELINUXCONFIG, "re");
> > -       if (cfg) {
> > -               char *buf;
> > -               char *tag;
> > -               int len =3D sizeof(SELINUXTAG) - 1;
> > -               buf =3D malloc(selinux_page_size);
> > -               if (!buf) {
> > -                       fclose(cfg);
> > -                       return -1;
> > -               }
> > -               while (fgets_unlocked(buf, selinux_page_size, cfg)) {
> > -                       if (strncmp(buf, SELINUXTAG, len))
> > -                               continue;
> > -                       tag =3D buf+len;
> > -                       while (isspace((unsigned char)*tag))
> > -                               tag++;
> > -                       if (!strncasecmp
> > -                           (tag, "enforcing", sizeof("enforcing") - 1)=
) {
> > -                               *enforce =3D 1;
> > -                               ret =3D 0;
> > -                               break;
> > -                       } else
> > -                           if (!strncasecmp
> > -                               (tag, "permissive",
> > -                                sizeof("permissive") - 1)) {
> > -                               *enforce =3D 0;
> > -                               ret =3D 0;
> > -                               break;
> > -                       } else
> > -                           if (!strncasecmp
> > -                               (tag, "disabled",
> > -                                sizeof("disabled") - 1)) {
> > -                               *enforce =3D -1;
> > -                               ret =3D 0;
> > -                               break;
> > -                       }
> > -               }
> > +       if (!cfg)
> > +               return -1;
> > +
> > +       char *buf =3D malloc(selinux_page_size);
> > +       if (!buf) {
> >                 fclose(cfg);
> > -               free(buf);
> > +               return -1;
> >         }
> > +
> > +       int ret =3D -1;
> > +       const int len =3D sizeof(SELINUXTAG) - 1;
> > +       while (fgets_unlocked(buf, selinux_page_size, cfg)) {
> > +               if (strncmp(buf, SELINUXTAG, len))
> > +                       continue;
> > +
> > +               char *tag =3D buf + len;
> > +               while (isspace((unsigned char)*tag))
> > +                       tag++;
> > +
> > +               if (!strncasecmp(tag, "enforcing", sizeof("enforcing") =
- 1)) {
> > +                       *enforce =3D 1;
> > +                       ret =3D 0;
> > +                       break;
> > +               } else if (!strncasecmp(tag, "permissive",
> > +                                       sizeof("permissive") - 1)) {
> > +                       *enforce =3D 0;
> > +                       ret =3D 0;
> > +                       break;
> > +               } else if (!strncasecmp(tag, "disabled",
> > +                                       sizeof("disabled") - 1)) {
> > +                       *enforce =3D -1;
> > +                       ret =3D 0;
> > +                       break;
> > +               }
> > +       }
> > +
> > +       fclose(cfg);
> > +       free(buf);
> > +
> >         return ret;
> >  }
> >
> > --
> > 2.50.1
> >
