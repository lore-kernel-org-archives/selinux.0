Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93E381A9B44
	for <selinux@vger.kernel.org>; Mon, 18 Nov 2024 20:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731960701; cv=none; b=M/HLJbMa0LrvWptxkwhdQwGARvaCIFVlymap09gSGO8+CZgskM8238eWdUKHVXy/+PuChEV8VmQsXJsRyN7gt+Q9xdnHKJRh5zUMe2YcSsc5VLOWc5ERfssG28ziC+p20G1iALaFE72ZwJ8M7LYeYr5dT9O2lxjrBOHRXyn5Q/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731960701; c=relaxed/simple;
	bh=3Ap/IN3akgTb6zO0BA+h7JARkGlmUgxweLCkxGuDkVs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lcR5Yr8zFMvhIa3mDVfLqZcQM5932XtClsns8DA88mjKiCL8Ib+686MpvtgM+5AAjXzDawvu5kqTyIpEkmc7OK+0FXfuKhpUIeRn2UFMRD7RNkY7b3eyzZ4kU/lGk3Z9VdRKdzcpW8O/LL4QHVZCpRtfhmAVC0X9LE4VM0cyWpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SzEr1BML; arc=none smtp.client-ip=209.85.167.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SzEr1BML"
Received: by mail-oi1-f176.google.com with SMTP id 5614622812f47-3e786167712so2260356b6e.3
        for <selinux@vger.kernel.org>; Mon, 18 Nov 2024 12:11:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731960698; x=1732565498; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=clWFstC1wpTbcB+IiTGMdR4orxqDl0R359cQAWF9ROs=;
        b=SzEr1BMLN1WaZcHE96lEEzXUaRTsTK98OUfzXbnE0hKKtDzJNuKXY5ZZT+ubLyRqMA
         NVGXYnZ33R8DC0mKqbx0/bO09iBwp4oPK/7slJX3QuV5o1UL963cAgTkVGCxdMnWcq+5
         HgwIIkY25LqCJEkfpOz1zAcWSgXrE9e4daqUY2xBwPeJ3L9I6x0qHmF3WZcnGg4plZCP
         ez4QtQxWi7gJjDUJ7t8FlXfAgdBznKUOjBj1YaN4M2itREPYfiP7432O5kfn/9IPKukj
         8kRfGivwZ0sALzSPUB3zGqZ8zMwRmnXfQG+LTEbW76/m59Gt8Q3V1ojmwXp5xL8i5wvp
         aS5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731960698; x=1732565498;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=clWFstC1wpTbcB+IiTGMdR4orxqDl0R359cQAWF9ROs=;
        b=S/0z/WAgPiJnLbkOB5u821uhcJAgWXzvwlNUYpoYcmjJteft9dgREo3+dCNcb73XGC
         unm/4rfBdry9B5/tx8LC436OjMLvXktjyCUATi1cRbd5w4rPxIaEHoijvSaYZsKP465n
         1Uc2xOLzzDY7zTARLbWJBEkQ9MzAEWwj+TaRyAydaN50m5FEAXaI1MjFWa2fz+Hae6oM
         ZBbv0HLX3rb5ntmAgRJdIn+0giLQX+5xOdASS/pioxdxIhEVJwIRFeAhCpk6vNl9N7WR
         CNYmLdEOZ6MIeDtfLdtTqdAyQzTriA3tmeUcX3udh7YPOKn9x1AQlvL6SDxzbySMX4zK
         ssqA==
X-Gm-Message-State: AOJu0Yx6uXQLsdXrLKJLI7VVpJcOwNd+jFpMtWwCK61DNFv3iD9zh4tU
	mvyF+FSCvZ/SQMD7qc65zNueHbYJaPBXcljKfVva4f23eUWUtEPLzls/G1wTri+LaBK7nruhis3
	JwK/OQwzd9W+cwbB1Ysh7H0qHWIY/Lg==
X-Google-Smtp-Source: AGHT+IGI6vDoLYaRA9/p7TI7IA7Dj+j8VbQaqzLyYP/SSTLVC1CDDWqwxdCW84wi30JgwmFpl2qxXNKWQA0gWAzKTng=
X-Received: by 2002:a05:6808:159e:b0:3e6:404e:881a with SMTP id
 5614622812f47-3e7bc83677cmr9387459b6e.33.1731960698539; Mon, 18 Nov 2024
 12:11:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241104142500.20055-1-jwcart2@gmail.com> <CAP+JOzSPVouL=887pg+_+kQK5Fvxe0R28mgfGKvSz0_=nr2ymg@mail.gmail.com>
In-Reply-To: <CAP+JOzSPVouL=887pg+_+kQK5Fvxe0R28mgfGKvSz0_=nr2ymg@mail.gmail.com>
From: James Carter <jwcart2@gmail.com>
Date: Mon, 18 Nov 2024 15:11:27 -0500
Message-ID: <CAP+JOzSjAJVNq50x=G4ZhYen3_qjJ9EDgecCy2_-eDbz7qPqPw@mail.gmail.com>
Subject: Re: [PATCH 1/3] libsepol/cil: Optionally allow duplicate role declarations
To: selinux@vger.kernel.org
Cc: cgoettsche@seltendoof.de, pebenito@ieee.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 15, 2024 at 8:59=E2=80=AFAM James Carter <jwcart2@gmail.com> wr=
ote:
>
> On Mon, Nov 4, 2024 at 9:25=E2=80=AFAM James Carter <jwcart2@gmail.com> w=
rote:
> >
> > Allow duplicate role declarations (along with duplicate type and
> > type attribute declarations and context rules) if the multiple_decls
> > field in the CIL db has been set. This field can be set by a call to
> > cil_set_multiple_decls().
> >
> > Signed-off-by: James Carter <jwcart2@gmail.com>
>
> I plan on merging these three patches soon.
> Jim
>

These three patches have been merged.
Jim

> > ---
> >  libsepol/cil/src/cil_build_ast.c | 8 +++++++-
> >  1 file changed, 7 insertions(+), 1 deletion(-)
> >
> > diff --git a/libsepol/cil/src/cil_build_ast.c b/libsepol/cil/src/cil_bu=
ild_ast.c
> > index 19fbb04e..80e9c679 100644
> > --- a/libsepol/cil/src/cil_build_ast.c
> > +++ b/libsepol/cil/src/cil_build_ast.c
> > @@ -137,6 +137,7 @@ static int cil_allow_multiple_decls(struct cil_db *=
db, enum cil_flavor f_new, en
> >         switch (f_new) {
> >         case CIL_TYPE:
> >         case CIL_TYPEATTRIBUTE:
> > +       case CIL_ROLE:
> >                 if (db->multiple_decls) {
> >                         return CIL_TRUE;
> >                 }
> > @@ -1744,7 +1745,12 @@ int cil_gen_role(struct cil_db *db, struct cil_t=
ree_node *parse_current, struct
> >
> >         rc =3D cil_gen_node(db, ast_node, (struct cil_symtab_datum*)rol=
e, (hashtab_key_t)key, CIL_SYM_ROLES, CIL_ROLE);
> >         if (rc !=3D SEPOL_OK) {
> > -               goto exit;
> > +               if (rc =3D=3D SEPOL_EEXIST) {
> > +                       cil_destroy_role(role);
> > +                       role =3D NULL;
> > +               } else {
> > +                       goto exit;
> > +               }
> >         }
> >
> >         return SEPOL_OK;
> > --
> > 2.47.0
> >
