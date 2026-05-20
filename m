Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 681BD3D9DBC
	for <selinux@vger.kernel.org>; Wed, 20 May 2026 15:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779291195; cv=pass; b=n26DISIz8VUcsjiNsjYYNyzGirkmvrk7pCJfTzkd0FimZUjebM98JiBsH1a2fcsXKGk10ZuLaL+x5b6wC9ZbiP6FdvdzvfBKHYtEoUXzadz5OBTv1ayzQ276XRV7qbGhJAargYrfWpsEKmzDS9zeSD3Drsh7VDmUDdfATwkATFw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779291195; c=relaxed/simple;
	bh=UNESf5caJ3hdYQEnLqGr0fCahBKVDoB0PEhNzXkGepU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YsfiL2yLWy3ZegTr10dhxXA/+slm7qrJymOTtXf0k9ySv0r4sOM7lxa+V1+4OaglB6yM7cNK5C44854fXaaR3KT7li+GgRlFj7mzcpy+b2iVHNxO0d5WIgS+tcFoCbp/yA2x1RZomW78CG0XIx5MyySnrb0q8L6ecv9KOHvbjm0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XW4xS8En; arc=pass smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XW4xS8En"
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-38e97e73234so45445581fa.1
        for <selinux@vger.kernel.org>; Wed, 20 May 2026 08:33:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779291193; cv=none;
        d=google.com; s=arc-20240605;
        b=N2gLBf0Vw4zNxJnCSppJebPXzGJG/3OapqvzKZGbdANNR9XhQWYFHQ5Zh3bCSIDHBh
         rEBwBnsnNshpndf9ikGxvsVNUwllx2tE+G078Q3DjzWh/c4uOmRulaPFsEMt8WVbVBmO
         EQOSAdI0Yj47Y8WRrTYP5mmJv2Zr5lwxdlVPKX/8aF4gE528qnC5VK5tT1vPADai01s9
         SGO2x6iTmC6rOup+aYKYmbsoirztZZCQ9LMpfKpwXFw2Vc47TQn3Bt5a4cjfYzRJ9Ouk
         z5YexUk25Y/njLpjfrpxV6VHZOwcvFeV9UbbCnKqJnd0T3yTQwujyzMfI7oLAxtNiK0X
         exLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=loPedkJWW5NsxZasmabpsVrzcNqsX8cLULapJHT/QGI=;
        fh=RcJrr7O3svp8K5gZfgCjK7Xv0tA8i0VIpUekoWsmIc8=;
        b=ItMyEwX4b7QtuOU3L+DmPe3Bpf0PdwOa//0h5OC1hDbotFR33l4+gekpLV4+dHOjbS
         TuKmlgRREew0/sDAOCA6fUylDfSvpUW3t4DcNCIWELeQcEfWHuE6eWupzc9k9itQhdYs
         wlKE1FAOtTk3fHT4onuhRJ7pIVvhxgOil/Ek06+Imz5OF7lJrUZarBA4MID7QA5SwBYi
         hvuqgLF2dDeyZkhOL3EU6BBxzVd+OTk9UWG8TaLjfAv0bpeVxBN25jDL10WOykgK3ePE
         TxiOaGeDryIHwESutNAjFxwiv2SEs/ghotLA8fvqKS8R1EF+jQ8IIpjV1RSVVeOheCsz
         2C4A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779291193; x=1779895993; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=loPedkJWW5NsxZasmabpsVrzcNqsX8cLULapJHT/QGI=;
        b=XW4xS8EnlJTnyN4am/CTX7f0l6WWLV8Et8QQkN3hor+5il8ablSQdvnJdkciWlC/Fl
         dRjVJPK0nTofLyT23TDKiaIOcBlLI4idBTcKdS8d/8d+yKs7Rs5BtD/e1RjlwFKSTh1b
         YICvH9NPPn32gg5WO1BZDGWJYS0BT0KifChMgrxZ/OfQ1caTj4TaVAMlQM3prvq0aQ1v
         ZO5fYpXAI1BUlXmOzA+0gh0OAw27dYQVJPeb6JP+Un+yNWXEZRHbV8gjhWy8DIjp1ki6
         vOeR90BUuACRtXPsWgwxVngdrnpZ34S+BkGdDEWSlZat/gFsJSAbzFlYSFnZGextCOfM
         VoBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779291193; x=1779895993;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=loPedkJWW5NsxZasmabpsVrzcNqsX8cLULapJHT/QGI=;
        b=VQ1jzkPi4XXSoWnLH1c2o4AC4eErN1WJ0ebX2ppKsWXXd3syRgFEDiyGXsvxA8uf0h
         khsatCssCeb3efGDu3eclqODQ9CmTCA5RviIhcHCrDcYhIqiqSceR6v3e+lv8g2RzhtS
         5ZGNNNEbdmyjhMVqTRsN4CPLofsTKPW7Ol6fxbBakwYAuSCrxDARcapx+SKlMgUwd940
         f0Q4UWtyW7FZX/9mjbcL3BRjT3BQlXxnk/hnrbVb7m6lM+jwN6DjecG5Q2ruaMSlN5Eu
         q3L+rZH32kUkKK6iKMI8450kXUqA08xa+YUy3RhgyLoBKoqRAR2ZRsVEAMLM1E5LUVjo
         Kf0Q==
X-Gm-Message-State: AOJu0Yzgk8CWEx1Ozv7hFaeuYxONvOiqX11BT7nDP50uHvdsPrBdHOLB
	tNKtRI7qzBayXVvY3zxFEWIdkgkldGTZbGr/H6/wEUo6hDOre6Yd8lBd3RwJBb9WSk4WBCJO49w
	BrX55+lV9sPnf9jj+qtvGQWk1jP4Pu/AxBDO7
X-Gm-Gg: Acq92OGu4S0sFgvSTUTg+PjE1bJbQWMrU6j7MapljR5Z1qS1UMB0+nS0mPVu/5EVobP
	oQW/EZ0SBJ+O+SbAyPDWtm/NcAa78VKXe8E2RAcN1GG5+DjqgQeTbiLDSm2nyIzGo2n64IgbZLk
	aBB9wN28Y8Clp+Alj/YjFKpOMBwsVtRjOExfvEGFJmLvirfyMmFzzS2kB1b4wWglxFgevA1nfdD
	e+8Auuaf7YkxODfKwCdS8Wi6AZ5KnaV36jhTO7l+m9agUpLvUTCSqkD7koIw0Uh7AId7YVgGL+z
	gJwBLK4SnqDH+tE=
X-Received: by 2002:a05:651c:1108:10b0:38d:e977:5533 with SMTP id
 38308e7fff4ca-39561cbacb1mr52023801fa.26.1779291192520; Wed, 20 May 2026
 08:33:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260508121327.91410-1-kalevi@kolttonen.fi> <20260508121327.91410-3-kalevi@kolttonen.fi>
In-Reply-To: <20260508121327.91410-3-kalevi@kolttonen.fi>
From: James Carter <jwcart2@gmail.com>
Date: Wed, 20 May 2026 11:33:01 -0400
X-Gm-Features: AVHnY4LXt_T2YxjGLJPNcU6rn-BMzJ4UZpCFGv8MdJy5vv3gP30IEqJpaPtEVuk
Message-ID: <CAP+JOzQgrnm=bDCsJ1JwL9RXY_Bz__MUa44LVaffW5x5cVRUcQ@mail.gmail.com>
Subject: Re: [PATCH 2/4] checkpolicy: remove unneeded tests before free() calls
To: Kalevi Kolttonen <kalevi@kolttonen.fi>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 8, 2026 at 8:13=E2=80=AFAM Kalevi Kolttonen <kalevi@kolttonen.f=
i> wrote:
>
> ISO C guarantees that free(NULL) is always safe to do so
> remove unneeded tests before free() calls.
>
> Signed-off-by: Kalevi Kolttonen <kalevi@kolttonen.fi>

Acked-by: James Carter <jwcart2@gmail.com>

> ---
>  checkpolicy/policy_define.c | 48 +++++++++++++------------------------
>  1 file changed, 16 insertions(+), 32 deletions(-)
>
> diff --git a/checkpolicy/policy_define.c b/checkpolicy/policy_define.c
> index d1511a1a..4f775111 100644
> --- a/checkpolicy/policy_define.c
> +++ b/checkpolicy/policy_define.c
> @@ -381,10 +381,8 @@ int define_initial_sid(void)
>         return 0;
>
>        bad:
> -       if (id)
> -               free(id);
> -       if (newc)
> -               free(newc);
> +       free(id);
> +       free(newc);
>         return -1;
>  }
>
> @@ -632,17 +630,13 @@ int define_common_perms(void)
>         return 0;
>
>        bad:
> -       if (id)
> -               free(id);
> -       if (comdatum)
> -               free(comdatum);
> +       free(id);
> +       free(comdatum);
>         return -1;
>
>        bad_perm:
> -       if (perm)
> -               free(perm);
> -       if (perdatum)
> -               free(perdatum);
> +       free(perm);
> +       free(perdatum);
>         return -1;
>  }
>
> @@ -759,10 +753,8 @@ int define_av_perms(int inherits)
>         return 0;
>
>        bad:
> -       if (id)
> -               free(id);
> -       if (perdatum)
> -               free(perdatum);
> +       free(id);
> +       free(perdatum);
>         return -1;
>  }
>
> @@ -892,10 +884,8 @@ int define_sens(void)
>         return 0;
>
>        bad:
> -       if (id)
> -               free(id);
> -       if (level)
> -               free(level);
> +       free(id);
> +       free(level);
>         if (datum) {
>                 level_datum_destroy(datum);
>                 free(datum);
> @@ -903,8 +893,7 @@ int define_sens(void)
>         return -1;
>
>        bad_alias:
> -       if (id)
> -               free(id);
> +       free(id);
>         if (aliasdatum) {
>                 level_datum_destroy(aliasdatum);
>                 free(aliasdatum);
> @@ -1076,8 +1065,7 @@ int define_category(void)
>         return 0;
>
>        bad:
> -       if (id)
> -               free(id);
> +       free(id);
>         if (datum) {
>                 cat_datum_destroy(datum);
>                 free(datum);
> @@ -1085,8 +1073,7 @@ int define_category(void)
>         return -1;
>
>        bad_alias:
> -       if (id)
> -               free(id);
> +       free(id);
>         if (aliasdatum) {
>                 cat_datum_destroy(aliasdatum);
>                 free(aliasdatum);
> @@ -6129,13 +6116,10 @@ static int define_genfs_context_helper(char *fsty=
pe, int has_type)
>         free(type);
>         return 0;
>        fail:
> -       if (type)
> -               free(type);
> +       free(type);
>         context_destroy(&newc->context[0]);
> -       if (fstype)
> -               free(fstype);
> -       if (newc->u.name)
> -               free(newc->u.name);
> +       free(fstype);
> +       free(newc->u.name);
>         free(newc);
>         return -1;
>  }
> --
> 2.54.0
>
>
