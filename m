Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B8E81B2505
	for <selinux@vger.kernel.org>; Thu, 29 Aug 2024 12:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724935254; cv=none; b=nz3PsU6cw/HrqAYJACmSkgkOuQ1ypppwn3NNCErdVNyAaFtPR9SYGaGrRYAvBx9+3NlRAbt7T+ICjK72SYpC7z0ekpiMWfsgpzmtifnjLNOnEL47A7pI2+eWn8h+cLR5el0b72lfb4w1u/aU4Vra15lfwfArxOaR2WvA4g6I7aA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724935254; c=relaxed/simple;
	bh=hEWG7kGDAUfHk8M9JmA/DgtNeqcJMiEcrw5XR57zWBg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qCgPABRmaCCmknAATj4qafmtU36QNxn0OPHHZk8ALGB5ulGBtNiXspUdLkbtctl4Ai99j0IKmg9U/KRqt89H6qwe6Jgp65uDnLRZdr9Riis98siZGx4PysuNZnVcRws5dVxfzS2IAK1zH3esHfj2UJX40nf0Ai+JNCzcAicXGvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ENwU/2WC; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ENwU/2WC"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2021c03c13aso5215835ad.1
        for <selinux@vger.kernel.org>; Thu, 29 Aug 2024 05:40:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724935252; x=1725540052; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YMmr59VEuEGgkTgmMlmXAYC2Rd28jwtqIqyRamk8wA4=;
        b=ENwU/2WCUPNZ7Eo/JUQtz0/W2yE6eQ0VUUC6MQhD9PEGbE+4HSkaPOcvOdvHijLvNo
         lDeMt+UtJl+nvzCoFQpJwCtWPTr8Rd+rrBTObRy9gzwFEisOkU2zDAbrW807mxKExjqT
         oWPU8vjOnkJZAVACRSAgw8hdLUcwPEuyAfPqVB2OrBf8tsPq+5Nop3Cc2sf+ev53yuue
         DBM5qZ0GfvVGX4085Y43zO7tt/MxH4O0ONhd30GEyteYQn2UwPeCUwkY8x640U5boBZ9
         Xw8ZOgog6a0nDyJVOpZZQxYTPQG5vhh6BKiT2/Z9hHrGWmnFBBPC1NhpbSSBFD7IP6Cq
         Ilpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724935252; x=1725540052;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YMmr59VEuEGgkTgmMlmXAYC2Rd28jwtqIqyRamk8wA4=;
        b=SH2b8DztwLcxf9BR7M4m7s31fLnegChawRoh264fET+wUbC72EKQzoTc419c29y/V7
         TdTdxduh7PFGgtX7APNioWExiV5UbTIL/IcixSxCU9UHd41ErUCI7tZDXUhVyU/1fW+9
         JcALuRk34KF/7KD4rSDVo0w8Go1q427wCAzn6ljXYhKpzdGVReP8lv92R50Pp9SRU8KL
         b8uDt3vW7d2Q47gutbl8KXQnx/ZPLjabdjfkHT5NjT9tVcbX7d9akg3353meengFy8yQ
         EfjSKMZpDf5HV9BVJh9fUq+7rn3J9YM4eTOs3226jSrNpZQ09S+h2Ol8YU9WTbsdMTyF
         asMA==
X-Forwarded-Encrypted: i=1; AJvYcCVdxhW31JIVgRkDLEfFaO5WA61/j79yrlE0J5gVZfVY8CEmRADArlcM8I8rQWUGSWij1QcZxOJL@vger.kernel.org
X-Gm-Message-State: AOJu0YyO+VR6Vni/qguKWJzIeMeVIcLOObvFHFqIQCkVdcRNX5dCvXty
	zrOqnBdo9OvlsjTdgdQG6IDIoE7ViYUr1mN4wyqjwSNKFPnf3xa5a+mPPw8lG2GIUIZDLgdSL8r
	igZcDznjYYP3aqKREm/7kuMluDts=
X-Google-Smtp-Source: AGHT+IG2UX8jjrbqdqLM9n+7nRym4bPzD6QAsJvHIaHD1UUMcGilmXLClDyvt2+Vpo3WNgVWg0cNHc3sMQW6SBG78kU=
X-Received: by 2002:a17:903:32cf:b0:1fb:2ebc:d16b with SMTP id
 d9443c01a7336-2050e961adamr39652355ad.7.1724935246201; Thu, 29 Aug 2024
 05:40:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240822003757.1998016-1-tweek@google.com>
In-Reply-To: <20240822003757.1998016-1-tweek@google.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Thu, 29 Aug 2024 08:40:34 -0400
Message-ID: <CAEjxPJ48a4ZwN-w8UcsCohbG+Ht5kSxhprc0fy9qfuw89t2abQ@mail.gmail.com>
Subject: Re: [PATCH 1/3] libsepol: Rename ioctl xperms structures and functions
To: =?UTF-8?Q?Thi=C3=A9baud_Weksteen?= <tweek@google.com>
Cc: paul@paul-moore.com, brambonne@google.com, jeffv@google.com, 
	selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 21, 2024 at 8:38=E2=80=AFPM Thi=C3=A9baud Weksteen <tweek@googl=
e.com> wrote:
>
> The ioctl extended permission structures and functions can be reused for
> other extended permissions. Use the more generic term "xperm" instead of
> "ioctl".
>
> Signed-off-by: Thi=C3=A9baud Weksteen <tweek@google.com>

Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>

> ---
>  checkpolicy/policy_define.c | 72 ++++++++++++++++++-------------------
>  1 file changed, 36 insertions(+), 36 deletions(-)
>
> diff --git a/checkpolicy/policy_define.c b/checkpolicy/policy_define.c
> index 4931f23d..4f6b2266 100644
> --- a/checkpolicy/policy_define.c
> +++ b/checkpolicy/policy_define.c
> @@ -1874,27 +1874,27 @@ avrule_t *define_cond_pol_list(avrule_t * avlist,=
 avrule_t * sl)
>         return sl;
>  }
>
> -typedef struct av_ioctl_range {
> +typedef struct av_xperm_range {
>         uint16_t low;
>         uint16_t high;
> -} av_ioctl_range_t;
> +} av_xperm_range_t;
>
> -struct av_ioctl_range_list {
> +struct av_xperm_range_list {
>         uint8_t omit;
> -       av_ioctl_range_t range;
> -       struct av_ioctl_range_list *next;
> +       av_xperm_range_t range;
> +       struct av_xperm_range_list *next;
>  };
>
> -static int avrule_sort_ioctls(struct av_ioctl_range_list **rangehead)
> +static int avrule_sort_xperms(struct av_xperm_range_list **rangehead)
>  {
> -       struct av_ioctl_range_list *r, *r2, *sorted, *sortedhead =3D NULL=
;
> +       struct av_xperm_range_list *r, *r2, *sorted, *sortedhead =3D NULL=
;
>
>         /* order list by range.low */
>         for (r =3D *rangehead; r !=3D NULL; r =3D r->next) {
> -               sorted =3D malloc(sizeof(struct av_ioctl_range_list));
> +               sorted =3D malloc(sizeof(struct av_xperm_range_list));
>                 if (sorted =3D=3D NULL)
>                         goto error;
> -               memcpy(sorted, r, sizeof(struct av_ioctl_range_list));
> +               memcpy(sorted, r, sizeof(struct av_xperm_range_list));
>                 sorted->next =3D NULL;
>                 if (sortedhead =3D=3D NULL) {
>                         sortedhead =3D sorted;
> @@ -1933,9 +1933,9 @@ error:
>         return -1;
>  }
>
> -static void avrule_merge_ioctls(struct av_ioctl_range_list **rangehead)
> +static void avrule_merge_xperms(struct av_xperm_range_list **rangehead)
>  {
> -       struct av_ioctl_range_list *r, *tmp;
> +       struct av_xperm_range_list *r, *tmp;
>         r =3D *rangehead;
>         while (r !=3D NULL && r->next !=3D NULL) {
>                 /* merge */
> @@ -1952,15 +1952,15 @@ static void avrule_merge_ioctls(struct av_ioctl_r=
ange_list **rangehead)
>         }
>  }
>
> -static int avrule_read_ioctls(struct av_ioctl_range_list **rangehead)
> +static int avrule_read_xperm_ranges(struct av_xperm_range_list **rangehe=
ad)
>  {
>         char *id;
> -       struct av_ioctl_range_list *rnew, *r =3D NULL;
> +       struct av_xperm_range_list *rnew, *r =3D NULL;
>         uint8_t omit =3D 0;
>
>         *rangehead =3D NULL;
>
> -       /* read in all the ioctl commands */
> +       /* read in all the ioctl/netlink commands */
>         while ((id =3D queue_remove(id_queue))) {
>                 if (strcmp(id,"~") =3D=3D 0) {
>                         /* these are values to be omitted */
> @@ -1979,7 +1979,7 @@ static int avrule_read_ioctls(struct av_ioctl_range=
_list **rangehead)
>                         free(id);
>                 } else {
>                         /* read in new low value */
> -                       rnew =3D malloc(sizeof(struct av_ioctl_range_list=
));
> +                       rnew =3D malloc(sizeof(struct av_xperm_range_list=
));
>                         if (rnew =3D=3D NULL)
>                                 goto error;
>                         rnew->next =3D NULL;
> @@ -2006,11 +2006,11 @@ error:
>  }
>
>  /* flip to included ranges */
> -static int avrule_omit_ioctls(struct av_ioctl_range_list **rangehead)
> +static int avrule_omit_xperms(struct av_xperm_range_list **rangehead)
>  {
> -       struct av_ioctl_range_list *rnew, *r, *newhead, *r2;
> +       struct av_xperm_range_list *rnew, *r, *newhead, *r2;
>
> -       rnew =3D calloc(1, sizeof(struct av_ioctl_range_list));
> +       rnew =3D calloc(1, sizeof(struct av_xperm_range_list));
>         if (!rnew)
>                 goto error;
>
> @@ -2028,7 +2028,7 @@ static int avrule_omit_ioctls(struct av_ioctl_range=
_list **rangehead)
>
>         while (r) {
>                 r2->range.high =3D r->range.low - 1;
> -               rnew =3D calloc(1, sizeof(struct av_ioctl_range_list));
> +               rnew =3D calloc(1, sizeof(struct av_xperm_range_list));
>                 if (!rnew)
>                         goto error;
>                 r2->next =3D rnew;
> @@ -2054,26 +2054,26 @@ error:
>         return -1;
>  }
>
> -static int avrule_ioctl_ranges(struct av_ioctl_range_list **rangelist)
> +static int avrule_xperm_ranges(struct av_xperm_range_list **rangelist)
>  {
> -       struct av_ioctl_range_list *rangehead;
> +       struct av_xperm_range_list *rangehead;
>         uint8_t omit;
>
>         /* read in ranges to include and omit */
> -       if (avrule_read_ioctls(&rangehead))
> +       if (avrule_read_xperm_ranges(&rangehead))
>                 return -1;
>         if (rangehead =3D=3D NULL) {
> -               yyerror("error processing ioctl commands");
> +               yyerror("error processing ioctl/netlink commands");
>                 return -1;
>         }
>         omit =3D rangehead->omit;
> -       /* sort and merge the input ioctls */
> -       if (avrule_sort_ioctls(&rangehead))
> +       /* sort and merge the input ranges */
> +       if (avrule_sort_xperms(&rangehead))
>                 return -1;
> -       avrule_merge_ioctls(&rangehead);
> +       avrule_merge_xperms(&rangehead);
>         /* flip ranges if these are omitted */
>         if (omit) {
> -               if (avrule_omit_ioctls(&rangehead))
> +               if (avrule_omit_xperms(&rangehead))
>                         return -1;
>         }
>
> @@ -2261,11 +2261,11 @@ static int avrule_xperms_used(const av_extended_p=
erms_t *xperms)
>  #define IOC_DRIV(x) ((x) >> 8)
>  #define IOC_FUNC(x) ((x) & 0xff)
>  #define IOC_CMD(driver, func) (((driver) << 8) + (func))
> -static int avrule_ioctl_partialdriver(struct av_ioctl_range_list *rangel=
ist,
> +static int avrule_xperm_partialdriver(struct av_xperm_range_list *rangel=
ist,
>                                 av_extended_perms_t *complete_driver,
>                                 av_extended_perms_t **extended_perms)
>  {
> -       struct av_ioctl_range_list *r;
> +       struct av_xperm_range_list *r;
>         av_extended_perms_t *xperms;
>         uint8_t low, high;
>
> @@ -2300,10 +2300,10 @@ static int avrule_ioctl_partialdriver(struct av_i=
octl_range_list *rangelist,
>
>  }
>
> -static int avrule_ioctl_completedriver(struct av_ioctl_range_list *range=
list,
> +static int avrule_ioctl_completedriver(struct av_xperm_range_list *range=
list,
>                         av_extended_perms_t **extended_perms)
>  {
> -       struct av_ioctl_range_list *r;
> +       struct av_xperm_range_list *r;
>         av_extended_perms_t *xperms;
>         uint16_t low, high;
>         xperms =3D calloc(1, sizeof(av_extended_perms_t));
> @@ -2342,10 +2342,10 @@ static int avrule_ioctl_completedriver(struct av_=
ioctl_range_list *rangelist,
>         return 0;
>  }
>
> -static int avrule_ioctl_func(struct av_ioctl_range_list *rangelist,
> +static int avrule_ioctl_func(struct av_xperm_range_list *rangelist,
>                 av_extended_perms_t **extended_perms, unsigned int driver=
)
>  {
> -       struct av_ioctl_range_list *r;
> +       struct av_xperm_range_list *r;
>         av_extended_perms_t *xperms;
>         uint16_t low, high;
>
> @@ -2457,13 +2457,13 @@ static int avrule_cpy(avrule_t *dest, const avrul=
e_t *src)
>  static int define_te_avtab_ioctl(const avrule_t *avrule_template)
>  {
>         avrule_t *avrule;
> -       struct av_ioctl_range_list *rangelist, *r;
> +       struct av_xperm_range_list *rangelist, *r;
>         av_extended_perms_t *complete_driver, *partial_driver, *xperms;
>         unsigned int i;
>
>
>         /* organize ioctl ranges */
> -       if (avrule_ioctl_ranges(&rangelist))
> +       if (avrule_xperm_ranges(&rangelist))
>                 return -1;
>
>         /* create rule for ioctl driver types that are entirely enabled *=
/
> @@ -2482,7 +2482,7 @@ static int define_te_avtab_ioctl(const avrule_t *av=
rule_template)
>         }
>
>         /* flag ioctl driver codes that are partially enabled */
> -       if (avrule_ioctl_partialdriver(rangelist, complete_driver, &parti=
al_driver))
> +       if (avrule_xperm_partialdriver(rangelist, complete_driver, &parti=
al_driver))
>                 return -1;
>
>         if (!partial_driver || !avrule_xperms_used(partial_driver))
> --
> 2.46.0.184.g6999bdac58-goog
>
