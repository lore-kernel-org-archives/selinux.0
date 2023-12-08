Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cgBHJDuT"
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDBCE1732
	for <selinux@vger.kernel.org>; Fri,  8 Dec 2023 12:02:34 -0800 (PST)
Received: by mail-lf1-x129.google.com with SMTP id 2adb3069b0e04-50be58a751cso2786717e87.2
        for <selinux@vger.kernel.org>; Fri, 08 Dec 2023 12:02:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702065753; x=1702670553; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8L2VMEnOh5P/HX++ojaiuXkZ4Ne5x4HpOHaEVnCAj0Y=;
        b=cgBHJDuTe+zta4vErIp5eRE8aoS72QMGxpEGHLIjUqXhiURmY6Ip5a99ASJ3G+bI9j
         PswI1q24cG7/zwi77iD/qMwbAEX7C+DCkUJDDVpYw7Xy9p3TM5iN172TAKnOLZUtqHrT
         A1FpudDo1ddJ4nEWTZe4nypRxzX/CGnEaFjq/ITX9jPavWbkj92HPpZOPXFsTL2gdX1r
         JGIo2zkGt1hTTGzzBVJHZ5XBUX5pxrpLxm8X27F+va8XVMsB/skFCj6OEThVWDSfFz9Y
         gW2TheKhQ6Eh75k2GptxgWC/vQbGvCQTdxOFWk0DOvcs0oWuvTnXRF1quCFkHnVN5Ubz
         sAEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702065753; x=1702670553;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8L2VMEnOh5P/HX++ojaiuXkZ4Ne5x4HpOHaEVnCAj0Y=;
        b=rGhk2dgpfweHGEagrF8PIrheqdGSEXaImONSov0gon2HzIf7GTVX+3X3rbLBJjoGng
         cPi9ASuFaVj5t4AmDI2B9FIii4HLm9ZtzF9ueeJC4Il4wZOykvCQRZPwdK1XGGPdLZsi
         fIUu2Wq5nkQICjeKYvU4Jye4SOYlePFs9I/Iaibd0INYt2PJsQ9U3/HcWijVMx3/Rkl5
         TafY0c6V+azBL+6fYc6DdPauuFciJokfYVdRXvS91Qhdg34yMj49PJF+mXtr1dkaR4IH
         3h26Q+Pyswrb2vcQGL8gAVVRqP9bjq8cm+SIcQX/Yc4NdxzbTh+tR2nl10YMuHdmFqpr
         vT+g==
X-Gm-Message-State: AOJu0Yxl2KXA836GrHFXagzHj1OtDDJC8GDbXkwpLt58Njp0uJ31tTa8
	Bs0WX3yc2Pl+7EuGPK748wfC51yCjnxxrXt3MinfMM5s
X-Google-Smtp-Source: AGHT+IEslEpRqSHlC94HhGH4Kz8vHRDDusyd42XC+es2IZXZ/lgnWoDYmw67zl/Qx+9BP3hx3p4N261suE7uIBaIuYw=
X-Received: by 2002:a05:6512:1ce:b0:50b:e573:b421 with SMTP id
 f14-20020a05651201ce00b0050be573b421mr183859lfp.129.1702065752698; Fri, 08
 Dec 2023 12:02:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231208151831.48343-1-cgzones@googlemail.com>
In-Reply-To: <20231208151831.48343-1-cgzones@googlemail.com>
From: James Carter <jwcart2@gmail.com>
Date: Fri, 8 Dec 2023 15:02:21 -0500
Message-ID: <CAP+JOzTCBjUjO1uUdN4-qb5Q3nBiodeOxr-L-_DkDoGX_-Dcvg@mail.gmail.com>
Subject: Re: [PATCH] libsepol: validate common classes in scope indices
To: =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 8, 2023 at 10:19=E2=80=AFAM Christian G=C3=B6ttsche
<cgzones@googlemail.com> wrote:
>
> Validate common classes inside scope indices similar to all other symbol
> table types.
>
> Reported-by: oss-fuzz (issue 64849)
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
> ---
> This probably also resolves issue 64854, which I could not reproduce
> locally.
> ---
>  libsepol/include/sepol/policydb/policydb.h | 1 +
>  libsepol/src/policydb_validate.c           | 2 ++
>  2 files changed, 3 insertions(+)
>
> diff --git a/libsepol/include/sepol/policydb/policydb.h b/libsepol/includ=
e/sepol/policydb/policydb.h
> index 6682069e..658b25d4 100644
> --- a/libsepol/include/sepol/policydb/policydb.h
> +++ b/libsepol/include/sepol/policydb/policydb.h
> @@ -430,6 +430,7 @@ typedef struct genfs {
>   * subtract one) into the global policydb->scope array. */
>  typedef struct scope_index {
>         ebitmap_t scope[SYM_NUM];
> +#define p_commons_scope scope[SYM_COMMONS]
>  #define p_classes_scope scope[SYM_CLASSES]
>  #define p_roles_scope scope[SYM_ROLES]
>  #define p_types_scope scope[SYM_TYPES]
> diff --git a/libsepol/src/policydb_validate.c b/libsepol/src/policydb_val=
idate.c
> index bd8e9f8f..4919f674 100644
> --- a/libsepol/src/policydb_validate.c
> +++ b/libsepol/src/policydb_validate.c
> @@ -1344,6 +1344,8 @@ bad:
>
>  static int validate_scope_index(sepol_handle_t *handle, const scope_inde=
x_t *scope_index, validate_t flavors[])
>  {
> +       if (validate_ebitmap(&scope_index->p_commons_scope, &flavors[SYM_=
COMMONS]))
> +               goto bad;

As far as I know, there will never be any commons in the scope index,
so it would be better to just check that it is empty.

Thanks,
Jim


>         if (validate_ebitmap(&scope_index->p_classes_scope, &flavors[SYM_=
CLASSES]))
>                 goto bad;
>         if (validate_ebitmap(&scope_index->p_roles_scope, &flavors[SYM_RO=
LES]))
> --
> 2.43.0
>
>
