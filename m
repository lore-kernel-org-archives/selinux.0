Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAECF81ACD
	for <selinux@vger.kernel.org>; Wed, 17 Jun 2026 19:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781725411; cv=pass; b=SgPX4LWJD3ZauZ1xCTkjQJQt3D6m81V5OKzbB+MCr2WYtYKD3ULMiMPl0zcIDCZUL0mcZP/sXAppZM1iRJvx7zDNCqzshL9UXFJv3A7vv+oxnLOvsXX/u37OTUScTGpWtybFQ0KDod+PKrWUHSgnlBnz6xK7lIsSOl4d7BWJ7E0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781725411; c=relaxed/simple;
	bh=oGBnAqanEhs5Vwc4NKk6MfJgRWgX28v8XLy7QB1wXzM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=e09dQiOcV4WjPC8+k6qGyHNqGKlP2n1u3Ois4Nl+mAdedWY1lIWOS+JLox7lf4qlKGdp62pmTqApx/NiWepKeQivJNHmaEIOVKPTa4QXthlc7K0zExzy+n5LtkUryjed3tiJZgZ4s4yJ7y9s1vS+6N04BuA2EevZ+cmNf5X6UO4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GO4gzldu; arc=pass smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GO4gzldu"
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-396aacc5bcfso2128491fa.3
        for <selinux@vger.kernel.org>; Wed, 17 Jun 2026 12:43:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781725408; cv=none;
        d=google.com; s=arc-20240605;
        b=bWvowAXFUwwGWy+Zo8apuJsYq9vUqsoh1+nw2yJfF89JmZVwru8XQwWVEsvT2T+ofP
         GiSgicx19EbpEJxqhRXdOEywAnz1ffVWOiWP/052eqzRa1cimfhpnu+v/8XJeXnksxB5
         3GUqO9n8SrNIXXLZmcIHS3JqzNCCYBrDjHf89e3kPL5XixqlVjkTfN9rC1oq87sV5xuK
         8TYCY6VIl3MH0LWbvAuu3Jvzp7Hcvxzsmav9CyD/svTX8QFjzmK2dx+VIh4gMlK7bBbA
         mnM6k/qI2F6A5Y6xTVhF+OCJIYgANx5qwMI+Nlpwe/kVbXz+U/hdquPRUQqqBybz5KTY
         ef0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=nWA+2QTHpeAGOvWRVkoGbQLrGlm84Cp3023u4ptbFQA=;
        fh=l2l+BKIhep14i9a5yxIzwDvgNRHYkyJlbYDDp8LiW6o=;
        b=IQMC+eBf8xLUjArbyL/k4ceuctJX2dSSPqkIf32MaZw1LxaeOyaQhMLUBtJYgtLf51
         aeU1ChFs5NYwJvN72FVkDYwzCHOEVSHervMLeQHKLJH1HN+o7QapUET4dNx1xNsd7xqt
         oVySi7JiAwAryK2xTMsiF7G2w2JGAxiUeeVm5Pgsu0AeS16E2dBAv76aZ5/Yb40e+zJd
         aCbbKUF96druFtnXFv86P8hfhTv5xvih6Yi5Yn83+JQxEbhOp8HqlKVWV4vbpVqBGhrK
         oDa2uqir4uCs3TnmeUeqL86AZrJtdG76Kcryw/+ROx9c+RIC55xLqhdqD9eXkPb0qz+L
         IsSw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781725408; x=1782330208; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nWA+2QTHpeAGOvWRVkoGbQLrGlm84Cp3023u4ptbFQA=;
        b=GO4gzlduhqiV/JfECTojb3lHnWy3FBIBNYWoHsdKLuqBFL8do3za3oEkD5dg3kI8hh
         QEEhQPbvJqRzOgL89sbPbZO04d9aKIugVl+8SEn74HDiexpBiOZsF4m/cW0KviVBz3lA
         tjDGWffyFzXd8IJ8iZ02eOwSjHatfvKuPMX1IqjauxcDpGkGHJdDgKZjBDUZD/p6euAH
         bcQ/bLSZwF+f2D9iDnTQl6cz2yFeE4vJQFyH7GzNf1fwTCHWJyjaWuXItl8XW/ImYdLi
         IWgJ31HyllaV0KyFSZVle0NyEK/D+L63IfY135hRY7869/495Fm9TZ6VO85M4QZyKPSk
         gM0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781725408; x=1782330208;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=nWA+2QTHpeAGOvWRVkoGbQLrGlm84Cp3023u4ptbFQA=;
        b=ZNw4cS/nMJD746Y91Se2CjUtlAXbHv4ci72e+lCwes03S9p0jwRAmiDZ1Ca4ci0dff
         vM3fvNF6MvlkddJWruLRz/+m6+Zn4d5m5MJsFU4rkvCJ3Qua0BaDPkPZ1Q3Hp9IoYT6n
         h2wUsCMXvpR6DJv04V1EszD1UH1iqG7bAoTuYMLe5uV97Kjpb9h3YFucN1dzkJcPp7ZX
         zth6o9yMdm4U0yEpF5cjI02cRSVNl31GXSsfudwfHBGz66tFr9zrWysfC+qQXvC0fv4i
         nmG3ylJfN/Q8fyuA3yRICuMcpKR+livUCdPnN+NJLe5KEbgvGfqB2vadSMD8QSqrjN/e
         CDVA==
X-Gm-Message-State: AOJu0YzY/AXqaqJlgzvbFPD0tfKTJC1Zoz1PJZu/6yCNbV6nh/a5g5Qa
	972lmcZYudUUdDnjbH5+Jlh6gG//UhXsXmJgRjbgMPTYmBD3GtCrR5XDHOg3AQ/45ypCLhNrvp5
	xMGJZaYWUbjmgVraAUdziU+xbGXCJr5vuvQ==
X-Gm-Gg: AfdE7clh4jXSdTlWJBkw5JszPrp8yWacMKJrhdLkt7KoyePw2U05UrkfVTL15cYeOsI
	JfgjHwCxEWg72RnkamYSUvn1LFKgPSmXibq/qM8Q0rZU2hIml3Kt/UoISXA+gZE73TEdCYqcrX2
	cxA0dUhPO36PPpO6B8cIFZi5Af0xP8hZiB7Gn8pVe9DyvtnBfDwmxvFfrXwRMavRCd5Bn6acGa2
	uRz4n1hPJwXILSTWrNgrp89hFA33/ZEWhHsJN+bW5w4ACMeFU1mYYz+deDudCHPzZ1klQ==
X-Received: by 2002:a2e:8f87:0:b0:395:2467:9e74 with SMTP id
 38308e7fff4ca-39969b98aaamr13301761fa.14.1781725407674; Wed, 17 Jun 2026
 12:43:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260617185543.91749-1-jwcart2@gmail.com> <20260617185543.91749-4-jwcart2@gmail.com>
In-Reply-To: <20260617185543.91749-4-jwcart2@gmail.com>
From: James Carter <jwcart2@gmail.com>
Date: Wed, 17 Jun 2026 15:43:16 -0400
X-Gm-Features: AVVi8CcnTZOSoz0yvaSyOi46fHVHWFE-5kDX9cFyxewElhysQARvk36-df0pBps
Message-ID: <CAP+JOzR-8G8uGfjeiT4pKb4A4GhVvafTvewTySOz0LrYMtumiw@mail.gmail.com>
Subject: Re: [PATCH 4/4] libsepol: Add checks when growing lists to prevent wrapping
To: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 17, 2026 at 2:56=E2=80=AFPM James Carter <jwcart2@gmail.com> wr=
ote:
>
> A common idiom to grow a list or buffer is to use "len *=3D 2", but
> it is possible for the multiplication to wrap on overflow. This
> would result in the new len being smaller than the old len and
> could lead to problems.
>
> Add checks to prevent doing the multiplication if it would wrap.
> The multiplication can always be done if len <=3D MAX / 2 and
> should not be done if len > MAX / 2.
>
> Signed-off-by: James Carter <jwcart2@gmail.com>
> ---
>  libsepol/src/kernel_to_common.c | 16 ++++++++++++++++
>  libsepol/src/module_to_cil.c    | 12 ++++++++++--
>  2 files changed, 26 insertions(+), 2 deletions(-)
>
> diff --git a/libsepol/src/kernel_to_common.c b/libsepol/src/kernel_to_com=
mon.c
> index adb7b661..9ffd452b 100644
> --- a/libsepol/src/kernel_to_common.c
> +++ b/libsepol/src/kernel_to_common.c
> @@ -22,6 +22,8 @@
>  #include "private.h"
>  #include "kernel_to_common.h"
>
> +#define MAX_NUM_STRS 1UL << 24
> +
>  void sepol_indent(FILE *out, int indent)
>  {
>         if (fprintf(out, "%*s", indent * 4, "") < 0) {
> @@ -117,7 +119,14 @@ int strs_add(struct strs *strs, char *s)
>         if (strs->num + 1 > strs->size) {
>                 char **new;
>                 size_t i =3D strs->size;
> +               if (strs->size =3D=3D MAX_NUM_STRS) {
> +                       ERR(NULL, "Too many strings");
> +                       return -1;
> +               }
>                 strs->size *=3D 2;
> +               if (strs->size > MAX_NUM_STRS) {
> +                       strs->size =3D MAX_NUM_STRS;
> +               }
>                 new =3D reallocarray(strs->list, strs->size, sizeof(char =
*));
>                 if (!new) {
>                         ERR(NULL, "Out of memory");
> @@ -169,12 +178,19 @@ char *strs_remove_last(struct strs *strs)
>
>  int strs_add_at_index(struct strs *strs, char *s, size_t index)
>  {
> +       if (index >=3D MAX_NUM_STRS) {
> +               ERR(NULL, "Index too large");
> +               return -1;
> +       }
>         if (index >=3D strs->size) {
>                 char **new;
>                 size_t i =3D strs->size;
>                 while (index >=3D strs->size) {
>                         strs->size *=3D 2;
>                 }
> +               if (strs->size > MAX_NUM_STRS) {
> +                       strs->size =3D MAX_NUM_STRS;
> +               }
>                 new =3D reallocarray(strs->list, strs->size, sizeof(char =
*));
>                 if (!new) {
>                         ERR(NULL, "Out of memory");

I just realized that I need to add a check in strs_init() as well.
Standby for v2.
Jim


> diff --git a/libsepol/src/module_to_cil.c b/libsepol/src/module_to_cil.c
> index 00db3d7f..ae7d700e 100644
> --- a/libsepol/src/module_to_cil.c
> +++ b/libsepol/src/module_to_cil.c
> @@ -447,13 +447,16 @@ static int stack_push(struct stack *stack, void *pt=
r)
>         void *new_stack;
>
>         if (stack->pos + 1 =3D=3D stack->size) {
> -               new_stack =3D reallocarray(stack->stack, stack->size * 2,
> +               if (stack->size > INT_MAX / 2) {
> +                       goto exit;
> +               }
> +               stack->size *=3D 2;
> +               new_stack =3D reallocarray(stack->stack, stack->size,
>                                          sizeof(*stack->stack));
>                 if (new_stack =3D=3D NULL) {
>                         goto exit;
>                 }
>                 stack->stack =3D new_stack;
> -               stack->size *=3D 2;
>         }
>
>         stack->pos++;
> @@ -4595,6 +4598,11 @@ static int fp_to_buffer(FILE *fp, char **data, siz=
e_t *data_len)
>         while ((read_len =3D fread(d + d_len, 1, max_len - d_len, fp)) > =
0) {
>                 d_len +=3D read_len;
>                 if (d_len =3D=3D max_len) {
> +                       if (max_len > SIZE_MAX / 2) {
> +                               ERR(NULL, "Buffer too large");
> +                               rc =3D -1;
> +                               goto exit;
> +                       }
>                         max_len *=3D 2;
>                         d_tmp =3D realloc(d, max_len);
>                         if (d_tmp =3D=3D NULL) {
> --
> 2.54.0
>
