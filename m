Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40DB9205AB3
	for <selinux@vger.kernel.org>; Wed,  4 Dec 2024 14:31:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733322705; cv=none; b=CI4XSS9kmf27WoH+RIeLaVRJ3YEV7mDzyu0o5uGy0MvR5E40l9uT2rRLxVkVsfazRdC2bzC/h3BbIVU/aMPnlefPr+GMAmKS7GZ3tmGXivmX4fgZCc+Jic1bsAhNAKEXPV7ImOEnycxGOG36fSu+SNBaDHuyb00J4a/OVYYtBxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733322705; c=relaxed/simple;
	bh=p9xUTmS6HaJCoZoWL+P06H3PgBHk5cFBYNzvI74DzUc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RrUcTXWqMtmama8fJFOqeu8OHa32iO7Qrkj0t3TyV4JjkmsvD3Ob0peRZxuf/6vXXO5vSIV9V3Ezv4PciUIVKYIN5cI8SXAn/lrXzMoUy+gMaL85rZFroxaEbDyVZ6XGBpG8NPmdeXHyoR8l+1eefiAUaCItjsqJ1bzy6ZMjFxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NHkqF3PT; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NHkqF3PT"
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-46677ef6910so45488911cf.2
        for <selinux@vger.kernel.org>; Wed, 04 Dec 2024 06:31:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733322703; x=1733927503; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nuPAJjm+D1CsaLPYauHZGxfqzLl3Gy+xmM33b6ezBNw=;
        b=NHkqF3PTD6AUYMTH/d6JISlHOI2umSYovR+ydT/COzCwU5mjNZVQ9cwBQz6JRfOyqz
         Z3zZXg6QFhBXmPKjPy3arDaokrN+wUToQFnTWLmth9ECbRLUffcgRe24UAdbpsidYBns
         5YrzDJaeGDdq6ZIwsLcE0NLQSanVrDdlA5oyNoCs0dW2hLfULII7ojg85v1aJ1fD3HT5
         7szANYvMnvAiu4d70Ycw0FNP4kPG8PHLgZLMCGkuD/5Rt3dOCoUnNv3hlAeE2Bcjf+ZG
         N16by23rofvORpl6g8DRWX4Ms5P2vacSvUUf4ii/2Mccxpxk9LuaHFjG1iLC7LgZipUT
         mn3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733322703; x=1733927503;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nuPAJjm+D1CsaLPYauHZGxfqzLl3Gy+xmM33b6ezBNw=;
        b=lSqac7mg3jTa9knybFd9SpzaU17pHqxN5TG4q16Muc91uxXr3khJDsLUw7Co6/G2oM
         6gTJuOinioP7GCo8dufYPPsHWCzZQdcKnIxwFCfjH8/kaDX0XCp/4jL/G1JdIQYyw2kY
         RCi9p5PkSR0bdKK80Dw7X8cD18LY6HG7WBJu2Yif/AbmsPmr1W9PbC4FnAtjOOeUdCdk
         RyMypXHfzNJPMDiHmf+fsZZiSWiPVrn2Vz1jLHyawPAzQkOzNj8jUKnMGsUuSW02di0e
         2v3UZcGimz/GrXJ3IWtE8P2WeP8fLVlZi47lSZkFMISTPC5YD/gDjNDOAeEVCS8r7snQ
         19Vw==
X-Gm-Message-State: AOJu0YwMGsiVLEzCjpcCtTOH+nu3JannhWl9zqc2k3gOqjbbfzTKTHfA
	VQ7ootHN8ZF3cjW+ywbyyVKwa/xkkMqGZ/mK/xy15e2OQlBuJ+P/mnz3EB2CS9Gyvw6ZjAJ2O3V
	K0DTPCpyakZ2as4x7PdIx313vsPQ=
X-Gm-Gg: ASbGncuoX6F0P2DlBs1unU7kWXpMgfnIMKQcT/zHBF0nZOinMr7zi8tGfa5u/bC7Avl
	+7S+MZUeuaw1wtljMhiHEM/NELQBSU9w=
X-Google-Smtp-Source: AGHT+IEOQylrCUjVIQ4UnlybfnWr/OAsYNZDWB9cP1gDhzB4SyLhd23lNlfyDZZ8VaJRni3rz2yhRNDT146FGJCI2C0=
X-Received: by 2002:a05:6214:19c8:b0:6d8:8256:41d7 with SMTP id
 6a1803df08f44-6d8b742bcc4mr124128616d6.33.1733322703060; Wed, 04 Dec 2024
 06:31:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241128154034.23298-1-cgoettsche@seltendoof.de> <CAP+JOzRsJzQzn6f1_UZLaGg3GWNFn7HohyiAS0z6+BZcfkVELA@mail.gmail.com>
In-Reply-To: <CAP+JOzRsJzQzn6f1_UZLaGg3GWNFn7HohyiAS0z6+BZcfkVELA@mail.gmail.com>
From: James Carter <jwcart2@gmail.com>
Date: Wed, 4 Dec 2024 09:31:32 -0500
Message-ID: <CAP+JOzQDLqX6QuT5fPPbnwCfKLZ_Ot4T=eApqCfH-1GnbJL5Dw@mail.gmail.com>
Subject: Re: [PATCH] libsepol: avoid unnecessary memset(3) calls in hashtab
To: cgzones@googlemail.com
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 2, 2024 at 4:17=E2=80=AFPM James Carter <jwcart2@gmail.com> wro=
te:
>
> On Fri, Nov 29, 2024 at 6:40=E2=80=AFAM Christian G=C3=B6ttsche
> <cgoettsche@seltendoof.de> wrote:
> >
> > From: Christian G=C3=B6ttsche <cgzones@googlemail.com>
> >
> > Use struct initialization with designators to skip unnecessary memset(3=
)
> > calls.  Since libsepol is not a security boundary uninitialized padding
> > is not a concern.
> >
> > Also drop the dead assignment of a region to be free'd in the next line=
.
> >
> > Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>
> Acked-by: James Carter <jwcart2@gmail.com>
>

Merged.
Thanks,
Jim

> > ---
> >  libsepol/src/hashtab.c | 23 ++++++++++++-----------
> >  1 file changed, 12 insertions(+), 11 deletions(-)
> >
> > diff --git a/libsepol/src/hashtab.c b/libsepol/src/hashtab.c
> > index 399582b1..4c658588 100644
> > --- a/libsepol/src/hashtab.c
> > +++ b/libsepol/src/hashtab.c
> > @@ -48,12 +48,14 @@ hashtab_t hashtab_create(unsigned int (*hash_value)=
 (hashtab_t h,
> >         if (p =3D=3D NULL)
> >                 return p;
> >
> > -       memset(p, 0, sizeof(hashtab_val_t));
> > -       p->size =3D size;
> > -       p->nel =3D 0;
> > -       p->hash_value =3D hash_value;
> > -       p->keycmp =3D keycmp;
> > -       p->htable =3D (hashtab_ptr_t *) calloc(size, sizeof(hashtab_ptr=
_t));
> > +       *p =3D (hashtab_val_t) {
> > +               .size =3D size,
> > +               .nel =3D 0,
> > +               .hash_value =3D hash_value,
> > +               .keycmp =3D keycmp,
> > +               .htable =3D (hashtab_ptr_t *) calloc(size, sizeof(hasht=
ab_ptr_t)),
> > +       };
> > +
> >         if (p->htable =3D=3D NULL) {
> >                 free(p);
> >                 return NULL;
> > @@ -127,9 +129,10 @@ int hashtab_insert(hashtab_t h, hashtab_key_t key,=
 hashtab_datum_t datum)
> >         newnode =3D (hashtab_ptr_t) malloc(sizeof(hashtab_node_t));
> >         if (newnode =3D=3D NULL)
> >                 return SEPOL_ENOMEM;
> > -       memset(newnode, 0, sizeof(struct hashtab_node));
> > -       newnode->key =3D key;
> > -       newnode->datum =3D datum;
> > +       *newnode =3D (hashtab_node_t) {
> > +               .key =3D key,
> > +               .datum =3D datum,
> > +       };
> >         if (prev) {
> >                 newnode->next =3D prev->next;
> >                 prev->next =3D newnode;
> > @@ -223,8 +226,6 @@ void hashtab_destroy(hashtab_t h)
> >         }
> >
> >         free(h->htable);
> > -       h->htable =3D NULL;
> > -
> >         free(h);
> >  }
> >
> > --
> > 2.45.2
> >
> >
