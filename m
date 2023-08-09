Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D92AC0015E
	for <selinux@archiver.kernel.org>; Wed,  9 Aug 2023 14:18:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232453AbjHIOSj (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 9 Aug 2023 10:18:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229882AbjHIOSj (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 9 Aug 2023 10:18:39 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CCA010F5
        for <selinux@vger.kernel.org>; Wed,  9 Aug 2023 07:18:38 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id 38308e7fff4ca-2b9c907bc68so107707811fa.2
        for <selinux@vger.kernel.org>; Wed, 09 Aug 2023 07:18:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691590716; x=1692195516;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MgEJhmhXUZr/4M4+koeQ4HuO5kB9drem6df+kH3MKvw=;
        b=SF0LDmCyARL167fvrO3+JFaBs3Zani46IhF1MkAjHUsyY2SnBrx9DjWYQuqXOXgDk5
         1GJCj3MKnrhfPc+to/8sQO0EAqnr94j/WktN9Ftu1GahNNtx9roImOHs4z75BYlKJoyx
         ij7u7XlcJgO7Qr5h5tzTsqWcAMtJCTbS/hFTfv3XmSeHyX+6vZ1/8YVqySy/oBY0kDjt
         X9dBlISDYZFQuL6HZWjWYLFFs5dyqEKXTEWBXsPD6wWBnTa0Ol6SQHptMoNPvvJyAPcJ
         pAMW4r8CN0NXfue1PXo/GL+Nv2m7qDs4msDeLkWONvlerxP8Nojsg/R1kD5jTf7Apes9
         FY7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691590716; x=1692195516;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MgEJhmhXUZr/4M4+koeQ4HuO5kB9drem6df+kH3MKvw=;
        b=I/pTTHIV8T1zf3UW47NqmLDUXlWaiheP+SiCOjqQ158gOZOsdF8mpODThMSw0EUVie
         4XUH9cEabvUhrw635RHG0o/Jw2QjtfpHAqeSAZnbh89CF4OTih3ei5ghoowiLpW2yYoh
         jo91icreNbTT9kW+kczmtobTgw2SGC6kTKRkxPKgw6aQLXMz1aLPQEh81cVdTbnDu/hg
         lq0KqTnVyzDfRkVFSWZO9gTPNvhK9lRCt2yq2Vb6TkmH+mCiC3j3JPphoIXqrBQxqOPE
         TncqGxbK66QN5C7N0HFJTMYglHFQv2DGN3rgK/TxMzc8TOZGEtV1RiCfa5sGsjTIIDfC
         MdSw==
X-Gm-Message-State: AOJu0YzgEIu+mlpAwqj/M6SbRItP2RMiRal53e3oSgW+diRiHswEOSv6
        t1RiL6bUfTEW12RSGChyKxbGPzLZwrSOVDbt/FUN2LEYbng=
X-Google-Smtp-Source: AGHT+IFQgHmxoqOtRG/CyGz/cXhSA4TfrmFq4JMZ9Kbo3igI7yedC46ol35De3goL9l8FzCzCbvs/5t+uMyKJMjjg8M=
X-Received: by 2002:a2e:9d88:0:b0:2b6:df25:1ab0 with SMTP id
 c8-20020a2e9d88000000b002b6df251ab0mr2132793ljj.34.1691590716285; Wed, 09 Aug
 2023 07:18:36 -0700 (PDT)
MIME-Version: 1.0
References: <20230805094418.18828-1-cgzones@googlemail.com>
In-Reply-To: <20230805094418.18828-1-cgzones@googlemail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Wed, 9 Aug 2023 10:18:25 -0400
Message-ID: <CAP+JOzTcZjH8kY5rgGb7SvcuVwMwZJ1Oah+g7fioizLMmTiy2A@mail.gmail.com>
Subject: Re: [PATCH] libsemanage/tests: use strict prototypes
To:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Sat, Aug 5, 2023 at 6:18=E2=80=AFAM Christian G=C3=B6ttsche
<cgzones@googlemail.com> wrote:
>
>     utilities.c:39:22: error: a function declaration without a prototype =
is deprecated in all versions of C [-Werror,-Wstrict-prototypes]
>     int create_test_store() {
>                          ^
>                           void
>     utilities.c:171:23: error: a function declaration without a prototype=
 is deprecated in all versions of C [-Werror,-Wstrict-prototypes]
>     int destroy_test_store() {
>                           ^
>                            void
>
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>

Acked-by: James Carter <jwcart2@gmail.com>

> ---
>  libsemanage/tests/utilities.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/libsemanage/tests/utilities.c b/libsemanage/tests/utilities.=
c
> index 71d7af1e..806869e0 100644
> --- a/libsemanage/tests/utilities.c
> +++ b/libsemanage/tests/utilities.c
> @@ -36,7 +36,7 @@ void test_msg_handler(void *varg, semanage_handle_t *ha=
ndle, const char *fmt,
>  {
>  }
>
> -int create_test_store() {
> +int create_test_store(void) {
>         FILE *fptr;
>
>         if (mkdir("test-policy", 0700) < 0)
> @@ -168,7 +168,7 @@ int write_test_policy_src(unsigned char *data, unsign=
ed int data_len) {
>         return 0;
>  }
>
> -int destroy_test_store() {
> +int destroy_test_store(void) {
>         FTS *ftsp =3D NULL;
>         FTSENT *curr =3D NULL;
>         int ret =3D 0;
> --
> 2.40.1
>
