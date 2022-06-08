Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6CF7CCA47B
	for <selinux@archiver.kernel.org>; Wed,  8 Jun 2022 18:04:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233822AbiFHSEB (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 8 Jun 2022 14:04:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233874AbiFHSD4 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 8 Jun 2022 14:03:56 -0400
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A10220C6E4
        for <selinux@vger.kernel.org>; Wed,  8 Jun 2022 11:03:55 -0700 (PDT)
Received: by mail-oi1-x22f.google.com with SMTP id r206so29025461oib.8
        for <selinux@vger.kernel.org>; Wed, 08 Jun 2022 11:03:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=JyRyq1DjRoteSryQBAB/rCJlYzGbiYVMOfbUixeYxQg=;
        b=qsGvEMTQME+ameA/ebBJwvQVL99kZ1QbAPNwSNb/v+KGGyh58679yi9oT6aDW1j92w
         mi76/B+kUQeHR+s74G6kwZtZBzEKX8Ysy9FoNKL3rLOFsH2wBzF6hgh8OeHSQnP/nQB+
         L+MSBgawmOoItlaZ54+22cgwkmb//j9DYqdPmpFmo+2ZMQN4QMBEVNn/7dIb7Adp24GR
         VcDTZnwK+NBJPGjRo8DDW5ilX/Dx/0UDcVjVj81N12X1AKAFFsb1tCdWzH6hqKHzgpoF
         eDIDBQqUAzaNsd4Lo84N59RvC32ejYBHZoeq/k+rxF7F9QEB+wB0/jUYV41OuA2yZyPh
         r6Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=JyRyq1DjRoteSryQBAB/rCJlYzGbiYVMOfbUixeYxQg=;
        b=Iv620dwwJ8TwY9Uvwy8BjTbzvV6SZ7MRvo0wboZJQHrb6vAlkmmhPeTKNuXlsWvr6i
         u1SK5gBlYRzcFp6+mHZA67K3BVapdwyDk6nlY44UKK7hvtB7AOkF6Ie/4/xfeoQoVgSR
         CVUcXu6QYsTKkZf0w34B1HnVXL93cGz6PiCIkBiiFHdEyVKZ2fow94eugd8nHcFVSD6E
         AlwQQrbJDqvQG5XHujvEi1kxT1twxMsjzVYQPlM+IygTSiERMDG0Nzs/KkpsH6avLZ5s
         ikF81JFfNCN0hb62WSQ4Dfw9odS0gQcwHiaYdlbsL5mXCEMyUda1V4ikp356DxuqlaUz
         +oBg==
X-Gm-Message-State: AOAM533dINvmfk5/eo7dEbv1Tjv0w4rb1sUBJRkZtxQJIbIprHHG0xqj
        MxOsMnJzOWQTSYPspiWN0IbCu1Cd9iYSJDwqPm38Pk9hOaE=
X-Google-Smtp-Source: ABdhPJwCpsogjWN9GR8KXgvWBjqLoeiJe1hiAb1GPPealTQpesZEY7qcc0cgB1fnimmbJPx3ru8303hkMJY2+for7ZQ=
X-Received: by 2002:a05:6808:ec5:b0:2f9:a7fb:4dfb with SMTP id
 q5-20020a0568080ec500b002f9a7fb4dfbmr3121280oiv.156.1654711434762; Wed, 08
 Jun 2022 11:03:54 -0700 (PDT)
MIME-Version: 1.0
References: <20220520125107.8423-1-cgzones@googlemail.com>
In-Reply-To: <20220520125107.8423-1-cgzones@googlemail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Wed, 8 Jun 2022 14:03:43 -0400
Message-ID: <CAP+JOzQgBDg5dJPLvMON9MOnqFsaOSjLZoQ6cpPEkbr=2N-S7A@mail.gmail.com>
Subject: Re: [PATCH] python/audit2allow: close file stream on error
To:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, May 23, 2022 at 4:10 AM Christian G=C3=B6ttsche
<cgzones@googlemail.com> wrote:
>
>     sepolgen-ifgen-attr-helper.c: In function =E2=80=98load_policy=E2=80=
=99:
>     sepolgen-ifgen-attr-helper.c:196:17: warning: leak of FILE =E2=80=98f=
p=E2=80=99 [CWE-775] [-Wanalyzer-file-leak]
>       196 |                 fprintf(stderr, "Out of memory!\n");
>           |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>

Acked-by: James Carter <jwcart2@gmail.com>

> ---
>  python/audit2allow/sepolgen-ifgen-attr-helper.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/python/audit2allow/sepolgen-ifgen-attr-helper.c b/python/aud=
it2allow/sepolgen-ifgen-attr-helper.c
> index 6f3ba962..5e6cffc1 100644
> --- a/python/audit2allow/sepolgen-ifgen-attr-helper.c
> +++ b/python/audit2allow/sepolgen-ifgen-attr-helper.c
> @@ -194,12 +194,14 @@ static policydb_t *load_policy(const char *filename=
)
>         policydb =3D malloc(sizeof(policydb_t));
>         if (policydb =3D=3D NULL) {
>                 fprintf(stderr, "Out of memory!\n");
> +               fclose(fp);
>                 return NULL;
>         }
>
>         if (policydb_init(policydb)) {
>                 fprintf(stderr, "Out of memory!\n");
>                 free(policydb);
> +               fclose(fp);
>                 return NULL;
>         }
>
> @@ -208,6 +210,7 @@ static policydb_t *load_policy(const char *filename)
>                 fprintf(stderr,
>                         "error(s) encountered while parsing configuration=
\n");
>                 free(policydb);
> +               fclose(fp);
>                 return NULL;
>         }
>
> --
> 2.36.1
>
