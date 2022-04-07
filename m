Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2978EC4332F
	for <selinux@archiver.kernel.org>; Thu,  7 Apr 2022 14:55:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344340AbiDGO5K (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 7 Apr 2022 10:57:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344319AbiDGO5I (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 7 Apr 2022 10:57:08 -0400
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38DCA1EE9FC
        for <selinux@vger.kernel.org>; Thu,  7 Apr 2022 07:55:08 -0700 (PDT)
Received: by mail-oi1-x231.google.com with SMTP id z8so5878865oix.3
        for <selinux@vger.kernel.org>; Thu, 07 Apr 2022 07:55:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=DazD9+WkmQAjCYjUkLK9bUlBMR0AGOPCShGrQCC9Na8=;
        b=b5WQi70O2g8FAFmScsziW2xNPdddmug/WYWbgbY6/MDzcyIYJOQtDNkQlD5VlRjgfy
         UorPgeYjSWOkanwFedD563dT5Q2RVqipdulQl1gKkJSMK5Yhr3yoVnULzbWmtoGPMYvk
         AML/c+x5LVbhtT2TMJ/1sUdmi1gQLuhLSTgbc2ALAhmgXBPg8kgTSAOWuRUUvHGv07H3
         P78lMf8OyQPjn5g+21GXHc9mx6/8SIMnTeXoY6jWYja8DYxph7BUOhii/zO8Ooa1kqrR
         7c6hdUMiPsW5QuVt9UvRKA9HgVs76QuyoM2/EzsQmIvtKu7gEUDmZlzdA5kjCSGf5uXx
         N1WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=DazD9+WkmQAjCYjUkLK9bUlBMR0AGOPCShGrQCC9Na8=;
        b=KhvwVVij0IRQIlJpsRkGSmuzko7yxhcqEa9MJfnkMfrprP4rW0bdQMcaxRWu+YKzSe
         D4OOAZUWfoRqTZ9vqH/Agogp5p/H4Rlnf9ZqzElI036HvOtYcn5laq0BAcHZ4HpZjOnZ
         ZT2Po+kKQERxET7bKGjtebVPaLLEEcLTI2MJwaaOq0h82yxVZCOdjfquh4REhZsQWwuj
         DLesa6Lqfbkxf86tjbym/pzGXuywMhdMJ529mRags5IdnOLWUbsXmG11BkDtPWPqlBd0
         Xh17p713nX/CJEZLaoStAksumOTcLcN1UCw1fSRO9AcerVNoRLgNbRjI+LjbabLYjEsZ
         EkhA==
X-Gm-Message-State: AOAM532NCnEML7Vja7UzW/kUjHP/HPuCbCV2bj8lyLrP9JF34QYLRHqo
        Tp5YVbWBDexvY3Kqfdo6VNhf68XhKXXx96S83Bqzve78ivc=
X-Google-Smtp-Source: ABdhPJwUgjY/dNIK+RLnJAiJmnn4DzEKRhrgmjhQn2sGiKEPbg5bi3omJQAVV9jsA2lPFVGtjIM2EHd+/COK+tyfL7w=
X-Received: by 2002:a05:6808:210b:b0:2d9:a6d3:b029 with SMTP id
 r11-20020a056808210b00b002d9a6d3b029mr5915783oiw.182.1649343292373; Thu, 07
 Apr 2022 07:54:52 -0700 (PDT)
MIME-Version: 1.0
References: <20220204133507.26977-1-cgzones@googlemail.com> <20220222135435.31216-1-cgzones@googlemail.com>
In-Reply-To: <20220222135435.31216-1-cgzones@googlemail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Thu, 7 Apr 2022 10:54:41 -0400
Message-ID: <CAP+JOzQrheKCHkqWtx8n_rJe2ziK7rKD-G5EGO4n5iEqO=jHOw@mail.gmail.com>
Subject: Re: [RFC PATCH v2 1/4] libsepol: add sepol_av_perm_to_string
To:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Feb 22, 2022 at 9:05 AM Christian G=C3=B6ttsche
<cgzones@googlemail.com> wrote:
>
> Add a wrapper around the utility function sepol_av_to_string() on the
> service internal policy.  This allows callers to convert a permission
> bit set into a string representation without access to the internal
> policy structure.
>
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>

After thinking about it, I am ok with this series. All of the
functions that are being exported are used by checkpolicy or audit2why
and are from services.c.

So for these four patches:
Acked-by: James Carter <jwcart2@gmail.com>

> ---
>  libsepol/include/sepol/policydb/services.h | 9 +++++++++
>  libsepol/src/services.c                    | 6 ++++++
>  2 files changed, 15 insertions(+)
>
> diff --git a/libsepol/include/sepol/policydb/services.h b/libsepol/includ=
e/sepol/policydb/services.h
> index 048f8a5a..44de3863 100644
> --- a/libsepol/include/sepol/policydb/services.h
> +++ b/libsepol/include/sepol/policydb/services.h
> @@ -103,6 +103,15 @@ extern int sepol_string_to_av_perm(sepol_security_cl=
ass_t tclass,
>                                         const char *perm_name,
>                                         sepol_access_vector_t *av);
>
> +/*
> + * Return a string representation of the permission av bit associated wi=
th
> + * tclass.
> + * Returns a pointer to an internal buffer, overridden by the next call =
to
> + * this function or sepol_av_to_string().
> + */
> + extern const char *sepol_av_perm_to_string(sepol_security_class_t tclas=
s,
> +                                       sepol_access_vector_t av);
> +
>  /*
>   * Compute a SID to use for labeling a new object in the
>   * class `tclass' based on a SID pair.
> diff --git a/libsepol/src/services.c b/libsepol/src/services.c
> index 7becfd1b..b2fb804e 100644
> --- a/libsepol/src/services.c
> +++ b/libsepol/src/services.c
> @@ -1233,6 +1233,12 @@ out:
>         return STATUS_ERR;
>  }
>
> + const char *sepol_av_perm_to_string(sepol_security_class_t tclass,
> +                                       sepol_access_vector_t av)
> +{
> +       return sepol_av_to_string(policydb, tclass, av);
> +}
> +
>  /*
>   * Write the security context string representation of
>   * the context associated with `sid' into a dynamically
> --
> 2.35.1
>
