Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C98D219D896
	for <selinux@vger.kernel.org>; Fri, 14 Jun 2024 14:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718374429; cv=none; b=EtbehXjyeXj6AQ+sJ+15hXa/50sr9JGOWy2mbg3njNB8YL6gI25NIfzygvV1hWALiUVYdMkdA+/oeHCCmMZ4iSDf0pYdF08VDr3GKw7vY/iatWdzedeZ/OJj4tcSXc5D3bX3ZJtcf3Ct1gEWCw+uo1C3CJD4uYQ2pkyQP84xnfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718374429; c=relaxed/simple;
	bh=bOKxuht0xzIJw4P1t0M5qf9tJBj1u++PBoRe7fSmWq0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RPR/6l/LVQT4sDpP50PbPp0MvoRx2J98/G/vGObjVJYaK2Wai5zee1mEoCAna3gGJZKIDOUHNe+L9tP5dsqi34pemzK3eBF6g7RywlkBrbSTl3umZhTA9S9/bljaehWR1CxQbRh/IIBceKnlNu8hytMWnQ0lHhYHGTHYCbxFXr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H0Dio+/b; arc=none smtp.client-ip=209.85.210.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H0Dio+/b"
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-6f986b92acaso1188116a34.2
        for <selinux@vger.kernel.org>; Fri, 14 Jun 2024 07:13:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718374427; x=1718979227; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jLpFQJTPcKHTrp1DbPn9hsMlah3JU62QIWCzqozTO40=;
        b=H0Dio+/bQzfIzgRKhAwuVg02nQtHvDorzmCrXwjxAqD+G30L2Hap2RW7Xy9Qt23bav
         KFMxn4GMMgAyrgWIGTyMndN0ZLhZHCfm2Em2NZ7gKpyR2GOAL2yj4nmqFhzE6eFmfhE/
         vyCosagbxJ8BOQPduGdait5y7dAMMyXeNR8tjHVmjGOKhrQvHZgfFZz9dkfkxRMqPcoq
         YalAMi5oQ/7I0maPUldARNHYlz1kWe7gj19pGa3FnxsquIdOh2dKTwwWHQ8/V3R5fxBU
         d9CLdUcjLZohkSsA7Z4vz9V5w8C0SpIBKHlVhKDALgq6vuvmb4AdMnjPj3lH7XtXbyDy
         MGrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718374427; x=1718979227;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jLpFQJTPcKHTrp1DbPn9hsMlah3JU62QIWCzqozTO40=;
        b=GepHllLVTBCfsCos3BlAzo1VKz287O0swWz++6fbu8YFFpMZd9G9pvSJu2HT1QSYGs
         wPBYBG2IRdQmTnBvyukmKN1wC49SFZayOSRq+rR24X5+zpd3mExXYK6eEG7h3UgzSg9A
         GzQeUJsNM1+/62L1T8J5/UnjSuHYOTlIWhLdB97WF16WdXlaD7/hVGFe8jXi5JZKiKxl
         xa1bv43oQmWbEpijCOAU3lKt8ex/+VWYOVcylqxyMUzpNHMDxmdreKVtGIj4rjgQlzVs
         d5fkOIegt6LiYaYQu5JnXtS01t/+zhaXHNw7k6gxIL1MJuztRq7/Poelh7CZ+GGE8Mc5
         UpTA==
X-Gm-Message-State: AOJu0YxOv+MnKQy5QsA+IujBb069GRu8Iui6RmafhWa2HPpervkv9o4B
	aWqAiAWUDYtoP0/XdHIMDx0kbCncA/wqEST8aGMDiB2JbhX478/FtQdNSzqZcvdL3v4f8y9bCvT
	GfAvY7pFw3EWEBMTp7km440NRnw0=
X-Google-Smtp-Source: AGHT+IGHJczRc9R5hUVF3+x66e74ovcCfyINcbG413rdA99xxvFBbIoO+RtbIEFcob9zhOCUAdZFGL+/XccpX+4Ljrs=
X-Received: by 2002:a05:6808:128b:b0:3d2:2b1d:7bd9 with SMTP id
 5614622812f47-3d24e9085e7mr3106879b6e.33.1718374426698; Fri, 14 Jun 2024
 07:13:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240608172332.140336-1-cgoettsche@seltendoof.de> <CAP+JOzQPRyF06cb=y4LQ-ASt3ei48bb7WCwSUoivsx+yus2oUg@mail.gmail.com>
In-Reply-To: <CAP+JOzQPRyF06cb=y4LQ-ASt3ei48bb7WCwSUoivsx+yus2oUg@mail.gmail.com>
From: James Carter <jwcart2@gmail.com>
Date: Fri, 14 Jun 2024 10:13:35 -0400
Message-ID: <CAP+JOzQfmwrnPacBFS81vShFxJ6tGrNG1bw+X=xz-0z5uc+ABQ@mail.gmail.com>
Subject: Re: [PATCH] tree-wide: fix misc typos
To: cgzones@googlemail.com
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 12, 2024 at 2:10=E2=80=AFPM James Carter <jwcart2@gmail.com> wr=
ote:
>
> On Sat, Jun 8, 2024 at 1:23=E2=80=AFPM Christian G=C3=B6ttsche
> <cgoettsche@seltendoof.de> wrote:
> >
> > From: Christian G=C3=B6ttsche <cgzones@googlemail.com>
> >
> > Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>
> Acked-by: James Carter <jwcart2@gmail.com>
>

Merged.
Thanks,
Jim

> > ---
> >  libselinux/utils/sefcontext_compile.c | 2 +-
> >  libsepol/src/kernel_to_cil.c          | 4 ++--
> >  libsepol/src/kernel_to_conf.c         | 4 ++--
> >  secilc/docs/cil_reference_guide.md    | 4 ++--
> >  4 files changed, 7 insertions(+), 7 deletions(-)
> >
> > diff --git a/libselinux/utils/sefcontext_compile.c b/libselinux/utils/s=
efcontext_compile.c
> > index 6c32172d..8677189e 100644
> > --- a/libselinux/utils/sefcontext_compile.c
> > +++ b/libselinux/utils/sefcontext_compile.c
> > @@ -189,7 +189,7 @@ static int write_binary_file(struct saved_data *dat=
a, int fd,
> >                 if (len !=3D 1)
> >                         goto err;
> >
> > -               /* original context strin (including nul) */
> > +               /* original context string (including nul) */
> >                 len =3D fwrite(context, sizeof(char), to_write, bin_fil=
e);
> >                 if (len !=3D to_write)
> >                         goto err;
> > diff --git a/libsepol/src/kernel_to_cil.c b/libsepol/src/kernel_to_cil.=
c
> > index e20ba4af..f94cb245 100644
> > --- a/libsepol/src/kernel_to_cil.c
> > +++ b/libsepol/src/kernel_to_cil.c
> > @@ -303,7 +303,7 @@ static int class_constraint_rules_to_strs(struct po=
licydb *pdb, char *classkey,
> >                         goto exit;
> >                 }
> >                 if (*perms =3D=3D '\0') {
> > -                       ERR(NULL, "No permisisons in permission string"=
);
> > +                       ERR(NULL, "No permissions in permission string"=
);
> >                         free(perms);
> >                         rc =3D -1;
> >                         goto exit;
> > @@ -1782,7 +1782,7 @@ static char *avtab_node_to_str(struct policydb *p=
db, avtab_key_t *key, avtab_dat
> >                         goto exit;
> >                 }
> >                 if (*perms =3D=3D '\0') {
> > -                       ERR(NULL, "No permisisons in permission string"=
);
> > +                       ERR(NULL, "No permissions in permission string"=
);
> >                         free(perms);
> >                         goto exit;
> >                 }
> > diff --git a/libsepol/src/kernel_to_conf.c b/libsepol/src/kernel_to_con=
f.c
> > index 5860a513..ca91ffae 100644
> > --- a/libsepol/src/kernel_to_conf.c
> > +++ b/libsepol/src/kernel_to_conf.c
> > @@ -298,7 +298,7 @@ static int class_constraint_rules_to_strs(struct po=
licydb *pdb, char *classkey,
> >                         goto exit;
> >                 }
> >                 if (*perms =3D=3D '\0') {
> > -                       ERR(NULL, "No permisisons in permission string"=
);
> > +                       ERR(NULL, "No permissions in permission string"=
);
> >                         free(perms);
> >                         rc =3D -1;
> >                         goto exit;
> > @@ -1748,7 +1748,7 @@ static char *avtab_node_to_str(struct policydb *p=
db, avtab_key_t *key, avtab_dat
> >                         goto exit;
> >                 }
> >                 if (*permstring =3D=3D '\0') {
> > -                       ERR(NULL, "No permisisons in permission string"=
);
> > +                       ERR(NULL, "No permissions in permission string"=
);
> >                         free(permstring);
> >                         goto exit;
> >                 }
> > diff --git a/secilc/docs/cil_reference_guide.md b/secilc/docs/cil_refer=
ence_guide.md
> > index d1d3ff16..5ae5a3a3 100644
> > --- a/secilc/docs/cil_reference_guide.md
> > +++ b/secilc/docs/cil_reference_guide.md
> > @@ -281,7 +281,7 @@ The number of `expr_set`'s in an `expr` is dependen=
t on the statement type (ther
> >          (mlsconstrain (process (transition dyntransition))
> >              (or (and (eq h1 h2) (eq l1 l2)) (eq t1 mlstrustedsubject))=
)
> >
> > -        ; The equivalent policy language mlsconstrain statememt is:
> > +        ; The equivalent policy language mlsconstrain statement is:
> >          ;mlsconstrain process { transition dyntransition }
> >          ;    ((h1 eq h2 and l1 eq l2) or t1 =3D=3D mlstrustedsubject);
> >
> > @@ -289,7 +289,7 @@ The number of `expr_set`'s in an `expr` is dependen=
t on the statement type (ther
> >          (mlsconstrain (process (getsched getsession getpgid getcap get=
attr ptrace share))
> >              (or (dom l1 l2) (eq t1 mlstrustedsubject)))
> >
> > -        ; The equivalent policy language mlsconstrain statememt is:
> > +        ; The equivalent policy language mlsconstrain statement is:
> >          ;mlsconstrain process { getsched getsession getpgid getcap get=
attr ptrace share }
> >          ;    (l1 dom l2 or t1 =3D=3D mlstrustedsubject);
> >      ```
> > --
> > 2.45.1
> >
> >
