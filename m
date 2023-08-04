Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 114A7C001DE
	for <selinux@archiver.kernel.org>; Fri,  4 Aug 2023 20:12:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230320AbjHDUMO (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 4 Aug 2023 16:12:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229963AbjHDULr (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 4 Aug 2023 16:11:47 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 567BA524A
        for <selinux@vger.kernel.org>; Fri,  4 Aug 2023 13:11:44 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id 38308e7fff4ca-2b95d5ee18dso39913771fa.1
        for <selinux@vger.kernel.org>; Fri, 04 Aug 2023 13:11:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691179902; x=1691784702;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/4+FTxHIKFJyoMYFbPUcGXg/iaAKDie5e/Rcw9Ie6Uc=;
        b=nOkupedcHSiKG4wYSMu8v10MmsydWH8BxecYYZ4vyUuawe8mgK1B3JOiqy274x5oy/
         Ivxr73/rT2jfQCeZQAggstqVhcmbmKeOf8AoWXWxb5CS9a5aBesSFDGVUJ/GO8rJPYwa
         rxFFiEARSw2UPvwOfYaRop50qOTskcoEXHutDMJSsZ5TwxJbNdP9wMbISqmevPqjpdvK
         zA/5ETjYKOdUGQiC2IRqSHQu8uk8WgfWFKt5Egy+BE6AojihFTEWrxSBdOJsWVi0db1U
         c+bt2A5t7nVq2UF6Lq8mUKzobh6hQ/tUDzUXsefvFZdNAPOVrruR2asfk+NelBn8f5DY
         iSLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691179902; x=1691784702;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/4+FTxHIKFJyoMYFbPUcGXg/iaAKDie5e/Rcw9Ie6Uc=;
        b=Da37dKUPJBkqsjsVApaGQKuknWRNID5PYoJRSONg1g4PEaGqfQ6vnkD+KvfH81amIs
         N0cJ8tt3HrlOAR9pevu+yftt3KeXQ1T9G81k8j7guLw5kEAL8aPeYHTvGzVv500uqUPS
         aOYvf15IObI0WIrib4I8x7YhPVHnU4PtocEljUVtQxCc5uiqfLqDnPZKLx0OqZ5qa4jW
         XRTtdJGwnIgJFcTtPGll8cDkPubmcAu8vitQnF00MDHcKc41QhFKDQfw3OdW4UqJ1JFm
         o1TyEbccQHDX7ZLY2MaK3OYDXTVtT0hVdYwucWZWXc5ioeS7W1nieXQwpGh753/Yo04m
         quMw==
X-Gm-Message-State: AOJu0YztfAle6Sz/v0dQyA0P/6tFE1EUc7Z3b3JfdwhOyKVl7B0PC7Xy
        OajfY4CB1NhZk9GrPe6EdyT2ZGDa+LOANsR/mT3WwQ8a
X-Google-Smtp-Source: AGHT+IEvTSuhO7UKM5mPVY8efzMXIniwX4xbZ0djry7py7BzitBf2sMCZ0C+H//s7wVi75baXWOObxTasYnWF63CH6I=
X-Received: by 2002:a2e:b706:0:b0:2b9:e53f:e201 with SMTP id
 j6-20020a2eb706000000b002b9e53fe201mr2211076ljo.31.1691179902062; Fri, 04 Aug
 2023 13:11:42 -0700 (PDT)
MIME-Version: 1.0
References: <20230714185338.46147-1-cgzones@googlemail.com>
In-Reply-To: <20230714185338.46147-1-cgzones@googlemail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Fri, 4 Aug 2023 16:11:30 -0400
Message-ID: <CAP+JOzS6MbNbT7yduzsoP79xmPPGQvdJ+ArySX9=pLQ2P0dVhw@mail.gmail.com>
Subject: Re: [PATCH] libsepol: free potential transition tables on insertion failure
To:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Jul 14, 2023 at 3:04=E2=80=AFPM Christian G=C3=B6ttsche
<cgzones@googlemail.com> wrote:
>
> If the insertion via the callback insertf fails, free the potential
> previously allocated transition hashtables.
>
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
> ---
>  libsepol/src/avtab.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/libsepol/src/avtab.c b/libsepol/src/avtab.c
> index 99fdaa87..6c74eff7 100644
> --- a/libsepol/src/avtab.c
> +++ b/libsepol/src/avtab.c
> @@ -715,7 +715,12 @@ int avtab_read_item(struct policy_file *fp, uint32_t=
 vers, avtab_t * a,
>                 }
>                 datum.data =3D le32_to_cpu(*buf32);
>         }
> -       return insertf(a, &key, &datum, p);
> +
> +       rc =3D insertf(a, &key, &datum, p);
> +       if (rc < 0)
> +               avtab_trans_destroy(&trans);
> +
> +       return rc;
>  }
>
>  static int avtab_insertf(avtab_t * a, avtab_key_t * k, avtab_datum_t * d=
,
> --
> 2.40.1
>

This patch depended on the prefix/suffix patches which have been reverted.
Jim
