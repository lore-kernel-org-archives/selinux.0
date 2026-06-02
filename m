Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEF89360EC7
	for <selinux@vger.kernel.org>; Tue,  2 Jun 2026 15:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780412517; cv=pass; b=MOk7JuG/pYwXiA5Gu1q6XFexC+3bGnta+LYMxMG3y0JOrmRzg6DVoka9o+0lIfytbcqSwIZ8yyDHBz3gXMjOcD4bOxu5PY4GLsmK2tpxwXu4J24TXV7pcPi4lRnf/7L7+dl+95MfH0fMjqJLUEdP9jVjffF7IiZRhhXU5AIBIWA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780412517; c=relaxed/simple;
	bh=/YCQ18mIGjSgeJuS5/paWCdZp5thsrjKdVm2l3DqpIw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=P0QKBedoBuAAH5wF+SVfXfakyolv3rmjL4a7WK+0iXjs5lJI8Z0qtXlqik++nkf+3wjxwKtOSzm4Smu2PG+RgTAD4VhwMOcZGjN3sv6v3xhR9rPVACyadHx+Uan3L6IkbJI3yZUVONpXc0XdgaAVTZA3at5baWuQ2QMevyr4yIE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PEQGixku; arc=pass smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PEQGixku"
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-3967717c951so35211861fa.1
        for <selinux@vger.kernel.org>; Tue, 02 Jun 2026 08:01:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780412514; cv=none;
        d=google.com; s=arc-20240605;
        b=OGSm13JBvDM1kkkOq3qFaN3ZlYfqvlFC+p9j19vHN2FzeR+xM8paM6oxUSEXUoZtyB
         GDzFJYNfaJyjoCF4QVwmNwFAdQnqMu//t86kcF1bS5pBdrzfpfP4LLM9DxH0CrKXpAng
         LbYWImaBrkHl2DJU6jTKs+Y4nHGvcrkMdrlaJ/6y3nrbsnebD1jGvsop2J3wuTijqyqn
         g6Tt7b2B4Tuq0a3DsB2yB1lbKYuIRpDN+Y3pfjCsPAAN+pvMLEr7TLp02/VxXqqG7Imj
         qNOc4CMyVcRRj3juFgZ0KVb6cYbcsIKrwM2tRIgu5p+WJ2HEADF5K3VFxrv7uuI8KXmh
         yPIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Uv7HRkxkDaegglVkuXWe3pJaglQmR5Izil6voH4TY7c=;
        fh=96e9iJ9F9hb8Uv5iBb2VrdJSMG4j9DkTXBh1F3mLMGg=;
        b=AWKLq9/JmnyCRXfwJBrn1BMDTXooKM8RUv3QAgKLjHFoSzgZgFDv4q8tr3qsKgx+PH
         Q7W0/O/xXBFH7ovIhNNrechJnjWCEmhidGrGTR1cDT2zSxxzz/AVc/TkYcQ6N/fVsSKy
         R+gEMoVkbLyNz6qmHKFt2Qgyb6v7dkjyxfaZOjyg/Td1pKAtWgo/PGvwvMuPzdjCKFev
         4J2Kur9BDrD09V/sqjEChsTM9P5C4RyGaAIG/YFfLKiAdx7v1CbCev4VvxzN7g3Nu2O6
         dBsQ2umrsPv5bnRwLN4I/bkj/FJqMUvqRFLZ68kcLznx4aofu24QjKxCRzy5Kxy/LPyr
         ZfZQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780412514; x=1781017314; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Uv7HRkxkDaegglVkuXWe3pJaglQmR5Izil6voH4TY7c=;
        b=PEQGixkuq+5usSMZeL1xVF2+0AWCtyMc/WFT+sWjMiExIIfLF/HVAGzM1mo1+tQarI
         MMIKxTxqjn0t7ZMyDOu5C4Vvayz8jVsfOit0Qr9qyIKINKSxogO1DJ9mEON1/CNvsW23
         an6bJjSYHKbDI06+5aaL9gZTYhdL6qPMXHASt+Q9YMPg2bWGUilNs0xbaqrDX1Wibu/u
         +pjfBtYaBFlqBOXhFsGq+iuZrrpVV9Fyh5YzHRoy7JIpqUYT7udqZRFLoEXBImSNgbnq
         wI6VsB5bRa/pbvGm0biXv2cdvUDywASv092VdTjuXP/u6itfbhqoUsrKaCtuVO3CUlvl
         ASdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780412514; x=1781017314;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Uv7HRkxkDaegglVkuXWe3pJaglQmR5Izil6voH4TY7c=;
        b=s0z6MHQG0wHdQ0BwfAfq1zIwzeZK3sLpRdOpYGXAB8dEsLTvO1/r4Fncr5D8kmqLvZ
         QyxM/AzbNDWQnPbWq0DHdTXnOTRbvZb1B53FWHbgoY+XcGw+5pYlMJy4/eKyKj7qJQkT
         b/uW+UjaRZLHjOf9ou9dF4fHEZ/9+CJRzxtnwUowrEebixWETwT1Ro/rCBAWKsrsCY3Y
         knCqpB7gxVuR2LgviKireDC1l7bYCTUmdv2sblpNOCW67lHLinSv4hyXSk3dHsv2Ac72
         4cQlVxvEichEoZ+iI2eZveIeJUPLGvvrqEw7nLVdiyfLzS4EVlBsC6cq3OYX/KgC/RKS
         QYTQ==
X-Forwarded-Encrypted: i=1; AFNElJ+orqPRzsHqpDX025TUAQ9G7fKuvtFsXu40CUYCsrZk2U1LVtHvEO+53OcoUZdh48OfNDrVDo/N@vger.kernel.org
X-Gm-Message-State: AOJu0YyWTXcl0eiZrk39Ban37X1DOVj7Ocdqx7xUYmC9Xz9yVVUX0Ik+
	N5nQc3uxoFC8DTyOuQ/oTNmJNDBC8jPDwa5Xpho49aNWQAIUqhuus8sC9e6QBCu45dI86hn7WVH
	VX1ZvW4KAZcLIyfY71GfmZNR1sP8eMiM=
X-Gm-Gg: Acq92OFWuW6mtaf15/3c7OsOtWkvuAmLprkUW9234gHagCgaPac75Jyj7m42+vJyDdz
	InkJX8DJYeROcHu9dSkqs2ziwtDRV2bPAHV4x/0kUWTNk7eZpkhnu/KGqLQ25UD5D/fbF4kOdX1
	Qrz9H46OlxMGbMFHDdzl8/TAZ/milVpnh7JHkViRCrBUvKamR721/BXoi6WtIqVfH41XIsq2uAl
	7S9eHFGA+uvj9GYIeKF2yGsypeuGfC8engMNcLVeeYBX6+/ALRPMDeMTLCVoHQnOIvXr4PuNZ2p
	DufpXNEPpRxl8N1ZEmNiMQXH1g==
X-Received: by 2002:a2e:bcc5:0:b0:393:fe12:579c with SMTP id
 38308e7fff4ca-396ac20710dmr421241fa.7.1780412512394; Tue, 02 Jun 2026
 08:01:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260531163723.683086-2-nvraxn@posteo.uk> <CAEjxPJ6SdvWkcUd=EmivGhB=m8cnh71-2JzHKS60izTfTXC67w@mail.gmail.com>
In-Reply-To: <CAEjxPJ6SdvWkcUd=EmivGhB=m8cnh71-2JzHKS60izTfTXC67w@mail.gmail.com>
From: James Carter <jwcart2@gmail.com>
Date: Tue, 2 Jun 2026 11:01:38 -0400
X-Gm-Features: AVHnY4IIy5XxbP2xvve9vheI0TOTHRL5N6ZOap63Bnt2Hhwmer6SPp4tvDD_wRU
Message-ID: <CAP+JOzRjW29+asdWwj0te5qhehD7qTGW03544=a63dKSaEfHQg@mail.gmail.com>
Subject: Re: [PATCH] libselinux: restorecon: add_exclude: validate directory
 before deref
To: Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: Rahul Sandhu <nvraxn@posteo.uk>, selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 1, 2026 at 2:39=E2=80=AFPM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Sun, May 31, 2026 at 12:38=E2=80=AFPM Rahul Sandhu <nvraxn@posteo.uk> =
wrote:
> >
> > Currently, the call to strcmp() with directory as an argument results
> > in directory being dereferenced before it is checked to be non-NULL.
> > Hence, move the validation of directory before the call to strcmp().
> >
> > Signed-off-by: Rahul Sandhu <nvraxn@posteo.uk>
>
> Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>
>

Merged.
Thanks,
Jim

> > ---
> >  libselinux/src/selinux_restorecon.c | 12 ++++++------
> >  1 file changed, 6 insertions(+), 6 deletions(-)
> >
> > diff --git a/libselinux/src/selinux_restorecon.c b/libselinux/src/selin=
ux_restorecon.c
> > index 69a53503..6a36de67 100644
> > --- a/libselinux/src/selinux_restorecon.c
> > +++ b/libselinux/src/selinux_restorecon.c
> > @@ -204,12 +204,6 @@ static int add_exclude(const char *directory, bool=
 who)
> >         size_t len =3D 0;
> >         int i;
> >
> > -       /* Check if already present. */
> > -       for (i =3D 0; i < exclude_count; i++) {
> > -               if (strcmp(directory, exclude_lst[i].directory) =3D=3D =
0)
> > -                       return 0;
> > -       }
> > -
> >         if (directory =3D=3D NULL || directory[0] !=3D '/') {
> >                 selinux_log(SELINUX_ERROR,
> >                             "Full path required for exclude: %s.\n",
> > @@ -218,6 +212,12 @@ static int add_exclude(const char *directory, bool=
 who)
> >                 return -1;
> >         }
> >
> > +       /* Check if already present. */
> > +       for (i =3D 0; i < exclude_count; i++) {
> > +               if (strcmp(directory, exclude_lst[i].directory) =3D=3D =
0)
> > +                       return 0;
> > +       }
> > +
> >         if (exclude_count >=3D INT_MAX - 1) {
> >                 selinux_log(SELINUX_ERROR, "Too many directory excludes=
: %d.\n", exclude_count);
> >                 errno =3D EOVERFLOW;
> > --
> > 2.54.0
> >
> >
>
