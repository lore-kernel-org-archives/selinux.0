Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 071EC413241
	for <selinux@vger.kernel.org>; Mon, 20 Jul 2026 12:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784550047; cv=pass; b=Y3Y8Gexk15HXkOQ6AUE8lbKvUCfAapUQqYkC8to0zwx7ixO0RC28c8KMAdsPGr/nIimk8QqRp2xduSZmc1fHEcOwfAriKG82lixvUrJkJ//vDkzMC88gCZjm+vUGdTXlJEbRqLipJUDxnZ7tfPAM2NVAdAPlplf5L/cjjQ16DYk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784550047; c=relaxed/simple;
	bh=SYrOoCHt2hktdv8s74gM1FcLw6qwcHzTZrOGY4wcSUE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=j0z6+VT4Y//jzo1BWvQswLSLDFeqy1UJEvkBSykC9HqYbAmYCfJZULoSv24mZAdrtrMiN0QSrCmubonrVACIJhtYp/ynhxTNq8UMMmPl99kZRul2zN3oo8D9LMAfxe8C8vz86xrFb3sdj4uMn25d5TB11EfCYzsCpxEB0KLfqKQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CNBOIHmz; arc=pass smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CNBOIHmz"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-84867f07d63so11196370b3a.2
        for <selinux@vger.kernel.org>; Mon, 20 Jul 2026 05:20:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784550045; cv=none;
        d=google.com; s=arc-20260327;
        b=eDnbhhWSmiX0czM3aoSaPSIJBM3A95VG1UnvswL/1+LixM68amuYRkz5thfydJZsEu
         EkD6LOoAuVURTNsAM/+tZTMjOo2Jcr9/aa3oiMQcY51BShwTfMyHqPFu/RrwQJAmaCOG
         N8kJ9YZFq2vrg+cEZnhWhYUwbeHdXDZCmJqKPRb9prXgCdMv9QvhbCFovREHUuKZ/wY3
         xmS15eVkElDib+gpqxm49B6+cAPAwWOC4J8bdf7AY5GLlKdQ2G8jlFItyYZFPEFYQiFk
         UXJoGUt45A2jgMy1yiPvt6zYjdyeLAHOeHSoFg81XTLITPh0vKW4aPkeE69R7mestTrR
         3wYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=D8U09JkI+qh3oDtYU7S+Vscm7hpN1EVy9G0mqPyD1pc=;
        fh=FsXghBnyoYbEc42Idnie0oh5A6i9FUng5ntOLhqXIRs=;
        b=WT41XZtBdu0UsR14+RujswNg0pYWVZmA/hWRRaWQgLzyGA2kP1xuYiOh1xXGmpzOjq
         SCB1LS/cD1+3vBU08eKDTwg38qCIgijH/gsz96RecyRsOoSlO6o0ehbPS1yU2v5miWIl
         ZFEMnO4pe07J2ycR222U0rEa1yITiqogMUOa4C+/mZPxPC4ceqKv8x5wG+fDrC/ngUBP
         VmwzbwgBZlowluqmYQtcRCY9yRh2595QR2ty/QfrPnj7t4GJqstZCWQcHOqtYh64iA9Y
         mtfnskDq4fT7QbuzLKtimKePM4TFkJyJzIpdH0p786f8gNpFf/vlfIjOhFdSYQvT/0gr
         Q+pA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784550045; x=1785154845; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=D8U09JkI+qh3oDtYU7S+Vscm7hpN1EVy9G0mqPyD1pc=;
        b=CNBOIHmzJJH091twmMxmH8rJvJHD0vgP+FQbH7GQOI/+R9G/7qe6Y58dCckzUvPWn5
         JbgcUJzk//bwXAfT8SYGTpXRgxVqgvLwHHNtkuFwwGDHqc3gPJQjZUagG7sM2gQGDBrG
         WmUvLfawjcHwyS10wHAQOFmx6qhTz/4gkzszf7i8CCvECDYnvahiWtDleTL1JCSUv5kx
         hS/kyp9KJZmq7HdsQMAHhj6XnPKRCS/U3KZ/PgPcM5JDH3WYZk1I0rzWt/Pg19IlK/Iw
         BXqUoVhkyYaDuFPiPSVTFYkq9WrgmwCO5W1yCieDY9TNb4Wa+azzoPRkMjV6py+zVkhT
         7FBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784550045; x=1785154845;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=D8U09JkI+qh3oDtYU7S+Vscm7hpN1EVy9G0mqPyD1pc=;
        b=LXezZXfLBLUmQ79SbttxRd7x2+VZ2kXSS6qVjbKIatiUCAfFSuZAal126B4fXukb/C
         GXBivrSxXv8Pt2TMmS8KAY+X/saesg1dl5yk7j0JxwUvqp2xByEFkA4yRbLi1CYvL8wi
         4lKO5NLCQFXZ7Q+HDzxRyIaX8t3wH9oNXJYqjezONcV1lyp17kL1t52w4Nl7uB4ZohtS
         jh2g+I1jSquRAwBwuatdKCV4dKdD+YOEFATIC+0sA+3kNOhvhdUeXlToJLXsOocj2P7u
         jzgaIdmfAH4sCUkhgaUNRjNvRmljyK/E35LHIqw4vaihMAEujlGWkO0oUdI0XgfIGN26
         9Ulg==
X-Gm-Message-State: AOJu0Ywe+AkTn7Z8zL7Gsn0MgO2aZcagASy/b+rMZZ/khfVctpBG71vX
	3L1wNLkABqqWSXYuoXoiKisrt3dE3f0YpGt6qChNWxPnVIp5NEZ9CO88L7/fsJda3ZYCD+YWFu3
	79c+g+jix33yu8KCJT4fM0sgU/gHZj+29eA==
X-Gm-Gg: AfdE7ckZ9i9TqDkBoEs2rn+806wTUmJZ8OibtY3DEjZOlzEN+Fhp4H+Qg/KRYEDAJmS
	mK/p2YCXyPsXhX0Lyr8cTv5kplNQRFOV9pXhERfCzeU+Bqs4KuV+R+npbZlXsyz2PDIiMheN1HG
	gdGqd2LB6CVnPZqmX3MWm7AHTvnk6vlVUggleXRi4RzJxnbk2/hIVS1bXJ7/18CoZNWRP5dPogR
	7oTiJO7/M6szcSh6T+PtN8RADgCYVuusy423OVwuatGT02OpOMPIcpFE1acXw==
X-Received: by 2002:a05:6a00:348b:b0:848:8715:c2cd with SMTP id
 d2e1a72fcca58-84c2948b105mr14910270b3a.47.1784550045092; Mon, 20 Jul 2026
 05:20:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260717173544.15801-1-jwcart2@gmail.com>
In-Reply-To: <20260717173544.15801-1-jwcart2@gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Mon, 20 Jul 2026 08:20:33 -0400
X-Gm-Features: AUfX_mw0nSFUujZH9bQjaJD9TrBSjFhmCfUmObdYvomj4rAypjO7klrNH58djCc
Message-ID: <CAEjxPJ5Mcz8ECLWS6mmjfbx+YsBF2tPNZVVyeGRjhQFMN-VN4w@mail.gmail.com>
Subject: Re: [PATCH] libsepol: Prevent OOB access of array when copying scope information
To: James Carter <jwcart2@gmail.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 17, 2026 at 1:35=E2=80=AFPM James Carter <jwcart2@gmail.com> wr=
ote:
>
> The function copy_scope_index() in link.c copies information about
> what declarations are in scope for the current block. This is tracked
> in the "scope" field of the scope_index struct in an array of ebitmaps.
> A second field called "class_perms_map" is used to track which
> permissions are in scope for each class. The "class_perms_len" field is
> the length of the permissions array. As the function is copying scoping
> information from the module to the base policy, the index values are
> translated as well. When the information for classes is translated and
> copied the largest new index value for a class is determined. This value
> is used to allocate the class_perms_map array. For each source class in
> that array, the bits in the source ebitmap are translated and set in the
> destination bitmap.
>
> A maliciously crafted policy could set permissions in the module's
> class_perms_map for a class that is not in scope. If that class has
> a new index that is greater than the largest index of a valid class,
> then there will be an OOB write when copying the class_perms_map.
>
> When copying the class_perms_map, check that the index is not going to
> result in an OOB write when converting. In addition, if there were no
> classes, then just set class_perms_map to NULL and return. Also, don't
> bother trying to copy permissions if the ebitmap is empty. Finally,
> just use array notation when copying the scope and class_perms_map
> data since they are both arrays of ebitmaps.
>
> Signed-off-by: James Carter <jwcart2@gmail.com>

Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>

> ---
>  libsepol/src/link.c | 27 +++++++++++++++++++--------
>  1 file changed, 19 insertions(+), 8 deletions(-)
>
> diff --git a/libsepol/src/link.c b/libsepol/src/link.c
> index 70742fc8..868e0a7a 100644
> --- a/libsepol/src/link.c
> +++ b/libsepol/src/link.c
> @@ -1652,8 +1652,9 @@ static int copy_scope_index(scope_index_t *src, sco=
pe_index_t *dest,
>         ebitmap_node_t *node;
>         /* copy the scoping information for this avrule decl block */
>         for (i =3D 0; i < SYM_NUM; i++) {
> -               ebitmap_t *srcmap =3D src->scope + i;
> -               ebitmap_t *destmap =3D dest->scope + i;
> +               ebitmap_t *srcmap =3D &src->scope[i];
> +               ebitmap_t *destmap =3D &dest->scope[i];
> +
>                 if (copy_callback_f[i] =3D=3D NULL) {
>                         continue;
>                 }
> @@ -1672,18 +1673,28 @@ static int copy_scope_index(scope_index_t *src, s=
cope_index_t *dest,
>                 }
>         }
>
> +       dest->class_perms_len =3D largest_mapped_class_value;
> +       if (largest_mapped_class_value =3D=3D 0) {
> +               dest->class_perms_map =3D NULL;
> +               return 0;
> +       }
> +
>         /* next copy the enabled permissions data  */
>         if ((dest->class_perms_map =3D calloc(largest_mapped_class_value,
>                                             sizeof(*dest->class_perms_map=
))) =3D=3D
>             NULL) {
>                 goto cleanup;
>         }
> -       dest->class_perms_len =3D largest_mapped_class_value;
> -       for (i =3D 0; i < src->class_perms_len; i++) {
> -               const ebitmap_t *srcmap =3D src->class_perms_map + i;
> -               ebitmap_t *destmap =3D
> -                       dest->class_perms_map + module->map[SYM_CLASSES][=
i] - 1;
>
> +       for (i =3D 0; i < src->class_perms_len; i++) {
> +               const ebitmap_t *srcmap =3D &src->class_perms_map[i];
> +               ebitmap_t *destmap;
> +               if (ebitmap_is_empty(srcmap))
> +                       continue;
> +               j =3D module->map[SYM_CLASSES][i] - 1;
> +               if (j >=3D largest_mapped_class_value)
> +                       goto cleanup;
> +               destmap =3D &dest->class_perms_map[j];
>                 if (ebitmap_convert(srcmap, destmap, module->perm_map[i])=
)
>                         goto cleanup;
>         }
> @@ -1691,7 +1702,7 @@ static int copy_scope_index(scope_index_t *src, sco=
pe_index_t *dest,
>         return 0;
>
>  cleanup:
> -       ERR(state->handle, "Out of memory!");
> +       ERR(state->handle, "Error copying scope index");
>         return -1;
>  }
>
> --
> 2.55.0
>
