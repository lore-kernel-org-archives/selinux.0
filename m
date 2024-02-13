Received: from mail-vs1-f53.google.com (mail-vs1-f53.google.com [209.85.217.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B3C760866
	for <selinux@vger.kernel.org>; Tue, 13 Feb 2024 20:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707856556; cv=none; b=KNywnrLMRTuKSioxKfwk5WEVwxuTkBPCj8UUFXsx/dVo7eDiU/e/dYiU/3eDY5REQI0YyN4/hRhVZDxw3VwLrdmoTNjFDJE4+78MeFH7fNFboRfFDFkUHSrMjVNusAXxHEAYE0fXFyrgK/fPt7rucpL0uPmWe2oDED1aLbQmak8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707856556; c=relaxed/simple;
	bh=sOjC9NViWIHVu8aODFyy4kqGb8d8X+jhJwdDBGq9X6w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Y2zjLU1d5fvk2OYzFh/9/UO+dxq45CVGzGB9lyoYmfdF8gn4EHd9ktzRrCvWu5Z7m9A2e5gRcuRhJjIKsNnWB1ZUFfrX/DcIMn61bKie0QdL1t1sWKqjdAbJd9oRCJTcOhDr+HmPmFJvr2NEWPsv5IaUJe29VUuF7354Wckk2bg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N+TmGz9I; arc=none smtp.client-ip=209.85.217.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N+TmGz9I"
Received: by mail-vs1-f53.google.com with SMTP id ada2fe7eead31-46d60c75683so532464137.1
        for <selinux@vger.kernel.org>; Tue, 13 Feb 2024 12:35:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707856554; x=1708461354; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VR/MWR3O+3LaX3h6l2VeTzTML8tz2hdQZvAQ9EgHHAU=;
        b=N+TmGz9It44fecM5NORcD0ZrCBxMlqY2QyR0HxcZsZBwM+djhMsMT9v6gXGzRXcD99
         0h8ZZxoG2NsbjC9ZVTuB2Hes1kQOLP25sdPc06L4dQiQ4H9XpCswIzv8hTvFPHXmMraW
         MNHZIIB7SfICB+HZTRPgk0i+z1gzSjBVZOcoiNGxq/G1Ri2xSdCOkKxYEZXfIj5Bp6qu
         KJkgD78FkM6UlBvUbbHEp/lIghd90bkYBZcApvWTLrBMLhm02UYAt6/bLncmYSUeJLwM
         +w2d0iBRAqVEJSwl4VsymFlNXP8AcUZ2sS7RRwIT7vcF0d1fnG58OMdfQ5gjn3xScT5J
         CV7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707856554; x=1708461354;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VR/MWR3O+3LaX3h6l2VeTzTML8tz2hdQZvAQ9EgHHAU=;
        b=GDlFgF/aOt7rT+H5J7c8hP4QbNMuVyUxX8XGH7dQjITjwL2CoUS5w5F4yUKAaBK2lE
         d1JVGEGO1poU2esXYAAulUHyvosbiHFHHz8iVR2FPN+WbIMx4aBWte1w5I0j2wc8e/Qg
         2w29Hwy6kbkLEFfqPCco+r8XFwM6/wPs3IcA/awHKuA3ZHPSRaWPLwWzPwB4an4e688c
         A9gIJj0CFuGPt5sSx7RzCrkOHgorofVZ853teDd06z9wPpgxFQejGSun3Ide16HGDmo4
         30eUvqaqhNtoQ0fsb2/Q5BsdaTNL9WVaohhzXw0Z/XkeshKy5xlpoo1VIwQHXqJppfIY
         icng==
X-Gm-Message-State: AOJu0YxSYep1trW8gvgXFvC9XU3Bt8clPfuN3okC+EbZsg6NGYTA9sN1
	Bl/DB6WuLJ88cCNv++pOkmu3kl3osE1vAM4x+8g97wQiwXcjvuBBC+LGHkQXfWzIjD/tnYFnYCW
	qvfCCLpZH8asZrvRSDtG8OMDDQ+A=
X-Google-Smtp-Source: AGHT+IH8Jq4u1GrxqA5nkA+4Ag9QKEw1QLDZg0h7z4bAn1xZusFNIWOqGfdQMQNhGexD3ABAZCZm8cl2fgjpqNlAQ1Y=
X-Received: by 2002:a05:6102:3b93:b0:46d:6b68:da3e with SMTP id
 z19-20020a0561023b9300b0046d6b68da3emr707722vsu.10.1707856554371; Tue, 13 Feb
 2024 12:35:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240122135507.63506-1-cgzones@googlemail.com> <20240122135507.63506-5-cgzones@googlemail.com>
In-Reply-To: <20240122135507.63506-5-cgzones@googlemail.com>
From: James Carter <jwcart2@gmail.com>
Date: Tue, 13 Feb 2024 15:35:43 -0500
Message-ID: <CAP+JOzTOeH8uB2V9+zt1i44QeCg7VaqWM8eHiBtzuunLxgaqew@mail.gmail.com>
Subject: Re: [PATCH 05/15] checkpolicy: check allocation and free memory on
 error at type definition
To: =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 22, 2024 at 9:37=E2=80=AFAM Christian G=C3=B6ttsche
<cgzones@googlemail.com> wrote:
>
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>

Acked-by: James Carter <jwcart2@gmail.com>

> ---
>  checkpolicy/policy_define.c | 23 +++++++++++++++++------
>  1 file changed, 17 insertions(+), 6 deletions(-)
>
> diff --git a/checkpolicy/policy_define.c b/checkpolicy/policy_define.c
> index 053156df..ec19da9d 100644
> --- a/checkpolicy/policy_define.c
> +++ b/checkpolicy/policy_define.c
> @@ -1399,7 +1399,7 @@ int define_typeattribute(void)
>         return 0;
>  }
>
> -static int define_typebounds_helper(char *bounds_id, char *type_id)
> +static int define_typebounds_helper(const char *bounds_id, const char *t=
ype_id)
>  {
>         type_datum_t *bounds, *type;
>
> @@ -1482,15 +1482,26 @@ int define_type(int alias)
>                  * old name based hierarchy.
>                  */
>                 if ((id =3D queue_remove(id_queue))) {
> -                       char *bounds, *delim;
> +                       const char *delim;
> +
> +                       if ((delim =3D strrchr(id, '.'))) {
> +                               int ret;
> +                               char *bounds =3D strdup(id);
> +                               if (!bounds) {
> +                                       yyerror("out of memory");
> +                                       free(id);
> +                                       return -1;
> +                               }
>
> -                       if ((delim =3D strrchr(id, '.'))
> -                           && (bounds =3D strdup(id))) {
>                                 bounds[(size_t)(delim - id)] =3D '\0';
>
> -                               if (define_typebounds_helper(bounds, id))
> -                                       return -1;
> +                               ret =3D define_typebounds_helper(bounds, =
id);
>                                 free(bounds);
> +                               if (ret) {
> +                                       free(id);
> +                                       return -1;
> +                               }
> +
>                         }
>                         free(id);
>                 }
> --
> 2.43.0
>
>
