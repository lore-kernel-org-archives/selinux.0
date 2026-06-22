Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90F6034C130
	for <selinux@vger.kernel.org>; Mon, 22 Jun 2026 20:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782159881; cv=pass; b=JumdvTgF5vGnQMcoe0JGtJcb4GAKlwu3yG5nwIDG2izJuna4gmDpO+5GYTCqS5Xq2MGdWS8p2g+WksUjcs3FHiLpWDoWfqq7YP6L7KD3+7mDrPVeMsJkk1n9m8D1+qblGDPXCKk3IFCQVZUaltXMROmOWL2BnN8JtzRYI5SbMsM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782159881; c=relaxed/simple;
	bh=V58tAN05+wApSPCfu9hhk/hUORNhGfbxeNqsQRxPEZw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BVEiLFaj+xjTK2qnirg4rxInC6tVEvog0Z0jPkLxgJPCYCkAhaMXKLnZOzHqS88/9OEaLvqYEHSB7nEiCLGEOw1RrvYsaLZhvCPJt8tnvfbEAnVF6jj84Q+oh0PREPQ7zEzd6sFnsBgircs3CbiDMg3x1hzP8QMWxqL8D9gGqqI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JdujPOs6; arc=pass smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JdujPOs6"
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-c891d27b10eso3246440a12.0
        for <selinux@vger.kernel.org>; Mon, 22 Jun 2026 13:24:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782159880; cv=none;
        d=google.com; s=arc-20240605;
        b=WAnheIwwJOZKclkufklHssdfcHm+kaXfYRwj5JMZL8QCqJJzfYjYnQj62HD2DWua3h
         7O3qeOVrHlj6Q9cQk7gy33JEn6aOhz0cOQ5oQUrkjR6XCl5T2Jekm3JB9YqeCHIB5SaA
         n/b3wTnnkOOlTNjrb6fjkVAGYj+8YRv6zqDoxENh5uKeYaLe8W1zFop71TiZegZSqeu8
         Oju07iwT08610J4iXlanOTPFPfhi9yvkBbCUYNqLHczGRaJI9lp5Iw4zb4VgFLlqBCSz
         Fh1zkAS+iVHLxN81qQxvUA7z9mCck4h6zFfGRlGoVo3jVv/sznUphI2Xgi4tf36UharU
         ly6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=nHWVB6NMmxxjNqcY8jkBwKk0J/hQhGb2hDRIPlXDaII=;
        fh=FsXghBnyoYbEc42Idnie0oh5A6i9FUng5ntOLhqXIRs=;
        b=O1MMQlxYdMgXLG+sr+Ovocs0yUM7ApwiD+fD3efiDq681RmPOvKwy2zZMD0B9h4OR9
         fpHzPC+uW8ZiLV63bsEah8AYeAugNv4ogfFtlGo+g1CX6b7/sj4kwIy8E+VfacI7AoFY
         ZycxHm8nnbfEV1wYZ2PAGBBSs2eNfnQ+rk/tSZ8lpU6uDjzCLKwrJtFkNaQxFIhDHsKs
         mlmXjoHKRUyM/3HikMmrO0NnbUeZcHdywd8X+TqYGPJtSVKORtHso9lrnAmN56ReuCX1
         0XuxQ/h59ssP2O7w6dYBiXn4P0DBDA0TYZUt5pAahag76tABgAsAUdeoYPjwW4rI3Qn9
         x/gA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782159880; x=1782764680; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nHWVB6NMmxxjNqcY8jkBwKk0J/hQhGb2hDRIPlXDaII=;
        b=JdujPOs6MINmQxl2ZE2U9kCU7M62aMPx1OyFtpJc7sjzeYLTrq1HF+/xMQubq/VPIl
         rZqrY68ta38/2lHe/riCUquwgTzZl+6WTLsCxTSSQaX42ewv1NsdUBJKvJQlABmTlc3k
         S9bo2l2qH6QZEDUuz8WoZlbfBwpgIfIMQyrj4Bj2NIKJ5XOMzI16j8vqdEs51ZrxV/QE
         1MBxd+YY054qK5Z8ZF0S/0nlLSCg5myFN/cjE71J5DKJ8/pjPnmtlTWlcfJKmk21hlwB
         uFPP0WJ9zse/ngoruk2Oxi8W+s/mZcqIPzt4EEoWKNj9eC+UJGbYGl6VlnRgQJODyVze
         f4yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782159880; x=1782764680;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=nHWVB6NMmxxjNqcY8jkBwKk0J/hQhGb2hDRIPlXDaII=;
        b=XHcne+zzbceSlatW/HXO9KgMmHEs2MjiO3NB/x1UNA+0f3otkLWsqMkZpl5fDHLgB1
         zJmcIALcFxsc62RAwAyo5q906TqRULivzbunSC9xktzJq9AitzMpoEqYWh/CZwyyRNqW
         vOwTbxJ0bNyh/zLbSh61c3dygNyC1EcXe7hPw2K+oT8xPo9PryMhg8TKJzAJ4Wlg3f9x
         rK3thm10bhbo9Xu+41OdwxC29Er2ykuOdxDzlsj5Q+QpdfcE3K+Daptk2IHCGEvZihc9
         pXtiEbc5mU48CtPPbzdacdnwpEJx0KkWXHPMoaK/cp3LNa5RPnjuCQZ/pJM4STkhYRRI
         o/uA==
X-Gm-Message-State: AOJu0YwUPdJe4zKOjd5kCGT0bC0A4eauNtq9O75dV1JECiEM9lX02+wc
	HVN37J4BOqVHyUZrguRo1OMCGwk8N2znFhRXM1N3qcNn4S/W3IMVTvZzgexP027cPqwXjquEYvj
	/N0N67SIOJMZ3jpVriR/ddOHSyJYWBBs=
X-Gm-Gg: AfdE7ckZZSpOcJFfzoEbmXE9/WIC5dqyQJz5J0gOtlS17hACSWZXQDmv7qQFXbHRPmF
	33kreyKG11gCAChZG6w4A8Xenn+XoWFk/k4LE+/FpptrZoccKPpjPSDV/rcRE9l4NnKR0g4+H/2
	nBJeqkBevEPYwrWeiIvHulNwxNZXKnohQeegu/0QWb/4aOodFRaHCWcEs6weXlkHUgXodaH40s5
	+Nl3EVeft1oUQabeOGiIb6Iz7hcTcOPR/JCwxMPe/KenQ0KqQAawrqdE6WsilSkvCP9LYNu
X-Received: by 2002:a05:6a21:1f84:b0:3bb:1639:6ebc with SMTP id
 adf61e73a8af0-3bb346546f8mr18514080637.31.1782159879879; Mon, 22 Jun 2026
 13:24:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260622173541.174998-1-jwcart2@gmail.com> <20260622173541.174998-6-jwcart2@gmail.com>
In-Reply-To: <20260622173541.174998-6-jwcart2@gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Mon, 22 Jun 2026 16:24:27 -0400
X-Gm-Features: AVVi8Ccwyyzw693N0Bi3UyRaL-wG9eHy-nO-7w3el_cza16RlqpicL4QOAWLRQY
Message-ID: <CAEjxPJ7=ue71sreD+qMoUPBrbPY4O4ithZAWp1rHRHeUs=hikA@mail.gmail.com>
Subject: Re: [PATCH 6/6 v3] libsepol: Add overflow checks
To: James Carter <jwcart2@gmail.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 22, 2026 at 1:36=E2=80=AFPM James Carter <jwcart2@gmail.com> wr=
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
> Signed-off-by: James Carter <jwcart2@gmail.com>

Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>

> ---
> v3: Previously in patch 0004
>     Use __builtin_mul_overflow() family of functions
>     Add checks for an error for all calls to stack_push()
>
>  libsepol/src/module_to_cil.c | 31 +++++++++++++++++++++++--------
>  1 file changed, 23 insertions(+), 8 deletions(-)
>
> diff --git a/libsepol/src/module_to_cil.c b/libsepol/src/module_to_cil.c
> index 00db3d7f..5b34186b 100644
> --- a/libsepol/src/module_to_cil.c
> +++ b/libsepol/src/module_to_cil.c
> @@ -447,13 +447,17 @@ static int stack_push(struct stack *stack, void *pt=
r)
>         void *new_stack;
>
>         if (stack->pos + 1 =3D=3D stack->size) {
> -               new_stack =3D reallocarray(stack->stack, stack->size * 2,
> +               if (__builtin_smul_overflow(stack->size, 2, &stack->size)=
) {
> +                       ERR(NULL, "Overflow");
> +                       goto exit;
> +               }
> +               new_stack =3D reallocarray(stack->stack, stack->size,
>                                          sizeof(*stack->stack));
>                 if (new_stack =3D=3D NULL) {
> +                       ERR(NULL, "Out of memory");
>                         goto exit;
>                 }
>                 stack->stack =3D new_stack;
> -               stack->size *=3D 2;
>         }
>
>         stack->pos++;
> @@ -1482,7 +1486,6 @@ static int cond_expr_to_cil(int indent, struct poli=
cydb *pdb,
>
>                 rc =3D stack_push(stack, new_val);
>                 if (rc !=3D 0) {
> -                       ERR(NULL, "Out of memory");
>                         goto exit;
>                 }
>                 new_val =3D NULL;
> @@ -2163,7 +2166,6 @@ static int constraint_expr_to_string(struct policyd=
b *pdb,
>
>                 rc =3D stack_push(stack, new_val);
>                 if (rc !=3D 0) {
> -                       ERR(NULL, "Out of memory");
>                         goto exit;
>                 }
>
> @@ -4183,7 +4185,10 @@ static int module_block_to_cil(struct policydb *pd=
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
> @@ -4210,7 +4215,10 @@ static int global_block_to_cil(struct policydb *pd=
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
> @@ -4284,7 +4292,10 @@ static int linked_block_to_cil(struct policydb *pd=
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
> @@ -4595,7 +4606,11 @@ static int fp_to_buffer(FILE *fp, char **data, siz=
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
> 2.54.0
>
