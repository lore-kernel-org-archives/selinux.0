Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1948529D27D
	for <selinux@vger.kernel.org>; Mon, 22 Jun 2026 19:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782155582; cv=pass; b=vF0kCxrUvUGp1lpzSj+8qLnoLiNWgy28uyRZ7tT9eavNhUxz8dGyd6/TL68GgG2kndoe2HXu+EoYxh4k4Fq3Ya4s1hak+JeAloI2HCUQ4miUJ6OBAB92l4dDsuBMJiqk6zwam4CW0dT1pN71rma8qy8m8JscqxagxgsYgKWX1QE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782155582; c=relaxed/simple;
	bh=1lVe7ZaiowpcrINq/wtGS+DvZ+FLLjMtLxksTOE/3NU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DC0ozy8F9jKzH7z1JYBoVFFwAUEVmuhVIVRjTPd+mQtEM8odceP/3Poruf36BYjiid+lxNE8zlWeGQ7K2aRN1CSCaC45RFdMljYkMbrPh6bHLZqVrdUaGb0szvoYg9JLbkyuolNB6CstGm2vjBPIK9ui3vD0os9o3opSjvu80V0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lgKgDhss; arc=pass smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lgKgDhss"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-84538597e1fso2799571b3a.1
        for <selinux@vger.kernel.org>; Mon, 22 Jun 2026 12:13:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782155580; cv=none;
        d=google.com; s=arc-20240605;
        b=DqWSz3dAn1Oh0TzaEVMlmPx+Fftoc0eHYZ+5ahL9bCEWYiy4CAuMyVva1palTuU9Ax
         J1ljFOg41IwhdxKAlEujpZEQHA8Pn0UtRvSxpkDK/GwQAfJWURPvbOvy3Gx0ydXTUnUB
         bzYkeSKx93yhfOwnuwlFvZ6V128r5VFhMLgs4vEHhE+1LR1dfN4WDgA4QUhWiFEh/u4D
         9fr+0vXVWvvbDUhrBVl8eRzW6TZ6rQcuNW76EIuumu/oTAIUXxnfIOYXDSxnVvhcPz71
         5Sxeo/heiMUG6e8u0a4S7y7X1DEeZoSBvC8LyA5OR8tfwihMwPwnQlJ5kkI7aiBtUP52
         UHBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=SYjatUUlPMOT5inn+Jj9/q1m7YUXRmjJZZ+lE6z0vUk=;
        fh=FsXghBnyoYbEc42Idnie0oh5A6i9FUng5ntOLhqXIRs=;
        b=NYj1cBGQJ1cydwinZngSNXOX9a3U5gci+Zh+92aYo4PBpvehRvcTpbMmfuS549V9EX
         y3fc07q5hkfFkRY6DWPTKV6SGYXg5dmsatSe/PKzVmbN8gW9ca+b7635QZ3xqhscNDVK
         j1PQbrMJsSMH6zx8Gi/lqmKqgQGv2S8EQy2zqQP9RtA7YHpbr6XGzSt+Uf0RBfxn4PDn
         9boj2XI5TwAGDbPQzOzNvETwy4HKC9S7pBugwzPpdMLrL8CIl/l5jGDwlGEd6kNrPGYj
         uzF7elr+o74IG+jZiSn8idbxXNA+gVlLkHeNbABZkBjBNkFP843vfZe02rUVimRHcibn
         fFQg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782155580; x=1782760380; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SYjatUUlPMOT5inn+Jj9/q1m7YUXRmjJZZ+lE6z0vUk=;
        b=lgKgDhssSqNkTMFouvJJtW/oP5pp1izdS8pnwNDpoMDQ30qypxBL/iDisncjg0Jy+E
         a6DtSsGz71Ab8AxbbELI9wqYgEsYcjUwq+6WJ7Hg3wh6GB0fPlG8jwvQgYnBmMyZ+1s6
         rcs0J/tTKC/ovgtxF4ra+rBTzvFQnJhe4kU7jLkiLn2iFqJN1V9u1b++FBALhlA24LIZ
         HF3xbchADBV1I63yE2wNgyqS4XkyECF3nKy9jVjrcmpID2YGRrh5WZQxqt18IOUNV2jl
         xeJqByZN6qwo9GShewswuVqMeg1mXe7CgQFG4sl/3PJIF8bUodQV6+UqRcxHAJaZ8jnI
         hKQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782155580; x=1782760380;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=SYjatUUlPMOT5inn+Jj9/q1m7YUXRmjJZZ+lE6z0vUk=;
        b=bcUArRYd/t/LLXpNf15zcxfHjaoF3IvM5ps5aYf+ouBxE4eOhOHJVn6yGIKmt5zLgJ
         SsMbZm3IPq+CESGLRinJMZev3Zrf3uesU6YuF9WNFXJfFNANApYX5AWbP4foEYqRIa3U
         C2m4p/EfMYk3XA/mNvqbjjKeAVN98+tPNRaRXqtDTxACtQgon4haXOcjDts52xCVuUMN
         SgZOFKNzRXEsRdQ6jTTwZvK5SMPCs0r+U6+MMK9koyy+xwnepF3yqX2qU/2mpaDmQ1Mt
         d1Ei+P5wWBfftbK2h95qAFyOtTKEFxbh/+3XU/5dXnVjLTugXdtuEdMozviZxHwoD9qB
         5VCg==
X-Gm-Message-State: AOJu0YzhzKeqVT6rlC5OHlpzxa1kmmiQ6qRq8wfj/0LOXPP/To6/C+IL
	tTR6I1atbwnpCG8urpTh4yGOZIouCROPk4J2lX9Ept+F9N7gwHlPZRANSZ0EGlrh0eZgYDdrvGO
	2YSICHyFpVvYqwK6VuT2IgnFxbn6C4sdMjA==
X-Gm-Gg: AfdE7cm2AsghM4erOR0/5ohubV0wnXrrmatxqKLkurDbVcnd7ioszuwktUg0JDXxaM3
	rFwM/7UIrp3eKjZMb+mEKd+DB4reWuEiV4F2mk3bEXmf28pPuDOkfRYCgvuniaAudwTl1964jJh
	LUqYSUC8zwSgWPSk7Jp7BekrRZVoE8Jtb3RsUR7IkK8/me3FA20tZH1xyqtcj6ML/RA+MsqbwYu
	vgsNj5ECUFfHGItTlUsA8w52+c8sEaTOjrwyNcqNj6FuLuCriTG+A2eWuNdijnncpuyoL7p
X-Received: by 2002:a05:6a00:1814:b0:845:363e:12d9 with SMTP id
 d2e1a72fcca58-8455603d4d7mr15533385b3a.3.1782155580283; Mon, 22 Jun 2026
 12:13:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260622173541.174998-1-jwcart2@gmail.com> <20260622173541.174998-5-jwcart2@gmail.com>
In-Reply-To: <20260622173541.174998-5-jwcart2@gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Mon, 22 Jun 2026 15:12:49 -0400
X-Gm-Features: AVVi8CeA13Cr9k3dAMPbx63TI549eEhRIe-kUTqMLQiFs4LU_tg92C_V9nOuHNM
Message-ID: <CAEjxPJ5d5wXTg+KaFaX+MpUuTc0EZ48Ww+zpBKw35a2waGnQ8A@mail.gmail.com>
Subject: Re: [PATCH 5/6 v3] libsepol: Add overflow checks to strs_* family of functions
To: James Carter <jwcart2@gmail.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 22, 2026 at 1:36=E2=80=AFPM James Carter <jwcart2@gmail.com> wr=
ote:
>
> The strs_* family of functions provide convient functions for

spelling

> handling an array of strings which is used in kernel_to_conf and
> kernel_to_cil. It uses the common idiom of "*=3D 2" to grow the
> array without any checks for overflow. There is also the function
> strs_add_at_index() which can cause multiple iterations of the
> "*=3D 2" idiom.
>
> Use the __builtin_mul_overflow() function that will do the
> multiplication while checking for overflow.
>
> In addition, the function strs_len_items() adds up the lengths
> of all the strings in the array which can overflow.
>
> Use the __builtin_add_overflow() function that will do the addition
> while checking for overflow.
>
> Signed-off-by: James Carter <jwcart2@gmail.com>
> ---
> v3: Previously in patch 0004
>     Use __builtin_mul_overflow() family of functions
>     Just check for overflow and don't set a maximum number of strings
>     All check for addition overflow using __builtin_add_overflow()
>
>  libsepol/src/kernel_to_common.c | 20 ++++++++++++++++----
>  libsepol/src/kernel_to_conf.c   | 10 +++++++++-
>  2 files changed, 25 insertions(+), 5 deletions(-)
>
> diff --git a/libsepol/src/kernel_to_common.c b/libsepol/src/kernel_to_com=
mon.c
> index adb7b661..bcd13c9a 100644
> --- a/libsepol/src/kernel_to_common.c
> +++ b/libsepol/src/kernel_to_common.c
> @@ -117,7 +117,10 @@ int strs_add(struct strs *strs, char *s)
>         if (strs->num + 1 > strs->size) {
>                 char **new;
>                 size_t i =3D strs->size;
> -               strs->size *=3D 2;
> +               if (__builtin_mul_overflow(strs->size, 2, &strs->size)) {
> +                       ERR(NULL, "Overflow");
> +                       return -1;
> +               }

Don't think it matters currently but you update strs->size here before
the reallocarray and therefore
later error paths can return with inconsistent (size, list) pairs.
Would be safer to compute the new
size to a temporary and only update strs->size if the reallocarray() succee=
ded.

>                 new =3D reallocarray(strs->list, strs->size, sizeof(char =
*));
>                 if (!new) {
>                         ERR(NULL, "Out of memory");
> @@ -173,7 +176,11 @@ int strs_add_at_index(struct strs *strs, char *s, si=
ze_t index)
>                 char **new;
>                 size_t i =3D strs->size;
>                 while (index >=3D strs->size) {
> -                       strs->size *=3D 2;
> +                       if (__builtin_mul_overflow(strs->size, 2,
> +                                                  &strs->size)) {
> +                               ERR(NULL, "Overflow");
> +                               return -1;
> +                       }

Same pattern here.

>                 }
>                 new =3D reallocarray(strs->list, strs->size, sizeof(char =
*));
>                 if (!new) {
> @@ -229,7 +236,9 @@ size_t strs_len_items(const struct strs *strs)
>         for (i =3D 0; i < strs->num; i++) {
>                 if (!strs->list[i])
>                         continue;
> -               len +=3D strlen(strs->list[i]);
> +               if (__builtin_add_overflow(len, strlen(strs->list[i]), &l=
en)) {
> +                       return SIZE_MAX;
> +               }
>         }
>
>         return len;
> @@ -248,7 +257,10 @@ char *strs_to_str(const struct strs *strs)
>         }
>
>         /* strs->num added because either ' ' or '\0' follows each item *=
/
> -       len =3D strs_len_items(strs) + strs->num;
> +       if (__builtin_add_overflow(strs_len_items(strs), strs->num, &len)=
) {
> +               ERR(NULL, "Overflow");
> +               goto exit;
> +       }
>         str =3D malloc(len);
>         if (!str) {
>                 ERR(NULL, "Out of memory");
> diff --git a/libsepol/src/kernel_to_conf.c b/libsepol/src/kernel_to_conf.=
c
> index 3e6bcb33..9bfe5b38 100644
> --- a/libsepol/src/kernel_to_conf.c
> +++ b/libsepol/src/kernel_to_conf.c
> @@ -1663,7 +1663,15 @@ static char *attr_strs_to_str(struct strs *strs)
>         }
>
>         /* 2*strs->num - 1 because ", " follows all but last attr (follow=
ed by '\0') */
> -       len =3D strs_len_items(strs) + 2 * strs->num - 1;
> +       if (__builtin_mul_overflow(strs->num, 2, &len)) {
> +               ERR(NULL, "Overflow");
> +               goto exit;
> +       }
> +       len -=3D 1;
> +       if (__builtin_add_overflow(len, strs_len_items(strs), &len)) {
> +               ERR(NULL, "Overflow");
> +               goto exit;
> +       }
>         str =3D malloc(len);
>         if (!str) {
>                 ERR(NULL, "Out of memory");
> --
> 2.54.0
>
