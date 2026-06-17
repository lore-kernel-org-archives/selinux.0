Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E76AE385D98
	for <selinux@vger.kernel.org>; Wed, 17 Jun 2026 20:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781727722; cv=pass; b=XQH3/WCR3sHyvdbrnalvvaOGauc7vBQtiIVSNWHfYpXckcXXscdCDAEWvtIm/VD0/9ngQNcK2QIGp+Wc+DPd6GJOx1gSNdJdMKskhZp8nS/disbfwm6CEk5Y57NDhPi2UorfZx4jRxo4QoBmubQH6kZG9IiOscnLB9aOr2aWeLY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781727722; c=relaxed/simple;
	bh=kyR2zMD3ID37H74Cxfg2td1z5bXJ5ZIRYYLAWFgAZ4A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CLlxn+ABtvKknecuXPlt1hIKvmv8yjjVYOYMvOwpfMgw3kDBypnUaAZkgele0JbuUwJCUe9f/aMlFTOzLtIUVUCR94tlrXfV26tXKksjrDvpIY05M+RyE5H+ToFU/aMD60476rIvcKd8Y5lXavkaaatyAoxGn1ZUkeI0DiXX14Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nJccdFZa; arc=pass smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nJccdFZa"
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-c88b8fe9059so109401a12.3
        for <selinux@vger.kernel.org>; Wed, 17 Jun 2026 13:22:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781727720; cv=none;
        d=google.com; s=arc-20240605;
        b=LNkPwUUo92/veh2DMuVmetnF75UINJGDBeWpCWHr2OyZ3/5szGaqzy8hdF33Yf6LtR
         CqtoNQ+B2zxSEhst6A9IZNeBfEIO8Ecc8v8KaMvpFA3ANLO3ZQ8yGS+gpr6SqwcVszfS
         3LilddKq8VJiVeyGj7df1p9hF1p5siNHmdiQpVjMrRHHknTWQXnyPVCPyG8fYQ6lXqDa
         jYPQrRY5kcwDsDQZrAKh/C5jfTpLnSFkwtcfyxPzaGfsm3gPin7LbUffbUGlrjYRvPuC
         cPlkwPHf1QOWMXIhq2GDfor2I4uuIjuuAiyoV36tBcaMTTOOfYoe9mboxEV9TLPlg6px
         y/qA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=XwAzVolZm1sRjgdl+z2zBF9skRSeahFpU1KT4fCxNO4=;
        fh=FsXghBnyoYbEc42Idnie0oh5A6i9FUng5ntOLhqXIRs=;
        b=RZUWmvZ7v4maTKZYpxD8U09kdLIM95JPhxgv98IZ/YDqzWEH0rZC2UPHbMo3nAhz28
         MuigoXXYDnFw0KXRaH6UxCeVR84QpensOubpMGslCm60OMhqy+Fa8nheEe0L0ZlfjGgb
         3c4ZJ8pdJztv8yLdC8rQ1STcKslFnGswuw1/67xRD/nVFESBVh/mbfRHFAf+Jscpwkxg
         IdF5eqAkFqB1Qh7+RPVPHAqR6XV0CJQDz6l6LNp/DWX/wGdaq2vFdYA/pE/nSoI+dmbs
         u1jI+LuNQ1ubL9ASIt4aRJEdhp4hqufcvxuN5vGArKYsR+wnBNEIVQudnOhVr/3RaNls
         c8Pw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781727720; x=1782332520; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XwAzVolZm1sRjgdl+z2zBF9skRSeahFpU1KT4fCxNO4=;
        b=nJccdFZaLNrkktjaas7sFxDWYQEQoQ0aVQs/8rZc8CZZ9I77xAmU4FpZialgvQaTdV
         Urx1Qc6B1HV4vKACRpmz5wU9QvdSa7Yn4JYJ8sh/kfnU0obVJfJEIsvBTrIzDQ3SAsSV
         mog4hCGmCqcHcRbM8E06OT+fNqRR+f9lFesCOVpeSTnoeh2jTcifHA0Zgw4eeukQUKXo
         HSmasMY+qyuJSiBQPUhJseuXPow/F03bBsLAxTQXHUm6+/uPVuWQ3HCslH7ZdBUEhqPH
         cfApgtrhM3FKWgGFM40ito2qNTuNkFiWYRx+5ssdMB2NSJ6lPdK7rLR2G7Hs/XiKxQxl
         WCHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781727720; x=1782332520;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=XwAzVolZm1sRjgdl+z2zBF9skRSeahFpU1KT4fCxNO4=;
        b=OqS88cZExKU+VOn68Ts2nR3cCiz1YYJzlo8zR4KJ4/C4OSKcDm8XyyuDA/1nBOzMSL
         I95G5YpjLuYazG3P4ZIDv0oE1cSfmdxgCdjv7lQvsRVKRyxsM9l8rIAcs7KwndiOOE//
         5pg3vqvIK48Pz3LTO+lImv7Lxvz6JdnzkY39V0JG8b74p7fLCMEN8vaJcp4+TSqTDJDn
         HdJSnAT4KINoUz5yEDoXyjAt8+apNjxQHIwPvjbpUMhAJkM9a39XHKq4s6yoNM95cmzo
         QElXgdAWc376CMHXXGXi6xz1VNKORjWpZsOTrrDkiBeZTTUisYkKlSJe4Szr18lIxhnb
         1u9g==
X-Gm-Message-State: AOJu0Yw8MEfpblWfwpS9irWaYzQokZMeuLUleDwRt5BA7MeAxIb4Sv21
	ha56DTSltoiSbYjhalGcsADspNPpvuscUogdKAaZK88IOTCUaNG8Zy4QYj8oJhpH1Vefb1VV5rp
	GjeDAk0CXoJsFYWDlXn8NsXKs/JLis1BOCA==
X-Gm-Gg: Acq92OFTWrnRYiSVNDRNvUkOJIupSZTpgQyKEzH8HrFpAVNhX79SThkDyOwcvyg33JB
	e8c7kkZZGPFJ2aNK3hLbFXPFW7izlEZ9HzsrXwsDbEqY+QmQh62T6n0DGitaE//b8o7dCCplUWs
	52JcQS/gRkX/ALoMOUk5RTODfZeTnF+9M6ufJDdXQ/dsH/zoXGmFRjnC5L9GZawlvj7W/7YWk74
	q41/GksR+j7okVAN/3zFQ3KI0kqh76e6hEttJDZhF11/PXChorweVacBS+GUuFY4jqtWz0q
X-Received: by 2002:a05:6a20:7f92:b0:3b4:6026:6c78 with SMTP id
 adf61e73a8af0-3b8bc86d61bmr5382574637.11.1781727720160; Wed, 17 Jun 2026
 13:22:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260617195645.96604-1-jwcart2@gmail.com> <20260617195645.96604-3-jwcart2@gmail.com>
In-Reply-To: <20260617195645.96604-3-jwcart2@gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Wed, 17 Jun 2026 16:21:48 -0400
X-Gm-Features: AVVi8CczoPf215kmLUN7uQMrq2OTht_RxjH-PqKoP4eri2SLUKUrhN1OuLbiwpk
Message-ID: <CAEjxPJ4R0Z7d_mOJ=cYr7R+hERc6d_2_JfDSA41tKaXFaVeFMQ@mail.gmail.com>
Subject: Re: [PATCH 3/4 v2] libsepol/cil: Add checks when growing lists to
 prevent wrapping
To: James Carter <jwcart2@gmail.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 17, 2026 at 3:59=E2=80=AFPM James Carter <jwcart2@gmail.com> wr=
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
>  libsepol/cil/src/cil_resolve_ast.c |  7 +++++++
>  libsepol/cil/src/cil_stack.c       |  4 ++++
>  libsepol/cil/src/cil_verify.c      | 28 ++++++++++++++++++++++++++++
>  3 files changed, 39 insertions(+)
>
> diff --git a/libsepol/cil/src/cil_stack.c b/libsepol/cil/src/cil_stack.c
> index d9c7b0c0..c80ed7ad 100644
> --- a/libsepol/cil/src/cil_stack.c
> +++ b/libsepol/cil/src/cil_stack.c
> @@ -77,6 +77,10 @@ void cil_stack_push(struct cil_stack *stack, enum cil_=
flavor flavor, void *data)
>         stack->pos++;
>
>         if (stack->pos =3D=3D stack->size) {
> +               if (stack->size > INT_MAX / 2) {
> +                       cil_log(CIL_ERR, "Stack too large\n");
> +                       exit(1);
> +               }
>                 stack->size *=3D 2;
>                 stack->stack =3D cil_realloc(stack->stack,
>                                            sizeof(*stack->stack) * stack-=
>size);

Can't this still overflow on the sizeof(*strack->stack)*stack->size calcula=
tion?
reallocarray() is good for this kind of thing.

> diff --git a/libsepol/cil/src/cil_verify.c b/libsepol/cil/src/cil_verify.=
c
> index eb732e44..ee90b0ce 100644
> --- a/libsepol/cil/src/cil_verify.c
> +++ b/libsepol/cil/src/cil_verify.c
> @@ -975,6 +975,13 @@ static int __cil_verify_user_pre_eval(struct cil_tre=
e_node *node)
>                         }
>
>                         if (steps =3D=3D limit) {
> +                               if (limit > INT_MAX / 2) {
> +                                       cil_log(CIL_ERR,
> +                                               "User bounds checking fai=
led "
> +                                               "to finish for user %s\n"=
,
> +                                               user->datum.name);
> +                                       goto exit;
> +                               }

Not sure about the error messages for all of these; they are overflow
conditions unrelated to the bounds checking.

> @@ -2112,6 +2133,13 @@ static int __cil_verify_classperms(struct cil_list=
 *classperms,
>         } else {
>                 steps++;
>                 if (steps > limit) {
> +                       if (limit > INT_MAX / 2) {

limit here is unsigned so UINT_MAX / 2 would match its type but no big
deal either way.

> +                               cil_log(CIL_ERR,
> +                                       "Class permission circular refere=
nce "
> +                                       "checking failed to finish for %s=
",
> +                                       cur->name);
> +                               goto exit;
> +                       }
>                         steps =3D 1;
>                         limit *=3D 2;
>                         orig =3D cur;
> --
> 2.54.0
>
>
