Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E89EAEB64DD
	for <selinux@archiver.kernel.org>; Tue, 11 Jul 2023 19:47:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229512AbjGKTro (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 11 Jul 2023 15:47:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230180AbjGKTrn (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 11 Jul 2023 15:47:43 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8441010E7
        for <selinux@vger.kernel.org>; Tue, 11 Jul 2023 12:47:42 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id 38308e7fff4ca-2b701dee4bfso100924221fa.0
        for <selinux@vger.kernel.org>; Tue, 11 Jul 2023 12:47:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689104861; x=1691696861;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lLsXdZUwGnqBixe/a1vwq7SNGucWNc8RoJK5E31v37M=;
        b=gFSrhpIwZIrgCyuKzG7RLZFaqhGOBGwaNFOqbgwJDXJk60NfaOIphG3P96yzXRBhpH
         MwUSvSLjzgshOHeMtT7MSNe3Uqx0MUevpcTQpKeLmWY8Ilkx4YXlw5MxmIIleRoOXFvR
         LDAnwDdS7PXvNCBghJCHFuyLKVQz1QtRYD5mQJU8RUm/IxzdIyFqd043PqqFLfw4nqGG
         RSts2M31+wAV6SLzC8AFPf2Mq2oVSkANKJzCEk4edvg7epBHOwp7WsuDinpzv6NKZXrU
         JBVOF72WNVP8zRNCXSsjwpzZFCv3qF2eK0Nk8p5JQA6aAkRGSfJ7pmcV6dLMARMcijWY
         k3GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689104861; x=1691696861;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lLsXdZUwGnqBixe/a1vwq7SNGucWNc8RoJK5E31v37M=;
        b=NZ0qvXa9zTL6kARcJxQ15Srhi+3l4Mnu9hDvJnlmrvbgHhrKSdH0zwHu9GgIWD+Og4
         Ow1vlO0gEeE52DdPHNrwfFnTHKPKMpeTYHnzMZUPXFTZkxCifbNVE3BD4wQtTkFQ7+6V
         mXaTVKz6/Evsm1O9K6qmLvrp9d4ynvnBT+abNJHqxoSmlf8eGZXupTBZxbS9efCaDbge
         Yzr3SdkLL4+WGSRSPimofTEOWdVJqyt16ttjKm8K8tyl5L3cbwdh+HqrC6jltkyJtUM3
         njiyBOEhufNNHVeTyP/jFPqgEov0GAG0qgr3kKqHlvqv/rqJinlBWoXxU59xBwwEe5p0
         7vOg==
X-Gm-Message-State: ABy/qLa9gp0NVSWOQmNeq+Z8ECQ+LA76HtyfVYxRZfXSBrro9wr3E2sW
        7awO8LmOkeH8rHPS/sI7WJNFQoFhqMpOnjyNStDy/B7wDp0=
X-Google-Smtp-Source: APBJJlFOjKhAHvMhWH5tPH3+55BYntSEMNvlgh9Rv1O2zr50AZD2cD4fnIhlUdkStx6gz1Br8sNRNAsydjLUIaxzE2g=
X-Received: by 2002:a2e:8902:0:b0:2b6:de6d:8148 with SMTP id
 d2-20020a2e8902000000b002b6de6d8148mr14077317lji.31.1689104860524; Tue, 11
 Jul 2023 12:47:40 -0700 (PDT)
MIME-Version: 1.0
References: <20230706140233.45990-1-cgzones@googlemail.com>
In-Reply-To: <20230706140233.45990-1-cgzones@googlemail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Tue, 11 Jul 2023 15:47:28 -0400
Message-ID: <CAP+JOzSsg_N8CGNAmMZfatcPC-XfjKANAr6W=Ld_r6R9UeyG=w@mail.gmail.com>
Subject: Re: [PATCH] libsepol/fuzz: more strict fuzzing of binary policies
To:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Jul 6, 2023 at 10:06=E2=80=AFAM Christian G=C3=B6ttsche
<cgzones@googlemail.com> wrote:
>
> Validate policy after optimizing.
>
> Run policy assertion check, ignoring any assertions.
>
> Abort on failures writing the parsed policy, as writing should not fail o=
n
> validated policies.
>
> Set close-on-exec flag in case of any sibling thread.
>
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>

Acked-by: James Carter <jwcart2@gmail.com>

> ---
>  libsepol/fuzz/binpolicy-fuzzer.c | 21 ++++++++++++++++-----
>  1 file changed, 16 insertions(+), 5 deletions(-)
>
> diff --git a/libsepol/fuzz/binpolicy-fuzzer.c b/libsepol/fuzz/binpolicy-f=
uzzer.c
> index 85c59645..79d42b0e 100644
> --- a/libsepol/fuzz/binpolicy-fuzzer.c
> +++ b/libsepol/fuzz/binpolicy-fuzzer.c
> @@ -3,6 +3,8 @@
>  #include <sepol/kernel_to_conf.h>
>  #include <sepol/policydb/policydb.h>
>
> +extern int policydb_validate(sepol_handle_t *handle, const policydb_t *p=
);
> +
>  extern int LLVMFuzzerTestOneInput(const uint8_t *data, size_t size);
>
>  static int write_binary_policy(policydb_t *p, FILE *outfp)
> @@ -38,18 +40,27 @@ int LLVMFuzzerTestOneInput(const uint8_t *data, size_=
t size)
>         if (policydb_load_isids(&policydb, &sidtab))
>                 goto exit;
>
> -       if (policydb.policy_type =3D=3D POLICY_KERN)
> +       if (policydb.policy_type =3D=3D POLICY_KERN) {
>                 (void) policydb_optimize(&policydb);
>
> -       devnull =3D fopen("/dev/null", "w");
> +               if (policydb_validate(NULL, &policydb) =3D=3D -1)
> +                       abort();
> +       }
> +
> +       (void) check_assertions(NULL, &policydb, policydb.global->branch_=
list->avrules);
> +
> +       devnull =3D fopen("/dev/null", "we");
>         if (!devnull)
>                 goto exit;
>
> -       (void) write_binary_policy(&policydb, devnull);
> +       if (write_binary_policy(&policydb, devnull))
> +               abort();
>
> -       (void) sepol_kernel_policydb_to_conf(devnull, &policydb);
> +       if (sepol_kernel_policydb_to_conf(devnull, &policydb))
> +               abort();
>
> -       (void) sepol_kernel_policydb_to_cil(devnull, &policydb);
> +       if (sepol_kernel_policydb_to_cil(devnull, &policydb))
> +               abort();
>
>  exit:
>         if (devnull !=3D NULL)
> --
> 2.40.1
>
