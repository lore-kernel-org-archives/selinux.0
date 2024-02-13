Received: from mail-vk1-f171.google.com (mail-vk1-f171.google.com [209.85.221.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA91B60B85
	for <selinux@vger.kernel.org>; Tue, 13 Feb 2024 20:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707856728; cv=none; b=HiLyoCiW/vzctOr5U5XsMY9OAbrNG8y/DAS97MbeGjdJlvsf6cCS01R+XlIPAQ93F7BRdeKPS17bofrBUVbEc4znlget9MQkoOkhCO4v+XxudtlKrDyttQuKg1qiCuHp9meoiWx2pg4FnqkMd6iZv55OkUZrkF4QakKDwIYMBBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707856728; c=relaxed/simple;
	bh=veoR9tx0vptOJjUSQ01a48kglOQvvX2LOIIyLjKo33Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BvfmcC6+a+LYFPYa2TNJyeRan+5+gHAky9cx351K8XfvBQslps3h6oZPFOv5+EAI5wBWgTwEB/MR0tE55G82ueM5KwbN6XgBgxCJ4LiHs/aSn0RG7ms88yOTbvhzXInNV1lo2KskZIPgx9NzXrvW3nJXyyhHzFRjSjenDuiSGsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VjF/qUxL; arc=none smtp.client-ip=209.85.221.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VjF/qUxL"
Received: by mail-vk1-f171.google.com with SMTP id 71dfb90a1353d-4c069db671eso1065627e0c.1
        for <selinux@vger.kernel.org>; Tue, 13 Feb 2024 12:38:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707856726; x=1708461526; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k5gQZqsa1VGdEFrT7Ocj/loxOcLrp9mJ/SiLsLMxIhI=;
        b=VjF/qUxLXPArXaM/MJdwbRtRQbxgH8Lr9DEnlz9fECl7UdvnUg5mS2J0ElfZa6apiq
         bWhcwBUvZB3oFb8iPvC6K3F82HGPsjhOrWRd6IU2a9sxrWbwAlRQvFOl4UO+KIvKT7MI
         Zw3i4xn75E5fpYeAKE5LQ3emtqsG3ZBdGFpzd9pW2kwtXgJDz8yRYkkA7aFkmXfoG8kE
         thBJ0xL5YgEqptqtfa7E+/et5Eogo35dhQuN1yAM8/WFvRVYbP1/84Es/tqMZyLNF6J8
         iXeh4ioq5Rr4KBv5Vw8AjZjl7iXh6st38mTnZ+KQ3QZIACtmnuridYjAZ5mO5xGJcBLc
         rakA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707856726; x=1708461526;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k5gQZqsa1VGdEFrT7Ocj/loxOcLrp9mJ/SiLsLMxIhI=;
        b=rHM2xaLrFe4nkmJusl7UBVMoH3EPPgfzRLBfwQWlUg3y2YZGx/WfASt7n2pneLCDkq
         j1p1PegFxefXj/p3vsqdGZcHafBlJEn78DTFbUKB/n7CtNghdSc+wZ637GwlzWdUxlcE
         a2KCSqj9X1g7npD5XwffuozSWXewKXwn5AUmR03Wb+WiqubgyTFMhwyViVITUkOsWbgQ
         ImXkF1lFFBl0TZXLt7CZVoJ7XCH69m04b/UlXcOXLmGdtwhiuu1XqGwNFkpKRPyUY5A/
         UiWizAAPFJn/uMDSO4d9Cwqsy4H0DdP2LQmupfyafgavpbFaXawnLr8ETf+YHq2CakVN
         gA0g==
X-Gm-Message-State: AOJu0Yz4rRCg1kzHty5axN6rmV72FM+hvRx9jNKWdNyw1uLxZ9GOKE+4
	8U01LDO91Vks8XIX7YQBPE7dVm3XN2nUKevCuzoN5GfQQE6Uvf8btKg6rN+QMwskBFD8KPOBzft
	UlJSjJs+7k50fT4/C3S7jz00Uqxs=
X-Google-Smtp-Source: AGHT+IGp/VW2BUqW+64+d3iUKtsda2rZKYQrN5oWKcfXT6YQ+G2YgSmmAab7ZR1uK+uKKqcjydOzKsozX8PLk0tnekU=
X-Received: by 2002:a05:6102:c03:b0:46e:cef9:bdbf with SMTP id
 x3-20020a0561020c0300b0046ecef9bdbfmr896565vss.3.1707856725874; Tue, 13 Feb
 2024 12:38:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240122135507.63506-1-cgzones@googlemail.com> <20240122135507.63506-14-cgzones@googlemail.com>
In-Reply-To: <20240122135507.63506-14-cgzones@googlemail.com>
From: James Carter <jwcart2@gmail.com>
Date: Tue, 13 Feb 2024 15:38:34 -0500
Message-ID: <CAP+JOzR5L4r-2EFYa3XUMOBJbAANVJE_4-9njWhKJJ3JV9KGSw@mail.gmail.com>
Subject: Re: [PATCH 14/15] checkpolicy: avoid assigning garbage values
To: =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 22, 2024 at 9:02=E2=80=AFAM Christian G=C3=B6ttsche
<cgzones@googlemail.com> wrote:
>
> Only assign the computed value on success, since it is not set by
> declare_symbol() on failure.
>
> Reported by GCC:
>
>     module_compiler.c: In function 'create_role':
>     module_compiler.c:287:24: warning: use of uninitialized value 'value'=
 [CWE-457] [-Wanalyzer-use-of-uninitialized-value]
>       287 |         datum->s.value =3D value;
>           |         ~~~~~~~~~~~~~~~^~~~~~~
>
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>

Acked-by: James Carter <jwcart2@gmail.com>

> ---
>  checkpolicy/module_compiler.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/checkpolicy/module_compiler.c b/checkpolicy/module_compiler.=
c
> index 464897cc..6ff91b8f 100644
> --- a/checkpolicy/module_compiler.c
> +++ b/checkpolicy/module_compiler.c
> @@ -284,9 +284,8 @@ static int create_role(uint32_t scope, unsigned char =
isattr, role_datum_t **role
>                 ret =3D require_symbol(SYM_ROLES, id, datum, &value, &val=
ue);
>         }
>
> -       datum->s.value =3D value;
> -
>         if (ret =3D=3D 0) {
> +               datum->s.value =3D value;
>                 *role =3D datum;
>                 *key =3D strdup(id);
>                 if (*key =3D=3D NULL) {
> @@ -303,6 +302,7 @@ static int create_role(uint32_t scope, unsigned char =
isattr, role_datum_t **role
>                         free(datum);
>                         return -1;
>                 }
> +               datum->s.value =3D value;
>                 *role =3D datum;
>                 *key =3D id;
>         } else {
> @@ -529,9 +529,8 @@ static int create_user(uint32_t scope, user_datum_t *=
*user, char **key)
>                 ret =3D require_symbol(SYM_USERS, id, datum, &value, &val=
ue);
>         }
>
> -       datum->s.value =3D value;
> -
>         if (ret =3D=3D 0) {
> +               datum->s.value =3D value;
>                 *user =3D datum;
>                 *key =3D strdup(id);
>                 if (*key =3D=3D NULL) {
> @@ -539,6 +538,7 @@ static int create_user(uint32_t scope, user_datum_t *=
*user, char **key)
>                         return -1;
>                 }
>         } else if (ret =3D=3D 1) {
> +               datum->s.value =3D value;
>                 *user =3D datum;
>                 *key =3D id;
>         } else {
> --
> 2.43.0
>
>
