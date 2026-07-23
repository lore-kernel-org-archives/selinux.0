Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1FCE47668D
	for <selinux@vger.kernel.org>; Thu, 23 Jul 2026 18:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784831852; cv=pass; b=Soo0mPzbpa7g3mNjZ5KyadQhjd3yGPe5OxyTHsPLCRYhl4b8BuGEnFkViNnGKNVDYZecMcsXzlEoj+kTXfDHcDGuoAU9NcirIIwb5pJnPFUaBzGh/jyFW7WwS0Y9FK4fpHefpTxsUctF5fNd+8NaqrQAr3/5eqFYeNBNtZ8faYc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784831852; c=relaxed/simple;
	bh=CJJdjEyMK7XwP352UA+e+jx1p8SYufIylMVQVaPlLaE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BMklRY1JWHNuh3tv2t953k7DfUBUMGP+zoXd01ziM91LT/CU6RRHqR7wccqQ17hvdssJWd+uXQetGBHNePds1Bmh0NdF841usZUOzm/+VLiNHyT4gnf2BFXt0LXfMPtghPHvv1HQf5E3Q9cdZp9UQHm0YcDb0cqfpG7PVTPbdT0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ByJvVNW2; arc=pass smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ByJvVNW2"
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-ca88130e09aso751658a12.3
        for <selinux@vger.kernel.org>; Thu, 23 Jul 2026 11:37:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784831843; cv=none;
        d=google.com; s=arc-20260327;
        b=Hh9N++HbX28QPqacdIPZX2iCIOdiOlJj7x/NF4mDcWnCSpJCTyiLPXFnspmABOP+ay
         f69KzgS9yckuBcpli1YhtHtabZoLiY9lr0C7tVow/HICt1JHFRc/XFEo7R2nadSJRVOF
         gxiq+qVZ2lU2F/bDiPhv/c8dO9v78If6Vqi3HXl97lUIWQOu/qJwZ7Cv61c0C/GRF7zC
         eg5nu6t6P7jJOPNTAby9yJ03M1+0tTF9APKREnfvojDIUKNjvKvpOxkeIt2ufgnxxDRK
         MCN5G8QctRSUgQyA/vVtBH/aNFEhSqhKfpsdLqkY4OUeX9H08FPYl/wlzQJRzL0uA8CM
         0WOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=z7ANSobByktobQF/whyRQEt4NxJS0m9zWx3vsHU60bM=;
        fh=FsXghBnyoYbEc42Idnie0oh5A6i9FUng5ntOLhqXIRs=;
        b=DLEAoh5b2O8MXzwxcxfdzoapE+3MTH/V5eyaoZA2sFXSLcihgvYv/bw/3kHT35l6E9
         9WFW8UkijFjWC32X2g+TkBvOo62wKARWPd+0KJXlRaLENJZtQlZLG7mmoLRLeA8gkA4i
         wJEVexWseUjJtMaq3NqyEc2JSQb7WpWRNi1SL14hVODZuKozrW7P+dZgBORYk5ceMA7V
         WRp3DT5j3XtVJTmrVZJkcPjD1G+gitpjQWFM1kKOlhwwKX3JidTI4sJVatuLwvtTPgFX
         p2r0NbcAA8lKMxx3mm5M4GoXL2PgLgYwuSQOhbHpixEpUofvRfLkc13W1urqo89o1tcS
         JkDQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784831843; x=1785436643; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=z7ANSobByktobQF/whyRQEt4NxJS0m9zWx3vsHU60bM=;
        b=ByJvVNW2yaDt5OF46Fi1Pe6WjqLAdEEZuzFdUJm4VDZzYOym/Sfv0vSqUG89uT9wGZ
         US58trtlq/F4WaU2rtvlxo+xQRrGx+1obmTa/O3o1X8RBt/b5D72GefSebhjXhglTace
         FTboD2m6EYmeWbf0Pc9aTix/Ud28creS3KxkvkRSQ+hIm5ZjzhVGOYv5juhyJ/NM4CMA
         QEsaLCgEL+J6zW/Clu5zacZwFmr61in4l7gexUNQ9odGB1vdqLwHrEzG16qGMBp7AXWR
         N6V7EYRfiZnj1PIebUruKrQvP64oJtMIT1cqk/b2Ff6QwmIpHalB2aaUO9hHezTlXJTs
         imMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784831843; x=1785436643;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=z7ANSobByktobQF/whyRQEt4NxJS0m9zWx3vsHU60bM=;
        b=cAc9buiKPg1saRVcoJ+HdwwA+mGaXSMjoY5+sfv7hL+y86oSgB7png6JD0dqBgpV6p
         QtjvgdNvfeCIOJfTjFqaibg6xx5c44rUccaTwAJDtip4GZf8rKrTJlubGStl7CoIuRUn
         eLLgN7FvFMVUDMtvyoED16IO0lF6NYcKBrX7SiE8dGg7XwG0ScVb6PsaXH/tnfHmAxxz
         UBQFRNQGSzSvY6CXSqe7Bp8y0PrHey2oizcYUvnYNLDsjlWkZkMnnmU78N3uwujlGmf1
         xZRwTWw9YS6EDCfmpeBZWcAqOuE5pSjMSYh9YN7sPmGCqoFkDIkMlNT6uuZsE6vaW2rj
         6Pag==
X-Gm-Message-State: AOJu0YwuB4chJq38thjaqK6DTWDwKRWrArBD4AO5UzLW+9ACCDgKbTGO
	bfc2G8jLh7FwQMANH04dc6FLaqLQ+VR/BGO1BlP4i7dWGyTxReyfvGlWbx2q57INkYhw89gFJQm
	PJ9967KawdJipqFk5Tgq3Woo1kf+x3KCLMA==
X-Gm-Gg: AR+sD11PmZ5rFoPsBvKC9yIZRZXoDouCxJi2nKJjfJ/peStmNefaj+Hd6GsQUouimaI
	+j/7VAv5irtms/ykYO79siGB/1jvCPvO8EWqxSFJsKb51oPElP5intCx1fliiuzu9wZefSSl9yf
	lwSQFpxaLlnHXL1t/XnFa8/xhXrst7XefpccbXPx1ItmRgxFXq3S+bS9u6zI2DatsAjmnWxdbWN
	2b6vVv1dzJyw2d8r+y4bu2/2Q1FeVkcl0P6qIYOcr0841UGXc772Khl3kQ38Q==
X-Received: by 2002:a05:6a21:6494:b0:3b4:870e:6f44 with SMTP id
 adf61e73a8af0-3c44b18ac3bmr4893129637.35.1784831842755; Thu, 23 Jul 2026
 11:37:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260723165436.10978-1-jwcart2@gmail.com>
In-Reply-To: <20260723165436.10978-1-jwcart2@gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Thu, 23 Jul 2026 14:37:11 -0400
X-Gm-Features: AUfX_mxNxHuvAwAglL_zAfgvueAQjGtj3tE-xRuko_CY02Rb1Azi4BqVQp5j4uk
Message-ID: <CAEjxPJ52heUU276fCsy20fsKi5YLV4QZci6hnnS6c3c1uFbWiA@mail.gmail.com>
Subject: Re: [PATCH v2] libsepol: Validate string fields used in various
 labeling rules
To: James Carter <jwcart2@gmail.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 23, 2026 at 12:54=E2=80=AFPM James Carter <jwcart2@gmail.com> w=
rote:
>
> Filename transitions and the ocontexts fs, netif, fs_use,
> ibendport, Xen devicetree, and genfs use strings in a name or type
> field used to identify what to label.
>
> Check that these strings do not contain any control characters to
> protect against maliciously crafted policies.
>
> Signed-off-by: James Carter <jwcart2@gmail.com>

Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>

> ---
> v2: Added another check in validate_genfs() and a check in
>      validate_filename_trans_rules
>
>  libsepol/src/policydb_validate.c | 35 +++++++++++++++++++++++++++-----
>  1 file changed, 30 insertions(+), 5 deletions(-)
>
> diff --git a/libsepol/src/policydb_validate.c b/libsepol/src/policydb_val=
idate.c
> index cde0b8d6..e7d79871 100644
> --- a/libsepol/src/policydb_validate.c
> +++ b/libsepol/src/policydb_validate.c
> @@ -1,4 +1,5 @@
>
> +#include <ctype.h>
>  #include <sepol/policydb/conditional.h>
>  #include <sepol/policydb/ebitmap.h>
>  #include <sepol/policydb/polcaps.h>
> @@ -129,6 +130,23 @@ bad:
>         return -1;
>  }
>
> +static int validate_string_field(const char *s)
> +{
> +       if (!s || !*s)
> +               goto bad;
> +
> +       while (*s) {
> +               if (iscntrl((unsigned char)*s))
> +                       goto bad;
> +               s++;
> +       }
> +
> +       return 0;
> +
> +bad:
> +       return -1;
> +}
> +
>  static int validate_ebitmap(const ebitmap_t *map, const validate_t *flav=
or)
>  {
>         if (ebitmap_length(map) > 0 &&
> @@ -1436,6 +1454,8 @@ static int validate_filename_trans(hashtab_key_t k,=
 hashtab_datum_t d,
>                 goto bad;
>         if (validate_value(ftk->tclass, &flavors[SYM_CLASSES]))
>                 goto bad;
> +       if (validate_string_field(ftk->name))
> +               goto bad;
>         if (!ftd)
>                 goto bad;
>         for (; ftd; ftd =3D ftd->next) {
> @@ -1505,7 +1525,7 @@ static int validate_ocontexts(sepol_handle_t *handl=
e, const policydb_t *p,
>                                         if (validate_context(&octx->conte=
xt[1],
>                                                              flavors, p->=
mls))
>                                                 goto bad;
> -                                       if (!octx->u.name)
> +                                       if (validate_string_field(octx->u=
.name))
>                                                 goto bad;
>                                         break;
>                                 case OCON_PORT:
> @@ -1522,7 +1542,7 @@ static int validate_ocontexts(sepol_handle_t *handl=
e, const policydb_t *p,
>                                         default:
>                                                 goto bad;
>                                         }
> -                                       if (!octx->u.name)
> +                                       if (validate_string_field(octx->u=
.name))
>                                                 goto bad;
>                                         break;
>                                 case OCON_IBPKEY:
> @@ -1533,7 +1553,8 @@ static int validate_ocontexts(sepol_handle_t *handl=
e, const policydb_t *p,
>                                 case OCON_IBENDPORT:
>                                         if (octx->u.ibendport.port =3D=3D=
 0)
>                                                 goto bad;
> -                                       if (!octx->u.ibendport.dev_name)
> +                                       if (validate_string_field(
> +                                                   octx->u.ibendport.dev=
_name))
>                                                 goto bad;
>                                         break;
>                                 }
> @@ -1560,7 +1581,7 @@ static int validate_ocontexts(sepol_handle_t *handl=
e, const policydb_t *p,
>                                                 goto bad;
>                                         break;
>                                 case OCON_XEN_DEVICETREE:
> -                                       if (!octx->u.name)
> +                                       if (validate_string_field(octx->u=
.name))
>                                                 goto bad;
>                                         break;
>                                 }
> @@ -1590,9 +1611,11 @@ static int validate_genfs(sepol_handle_t *handle, =
const policydb_t *p,
>                             validate_value(octx->v.sclass,
>                                            &flavors[SYM_CLASSES]))
>                                 goto bad;
> +                       if (validate_string_field(octx->u.name))
> +                               goto bad;
>                 }
>
> -               if (!genfs->fstype)
> +               if (validate_string_field(genfs->fstype))
>                         goto bad;
>         }
>
> @@ -1728,6 +1751,8 @@ validate_filename_trans_rules(sepol_handle_t *handl=
e,
>                         goto bad;
>                 if (validate_simpletype(filename_trans->otype, p, flavors=
))
>                         goto bad;
> +               if (validate_string_field(filename_trans->name))
> +                       goto bad;
>
>                 /* currently only the RULE_SELF flag can be set */
>                 switch (filename_trans->flags) {
> --
> 2.55.0
>
