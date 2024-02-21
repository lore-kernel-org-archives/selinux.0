Received: from mail-vs1-f50.google.com (mail-vs1-f50.google.com [209.85.217.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64F0786AE6
	for <selinux@vger.kernel.org>; Wed, 21 Feb 2024 21:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708549960; cv=none; b=d0xrWyHUMiEAPj2xJ3HDrcU+xNKwqXAQ47FvkxMXTsnP2DTXOt60xOlfyj4FYuE/izErRcCMbM+Msg+LTN3McX/pYaeiNH2IN/tPlgowXBQNXDceDa1PExixoU2XLRtYs4PAh1ooeGenqM6YqxSGsKWK3/xc7d/Sr0UfBDccqaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708549960; c=relaxed/simple;
	bh=Jb21i/UQUL61dAlma/o3I+VvaMjSL0dr7Di0qR01kZo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZXWKjaocEhVPosaishTa7KIKfU6fBJcEkAL8qyjMMhD4D3koGfcdyQuIoQR9kcvdVK8Jpe5BZtCNCxKLwbwsSomWrkOQHooQ277L+KEPV44vKJN2eg0LT7Hr4w+ws+xdJf9WkNoRuVVh5q3mzjojp7LsaP3fKy7Y5mj3YG16KhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ecYqcvYi; arc=none smtp.client-ip=209.85.217.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ecYqcvYi"
Received: by mail-vs1-f50.google.com with SMTP id ada2fe7eead31-470455b5352so726713137.2
        for <selinux@vger.kernel.org>; Wed, 21 Feb 2024 13:12:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708549957; x=1709154757; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gr/8xLpZ6aWpThStwubCn9Fgkx2VR1N7CUC+2MPNsUM=;
        b=ecYqcvYiTy86K6AupB4toa2oG8vh6nYGI8W3UDTy7FPazTrsM1TBOoDFeBcl8fdgYF
         fL8k2pYdwNorydGGpNpUOZpSxE/Yu1d3d8HTbSTzsGI0fonfvPMGBDGH/etzPvD8SH3d
         ucGnll+uCQUgdZWiNHD3TVTZSSm9r/QRTcPuDwwDoIoeGZliGdEv7JJvGPXKP3/jjpiG
         l9t+QbER2lus/J3wMkxtYwwCvQKra1lF5VKCpMySzwvtrX/ULSQO5NPwzm29xnjziKUv
         m02/hPmxjN96BoY4z21SNl0bfonjW+kxiLfDp4/7VGPqzYGI6CUffB9DguaVnjERgtsA
         0q7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708549957; x=1709154757;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gr/8xLpZ6aWpThStwubCn9Fgkx2VR1N7CUC+2MPNsUM=;
        b=YiP2HkYWKoF9Lc0DSltTaV/TgljSkzHiNFgYX5fAZ6ZxhmPz+/cjZoYLFidzCCT93u
         EMrPQMztVBn+DN2+i6v2Tll3CSsua9C8gWUpvnbEZnKXsLaRVdkiBgEoqPucFBSpMaqV
         Z799Qi5nmyyy4AOaRLIcVejvPDgaLEelwa3gk1UDTTJUSA2dRPfVQLuhvHJ/3J7bI1GB
         PtSDQVzenO3ZMj6s8lWXE6Y37yvmJjFGISaoEeVo3QE9VZ9f8sD6q3vVftbllnvFpEMc
         20jo3bHmWt52zr+QD59VSULP3mHl4/GVFNA9xtyBAbAU7OR+QIhTXPBx+7alSQIvnCP5
         O2tw==
X-Gm-Message-State: AOJu0YxAGrYPVQcCXXKp+ij2wymbvgd/1ZQOBJ/eRMG2TKOYCZsZr1+S
	Md712h0LyOne/qBM3xEq7zni0nPlxFG4gAUC3rkOwnnSDOgKrtI9L2GE9t89XoyNOznvuvRQi98
	3irvf49/hOtPzYTEeO0A+HMqcs8TKlvE+
X-Google-Smtp-Source: AGHT+IFOL5zkZZiIY35htumUARfSzN5+AjJTaG3C3Vt9iwA1braYh5KXsKjZ7RXmj+aXn6pK65ZGHPHKDBqU+syyLMY=
X-Received: by 2002:a67:f1cb:0:b0:470:3da4:1a3a with SMTP id
 v11-20020a67f1cb000000b004703da41a3amr12553529vsm.6.1708549956985; Wed, 21
 Feb 2024 13:12:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240213205605.830719-1-jwcart2@gmail.com> <CAJ2a_Dfj7kLxm1JKKZXjqD7cfdamDoW0pDXqyNBtJaHi_5bxbg@mail.gmail.com>
In-Reply-To: <CAJ2a_Dfj7kLxm1JKKZXjqD7cfdamDoW0pDXqyNBtJaHi_5bxbg@mail.gmail.com>
From: James Carter <jwcart2@gmail.com>
Date: Wed, 21 Feb 2024 16:12:25 -0500
Message-ID: <CAP+JOzQZ4Nf-8puo0HWZT1+d4ud0QVNUKNcNo4CNJmUe96=nkg@mail.gmail.com>
Subject: Re: [PATCH] checkpolicy, libsepol: Fix potential double free of mls_level_t
To: =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 15, 2024 at 1:41=E2=80=AFPM Christian G=C3=B6ttsche
<cgzones@googlemail.com> wrote:
>
> On Tue, 13 Feb 2024 at 21:56, James Carter <jwcart2@gmail.com> wrote:
> >
> > In checkpolicy, sensitivities that have aliases will temporarily
> > share the mls_level_t structure until a level statement defines the
> > categories for the level and the alias is updated to have its own
> > mls_level_t structure. Currently, this does not cause a problem
> > because checkpolicy does very little clean-up before exiting when
> > an error is detected. But if the policydb is destroyed before exiting
> > due to an error after a sensitivity and its alias is declared, but
> > before a level statement involving either of them, then a double
> > free of the shared mls_level_t will occur.
> >
> > The defined field of the level_datum_t is set after a level statement
> > is processed for the level_datum_t. This means that we know the alias
> > has its own mls_level_t if the defined field is set. This means that
> > the defined field can be used to determine whether or not the
> > mls_level_t pointed to by an alias level_datum_t should be destroyed.
> >
> > Since the defined field is not set when reading or expanding a policy,
> > update libsepol to set the defined field.
>
> I tried to avoid touching anything related to the `defined` member in
> the checkpolicy patchset, since my plan was to remove the member in a
> couple months, when the fuzzer has verified it is redundant after the
> new member `copy` was introduced.
> Currently the member `defined` is only checked once in the entire code
> base: in a sanity check in checkpolicy that I never saw triggered.
> So it is unused during binary policy parsing and CIL policy
> compilation (and also unnecessary for correct cleanup there, since the
> two active fuzzers have not found any related use-after-free issue or
> leak).
> Thus my preference is to have in the end only the `copy` member from
> my patch 10/15, which does not need to be set everywhere manually
> since the default calloc'ed value of 0 is the correct default, and
> it's only going to be used in three places:
> libsepol/src/policydb.c:sens_destroy(),
> checkpolicy/policy_define.c:define_sens() and
> checkpolicy/policy_define.c:clone_level().
>

I like the idea of not having to set the value outside of checkpolicy.
I don't like the idea of having both a "defined" and a "copy" field in
the struct.
Checkpolicy needs the "defined" field to check if a sensitivity has a
level statement associated with it.

I sent v2 of the patch where I change the field to "notdefined". It is
a bit awkward, but it does mean that the "notdefined" field is never
set except for in checkpolicy.

Thanks for the comments,
Jim


> > Signed-off-by: James Carter <jwcart2@gmail.com>
> > ---
> >  checkpolicy/policy_define.c | 11 +++++++----
> >  libsepol/src/expand.c       |  1 +
> >  libsepol/src/policydb.c     |  7 +++++--
> >  3 files changed, 13 insertions(+), 6 deletions(-)
> >
> > diff --git a/checkpolicy/policy_define.c b/checkpolicy/policy_define.c
> > index 260e609d..542bb978 100644
> > --- a/checkpolicy/policy_define.c
> > +++ b/checkpolicy/policy_define.c
> > @@ -1006,9 +1006,10 @@ static int clone_level(hashtab_key_t key __attri=
bute__ ((unused)), hashtab_datum
> >         mls_level_t *level =3D (mls_level_t *) arg, *newlevel;
> >
> >         if (levdatum->level =3D=3D level) {
> > -               levdatum->defined =3D 1;
> > -               if (!levdatum->isalias)
> > +               if (!levdatum->isalias) {
> > +                       levdatum->defined =3D 1;
> >                         return 0;
> > +               }
> >                 newlevel =3D (mls_level_t *) malloc(sizeof(mls_level_t)=
);
> >                 if (!newlevel)
> >                         return -1;
> > @@ -1017,6 +1018,7 @@ static int clone_level(hashtab_key_t key __attrib=
ute__ ((unused)), hashtab_datum
> >                         return -1;
> >                 }
> >                 levdatum->level =3D newlevel;
> > +               levdatum->defined =3D 1;
> >         }
> >         return 0;
> >  }
> > @@ -1057,8 +1059,6 @@ int define_level(void)
> >         }
> >         free(id);
> >
> > -       levdatum->defined =3D 1;
> > -
> >         while ((id =3D queue_remove(id_queue))) {
> >                 cat_datum_t *cdatum;
> >                 int range_start, range_end, i;
> > @@ -1121,6 +1121,9 @@ int define_level(void)
> >                 free(id);
> >         }
> >
> > +       if (!levdatum->isalias)
> > +               levdatum->defined =3D 1;
> > +
> >         if (hashtab_map
> >             (policydbp->p_levels.table, clone_level, levdatum->level)) =
{
> >                 yyerror("out of memory");
> > diff --git a/libsepol/src/expand.c b/libsepol/src/expand.c
> > index e63414b1..0e16c502 100644
> > --- a/libsepol/src/expand.c
> > +++ b/libsepol/src/expand.c
> > @@ -1191,6 +1191,7 @@ static int sens_copy_callback(hashtab_key_t key, =
hashtab_datum_t datum,
> >                 goto out_of_mem;
> >         }
> >         new_level->isalias =3D level->isalias;
> > +       new_level->defined =3D 1;
> >         state->out->p_levels.nprim++;
> >
> >         if (hashtab_insert(state->out->p_levels.table,
> > diff --git a/libsepol/src/policydb.c b/libsepol/src/policydb.c
> > index f10a8a95..0c950bf1 100644
> > --- a/libsepol/src/policydb.c
> > +++ b/libsepol/src/policydb.c
> > @@ -1390,8 +1390,10 @@ static int sens_destroy(hashtab_key_t key, hasht=
ab_datum_t datum, void *p
> >         if (key)
> >                 free(key);
> >         levdatum =3D (level_datum_t *) datum;
> > -       mls_level_destroy(levdatum->level);
> > -       free(levdatum->level);
> > +       if (!levdatum->isalias || levdatum->defined) {
> > +               mls_level_destroy(levdatum->level);
> > +               free(levdatum->level);
> > +       }
> >         level_datum_destroy(levdatum);
> >         free(levdatum);
> >         return 0;
> > @@ -3357,6 +3359,7 @@ static int sens_read(policydb_t * p
> >                 goto bad;
> >
> >         levdatum->isalias =3D le32_to_cpu(buf[1]);
> > +       levdatum->defined =3D 1;
> >
> >         levdatum->level =3D malloc(sizeof(mls_level_t));
> >         if (!levdatum->level || mls_read_level(levdatum->level, fp))
> > --
> > 2.43.0
> >
