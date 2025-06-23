Received: from mail-ua1-f47.google.com (mail-ua1-f47.google.com [209.85.222.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60F6A3C30
	for <selinux@vger.kernel.org>; Mon, 23 Jun 2025 18:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750704345; cv=none; b=HhWYq4W9pepmx1/dkNmxBjnjbkI2qat08cQXdhu4mkME3bmTnta6nEGgjyrR5Yjl7a8auULIDDP2eraInO6etb0RkJF6aOmeiY0UqX355L5n1XZDwtxHCS1B8QVPUXrnYDcD0DnqMvc5oAYHihpXara+OFoq336IxinfFpHJgyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750704345; c=relaxed/simple;
	bh=G8O1nc69Vlec+XER8NvmTt3pV7Ysgn3Z4YYl3+xmA4c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IEIKUjSzaUdOurnfx1rmTk8bgjG8OIwveQOgZ5V6KFJceyR1MebGcCTronZDSr2HZhXGnR3g0BumwWAkRUTa9hhuswu6tRuwuR5D50Q7n1mKQTgryvW9cX93PolHEzz6J8/MLBwO/fEriW/8+C2wR4KQtUZvWUAhg5q1WdQ3KkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ILb7TD+B; arc=none smtp.client-ip=209.85.222.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ILb7TD+B"
Received: by mail-ua1-f47.google.com with SMTP id a1e0cc1a2514c-87f74a28a86so3048853241.2
        for <selinux@vger.kernel.org>; Mon, 23 Jun 2025 11:45:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750704342; x=1751309142; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tTm41+51KeO434RakEIw/bSUu0x62lcNruDAS/qctQY=;
        b=ILb7TD+BSo5HDpAgCT73F3oTaXJjBIUZ+4eEKzCMFQCDJiDqDpYXEEpih87pO4Nl5t
         0ebdV4YJCU1F+R6jroIm4YB90SfEtEr37pQgNRYKR1qcXypeufZiFG0u2d1L9dPHMh4e
         3u7KjKqydFl8AOb52ygCW2bHj+1pim8pwH0HkQa+h14I3VGI824TwTYm2qBPmHwSwcmg
         Y8Va0NFSsE781j7aOBJy2fEcsbxTZ0d1YNWL6vd3AAT09+1JqHpbrId3TELD8rsc1iy+
         vwUX93hwF681DgHpxvP2naCJ1R4VphgsMgJ706/hhmkypeIaMVbDeGkLrDEnGz9c0iyZ
         Hfmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750704342; x=1751309142;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tTm41+51KeO434RakEIw/bSUu0x62lcNruDAS/qctQY=;
        b=jriHoXUW59fMkzhV/Qqk84vWNsS3MMmfBoEt56UbWZaaockcI2huvdBkbwbSJ2ztlk
         g+qjsKWILjjSUR7L7IEq/H6Hd+cK8OZQC7l6zGiuVonSkKb3u9eTnXniwvJiZ5zpbgh7
         4YVur5DI7MVzDI+m6PZLxEg96eh/5ZPXWhp94I/hyBUzwipDP3xpxSnTUFy8eb2E63p9
         A0Fvx8DHmHbCSDwioEfBgHYxOjTBJWznL9vINpL6ORY+pd1NyvJbAozINDnEEFo0SlUB
         W20huorX65wLwCfQf2RC2x/uAbG9eXWebAAz64OuJ98CQp+KUj0F8hJcaPRBiAl039GB
         g09Q==
X-Gm-Message-State: AOJu0Ywn+Oj9XrjPOt9SSgYdBnJonw0YXoWZyiwwTO4Bm88wmiGxNs1K
	jPNljt/Sn2Y+qIdNPqNvxFNTXlydJBWv8kWEpjrfqOBpYJzRqNn54em77U0jyAuPpFQkwZWCOzD
	YmwEN4RjsE1KVdSPayPYtt33AxTqhZ/0=
X-Gm-Gg: ASbGncuGIy3UpbJszerzsiTiFdx404Jj6Mbhguz+cqJUGnVvQOCd3Uk1umwiwK4o3dZ
	RbSYfka5VOeleFzo2q+2uH5ltwiehOregiP3Eky+rRzJQjoKFclzLPlDPi6VSuTXshuC7iFoR5j
	C1i99Ocul+7EWHshMxTZvyO734NyZpNnR1+XM+o8kH
X-Google-Smtp-Source: AGHT+IF4Y/ooqWC5VnngXTAefOM7r/K/bW2pQLbCMrqXcDesUGux/AcNS31tWI48N+8XQbR5Byf/y/pN54IK8LJEYSc=
X-Received: by 2002:a05:6102:41c9:b0:4e9:d951:1433 with SMTP id
 ada2fe7eead31-4e9d9515564mr3449334137.12.1750704342136; Mon, 23 Jun 2025
 11:45:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250616152534.26053-1-cgoettsche@seltendoof.de>
 <20250616152534.26053-5-cgoettsche@seltendoof.de> <CAP+JOzSJXKnNu3bHBuo4DRNFiVYauzjtfZw1xBu0CxEOsn_TZA@mail.gmail.com>
In-Reply-To: <CAP+JOzSJXKnNu3bHBuo4DRNFiVYauzjtfZw1xBu0CxEOsn_TZA@mail.gmail.com>
From: James Carter <jwcart2@gmail.com>
Date: Mon, 23 Jun 2025 14:45:31 -0400
X-Gm-Features: Ac12FXzLJHskDOHyPrKcAAwyNxqEOCqCjwkQOSXwhj2A3ZaTT8gWE5LJzBayZYc
Message-ID: <CAP+JOzQVv7NJDksXmP_P3XjOmE8O5J5HMvZ8ThWqnpXVNRBumA@mail.gmail.com>
Subject: Re: [PATCH v3 1/5] libsepol: update sort order for netifcon definitions
To: =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 23, 2025 at 11:04=E2=80=AFAM James Carter <jwcart2@gmail.com> w=
rote:
>
> On Mon, Jun 16, 2025 at 11:33=E2=80=AFAM Christian G=C3=B6ttsche
> <cgoettsche@seltendoof.de> wrote:
> >
> > From: Christian G=C3=B6ttsche <cgzones@googlemail.com>
> >
> > Order netifcon definitions with a wildcard interface name last in objec=
t
> > contexts, so the kernel tries to match literal names first.
> >
> > Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>
> For these five patches.
> Acked-by: James Carter <jwcart2@gmail.com>
>

These five patches have been merged.
Thanks,
Jim

> > ---
> >  libsepol/cil/src/cil_post.c     | 36 ++++++++++++++++++++++++++++++---
> >  libsepol/src/kernel_to_common.c | 36 ++++++++++++++++++++++++++++++---
> >  2 files changed, 66 insertions(+), 6 deletions(-)
> >
> > diff --git a/libsepol/cil/src/cil_post.c b/libsepol/cil/src/cil_post.c
> > index d63a5496..70e5b734 100644
> > --- a/libsepol/cil/src/cil_post.c
> > +++ b/libsepol/cil/src/cil_post.c
> > @@ -316,10 +316,40 @@ int cil_post_genfscon_compare(const void *a, cons=
t void *b)
> >
> >  int cil_post_netifcon_compare(const void *a, const void *b)
> >  {
> > -       struct cil_netifcon *anetifcon =3D *(struct cil_netifcon**)a;
> > -       struct cil_netifcon *bnetifcon =3D *(struct cil_netifcon**)b;
> > +       /* keep in sync with kernel_to_common.c:netif_data_cmp() */
> > +       const struct cil_netifcon *anetifcon =3D *(struct cil_netifcon*=
*)a;
> > +       const struct cil_netifcon *bnetifcon =3D *(struct cil_netifcon*=
*)b;
> > +       const char *a_name =3D anetifcon->interface_str;
> > +       const char *b_name =3D bnetifcon->interface_str;
> > +       size_t a_stem =3D strcspn(a_name, "*?");
> > +       size_t b_stem =3D strcspn(b_name, "*?");
> > +       size_t a_len =3D strlen(a_name);
> > +       size_t b_len =3D strlen(b_name);
> > +       int a_iswildcard =3D a_stem !=3D a_len;
> > +       int b_iswildcard =3D b_stem !=3D b_len;
> > +       int rc;
> > +
> > +       /* order non-wildcards first */
> > +       rc =3D spaceship_cmp(a_iswildcard, b_iswildcard);
> > +       if (rc)
> > +               return rc;
> > +
> > +       /* order non-wildcards alphabetically */
> > +       if (!a_iswildcard)
> > +               return strcmp(a_name, b_name);
> > +
> > +       /* order by decreasing stem length */
> > +       rc =3D spaceship_cmp(a_stem, b_stem);
> > +       if (rc)
> > +               return -rc;
> > +
> > +       /* order '?' (0x3f) before '*' (0x2A) */
> > +       rc =3D spaceship_cmp(a_name[a_stem], b_name[b_stem]);
> > +       if (rc)
> > +               return -rc;
> >
> > -       return  strcmp(anetifcon->interface_str, bnetifcon->interface_s=
tr);
> > +       /* order alphabetically */
> > +       return strcmp(a_name, b_name);
> >  }
> >
> >  int cil_post_ibendportcon_compare(const void *a, const void *b)
> > diff --git a/libsepol/src/kernel_to_common.c b/libsepol/src/kernel_to_c=
ommon.c
> > index 44f0be23..e4338ec6 100644
> > --- a/libsepol/src/kernel_to_common.c
> > +++ b/libsepol/src/kernel_to_common.c
> > @@ -441,10 +441,40 @@ static int portcon_data_cmp(const void *a, const =
void *b)
> >
> >  static int netif_data_cmp(const void *a, const void *b)
> >  {
> > -       struct ocontext *const *aa =3D a;
> > -       struct ocontext *const *bb =3D b;
> > +       /* keep in sync with cil_post.c:cil_post_netifcon_compare() */
> > +       const struct ocontext *const *aa =3D a;
> > +       const struct ocontext *const *bb =3D b;
> > +       const char *a_name =3D (*aa)->u.name;
> > +       const char *b_name =3D (*bb)->u.name;
> > +       size_t a_stem =3D strcspn(a_name, "*?");
> > +       size_t b_stem =3D strcspn(b_name, "*?");
> > +       size_t a_len =3D strlen(a_name);
> > +       size_t b_len =3D strlen(b_name);
> > +       int a_iswildcard =3D a_stem !=3D a_len;
> > +       int b_iswildcard =3D b_stem !=3D b_len;
> > +       int rc;
> >
> > -       return strcmp((*aa)->u.name, (*bb)->u.name);
> > +       /* order non-wildcards first */
> > +       rc =3D spaceship_cmp(a_iswildcard, b_iswildcard);
> > +       if (rc)
> > +               return rc;
> > +
> > +       /* order non-wildcards alphabetically */
> > +       if (!a_iswildcard)
> > +               return strcmp(a_name, b_name);
> > +
> > +       /* order by decreasing stem length */
> > +       rc =3D spaceship_cmp(a_stem, b_stem);
> > +       if (rc)
> > +               return -rc;
> > +
> > +       /* order '?' (0x3f) before '*' (0x2A) */
> > +       rc =3D spaceship_cmp(a_name[a_stem], b_name[b_stem]);
> > +       if (rc)
> > +               return -rc;
> > +
> > +       /* order alphabetically */
> > +       return strcmp(a_name, b_name);
> >  }
> >
> >  static int node_data_cmp(const void *a, const void *b)
> > --
> > 2.49.0
> >
> >
