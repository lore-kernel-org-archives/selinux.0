Received: from mail-ua1-f54.google.com (mail-ua1-f54.google.com [209.85.222.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3956318C034
	for <selinux@vger.kernel.org>; Fri, 15 Nov 2024 13:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731679100; cv=none; b=X/YtHh5tR2mHkp9wxlxVR4EM6EH3TYoJ16HjVsJTceX1c/VrDYKep2F2Eg/O0MkAayhmostOspHEBROcDat80Fvbip1Owa3Pr+I8bc2gS17L2Rgk2porcsxa3hTGD5XWJaidTZA41pMx6bZnrQGV3UffCTcNk+35/wZvQCtkCgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731679100; c=relaxed/simple;
	bh=Teg7VHhCOHQXGlSO99zc5zN2baKjLQSTKnTXaMT+UCk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oxmS4/GZpIPIBa3dSg4RCR0E0SeB7cxiQqLESt5kTdb2OP0OOV4+505AvKT6phWs1Zc4jKzQBSTHTRJCOaUEdFy9QE/Hjix1e2CKGnhAnIOaYZd6j9c8yHFdAiH9vo4kjbBT38ndQwS6EV/+GFYXC50NwJu8Mz2/KhqAPKe+uhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V8yqTRf1; arc=none smtp.client-ip=209.85.222.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V8yqTRf1"
Received: by mail-ua1-f54.google.com with SMTP id a1e0cc1a2514c-856e51bf038so295195241.2
        for <selinux@vger.kernel.org>; Fri, 15 Nov 2024 05:58:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731679098; x=1732283898; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X9idNWV0dctQSIKABfxwhgAyXi4Bt1qPYe/I6yr51sg=;
        b=V8yqTRf19MfewB2DyFPZl0yUWjy0+1++nlNRITOKbMHCPVGZRZAeGlJxPFmhRPqO4C
         iUz6mKHrfGSm0O5uERlzN0p51ZrmhlgK3U8cbX66JNS7VrD1dqPweHRtsgF98A0TRdE+
         wdgoi9d8akhpusp1ZallDkk95WIXJomv97IMwJhLfqJVERNOqvioH8rYsqwKzcVfsB8x
         2XpE8tffn4B1N51sWTc7c9VRCTlyIsboXt0U13tHVkiMVj5N2PJ5PNbhA45mmrkq5+lS
         OLr5wpocwY5nq89fkdZEMTBpKMz7UgGKMwxmQzgMxgdAh3/7KqJWIGTk93IpEXRFDJDx
         AAaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731679098; x=1732283898;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X9idNWV0dctQSIKABfxwhgAyXi4Bt1qPYe/I6yr51sg=;
        b=JsMEN9zlb07hvhilnxwDFqPOD+ipQ8EuN/AUVDxx/tc4kidzmlfpUv5GPw5ofAXe2p
         Br8tEYttR0tdBx4NWaeIm9YVzoFF7k4a+2CoKGIBW01JQ6o+8mrweCRWV3gZO4c7Ylrv
         3U6jFiM5HiDIc7lmXfCZgjmm6bISztqGSS1Knyve9NjgGbYemyQ4G5si5mAye2wyMqbd
         NyB9CDmZZU+8f0kewlnLol+e6wxHTeKGfjKZ3qy7rte/YdN2DXf3C3eqojdyFnXH9qFO
         cUwQL7HUytIBZLGVbUtVaoRGa38AUAchSe/kFMVbPGWCHK3NII6wB0ddm+FWRjW4+61J
         FJ2Q==
X-Gm-Message-State: AOJu0YyXbpqFD366W8c6xPTk8G+5LrTKUSZD+Hmehk7X7CTYaZzIOhxm
	geLrx3WK3Ftb4KRTuQLoQ6Ye5iieKFf1VuBRe2+RA3CaqTc1kuRqECVT0Y18TRlOpX3zdGvYnB0
	3HBN3p6QuGrkugQkQgcxQCDwuv9eKhQ==
X-Google-Smtp-Source: AGHT+IH8t3hJ/GBw0T5VVEBBmF9gFcqVobuXiVvQQV5NXP6vyofFcXUNhWFtzMvatMahQz3KYOP8uIaEU/KeX9TYfIc=
X-Received: by 2002:a05:6102:370d:b0:49b:cfbc:63ac with SMTP id
 ada2fe7eead31-4ad62b6574fmr3230764137.6.1731679097830; Fri, 15 Nov 2024
 05:58:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240828151557.204343-1-jwcart2@gmail.com>
In-Reply-To: <20240828151557.204343-1-jwcart2@gmail.com>
From: James Carter <jwcart2@gmail.com>
Date: Fri, 15 Nov 2024 08:58:07 -0500
Message-ID: <CAP+JOzQJ0HsyeVy5d-RCyOCD8XF7q6m_1kmwCvrY83AOXEQw0Q@mail.gmail.com>
Subject: Re: [PATCH v3] checkpolicy: Fix MLS users in optional blocks
To: selinux@vger.kernel.org
Cc: cgzones@googlemail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 28, 2024 at 11:16=E2=80=AFAM James Carter <jwcart2@gmail.com> w=
rote:
>
> When a user is created in an optional block, a user datum is added
> to both the avrule_decl's symtab and the policydb's symtab, but
> the semantic MLS information is only added to the avrule_decl's
> user datum. This causes an error to occur during policy expansion
> when user_copy_callback() is called. If this error did not occur
> then the policydb's user datum would be written without any MLS
> info and the policy would fail validation when read later.
>
> When creating a user datum, search for a user datum with the same
> key in the policydb's symtab. If that datum has no MLS information,
> then copy the MLS information from the avrule_decl's datum. If it
> does, then compare the default level, low level, and high level
> sensitivities and give an error if they do not match. There is not
> enough information to expand the categories for the high and low
> levels, so merge the semantic categories. If the two category sets
> are not equal an error will occur during the expansion phase.
>
> A minimum policy to demonstrate the bug:
> class CLASS1
> sid kernel
> class CLASS1 { PERM1 }
> sensitivity SENS1;
> dominance { SENS1 }
> level SENS1;
> mlsconstrain CLASS1 { PERM1 } ((h1 dom h2) and (l1 domby h1));
> type TYPE1;
> allow TYPE1 self : CLASS1 PERM1;
> role ROLE1;
> role ROLE1 types TYPE1;
> optional {
>   require {
>     role ROLE1;
>   }
>   user USER2 roles ROLE1 level SENS1 range SENS1;
> }
> user USER1 roles ROLE1 level SENS1 range SENS1;
> sid kernel USER1:ROLE1:TYPE1:SENS1
>
> Signed-off-by: James Carter <jwcart2@gmail.com>

I plan on merging this soon.
Jim

> ---
> v2:
>   - Fixed mls_semantic_cats_merge() so that it keeps existing cats in dst
>   - Made src const in mls_add_or_check_level()
> v3:
>   - Free id in the error path
>
>  checkpolicy/policy_define.c | 72 ++++++++++++++++++++++++++++++++++++-
>  1 file changed, 71 insertions(+), 1 deletion(-)
>
> diff --git a/checkpolicy/policy_define.c b/checkpolicy/policy_define.c
> index bfeda86b..af8d007c 100644
> --- a/checkpolicy/policy_define.c
> +++ b/checkpolicy/policy_define.c
> @@ -4175,6 +4175,50 @@ static int parse_categories(char *id, level_datum_=
t * levdatum, ebitmap_t * cats
>         return 0;
>  }
>
> +static int mls_semantic_cats_merge(mls_semantic_cat_t ** dst,
> +                                                                  const =
mls_semantic_cat_t * src)
> +{
> +       mls_semantic_cat_t *new;
> +
> +       while (src) {
> +               new =3D (mls_semantic_cat_t *) malloc(sizeof(mls_semantic=
_cat_t));
> +               if (!new)
> +                       return -1;
> +
> +               mls_semantic_cat_init(new);
> +               new->low =3D src->low;
> +               new->high =3D src->high;
> +               new->next =3D *dst;
> +               *dst =3D new;
> +
> +               src =3D src->next;
> +       }
> +
> +       return 0;
> +}
> +
> +static int mls_add_or_check_level(mls_semantic_level_t *dst, const mls_s=
emantic_level_t *src)
> +{
> +       if (!dst->sens) {
> +               if (mls_semantic_level_cpy(dst, src) < 0) {
> +                       yyerror("out of memory");
> +                       return -1;
> +               }
> +       } else {
> +               if (dst->sens !=3D src->sens) {
> +                       return -1;
> +               }
> +               /* Duplicate cats won't cause problems, but different cat=
s will
> +                * result in an error during expansion */
> +               if (mls_semantic_cats_merge(&dst->cat, src->cat) < 0) {
> +                       yyerror("out of memory");
> +                       return -1;
> +               }
> +       }
> +
> +       return 0;
> +}
> +
>  static int parse_semantic_categories(char *id, level_datum_t * levdatum =
__attribute__ ((unused)),
>                                      mls_semantic_cat_t ** cats)
>  {
> @@ -4233,7 +4277,7 @@ static int parse_semantic_categories(char *id, leve=
l_datum_t * levdatum __attrib
>  int define_user(void)
>  {
>         char *id;
> -       user_datum_t *usrdatum;
> +       user_datum_t *usrdatum, *usr_global;
>         level_datum_t *levdatum;
>         int l;
>
> @@ -4258,10 +4302,16 @@ int define_user(void)
>                 return 0;
>         }
>
> +       id =3D strdup(queue_head(id_queue));
> +
>         if ((usrdatum =3D declare_user()) =3D=3D NULL) {
> +               free(id);
>                 return -1;
>         }
>
> +       usr_global =3D hashtab_search(policydbp->p_users.table, (hashtab_=
key_t) id);
> +       free(id);
> +
>         while ((id =3D queue_remove(id_queue))) {
>                 if (set_user_roles(&usrdatum->roles, id))
>                         return -1;
> @@ -4288,6 +4338,7 @@ int define_user(void)
>                 usrdatum->dfltlevel.sens =3D levdatum->level->sens;
>
>                 while ((id =3D queue_remove(id_queue))) {
> +                       /* This will add to any already existing categori=
es */
>                         if (parse_semantic_categories(id, levdatum,
>                                                     &usrdatum->dfltlevel.=
cat)) {
>                                 free(id);
> @@ -4313,6 +4364,7 @@ int define_user(void)
>                         usrdatum->range.level[l].sens =3D levdatum->level=
->sens;
>
>                         while ((id =3D queue_remove(id_queue))) {
> +                               /* This will add to any already existing =
categories */
>                                 if (parse_semantic_categories(id, levdatu=
m,
>                                                &usrdatum->range.level[l].=
cat)) {
>                                         free(id);
> @@ -4333,6 +4385,24 @@ int define_user(void)
>                                 return -1;
>                         }
>                 }
> +
> +               if (usr_global && usr_global !=3D usrdatum) {
> +                       if (mls_add_or_check_level(&usr_global->dfltlevel=
,
> +                                                                        =
  &usrdatum->dfltlevel)) {
> +                               yyerror("Problem with user default level"=
);
> +                               return -1;
> +                       }
> +                       if (mls_add_or_check_level(&usr_global->range.lev=
el[0],
> +                                                                        =
  &usrdatum->range.level[0])) {
> +                               yyerror("Problem with user low level");
> +                               return -1;
> +                       }
> +                       if (mls_add_or_check_level(&usr_global->range.lev=
el[1],
> +                                                                        =
  &usrdatum->range.level[1])) {
> +                               yyerror("Problem with user high level");
> +                               return -1;
> +                       }
> +               }
>         }
>         return 0;
>  }
> --
> 2.46.0
>
