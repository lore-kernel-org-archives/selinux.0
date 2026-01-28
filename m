Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E30C2517AC
	for <selinux@vger.kernel.org>; Wed, 28 Jan 2026 20:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769632156; cv=pass; b=r6kQMbnzTECbsWZ+6wi01GOyaFctBm4lGGYBRJf7ptPKS0bFidofLLQvoxjp5aXRzUIJiWaOPxnfffZEa0vFxxPmjiVrO/5MH+awWL/2mkxB58omhBi08zBmArBiRqt07SqjIjjDU58wjV5ir1TsermV1+LaP8wazSidx/sVWOM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769632156; c=relaxed/simple;
	bh=1LfVX3m/LJuSLqMko1w+IAVd8iAuzgqBfAK3t0q/STQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=uBKyflBKxIccXzp/+r8uQI6wZBjYZ/4oVtLdPaWuH+BQTBAOkDzviJDprBKD+rtFy77A1Vz984rVzL6IzONHl8T+SUihmTLNTK5PT/PglHdHsX80NOkWKymfjt4uFcXkaYBRibDnRl6KQNK10hSai8fGQsC6yTK3q3L/7AfnW8E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YJzZdWJW; arc=pass smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YJzZdWJW"
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-38320cd563aso2829811fa.0
        for <selinux@vger.kernel.org>; Wed, 28 Jan 2026 12:29:15 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769632153; cv=none;
        d=google.com; s=arc-20240605;
        b=WXryFEvr+mUaU+pMqIytk5HK/ZQUfqr8Fv/lvC/LY+RtTeZhRUw5iUMKeqpLbHY8SA
         w4PJdyvjdOSnzywPOUXFM4LoOqZ2plEQ4n3yYvewMyy7l5ZUb0Zodjm7DIdHyzxdMvgo
         hIv0yiqHzNiTLaGfUW/rH8GWW5g/X2ZT3imCns7vPIxNYLucbXfEf+jHOZqo1s7/sHa5
         IENaiT6CnmoXGCedm1wWv9WJzrXguBsmNBvARnqtbiLYqcg0JB1ppRCpVNqgOckak0tW
         8dcVulTgps8WLiJ46wN5saQpg7l4galpasVpZOEy5u66Mdlni32+WYxzORfuHwrB9G8T
         QeKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=RuZ1I9QOGghIcrEPZqdsmRPXIXdw0NCxwxo7qCevNIQ=;
        fh=l2l+BKIhep14i9a5yxIzwDvgNRHYkyJlbYDDp8LiW6o=;
        b=Ug8A+IF+PRL6vH8H4+GmbA4nto4imFs+PsSAmsa4vMjQ//XUqqpKX+3oHcDEb2OLGH
         9GMg8nmjBPwmbdRL7vOSMlaROPBhxhUiBzQ58hOeegu0wXAKJ1D4DrJQMhaFovwPMNW9
         TfM5rNvFKJDKhwpUcUeRG32vgQ7v0toRUM2F3aCRW3eEZ7JRqOcttAG0bolcf6oOZ5yX
         fAcqZi2vrLssDX5r1GiP7/bLpqt8iBgYn7Q3qAw9mpaGAvuoHnA3hDSiB0zScsIb+IQy
         al40BINrEJNVpZHh/O+H0nPaaglODgbk8l4JKT18S6LzAzIUVnPVpb4Lb+wYwfawFOCi
         5ODg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769632153; x=1770236953; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RuZ1I9QOGghIcrEPZqdsmRPXIXdw0NCxwxo7qCevNIQ=;
        b=YJzZdWJWgz1GvG3gmIGsKLEpmldJQaeaDuQw7LFodUrBw5Z6W7wHgkZl5v/m6QUJEt
         JgW+uciv6GKoThPBtkNsEGU6z8ry6fCALna8jHns5uf3+kZhZEQV9hX/f7hpS16QJBxe
         8laB80Y9RjEZemknB6BotWwptL7JugM3TVLuZSgrpMs0jvbpr8h2XU6jJpysNTMcBo+3
         oTOIO7D9o3/p4NcYU24qlWuf71U/OuiukGSKIEiE2X8n1fTAIz3UdpmyY4YrWHB0lO8O
         zMsI3EOXofxqokwAiQ5Aja6nVrOfiCRzLqHuKxqjBqIzPrBn0SsTXXstIbfzuQr6DoRS
         dsVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769632153; x=1770236953;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=RuZ1I9QOGghIcrEPZqdsmRPXIXdw0NCxwxo7qCevNIQ=;
        b=YhZJSkpuflwHXZH1jYdG9N+R6G7lD7AVpL1V28Z7wnGWSzwMhqbQdFOVrd7rzNXK+C
         2PCV9Jjq831UVusUBXbWqmv+Py4XdqS3CuRE5HWyolqFF6Z/vyzwIKkl7QBMO+IiaQyQ
         KuauSfzBIQXUYij9b0EpabADCHIgQh0oKdkd9FU93V0+BWE3dTSjpc2io3cY9JcCIaz8
         qIvqASPPRaYvbI2i0sid1sx6ZmK1UezfMucACdBLoaqKQlFYMo/HCnbtSYoggfLBr0pc
         HXl4ue8sfD2N3Heux/GSL0nwCunTyb8ma+saRo2uxs03a81oqzOKsEed9GNwvay2FqPF
         pRYw==
X-Gm-Message-State: AOJu0Yx85o7FK04/PdW89/g9V2IhT604Mbg4V1PsdUmzs3mht/nlGIxn
	9WrYxe3SKwFzam+7h4cAR4WIuj9WgPp4t1F8IrfyBGOWEflACg3ZlZ4ozq9dI2vxA6ZyrNVwPOx
	a6q6xbiaWuUTiqFw7GLrlMGc1dwmN147n4w==
X-Gm-Gg: AZuq6aI5MC/7dJFkBM+JNL5D/Q5b8GKg26+yUHfvtUc/qY6VLfa++nxAmVKcSlx29xh
	Rdt3gRJ7BHM9TzWi8edMVDJ8r3eyGXKbweSvHchSnCHFMgkdqyPipKjESiFoCD7BDa0RM+AYsEl
	8f52DJKCU9BDpcM9a/Tifi6D+4d/z5ElY08ZblIpZ6674hyHcGlp+6I0pBwyHKmZXcb30dPOBoQ
	/AOQZ0Znt+8XqPgv2lOm5HYHrPgS64F088Y9UPqG7L/O+I4kE+5iH7igHO814Knk4OC
X-Received: by 2002:a05:651c:f19:b0:383:b9d9:3fdd with SMTP id
 38308e7fff4ca-3861c913590mr25438471fa.34.1769632153260; Wed, 28 Jan 2026
 12:29:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260112184928.58593-1-jwcart2@gmail.com>
In-Reply-To: <20260112184928.58593-1-jwcart2@gmail.com>
From: James Carter <jwcart2@gmail.com>
Date: Wed, 28 Jan 2026 15:29:02 -0500
X-Gm-Features: AZwV_QjLQiUBkrxgetmbruDSkalfg0slgVYrvTVINVFYx-DLXSk2Xrtk0lKQe0g
Message-ID: <CAP+JOzS6O7x-yJamCBcqnqWrfD1XdmAGk64fh0Ko-9+1WiHweg@mail.gmail.com>
Subject: Re: [PATCH] libsepol: Fix possible use-after-free when expanding attributes
To: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 12, 2026 at 1:49=E2=80=AFPM James Carter <jwcart2@gmail.com> wr=
ote:
>
> Both expand_attributes_in_attributes() and
> expand_role_attritbutes_in_attributes() have a potential use-after-
> free bug. The function ebitmap_set_bit(), when used to clear a bit
> will free an ebitmap node if no other bits are set on that node.
> This can result in a use-after-free in
> ebitmap_for_each_positive_bit() which keeps a pointer to the current
> node.
>
> Instead, use a temporary ebitmap and update the types or roles after
> the loop is done. Also move the check for a loop earlier to avoid
> uneccessary work.
>
> Reported-by: oss-fuzz (issue 474561491)
> Signed-off-by: James Carter <jwcart2@gmail.com>

This patch has been merged.
Jim

> ---
>  libsepol/src/expand.c | 37 +++++++++++++++++++++----------------
>  1 file changed, 21 insertions(+), 16 deletions(-)
>
> diff --git a/libsepol/src/expand.c b/libsepol/src/expand.c
> index 6e0c038e..ed912b57 100644
> --- a/libsepol/src/expand.c
> +++ b/libsepol/src/expand.c
> @@ -245,19 +245,22 @@ static int expand_attributes_in_attributes(sepol_ha=
ndle_t *handle, policydb_t *p
>                                 done =3D 0;
>                                 ebitmap_init(&types);
>                                 ebitmap_for_each_positive_bit(&td->types,=
 nj, j) {
> +                                       if (i =3D=3D j) {
> +                                               ERR(handle, "Found loop i=
n type attributes involving: %s", p->p_type_val_to_name[i]);
> +                                               ebitmap_destroy(&attrs);
> +                                               ebitmap_destroy(&types);
> +                                               return -1;
> +                                       }
>                                         if (ebitmap_get_bit(&attrs, j)) {
>                                                 ad =3D p->type_val_to_str=
uct[j];
>                                                 ebitmap_union(&types, &ad=
->types);
> -                                               ebitmap_set_bit(&td->type=
s, j, 0);
> +                                       } else {
> +                                               ebitmap_set_bit(&types, j=
, 1);
>                                         }
>                                 }
> -                               ebitmap_union(&td->types, &types);
> +                               ebitmap_destroy(&td->types);
> +                               ebitmap_cpy(&td->types, &types);
>                                 ebitmap_destroy(&types);
> -                               if (ebitmap_get_bit(&td->types, i)) {
> -                                       ERR(handle, "Found loop in type a=
ttributes involving: %s", p->p_type_val_to_name[i]);
> -                                       ebitmap_destroy(&attrs);
> -                                       return -1;
> -                               }
>                         }
>                 }
>         }
> @@ -925,9 +928,8 @@ static int expand_role_attributes_in_attributes(sepol=
_handle_t *handle, policydb
>         ebitmap_init(&attrs);
>         for (i=3D0; i < p->p_roles.nprim; i++) {
>                 rd =3D p->role_val_to_struct[i];
> -               if (rd && rd->flavor =3D=3D ROLE_ATTRIB) {
> +               if (rd && rd->flavor =3D=3D ROLE_ATTRIB)
>                         ebitmap_set_bit(&attrs, i, 1);
> -               }
>         }
>
>         while (!done && reps < p->p_roles.nprim) {
> @@ -939,19 +941,22 @@ static int expand_role_attributes_in_attributes(sep=
ol_handle_t *handle, policydb
>                                 done =3D 0;
>                                 ebitmap_init(&roles);
>                                 ebitmap_for_each_positive_bit(&rd->roles,=
 nj, j) {
> +                                       if (i =3D=3D j) {
> +                                               ERR(handle, "Found loop i=
n role attributes involving: %s", p->p_role_val_to_name[i]);
> +                                               ebitmap_destroy(&attrs);
> +                                               ebitmap_destroy(&roles);
> +                                               return -1;
> +                                       }
>                                         if (ebitmap_get_bit(&attrs, j)) {
>                                                 ad =3D p->role_val_to_str=
uct[j];
>                                                 ebitmap_union(&roles, &ad=
->roles);
> -                                               ebitmap_set_bit(&rd->role=
s, j, 0);
> +                                       } else {
> +                                               ebitmap_set_bit(&roles, j=
, 1);
>                                         }
>                                 }
> -                               ebitmap_union(&rd->roles, &roles);
> +                               ebitmap_destroy(&rd->roles);
> +                               ebitmap_cpy(&rd->roles, &roles);
>                                 ebitmap_destroy(&roles);
> -                               if (ebitmap_get_bit(&rd->roles, i)) {
> -                                       ERR(handle, "Found loop in role a=
ttributes involving: %s", p->p_role_val_to_name[i]);
> -                                       ebitmap_destroy(&attrs);
> -                                       return -1;
> -                               }
>                         }
>                 }
>         }
> --
> 2.50.0
>
