Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 671A83E92AB
	for <selinux@vger.kernel.org>; Tue, 26 May 2026 14:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779805460; cv=pass; b=MZDlArnjLyTRwvl6veFOndsGg/YnAGJMUkU1OuEDu0tq/ctECJwDSH0rlMDcZljnZ2SyQUsal+VISlD5PqSQpIY93+26esdGbEZRVZR1iaoKZh4aotCXwP7J7tbk89p4Nrf8N2wnUkFq/NTDMxWgde53Jt6YEiE8pRyYXEQ+giM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779805460; c=relaxed/simple;
	bh=4/uWuwCf7Sf3KuXPcinzAvwxlQYytgjogHkSMIul064=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YuC1gerbazrAohSVu6yBUZQdIixjVicOZoYGop6wkY5+FNMseaqOV+JVjsoGziRaGeeNGViCON79CbUdYwa4BVp/zN/A9Uv2trDVrjPXmsKo0wdg0UcASDruoiVlia13DOMrNKFCyP22qISJkaMuBbyr1oYjweyBD3vhw7gv8JA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Rw1Nzu3s; arc=pass smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rw1Nzu3s"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-36a8ee1e28cso3082298a91.0
        for <selinux@vger.kernel.org>; Tue, 26 May 2026 07:24:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779805458; cv=none;
        d=google.com; s=arc-20240605;
        b=LeuB27SUSpg9g+g/VTR/geK7cpfIG09UKNDXO6Vhoq/ovfRaHDyGiJMfGY/6JkxQcY
         gjrjGYRPF11KehLd2BcDIp6XpqUoCCAh6Nx4ZYyeVI7yL0mLpdmjnMqDqPMafJGgA04N
         KWQDlZPv7Axq0F7GA6tXFhHuZ0HmkQ+k0tXPtAfNUSrHnCuR42lLkvgvuBYcMHb3ItoR
         8562qcwQjO6XkJvadGtPLd5otr4IzDGDk4i/sr5xo0ILOQ8ctZxdH0UfO3pcVfuLBkt/
         ePU/UKqX6l4Ef+Z5zoy50qUwwY0aIgl99WEp1XBR+4Sr/IUDuy2ErNTW6CPVQiaAEwrF
         WAYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=LIORcTWV6yLS89xu4OtOyGlbJHpqAlc/VepTOVObkeM=;
        fh=FsXghBnyoYbEc42Idnie0oh5A6i9FUng5ntOLhqXIRs=;
        b=Dj16ThtBlSvJgNZjY40zW5fjVJAyDKlrZ/YqLV64NzJNnvrKh1KxzAIGOtTMc87icJ
         Rg9PeJ0tnudxyURs5VN/g0aHxkk1ySpOs8H7CeS5gATPPpbQjAPkpJVcmysmW9kcaCqx
         UohX5fT6sXIdHiRRBAK2mgLdY4K3nhVw90H4CQpS9i8YLhBOCxPkJWL2xo+F4MIpywUO
         Dhpgcqlp4AOEom7iRIYVD7ihA7Tah4GJ2+KgBxYq/vHFoeDt6rPo2gzkEvGLWzYjj+yP
         lh0r+SL8HPRD1C4rxp62ioOTB3pcLA9d56T++K1xjrjK2hvkJe2l4FFUgKtH4AvaNhsM
         w4UA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779805458; x=1780410258; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LIORcTWV6yLS89xu4OtOyGlbJHpqAlc/VepTOVObkeM=;
        b=Rw1Nzu3s2acVjebYsEkwSxO6TAqMYPM5FNPUbCGjp+fXKcy9rB1vDvJO8Xft0ZqpCJ
         9jqcnytgQWrUJELIt3UzFb1YOUFZhcqNwM3aDzmprBpHnzJ4sJobG67RXQbFKe6kOKAO
         Pjt/r0Ay/79pfI9Oo+Gj4KHOVCu/3xPsdomySgTzYlJs8yya7Cy8bisrBWkFP8gbSbU4
         vX4vaZMqS6R2SlV/N+g9snwj8fAflKOIIBxJYnwVSU6aUgMCdRHxdXTp1UqAedfOZrM4
         EE5Ad/gmvLb7oMw1XIWIRvLOJ3G+Y54CdgiOz0m1WHw+hVlnV79JFXaMzq5zye4VfQrZ
         SISQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779805458; x=1780410258;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=LIORcTWV6yLS89xu4OtOyGlbJHpqAlc/VepTOVObkeM=;
        b=XifI0ITyBDJaFPE7sp2956LaaLn1mFXqoZp7DdFEMH/+GXmufyotSSf6oAoPFpqbAZ
         zjsFGTJZ1uJ/ysekVmS9IHOWMuDMY88ic8A061/5P5DLgOhrAg0tdGgqwwJdQhw3BL20
         HLUf/DbYLmWRqF7DH1PEV6jVjzQ/vKKkLp7IWbmoV1Wziv/jMQgOPYviXnJpxEf1lUFv
         otweE0LcX1WC1sCddod7cmbf1RIrY3RN0y1kUH2wPQ6BrHKFtZCYe1qkkcLJSumLs0mS
         37QY3Eg7Xolgmet1CupAjX/IVmus3c9vhGtBmW5EUeBelBqyH1Zhfbz/ZaC2lkRRVs5d
         LsSg==
X-Gm-Message-State: AOJu0Yy3ZadgkYqfxAVLb3lk8j/ttj0NhR3EQ9n7ib6qHER+ipOweoOu
	rxHZagBeZhz3WrQbpBc3ShhO7JnHTOZxvAPKlUHPoinkyvdrcAVOVe9GpXV2e4b3ImRPzxMQ6Ce
	hI/DNLaZnK4l1TSUu6N6h1e3qoPvX52E=
X-Gm-Gg: Acq92OE2LoitJE07Z/BBQ96yDoxRp/I2sFH1Tl1sfffYDnUWaNLy4hXiMhUsvGebiS1
	iJi3Sxby+x6VViKLLLLn23jVgfopMNEQV0t6Zi4UszGo+Mowj8TyZ4pYt0laXHcPn3imc5qcEGa
	qAVdfISa7lnIJgOS5EM30IOS3O9hj/8U9Lb/tZM21F8L0ZQMMBfbcMlE4yPUjbhiPS+fy+DTu6J
	Owo1oJJTlrsxa3fmI9ilcjY070BPOUePzceK1+o0ojIaCtjtOzw2hcRoFhpqLcqDwu48f4FcLYV
	miXhrXPXewJgUGyy+w==
X-Received: by 2002:a17:90b:2e04:b0:369:b957:1d84 with SMTP id
 98e67ed59e1d1-36a677c78famr18111672a91.14.1779805458607; Tue, 26 May 2026
 07:24:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260521180100.21791-1-jwcart2@gmail.com> <CAEjxPJ6ieK2=QXRucnwvC2Zs952V4cZAE6wMPMSshqpVU_H+-Q@mail.gmail.com>
In-Reply-To: <CAEjxPJ6ieK2=QXRucnwvC2Zs952V4cZAE6wMPMSshqpVU_H+-Q@mail.gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Tue, 26 May 2026 10:24:06 -0400
X-Gm-Features: AVHnY4JJzZfFsl5V_9N1VVjtxdYpA9MY46RKlNprYLXH3xP5F9DjTKvs_joGX_w
Message-ID: <CAEjxPJ4_jgmGT5DW1yBg7uYmNHGEN3SgO23jjqXmU8Zj7cm2fw@mail.gmail.com>
Subject: Re: [PATCH] libsepol: Fix double free in copy_avrule_block
To: James Carter <jwcart2@gmail.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 26, 2026 at 9:17=E2=80=AFAM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Thu, May 21, 2026 at 2:44=E2=80=AFPM James Carter <jwcart2@gmail.com> =
wrote:
> >
> > If there is a failure in copy_avrule_decl(), avrule_decl_destroy()
> > is called on new_decl and then avrule_block_list_destroy() is called
> > on new_block, but since new_decl has already been linked into
> > new_block, new_decl will be freed again.
> >
> > Instead, just link new_decl into new_block after the call to
> > copy_avrule_decl().
> >
> > Signed-off-by: James Carter <jwcart2@gmail.com>
>
> Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>

Merged.

>
> > ---
> >  libsepol/src/link.c | 13 +++++++------
> >  1 file changed, 7 insertions(+), 6 deletions(-)
> >
> > diff --git a/libsepol/src/link.c b/libsepol/src/link.c
> > index 188b4020..e0da6575 100644
> > --- a/libsepol/src/link.c
> > +++ b/libsepol/src/link.c
> > @@ -1757,12 +1757,6 @@ static int copy_avrule_block(link_state_t * stat=
e, policy_module_t * module,
> >                         }
> >                 }
> >
> > -               if (last_decl =3D=3D NULL) {
> > -                       new_block->branch_list =3D new_decl;
> > -               } else {
> > -                       last_decl->next =3D new_decl;
> > -               }
> > -               last_decl =3D new_decl;
> >                 state->base->decl_val_to_struct[state->next_decl_id - 1=
] =3D
> >                     new_decl;
> >                 state->decl_to_mod[state->next_decl_id] =3D module->pol=
icy;
> > @@ -1775,6 +1769,13 @@ static int copy_avrule_block(link_state_t * stat=
e, policy_module_t * module,
> >                         goto cleanup;
> >                 }
> >
> > +               if (last_decl =3D=3D NULL) {
> > +                       new_block->branch_list =3D new_decl;
> > +               } else {
> > +                       last_decl->next =3D new_decl;
> > +               }
> > +               last_decl =3D new_decl;
> > +
> >                 state->next_decl_id++;
> >         }
> >         state->last_avrule_block->next =3D new_block;
> > --
> > 2.54.0
> >
> >
