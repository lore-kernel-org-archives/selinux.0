Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eSp5ZKJg"
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD60BBD
	for <selinux@vger.kernel.org>; Mon, 11 Dec 2023 10:48:34 -0800 (PST)
Received: by mail-lf1-x133.google.com with SMTP id 2adb3069b0e04-50bf8843a6fso4783831e87.0
        for <selinux@vger.kernel.org>; Mon, 11 Dec 2023 10:48:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702320513; x=1702925313; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ey7ngf768ddPQSyW/uVJ8cuZWt6jcazcaNz9eDAN+KQ=;
        b=eSp5ZKJgQUAxmCn0MHSAQtWc+A7A6d1bEbjC7rR9+Xp9HVusEWIsKIUtEw0ff+EWdd
         +knjrqlEFhihbXX0L2PQkcKeKXJoxhdpGHic4zXAnrMCE0n+IDWoJL2KB2kF7AsC4U7q
         6s8ho+txxSY7rA7GipIgTBTRRp0S4jvbcavnM7qgrA1XUVIXAa5k5UTw9gcouAyX2i3H
         0/CMQAl4VuAsnmDvU4vkSxq3wEFzsI3qnFED7dP2UKNhfP0VZOxdVt5g2VvjXooIfzP9
         wL+ta4LsALcniPidvOj2ZxXorYihy701erDGIY01v/SCE/IaV6+A0LmPOiudijO2D4Cr
         nDEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702320513; x=1702925313;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ey7ngf768ddPQSyW/uVJ8cuZWt6jcazcaNz9eDAN+KQ=;
        b=A22DhBG2e1GWmwTN+OXv1Whr66kjChgmLtwFONv3E5PNUqURpujjnE9P1QdyW12yqU
         bPmIh/V+ZfQ7ZH1wEgRblvnsxkL1fzbKjuF95nVMyzrGo8imfnfETLfsinhje5J+oKyv
         /8QewSzi8Bh2Br+2yhmmdbR3puYvqiVcP7XTFtWq2zAjq3hzkAahAEh/hlF9EPVoxEvt
         qd48fIlofFHPZWm4vasbcGOUxV9VnHicycaf7PjYYJHZbfgRCQkqJqrZzIwpUoojtX0h
         2DHpHnmmhodPntxQsrZ8ALq+NkWfraqt+BYmLhYHyLYQcRC/KPRxqetfQm5+LB0xVPCt
         kbqg==
X-Gm-Message-State: AOJu0YyIkJoEmCdO2V68ZGgkV14wAd/+UdHqCH9Nlqv0RTRPxzEuTBx1
	gam/6PPYRVnVO9XOzuh9A/JhgeQvTJeYZkspPAQ=
X-Google-Smtp-Source: AGHT+IFaBS0YA+ktzFNiXrXshVsqxzNBvop4WT9KNUD1dNKYTsfmcLEtmCJQnKHJOMeoHPg76FxlB8OKKMzvqw7zWo4=
X-Received: by 2002:a05:6512:2246:b0:50b:f52b:e337 with SMTP id
 i6-20020a056512224600b0050bf52be337mr3492303lfu.1.1702320512745; Mon, 11 Dec
 2023 10:48:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231211145544.125635-1-cgzones@googlemail.com>
In-Reply-To: <20231211145544.125635-1-cgzones@googlemail.com>
From: James Carter <jwcart2@gmail.com>
Date: Mon, 11 Dec 2023 13:48:21 -0500
Message-ID: <CAP+JOzS9u-M2jRkUV0kTQeh-wLuz1YxANbD9iEFWA1WNxLnaRw@mail.gmail.com>
Subject: Re: [PATCH] libsepol: validate empty common classes in scope indices
To: =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 11, 2023 at 9:55=E2=80=AFAM Christian G=C3=B6ttsche
<cgzones@googlemail.com> wrote:
>
> Validate no common classes inside scope indices are defined.
>
> Reported-by: oss-fuzz (issue 64849)
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>

Acked-by: James Carter <jwcart2@gmail.com>

> ---
> This probably also resolves issue 64854, which I could not reproduce
> locally.
>
> Supersedes https://patchwork.kernel.org/project/selinux/patch/20231208151=
831.48343-1-cgzones@googlemail.com/
> ---
>  libsepol/src/policydb_validate.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/libsepol/src/policydb_validate.c b/libsepol/src/policydb_val=
idate.c
> index bd8e9f8f..d86f885e 100644
> --- a/libsepol/src/policydb_validate.c
> +++ b/libsepol/src/policydb_validate.c
> @@ -1344,6 +1344,8 @@ bad:
>
>  static int validate_scope_index(sepol_handle_t *handle, const scope_inde=
x_t *scope_index, validate_t flavors[])
>  {
> +       if (!ebitmap_is_empty(&scope_index->scope[SYM_COMMONS]))
> +               goto bad;
>         if (validate_ebitmap(&scope_index->p_classes_scope, &flavors[SYM_=
CLASSES]))
>                 goto bad;
>         if (validate_ebitmap(&scope_index->p_roles_scope, &flavors[SYM_RO=
LES]))
> --
> 2.43.0
>
>
