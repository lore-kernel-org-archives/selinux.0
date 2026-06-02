Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A39FA39184A
	for <selinux@vger.kernel.org>; Tue,  2 Jun 2026 15:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780412472; cv=pass; b=tqW+Q5F2scf+rnJu/nBFjhicPxz6SdsqJx8eAJ8tANbFsCEEapIXKGg1B2fGmvUeese0vuiXadUV+Mj+6Ri4M6bVx7dZOZ0ljBmcpHbUNILh0eWpx0CtiHPpfDQU/C0p1scy16PuobYE+THG8sOwYmD2t//+IELHjG8CfaUQlfw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780412472; c=relaxed/simple;
	bh=YfcURcCfDmBsKKmrmkBM8gvinCyFeeQcpjoLVcciup8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SNpCNd1SPHmbKhs+qdPGzEiCfPYq7FNrF2S0Z50p6DWPXKgxKXzdo0IIgiBO9tZTEM+deJm6iLWJZZoB+Fsvu2pgWqvTTpPoWxo5futXGp+YCqmV30eLzSXmUAcmJY2X0QwWrCk7GeXd4VoRKyKZZxnLp96mAsKkIzlfPDtL8+I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JOxiV4l3; arc=pass smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JOxiV4l3"
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-3965bc493caso29941191fa.2
        for <selinux@vger.kernel.org>; Tue, 02 Jun 2026 08:01:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780412469; cv=none;
        d=google.com; s=arc-20240605;
        b=RxV04jeOPAYe/qwyKzx5KrsYiOvTChV3g9UTMcS0alKIS/tmp/3QshfYfEUjwjZ8fo
         wVv/ws8pxUS8Y5JWmUyyQWfHaWg5U1GMFFlBz/hdMzRarKg5XyszUkGslp0A8B+cr+Et
         nTAK54Smh+XnAbz3hOVFeHU9QCOLyKMwLFYZC2+zo/L5JDBWa8ipULNVQChFs1ZUqklu
         jIEKdGC6V1iU0VdOTLd8WFG1NXdI9kKGZANrbxUL4D+SqsaBBLICIg6nrjY5hB8msGmm
         yRbM0pqm019E2SQ+k4X5lX4L0qQmvc3eNtsi+yljBF3EroT98cjYuRGZSUI+BDp7orja
         qL6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=A8gc7kpJoQEkDeUmbTfN+5oJEjWHYL6T7ku3RV1pR1s=;
        fh=+D6xJ6BB9J6NyoJZZl71KoOEMrrFPGwz9kIyEgHHWvo=;
        b=UgbACu5X2ytWoRLzf8xNLEtNh67WTnCkcogrVVqjLOXn21kS29BCuo4ifJPpfBtwj5
         XI8b8Z5W1VU+qmwIaDZKhpkUM4x9LoUMnbxYSbXrz1GYI8FmunN6lAgV5rNK1GOEEZsE
         y2AdXK8rPKZtmY/72giLPL6Gavm7x1RHUIw67jpCM0Z+ZCa4b59lDbk5PgdmZkiRDyW3
         wqQJ465VKdZjS/H8QDFqccvgcdZtGlV8v2Ee5AddYfXGPBNzAosbe5XqdqElnoSdNP7G
         U7ohNTvzhbj1/eP02noH0+gy0g0qwfr1lVHweSVhCqRA1lxUjPlN4M/8Lzp3+RFIS5Tb
         nb6g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780412469; x=1781017269; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A8gc7kpJoQEkDeUmbTfN+5oJEjWHYL6T7ku3RV1pR1s=;
        b=JOxiV4l3H2eJiNHL0pvYkZSfsBID77ro/Nms/T+ChWdaHkerhBbckIp5CuLUvPqhja
         RpHAMyH4UgNaku9lIpfe1JXgUCHj0Ayb8knmYm+6cqEAP66OcLXqb/1FK/pM2NhhCEi/
         uVq9UUYe5dihyn1ljrapIeH38mTD9py/UEjV9LJEemN8IhhVFdrst25/HoNHxHVqDw/G
         eoSdUW1g1g4i6m+JHYMY5QPVi73p5tubMdlwki+gAXQoUQ56gGa7U3mmgwA+Xlk1zl6W
         hFbleV4sBYCImgryEkHizWWy5nrSmNTLu3ANUDYwkcuhZnWq34xgQyQSrpVDzQw52Csz
         DX2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780412469; x=1781017269;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=A8gc7kpJoQEkDeUmbTfN+5oJEjWHYL6T7ku3RV1pR1s=;
        b=G6KnqFvbuSZbxzChSenbxkjQBzFO2UrC0k/rOkIVirBteBp3+74LAM75GdlAajwYWB
         +V8gmv75gNRxd9lCGpexAxV1XUJHMW1fcj0FFA8YNWRj8xfxDnsup+vELSNvDvrOS8+C
         77R+sF8hWz4DMD16eN2kC0Noy3QV84L2tdt9qTKxNOt2avfccjUgzsee3+TgBGbdiAoB
         Erv3i8/c3p3UlVryTCFefz6gq/LILNAG3YjXHeAB6hQjDibbQk/Y4lTB5i2v0aosfXmd
         JXN2lOhoHlszLIr8sfhCvpY3nlCm71f1RpYSIb+PUOKjH9W3dn8sbt9/ZSRV1U9n5t++
         Bg+w==
X-Gm-Message-State: AOJu0YxW45b+OoDdN9pdfJxQ1SxSKk0tqss4ftucvNQBp0aHQ3mks8D5
	/gBoVF69O6mUb8cG+t3UgfYS4nezr345VQx2RFnQNYzY4PB/YbYJ0pUXQAnip2gpOj2S70o3bmJ
	OZ3kSUoAG1IoVsopdhuQ0H5lxNmxEjSunTQ==
X-Gm-Gg: Acq92OF9bXYFRUiGad/nrSh2Uo+rBsHjF/bKIREOhbC+/mAiFtcMI5C3aPcCNi5vG/f
	VSjS+8qLTXmgm/akLXNirIgLTGdAeZiRZLvtJz9tX3MjX2MeuRuKDRxHsZfbuhMIm7hq8cxlDAL
	uBlbk4QQnLbL5gAOReoOJofsd/pyoHMfKHIvih270QTpXqxL8Avp5QetqVTAWDsVOdXtthFm2Ol
	KY4mFdYt7lFAlc3G6QZhgsvFmUXYwGR7tuzRuDw3xrLx4NOQ2/NO/wGXb7i+PH7qlrmLvk7BaAO
	0MTujGfGJoxtj+s=
X-Received: by 2002:a2e:be1c:0:b0:396:6bd5:a9cb with SMTP id
 38308e7fff4ca-396ac2de864mr268721fa.15.1780412468221; Tue, 02 Jun 2026
 08:01:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260528163930.418992-2-nvraxn@posteo.uk> <CAP+JOzRB=2-jSQaSVjVQ12YHb5yTM71yPrXmFDDG_FiaQaT3TQ@mail.gmail.com>
In-Reply-To: <CAP+JOzRB=2-jSQaSVjVQ12YHb5yTM71yPrXmFDDG_FiaQaT3TQ@mail.gmail.com>
From: James Carter <jwcart2@gmail.com>
Date: Tue, 2 Jun 2026 11:00:55 -0400
X-Gm-Features: AVHnY4LtPDCvTMug6ZYsNgKwoQZ8IcziM9Z8LBVbLluFmT5bNLamPPIbh3sc83k
Message-ID: <CAP+JOzQcGMxH1e-rG+2sOMOAbR7NU9a2fdnJbrst-1xrzXqfsg@mail.gmail.com>
Subject: Re: [PATCH] libsepol: check the number of elements in the avtab
To: Rahul Sandhu <nvraxn@posteo.uk>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 29, 2026 at 9:42=E2=80=AFAM James Carter <jwcart2@gmail.com> wr=
ote:
>
> On Thu, May 28, 2026 at 12:57=E2=80=AFPM Rahul Sandhu <nvraxn@posteo.uk> =
wrote:
> >
> > Instead of counting each time we semantically see an AV rule, check the
> > number of elements in the access vector table. AV rules may collapse to
> > nothing, for example:
> >
> > (class foo (bar baz))
> > (classorder (foo))
> >
> > (allow t self (foo (not (bar baz))))
> >
> > Previously, the compiler would incorrectly count the above rule as one
> > AV rule, when in reality it collapses down to nothing as no permissions
> > are actually granted.
> >
> > Signed-off-by: Rahul Sandhu <nvraxn@posteo.uk>
>
> Acked-by: James Carter <jwcart2@gmail.com>
>
Merged.
Thanks,
Jim

> > ---
> >  libsepol/cil/src/cil_binary.c | 6 ++++++
> >  libsepol/cil/src/cil_post.c   | 8 --------
> >  libsepol/cil/src/cil_verify.c | 6 ------
> >  libsepol/cil/src/cil_verify.h | 1 -
> >  4 files changed, 6 insertions(+), 15 deletions(-)
> >
> > diff --git a/libsepol/cil/src/cil_binary.c b/libsepol/cil/src/cil_binar=
y.c
> > index 74ec3cd5..dca1937a 100644
> > --- a/libsepol/cil/src/cil_binary.c
> > +++ b/libsepol/cil/src/cil_binary.c
> > @@ -5468,6 +5468,12 @@ int cil_binary_create_allocated_pdb(const struct=
 cil_db *db, sepol_policydb_t *p
> >                 goto exit;
> >         }
> >
> > +       if (pdb->te_avtab.nel =3D=3D 0) {
> > +               cil_log(CIL_ERR, "Policy must include at least one avru=
le\n");
> > +               rc =3D SEPOL_ERR;
> > +               goto exit;
> > +       }
> > +
> >         rc =3D SEPOL_OK;
> >
> >  exit:
> > diff --git a/libsepol/cil/src/cil_post.c b/libsepol/cil/src/cil_post.c
> > index 2b6dad73..fa59d337 100644
> > --- a/libsepol/cil/src/cil_post.c
> > +++ b/libsepol/cil/src/cil_post.c
> > @@ -2506,7 +2506,6 @@ exit:
> >  static int cil_post_verify(struct cil_db *db)
> >  {
> >         int rc =3D SEPOL_ERR;
> > -       int avrule_cnt =3D 0;
> >         int handleunknown =3D -1;
> >         int mls =3D -1;
> >         int nseuserdflt =3D 0;
> > @@ -2518,7 +2517,6 @@ static int cil_post_verify(struct cil_db *db)
> >
> >         extra_args.db =3D db;
> >         extra_args.csymtab =3D &csymtab;
> > -       extra_args.avrule_cnt =3D &avrule_cnt;
> >         extra_args.handleunknown =3D &handleunknown;
> >         extra_args.mls =3D &mls;
> >         extra_args.nseuserdflt =3D &nseuserdflt;
> > @@ -2548,12 +2546,6 @@ static int cil_post_verify(struct cil_db *db)
> >                 }
> >         }
> >
> > -       if (avrule_cnt =3D=3D 0) {
> > -               cil_log(CIL_ERR, "Policy must include at least one avru=
le\n");
> > -               rc =3D SEPOL_ERR;
> > -               goto exit;
> > -       }
> > -
> >         if (nseuserdflt > 1) {
> >                 cil_log(CIL_ERR, "Policy cannot contain more than one s=
elinuxuserdefault, found: %d\n", nseuserdflt);
> >                 rc =3D SEPOL_ERR;
> > diff --git a/libsepol/cil/src/cil_verify.c b/libsepol/cil/src/cil_verif=
y.c
> > index 9654d71d..d3c4fd81 100644
> > --- a/libsepol/cil/src/cil_verify.c
> > +++ b/libsepol/cil/src/cil_verify.c
> > @@ -1621,7 +1621,6 @@ exit:
> >  int __cil_verify_helper(struct cil_tree_node *node, uint32_t *finished=
, void *extra_args)
> >  {
> >         int rc =3D SEPOL_ERR;
> > -       int *avrule_cnt =3D 0;
> >         int *handleunknown;
> >         int *mls;
> >         int *nseuserdflt =3D 0;
> > @@ -1635,7 +1634,6 @@ int __cil_verify_helper(struct cil_tree_node *nod=
e, uint32_t *finished, void *ex
> >         }
> >
> >         db =3D args->db;
> > -       avrule_cnt =3D args->avrule_cnt;
> >         handleunknown =3D args->handleunknown;
> >         mls =3D args->mls;
> >         nseuserdflt =3D args->nseuserdflt;
> > @@ -1671,10 +1669,6 @@ int __cil_verify_helper(struct cil_tree_node *no=
de, uint32_t *finished, void *ex
> >                 case CIL_TYPE:
> >                         rc =3D __cil_verify_type(node);
> >                         break;
> > -               case CIL_AVRULE:
> > -                       (*avrule_cnt)++;
> > -                       rc =3D SEPOL_OK;
> > -                       break;
> >                 case CIL_HANDLEUNKNOWN:
> >                         if (*handleunknown !=3D -1) {
> >                                 cil_log(CIL_ERR, "Policy can not have m=
ore than one handleunknown\n");
> > diff --git a/libsepol/cil/src/cil_verify.h b/libsepol/cil/src/cil_verif=
y.h
> > index daa2f80a..f86d07ed 100644
> > --- a/libsepol/cil/src/cil_verify.h
> > +++ b/libsepol/cil/src/cil_verify.h
> > @@ -49,7 +49,6 @@ enum cil_syntax {
> >  struct cil_args_verify {
> >         struct cil_db *db;
> >         struct cil_complex_symtab *csymtab;
> > -       int *avrule_cnt;
> >         int *handleunknown;
> >         int *mls;
> >         int *nseuserdflt;
> > --
> > 2.54.0
> >
> >
