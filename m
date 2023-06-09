Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73707C7EE25
	for <selinux@archiver.kernel.org>; Fri,  9 Jun 2023 19:27:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229829AbjFIT1x (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 9 Jun 2023 15:27:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231376AbjFIT1x (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 9 Jun 2023 15:27:53 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56C161BD6
        for <selinux@vger.kernel.org>; Fri,  9 Jun 2023 12:27:50 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id 38308e7fff4ca-2b203360d93so24431391fa.3
        for <selinux@vger.kernel.org>; Fri, 09 Jun 2023 12:27:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686338868; x=1688930868;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=np8smllD7Gp1HgNRPrRdB9e8fZloC+bv0RWbR6zQGcs=;
        b=QbF1Mfpmt0/pWB5KT7ENKvf8IGh0Ssw9qauLr7AOWcMp2xrOvwC8k7SL6Kmal6gnUy
         iksVru9XLAxP8lzjbeqybihODQbLi5VoITLcrCkSPpSavBageS3WU0H69JO8qFBEoCo9
         oVuGYyzNoA37BZ5UQduehjHmhz7cS0aQVDQr8bbB7iKwLr0nwfepnNxicNUOxWAq075j
         uJTzMSVN7zZDltN04InlYF48iaQXYg6222U91oTcuN9r4+3BVGomndo7KFkBS28rn4Nn
         250qvXus1saxGfzQ0K5dbxr4VpvPFDm/tMY2NJwte58KdoEcEfnC/98yHX6KrOsqainS
         K52g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686338868; x=1688930868;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=np8smllD7Gp1HgNRPrRdB9e8fZloC+bv0RWbR6zQGcs=;
        b=R+95OrcZcuNJ4bo8mK2aNd93BjLbEGTbjUiLTy94Apzt+l0Jr3oLv6tQ+PWWOCaey2
         Wcd1OXn+3Z/P0IX1sb/I6QGBH9gTKMNNOuFn/Ggir8dE713GdlW9w+8/Oo/ehioNn1fF
         TCqvLKTudBbKA22c3eFDZM11k4Hxh7YvjGA9qaHqxNRuq6XIQem32wGngJpzLY/tBLLZ
         extgROivx5+4uVvwxuarWxdv2XVhGjJq5a2gxlYgUVlB385Xp1UfFzxrKZ7zXEGTdg85
         syouB4a1h/LTAQki6D/cTHdX4JtYzveQOo+P81SI9Tr/aYHis/cBHUn6+zPW6U2Tjot/
         Z4bw==
X-Gm-Message-State: AC+VfDxVktTR17f9m59cN5AGe3jT7/l98e3SbrjySrne4OrQ60Tdqdjx
        joersHwfvuSrJPCl1zWHABsfGZ8tcjLrGp+ec8d3427c
X-Google-Smtp-Source: ACHHUZ5eEYxs6lfeKJ4luSXLSPI+z8pLNJu4HNJsPUkW+r61+aN80C+qFH/NLBAv5LircjmJszIDE5K+zAeDRMUya2M=
X-Received: by 2002:a2e:9881:0:b0:2ad:dab5:fe88 with SMTP id
 b1-20020a2e9881000000b002addab5fe88mr1726080ljj.42.1686338868218; Fri, 09 Jun
 2023 12:27:48 -0700 (PDT)
MIME-Version: 1.0
References: <20230512110730.78672-1-cgzones@googlemail.com> <20230512110730.78672-2-cgzones@googlemail.com>
In-Reply-To: <20230512110730.78672-2-cgzones@googlemail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Fri, 9 Jun 2023 15:27:36 -0400
Message-ID: <CAP+JOzS1DxTVHyeqv3cS9khrjBG8yOh38CW2qLz9o9wYk73MaQ@mail.gmail.com>
Subject: Re: [RFC PATCH 2/4] semodule_link: update
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
> More verbose error messages and add missing trailing newline.
> More strict argument count checking.
> Check closing file for incomplete write.
> Rework resource cleanup, so that all files and allocated memory are
> released in all branches, useful to minimize reports while debugging
> libsepol under valgrind(8) or sanitizers.
>
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
> ---
>  semodule-utils/semodule_link/semodule_link.c | 65 ++++++++++++--------
>  1 file changed, 38 insertions(+), 27 deletions(-)
>
> diff --git a/semodule-utils/semodule_link/semodule_link.c b/semodule-util=
s/semodule_link/semodule_link.c
> index 38a6843c..58a82cb0 100644
> --- a/semodule-utils/semodule_link/semodule_link.c
> +++ b/semodule-utils/semodule_link/semodule_link.c
> @@ -21,9 +21,7 @@
>
>  #define LINKPOLICY_VERSION "1.0"
>
> -char *progname;
> -extern char *optarg;
> -extern int optind;
> +static const char *progname;
>

Is there a reason that we can't eliminate this global and just pass in
the program name?

>  static __attribute__((__noreturn__)) void usage(const char *program_name=
)
>  {
> @@ -32,7 +30,7 @@ static __attribute__((__noreturn__)) void usage(const c=
har *program_name)
>         exit(1);

Same comment as for patch 1 about "exit(1)"

>  }
>
> -static sepol_module_package_t *load_module(char *filename)
> +static sepol_module_package_t *load_module(const char *filename)
>  {
>         int ret;
>         FILE *fp =3D NULL;
> @@ -49,7 +47,7 @@ static sepol_module_package_t *load_module(char *filena=
me)
>         }
>         fp =3D fopen(filename, "r");
>         if (!fp) {
> -               fprintf(stderr, "%s:  Could not open package %s:  %s", pr=
ogname,
> +               fprintf(stderr, "%s:  Could not open package %s:  %s\n", =
progname,
>                         filename, strerror(errno));
>                 goto bad;
>         }
> @@ -76,11 +74,10 @@ static sepol_module_package_t *load_module(char *file=
name)
>
>  int main(int argc, char **argv)
>  {
> -       int ch, i, show_version =3D 0, verbose =3D 0, num_mods;
> -       char *basename, *outname =3D NULL;
> -       sepol_module_package_t *base, **mods;
> -       FILE *outfile;
> -       struct sepol_policy_file *pf;
> +       int ch, i, ret, show_version =3D 0, verbose =3D 0, num_mods =3D 0=
;
> +       const char *basename, *outname =3D NULL;
> +       sepol_module_package_t *base =3D NULL, **mods =3D NULL;
> +       struct sepol_policy_file *pf =3D NULL;
>
>         progname =3D argv[0];
>
> @@ -106,7 +103,7 @@ int main(int argc, char **argv)
>         }
>
>         /* check args */
> -       if (argc < 3 || !(optind !=3D (argc - 1))) {
> +       if (argc < 3 || optind + 2 > argc) {
>                 fprintf(stderr,
>                         "%s:  You must provide the base module package an=
d at least one other module package\n",
>                         argv[0]);
> @@ -119,18 +116,15 @@ int main(int argc, char **argv)
>                 fprintf(stderr,
>                         "%s:  Could not load base module from file %s\n",
>                         argv[0], basename);
> -               exit(1);
> +               goto failure;
>         }
>
>         num_mods =3D argc - optind;
> -       mods =3D
> -           (sepol_module_package_t **) malloc(sizeof(sepol_module_packag=
e_t *)
> -                                              * num_mods);
> +       mods =3D calloc(num_mods, sizeof(sepol_module_package_t *));
>         if (!mods) {
>                 fprintf(stderr, "%s:  Out of memory\n", argv[0]);
> -               exit(1);
> +               goto failure;
>         }
> -       memset(mods, 0, sizeof(sepol_module_package_t *) * num_mods);
>
>         for (i =3D 0; optind < argc; optind++, i++) {
>                 mods[i] =3D load_module(argv[optind]);
> @@ -138,39 +132,56 @@ int main(int argc, char **argv)
>                         fprintf(stderr,
>                                 "%s:  Could not load module from file %s\=
n",
>                                 argv[0], argv[optind]);
> -                       exit(1);
> +                       goto failure;
>                 }
>         }
>
>         if (sepol_link_packages(NULL, base, mods, num_mods, verbose)) {
>                 fprintf(stderr, "%s:  Error while linking packages\n", ar=
gv[0]);
> -               exit(1);
> +               goto failure;
>         }
>
>         if (outname) {
> -               outfile =3D fopen(outname, "w");
> +               FILE *outfile =3D fopen(outname, "w");
>                 if (!outfile) {
> -                       perror(outname);
> -                       exit(1);
> +                       fprintf(stderr, "%s:  Could not open output file =
%s:  %s\n",
> +                               progname, outname, strerror(errno));
> +                       goto failure;
>                 }
>
>                 if (sepol_policy_file_create(&pf)) {
>                         fprintf(stderr, "%s:  Out of memory\n", argv[0]);
> -                       exit(1);
> +                       fclose(outfile);
> +                       goto failure;
>                 }
>                 sepol_policy_file_set_fp(pf, outfile);
>                 if (sepol_module_package_write(base, pf)) {
>                         fprintf(stderr, "%s:  Error writing linked packag=
e.\n",
>                                 argv[0]);
> -                       exit(1);
> +                       sepol_policy_file_free(pf);
> +                       fclose(outfile);
> +                       goto failure;
>                 }
>                 sepol_policy_file_free(pf);
> -               fclose(outfile);
> +
> +               if (fclose(outfile)) {
> +                       fprintf(stderr, "%s:  Error closing linked packag=
e:  %s\n",
> +                               argv[0], strerror(errno));
> +                       goto failure;
> +               }
>         }
>
> -       sepol_module_package_free(base);
> +       ret =3D EXIT_SUCCESS;
> +
> +cleanup:
>         for (i =3D 0; i < num_mods; i++)
>                 sepol_module_package_free(mods[i]);
>         free(mods);
> -       exit(0);
> +       sepol_module_package_free(base);
> +
> +       return ret;
> +
> +failure:
> +       ret =3D EXIT_FAILURE;
> +       goto cleanup;

Same comment as for patch 1 here as well.

Thanks,
Jim

>  }
> --
> 2.40.1
>
