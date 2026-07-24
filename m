Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDC9F3AD50A
	for <selinux@vger.kernel.org>; Fri, 24 Jul 2026 16:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784909239; cv=pass; b=W5iirK37Gv/3IGPCDABFo1ah2hB5QClDoAWOgFivzLWM3UI5uZ430ssUE0PMHUZ+5owly7HnA6z8vnE7m7DGo/aD3WPoV/KuPq85ouAv20D//xfV4iApHoXLn2L77lv796YuUGyh9cFBkRmTimGiRkxalbYsKbDtEIgyyBADMCA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784909239; c=relaxed/simple;
	bh=vdiQs24C3uJT8t7dTZYmfCpnVl5zUn3hUj8VQv3idpo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RjHSGXI2Px2E+W7yRXDUa3qrPfXvpK6uJ3ps+UwcFJtQ8FN8adiWtHMWwa7dy5rnBYysvzjC4rSUmuv4a3HruNZ5rp4ByQMaHFPWERo1C3P9t9msQwuPAmzMGrx4hhqRUBl6S3XzE+yZI0veOinwsO2zuEEAGVV8HpYgmd6JCb8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iGlZ27op; arc=pass smtp.client-ip=209.85.160.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iGlZ27op"
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-448b69cfc6dso463247fac.3
        for <selinux@vger.kernel.org>; Fri, 24 Jul 2026 09:07:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784909236; cv=none;
        d=google.com; s=arc-20260327;
        b=mMrd573hQwtQ/P+ZsHWGLwPSb9S+1my7qnd77W8T9Lyp7BbB39h+ow+7jPdXivFXPA
         cdGQauIIeWuLYId0PFkqsSR8WRwGShA0y27KbrBBV1Jh+1OSqdmFxek8XBixF5IFL4Gm
         7j/HoXSfOIzxIors9HcNZO8/OxvSoilFgFXYEIlFphTxwyFc6dOyiqOVgFYcrG0P4fpC
         sVV6zI+I/eEU9asfP9nXsNFzvQsErRjCP8kxLjZxAEq0+sd99wGWenJ7ob4Fz1HHMa0f
         tX91Mubc+DCXyqzciyK7aJ6fpT/Ds2RuxtL3Lm2LnaJVNeV5l39S30AkUMehTEaFm/Hx
         Ulfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=/y0gJAxGJQj12m/paa8kVhuLriyIySR3ifcn30h5gTE=;
        fh=FsXghBnyoYbEc42Idnie0oh5A6i9FUng5ntOLhqXIRs=;
        b=lByTneaQN4LaNqjRcyqWWB6qIkWwTYCAo/8am15Tq7e3DwFM0R42ieHI73fI8MH22g
         TBWP5wy+Q8PI/mD2XEW6aiQ4FeeyhqyBqSHtIkoNpsu/ewiZXtm18ResMKQZff5MRuDy
         wv8mupkwIytrzHv8GS7q+DH93WNHBamv4rb53v6K5pqPc7QwIpt1Y/e0uCQdD/B4wuQF
         RLoFJTlGmwtA0clLo6SKxRQZe7mSmKKlovgZvTvXtdEBXty7pLQ/wEaS5ww83lvFY5BJ
         C52e9m+b1rhwX2M7tvdvCZGwbVT+vaFJINVU+ip9vNYu0hlski1GThpwPPIILX3FQOjP
         Nq2A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784909236; x=1785514036; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=/y0gJAxGJQj12m/paa8kVhuLriyIySR3ifcn30h5gTE=;
        b=iGlZ27opw9Ea1+h74zpWJP8lXV+4OpgRUYbPkbUqzhNzhkiaU85rHm7u4BqLTEGNJP
         5K2EcKExUkvwSzUgf+xyY/ihBpA5fqNGH0ivcFuPGUR6V+mdzDKXH6sFk03lf5hPL5Ah
         h0U+Sf7Hiv37qpCIADzafBfeKYv0P8NLkKf9ALQCByZJqdGcAPsYavZi3XuumK0YdKa9
         AsdalkLmGVWez6fW72jjzI5HbXBzA/Qkj4x2fqeKtog/Dkzd88Kl2/DAAnLu5+Qcbrij
         /0RTxXIEtR71fgE4ddQXMFvrJbvvR4D9Bxmc+lwamO56qpJ3ZPUJTauprRlNk2T/gMjO
         ILcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784909236; x=1785514036;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/y0gJAxGJQj12m/paa8kVhuLriyIySR3ifcn30h5gTE=;
        b=CE6w/M5SIC2QoaBgDqSLT38crNu4oaeA/fNmLAN8fB/AOP08CLVF1JHmOYOCaFtJmu
         bgAb7J3RL6jRJzYAiu1b6sNM+UxD6Tq3y00D9IXPsq+UYk+CmAvNQGH63oc9YradQ2Dq
         sn4DxhAm5Z+HoE89vmlvZNX6jtTtYZGKJqWstDzfPkZmIEFewbqHNm+D7y9EmLmzAJMm
         SUsQKqyMZ2vGHc2ojS6AQnRQYnAvNURQy2KwSilARELtFkeqi/lpU32NniU8YQqWhRGj
         zas/MFuOjPo07Nb5OjbRPfU6NO7+JGAcLrs+GqkrDLCZWI6FoAFQ54jYTNohkdnihsFR
         jrgQ==
X-Gm-Message-State: AOJu0Yx8hvyKjzHAIt8DemiRbALUQCnz7rP0R/7ZOSBTPDNjhOlEPAkx
	GYzAgH7Q4LXrA5ZPhtTJ7Cq+n7CneWCUN9lxB/p0Oizyh1q6Ju5Fb2g0gQVMZXn9erxOsN90x8/
	eTgud5DUxeElNkIj0DoOy1gkbWlPgi13krQ==
X-Gm-Gg: AR+sD13TeevACyjG9mOaVC2IA9gZfmJNFLmvfJq08w4G9YK1yk9HE6VFka3peq7IUHM
	mD+0EkxNFb/nJqygB2sP6exupudVYUEP7NRiSB5vEFjzb/ph1K1WeiwZBDpjpU52oNEXYFsCN8c
	iIbAr9CeHr9e+57JDPvqt3sNkYNTtKGGdHql6Yfdvrp0x4wVcRXy/Q5UWGBcFdAcG3omKrkOdoI
	5H/E+ke8iCgFV1nKatr0HRl7SVat9ZGnOkRIDsdXVGiNo5iGHqri96UXGIpzQ==
X-Received: by 2002:a05:6870:c26f:b0:451:b9ed:5684 with SMTP id
 586e51a60fabf-457a1023312mr4850013fac.34.1784909236486; Fri, 24 Jul 2026
 09:07:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260724150916.48989-1-jwcart2@gmail.com>
In-Reply-To: <20260724150916.48989-1-jwcart2@gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Fri, 24 Jul 2026 12:07:05 -0400
X-Gm-Features: AUfX_myDqHe-Xlv9qdfxxD5Y21WRQtcgUv6HJg5IUS6WMluGzdO_zg1YZp7RuEk
Message-ID: <CAEjxPJ6nvhWaWmXHW4O_kV+dSa0svnki6xh75qW_=9rH+9fLHw@mail.gmail.com>
Subject: Re: [PATCH] libsepol/cil: Fix double free in cil_deny.c
To: James Carter <jwcart2@gmail.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 24, 2026 at 11:09=E2=80=AFAM James Carter <jwcart2@gmail.com> w=
rote:
>
> The function cil_create_attribute_d1_and_not_d2() (let's call this
> f1) mallocs an ebitmap named types. This ebitmap is passed to the
> function cil_create_and_insert_attribute_and_set() (let's call this
> f2) which will create a new typeattribute which has its types field
> point to the types ebitmap passed in by f1. If there is an error in
> getting a symtab or inserting the new attribute into the symtab,
> then cil_destroy_typeattribute() is called during cleanup. This will
> free the ebitmap pointed to by the types field. After f2 exits with
> an error, f1 will perform cleanup and try to free the types ebitmap
> again.
>
> Move the calls to cil_get_symtab() and cil_symtab_insert() to
> earlier in f2 to make it easier to clean up in the case of an error.
> When cleaning up from an error do the cleanup manually instead of
> calling cil_destroy_typeattribute() and do not free the passed in
> types ebitmap. Function f1 needs to call ebitmap_destroy() (which
> is safe to call more than once on a ebitmap) and free the ebitmap.
>
> Also add ebitmap_destroy() calls to
> cil_create_attribute_all_and_not_d() and
> cil_create_attribute_d1_and_d2()
>
> Reported-by: oss-fuzz (issue 500754862)
> Signed-off-by: James Carter <jwcart2@gmail.com>

Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>

> ---
>  libsepol/cil/src/cil_deny.c | 44 ++++++++++++++++++-------------------
>  1 file changed, 22 insertions(+), 22 deletions(-)
>
> diff --git a/libsepol/cil/src/cil_deny.c b/libsepol/cil/src/cil_deny.c
> index c81b8beb..dc0f4ae9 100644
> --- a/libsepol/cil/src/cil_deny.c
> +++ b/libsepol/cil/src/cil_deny.c
> @@ -870,7 +870,6 @@ static int cil_create_and_insert_attribute_and_set(st=
ruct cil_db *db,
>         struct cil_tree_node *attr_node =3D NULL;
>         char *name;
>         struct cil_typeattribute *attr =3D NULL;
> -       struct cil_tree_node *attrset_node =3D NULL;
>         struct cil_typeattributeset *attrset =3D NULL;
>         symtab_t *symtab =3D NULL;
>         int rc =3D SEPOL_ERR;
> @@ -880,12 +879,25 @@ static int cil_create_and_insert_attribute_and_set(=
struct cil_db *db,
>                 goto exit;
>         }
>
> +       rc =3D cil_get_symtab(prev->parent, &symtab, CIL_SYM_TYPES);
> +       if (rc !=3D SEPOL_OK) {
> +               goto exit;
> +       }
> +
> +       cil_typeattribute_init(&attr);
> +       attr_node =3D cil_create_and_insert_node(prev, CIL_TYPEATTRIBUTE,=
 attr);
> +
> +       rc =3D cil_symtab_insert(symtab, name, &attr->datum, attr_node);
> +       if (rc !=3D SEPOL_OK) {
> +               goto exit;
> +       }
> +
>         cil_typeattributeset_init(&attrset);
>         attrset->attr_str =3D name;
>         attrset->str_expr =3D str_expr;
>         attrset->datum_expr =3D datum_expr;
> +       cil_create_and_insert_node(attr_node, CIL_TYPEATTRIBUTESET, attrs=
et);
>
> -       cil_typeattribute_init(&attr);
>         cil_list_init(&attr->expr_list, CIL_TYPE);
>         cil_list_append(attr->expr_list, CIL_LIST, datum_expr);
>         attr->types =3D types;
> @@ -894,20 +906,6 @@ static int cil_create_and_insert_attribute_and_set(s=
truct cil_db *db,
>                              CIL_FALSE :
>                              CIL_TRUE;
>
> -       attr_node =3D cil_create_and_insert_node(prev, CIL_TYPEATTRIBUTE,=
 attr);
> -       attrset_node =3D cil_create_and_insert_node(
> -               attr_node, CIL_TYPEATTRIBUTESET, attrset);
> -
> -       rc =3D cil_get_symtab(prev->parent, &symtab, CIL_SYM_TYPES);
> -       if (rc !=3D SEPOL_OK) {
> -               goto exit;
> -       }
> -
> -       rc =3D cil_symtab_insert(symtab, name, &attr->datum, attr_node);
> -       if (rc !=3D SEPOL_OK) {
> -               goto exit;
> -       }
> -
>         db->num_types_and_attrs++;
>
>         *d =3D &attr->datum;
> @@ -915,15 +913,14 @@ static int cil_create_and_insert_attribute_and_set(=
struct cil_db *db,
>         return SEPOL_OK;
>
>  exit:
> +       if (attr) {
> +               cil_symtab_datum_destroy(&attr->datum);
> +               free(attr);
> +       }
>         if (attr_node) {
> -               cil_destroy_typeattribute(
> -                       attr_node->data); // This will not destroy datum_=
expr
> +               prev->next =3D attr_node->next;
>                 free(attr_node);
>         }
> -       if (attrset_node) {
> -               prev->next =3D attrset_node->next;
> -               free(attrset_node);
> -       }
>         return rc;
>  }
>
> @@ -1038,6 +1035,7 @@ static int cil_create_attribute_all_and_not_d(struc=
t cil_db *db,
>  exit:
>         cil_list_destroy(&str_expr, CIL_FALSE);
>         cil_list_destroy(&datum_expr, CIL_FALSE);
> +       ebitmap_destroy(types);
>         free(types);
>         return rc;
>  }
> @@ -1103,6 +1101,7 @@ static int cil_create_attribute_d1_and_not_d2(struc=
t cil_db *db,
>  exit:
>         cil_list_destroy(&str_expr, CIL_FALSE);
>         cil_list_destroy(&datum_expr, CIL_FALSE);
> +       ebitmap_destroy(types);
>         free(types);
>         return rc;
>  }
> @@ -1168,6 +1167,7 @@ static int cil_create_attribute_d1_and_d2(struct ci=
l_db *db,
>  exit:
>         cil_list_destroy(&str_expr, CIL_FALSE);
>         cil_list_destroy(&datum_expr, CIL_FALSE);
> +       ebitmap_destroy(types);
>         free(types);
>         return rc;
>  }
> --
> 2.55.0
>
