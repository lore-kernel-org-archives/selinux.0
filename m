Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23B14C433E0
	for <selinux@archiver.kernel.org>; Mon,  4 Jan 2021 16:34:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E338D2245C
	for <selinux@archiver.kernel.org>; Mon,  4 Jan 2021 16:34:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727166AbhADQeZ (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 4 Jan 2021 11:34:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727032AbhADQeZ (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 4 Jan 2021 11:34:25 -0500
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35353C061574
        for <selinux@vger.kernel.org>; Mon,  4 Jan 2021 08:33:45 -0800 (PST)
Received: by mail-ot1-x336.google.com with SMTP id a109so26553239otc.1
        for <selinux@vger.kernel.org>; Mon, 04 Jan 2021 08:33:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=C/6W8j9xT8CiXl+0IuEcjds+TTF1+SEhkml8K+rBTpM=;
        b=RE1DRrMrvc/TmzyL7Qrl19mnBTe0P6U5gd1A96pK7ReiN/dK1PR207BhP6Aia3bQ1Y
         DLQ0CFnd4+JKQuCCdocpArIeMuYAFDCI4kemJDVZqpIvyRRww69zd2k6PBNDJUr9HgYF
         8YeULDTMi3+kNda74qKPHbY7wb7hTBEuTsCGs2CjzTe/fXveoScQIy7EZFdDVpnsQOQK
         fraSFZcX0LlO5GP4+b/f6ViI26SKKA4aDj1ZoWozrxP3Kgnw2KMjphKSwbLOzDYV6T7J
         ygJZqdJZgEhFb+HVoV9Kjpmst/mDPwkIHhkPvqPUYCQ2ogMsc72PdAmoMGjGMzbI2K1g
         0n4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=C/6W8j9xT8CiXl+0IuEcjds+TTF1+SEhkml8K+rBTpM=;
        b=YVgpNpfak2gf2l/SmTDFdLj3Mh9WIEi9/QflBGHiM4ehdZvCYIW/DIot/tmocAlyLq
         pGS4VFbqzDgjyGvUTj2Td2HOu+NQU6IqKuJheODGNlL1yQoS6wBOLgMVDkx0H/MDGOqX
         Yg9ro6WAHRPrh1wbBufec96uqqRkqtLObYxIjFBbuqnN04IBk5sRYAeyGPM2AqegPGTx
         +FkDg0LeHLnm433OgwGWesWkye8PXwsoJdG4kmj0PxsrsQ0jVbj01ECUFKtTv1yEctSi
         meg8MUf0IV0fdlbdNbuaFVlVC/sqPJyVq2EB4fw7WK+h46r005rIIS+HybHRlpT87Tt1
         EgKA==
X-Gm-Message-State: AOAM530aFUt4c5Q7HEeTTp0o2qDo5h+u6uGTpwWTtRyzmnkfWrwyJHQh
        Y0fM+HsD1Az+O2E4jmahmzaLm/2n7gbov5c+obvSgwNiVKg=
X-Google-Smtp-Source: ABdhPJxG3uPJQesBC12g5LfUQd9LLgfxNqngYyDs60/ZbCvN3FETQ7XZE3dQHzbQlul3HxJJsll3LlT/Jestb0Y5prQ=
X-Received: by 2002:a9d:27a7:: with SMTP id c36mr52783431otb.59.1609778024625;
 Mon, 04 Jan 2021 08:33:44 -0800 (PST)
MIME-Version: 1.0
References: <20201230100746.2549568-1-nicolas.iooss@m4x.org> <20201230100746.2549568-3-nicolas.iooss@m4x.org>
In-Reply-To: <20201230100746.2549568-3-nicolas.iooss@m4x.org>
From:   James Carter <jwcart2@gmail.com>
Date:   Mon, 4 Jan 2021 11:33:33 -0500
Message-ID: <CAP+JOzRqWHUkVfDsY+yijBEvhMf=52HqYD6vQfNLDdcn3hw+_g@mail.gmail.com>
Subject: Re: [PATCH 3/6] libsepol/cil: constify some strings
To:     Nicolas Iooss <nicolas.iooss@m4x.org>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Dec 30, 2020 at 5:09 AM Nicolas Iooss <nicolas.iooss@m4x.org> wrote=
:
>
> Function cil_add_file() copies its input into a newly-allocated buffer,
> and does not modify "name". State these properties in the types of
> parameters by adding "const" qualifiers.
>
> This enables using LibFuzzer directly on cil_add_file(), without a
> warning about discarding "const" qualifier:
>
>     fuzz-secilc.c: In function =E2=80=98LLVMFuzzerTestOneInput=E2=80=99:
>     fuzz-secilc.c:57:31: warning: passing argument 3 of =E2=80=98cil_add_=
file=E2=80=99
>     discards =E2=80=98const=E2=80=99 qualifier from pointer target type
>     [-Wdiscarded-qualifiers]
>        57 |  if (cil_add_file(db, "fuzz", data, size) !=3D SEPOL_OK)
>           |                               ^~~~
>     In file included from fuzz-secilc.c:26:
>     /usr/include/sepol/cil/cil.h:45:57: note: expected =E2=80=98char *=E2=
=80=99 but
>     argument is of type =E2=80=98const uint8_t *=E2=80=99 {aka =E2=80=98c=
onst unsigned char *=E2=80=99}
>        45 | extern int cil_add_file(cil_db_t *db, char *name, char *data,=
 size_t size);
>           |                                                   ~~~~~~^~~~
>
> Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>

Acked-by: James Carter <jwcart2@gmail.com>

> ---
>  libsepol/cil/include/cil/cil.h | 4 ++--
>  libsepol/cil/src/cil.c         | 2 +-
>  libsepol/cil/src/cil_log.c     | 6 +++---
>  libsepol/cil/src/cil_parser.c  | 2 +-
>  libsepol/cil/src/cil_parser.h  | 2 +-
>  5 files changed, 8 insertions(+), 8 deletions(-)
>
> diff --git a/libsepol/cil/include/cil/cil.h b/libsepol/cil/include/cil/ci=
l.h
> index f8cfc3be5015..e6f4503eb33a 100644
> --- a/libsepol/cil/include/cil/cil.h
> +++ b/libsepol/cil/include/cil/cil.h
> @@ -42,7 +42,7 @@ typedef struct cil_db cil_db_t;
>  extern void cil_db_init(cil_db_t **db);
>  extern void cil_db_destroy(cil_db_t **db);
>
> -extern int cil_add_file(cil_db_t *db, char *name, char *data, size_t siz=
e);
> +extern int cil_add_file(cil_db_t *db, const char *name, const char *data=
, size_t size);
>
>  extern int cil_compile(cil_db_t *db);
>  extern int cil_build_policydb(cil_db_t *db, sepol_policydb_t **sepol_db)=
;
> @@ -67,7 +67,7 @@ enum cil_log_level {
>         CIL_INFO
>  };
>  extern void cil_set_log_level(enum cil_log_level lvl);
> -extern void cil_set_log_handler(void (*handler)(int lvl, char *msg));
> +extern void cil_set_log_handler(void (*handler)(int lvl, const char *msg=
));
>
>  #ifdef __GNUC__
>  __attribute__ ((format(printf, 2, 3)))
> diff --git a/libsepol/cil/src/cil.c b/libsepol/cil/src/cil.c
> index bb7f06d5c4b3..99c8e288912c 100644
> --- a/libsepol/cil/src/cil.c
> +++ b/libsepol/cil/src/cil.c
> @@ -500,7 +500,7 @@ void cil_root_destroy(struct cil_root *root)
>         free(root);
>  }
>
> -int cil_add_file(cil_db_t *db, char *name, char *data, size_t size)
> +int cil_add_file(cil_db_t *db, const char *name, const char *data, size_=
t size)
>  {
>         char *buffer =3D NULL;
>         int rc;
> diff --git a/libsepol/cil/src/cil_log.c b/libsepol/cil/src/cil_log.c
> index b222b155120a..a8e4d2e94a78 100644
> --- a/libsepol/cil/src/cil_log.c
> +++ b/libsepol/cil/src/cil_log.c
> @@ -37,14 +37,14 @@
>
>  static enum cil_log_level cil_log_level =3D CIL_ERR;
>
> -void cil_default_log_handler(__attribute__((unused)) int lvl, char *msg)
> +void cil_default_log_handler(__attribute__((unused)) int lvl, const char=
 *msg)
>  {
>         fprintf(stderr, "%s", msg);
>  }
>
> -void (*cil_log_handler)(int lvl, char *msg) =3D &cil_default_log_handler=
;
> +void (*cil_log_handler)(int lvl, const char *msg) =3D &cil_default_log_h=
andler;
>
> -void cil_set_log_handler(void (*handler)(int lvl, char *msg))
> +void cil_set_log_handler(void (*handler)(int lvl, const char *msg))
>  {
>         cil_log_handler =3D handler;
>  }
> diff --git a/libsepol/cil/src/cil_parser.c b/libsepol/cil/src/cil_parser.=
c
> index a8af1dce2c4b..b62043b95806 100644
> --- a/libsepol/cil/src/cil_parser.c
> +++ b/libsepol/cil/src/cil_parser.c
> @@ -196,7 +196,7 @@ static void add_cil_path(struct cil_tree_node **curre=
nt, char *path)
>         insert_node(node, *current);
>  }
>
> -int cil_parser(char *_path, char *buffer, uint32_t size, struct cil_tree=
 **parse_tree)
> +int cil_parser(const char *_path, char *buffer, uint32_t size, struct ci=
l_tree **parse_tree)
>  {
>
>         int paren_count =3D 0;
> diff --git a/libsepol/cil/src/cil_parser.h b/libsepol/cil/src/cil_parser.=
h
> index 02ecb784e95c..1cec63944fdf 100644
> --- a/libsepol/cil/src/cil_parser.h
> +++ b/libsepol/cil/src/cil_parser.h
> @@ -32,6 +32,6 @@
>
>  #include "cil_tree.h"
>
> -int cil_parser(char *path, char *buffer, uint32_t size, struct cil_tree =
**parse_tree);
> +int cil_parser(const char *path, char *buffer, uint32_t size, struct cil=
_tree **parse_tree);
>
>  #endif /* CIL_PARSER_H_ */
> --
> 2.29.2
>
