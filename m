Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22E81C54E7C
	for <selinux@archiver.kernel.org>; Tue, 14 Nov 2023 20:38:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234007AbjKNUip (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 14 Nov 2023 15:38:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234012AbjKNUip (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 14 Nov 2023 15:38:45 -0500
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5CC5F1
        for <selinux@vger.kernel.org>; Tue, 14 Nov 2023 12:38:41 -0800 (PST)
Received: by mail-lj1-x230.google.com with SMTP id 38308e7fff4ca-2c59a4dd14cso73601551fa.2
        for <selinux@vger.kernel.org>; Tue, 14 Nov 2023 12:38:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699994320; x=1700599120; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GJvqrAdrbDt0PH0QuXr1nf4XjaQ9aKZPxBq/UMziv+g=;
        b=cSGSwEc1DpxNEfeFsdMtvIfck6nocP7YekzLHB71QZY8CjzTfheGRr89HDX8l/7Lmt
         R+n9jbcIiiAVdplidlBvPa3T8DpCiG4vURo2eC9w+KlyzCkXuSgDBB6kJ57BdSkugus/
         mozMQyEYIe9Xo0AcQd1D7YKnFklkqRP3m7I4Ol5W5WG89NdRtunHuu+pOQRFq7pCxgkV
         LJOVNnB/aS4w9FbF7t4YBZKLwIKcJzRetcZJDkhcR0wO5jD9EVWqCqhfn8yDmIvYUaPo
         KYIClg2+/ANkQHfwMTPTN1Acdb8kwu3sApNEhRY8CSV2pE+jVma8vp792AravTP1aHdT
         HuoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699994320; x=1700599120;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GJvqrAdrbDt0PH0QuXr1nf4XjaQ9aKZPxBq/UMziv+g=;
        b=vHRZs3L8koG5uKjFUtmMb8fGsHgYq/NUAS/v0EYR0aaGNnaoj9BPTHIMSfBrSF/6dq
         VxRzk8heKe7CwJ1kyUUVWrzz9CmMe5lB/EbCwruhUVSbMab2Qxm7EaibL3A2RwVw955L
         pM1IdKpVGYbRg2+WodjMYeYacGavPyTxcYAdSJKAJJvDriNLfr8KtwR9H6c65CvGuSNM
         kEGxR9bdQLEoTc9xMPPCKNRYm7ZxzB4pM4bzqj8kpUvvtEdg6pl/X3QCfkIC3ox6+pPP
         src9kEZ2/OQwf6vYatA5nPYZxJHkTYS5oeDLflVDWz7LhehILZH1GJ4kqTFTL7xLo1ki
         Xzcw==
X-Gm-Message-State: AOJu0Yw+7DOinVUsp+nccqa/JQ6D3ltvzxTYD0vDUpjWPQREGL7mZFXM
        gh9Jt13sdQId9aaJi9F9TF6xPXisPaeI5tSRL8c=
X-Google-Smtp-Source: AGHT+IEa1H0rIBLOi4L0cCd1euKVl7MmXevVt5j6BykXR/gwwrqpBNKWkIS21SXwWJWsIXoUpFBgRphkW64UWb6way4=
X-Received: by 2002:a05:6512:51c:b0:503:35bb:1e74 with SMTP id
 o28-20020a056512051c00b0050335bb1e74mr6851454lfb.61.1699994319732; Tue, 14
 Nov 2023 12:38:39 -0800 (PST)
MIME-Version: 1.0
References: <20231113232750.48706-1-luhuaxin1@huawei.com>
In-Reply-To: <20231113232750.48706-1-luhuaxin1@huawei.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Tue, 14 Nov 2023 15:39:28 -0500
Message-ID: <CAP+JOzRTW1mJH2VT143OOYCaM7xbNytPukXMoY3gfwCJX1FGhg@mail.gmail.com>
Subject: Re: [PATCH v1] libsepol: add check for category value before printing
To:     luhuaxin1@huawei.com
Cc:     selinux@vger.kernel.org, fangxiuning@huawei.com,
        zhujianwei7@huawei.com, shenyining@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Nov 13, 2023 at 8:59=E2=80=AFPM <luhuaxin1@huawei.com> wrote:
>
> From: Huaxin Lu <luhuaxin1@huawei.com>
>
> In mls_semantic_level_expand(), there is a explicitly determine
> whether category is 0, which may cause an potential integer
> overflow in error branch.
>
> Signed-off-by: Huaxin Lu <luhuaxin1@huawei.com>
> ---
>  libsepol/src/expand.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/libsepol/src/expand.c b/libsepol/src/expand.c
> index ee5f9185..9ed22bfd 100644
> --- a/libsepol/src/expand.c
> +++ b/libsepol/src/expand.c
> @@ -945,8 +945,8 @@ int mls_semantic_level_expand(mls_semantic_level_t * =
sl, mls_level_t * l,
>         for (cat =3D sl->cat; cat; cat =3D cat->next) {
>                 if (!cat->low || cat->low > cat->high) {
>                         ERR(h, "Category range is not valid %s.%s",
> -                           p->p_cat_val_to_name[cat->low - 1],
> -                           p->p_cat_val_to_name[cat->high - 1]);
> +                           cat->low > 0 ? p->p_cat_val_to_name[cat->low =
- 1] : "n/a",
> +                           cat->high > 0 ? p->p_cat_val_to_name[cat->hig=
h - 1] : "n/a");

I would prefer "Invalid", "Bad Category", "NULL", or something along
those lines instead of "n/a".
Thanks,
Jim


>                         return -1;
>                 }
>                 for (i =3D cat->low - 1; i < cat->high; i++) {
> --
> 2.33.0
>
