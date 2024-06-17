Received: from mail-ua1-f48.google.com (mail-ua1-f48.google.com [209.85.222.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0360C18EFF9
	for <selinux@vger.kernel.org>; Mon, 17 Jun 2024 17:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718646963; cv=none; b=nHQ/pCwDyPf1Sm56I78pjhJV2EdZh7duj4sDc/s2HO0M9gVwBN+mYezY6Zv4/vacAdgsfvxjnVigjWxUrgmyoC8gnLEfCoRy2Nv2uesLQkmZ3NRbOrAulvBYienGqUypNldvfOuWaUUTRUFn8u9e8VHFy7Au/8FDfJXTVBsDgtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718646963; c=relaxed/simple;
	bh=9evwrKh3x+H0cwjpuBO6UWqK4hOkCnWhGGOlEYRNkvs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aT14KbjTpgzPCtrsoXUqcI6xcnEXE5F51HKGd8ZEUgMc0MLaD97XpuygwxIj9zwzy7naM2laZ/Kaqhnr6l0YMhCteoSdsdxjgigEGbCSB3dkarvgE4+JN02IdWuEYK4IIGbEUrI4iJWnxMJUu4fU7A50iglLO/9YrEF8fsgMcas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YT1sE6J5; arc=none smtp.client-ip=209.85.222.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YT1sE6J5"
Received: by mail-ua1-f48.google.com with SMTP id a1e0cc1a2514c-80b8a8b06b9so1147428241.2
        for <selinux@vger.kernel.org>; Mon, 17 Jun 2024 10:56:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718646961; x=1719251761; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NDhlQtlIXK9OtaOYqkmlCdHbzbcSa6AlfXqMT/6O4EA=;
        b=YT1sE6J5RJ0s0540VgamNJFFH6DuWjph5DSLXNY9g9EO0qEmgKIwIalB5e3rG9hkNb
         TCCoTexU5G/1FG5dJqYom/THjNI8fqLOCkzwONToUPqLkbYiHmfqvGAES72o2in3iXPh
         pMtHaLCBubshX9JTY1R/bYkbU9xJCF8/k5ojXywNTzlve2SDu77GCSki78T9qhqMy62w
         9bcRN0dkUFCmugxu7ZJSv42NICXzJijEk99iuFmIdmPg4khCIxw6P0Bjc7OZMRaoSk2M
         OZ8KFjwpBZ9bA8eGitHkbIunA4Hdg1D+9pGyjmGlVAeMeSHoxKOAcA6yVpchmGnlNwWa
         yYJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718646961; x=1719251761;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NDhlQtlIXK9OtaOYqkmlCdHbzbcSa6AlfXqMT/6O4EA=;
        b=Jgo+dFIqfMbxT5Z3WdEDrRWkRwLcZUmoMzn3Q/LxMfWwuWaNVz9TUHam1fBSjq22jW
         44Y0PPuBAvAYONJfoQkDbjKMoHCWS0Fsop5HC2F49WcB/xXcM9Xa1zhRC77h3nSGnckR
         zOtuczrrJllmmEbujyDvO1Btv7bFJRmJn1u1jx1uW+VqlgqMj67xUUw+laaypZuo8jc1
         5R71b13FZnJaAuHke/rk039RMHMFCsb5Mq8c79uCyRgIPL6IDoJSbHFFgHvyDyiZL1cv
         wROCmPtObdDLoQuSs3+srLVXuYWgrkOzPPkVKF8JZ6uC1wQJREUekh57jw2totvPQEZc
         rzsw==
X-Gm-Message-State: AOJu0Ywpj3APTo9V3AY4LePG8sQ5RQZpczz0QfKl61DS50fBJwJu9JQI
	INynl47UeXSrQEa9dSGsk2e+zhNo2IHnSpGChmDAOIEzuvB4AZmw9bCHGevGD8W5ufIEUUb4Zva
	8btM1K933Q8ayCWbL8O1wnlBeg7w=
X-Google-Smtp-Source: AGHT+IHXReqi1uNlasOUXHKSBttYkQgG4X1vExUrHkqfj2C1av9gOT4PF4faozsRPIIwJ/Y0QsY4iZWkMi4sZMCsRvw=
X-Received: by 2002:a05:6102:22f0:b0:48c:377b:11d with SMTP id
 ada2fe7eead31-48dae3ceb9dmr9401532137.22.1718646960824; Mon, 17 Jun 2024
 10:56:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240615132525.36358-1-cgoettsche@seltendoof.de>
In-Reply-To: <20240615132525.36358-1-cgoettsche@seltendoof.de>
From: James Carter <jwcart2@gmail.com>
Date: Mon, 17 Jun 2024 13:55:49 -0400
Message-ID: <CAP+JOzQcApAE4xmcYSeGcmxUVhuPmF9sn12zARY+J3JCqN+5gQ@mail.gmail.com>
Subject: Re: [PATCH] libsepol: check scope permissions refer to valid class
To: cgzones@googlemail.com
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jun 15, 2024 at 9:25=E2=80=AFAM Christian G=C3=B6ttsche
<cgoettsche@seltendoof.de> wrote:
>
> From: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>
> Validate that the permission maps in the scope index refer to a valid
> class datum.  Otherwise since commit 52e5c306 ("libsepol: move unchanged
> data out of loop") this can lead to a NULL dereference in the class
> existence check during linking.
>
> Reported-by: oss-fuzz (issue 69655)
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>

Acked-by: James Carter <jwcart2@gmail.com>

> ---
>  libsepol/src/policydb_validate.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/libsepol/src/policydb_validate.c b/libsepol/src/policydb_val=
idate.c
> index 9746f562..0216410c 100644
> --- a/libsepol/src/policydb_validate.c
> +++ b/libsepol/src/policydb_validate.c
> @@ -1467,6 +1467,8 @@ bad:
>
>  static int validate_scope_index(sepol_handle_t *handle, const scope_inde=
x_t *scope_index, validate_t flavors[])
>  {
> +       uint32_t i;
> +
>         if (!ebitmap_is_empty(&scope_index->scope[SYM_COMMONS]))
>                 goto bad;
>         if (validate_ebitmap(&scope_index->p_classes_scope, &flavors[SYM_=
CLASSES]))
> @@ -1483,8 +1485,10 @@ static int validate_scope_index(sepol_handle_t *ha=
ndle, const scope_index_t *sco
>                 goto bad;
>         if (validate_ebitmap(&scope_index->p_cat_scope, &flavors[SYM_CATS=
]))
>                 goto bad;
> -       if (scope_index->class_perms_len > flavors[SYM_CLASSES].nprim)
> -               goto bad;
> +
> +       for (i =3D 0; i < scope_index->class_perms_len; i++)
> +               if (validate_value(i + 1, &flavors[SYM_CLASSES]))
> +                       goto bad;
>
>         return 0;
>
> --
> 2.45.1
>
>
