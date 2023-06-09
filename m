Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88424C7EE29
	for <selinux@archiver.kernel.org>; Fri,  9 Jun 2023 19:36:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229595AbjFITgZ (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 9 Jun 2023 15:36:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231181AbjFITgY (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 9 Jun 2023 15:36:24 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF15A3594
        for <selinux@vger.kernel.org>; Fri,  9 Jun 2023 12:36:19 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id 38308e7fff4ca-2b1a6a8e851so24298981fa.2
        for <selinux@vger.kernel.org>; Fri, 09 Jun 2023 12:36:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686339377; x=1688931377;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OywCBlB+TnCNOF8PSu4DVHO+i6TGE0qqqWttHtS8ab4=;
        b=eC39qcMw5vz4tNeMgntx40+zPiZR8+Xgvo/OjgWDDjThQ5ppi6srfBo3kWY3VaZaIA
         vZKEssytQuS0vV34ZCmPD6WUPo4izwzt/52wKReETfMg/QrxxZ+LXAHgVz3F7oE9z9fG
         uLfH3XSluwUwHVzbriiM7PzECyud7iQO8RJfIAqp221O0EsZSTdcegnqdJ5q3kfs7jIh
         IfWJhQn5RozEt48QG3gefQdVO7v8W8PHCbjh611Ir62GgPA18FRr4U7J6UHgcVcK2o0U
         p16HOJeIYA0sIJrNFV9ZKUuwaugQbXW3MRJztRsRHH61ZWh6mMJFkuMMrxVeyTTcZHpV
         OZMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686339377; x=1688931377;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OywCBlB+TnCNOF8PSu4DVHO+i6TGE0qqqWttHtS8ab4=;
        b=TvNis4tU3GBFgCtpXypjb7DXJzn4Qv1acSZhxLuJOYRbFB1k9uCwV3GvdbQnZPQykT
         5iJCcyFH8uAbFkWmgA5Xgv4l0wYIG/3hCMJMmyoZxdvMvRcspXTsyORVpv+9VMPoRVFb
         83B6G/OYnoXbukPodXxBiNoi1VdQdopxKABYXAfFrHSjHfN/9rCFUjcxOi1e3Ec7/5Wz
         bsX8NRJaV/14uuhGBcQIzPGXGyMPONI8Y7dDJrxGMf3e47OAiXg8Tf0nL3qeY5QRx0Oj
         ZnI9qprv3OyKWk/n1YBC6W5Vi415PJ8tcQvT2OAC3rR3xcVvcprtlp1nwLv47SWLfeO6
         H1ZA==
X-Gm-Message-State: AC+VfDz63q9HJuawWOEDhRvY6MumGuc7lIDLLEewgodFKZGOAVIDp1QB
        OZzc+hrlRFDyimHKMOZcDYWfGaGqzb3SOQYRfBEBQJjn
X-Google-Smtp-Source: ACHHUZ4CMv6TrxWzJUUJIl4l+qvEF9/JA/UNIxQMjZZyCWtj3UvNI55WZxi/N11vuCnScgG6OjLUDLqcK5esjYzP4Ag=
X-Received: by 2002:a2e:804b:0:b0:2b1:df76:294a with SMTP id
 p11-20020a2e804b000000b002b1df76294amr1708283ljg.43.1686339376492; Fri, 09
 Jun 2023 12:36:16 -0700 (PDT)
MIME-Version: 1.0
References: <20230512110730.78672-1-cgzones@googlemail.com> <20230512110730.78672-4-cgzones@googlemail.com>
In-Reply-To: <20230512110730.78672-4-cgzones@googlemail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Fri, 9 Jun 2023 15:36:04 -0400
Message-ID: <CAP+JOzTAFxddWDnwgszYLVm6+yq7LGYypHbs0bLd34Zgp44X+g@mail.gmail.com>
Subject: Re: [RFC PATCH 4/4] semodule_unpackage: update
To:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, May 12, 2023 at 7:22=E2=80=AFAM Christian G=C3=B6ttsche
<cgzones@googlemail.com> wrote:
>
> Drop unnecessary declarations.
> Check closing file for incomplete write.
> Rework resource cleanup, so that all files and allocated memory are
> released in all branches, useful to minimize reports while debugging
> libsepol under valgrind(8) or sanitizers.
>
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
> ---
>  .../semodule_package/semodule_unpackage.c     | 122 +++++++++++-------
>  1 file changed, 75 insertions(+), 47 deletions(-)
>
> diff --git a/semodule-utils/semodule_package/semodule_unpackage.c b/semod=
ule-utils/semodule_package/semodule_unpackage.c
> index b8c4fbce..21c97953 100644
> --- a/semodule-utils/semodule_package/semodule_unpackage.c
> +++ b/semodule-utils/semodule_package/semodule_unpackage.c
> @@ -11,8 +11,7 @@
>  #include <fcntl.h>
>  #include <errno.h>
>
> -char *progname =3D NULL;
> -extern char *optarg;
> +static const char *progname =3D NULL;

Can we get rid of the global here and just pass in the program name?

>
>  static __attribute__((__noreturn__)) void usage(void)
>  {
> @@ -20,84 +19,113 @@ static __attribute__((__noreturn__)) void usage(void=
)
>         exit(1);

Same comment as patch 1 about removing "exit(1)"

>  }
>
> -static int file_to_policy_file(const char *filename, struct sepol_policy=
_file **pf, const char *mode)
> -{
> -       FILE *f;
> -
> -       if (sepol_policy_file_create(pf)) {
> -               fprintf(stderr, "%s:  Out of memory\n", progname);
> -               return -1;
> -       }
> -
> -       f =3D fopen(filename, mode);
> -       if (!f) {
> -               fprintf(stderr, "%s:  Could not open file %s:  %s\n", pro=
gname, strerror(errno), filename);
> -               return -1;
> -       }
> -       sepol_policy_file_set_fp(*pf, f);
> -       return 0;
> -}
> -
>  int main(int argc, char **argv)
>  {
> -       struct sepol_module_package *pkg;
> -       struct sepol_policy_file *in, *out;
> -       FILE *fp;
> +       struct sepol_module_package *pkg =3D NULL;
> +       struct sepol_policy_file *in =3D NULL, *out =3D NULL;
> +       FILE *fp =3D NULL;
>         size_t len;
> -       char *ppfile, *modfile, *fcfile =3D NULL, *fcdata;
> +       const char *ppfile, *modfile, *fcfile =3D NULL, *fcdata;
> +       int ret;
>
>         progname =3D argv[0];
>
> -       if (argc < 3) {
> +       if (argc < 3)
>                 usage();
> -               exit(1);
> -       }
>
>         ppfile =3D argv[1];
>         modfile =3D argv[2];
>         if (argc >=3D 4)
>                 fcfile =3D argv[3];
>
> -       if (file_to_policy_file(ppfile, &in, "r"))
> -               exit(1);
> -
>         if (sepol_module_package_create(&pkg)) {
> -                fprintf(stderr, "%s:  Out of memory\n", progname);
> -                exit(1);
> +               fprintf(stderr, "%s:  Out of memory\n", progname);
> +               goto failure;
> +       }
> +
> +       if (sepol_policy_file_create(&in)) {
> +               fprintf(stderr, "%s:  Out of memory\n", progname);
> +               goto failure;
>         }
>
> +       fp =3D fopen(ppfile, "r");
> +       if (!fp) {
> +               fprintf(stderr, "%s:  Could not open file %s:  %s\n", pro=
gname, ppfile, strerror(errno));
> +               goto failure;
> +       }
> +       sepol_policy_file_set_fp(in, fp);
> +
>         if (sepol_module_package_read(pkg, in, 0) =3D=3D -1) {
> -                fprintf(stderr, "%s:  Error while reading policy module =
from %s\n",
> +               fprintf(stderr, "%s:  Error while reading policy module f=
rom %s\n",
>                         progname, ppfile);
> -                exit(1);
> +               goto failure;
>         }
>
> -       if (file_to_policy_file(modfile, &out, "w"))
> -               exit(1);
> +       sepol_policy_file_free(in);
> +       in =3D NULL;
> +       fclose(fp);
> +       fp =3D NULL;
>
> -        if (sepol_policydb_write(sepol_module_package_get_policy(pkg), o=
ut)) {
> -                fprintf(stderr, "%s:  Error while writing module to %s\n=
", progname, modfile);
> -                exit(1);
> -        }
> +       if (sepol_policy_file_create(&out)) {
> +               fprintf(stderr, "%s:  Out of memory\n", progname);
> +               goto failure;
> +       }
> +
> +       fp =3D fopen(modfile, "w");
> +       if (!fp) {
> +               fprintf(stderr, "%s:  Could not open file %s:  %s\n", pro=
gname, modfile, strerror(errno));
> +               goto failure;
> +       }
> +       sepol_policy_file_set_fp(out, fp);
> +
> +       if (sepol_policydb_write(sepol_module_package_get_policy(pkg), ou=
t)) {
> +               fprintf(stderr, "%s:  Error while writing module to %s\n"=
, progname, modfile);
> +               goto failure;
> +       }
> +
> +       ret =3D fclose(fp);
> +       fp =3D NULL;
> +       if (ret) {
> +               fprintf(stderr, "%s:  Error while closing file %s:  %s\n"=
, progname, modfile, strerror(errno));
> +               goto failure;
> +       }
>
> -       sepol_policy_file_free(in);
>         sepol_policy_file_free(out);
> +       out =3D NULL;
>
>         len =3D sepol_module_package_get_file_contexts_len(pkg);
>         if (fcfile && len) {
>                 fp =3D fopen(fcfile, "w");
>                 if (!fp) {
> -                       fprintf(stderr, "%s:  Could not open file %s:  %s=
\n", progname, strerror(errno), fcfile);
> -                       exit(1);
> +                       fprintf(stderr, "%s:  Could not open file %s:  %s=
\n", progname, fcfile, strerror(errno));
> +                       goto failure;
>                 }
>                 fcdata =3D sepol_module_package_get_file_contexts(pkg);
>                 if (fwrite(fcdata, 1, len, fp) !=3D len) {
> -                       fprintf(stderr, "%s:  Could not write file %s:  %=
s\n", progname, strerror(errno), fcfile);
> -                       exit(1);
> +                       fprintf(stderr, "%s:  Could not write file %s:  %=
s\n", progname, fcfile, strerror(errno));
> +                       goto failure;
> +               }
> +
> +               ret =3D fclose(fp);
> +               fp =3D NULL;
> +               if (ret) {
> +                       fprintf(stderr, "%s:  Could not close file %s:  %=
s\n", progname, fcfile, strerror(errno));
> +                       goto failure;
>                 }
> -               fclose(fp);
>         }
>
> +       ret =3D EXIT_SUCCESS;
> +
> +cleanup:
> +       if (fp)
> +               fclose(fp);
> +       sepol_policy_file_free(out);
>         sepol_module_package_free(pkg);
> -       exit(0);
> +       sepol_policy_file_free(in);
> +
> +       return ret;
> +
> +failure:
> +       ret =3D EXIT_FAILURE;
> +       goto cleanup;

Same comment as patch 1 about ending with "return ret".

Thanks,
Jim

>  }
> --
> 2.40.1
>
