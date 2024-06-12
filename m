Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E708317FAA4
	for <selinux@vger.kernel.org>; Wed, 12 Jun 2024 15:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718206401; cv=none; b=W4rCLiocLxsZDeVBtpz/KVPwDgWik7jg+tnOCdRedCAIAW0uIk1Vp5gtSWsfRy9QlwB2Hyow95Su+m8oncCpKF7bCJ3v7dFJTXIKE4/3c/0CVXTKIoMR8gAmnWrLqoTTyASzNMxB/HdREzZTGO6VK1K9ExSqIORmowhrwoiZxoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718206401; c=relaxed/simple;
	bh=NSTfAavLJUL4Plzeg621vjxpnvyZbHa81rlw2p0j2uc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=h5WJ0cBg2d6cSSapS84RO8CKCqAgSOl8PPWKPZa7MuXs7xK2WDhYuTg9Li75EQQGB73Wc3QtkeMvKsR0TcaNo5mb29XDBJTfzU+5Nac60cnLKTYlDvrdQ3JyOcewOHWTE5SblGqzF6jsq6DKPTmPM2z1nIzBItJE3672HwMONkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EnOevVHE; arc=none smtp.client-ip=209.85.210.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EnOevVHE"
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-6f9603730d5so2760546a34.1
        for <selinux@vger.kernel.org>; Wed, 12 Jun 2024 08:33:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718206399; x=1718811199; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zm0YWcnjvs0g0rzDL8n62kgDNBYkXJ1uqbeDilV9qZM=;
        b=EnOevVHEFQEiF5aDxBCJVudOStrSs+i/1URzPRlt3hdLYTbmarcatsFBJkURPu6osf
         P9kJvkJ8fmVUgs+N1SmVZdydpsZtkvuvcOpzbY6LpRj/BImW4GY/frx30pIxG+gwtIG5
         47GrMK6IN0PCizzZjaw55lEpXC4UagUSctAgqR/nDbHeiasWQSFrC5tAZhSlUPySMB4i
         SVmNiWKyL9M5Srl+wlNL3TOi2rJFb+OaTXQggUfr+sf3bT9Cf/SUCYHH9NBaOQ0msnLZ
         wzwVQOtl2pa+CaGBrm/kL0kHyI+LV47Vjzx/OQTlhAvS93jRUNDlGHayemoQx1azzGd4
         471A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718206399; x=1718811199;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zm0YWcnjvs0g0rzDL8n62kgDNBYkXJ1uqbeDilV9qZM=;
        b=oz6t7bdjzFZjmz1ohXbwkwGg3rK2Id4uRd9IcSFd2+6qp5tQZ79XLv9vUWT5BhpD/d
         xeDTX9jV0liK6zoxN9DvQANTJKMY5L1bxJbwFfoviXzV6foIytja8njDX3OPDlyNPKLT
         JknabGgPiKHn5j2nV5dr6PIXCKTfRl7L8hia6tr5XwScMz3bS7M9q9Vxhx6q7uGU7v+W
         bHHAEFLb0eGZowXqWi9cwsoiWEIKzMEizrBULG/34ksJ5qtcbpWqecCfFd5/RayBjgta
         +n7ALLCJSJaYTQPKqlQbAKIzRHnAqmB0kGF62VIzBhpWGznXkaOdT2vjejINx7ZgFAnO
         +zZA==
X-Gm-Message-State: AOJu0YwIb/LC2hjVou9P5IhGS5XqpDZCKjEJgbDtLwDvrS/Gqlyba6p6
	vxF/+T36Le/AcukfnvI7itQ8LRLjrJxpQEr+3LmNeZHHJO9qG2gehRLG22jns96TytgXwVSw+Ig
	RTQJwhsfxhj/5QwaiQyjfudd/wldNogkr
X-Google-Smtp-Source: AGHT+IFABntZu3lCNQo1/VaYrn3WaKohfw5j6kdMLU0evWbB0vQ6kE+2sPZ7cVx3vLTf96bfhp8O4gMnM4q4gUfo4UM=
X-Received: by 2002:a05:6808:2e93:b0:3d2:1ed4:78b2 with SMTP id
 5614622812f47-3d23e11f42cmr3204484b6e.55.1718206398878; Wed, 12 Jun 2024
 08:33:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240608171838.136163-1-cgoettsche@seltendoof.de>
In-Reply-To: <20240608171838.136163-1-cgoettsche@seltendoof.de>
From: James Carter <jwcart2@gmail.com>
Date: Wed, 12 Jun 2024 11:33:07 -0400
Message-ID: <CAP+JOzQVALz=Mqk3+YND3bcKtNMCMt3Hmg7GfiGU378+xsDaiQ@mail.gmail.com>
Subject: Re: [PATCH] libsepol: validate attribute-type maps
To: cgzones@googlemail.com
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jun 8, 2024 at 1:18=E2=80=AFPM Christian G=C3=B6ttsche
<cgoettsche@seltendoof.de> wrote:
>
> From: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>
> Ensure the attribute-to-type maps contain no invalid entries, required
> for generating typeattributeset statements when converting to CIL.
>
> Reported-by: oss-fuzz (issue 69283)
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>

Acked-by: James Carter <jwcart2@gmail.com>

> ---
>  libsepol/src/policydb_validate.c | 23 +++++++++++++++++++++++
>  1 file changed, 23 insertions(+)
>
> diff --git a/libsepol/src/policydb_validate.c b/libsepol/src/policydb_val=
idate.c
> index 84c1071c..9746f562 100644
> --- a/libsepol/src/policydb_validate.c
> +++ b/libsepol/src/policydb_validate.c
> @@ -1654,6 +1654,26 @@ bad:
>         return -1;
>  }
>
> +static int validate_attrtype_map(sepol_handle_t *handle, const policydb_=
t *p, validate_t flavors[])
> +{
> +       const ebitmap_t *maps =3D p->attr_type_map;
> +       uint32_t i;
> +
> +       if (p->policy_type =3D=3D POLICY_KERN) {
> +               for (i =3D 0; i < p->p_types.nprim; i++) {
> +                       if (validate_ebitmap(&maps[i], &flavors[SYM_TYPES=
]))
> +                               goto bad;
> +               }
> +       } else if (maps)
> +               goto bad;
> +
> +       return 0;
> +
> +bad:
> +       ERR(handle, "Invalid attr type map");
> +       return -1;
> +}
> +
>  static int validate_properties(sepol_handle_t *handle, const policydb_t =
*p)
>  {
>         switch (p->policy_type) {
> @@ -1790,6 +1810,9 @@ int policydb_validate(sepol_handle_t *handle, const=
 policydb_t *p)
>         if (validate_typeattr_map(handle, p, flavors))
>                 goto bad;
>
> +       if (validate_attrtype_map(handle, p, flavors))
> +               goto bad;
> +
>         validate_array_destroy(flavors);
>
>         return 0;
> --
> 2.45.1
>
>
