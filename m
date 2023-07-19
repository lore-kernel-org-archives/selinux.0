Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92913C001B0
	for <selinux@archiver.kernel.org>; Wed, 19 Jul 2023 15:58:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230094AbjGSP6x (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 19 Jul 2023 11:58:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229752AbjGSP6w (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 19 Jul 2023 11:58:52 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3E36197
        for <selinux@vger.kernel.org>; Wed, 19 Jul 2023 08:58:50 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id 38308e7fff4ca-2b700e85950so104464091fa.3
        for <selinux@vger.kernel.org>; Wed, 19 Jul 2023 08:58:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689782329; x=1690387129;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=50yrXKwPWJywz9bsE6WP7k/g+SIbx/ynOBkh4FRR36c=;
        b=JYi4TKcC+p8FF4zXRURwXEbxcI2el+P0xW4u3RuK6n3EBtKCBIQIHiPVBzVjhO0IkX
         YQ7XKpzZsZDyWHTKJngpmco/H98eynCIUjpCwGgiYnTy4nsPS4dpNfJkiXZ8uGYUWDmd
         5+KU9BjHfo9BiLaX6DUozHKT4UvLVEnDb+iDcizh1VQOZ7eghbN7DARhD0mumuaxkL5C
         3e5AeCzKVrwHYwMq/RrJcWoFFMsLNAfqxO5/yvhe+DbWmJOVMNJWyhSrsmZEXlwexmrS
         GByDULT2vPWOZCmOPqpGs3BPnpYmppwMrectwDtR2JCxLPZfKlSnqOAyuTj2e1EAkkzz
         SDnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689782329; x=1690387129;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=50yrXKwPWJywz9bsE6WP7k/g+SIbx/ynOBkh4FRR36c=;
        b=DRdREHC3ZbCWKIY9ZlXIR1XD/1KJo+vi53ZyRh4nALOVJkZiI55AepdIEkEEhssHxG
         sW0OEYpqKEgLqn6xLsc+h560PiXoVSfAtHMoZvLPNWQtU6FXFe1a3tq8V8FC7W5nO4FM
         XeO3S6DBpFuEMQIQrk7aJa8F5RwpspyxQ0MiH6jP7wl7+wYOZUTAja/PwiPXpIH8mMBJ
         cTixTfTLX1+J3mTJjnovbuwPtjVSeKxNdVKnzhtc5RHvNybHZo1TcfeDkj0hqfXw/ZWj
         PMGbERQ3Ai2Y5URFa6AxrlJG4UnudItcLd8BXC5MIgXKBOqlAnFFjoEyRSu8JTo1lEs2
         QeTQ==
X-Gm-Message-State: ABy/qLZWMTwFUoemnW98aZs/7f/W0SfZFMrBOrwd19KfawEF5rAZ+UA7
        JJCRMOt/UOSufMhlQ/345DZmPwv6wD3HAb2pWvc=
X-Google-Smtp-Source: APBJJlEE99MoRY78U+tmR8fBkQgE3vDwVwyt5FjNU8CZ5FPcT8K/os+sgDKm54zJz/s8pcJNTx5mcZiusmA7yVoNsX0=
X-Received: by 2002:a2e:80cd:0:b0:2b5:9f54:e28b with SMTP id
 r13-20020a2e80cd000000b002b59f54e28bmr288360ljg.7.1689782328820; Wed, 19 Jul
 2023 08:58:48 -0700 (PDT)
MIME-Version: 1.0
References: <20230706145335.71452-1-cgzones@googlemail.com>
In-Reply-To: <20230706145335.71452-1-cgzones@googlemail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Wed, 19 Jul 2023 11:58:37 -0400
Message-ID: <CAP+JOzQ00KQ4-XuE3jXLG76jNfXmfxs1r5_2_8tX+MhGjNyUrg@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] semodule_expand: update
To:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Jul 6, 2023 at 10:54=E2=80=AFAM Christian G=C3=B6ttsche
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
> Add help argument option -h.
> Set close-on-exec flag in case of any sibling threads.
>
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>

For this series of four patches:
Acked-by: James Carter <jwcart2@gmail.com>

> ---
> v2:
>   - address comments by Jim:
>     * drop exit() calls
>     * reduce to only one final return statement
>   - add help argument option -h
>   - set close-on-exec flag
> ---
>  .../semodule_expand/semodule_expand.8         |   5 +-
>  .../semodule_expand/semodule_expand.c         | 112 +++++++++++-------
>  2 files changed, 73 insertions(+), 44 deletions(-)
>
> diff --git a/semodule-utils/semodule_expand/semodule_expand.8 b/semodule-=
utils/semodule_expand/semodule_expand.8
> index 1b482a1f..84b943cd 100644
> --- a/semodule-utils/semodule_expand/semodule_expand.8
> +++ b/semodule-utils/semodule_expand/semodule_expand.8
> @@ -3,7 +3,7 @@
>  semodule_expand \- Expand a SELinux policy module package.
>
>  .SH SYNOPSIS
> -.B semodule_expand [-V ] [ -a ] [ -c [version]] basemodpkg outputfile
> +.B semodule_expand [-ahV] [ -c [version]] basemodpkg outputfile
>  .br
>  .SH DESCRIPTION
>  .PP
> @@ -17,6 +17,9 @@ together a set of packages into a single package).
>
>  .SH "OPTIONS"
>  .TP
> +.B \-h
> +show help
> +.TP
>  .B \-V
>  show version
>  .TP
> diff --git a/semodule-utils/semodule_expand/semodule_expand.c b/semodule-=
utils/semodule_expand/semodule_expand.c
> index 895cdd78..99380abe 100644
> --- a/semodule-utils/semodule_expand/semodule_expand.c
> +++ b/semodule-utils/semodule_expand/semodule_expand.c
> @@ -21,32 +21,25 @@
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
> -static __attribute__((__noreturn__)) void usage(const char *program_name=
)
> +static void usage(const char *program_name)
>  {
> -       printf("usage: %s [-V -a -c [version]] basemodpkg outputfile\n",
> +       printf("usage: %s [-h -V -a -c [version] -v] basemodpkg outputfil=
e\n",
>                program_name);
> -       exit(1);
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
> -
> -       while ((ch =3D getopt(argc, argv, "c:Vva")) !=3D EOF) {
> +       const char *basename, *outname;
> +       int ch, ret, show_version =3D 0, verbose =3D 0, policyvers =3D 0,=
 check_assertions =3D 1;
> +       struct sepol_policy_file *pf =3D NULL;
> +       sepol_module_package_t *base =3D NULL;
> +       sepol_policydb_t *out =3D NULL, *p;
> +       FILE *fp =3D NULL, *outfile =3D NULL;
> +       sepol_handle_t *handle =3D NULL;
> +
> +       while ((ch =3D getopt(argc, argv, "c:Vvah")) !=3D EOF) {
>                 switch (ch) {
>                 case 'V':
>                         show_version =3D 1;
> @@ -54,14 +47,20 @@ int main(int argc, char **argv)
>                 case 'v':
>                         verbose =3D 1;
>                         break;
> +               case 'h':
> +                       usage(argv[0]);
> +                       return EXIT_SUCCESS;
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
> +                                       return EXIT_FAILURE;
>                                 }
>                                 if (n < sepol_policy_kern_vers_min()
>                                     || n > sepol_policy_kern_vers_max()) =
{
> @@ -71,7 +70,7 @@ int main(int argc, char **argv)
>                                                 sepol_policy_kern_vers_mi=
n(),
>                                                 sepol_policy_kern_vers_ma=
x());
>                                         usage(argv[0]);
> -                                       exit(1);
> +                                       return EXIT_FAILURE;
>                                 }
>                                 policyvers =3D n;
>                                 break;
> @@ -82,6 +81,7 @@ int main(int argc, char **argv)
>                         }
>                 default:
>                         usage(argv[0]);
> +                       return EXIT_FAILURE;
>                 }
>         }
>
> @@ -92,84 +92,90 @@ int main(int argc, char **argv)
>
>         if (show_version) {
>                 printf("%s\n", EXPANDPOLICY_VERSION);
> -               exit(0);
> +               return EXIT_SUCCESS;
>         }
>
>         /* check args */
> -       if (argc < 3 || !(optind !=3D (argc - 1))) {
> +       if (argc < 3 || argc - optind !=3D 2) {
>                 fprintf(stderr,
>                         "%s:  You must provide the base module package an=
d output filename\n",
>                         argv[0]);
>                 usage(argv[0]);
> +               return EXIT_FAILURE;
>         }
>
>         basename =3D argv[optind++];
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
> -       fp =3D fopen(basename, "r");
> +
> +       fp =3D fopen(basename, "re");
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
> -       outfile =3D fopen(outname, "w");
> +       outfile =3D fopen(outname, "we");
>         if (!outfile) {
> -               perror(outname);
> -               exit(1);
> +               fprintf(stderr, "%s:  Can't open '%s':  %s\n",
> +                       argv[0], outname, strerror(errno));
> +               goto failure;
>         }
>
>         sepol_policy_file_set_fp(pf, outfile);
> @@ -178,12 +184,32 @@ int main(int argc, char **argv)
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
> +       goto cleanup;
> +
> +failure:
> +       ret =3D EXIT_FAILURE;
> +
> +cleanup:
> +       if (outfile)
> +               fclose(outfile);
>         sepol_policydb_free(out);
> +       if (fp)
> +               fclose(fp);
> +       sepol_module_package_free(base);
>         sepol_policy_file_free(pf);
> +       sepol_handle_destroy(handle);
>
> -       return 0;
> +       return ret;
>  }
> --
> 2.40.1
>
