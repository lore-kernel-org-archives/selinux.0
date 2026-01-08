Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10D0528000C
	for <selinux@vger.kernel.org>; Thu,  8 Jan 2026 17:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767891861; cv=none; b=WS2KIk+0amFC6ji6dM3xfwpFZr0qEPxwUE33hg+NguswHpQV8KVnIxcGEF18RNEvXa+EzIIO9gFWY0kr0wwfvoAvdXsx0vq/U1Zz9alJhfBLS8egKrb1ifz+8sz8PehRFa89RpRZR2g1DHH/yhMUNaWoVITgaISBCkExHKG0wOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767891861; c=relaxed/simple;
	bh=GqwRq0bBNZoAXb2Y+9L1c52AXsEfCPA9ieYkFzYHjwI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=AweOLdmflh7oFLncn877jxOn9M9iNeY5CgymXgIjOea9Jh5R+UJQAEkr7bDnvQtVzi2zRHrt4JSIAD+0nv2XLs3Aaim1ruBNMKTVkECYn7w3FKNT/32lWlyf/LBg8XUrH526ON1BiVxOAM5ez8KHgDrxdhmeehNNDtxMV/1fxJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QHTOXU8Z; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QHTOXU8Z"
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-59b786b2a5dso1089156e87.3
        for <selinux@vger.kernel.org>; Thu, 08 Jan 2026 09:04:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767891858; x=1768496658; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vf+mB0fkkfiL08Ohc5bEdk6oMrEN0vVAxWAxzlpLlFA=;
        b=QHTOXU8ZXpf36vEkDqb1j3ypJs/Z/Da4ybli6haWRJNyXfcITCpEKsQG8nTktLJjyj
         scGiQZCyskxBApv/Kkw1CKtgCalI6QgG4Iye48uXcHPtknTAsB1YlCo1trjVLsSF6ImS
         Q9DJm18fKkYX3oXLZPg39rNyN1kzxm5W1zKPEcWq1/a+tLAD1M4FttkatKg9QfZE/5MS
         pntG6gdvHWwqtnsSzw/pYI/psB01r2ZYxZqUP0tFM7CQbnnX1xEsf65YQ7hbcKOw+mFj
         msXIpwZTFsNIU7v8qnVwDjndkN35w2O5RgCJ4TQkCYlOUg/ADkLBoVJrk0qqXaNxEnis
         2jUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767891858; x=1768496658;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vf+mB0fkkfiL08Ohc5bEdk6oMrEN0vVAxWAxzlpLlFA=;
        b=UrweoZKFcAMzjuP3iN4O1WYDS+chTttYDTo/b98X9WVpWWZF9Q+DTlFbXwuxo0S5bs
         NP07yTKjR/xvx50+H07JvDlzWNCW92/lELV8eqp4hsw+55R0aQZ/2r7jMMTy+6tJCnRY
         XlOHbZFq5lE7LpFEt7JBNl6Cf27BL0sdc+/U5e5iPKbvJE/kO5iAB9LKhbM0N1xVYWMv
         jrnuSzWZPdv3CpMHUnMTe7c/lc2jN5mIDkboMBzg79buqezvWfgkFLXJgFbf1xzCV1oE
         uzVuSyxUOEW6kyHB9Gk1wNlwnBVLTSf6Lr5WAVKDgcC+UaZqzcE0qAd9izuW2GFUikqn
         dSAw==
X-Gm-Message-State: AOJu0YxjofaSLDGOzotcQirgfOZnP1ngr4wpX7ICwXIwrg/CTV+QecMR
	KBoUI6fG8PAeEYwvtnKkXKzsD4GbP64pJJrPV5q1S9pqTSj1rfAMSAoEj5UUqfQrEPB6n3ZWe6h
	60rAyDf19/vIWsa0pmKjm6tFS1l+QJVYoRg==
X-Gm-Gg: AY/fxX5gv9iYqvjhOEX+6yXq+qAetLvmv9ToW+eXcdte9NdMxfrwkrnnfMtaL5boFcI
	gKJCuH3zQQiBwNSvDHy7AC2Ry0PFuG06rmT+IQqp3ftMOtlYrnI+CFnalXKsGjiI74bqcIXNXZ0
	we6nOCGatF/vTAwXWYrHLG6fbZR3BVPrKXmxD1unV8o4vuVR+q3ggbd9mdknMCpII+aqrx6ZBKj
	wyt1MBhroCgGKrj8JF0jTmjzGaIfuDSLs54Go0VQdizw/YiLQ+xGFa7NbWUatZVZdnp
X-Google-Smtp-Source: AGHT+IEivcao/5c+saX/XKOiGSUuFBbpQ3zIzsqvvRNUu3sZKUCu1YueLKmv6Lx+D7I3LFUXs4YtJ2NDjEYK3UtYqb0=
X-Received: by 2002:a05:6512:3da9:b0:598:efb0:b81b with SMTP id
 2adb3069b0e04-59b6ef0903amr2357501e87.14.1767891857924; Thu, 08 Jan 2026
 09:04:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251217174914.189853-1-jwcart2@gmail.com>
In-Reply-To: <20251217174914.189853-1-jwcart2@gmail.com>
From: James Carter <jwcart2@gmail.com>
Date: Thu, 8 Jan 2026 12:04:06 -0500
X-Gm-Features: AQt7F2rs8KJwXahxMucqewIx7TAo1pHSyTe-CY_6puMmhV2hz94zwabGgadPuDc
Message-ID: <CAP+JOzR18KnQWRYJYyKbhMY5JSAXZcy8RFSVUGEaDm0SvKvS5A@mail.gmail.com>
Subject: Re: [PATCH] libsepol: Fix expand_role_attributes_in_attributes()
To: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 17, 2025 at 12:49=E2=80=AFPM James Carter <jwcart2@gmail.com> w=
rote:
>
> Fix potential NULL dereference when there are gaps in the roles in
> the role_val_to_struct array.
>
> Remove debugging messages and provide a better error message.
>
> Checking "!done" is clearer than checking "reps < p->p_roles.nprim"
> for determining that there was a problem expanding role attributes.
>
> Signed-off-by: James Carter <jwcart2@gmail.com>

This patch has been merged.
Jim

> ---
>  libsepol/src/expand.c | 19 +++++++++----------
>  1 file changed, 9 insertions(+), 10 deletions(-)
>
> diff --git a/libsepol/src/expand.c b/libsepol/src/expand.c
> index 04b5e5e4..74f03c87 100644
> --- a/libsepol/src/expand.c
> +++ b/libsepol/src/expand.c
> @@ -875,7 +875,7 @@ static int expand_role_attributes_in_attributes(sepol=
_handle_t *handle, policydb
>         ebitmap_init(&attrs);
>         for (i=3D0; i < p->p_roles.nprim; i++) {
>                 rd =3D p->role_val_to_struct[i];
> -               if (rd->flavor =3D=3D ROLE_ATTRIB) {
> +               if (rd && rd->flavor =3D=3D ROLE_ATTRIB) {
>                         ebitmap_set_bit(&attrs, i, 1);
>                 }
>         }
> @@ -887,9 +887,6 @@ static int expand_role_attributes_in_attributes(sepol=
_handle_t *handle, policydb
>                         rd =3D p->role_val_to_struct[i];
>                         if (ebitmap_match_any(&rd->roles, &attrs)) {
>                                 done =3D 0;
> -                               if (ebitmap_get_bit(&rd->roles, i)) {
> -                                       ERR(handle, "Before: attr has own=
 bit set: %d\n", i);
> -                               }
>                                 ebitmap_init(&roles);
>                                 ebitmap_for_each_positive_bit(&rd->roles,=
 nj, j) {
>                                         if (ebitmap_get_bit(&attrs, j)) {
> @@ -901,19 +898,21 @@ static int expand_role_attributes_in_attributes(sep=
ol_handle_t *handle, policydb
>                                 ebitmap_union(&rd->roles, &roles);
>                                 ebitmap_destroy(&roles);
>                                 if (ebitmap_get_bit(&rd->roles, i)) {
> -                                       ERR(handle, "After: attr has own =
bit set: %d\n", i);
> -                                       done =3D 1; /* Just end early */
> +                                       ERR(handle, "Found loop in role a=
ttributes involving: %s", p->p_role_val_to_name[i]);
> +                                       ebitmap_destroy(&attrs);
> +                                       return -1;
>                                 }
>                         }
>                 }
>         }
>
> -       if (reps >=3D p->p_roles.nprim) {
> -               ERR(handle, "Had to bail: reps =3D %u\n", reps);
> -       }
> -
>         ebitmap_destroy(&attrs);
>
> +       if (!done) {
> +               ERR(handle, "Failed to expand role attributes");
> +               return -1;
> +       }
> +
>         return 0;
>  }
>
> --
> 2.50.0
>
