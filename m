Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VMKRHspk"
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C17CAA3
	for <selinux@vger.kernel.org>; Wed,  6 Dec 2023 12:57:19 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id 2adb3069b0e04-50bf26f8988so292850e87.2
        for <selinux@vger.kernel.org>; Wed, 06 Dec 2023 12:57:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701896238; x=1702501038; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TtB2N9Ss3/LOSNh+EPN/fYzp4jWDhfuAWfCML6egYls=;
        b=VMKRHspkZlU1jjynIj1imzolktDiVTqHn9jnH1C1cEOzMTAYdZComiPYMRVQyPZ8vQ
         I7/E4WMep8T0yZkNtethQZnayTKT+y1whOQ7EdUYv8OjVJaTZ+Wh1xHzuV7oqeY5SKwH
         ulj700zzYfOiJTTbehCb2H3rFJ4pOLBXQZ//1xXzBMnTdJjyK2f/KJxvtSVrGblrnIbM
         1L8xttwmEwMtwHilUy7L/7QMLGjRLl0vzb5Gca153Cjf7NTCqIa6aReVPNa1uM+b7ooo
         Y8gvXTGYzFfyh+ASpO5cWhKrtbF+W70mlzDZDtz97SsSX8ywGkcfD7uJoiocrXa77QXT
         pGPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701896238; x=1702501038;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TtB2N9Ss3/LOSNh+EPN/fYzp4jWDhfuAWfCML6egYls=;
        b=HeAMuZc5FP8DBTPQeu8E6wjKK+m/1y1UHqWzF/+bxlDZO32oGT82qPDzm8V2zhTmf7
         d3e1+g+EoJGLRL48GzBU5JOVV3aFSZrCNsmYntnos0EIUKe9nixIyRmS8nKV3TSVljk1
         iUdBG2YFl1dNbjOHCT0ix+jvG+dEul+UAc51kutb2PXv7JQFt5d4Acnrl+BSv37ugfty
         tvLq4ZzGBxecv6VkLViVmkGgu/HwiKlcAdkI1vSZe2+btyWBHRvDkfL1fn28C58MGGXB
         0q8Vj2YQYxDCO5jp/EdBWRw9vNCp4WcLhStB2Abq31fB7dgjbw0wH2wcKUPTwam5Rzwi
         iDUQ==
X-Gm-Message-State: AOJu0Yy58xqu5drXW5GAFuCXmV01IXIEHChnmM9TbQZntWYYtNpO3iVG
	V4k/CWUgHkz55JgkDw+sDiJwrVx5Wrto5dnt1xBQwN8u
X-Google-Smtp-Source: AGHT+IH5QGGfoNkN+hTOyksEczKz/ZZiThQB7JYxX8hlOjUyUAHZ3Gv5fRh0MBut76vVeGDvvRGs06crLpvKspF9zE4=
X-Received: by 2002:a05:6512:6c9:b0:50b:f836:9027 with SMTP id
 u9-20020a05651206c900b0050bf8369027mr1247816lff.93.1701896237628; Wed, 06 Dec
 2023 12:57:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231128182334.57740-1-cgzones@googlemail.com> <CAP+JOzTv8z-KNJ28iqNddSp3rajQi8X8RmLoO-2by+Xv=_RvUQ@mail.gmail.com>
In-Reply-To: <CAP+JOzTv8z-KNJ28iqNddSp3rajQi8X8RmLoO-2by+Xv=_RvUQ@mail.gmail.com>
From: James Carter <jwcart2@gmail.com>
Date: Wed, 6 Dec 2023 15:57:06 -0500
Message-ID: <CAP+JOzT6ygC-JetwDsTfLJ9gLWqWs2_4jHHKjPaLOytuYZr7ew@mail.gmail.com>
Subject: Re: [PATCH 1/7] libsepol: validate conditional type rules have a
 simple default type
To: =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 1, 2023 at 2:52=E2=80=AFPM James Carter <jwcart2@gmail.com> wro=
te:
>
> On Tue, Nov 28, 2023 at 1:23=E2=80=AFPM Christian G=C3=B6ttsche
> <cgzones@googlemail.com> wrote:
> >
> > Similar to unconditional avtab keys check the default type of type av
> > rules are a simple type, not an attribute.
> > Since extended permission rules are not allowed in conditional policies
> > this check does not need to be performed.
> >
> > Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>
> For every patch except for patch 4.
> Acked-by: James Carter <jwcart2@gmail.com>
>

Patches 1-3 and 5-7 have been merged.
Thanks,
Jim


> > ---
> >  libsepol/src/policydb_validate.c | 15 +++++++++++----
> >  1 file changed, 11 insertions(+), 4 deletions(-)
> >
> > diff --git a/libsepol/src/policydb_validate.c b/libsepol/src/policydb_v=
alidate.c
> > index 8b87675f..c2f19fa0 100644
> > --- a/libsepol/src/policydb_validate.c
> > +++ b/libsepol/src/policydb_validate.c
> > @@ -885,14 +885,21 @@ static int validate_cond_av_list(sepol_handle_t *=
handle, const cond_av_list_t *c
> >
> >         for (; cond_av; cond_av =3D cond_av->next) {
> >                 for (avtab_ptr =3D cond_av->node; avtab_ptr; avtab_ptr =
=3D avtab_ptr->next) {
> > -                       if (validate_avtab_key(&avtab_ptr->key, 1, p, f=
lavors)) {
> > -                               ERR(handle, "Invalid cond av list");
> > -                               return -1;
> > -                       }
> > +                       const avtab_key_t *key =3D &avtab_ptr->key;
> > +                       const avtab_datum_t *datum =3D &avtab_ptr->datu=
m;
> > +
> > +                       if (validate_avtab_key(key, 1, p, flavors))
> > +                               goto bad;
> > +                       if ((key->specified & AVTAB_TYPE) && validate_s=
impletype(datum->data, p, flavors))
> > +                               goto bad;
> >                 }
> >         }
> >
> >         return 0;
> > +
> > +bad:
> > +       ERR(handle, "Invalid cond av list");
> > +       return -1;
> >  }
> >
> >  static int validate_avrules(sepol_handle_t *handle, const avrule_t *av=
rule, int conditional, const policydb_t *p, validate_t flavors[])
> > --
> > 2.43.0
> >
> >
