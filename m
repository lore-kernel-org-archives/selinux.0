Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EB79135A5C
	for <selinux@vger.kernel.org>; Thu, 25 Jan 2024 19:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706212617; cv=none; b=pgC3OQA8BRGnBFOUZWK/U/ab+owpmZ3OQXzLqHXvzrAuJQZdxH3V0E1MW6zFxecT/EEBpEDOExsaAjQFPpcrUM8u5gzVoVr9R2jZj31s6gimemTJ/u6pku80jdgoZo997QiDEGG2b44Xa0HZ7/YaqzHUEdboXiSpz1vPN3vTMOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706212617; c=relaxed/simple;
	bh=2/3paeaNp9wM+nYdj3g3KChg3OXOvURqLvcV+lQmZ58=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=T7r7PwN4t1+KcVRImbctaYJjpeUM5t/pKfUj5qL3jfb2/DzTfw+IILEofXdL44PTvkQ30h81to/pMDL4duU7U/sbNz8rSbfN5QagPrbRKb1IS+W+zRTGhnB6GBeENA+cdopgit+Rl8QIU6w8EPfjVXjvC9WcIoy5yQG2uUba2Ng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YaMPWQ6k; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YaMPWQ6k"
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2cf1c3b23aeso11799501fa.1
        for <selinux@vger.kernel.org>; Thu, 25 Jan 2024 11:56:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706212612; x=1706817412; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mlMJewZWOCLfqCgKkgRt7B8GzDWB1r5/NkPErOFMqLI=;
        b=YaMPWQ6k+CQoNqJk2KshceN2ukODux9SbnEN+0UMnba8QceH+12JxauyC5zbGOex3s
         fx8np9H1NvYL5aogjeSTnqCDjMKdKMh6W3kSg/8RP/0ZpkiISDuMAevdA1FqER4kVBnP
         LTjAf6dcyfQgvmFJuq9MKzn7ZfiwbxNMOPp24FeaWtXEOusyIuhLosc80wc+7cpq3kAS
         cpzn8OOEC5bmEmlR0iGqCfvNPKcw2Tc7y8PFOARcltl/N3Mi36pM+ZOCwQFM+iK8VY2q
         59AwPd95x3s2K7PM9SGoW7voijdmLPc1lwvoEFGKlLqqGCPyPswRj9R3XwYx6wh5Shsl
         dOYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706212612; x=1706817412;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mlMJewZWOCLfqCgKkgRt7B8GzDWB1r5/NkPErOFMqLI=;
        b=vaO+PaFApR7RNuo+BDmU1IqhpWXJbV6AkjkOZFBx4RNN5sTFGJucZolw42h044pxrX
         dUBEMWpv3YQRQfpYur19yIJnOjLYpou8OWnnOjlkRH9vjD1STZ1YMuQSAxAsMGL9MNke
         CwdQ1CJuxsMqt6lLu+gxnXHveZfycINAk5bUtoqrRL3Go36A3Ras87JZlsTbm+/4eJ4Y
         eLsw26Ux+6e02/fzRaCmEekFIbIog08OaRwIslkH5f7Dt9mKYCW5KblBvrwUom8miix7
         kgTeYIuYFtMuh+D10s4ekKcwur1fXAapnRhLeb+wRQ9IlwtJRkkTBxxDBcYf3HqthrmP
         Ldzg==
X-Gm-Message-State: AOJu0YzxXj2VF2mIznQgrTcaHS58XX5llENkGbXO/wUFdsqudq9aCvSk
	Fzd6u98j/Bkyopp+X5QPRU6FjFlgTOKWr2NtHCty1bGJNi28Zo/ChOTTW76liLx9cIHhYBum1wT
	hcGp65fJiOWFgEIyRQoiKc2U7fQg=
X-Google-Smtp-Source: AGHT+IHXDJu8RCHao6yfBx+AsnRBMIu6tDjsKbt60TGFnBbnVkKO8k6nQs11cj8b7UCGw6T6sx6vENNPtILI1Kos4SM=
X-Received: by 2002:a2e:9799:0:b0:2cf:15be:462e with SMTP id
 y25-20020a2e9799000000b002cf15be462emr36548lji.11.1706212612454; Thu, 25 Jan
 2024 11:56:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240105183534.1110639-1-cgzones@googlemail.com> <CAP+JOzSjf8zZCETt108K2nboKmsHNnhnKva+u_nw7xYashU_aA@mail.gmail.com>
In-Reply-To: <CAP+JOzSjf8zZCETt108K2nboKmsHNnhnKva+u_nw7xYashU_aA@mail.gmail.com>
From: James Carter <jwcart2@gmail.com>
Date: Thu, 25 Jan 2024 14:56:41 -0500
Message-ID: <CAP+JOzS7Ekht3dsz-Da9vX8a3bs5B3UzMeyKz=zh5SKJLOM1bQ@mail.gmail.com>
Subject: Re: [PATCH 1/4] libsepol: reorder calloc(3) arguments
To: =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 5, 2024 at 2:56=E2=80=AFPM James Carter <jwcart2@gmail.com> wro=
te:
>
> On Fri, Jan 5, 2024 at 1:36=E2=80=AFPM Christian G=C3=B6ttsche
> <cgzones@googlemail.com> wrote:
> >
> > The canonical order of calloc(3) parameters is the number of elements
> > first and the size of each element second.
> >
> > Reported by GCC 14:
> >
> >     kernel_to_conf.c:814:47: warning: 'calloc' sizes specified with 'si=
zeof' in the earlier argument and not in the later argument [-Wcalloc-trans=
posed-args]
> >     kernel_to_conf.c:945:46: warning: 'calloc' sizes specified with 'si=
zeof' in the earlier argument and not in the later argument [-Wcalloc-trans=
posed-args]
> >     kernel_to_conf.c:2109:35: warning: 'calloc' sizes specified with 's=
izeof' in the earlier argument and not in the later argument [-Wcalloc-tran=
sposed-args]
> >     kernel_to_common.c:578:29: warning: 'calloc' sizes specified with '=
sizeof' in the earlier argument and not in the later argument [-Wcalloc-tra=
nsposed-args]
> >
> > Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>
> For these four patches:
> Acked-by: James Carter <jwcart2@gmail.com>
>

These four patches have been merged.
Thanks,
Jim

> > ---
> >  libsepol/src/kernel_to_common.c | 2 +-
> >  libsepol/src/kernel_to_conf.c   | 6 +++---
> >  2 files changed, 4 insertions(+), 4 deletions(-)
> >
> > diff --git a/libsepol/src/kernel_to_common.c b/libsepol/src/kernel_to_c=
ommon.c
> > index 4612eef3..2422eed0 100644
> > --- a/libsepol/src/kernel_to_common.c
> > +++ b/libsepol/src/kernel_to_common.c
> > @@ -575,7 +575,7 @@ static int sort_ocontext_data(struct ocontext **oco=
ns, int (*cmp)(const void *,
> >                 return 0;
> >         }
> >
> > -       data =3D calloc(sizeof(*data), num);
> > +       data =3D calloc(num, sizeof(*data));
> >         if (!data) {
> >                 ERR(NULL, "Out of memory");
> >                 return -1;
> > diff --git a/libsepol/src/kernel_to_conf.c b/libsepol/src/kernel_to_con=
f.c
> > index 83f46e0f..e6b449b4 100644
> > --- a/libsepol/src/kernel_to_conf.c
> > +++ b/libsepol/src/kernel_to_conf.c
> > @@ -811,7 +811,7 @@ static int write_sensitivity_rules_to_conf(FILE *ou=
t, struct policydb *pdb)
> >         num =3D strs_num_items(strs);
> >
> >         if (num > 0) {
> > -               sens_alias_map =3D calloc(sizeof(*sens_alias_map), pdb-=
>p_levels.nprim);
> > +               sens_alias_map =3D calloc(pdb->p_levels.nprim, sizeof(*=
sens_alias_map));
> >                 if (!sens_alias_map) {
> >                         rc =3D -1;
> >                         goto exit;
> > @@ -942,7 +942,7 @@ static int write_category_rules_to_conf(FILE *out, =
struct policydb *pdb)
> >         num =3D strs_num_items(strs);
> >
> >         if (num > 0) {
> > -               cat_alias_map =3D calloc(sizeof(*cat_alias_map), pdb->p=
_cats.nprim);
> > +               cat_alias_map =3D calloc(pdb->p_cats.nprim, sizeof(*cat=
_alias_map));
> >                 if (!cat_alias_map) {
> >                         rc =3D -1;
> >                         goto exit;
> > @@ -2106,7 +2106,7 @@ static int write_cond_nodes_to_conf(FILE *out, st=
ruct policydb *pdb)
> >                 return 0;
> >         }
> >
> > -       cond_data =3D calloc(sizeof(struct cond_data), num);
> > +       cond_data =3D calloc(num, sizeof(struct cond_data));
> >         if (!cond_data) {
> >                 rc =3D -1;
> >                 goto exit;
> > --
> > 2.43.0
> >
> >
