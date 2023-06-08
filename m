Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A483C7EE29
	for <selinux@archiver.kernel.org>; Thu,  8 Jun 2023 20:59:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234257AbjFHU7v (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 8 Jun 2023 16:59:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236575AbjFHU7q (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 8 Jun 2023 16:59:46 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D10BD2697
        for <selinux@vger.kernel.org>; Thu,  8 Jun 2023 13:59:43 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id 2adb3069b0e04-4f658a17aa4so260920e87.0
        for <selinux@vger.kernel.org>; Thu, 08 Jun 2023 13:59:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686257982; x=1688849982;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lRvgJSNINulCtz6dlMM4nFiJrZ0O3j8LfEyrR9R5Soo=;
        b=R0V+TUU0xlRiRUKNKocLQgpeUNHExdzXHbXqU9KmMzaXYILeIvF7/a4QeOnJpUrQLY
         9fjqkO6Wb4Z3Gqf0YUQUsLrqlERfdpxKQBw5UYt18wDk8MLISux5esyH5pMBgxauoosG
         l6S/ew5lDyvG0xOkMjORwdoUJF6zTqczCthhvwbB4UfAFtx8gp2N40iiz1DK7MqhuRSV
         fN/Qcj8g1oyyI7Qubs+m1ZiFwrHfl/N12tw0GnepClnMziSgsvNm3jCriiQK9x01GtNN
         f8DMk65FgfUqktHjsUVxchcNXbTqReSaXT+EYL/yu8R1Fqw1I3vEOEzqgFBBCNU+hqlF
         et2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686257982; x=1688849982;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lRvgJSNINulCtz6dlMM4nFiJrZ0O3j8LfEyrR9R5Soo=;
        b=SyyacURaxeurfZibnVUDAxerQwtV1zngyn9XZiSVLEwESqwlEbgR9BMDqDCbb1iIBK
         tOFquttm+pozvtVZxxh7txwijiNGXHnvGyVogfvMhvbcjZG37mTk3zY8Tiz0FgNjAy1e
         pq3P1Ol93bRXuI6Bew9BrTG2ZheeZylsMoylxFfQuNsBAFaZ/mBqmXmsKDFTJFNkbHrw
         4kFIrGJhWTWbEKVBsUSnYGAiYO/1QFsL17BrS3PspHz3yTvz/ESMWUSW+a/JjPUyvy0w
         iazFtu8raz9fdDNR/55WwN66ddX+QsGzqXJB/zeSpOfuc8XJUQWJ67gx6zH65U1VlHEZ
         wepQ==
X-Gm-Message-State: AC+VfDwTZ5NjdVAIA8UNK9ZnHXRanesZ3rNs8MGXyL+XvJGoFthz/cm1
        VZV+WjHGEPoiBee7OKDojaQ/HCDq54CI6F9+UOj3NsIDvPM=
X-Google-Smtp-Source: ACHHUZ5hjxhbkKyezJDhgWloOU/eflO3+O1Uj0WXK9wO6tHQ/9UCc1eMbneIu65QnxJU5Dge/oT82yxW//JVDrUy3jY=
X-Received: by 2002:a2e:3c19:0:b0:2b2:104d:8f8d with SMTP id
 j25-20020a2e3c19000000b002b2104d8f8dmr1532929lja.7.1686257981677; Thu, 08 Jun
 2023 13:59:41 -0700 (PDT)
MIME-Version: 1.0
References: <20230331173442.101678-1-cgzones@googlemail.com> <20230512095749.59577-1-cgzones@googlemail.com>
In-Reply-To: <20230512095749.59577-1-cgzones@googlemail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Thu, 8 Jun 2023 16:59:30 -0400
Message-ID: <CAP+JOzTUSw7s0N5fqFUwCNmhrxpNLa4uA9y1r67Vx7_FkFd2pA@mail.gmail.com>
Subject: Re: [PATCH v2] checkpolicy: add option to skip checking neverallow rules
To:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, May 12, 2023 at 5:59=E2=80=AFAM Christian G=C3=B6ttsche
<cgzones@googlemail.com> wrote:
>
> Add the command line argument `-N/--disable-neverallow`, similar to
> secilc(8), to checkpolicy(8) and checkmodule(8) to skip the check of
> neverallow rule violations.
>
> This is mainly useful in development, e.g. to quickly add rules to a
> policy without fulfilling all neverallow rules or build policies with
> known violations.
>
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>

Acked-by: James Carter <jwcart2@gmail.com>

> ---
> v2:
>    invert variable logic from check_neverallow to disable_neverallow
> ---
>  checkpolicy/checkmodule.8 |  5 ++++-
>  checkpolicy/checkmodule.c | 13 +++++++++----
>  checkpolicy/checkpolicy.8 |  5 ++++-
>  checkpolicy/checkpolicy.c | 12 ++++++++----
>  4 files changed, 25 insertions(+), 10 deletions(-)
>
> diff --git a/checkpolicy/checkmodule.8 b/checkpolicy/checkmodule.8
> index 1061a6f2..ed9efd4c 100644
> --- a/checkpolicy/checkmodule.8
> +++ b/checkpolicy/checkmodule.8
> @@ -3,7 +3,7 @@
>  checkmodule \- SELinux policy module compiler
>  .SH SYNOPSIS
>  .B checkmodule
> -.I "[\-h] [\-b] [\-c policy_version] [\-C] [\-E] [\-m] [\-M] [\-U handle=
_unknown] [\-V] [\-o output_file] [input_file]"
> +.I "[\-h] [\-b] [\-c policy_version] [\-C] [\-E] [\-m] [\-M] [\-N] [\-U =
handle_unknown] [\-V] [\-o output_file] [input_file]"
>  .SH "DESCRIPTION"
>  This manual page describes the
>  .BR checkmodule
> @@ -43,6 +43,9 @@ Generate a non-base policy module.
>  .B \-M,\-\-mls
>  Enable the MLS/MCS support when checking and compiling the policy module=
.
>  .TP
> +.B \-N,\-\-disable-neverallow
> +Do not check neverallow rules.
> +.TP
>  .B \-V,\-\-version
>  Show policy versions created by this program.
>  .TP
> diff --git a/checkpolicy/checkmodule.c b/checkpolicy/checkmodule.c
> index 3432608b..14e6c891 100644
> --- a/checkpolicy/checkmodule.c
> +++ b/checkpolicy/checkmodule.c
> @@ -123,7 +123,7 @@ static int write_binary_policy(policydb_t * p, FILE *=
outfp)
>
>  static __attribute__((__noreturn__)) void usage(const char *progname)
>  {
> -       printf("usage:  %s [-h] [-V] [-b] [-C] [-E] [-U handle_unknown] [=
-m] [-M] [-o FILE] [-c VERSION] [INPUT]\n", progname);
> +       printf("usage:  %s [-h] [-V] [-b] [-C] [-E] [-U handle_unknown] [=
-m] [-M] [-N] [-o FILE] [-c VERSION] [INPUT]\n", progname);
>         printf("Build base and policy modules.\n");
>         printf("Options:\n");
>         printf("  INPUT      build module from INPUT (else read from \"%s=
\")\n",
> @@ -139,6 +139,7 @@ static __attribute__((__noreturn__)) void usage(const=
 char *progname)
>         printf("               allow: Allow unknown kernel checks\n");
>         printf("  -m         build a policy module instead of a base modu=
le\n");
>         printf("  -M         enable MLS policy\n");
> +       printf("  -N         do not check neverallow rules\n");
>         printf("  -o FILE    write module to FILE (else just check syntax=
)\n");
>         printf("  -c VERSION build a policy module targeting a modular po=
licy version (%d-%d)\n",
>                MOD_POLICYDB_VERSION_MIN, MOD_POLICYDB_VERSION_MAX);
> @@ -148,7 +149,7 @@ static __attribute__((__noreturn__)) void usage(const=
 char *progname)
>  int main(int argc, char **argv)
>  {
>         const char *file =3D txtfile, *outfile =3D NULL;
> -       unsigned int binary =3D 0, cil =3D 0;
> +       unsigned int binary =3D 0, cil =3D 0, disable_neverallow =3D 0;
>         int ch;
>         int show_version =3D 0;
>         policydb_t modpolicydb;
> @@ -159,12 +160,13 @@ int main(int argc, char **argv)
>                 {"version", no_argument, NULL, 'V'},
>                 {"handle-unknown", required_argument, NULL, 'U'},
>                 {"mls", no_argument, NULL, 'M'},
> +               {"disable-neverallow", no_argument, NULL, 'N'},
>                 {"cil", no_argument, NULL, 'C'},
>                 {"werror", no_argument, NULL, 'E'},
>                 {NULL, 0, NULL, 0}
>         };
>
> -       while ((ch =3D getopt_long(argc, argv, "ho:bVEU:mMCc:", long_opti=
ons, NULL)) !=3D -1) {
> +       while ((ch =3D getopt_long(argc, argv, "ho:bVEU:mMNCc:", long_opt=
ions, NULL)) !=3D -1) {
>                 switch (ch) {
>                 case 'h':
>                         usage(argv[0]);
> @@ -202,6 +204,9 @@ int main(int argc, char **argv)
>                 case 'M':
>                         mlspol =3D 1;
>                         break;
> +               case 'N':
> +                       disable_neverallow =3D 1;
> +                       break;
>                 case 'C':
>                         cil =3D 1;
>                         break;
> @@ -317,7 +322,7 @@ int main(int argc, char **argv)
>                         fprintf(stderr, "%s:  link modules failed\n", arg=
v[0]);
>                         exit(1);
>                 }
> -               if (expand_module(NULL, &modpolicydb, &kernpolicydb, 0, 1=
)) {
> +               if (expand_module(NULL, &modpolicydb, &kernpolicydb, /*ve=
rbose=3D*/0, !disable_neverallow)) {
>                         fprintf(stderr, "%s:  expand module failed\n", ar=
gv[0]);
>                         exit(1);
>                 }
> diff --git a/checkpolicy/checkpolicy.8 b/checkpolicy/checkpolicy.8
> index 2984c238..c66e084b 100644
> --- a/checkpolicy/checkpolicy.8
> +++ b/checkpolicy/checkpolicy.8
> @@ -3,7 +3,7 @@
>  checkpolicy \- SELinux policy compiler
>  .SH SYNOPSIS
>  .B checkpolicy
> -.I "[\-b[F]] [\-C] [\-d] [\-U handle_unknown (allow,deny,reject)] [\-M] =
[\-c policyvers] [\-o output_file|\-] [\-S] [\-t target_platform (selinux,x=
en)] [\-O] [\-E] [\-V] [input_file]"
> +.I "[\-b[F]] [\-C] [\-d] [\-U handle_unknown (allow,deny,reject)] [\-M] =
[\-N] [\-c policyvers] [\-o output_file|\-] [\-S] [\-t target_platform (sel=
inux,xen)] [\-O] [\-E] [\-V] [input_file]"
>  .br
>  .SH "DESCRIPTION"
>  This manual page describes the
> @@ -38,6 +38,9 @@ Specify how the kernel should handle unknown classes or=
 permissions (deny, allow
>  .B \-M,\-\-mls
>  Enable the MLS policy when checking and compiling the policy.
>  .TP
> +.B \-N,\-\-disable-neverallow
> +Do not check neverallow rules.
> +.TP
>  .B \-c policyvers
>  Specify the policy version, defaults to the latest.
>  .TP
> diff --git a/checkpolicy/checkpolicy.c b/checkpolicy/checkpolicy.c
> index 2485142d..623ba8b2 100644
> --- a/checkpolicy/checkpolicy.c
> +++ b/checkpolicy/checkpolicy.c
> @@ -109,7 +109,7 @@ static __attribute__((__noreturn__)) void usage(const=
 char *progname)
>  {
>         printf
>             ("usage:  %s [-b[F]] [-C] [-d] [-U handle_unknown (allow,deny=
,reject)] [-M] "
> -            "[-c policyvers (%d-%d)] [-o output_file|-] [-S] [-O] "
> +            "[-N] [-c policyvers (%d-%d)] [-o output_file|-] [-S] [-O] "
>              "[-t target_platform (selinux,xen)] [-E] [-V] [input_file]\n=
",
>              progname, POLICYDB_VERSION_MIN, POLICYDB_VERSION_MAX);
>         exit(1);
> @@ -393,7 +393,7 @@ int main(int argc, char **argv)
>         size_t scontext_len, pathlen;
>         unsigned int i;
>         unsigned int protocol, port;
> -       unsigned int binary =3D 0, debug =3D 0, sort =3D 0, cil =3D 0, co=
nf =3D 0, optimize =3D 0;
> +       unsigned int binary =3D 0, debug =3D 0, sort =3D 0, cil =3D 0, co=
nf =3D 0, optimize =3D 0, disable_neverallow =3D 0;
>         struct val_to_name v;
>         int ret, ch, fd, target =3D SEPOL_TARGET_SELINUX;
>         unsigned int nel, uret;
> @@ -415,6 +415,7 @@ int main(int argc, char **argv)
>                 {"version", no_argument, NULL, 'V'},
>                 {"handle-unknown", required_argument, NULL, 'U'},
>                 {"mls", no_argument, NULL, 'M'},
> +               {"disable-neverallow", no_argument, NULL, 'N'},
>                 {"cil", no_argument, NULL, 'C'},
>                 {"conf",no_argument, NULL, 'F'},
>                 {"sort", no_argument, NULL, 'S'},
> @@ -424,7 +425,7 @@ int main(int argc, char **argv)
>                 {NULL, 0, NULL, 0}
>         };
>
> -       while ((ch =3D getopt_long(argc, argv, "o:t:dbU:MCFSVc:OEh", long=
_options, NULL)) !=3D -1) {
> +       while ((ch =3D getopt_long(argc, argv, "o:t:dbU:MNCFSVc:OEh", lon=
g_options, NULL)) !=3D -1) {
>                 switch (ch) {
>                 case 'o':
>                         outfile =3D optarg;
> @@ -473,6 +474,9 @@ int main(int argc, char **argv)
>                 case 'M':
>                         mlspol =3D 1;
>                         break;
> +               case 'N':
> +                       disable_neverallow =3D 1;
> +                       break;
>                 case 'C':
>                         cil =3D 1;
>                         break;
> @@ -630,7 +634,7 @@ int main(int argc, char **argv)
>                                 fprintf(stderr, "%s:  policydb_init faile=
d\n", argv[0]);
>                                 exit(1);
>                         }
> -                       if (expand_module(NULL, policydbp, &policydb, 0, =
1)) {
> +                       if (expand_module(NULL, policydbp, &policydb, /*v=
erbose=3D*/0, !disable_neverallow)) {
>                                 fprintf(stderr, "Error while expanding po=
licy\n");
>                                 exit(1);
>                         }
> --
> 2.40.1
>
