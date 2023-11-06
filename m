Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F3A2C4332F
	for <selinux@archiver.kernel.org>; Mon,  6 Nov 2023 14:33:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230146AbjKFOdd (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 6 Nov 2023 09:33:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbjKFOdc (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 6 Nov 2023 09:33:32 -0500
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E09194
        for <selinux@vger.kernel.org>; Mon,  6 Nov 2023 06:33:29 -0800 (PST)
Received: by mail-lf1-x12a.google.com with SMTP id 2adb3069b0e04-5094cb3a036so5519761e87.2
        for <selinux@vger.kernel.org>; Mon, 06 Nov 2023 06:33:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699281208; x=1699886008; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HfRbY+KwjoiYN4NiHmGY+w5w85gxv9NYZDq+deBa8vI=;
        b=fMvRiq5uOoa/BYeCXBBaxKlyN7DbxJBsN8TwV6yEcDIe8NOKH7x46agrVJE2LTX6Cx
         8Z/d306RMmgCOQBzk65WWSjqcsb6IkZ2emSmvICKp9iLOtpMmxHFW06vz4hobuI/JyRE
         pwR6Yc2xc6hR7Y6KoDo/KZTrP1d09A2uzjOUrMPk3rBgey/O+8V6UXt200K5tGJ1SiGd
         XYNihvmonbhmZAE30VoSij9e8IkhZOpXDRQosDN9HS9XeOaFptNYAxlvMEkvw6I6ZQss
         qtk+e+508eMnIjdma+oy3RhHA9D8VJKyk384dQQs4giwsJUvpGwmNjl/GqL8ywyxAiX4
         YFtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699281208; x=1699886008;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HfRbY+KwjoiYN4NiHmGY+w5w85gxv9NYZDq+deBa8vI=;
        b=ta/bhHOfLe9pS22deoaHvYeZC242XyoZQyqn7K2TM8olI/zOmmTXA4cFcHaWu+Dtpn
         652iJMl0NdEKhXZooS/UgtfGAVIfkXj0sWYNLG94SBf0fRORiXTOHCwjEspu/2GwvpC5
         cgdcYtpWGK+TZxYLPOkceBErF+EXNnlrNJSjo7+Wk34BX6PPZ7tMJrpoYzuOiKQz5L6q
         o6UppBIcn+J01/hpxPsdONzHNAFuPHjrlYS1bEADQLkVvqK78EA867f+YIeaFyLWw7zE
         iMrmgEzi3Shr4nAA0h1ZIqcQhdtrwAPhS1ObQG/L8a9VPjpEfHOumDnoTg/RIjtTkqh1
         dOeA==
X-Gm-Message-State: AOJu0YwF7azoeySRuFEf0bM/IGWm/eyvMZ1QOaVPDqKk8YvyCaTB8nBC
        aKXOj3zF1kuxsN7Ji+KL2gl5L7lNGiEEjFB5wl3TTGcJwSA=
X-Google-Smtp-Source: AGHT+IGCb1yGIynJgOSE988rLDCzJQUSguGH0ZbIxosHV4fFHUCru8/ODNQ65Q2PPzXWG/9JRccvd22Rsg7QODvcio8=
X-Received: by 2002:a05:6512:3096:b0:508:11f5:8953 with SMTP id
 z22-20020a056512309600b0050811f58953mr12192167lfd.26.1699281207502; Mon, 06
 Nov 2023 06:33:27 -0800 (PST)
MIME-Version: 1.0
References: <20231103182637.85003-1-cgzones@googlemail.com>
In-Reply-To: <20231103182637.85003-1-cgzones@googlemail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Mon, 6 Nov 2023 09:33:16 -0500
Message-ID: <CAP+JOzRS4ErNLz-tERjzuqWxot2OW7N6se0p9f5dBmGwU_-GJg@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] libsepol: validate default type of transition is
 not an attribute
To:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Nov 3, 2023 at 2:27=E2=80=AFPM Christian G=C3=B6ttsche
<cgzones@googlemail.com> wrote:
>
> The default type of a type transition must be a regular type, not an
> attribute.
>
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>

Acked-by: James Carter <jwcart2@gmail.com>

> ---
> v2:
>   fix build error by supplying necessary arguments to
>   validate_simpletype()
> ---
>  libsepol/src/policydb_validate.c | 16 ++++++++++------
>  1 file changed, 10 insertions(+), 6 deletions(-)
>
> diff --git a/libsepol/src/policydb_validate.c b/libsepol/src/policydb_val=
idate.c
> index 892a0ffd..810c3263 100644
> --- a/libsepol/src/policydb_validate.c
> +++ b/libsepol/src/policydb_validate.c
> @@ -468,7 +468,7 @@ static int validate_role_datum_wrapper(__attribute__(=
(unused)) hashtab_key_t k,
>         return validate_role_datum(margs->handle, d, margs->flavors);
>  }
>
> -static int validate_simpletype(uint32_t value, const policydb_t *p, vali=
date_t flavors[])
> +static int validate_simpletype(uint32_t value, const policydb_t *p, cons=
t validate_t flavors[SYM_NUM])
>  {
>         const type_datum_t *type;
>
> @@ -1094,7 +1094,9 @@ static int validate_filename_trans(hashtab_key_t k,=
 hashtab_datum_t d, void *arg
>  {
>         const filename_trans_key_t *ftk =3D (filename_trans_key_t *)k;
>         const filename_trans_datum_t *ftd =3D d;
> -       validate_t *flavors =3D (validate_t *)args;
> +       const map_arg_t *margs =3D args;
> +       const validate_t *flavors =3D margs->flavors;
> +       const policydb_t *p =3D margs->policy;
>
>         if (validate_value(ftk->ttype, &flavors[SYM_TYPES]))
>                 goto bad;
> @@ -1105,7 +1107,7 @@ static int validate_filename_trans(hashtab_key_t k,=
 hashtab_datum_t d, void *arg
>         for (; ftd; ftd =3D ftd->next) {
>                 if (validate_ebitmap(&ftd->stypes, &flavors[SYM_TYPES]))
>                         goto bad;
> -               if (validate_value(ftd->otype, &flavors[SYM_TYPES]))
> +               if (validate_simpletype(ftd->otype, p, flavors))
>                         goto bad;
>         }
>
> @@ -1115,9 +1117,11 @@ bad:
>         return -1;
>  }
>
> -static int validate_filename_trans_hashtab(sepol_handle_t *handle, hasht=
ab_t filename_trans, validate_t flavors[])
> +static int validate_filename_trans_hashtab(sepol_handle_t *handle, const=
 policydb_t *p, validate_t flavors[])
>  {
> -       if (hashtab_map(filename_trans, validate_filename_trans, flavors)=
) {
> +       map_arg_t margs =3D { flavors, handle, p };
> +
> +       if (hashtab_map(p->filename_trans, validate_filename_trans, &marg=
s)) {
>                 ERR(handle, "Invalid filename trans");
>                 return -1;
>         }
> @@ -1555,7 +1559,7 @@ int policydb_validate(sepol_handle_t *handle, const=
 policydb_t *p)
>                 if (validate_role_allows(handle, p->role_allow, flavors))
>                         goto bad;
>                 if (p->policyvers >=3D POLICYDB_VERSION_FILENAME_TRANS)
> -                       if (validate_filename_trans_hashtab(handle, p->fi=
lename_trans, flavors))
> +                       if (validate_filename_trans_hashtab(handle, p, fl=
avors))
>                                 goto bad;
>         } else {
>                 if (validate_avrule_blocks(handle, p->global, p, flavors)=
)
> --
> 2.42.0
>
