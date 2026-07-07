Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 755B13F99FE
	for <selinux@vger.kernel.org>; Tue,  7 Jul 2026 12:24:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783427099; cv=pass; b=JTzfOPVoJ9zUVGiv0xzc6sP+v6VCnkEC+CLjms1xC3/mViO/es6fyElLMHR62md2zwOjRrdAGCfFdGcSxbmnwzQwoWf43t6u/FhhlxPqSD8Vrf86/UZ3Btkhe6X0Fftr9nkPC3zPFIw8L5QxtpKQbf9JZZHr8t7iWS6bDCW2ccI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783427099; c=relaxed/simple;
	bh=XBlekaeMwLXf80kDnZDyLbeXn8A63mYStTBjvMKvr4M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iQPP69fXYL+rvkFcTYaiN0umatRReOTTWWiXoxutgbqf8ZmJG47y98Liv2t7ZcuEWkMd5eH04FmlO3G/YIIZ71PJtz/FhuidypHawAb2eJLlewyPU/OdOiQYqWdM33k/Q9Tcprw37JwHA1qlsBxCB1m0jXIOFJNh28JABe8m3aM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P0Z4NRBJ; arc=pass smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P0Z4NRBJ"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2cace91f112so35037275ad.0
        for <selinux@vger.kernel.org>; Tue, 07 Jul 2026 05:24:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783427097; cv=none;
        d=google.com; s=arc-20260327;
        b=X6HGJh6ha8GRrYjag6lOi26s+o2ODEcHmHeGJtLTgG4XNcfdzmEoeajBPUXK419DpF
         mrN9Gwtq4msWcpwCEiNdG4vDWIdOYZvOpC5no3WK7rvkEx3pDxKjBzzw4cMpS4TPbnut
         ibKEC/Bi/w13llqUq9XtImzWOrT6cQdn9gZRfQ/T8coTCwLeJk/mR5NHVnSFU+fcGZqU
         6/URI9cMql7TqEZLsA/ckkRhYvTc43cm7lTfkO1ujIWH6dhq1YOGshSg73MKQ+iGcioz
         8PSiBb7fpOCf2JTj7bNYlKYfqy5k/aU1CemkAsMZb10ba44qk9yNnwwef3dkHwHvvxnh
         QSzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=FZgayyinbWzK3+gSwVlfLvJw6LVtiS65uXERgpRkRMk=;
        fh=FsXghBnyoYbEc42Idnie0oh5A6i9FUng5ntOLhqXIRs=;
        b=iCeBOwAUprt6azV9ABqPsZe14CoFxRS5T8Fhgu9ekMNk5n48VqcyO4Q2lM/J0xvG2f
         i8NdZ7hEogzam1A+28/ztvIqLKAZRC3lb0v6Mz4E4bE90n37BJSdtAR4c3GwOJn/5qIG
         3ezoUdXL62UR3sqT3FeJ5Y39UwedNZxf7DYn0hflJ0IOE5AoWkiH6LFzfemz2h8V3r/y
         1qCi8qUzgUpBevMf/o64u7iiDoAwfhnHODpHeyRgnKWugezYBLJsqvT68PUSOlCMLNaI
         IQZM9iG9iku8mRqrBMMutPKvD2eQW1gU1aQQji05gOi+vbGglK1HnOpnNXDnyz1qVNsa
         opyQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783427097; x=1784031897; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FZgayyinbWzK3+gSwVlfLvJw6LVtiS65uXERgpRkRMk=;
        b=P0Z4NRBJZ42u7/9e/MsKRpXclYUWJtU2brg2gyKONYF0fnKdVkNY0MN3qFSgWpSu1f
         +nT1tOiF6kD10w/QUqFUPW1t8BDE7TGuFIrjbrYWlfRmvh2r/F/l1/GXn/57aduqSLc4
         taGyy3RDUb01TDtRAbpaL6J4XZf22n4/JefHh03XwF9OrPZU5FBsEeHqe7AZ6GB9SSny
         5ofr86qdg/0mJbYfvqObgGJnahs4iHxuvBGdj+35+9OGB7WGiUGR/RvQ3Wu2e4SNqYr3
         /uZMmiAHhEBCTU8H7+W2wKXWfIyOSsIMLpYHRQbX1+lzIVY0EfyYLZQ1e2xR8gP2O8Qe
         3lqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783427097; x=1784031897;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=FZgayyinbWzK3+gSwVlfLvJw6LVtiS65uXERgpRkRMk=;
        b=PP1xqq+nU3hE+C77pjHKDggs7zcpuJdZmbdcoM9mjyp5XPt94WcOhi/oNeOLGY9ubd
         OGJrwPpls58BiTUz0uluRB3+nCRBuJ9X+YXa+i27auK5dSLYY34Z5N5osv9uGWTplHyA
         X6+o0XL8cG4jOceYbmefBMTw/ap0tSCuKncREkaazOEqm7XvlwJwFd/NvpOFn2HUbMKz
         BC20SVCZ4oUOwAKPwl4lz4AoL0ytQXYuNCdTIvR2KcSY8TmO4AhyFFJsi5kg5Fa2ViE9
         9CkSwFJACOUcpdz6tb1xQEkoR06ATIo8NGOS8Lg0vC7dud4QhV7k5DsuVflsEnsxv+IV
         jyAQ==
X-Gm-Message-State: AOJu0Yx59+jbbg8HoPXkvmBU+hdpWX8qdlcfA182AgWdzmeAt63HM7U8
	ddrdfwvtaq2gFiL9rEs+rpl/yD4FrcHds3EyMEXYybrdQkxsn+s625R854guXcnuDLFecpMysfg
	I7yuE1novPCmOPvc5coeMXK2Bn0pIKJ0=
X-Gm-Gg: AfdE7cnIXxcTdxUxxu1uY7eYsTwmXaTT/7z5BLowLGhNhLq6Uyy6wJEPZAV/4U+0/1b
	OmDmxF/I2uVg1Jkh7TRGBqGDGJF0ivfb9Sr22+QDCKxLWJtDXKvqpfrp/QHHwcyKu8Q+1hYQCaE
	+SPlrpIzKwqsZNYefbwxyVMJqhKzsyCNqwRkTafBkZj65a0KcuuuCefTc/O9jWbUuGtq28TW3cR
	sVN/eqLiwRetJUDQyzPHozajbP+iYonrYmeLqdPMHcChKFRZ4GyD3HNptUZ6sacXn/p9rEq
X-Received: by 2002:a17:903:1a0f:b0:2c9:97a7:b1eb with SMTP id
 d9443c01a7336-2ccbf06aea0mr46063985ad.42.1783427096746; Tue, 07 Jul 2026
 05:24:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260706143844.25956-1-jwcart2@gmail.com> <20260706143844.25956-6-jwcart2@gmail.com>
In-Reply-To: <20260706143844.25956-6-jwcart2@gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Tue, 7 Jul 2026 08:24:45 -0400
X-Gm-Features: AVVi8CfcUaQxlZSpxxtRfFZsIQ4NbsNOTooMIdwqKAO70rzUYOm4TgOwJpeJxFE
Message-ID: <CAEjxPJ6uzkGp34eV4kPRRreLpQ0w+fNwu+aWCw+WCMhmU4XAsw@mail.gmail.com>
Subject: Re: [PATCH 6/6 v7] libsepol: Add overflow checks
To: James Carter <jwcart2@gmail.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 6, 2026 at 10:39=E2=80=AFAM James Carter <jwcart2@gmail.com> wr=
ote:
>
> The function stack_push() uses the common idiom of "*=3D 2" to grow
> the size of the stack, but there is not check for overflow. Use the
> __builtin_smul_overflow() function to report an overflow and return
> an error.
>
> There are several calls of stack_push() that does not check for
> an error. Add checks for an error for these calls.
>
> Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> Signed-off-by: James Carter <jwcart2@gmail.com>

This series has been merged.

> ---
> v7: No changes
>
>  libsepol/src/module_to_cil.c | 33 +++++++++++++++++++++++++--------
>  1 file changed, 25 insertions(+), 8 deletions(-)
>
> diff --git a/libsepol/src/module_to_cil.c b/libsepol/src/module_to_cil.c
> index 00db3d7f..2aaf4feb 100644
> --- a/libsepol/src/module_to_cil.c
> +++ b/libsepol/src/module_to_cil.c
> @@ -445,15 +445,21 @@ static int stack_push(struct stack *stack, void *pt=
r)
>  {
>         int rc =3D -1;
>         void *new_stack;
> +       int new_size;
>
>         if (stack->pos + 1 =3D=3D stack->size) {
> -               new_stack =3D reallocarray(stack->stack, stack->size * 2,
> +               if (__builtin_smul_overflow(stack->size, 2, &new_size)) {
> +                       ERR(NULL, "Overflow");
> +                       goto exit;
> +               }
> +               new_stack =3D reallocarray(stack->stack, new_size,
>                                          sizeof(*stack->stack));
>                 if (new_stack =3D=3D NULL) {
> +                       ERR(NULL, "Out of memory");
>                         goto exit;
>                 }
>                 stack->stack =3D new_stack;
> -               stack->size *=3D 2;
> +               stack->size =3D new_size;
>         }
>
>         stack->pos++;
> @@ -1482,7 +1488,6 @@ static int cond_expr_to_cil(int indent, struct poli=
cydb *pdb,
>
>                 rc =3D stack_push(stack, new_val);
>                 if (rc !=3D 0) {
> -                       ERR(NULL, "Out of memory");
>                         goto exit;
>                 }
>                 new_val =3D NULL;
> @@ -2163,7 +2168,6 @@ static int constraint_expr_to_string(struct policyd=
b *pdb,
>
>                 rc =3D stack_push(stack, new_val);
>                 if (rc !=3D 0) {
> -                       ERR(NULL, "Out of memory");
>                         goto exit;
>                 }
>
> @@ -4183,7 +4187,10 @@ static int module_block_to_cil(struct policydb *pd=
b, struct avrule_block *block,
>                 (*indent)++;
>         }
>
> -       stack_push(stack, decl);
> +       rc =3D stack_push(stack, decl);
> +       if (rc !=3D 0) {
> +               goto exit;
> +       }
>
>         rc =3D block_to_cil(pdb, block, stack, *indent);
>         if (rc !=3D 0) {
> @@ -4210,7 +4217,10 @@ static int global_block_to_cil(struct policydb *pd=
b, struct avrule_block *block,
>                     "Warning: 'else' not allowed in global block. Droppin=
g from output.");
>         }
>
> -       stack_push(stack, decl);
> +       rc =3D stack_push(stack, decl);
> +       if (rc !=3D 0) {
> +               goto exit;
> +       }
>
>         // type aliases and commons are only stored in the global symtab.
>         // However, to get scoping correct, we assume they are in the
> @@ -4284,7 +4294,10 @@ static int linked_block_to_cil(struct policydb *pd=
b, struct avrule_block *block,
>                 }
>         }
>
> -       stack_push(stack, decl);
> +       rc =3D stack_push(stack, decl);
> +       if (rc !=3D 0) {
> +               goto exit;
> +       }
>
>         rc =3D block_to_cil(pdb, block, stack, 0);
>         if (rc !=3D 0) {
> @@ -4595,7 +4608,11 @@ static int fp_to_buffer(FILE *fp, char **data, siz=
e_t *data_len)
>         while ((read_len =3D fread(d + d_len, 1, max_len - d_len, fp)) > =
0) {
>                 d_len +=3D read_len;
>                 if (d_len =3D=3D max_len) {
> -                       max_len *=3D 2;
> +                       if (__builtin_mul_overflow(max_len, 2, &max_len))=
 {
> +                               ERR(NULL, "Overflow");
> +                               rc =3D -1;
> +                               goto exit;
> +                       }
>                         d_tmp =3D realloc(d, max_len);
>                         if (d_tmp =3D=3D NULL) {
>                                 ERR(NULL, "Out of memory");
> --
> 2.55.0
>
