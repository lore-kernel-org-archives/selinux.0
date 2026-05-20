Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E40BC54768
	for <selinux@vger.kernel.org>; Wed, 20 May 2026 15:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779291292; cv=pass; b=lrVEgkdNzNGBrZKVy5nkMwpmbTcXqUtX42frQdGPH1TJNpJp6unt5+/fn6uWJdFsnpBlU7JHQGVJ8w3CnculHH27sTYs6xLzOLrxXi4Ps4C1Jpm5YhL7fLB9+BG4eq4x8mdqH4ENarbjVg+Zkbeff/J/+S7pTAM2YfaBBYnzmKo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779291292; c=relaxed/simple;
	bh=townmmkuJcH6MiJN8EmWmk5ePDBbuzhJLvNC1Jx5Gl0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GpBT7nxwiKcwBrv8LDwuUP5f5s8X2ZIOMKCQzHrxXcBrv6x1SP0BHQTpLQL7deOKNofZz5/WOHkblZl0YFQBGeJ0GAnynE6VGOjqvPFyI5DIO/PnbuDzeZFhBJQj1POhUrvvooawq6uS5lQ2VoqTf8+s7n0TyPFstvgtxA41frs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kO8PgFta; arc=pass smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kO8PgFta"
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-5aa0da74eaaso5840140e87.1
        for <selinux@vger.kernel.org>; Wed, 20 May 2026 08:34:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779291289; cv=none;
        d=google.com; s=arc-20240605;
        b=Db59PjFiTC1etcSRc+sAO9wLBWgIZKwYnbt6jZ2I09scXpxeP+jP3Bc7Gyjxt+Au2d
         CsGwtCPZuAKO5PxEfe/p/v8RCMGUkptKybTMdkkOnQ4Fl5+69dy+4IE60Dfs45SbkD6F
         Q5vJwI99qilE0UNRa0GY6qcTb6+2XMLhtI7G9zsO1K202/mDtFgrmqIEvBmxLH47lfXy
         ouFvny2avm99586fs4CCofIB/VbXo53LD65fgETLbUm0vSDysbyOGww8RG4oL+9QX9zG
         ZLG5KH8QEenwshrmhaWCQS/V46/diOJRYvjTPk5Ua6LoYKFRKEhvGA1PS+BGI8c4TW9a
         Mu2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Bn2jyqm1GYMBlsx/b0cUeJBz90BLEG+3isyvoxaUC5Q=;
        fh=RcJrr7O3svp8K5gZfgCjK7Xv0tA8i0VIpUekoWsmIc8=;
        b=birRx+wWfjhseq5KKAvT2sAdPoTSJOu4GGUYnNFHkCDWuZOjtXEGkb/bVRDdCJ7EZd
         k62Mx1NSydrN6l/NXwZtgKXw0mnpF6RUpQEew+Uv0QWngphvqCav2vT56yBI2Gt78Kf/
         TWSJizdFbuxc2Dg9CvD5o6FwesybKzlnqndz6F0v6clU1t4qtq7aHs/5ssEhesK75wFE
         3uEepGUdMIFJGykKBsdGsvvUG1+D7XkneyVRnPM77c/nUFKJnKAW/KKSyCZBXnJcWeBA
         Pe6Dh021tvcqL7PXpRQdMbWnL4/r2l5bM8Y03ZyZZame4/dN75poKQKEJbrN19aQig3D
         JRkg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779291289; x=1779896089; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Bn2jyqm1GYMBlsx/b0cUeJBz90BLEG+3isyvoxaUC5Q=;
        b=kO8PgFtaiaov+BsLoNeU3s72cr2tuqeJlEZ6CiOBUmOEGdEKytOjd9BgwHnM8gI7TL
         p6XXch+3fKpXPY8lYo8PX3jsy5KRrIvusS9JcDMCqkqgL8fyEO8Wp637qOZrWir4Vdbo
         ki1xJE2Es210MYVJ7E0m9rI+eLVxIjafGF8QtShqgw7Eo1VCnWZ2/E5yFBdrhgO30ZMB
         i6he7B8fRnLj4ojLF7X2/pgVz8XdtSLL0xJanVR583FtQ2QHTeVK2CFq+89NBxu1JkXW
         07TYWdoNaFC1SL5uz3CGCoaXOJDGXoEd3T8EtRaIrxZf58/7u0SZ2J44ymzhQ7XC0HnB
         Cz7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779291289; x=1779896089;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Bn2jyqm1GYMBlsx/b0cUeJBz90BLEG+3isyvoxaUC5Q=;
        b=mUhqIRVC3muDsMTcszLQZcJwl8Yx87EluYAacRHQxKsakFp2mKdbdmbnR0W7xLCOQ7
         GdU4lHAvZCIhOKtTcZ0e3+EwQ4j7yHmKwHu6PkmJGW6h7ybNY9dmo0eDnVWDOTgphFTN
         q9fV1gvVkrINrPIGVpG6GLetxbd8ZySp1GzYsmPUdC+0PrREGNLZydDKJ67uMjNMDX14
         ghbIAWK9NOa00KPoeI6RGliHo43xPe4MYzlAlGCeXQJsLS9to2DrpPEbOJxEHGemCEeV
         jeHI1H7f7ep1S/nsn2S+7TE+AO+8rxwj1krQVZxb8+N6W18MtXjmu7UqPcNdEEUvtC3h
         GiHQ==
X-Gm-Message-State: AOJu0YwQ6X7jVK7+rWk1DffiQYkxSBdD0/5U55wkc6vZj/KRhWGDxVx7
	RWorTIIgvn61nJmwApSI3kvonJYMwE0A13GZZvBv/lLoS3wO/SIUSqV55k56LvCPzEzsZMW91Hp
	OouaRqWVNZRdozedFX+s3PFJx9E6rt9s=
X-Gm-Gg: Acq92OFX5CA9du5gUNr/6Djtp6SL8IL6J+/9FqWZNk/3wbiJAX/VwMm/wOHcribW7iM
	tZqDYjtk3xNMUCp5X6tB8EobB3OvvM5K+2kAaHpRw19GBLFqHUrs9NIKBRl3ByGxyvUpU3LrYvA
	5jF2q4ri9gA7ASqojwEZV5G0bgXmIHL3nwoihHtExp70eVqRBXqkCajAcl4PdBz27GeMTeyNgvn
	apFBYcPvZL9CjNTDAwvm0QcZ1Br8S8rwaxDkpx79S4O/iSRA8KMptTwGB5TLkWSwttG1TawVJgy
	KJNbrhzLb91KZo8=
X-Received: by 2002:a05:6512:23c6:b0:5a7:4699:9fd8 with SMTP id
 2adb3069b0e04-5aa2ae3fb51mr723e87.16.1779291288962; Wed, 20 May 2026 08:34:48
 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260508121327.91410-1-kalevi@kolttonen.fi> <20260508121327.91410-5-kalevi@kolttonen.fi>
In-Reply-To: <20260508121327.91410-5-kalevi@kolttonen.fi>
From: James Carter <jwcart2@gmail.com>
Date: Wed, 20 May 2026 11:34:37 -0400
X-Gm-Features: AVHnY4Jj8YfIpsQXMSDnlwfRSie4VPuYWl7oI8XSGyoykcf3M95KXZ8mWRdisnk
Message-ID: <CAP+JOzR8fLePvbCuG4Rg3qcRwpeJH9HkfLVksN77_M+qNGKpVw@mail.gmail.com>
Subject: Re: [PATCH 4/4] checkpolicy: remove unneeded malloc() casts
To: Kalevi Kolttonen <kalevi@kolttonen.fi>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 8, 2026 at 8:18=E2=80=AFAM Kalevi Kolttonen <kalevi@kolttonen.f=
i> wrote:
>
> Signed-off-by: Kalevi Kolttonen <kalevi@kolttonen.fi>

Acked-by: James Carter <jwcart2@gmail.com>

> ---
>  checkpolicy/policy_define.c | 28 +++++++++++++---------------
>  1 file changed, 13 insertions(+), 15 deletions(-)
>
> diff --git a/checkpolicy/policy_define.c b/checkpolicy/policy_define.c
> index 755a8428..0a553a1f 100644
> --- a/checkpolicy/policy_define.c
> +++ b/checkpolicy/policy_define.c
> @@ -786,7 +786,7 @@ int define_sens(void)
>                 yyerror2("sensitivity identifier %s may not contain perio=
ds", id);
>                 goto bad;
>         }
> -       level =3D (mls_level_t *) malloc(sizeof(mls_level_t));
> +       level =3D malloc(sizeof(mls_level_t));
>         if (!level) {
>                 yyerror("out of memory");
>                 goto bad;
> @@ -795,7 +795,7 @@ int define_sens(void)
>         level->sens =3D 0;        /* actual value set in define_dominance=
 */
>         ebitmap_init(&level->cat);      /* actual value set in define_lev=
el */
>
> -       datum =3D (level_datum_t *) malloc(sizeof(level_datum_t));
> +       datum =3D malloc(sizeof(level_datum_t));
>         if (!datum) {
>                 yyerror("out of memory");
>                 goto bad;
> @@ -839,7 +839,7 @@ int define_sens(void)
>                         free(id);
>                         return -1;
>                 }
> -               aliasdatum =3D (level_datum_t *) malloc(sizeof(level_datu=
m_t));
> +               aliasdatum =3D malloc(sizeof(level_datum_t));
>                 if (!aliasdatum) {
>                         yyerror("out of memory");
>                         free(id);
> @@ -976,7 +976,7 @@ int define_category(void)
>                 yyerror2("category identifier %s may not contain periods"=
, id);
>                 goto bad;
>         }
> -       datum =3D (cat_datum_t *) malloc(sizeof(cat_datum_t));
> +       datum =3D malloc(sizeof(cat_datum_t));
>         if (!datum) {
>                 yyerror("out of memory");
>                 goto bad;
> @@ -1019,7 +1019,7 @@ int define_category(void)
>                         free(id);
>                         return -1;
>                 }
> -               aliasdatum =3D (cat_datum_t *) malloc(sizeof(cat_datum_t)=
);
> +               aliasdatum =3D malloc(sizeof(cat_datum_t));
>                 if (!aliasdatum) {
>                         yyerror("out of memory");
>                         free(id);
> @@ -1091,7 +1091,7 @@ static int clone_level(hashtab_key_t key __attribut=
e__ ((unused)), hashtab_datum
>                         levdatum->notdefined =3D FALSE;
>                         return 0;
>                 }
> -               newlevel =3D (mls_level_t *) malloc(sizeof(mls_level_t));
> +               newlevel =3D malloc(sizeof(mls_level_t));
>                 if (!newlevel)
>                         return -1;
>                 if (mls_level_cpy(newlevel, level)) {
> @@ -2167,7 +2167,7 @@ static int define_te_avtab_xperms_helper(int which,=
 avrule_t ** rule)
>         unsigned int i;
>         int add =3D 1, ret;
>
> -       avrule =3D (avrule_t *) malloc(sizeof(avrule_t));
> +       avrule =3D malloc(sizeof(avrule_t));
>         if (!avrule) {
>                 yyerror("out of memory");
>                 goto out;
> @@ -2231,8 +2231,7 @@ static int define_te_avtab_xperms_helper(int which,=
 avrule_t ** rule)
>         perms =3D NULL;
>         id =3D queue_head(id_queue);
>         ebitmap_for_each_positive_bit(&tclasses, node, i) {
> -               cur_perms =3D
> -                   (class_perm_node_t *) malloc(sizeof(class_perm_node_t=
));
> +               cur_perms =3D malloc(sizeof(class_perm_node_t));
>                 if (!cur_perms) {
>                         yyerror("out of memory");
>                         goto out2;
> @@ -2779,7 +2778,7 @@ static int define_te_avtab_helper(int which, avrule=
_t ** rule)
>
>         ebitmap_init(&tclasses);
>
> -       avrule =3D (avrule_t *) malloc(sizeof(avrule_t));
> +       avrule =3D malloc(sizeof(avrule_t));
>         if (!avrule) {
>                 yyerror("memory error");
>                 ret =3D -1;
> @@ -2848,8 +2847,7 @@ static int define_te_avtab_helper(int which, avrule=
_t ** rule)
>
>         perms =3D NULL;
>         ebitmap_for_each_positive_bit(&tclasses, node, i) {
> -               cur_perms =3D
> -                   (class_perm_node_t *) malloc(sizeof(class_perm_node_t=
));
> +               cur_perms =3D malloc(sizeof(class_perm_node_t));
>                 if (!cur_perms) {
>                         yyerror("out of memory");
>                         ret =3D -1;
> @@ -4390,7 +4388,7 @@ static int mls_semantic_cats_merge(mls_semantic_cat=
_t ** dst,
>         mls_semantic_cat_t *new;
>
>         while (src) {
> -               new =3D (mls_semantic_cat_t *) malloc(sizeof(mls_semantic=
_cat_t));
> +               new =3D malloc(sizeof(mls_semantic_cat_t));
>                 if (!new)
>                         return -1;
>
> @@ -4467,7 +4465,7 @@ static int parse_semantic_categories(char *id, leve=
l_datum_t * levdatum __attrib
>                 range_start =3D range_end =3D cdatum->s.value;
>         }
>
> -       newcat =3D (mls_semantic_cat_t *) malloc(sizeof(mls_semantic_cat_=
t));
> +       newcat =3D malloc(sizeof(mls_semantic_cat_t));
>         if (!newcat) {
>                 yyerror("out of memory");
>                 return -1;
> @@ -4859,7 +4857,7 @@ int define_fs_context(unsigned int major, unsigned =
int minor)
>                 return -1;
>         }
>
> -       newc->u.name =3D (char *)malloc(6);
> +       newc->u.name =3D malloc(6);
>         if (!newc->u.name) {
>                 yyerror("out of memory");
>                 free(newc);
> --
> 2.54.0
>
>
