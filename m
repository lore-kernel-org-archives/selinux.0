Received: from mail-vk1-f172.google.com (mail-vk1-f172.google.com [209.85.221.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36A2017591
	for <selinux@vger.kernel.org>; Thu, 20 Mar 2025 16:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742488844; cv=none; b=gq09h0jfcm8bReToeesr5VGcRJUCLoitbOEylhGvJv28HCtqW8VrAu6mXSLC5Q7eXTICRC80jYvvEBLRz0SyuDMZMd+ztr2+l26183iQSE7+BRhOFSjlcxU5iqvIjMeW1FFS2h48hegVxptumsApO+z8wUXCnsqSw/EqKXph5Eo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742488844; c=relaxed/simple;
	bh=1ykALsIEbpzfYmn23yiil+SzxTI10ELorHjM0tloNKs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dHetW1VYo6X9UkXWc+cOdVH85/HPnKClQPR0zGp/KSQdSrrhWQgpUAJSWEuk6Owlqqlk+bVlKMo1PuaxtaKjzNzjbi0bb4czmlWbPXw5DZNm+4ak1W1NFduar2MbMvvebvTOzwQbw2ynJPSSs31WESvB9VUh7nGyqA9SS3e3Giw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=My9qBBJ1; arc=none smtp.client-ip=209.85.221.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="My9qBBJ1"
Received: by mail-vk1-f172.google.com with SMTP id 71dfb90a1353d-5240b014f47so447320e0c.1
        for <selinux@vger.kernel.org>; Thu, 20 Mar 2025 09:40:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742488842; x=1743093642; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UCegpu9fl5lmnERharMrY+CtzaIb3NyKxrVXWPW5RMU=;
        b=My9qBBJ1r4WM0yrbLTsylwQhVxeOOqwe5nQkhQmGwdd3Jo5yyRli91rMfTAjxGr8PQ
         YSA+4oqR0Q48iig75UC4cQSjhjrzsuVGeVZFH0oI6IczK5pMazvxlsXgMC88dHf3ILTv
         Yyy9WCsAQ9g4d7Zj7JWsrQck7iYqmtShzGX5Ggr2JSvKgeKL9+8UpCDqBHN5WkOJTArE
         FhSALC4L/9NjFJMS1gKD3j7UMRATSVC/k2nOXN5qbWQvcqz3+XcO7brSxa63JkYsivIe
         T33IO59xQDAmtdQb6iybFh98CtzAC764UJ3BOoJxZim7kZPTSbJjvmWQEz/frR582Kp3
         Nm9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742488842; x=1743093642;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UCegpu9fl5lmnERharMrY+CtzaIb3NyKxrVXWPW5RMU=;
        b=KOJ9F5fak49spg37W7j6j1JT/E30CyB+Z82oRrdNJBbCV75ZmBu+mYD9EKZm7FVLlJ
         nEepO33/5nGR2zZRsunYru2iKqABvchTfjKqG80dCU7RW85oZjEC0wEEM46KkxrWVrV+
         iQwMl1YqpC7jA/0XKbM7wPc6sEANW2MJSQjTrmDIpKg2mqZT/4ipgPvyaEFJkLVa5lVF
         H/oXVWhLhNyb2yQ6XkIhMWsVzo1l1nVAxd8sYM8rfrC9DI4lUtQLSjlTCryPi5R4cRnw
         abOvJpvC8ivSlgQTwXys56oQvaQNRdu2HGFj/ItZ2Qdl1U1olFIqxjDnUx+QAi7dyBoS
         j5+g==
X-Gm-Message-State: AOJu0YzXK8Da7VWjm0eg+qOOhRjmGqkwhA6NCvL9vNMTwnG9ocWSxls3
	k4DIT70qdWH5X7tg74QzOgxcHwGUrpEHg5GvzPLuSMnXc1SoDA/S5NkcR27sAB4u5Pk7JR/ekJ6
	I/0ghXpSxOaKAFON1bbp5sZmUOG0=
X-Gm-Gg: ASbGncvs16tHFcyZxmEaoUy/S7VRjwHauSHXS0QJ0p5KmQD412uw/JSIauE9c0+Tmrz
	RYhkphbiHmJOosxPh06A9XVk4ILN+m1Ri9FykivPHkO6lrFlW+LTJzExZCZoozkA0ssmNWu2qbP
	Iw+27NmRccyQKW7OkAvsDUEnJb/RfAb47zFg==
X-Google-Smtp-Source: AGHT+IG/vG4QSvY6D0jc4KaFlVoQEHiDI8qjaVekPQ58OsQeF0WQeotvlfTa09dYSL9KHmsu80ClT00p/3USGTCBO14=
X-Received: by 2002:a05:6102:160f:b0:4c1:7d0d:a48c with SMTP id
 ada2fe7eead31-4c4ec85828emr7576217137.22.1742488841922; Thu, 20 Mar 2025
 09:40:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250222172631.18683-1-cgoettsche@seltendoof.de>
In-Reply-To: <20250222172631.18683-1-cgoettsche@seltendoof.de>
From: James Carter <jwcart2@gmail.com>
Date: Thu, 20 Mar 2025 12:40:31 -0400
X-Gm-Features: AQ5f1Jpj2QyVVMy1zimgPyqk9HWhJE9yfIkhP4dXeMIMcOPvHlvkTmTfvKX359w
Message-ID: <CAP+JOzQtx53dN7TNjpWddEQL-tUrjapOJ1Ex6j1HHfYbcPVQdA@mail.gmail.com>
Subject: Re: [PATCH] checkpolicy: rework cleanup in define_te_avtab_xperms_helper()
To: =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 22, 2025 at 12:34=E2=80=AFPM Christian G=C3=B6ttsche
<cgoettsche@seltendoof.de> wrote:
>
> From: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>
> Clean up the local avrule on error, since its ownership is not
> transferred. Also clean up the local ebitmap on error.
>
> Reported-by: oss-fuzz (issue 398356438)
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>

Acked-by: James Carter <jwcart2@gmail.com>

> ---
>  checkpolicy/policy_define.c | 29 ++++++++++++++---------------
>  1 file changed, 14 insertions(+), 15 deletions(-)
>
> diff --git a/checkpolicy/policy_define.c b/checkpolicy/policy_define.c
> index f19e9f6d..06068556 100644
> --- a/checkpolicy/policy_define.c
> +++ b/checkpolicy/policy_define.c
> @@ -1610,7 +1610,8 @@ struct val_to_name {
>
>  /* Adds a type, given by its textual name, to a typeset.  If *add is
>     0, then add the type to the negative set; otherwise if *add is 1
> -   then add it to the positive side. */
> +   then add it to the positive side.
> +   The identifier `id` is always consumed. */
>  static int set_types(type_set_t * set, char *id, int *add, char starallo=
wed)
>  {
>         type_datum_t *t;
> @@ -2117,18 +2118,17 @@ static int define_te_avtab_xperms_helper(int whic=
h, avrule_t ** rule)
>  {
>         char *id;
>         class_perm_node_t *perms, *tail =3D NULL, *cur_perms =3D NULL;
> -       class_datum_t *cladatum;
> -       perm_datum_t *perdatum =3D NULL;
> +       const class_datum_t *cladatum;
> +       const perm_datum_t *perdatum;
>         ebitmap_t tclasses;
>         ebitmap_node_t *node;
>         avrule_t *avrule;
>         unsigned int i;
> -       int add =3D 1, ret =3D 0;
> +       int add =3D 1, ret;
>
>         avrule =3D (avrule_t *) malloc(sizeof(avrule_t));
>         if (!avrule) {
>                 yyerror("out of memory");
> -               ret =3D -1;
>                 goto out;
>         }
>         avrule_init(avrule);
> @@ -2139,14 +2139,13 @@ static int define_te_avtab_xperms_helper(int whic=
h, avrule_t ** rule)
>         avrule->xperms =3D NULL;
>         if (!avrule->source_filename) {
>                 yyerror("out of memory");
> -               return -1;
> +               goto out;
>         }
>
>         while ((id =3D queue_remove(id_queue))) {
>                 if (set_types
>                     (&avrule->stypes, id, &add,
>                      which =3D=3D AVRULE_XPERMS_NEVERALLOW ? 1 : 0)) {
> -                       ret =3D -1;
>                         goto out;
>                 }
>         }
> @@ -2156,13 +2155,11 @@ static int define_te_avtab_xperms_helper(int whic=
h, avrule_t ** rule)
>                         free(id);
>                         if (add =3D=3D 0 && which !=3D AVRULE_XPERMS_NEVE=
RALLOW) {
>                                 yyerror("-self is only supported in never=
allow and neverallowxperm rules");
> -                               ret =3D -1;
>                                 goto out;
>                         }
>                         avrule->flags |=3D (add ? RULE_SELF : RULE_NOTSEL=
F);
>                         if ((avrule->flags & RULE_SELF) && (avrule->flags=
 & RULE_NOTSELF)) {
>                                 yyerror("self and -self are mutual exclus=
ive");
> -                               ret =3D -1;
>                                 goto out;
>                         }
>                         continue;
> @@ -2170,7 +2167,6 @@ static int define_te_avtab_xperms_helper(int which,=
 avrule_t ** rule)
>                 if (set_types
>                     (&avrule->ttypes, id, &add,
>                      which =3D=3D AVRULE_XPERMS_NEVERALLOW ? 1 : 0)) {
> -                       ret =3D -1;
>                         goto out;
>                 }
>         }
> @@ -2178,7 +2174,6 @@ static int define_te_avtab_xperms_helper(int which,=
 avrule_t ** rule)
>         if ((avrule->ttypes.flags & TYPE_COMP)) {
>                 if (avrule->flags & RULE_NOTSELF) {
>                         yyerror("-self is not supported in complements");
> -                       ret =3D -1;
>                         goto out;
>                 }
>                 if (avrule->flags & RULE_SELF) {
> @@ -2190,7 +2185,7 @@ static int define_te_avtab_xperms_helper(int which,=
 avrule_t ** rule)
>         ebitmap_init(&tclasses);
>         ret =3D read_classes(&tclasses);
>         if (ret)
> -               goto out;
> +               goto out2;
>
>         perms =3D NULL;
>         id =3D queue_head(id_queue);
> @@ -2199,8 +2194,7 @@ static int define_te_avtab_xperms_helper(int which,=
 avrule_t ** rule)
>                     (class_perm_node_t *) malloc(sizeof(class_perm_node_t=
));
>                 if (!cur_perms) {
>                         yyerror("out of memory");
> -                       ret =3D -1;
> -                       goto out;
> +                       goto out2;
>                 }
>                 class_perm_node_init(cur_perms);
>                 cur_perms->tclass =3D i + 1;
> @@ -2238,9 +2232,14 @@ static int define_te_avtab_xperms_helper(int which=
, avrule_t ** rule)
>
>         avrule->perms =3D perms;
>         *rule =3D avrule;
> +       return 0;
>
> +out2:
> +       ebitmap_destroy(&tclasses);
>  out:
> -       return ret;
> +       avrule_destroy(avrule);
> +       free(avrule);
> +       return -1;
>  }
>
>  /* index of the u32 containing the permission */
> --
> 2.47.2
>
>
