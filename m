Received: from mail-ua1-f47.google.com (mail-ua1-f47.google.com [209.85.222.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 692C61D699
	for <selinux@vger.kernel.org>; Thu,  7 Mar 2024 14:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709820931; cv=none; b=ibk7ZJ4oliZ4wx0r7WbTzethhsh5H66i3GBKYGPx2mwkHO99kucJ05C9UQ090Vvjhiu2qmGnMb0EGi4XVLaWmxzfo4nyvY7SkKpYCyOyNgnAYsVSfSdcRXKR7JCzR5BlS5W6+ARNnFgruAaWXJR+jG/9qKgetb1PJZSQ3UFY3+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709820931; c=relaxed/simple;
	bh=v8P9RCbVLyo1LFjNHyuRXkOeFEF07Ub25rlQ9NZmJXo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mgIUqrIjTX+9LtMK+XfBT2QqcZoG8GB+gyzBSfk+CZ6J9n3HfgQVVaXjnmpco/rR6QQWQneC/BMneIpNTG5EMYOq0U2X2s6gQ8lmuHStzVw5zPRW6HSMA5OkXnTXb+C44r049e1zUVA7WzTCutv/G79YZPG4b77tUQT+1e3KN68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YEdRxFxM; arc=none smtp.client-ip=209.85.222.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YEdRxFxM"
Received: by mail-ua1-f47.google.com with SMTP id a1e0cc1a2514c-7d5fce59261so763278241.3
        for <selinux@vger.kernel.org>; Thu, 07 Mar 2024 06:15:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709820929; x=1710425729; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X29kOZmjCRJpSdTR5R75MYcTxUyz/w79ySIC++L0wHA=;
        b=YEdRxFxMIRJ321aMcP0rWlCHHbNLF7cwp0pMrArwbLU5Dzv6UyPORmSE7JIZUtUDDl
         WGefPYHebsZ+UGk+DVH3HExp6hpUiVw7t4TPtXI+8AAD1D839uMuZypOZHjktd8W/3+g
         ESOa7OYNLaJd5Y2LDre25Y+iRb/PVw6yVROwLCh+fAuXJ2R5VRhSydVTUmmzbq99vO5c
         iGB4qXV19JvoJbAb7MxK4f15mh80+qRbcCxLrSUyHRkOUnVTTcGzARYb+33heknOyHqw
         L62Gxash2jQu3ijzTYzBisY6lASqaH+1sbG8QgS6ZwQ19dVJWQ0056+X1JkMkml+0fop
         5l0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709820929; x=1710425729;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X29kOZmjCRJpSdTR5R75MYcTxUyz/w79ySIC++L0wHA=;
        b=p9+y8NKy6OcBm+5l2124b34zKCqd6UzPMMIAasifPtwyNHDFeADsLChyRIwEOhfmBJ
         pGuRFAHDhmCmKVn+V18PjBCC9ehE69jEKv8GTDv7UL5HJbw91PjoD+DfE/B054qXVXe+
         Pu6JsZLIPlEU/O2Ybm56QxU2pjO6Tc8V5dmlyjVp3PCQI5dqP46uJU8PJaD4w80c8Sni
         UVIYW4Vs6wtqLKtMHpfU0NOJjB0s5U2aeqL2TPXV8J+9yPDmL3+RE2YwAcM50gChVrKe
         Os1eh0yDZXh1zMlik7kaJcvSOHp/cohOvSjVAjAR1aroUKRcT+/wE8IEcMP4g2HBGW13
         5Ytw==
X-Gm-Message-State: AOJu0YzgczYTir2UuXc8TvLqCtqr1acS+u71P8ILWYs7lSBgmK1C4fLw
	GxVtTAG7oUzZAdUy6+dAvX6uDuZHhMp5WW+5b25f+cplzHzkOFWOlj5JNzTaqB1WxJmU+AFDwy9
	JGTzTcAOsEx4lbm5gvjZ8m9+5uNhRgBJ9
X-Google-Smtp-Source: AGHT+IFpuKYJSbPrLdkhduk7YnI/iroxCRnxfhUqgS+lfMjxDUhOeXFOxT/1J5lW647/x+L7C/wHTkbQ7qwFlHBY8h0=
X-Received: by 2002:a05:6102:da:b0:470:576b:62f8 with SMTP id
 u26-20020a05610200da00b00470576b62f8mr8157862vsp.7.1709820929097; Thu, 07 Mar
 2024 06:15:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240306143451.2256235-1-jwcart2@gmail.com> <CAJ2a_De2X6Ux5et0kEu7fmfgwZeYtq_OLVNXbX6M4tsbucqvew@mail.gmail.com>
In-Reply-To: <CAJ2a_De2X6Ux5et0kEu7fmfgwZeYtq_OLVNXbX6M4tsbucqvew@mail.gmail.com>
From: James Carter <jwcart2@gmail.com>
Date: Thu, 7 Mar 2024 09:15:18 -0500
Message-ID: <CAP+JOzSU+10+HnFT94-otNkp4Zr474nbnFWDv_XLsKZGk53fYw@mail.gmail.com>
Subject: Re: [PATCH] checkpolicy/fuzz: Update check_level() to use notdefined field
To: =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 6, 2024 at 2:22=E2=80=AFPM Christian G=C3=B6ttsche
<cgzones@googlemail.com> wrote:
>
> On Wed, 6 Mar 2024 at 15:34, James Carter <jwcart2@gmail.com> wrote:
> >
> > Commit e16f586 (Fix potential double free of mls_level_t) renamed
> > the "defined" field to "notdefined", but did not update this use of
> > it.
> >
> > Use the new field "notdefined" for the check.
>
> Since the renamed member "notdefined" is checked during validation and
> the fuzzer calls policydb_valudate() I think the whole callback can be
> removed.
>

I left it in for now because checkpolicy does a similar check and I
wanted to get this merged as soon as possible since it was breaking
the fuzzer.

> > Signed-off-by: James Carter <jwcart2@gmail.com>

This patch has been merged.

Thanks,
Jim

> > ---
> >  checkpolicy/fuzz/checkpolicy-fuzzer.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/checkpolicy/fuzz/checkpolicy-fuzzer.c b/checkpolicy/fuzz/c=
heckpolicy-fuzzer.c
> > index 0d749a02..a3da0b57 100644
> > --- a/checkpolicy/fuzz/checkpolicy-fuzzer.c
> > +++ b/checkpolicy/fuzz/checkpolicy-fuzzer.c
> > @@ -135,7 +135,7 @@ static int check_level(hashtab_key_t key, hashtab_d=
atum_t datum, void *arg __att
> >         const level_datum_t *levdatum =3D (level_datum_t *) datum;
> >
> >         // TODO: drop member defined if proven to be always set
> > -       if (!levdatum->isalias && !levdatum->defined) {
> > +       if (!levdatum->isalias && levdatum->notdefined) {
> >                 fprintf(stderr,
> >                         "Error:  sensitivity %s was not used in a level=
 definition!\n",
> >                         key);
> > --
> > 2.44.0
> >
