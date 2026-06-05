Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 441AA336ECF
	for <selinux@vger.kernel.org>; Fri,  5 Jun 2026 13:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780665208; cv=pass; b=r2aPrIJRvHXCjOg035NbJlBq9lgMFp58vhRjRQy6daQf5wtdNGgz0P3tZ/Ou0wRuiFXpLIGp8j8EefMA3+k+FI1g1Z+Mo0k9N4rKE0fL5MadfGOHmR11m56oGldOuXNDnpzXCHtGTrajxFsgwpPK7cTge0zXHy8JuGZVzylDEjk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780665208; c=relaxed/simple;
	bh=OXYVurLVNKkGh6g1yzGmiwz0vC3ATmXHn11o5BV02+c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ljvzxC9VrXTewRUiEfcAQMr0DZ4VWU+AN2EV1og90wjfIGY5zodP44WUNlVb/TFuAnR50WBONJ5ORQr6cOQw7SSQOtGA75iGj6fzSFXpUrAkc6J8dxHtlaA/nOsPMr1IAxKhFiU5d6sm/xaHTPIRjSWtvl/7rZVh42xV/MxZ5Sg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m02Y0Y0C; arc=pass smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m02Y0Y0C"
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-39677234558so18777811fa.1
        for <selinux@vger.kernel.org>; Fri, 05 Jun 2026 06:13:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780665205; cv=none;
        d=google.com; s=arc-20240605;
        b=Z2VaJiaWpmS486oVrPVwuDX4YL0xIIZuXsQTZXNvNGrASWzYEvs6VeEPBDPRY7xkA7
         PiMAlrPaVwlpl83NAaBMpfpQ8ESqzsdoyOVODw34eCdj8puxtCqC8z398sYK5HiUCZBq
         H3aEiqlhWME+ZIhza+M9N0bn+MbSeBr35vL1J8coXa9pdVLFXcICVGG4FubwMwpImk8B
         BbSXwNlS0I1ZOprecLPIxFO6blx8dIwEGqbdT09XL4AoSNiawV0cwtA3WWnvwzuLUTQH
         3UV9tH5kafl/X3ZSPQ+dcPH3lBrkeFs5h3CDp8TD9vuhZjRxGkD/lu4s0fOuTp9cBdIe
         15nQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=jncanf3Mfb16TC8oost5TgQoUjWZyT+vd42DVU0SeHg=;
        fh=nOcPTm+jzSpUJDDJhvsoEQt/GcMQFmPB1BDsWNtwPZ8=;
        b=gDiioLZxjbWM6YfC8AbNc5iUgJ196LThEoRsxJiaRgYcm/R9GgvYg/mNAaStvC74rD
         tZonGC1zNLDk6p6n/ApqPo2rqxWp4MfbmKG+OdUzgGzdRdKtr+eigmWYfKlPdDY0iJgt
         OH8QmoiR1rGZMz3DMcV0ORZLqcsvp8D8SygNnc/kkHUtev8Z7uBOxDnLw9o+sRECVZiK
         OdOqVRTCGBIT5ZDrhBi2g2WaJtfJADJfHb3kb+bZ0b1cegOKyqX5IhjJ5OqjUwwQc1ny
         hJU2G0BuhtUoyufRRkbcYxuIWiCZguCPymaWODLkHlW0qfS1TLo8aYfu6NZVlLDwNMDq
         oGGA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780665205; x=1781270005; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jncanf3Mfb16TC8oost5TgQoUjWZyT+vd42DVU0SeHg=;
        b=m02Y0Y0C63BQTfNxsaWRSe9yeT0m6gkevyRXyGNUjKtke/q/9/Q1hKPeh2OIP7eL3S
         A4fb78APmw2MnQxoyfUS/H++3LeSQwFcH1cLJTcHz6iNKzWosrxQzN7xytzqmMMjvZuZ
         DtVj9lOZKKXkMR30GwGFCX6wgIxdVTH+NHKbdmcKJPaNRWKIlV0uGaGpdfNk3Hy9bgvg
         /9YYLdufNKCUnacym9hJ7oedMwDfM6i2xmgUpDkIx00N5lkBYduZuYAdwPfdgh2BeoOi
         XQRbmJib/cB9qGqptflfVGmw1prLD22yeM5nekcl9RsLInvO3iL+3DD/FJyRkQOaB2tb
         KI4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780665205; x=1781270005;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jncanf3Mfb16TC8oost5TgQoUjWZyT+vd42DVU0SeHg=;
        b=kXclFXXv4SUEPjmh1ABjvSzQaebdnjVpyx5nnyU1N2B66j0K9UixmHFRncVbpwDAl5
         77siInmUKUhYJpDmAcWDS1as+x8mexBERklhcjHt3wcslf/Cl5oougV9bIsgK8N3L4VC
         tNV/lt1AN5uDX2vyVYwnA7stYkBUFBs1yyuEFG8o8l0aliIE3NJ8VUe3rzrczSLALQdU
         EMO65zX8Z67b7w/rPbRG+sB5DF1PZEb8FqBugImQL1tvSfeuuxmjlq/c27TJmYgM1S6/
         DZbkjtSm0rVnGDA+smYWfUs3DaN1vulZj5lQRY0qUNpcTRzsAbZmNcwY2AvQxheVJ56+
         srmg==
X-Gm-Message-State: AOJu0YynaoVLhpLwr3o9vLPLtGY4yaoUIuDssVDdczIrOO55ZlpXVJuK
	07tszc9YIyQ8C+4WS3z0NS1Q4LtWEbBfkoOMoiSikaQQxlCs3Sbx7e+CTsv8MDYBXcn02qHltUI
	9Gps0fp6tDsAos1sIbeXI3OwcfdCYgY5a0Q==
X-Gm-Gg: Acq92OF7AVf/b2Dwwo3h2s9D7JFNrT2C+3k3oqx9OwQQazn9z/ndm4kgD2hHZWN/Xnj
	+f+DpdAsHQQ6BStamTl4oBl393o8+vvS7siop+Pqsvb3bEfsaI8bTTG8Qful3easBMHIuA0xuSI
	NE39wDDIZW2Pbl4rTYZxcs2GT91xU0pErq7xPoFcOKslu5nBfMYbjAfZAot0c3juVcERXLgsUFr
	LM6dmxAMTIdhBmzMeV/F0u4RbIxKdFtHaNFaiPjPpka8DezclFZ8Uvx8s+M8hhspTmBOrGp4jvF
	El2Q2VR4D0lU0so=
X-Received: by 2002:a05:651c:1a0b:b0:394:472e:e430 with SMTP id
 38308e7fff4ca-396d08fbd30mr11013861fa.18.1780665205366; Fri, 05 Jun 2026
 06:13:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260604191727.52013-1-jwcart2@gmail.com> <CAEjxPJ6W9WpDmy-=eWx97OTpOdGyc5ypC8ODUEiOu8GE=9HJ+A@mail.gmail.com>
In-Reply-To: <CAEjxPJ6W9WpDmy-=eWx97OTpOdGyc5ypC8ODUEiOu8GE=9HJ+A@mail.gmail.com>
From: James Carter <jwcart2@gmail.com>
Date: Fri, 5 Jun 2026 09:13:13 -0400
X-Gm-Features: AVVi8Cfn3_jhloShgPggjovAjugaX1zTYfl0lQH7tkWhro7Aa7YEtAfMJBzqqkM
Message-ID: <CAP+JOzT+ekoS1nVy7vOkSj-2em631nnpxfEQtV0wt-Xpn0w=Eg@mail.gmail.com>
Subject: Re: [PATCH v2] libsepol/cil: Add check for too large of file size
To: Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 4, 2026 at 3:19=E2=80=AFPM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Thu, Jun 4, 2026 at 3:17=E2=80=AFPM James Carter <jwcart2@gmail.com> w=
rote:
> >
> > In cil_add_file() add a check for a file size that is too large.
> >
> > Signed-off-by: James Carter <jwcart2@gmail.com>
>
> Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>
>

Merged.
Jim

> > ---
> > v2: Add '\n' to end of log message
> >
> >  libsepol/cil/src/cil.c | 5 +++++
> >  1 file changed, 5 insertions(+)
> >
> > diff --git a/libsepol/cil/src/cil.c b/libsepol/cil/src/cil.c
> > index 83377821..18b98fe2 100644
> > --- a/libsepol/cil/src/cil.c
> > +++ b/libsepol/cil/src/cil.c
> > @@ -549,6 +549,11 @@ int cil_add_file(cil_db_t *db, const char *name, c=
onst char *data, size_t size)
> >
> >         cil_log(CIL_INFO, "Parsing %s\n", name);
> >
> > +       if (size > SIZE_MAX - 2) {
> > +               cil_log(CIL_ERR, "File size is too large\n");
> > +               return SEPOL_ERR;
> > +       }
> > +
> >         buffer =3D cil_malloc(size + 2);
> >         memcpy(buffer, data, size);
> >         memset(buffer + size, 0, 2);
> > --
> > 2.54.0
> >
> >
