Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D28E4C7EE25
	for <selinux@archiver.kernel.org>; Fri,  9 Jun 2023 19:25:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230062AbjFITZR (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 9 Jun 2023 15:25:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231232AbjFITZQ (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 9 Jun 2023 15:25:16 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC61C2D74
        for <selinux@vger.kernel.org>; Fri,  9 Jun 2023 12:25:14 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id 38308e7fff4ca-2b1c5a6129eso23698011fa.2
        for <selinux@vger.kernel.org>; Fri, 09 Jun 2023 12:25:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686338713; x=1688930713;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=shpwywNU1en+MG/dqFhCVUPfLkc/L2UKRvT7EBVaRMI=;
        b=QP1NJE+aH9rIbiNesz/Oa4gpj9RNlV+rv3iPAZq186CsR4EhR7n+KJvZTD+vMyph+9
         zHM00ef1f+OGdZg5gPwFlKd8xUnbzZLwfKGrHUSBtIsw+MC1zDDhfMvJ0NUt0oB5f+ur
         7/Z+ssmpgRZn34IbYrF+WOBnF1qVbX214SAtRpwukTW91gd3TV5JVSzyRVLpGOytIO8C
         Zq1blj7cPjf6OYHutfNloPcHBowuKQXTbWOjizJ16pWHrbLxcc0yGl9liy7iHnLEeSLg
         jDOzMI1b9aysm4LRG7qbCF6ObfBdaM10mcwbAqOFxkBHmteRcSm2RX1dnWekKZIlIsua
         95FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686338713; x=1688930713;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=shpwywNU1en+MG/dqFhCVUPfLkc/L2UKRvT7EBVaRMI=;
        b=kkrDFarHmiONeI5S8jgTKqdQmmLYVe1J310QnGOlwCrC0y+XpppVw77yUlyH0G9S1B
         Nlm3V+zALcY+eFWgYIp0IdOTsXAstJoSAi1/mVJCIW1T4gDxPE02nTa4fZltYbjyeX1V
         e3XaVwV5pDgwMJRg9WTcqkzuTVQZ8bQ5qEH97tl4cL+esTLDdEA/CnPzhTGOlgQlwa7o
         tBr1HVWjGl43+UFmsG+ZDB3DDUX3SNPmmh2Fn4AgMRNsCRIK6cBPL+6pzv50IxwgRkfy
         yDonw/XY5oM8t+vI9eF2UqH8VX2d/Lr33Mi0KCwyW5OSyHVTEMkfxJdCm5qpoIaFQ9YD
         /3Qw==
X-Gm-Message-State: AC+VfDzkVdK6/UkpCVajilXxhHfCfhWLY2IVrQmIsH+ixzlOw1FFHH0j
        M4PeOJwYY7jMtQmY7SJJPK893xXdpxywhaC0hHuFubdZ
X-Google-Smtp-Source: ACHHUZ7ImDDdvtz5hje8cfxavk9UVGI2seEqTCAwmmMoxHyEjMc/aSpaoaYW/HsQWDsn/5mjzcSVa9kcDOpllkW/mdg=
X-Received: by 2002:a2e:b0db:0:b0:2b1:b953:9aa2 with SMTP id
 g27-20020a2eb0db000000b002b1b9539aa2mr1750187ljl.21.1686338712603; Fri, 09
 Jun 2023 12:25:12 -0700 (PDT)
MIME-Version: 1.0
References: <20230512110730.78672-1-cgzones@googlemail.com>
In-Reply-To: <20230512110730.78672-1-cgzones@googlemail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Fri, 9 Jun 2023 15:25:00 -0400
Message-ID: <CAP+JOzTLcXEqeKxG1cpGNC724A0Q18hTHydM3miJhETMsRMR+A@mail.gmail.com>
Subject: Re: [RFC PATCH 1/4] semodule_expand: update
To:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, May 12, 2023 at 7:28=E2=80=AFAM Christian G=C3=B6ttsche
<cgzones@googlemail.com> wrote:
>
> Drop unnecessary declarations.
> Reduce scope of file global variable.
> Mention -v argument in help usage message.
> More strict integer conversion.
> More strict argument count checking.
> Check closing file for incomplete write.
> Rework resource cleanup, so that all files and allocated memory are
> released in all branches, useful to minimize reports while debugging
> libsepol under valgrind(8) or sanitizers.
>
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
> ---
>  .../semodule_expand/semodule_expand.c         | 91 +++++++++++--------
>  1 file changed, 55 insertions(+), 36 deletions(-)
>
> diff --git a/semodule-utils/semodule_expand/semodule_expand.c b/semodule-=
utils/semodule_expand/semodule_expand.c
> index 895cdd78..8d9feb05 100644
> --- a/semodule-utils/semodule_expand/semodule_expand.c
> +++ b/semodule-utils/semodule_expand/semodule_expand.c
> @@ -21,30 +21,24 @@
>  #include <unistd.h>
>  #include <string.h>
>
> -extern char *optarg;
> -extern int optind;
> -
> -int policyvers =3D 0;
> -
>  #define EXPANDPOLICY_VERSION "1.0"
>
>  static __attribute__((__noreturn__)) void usage(const char *program_name=
)
>  {
> -       printf("usage: %s [-V -a -c [version]] basemodpkg outputfile\n",
> +       printf("usage: %s [-V -a -c [version] -v] basemodpkg outputfile\n=
",
>                program_name);
>         exit(1);

If you are going to use EXIT_FAILURE, then all the uses of "exit(1)"
should be removed.

>  }
>
>  int main(int argc, char **argv)
>  {
> -       char *basename, *outname;
> -       int ch, ret, show_version =3D 0, verbose =3D 0;
> -       struct sepol_policy_file *pf;
> -       sepol_module_package_t *base;
> -       sepol_policydb_t *out, *p;
> -       FILE *fp, *outfile;
> -       int check_assertions =3D 1;
> -       sepol_handle_t *handle;
> +       const char *basename, *outname;
> +       int ch, ret, show_version =3D 0, verbose =3D 0, policyvers =3D 0,=
 check_assertions =3D 1;
> +       struct sepol_policy_file *pf =3D NULL;
> +       sepol_module_package_t *base =3D NULL;
> +       sepol_policydb_t *out =3D NULL, *p;
> +       FILE *fp =3D NULL, *outfile =3D NULL;
> +       sepol_handle_t *handle =3D NULL;
>
>         while ((ch =3D getopt(argc, argv, "c:Vva")) !=3D EOF) {
>                 switch (ch) {
> @@ -55,13 +49,15 @@ int main(int argc, char **argv)
>                         verbose =3D 1;
>                         break;
>                 case 'c':{
> -                               long int n =3D strtol(optarg, NULL, 10);
> +                               long int n;
> +
> +                               errno =3D 0;
> +                               n =3D strtol(optarg, NULL, 10);
>                                 if (errno) {
>                                         fprintf(stderr,
>                                                 "%s:  Invalid policyvers =
specified: %s\n",
>                                                 argv[0], optarg);
>                                         usage(argv[0]);
> -                                       exit(1);
>                                 }
>                                 if (n < sepol_policy_kern_vers_min()
>                                     || n > sepol_policy_kern_vers_max()) =
{
> @@ -71,7 +67,6 @@ int main(int argc, char **argv)
>                                                 sepol_policy_kern_vers_mi=
n(),
>                                                 sepol_policy_kern_vers_ma=
x());
>                                         usage(argv[0]);
> -                                       exit(1);
>                                 }
>                                 policyvers =3D n;
>                                 break;
> @@ -96,7 +91,7 @@ int main(int argc, char **argv)
>         }
>
>         /* check args */
> -       if (argc < 3 || !(optind !=3D (argc - 1))) {
> +       if (argc < 3 || argc - optind !=3D 2) {
>                 fprintf(stderr,
>                         "%s:  You must provide the base module package an=
d output filename\n",
>                         argv[0]);
> @@ -107,69 +102,74 @@ int main(int argc, char **argv)
>         outname =3D argv[optind];
>
>         handle =3D sepol_handle_create();
> -       if (!handle)
> -               exit(1);
> +       if (!handle) {
> +               fprintf(stderr, "%s:  Out of memory\n", argv[0]);
> +               goto failure;
> +       }
>
>         if (sepol_policy_file_create(&pf)) {
>                 fprintf(stderr, "%s:  Out of memory\n", argv[0]);
> -               exit(1);
> +               goto failure;
>         }
>
>         /* read the base module */
>         if (sepol_module_package_create(&base)) {
>                 fprintf(stderr, "%s:  Out of memory\n", argv[0]);
> -               exit(1);
> +               goto failure;
>         }
> +
>         fp =3D fopen(basename, "r");
>         if (!fp) {
>                 fprintf(stderr, "%s:  Can't open '%s':  %s\n",
>                         argv[0], basename, strerror(errno));
> -               exit(1);
> +               goto failure;
>         }
> +
>         sepol_policy_file_set_fp(pf, fp);
>         ret =3D sepol_module_package_read(base, pf, 0);
>         if (ret) {
>                 fprintf(stderr, "%s:  Error in reading package from %s\n"=
,
>                         argv[0], basename);
> -               exit(1);
> +               goto failure;
>         }
> +
>         fclose(fp);
> +       fp =3D NULL;
>
>         /* linking the base takes care of enabling optional avrules */
>         p =3D sepol_module_package_get_policy(base);
>         if (sepol_link_modules(handle, p, NULL, 0, 0)) {
>                 fprintf(stderr, "%s:  Error while enabling avrules\n", ar=
gv[0]);
> -               exit(1);
> +               goto failure;
>         }
>
>         /* create the output policy */
>
>         if (sepol_policydb_create(&out)) {
>                 fprintf(stderr, "%s:  Out of memory\n", argv[0]);
> -               exit(1);
> +               goto failure;
>         }
>
>         sepol_set_expand_consume_base(handle, 1);
>
>         if (sepol_expand_module(handle, p, out, verbose, check_assertions=
)) {
>                 fprintf(stderr, "%s:  Error while expanding policy\n", ar=
gv[0]);
> -               exit(1);
> +               goto failure;
>         }
>
>         if (policyvers) {
>                 if (sepol_policydb_set_vers(out, policyvers)) {
>                         fprintf(stderr, "%s:  Invalid version %d\n", argv=
[0],
>                                 policyvers);
> -                       exit(1);
> +                       goto failure;
>                 }
>         }
>
> -       sepol_module_package_free(base);
> -
>         outfile =3D fopen(outname, "w");
>         if (!outfile) {
> -               perror(outname);
> -               exit(1);
> +               fprintf(stderr, "%s:  Can't open '%s':  %s\n",
> +                       argv[0], outname, strerror(errno));
> +               goto failure;
>         }
>
>         sepol_policy_file_set_fp(pf, outfile);
> @@ -178,12 +178,31 @@ int main(int argc, char **argv)
>                 fprintf(stderr,
>                         "%s:  Error while writing expanded policy to %s\n=
",
>                         argv[0], outname);
> -               exit(1);
> +               goto failure;
>         }
> -       fclose(outfile);
> -       sepol_handle_destroy(handle);
> +
> +       ret =3D fclose(outfile);
> +       outfile =3D NULL;
> +       if (ret) {
> +               fprintf(stderr, "%s:  Error closing policy file %s:  %s\n=
",
> +                       argv[0], outname, strerror(errno));
> +               goto failure;
> +       }
> +
> +       ret =3D EXIT_SUCCESS;
> +cleanup:
> +       if (outfile)
> +               fclose(outfile);
>         sepol_policydb_free(out);
> +       if (fp)
> +               fclose(fp);
> +       sepol_module_package_free(base);
>         sepol_policy_file_free(pf);
> +       sepol_handle_destroy(handle);
> +
> +       return ret;
>
> -       return 0;
> +failure:
> +       ret =3D EXIT_FAILURE;
> +       goto cleanup;
>  }

I would prefer to have the return at the end.
Something like this:

  ret =3D EXIT_SUCCESS;
  goto cleanup;
failure:
  ret =3D EXIT_FAILURE;
cleanup:
...
  return ret;
}

Thanks,
Jim

> --
> 2.40.1
>
