Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6304C00144
	for <selinux@archiver.kernel.org>; Mon,  1 Aug 2022 18:49:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234239AbiHAStA (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 1 Aug 2022 14:49:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234155AbiHASsx (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 1 Aug 2022 14:48:53 -0400
Received: from mail-oa1-x2f.google.com (mail-oa1-x2f.google.com [IPv6:2001:4860:4864:20::2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAF7B32452
        for <selinux@vger.kernel.org>; Mon,  1 Aug 2022 11:48:52 -0700 (PDT)
Received: by mail-oa1-x2f.google.com with SMTP id 586e51a60fabf-1013ecaf7e0so14677903fac.13
        for <selinux@vger.kernel.org>; Mon, 01 Aug 2022 11:48:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=jau2VAMf/4hq8LahO0fOT8hHe+h6eEZIvUbT/4/KYr8=;
        b=M/7jsUcQL0gKMnN9KeOizgYV0n1wnNLwEY7qL9TCERbkBhEPJS2Z/ia7/KRMK1tUtb
         HMbC7h/X5/94L22/BEmWghOj8IvnC7WnVvfSbQ+0DNF2YG8SodTSPyCFRb4m/zpQbpWJ
         NOx1IjeFiw1q0kM5rE+XUMFTnkZnYz4gJhbFNOPaYKPMvxSC6XNrDL0u5/1YLvUs1W9W
         Gd2O6dZvZW5hHVUODpPWnYZBmIIKiADAHEQtYdMmOh5hoxclnMBbGmlPO58W8KLTU/+F
         z5BOfBmzF4he4Z+Cp8v8LsEFUs8zI+qLZQPKR7sHdzPQfsxN6fLmDE2ktPUWQewYsNLi
         ConA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=jau2VAMf/4hq8LahO0fOT8hHe+h6eEZIvUbT/4/KYr8=;
        b=4ciV9TaQkR4Sekoa6aO0N60Eno8UBjrD+M7GnRfBpmhXwLRfOLehevnN6PtW01BKxe
         BcuokRI64+4lieR4a8+FzTQsF1c+Sy3Hw2RtOc95PeF5eUrtZP0EFZb/SO7TxtTlYbeR
         C0fL99R7q/vHb0DfSenGTBYfD7YHOVmCMmS4VhcFVi6PAR8+TR2/acxUmK1qvrp7WIcH
         XV7RvwOGcTmWB8EduxpaTo5ecpHaVptlwgfqjTSCIy0SvdhKU1myfr6cFWM0k06iCFPf
         opbNtBRhJ8pWkssPbxFoW9O0kYBi5P3z1Jz6V67fez8pzx8OQM6UzG8d8C1W6LunN6mh
         T7zA==
X-Gm-Message-State: AJIora/v3955EEqyL78MjUpZ3sB8QdsmIcAs9TGGFPpgqiT3dchdh86w
        JZ/zjhHGTw3pzwkHxY65oMYTctFZZvbM5my52Gs=
X-Google-Smtp-Source: AGRyM1uf46Yvz12rLAdB2L++pOKaMx0qI+oxttzC1gDzml7OJsdWIRwdB9qPJ5Qn/h+pj+XctcHb3YWy7BeXV8lnmv8=
X-Received: by 2002:a05:6870:b017:b0:10c:ce5a:ac4 with SMTP id
 y23-20020a056870b01700b0010cce5a0ac4mr7911445oae.182.1659379731617; Mon, 01
 Aug 2022 11:48:51 -0700 (PDT)
MIME-Version: 1.0
References: <20220721152444.31690-1-cgzones@googlemail.com>
In-Reply-To: <20220721152444.31690-1-cgzones@googlemail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Mon, 1 Aug 2022 14:48:40 -0400
Message-ID: <CAP+JOzR2Y90=v6WomOi=LRboCTAVqVJ79Ae6VArtSQEL_y8WwA@mail.gmail.com>
Subject: Re: [PATCH v2 1/5] libsepol: rename validate_policydb to policydb_validate
To:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Jul 21, 2022 at 11:34 AM Christian G=C3=B6ttsche
<cgzones@googlemail.com> wrote:
>
> Most global functions operating on a policy database use policydb as
> prefix.
>
> Since this function is not exported there should not be any external
> use.
>
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>

For this series:
Acked-by: James Carter <jwcart2@gmail.com>


> ---
>  libsepol/src/policydb.c          | 2 +-
>  libsepol/src/policydb_validate.c | 2 +-
>  libsepol/src/policydb_validate.h | 2 +-
>  3 files changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/libsepol/src/policydb.c b/libsepol/src/policydb.c
> index fc260eb6..8a65df05 100644
> --- a/libsepol/src/policydb.c
> +++ b/libsepol/src/policydb.c
> @@ -4570,7 +4570,7 @@ int policydb_read(policydb_t * p, struct policy_fil=
e *fp, unsigned verbose)
>                 }
>         }
>
> -       if (validate_policydb(fp->handle, p))
> +       if (policydb_validate(fp->handle, p))
>                 goto bad;
>
>         return POLICYDB_SUCCESS;
> diff --git a/libsepol/src/policydb_validate.c b/libsepol/src/policydb_val=
idate.c
> index 99d4eb7f..e1dad236 100644
> --- a/libsepol/src/policydb_validate.c
> +++ b/libsepol/src/policydb_validate.c
> @@ -1330,7 +1330,7 @@ static void validate_array_destroy(validate_t flavo=
rs[])
>  /*
>   * Validate policydb
>   */
> -int validate_policydb(sepol_handle_t *handle, policydb_t *p)
> +int policydb_validate(sepol_handle_t *handle, policydb_t *p)
>  {
>         validate_t flavors[SYM_NUM] =3D {};
>
> diff --git a/libsepol/src/policydb_validate.h b/libsepol/src/policydb_val=
idate.h
> index d9f7229b..b7f9f191 100644
> --- a/libsepol/src/policydb_validate.h
> +++ b/libsepol/src/policydb_validate.h
> @@ -4,4 +4,4 @@
>  #include <sepol/policydb/policydb.h>
>
>  int value_isvalid(uint32_t value, uint32_t nprim);
> -int validate_policydb(sepol_handle_t *handle, policydb_t *p);
> +int policydb_validate(sepol_handle_t *handle, policydb_t *p);
> --
> 2.36.1
>
