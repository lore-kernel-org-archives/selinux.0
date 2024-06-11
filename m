Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 985034315B
	for <selinux@vger.kernel.org>; Tue, 11 Jun 2024 17:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718125990; cv=none; b=rmhwgtS7khXNfIW2WEM5iCAn/uUq+szbvIzOOzHRBRtkYdIZNQ6pcnB1OgKxciHpq19glEbqRC8Vl0znfsl+yodmQuJu49+fXFLiBfit4uHOd2OwCeHptPWhRDCeGOfqMGbyE0qeTKFRRSw5LJ9QY1ocjxDXzyuiZCGdHE7i06Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718125990; c=relaxed/simple;
	bh=FLLL/i8E2UXzLr12JBZYcLTpB/iMpWxvltq6cSZ9SHo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rHp2CSCfOS9i992GCMsS8SLHUDdt6t/ZiWP5GErXtrZ7CRllcX3yDQZ5EfQOZemhJ326Tp7Pbp9mkOBWsGusrz1TZXBCxgxZcPaiK/o+15Hp+CTqoLW5FVqgLPjarADe/qB24+X1OEDVDHDzNwgDHkGsZblIXTCIIf1p2IKptnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ezF6JDZH; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ezF6JDZH"
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-4405fb741ccso373491cf.1
        for <selinux@vger.kernel.org>; Tue, 11 Jun 2024 10:13:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718125987; x=1718730787; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Hjf23uHllzVqVdtUKTr+ruuGq1i83PYwuKbaCDWmT4o=;
        b=ezF6JDZHuw0FlB+sRcjxZZTnajtuuOo7vryUNhWtgBp1eaYm6uS28Xgwkt6VLXOoeS
         cgMs3gJNNS54kdvhs02GhlfzAPTmCrwhwnNm/JHn4UPtf0fQgPux7Dcb63NMyHe34bm5
         lLZxwy8PqFZ03hj7w+sZw+yTg64/MHshTgt0b6EVBBpbx44W8j7RPfdQWgGYY7P7ax7e
         s0k/AdHw4PkOrqXCRWtwVpTN3eHEVUP61sF7Gx4wV54+MA/HH+QMCZX8MfOBh0mGbqj2
         3RivnhxEXdmqdDYwfldzIkcay//ovno1MQ9GDTAaX6RMty8zlRHCZw0qPDtRhA01pxD0
         +WSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718125987; x=1718730787;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Hjf23uHllzVqVdtUKTr+ruuGq1i83PYwuKbaCDWmT4o=;
        b=IwGq7MKyUglxXKJK3cxTTBDe/bG7Yln2BOdT4AkptfNDr+FEZyjGWG0KzAO3XlBBom
         6ZGsx1ucyvFYyrdQ5QJYYgROq+NZMY6HVdxwFM9uMKVonyhJbyfxPxYLKMtKSwu9QDtb
         70A3CSXTihAUYsKJLJM0Y6KIl3ncRMKrwq6CXDNP+a44w+uc/N1bN50UeMuIJCvq4jFp
         QaG0FCd6KOFMBQiECjqN4VpMePez648WvblSHoAzxPA82A02XVUrW/buulKEoKB/+ZyL
         PL5jhaNUv9H8FxO2tzX9LFDKE6tIuH7mBJWi8MAhKFhUafcOayzKXRRsYDLos2w7iW0y
         35xw==
X-Gm-Message-State: AOJu0YwisNUGy+kiF816uaxWalSrMSUgcfOEVn7qICDco1CoGSWKgVYk
	khuW6Su/tduWoohR4FIsiKMj9g46yn77vJaPDjCgVEXGp6o4AP1p7Jwa0DndBXaK9CP2FNRjTIb
	d+vxBgWJGq4NeC5X8iYCvG9cSf//7WLTp
X-Google-Smtp-Source: AGHT+IG0ytYpwGwpbeev2n4FI/yLVfIqWL5pR3sPrWIFsiGFqGCNJW19+jiixRNdxTaN5U/zZxqPyT8kCMFo0aqj7yg=
X-Received: by 2002:ac8:5843:0:b0:440:6592:64b7 with SMTP id
 d75a77b69052e-4413aeb2966mr46524001cf.17.1718125987340; Tue, 11 Jun 2024
 10:13:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240608171923.136765-1-cgoettsche@seltendoof.de>
In-Reply-To: <20240608171923.136765-1-cgoettsche@seltendoof.de>
From: James Carter <jwcart2@gmail.com>
Date: Tue, 11 Jun 2024 13:14:30 -0400
Message-ID: <CAP+JOzT2Fo3T8zzdCCaLZKdximUCWC6My3ZzoNqhsDhiSV0c4A@mail.gmail.com>
Subject: Re: [PATCH] libsepol: hashtab: save one comparison on hit
To: cgzones@googlemail.com
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jun 8, 2024 at 1:19=E2=80=AFPM Christian G=C3=B6ttsche
<cgoettsche@seltendoof.de> wrote:
>
> From: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>
> When the comparison function returns 0, avoid a repeated call to it.
>
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>

Acked-by: James Carter <jwcart2@gmail.com>

> ---
>  libsepol/src/hashtab.c | 53 +++++++++++++++++++++++++-----------------
>  1 file changed, 32 insertions(+), 21 deletions(-)
>
> diff --git a/libsepol/src/hashtab.c b/libsepol/src/hashtab.c
> index 2af3a9bf..399582b1 100644
> --- a/libsepol/src/hashtab.c
> +++ b/libsepol/src/hashtab.c
> @@ -112,15 +112,17 @@ int hashtab_insert(hashtab_t h, hashtab_key_t key, =
hashtab_datum_t datum)
>         hashtab_check_resize(h);
>
>         hvalue =3D h->hash_value(h, key);
> -       prev =3D NULL;
> -       cur =3D h->htable[hvalue];
> -       while (cur && h->keycmp(h, key, cur->key) > 0) {
> -               prev =3D cur;
> -               cur =3D cur->next;
> -       }
>
> -       if (cur && (h->keycmp(h, key, cur->key) =3D=3D 0))
> -               return SEPOL_EEXIST;
> +       for (prev =3D NULL, cur =3D h->htable[hvalue]; cur; prev =3D cur,=
 cur =3D cur->next) {
> +               int cmp;
> +
> +               cmp =3D h->keycmp(h, key, cur->key);
> +               if (cmp > 0)
> +                       continue;
> +               if (cmp =3D=3D 0)
> +                       return SEPOL_EEXIST;
> +               break;
> +       }
>
>         newnode =3D (hashtab_ptr_t) malloc(sizeof(hashtab_node_t));
>         if (newnode =3D=3D NULL)
> @@ -151,14 +153,19 @@ int hashtab_remove(hashtab_t h, hashtab_key_t key,
>                 return SEPOL_ENOENT;
>
>         hvalue =3D h->hash_value(h, key);
> -       last =3D NULL;
> -       cur =3D h->htable[hvalue];
> -       while (cur !=3D NULL && h->keycmp(h, key, cur->key) > 0) {
> -               last =3D cur;
> -               cur =3D cur->next;
> +
> +       for (last =3D NULL, cur =3D h->htable[hvalue]; cur; last =3D cur,=
 cur =3D cur->next) {
> +               int cmp;
> +
> +               cmp =3D h->keycmp(h, key, cur->key);
> +               if (cmp > 0)
> +                       continue;
> +               if (cmp =3D=3D 0)
> +                       break;
> +               return SEPOL_ENOENT;
>         }
>
> -       if (cur =3D=3D NULL || (h->keycmp(h, key, cur->key) !=3D 0))
> +       if (cur =3D=3D NULL)
>                 return SEPOL_ENOENT;
>
>         if (last =3D=3D NULL)
> @@ -183,14 +190,18 @@ hashtab_datum_t hashtab_search(hashtab_t h, const_h=
ashtab_key_t key)
>                 return NULL;
>
>         hvalue =3D h->hash_value(h, key);
> -       cur =3D h->htable[hvalue];
> -       while (cur !=3D NULL && h->keycmp(h, key, cur->key) > 0)
> -               cur =3D cur->next;
> -
> -       if (cur =3D=3D NULL || (h->keycmp(h, key, cur->key) !=3D 0))
> -               return NULL;
> +       for (cur =3D h->htable[hvalue]; cur; cur =3D cur->next) {
> +               int cmp;
> +
> +               cmp =3D h->keycmp(h, key, cur->key);
> +               if (cmp > 0)
> +                       continue;
> +               if (cmp =3D=3D 0)
> +                       return cur->datum;
> +               break;
> +       }
>
> -       return cur->datum;
> +       return NULL;
>  }
>
>  void hashtab_destroy(hashtab_t h)
> --
> 2.45.1
>
>
