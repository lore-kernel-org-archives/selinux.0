Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3210C7EE29
	for <selinux@archiver.kernel.org>; Fri,  9 Jun 2023 19:37:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229722AbjFIThS (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 9 Jun 2023 15:37:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbjFIThQ (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 9 Jun 2023 15:37:16 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8757630D0
        for <selinux@vger.kernel.org>; Fri,  9 Jun 2023 12:37:14 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id 2adb3069b0e04-4f62d93f38aso2773577e87.0
        for <selinux@vger.kernel.org>; Fri, 09 Jun 2023 12:37:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686339433; x=1688931433;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d8EDBdxkSozwL7DeA+rq9oQmF6Xdl6/gUYqsw0hxXDU=;
        b=aV7gH62cTfezEyv1V9DUNaIRGoTzTzz8+bRwd2pNwa6LQmOPjfDPKV/4TxKg/tkfD7
         QO4JBkFPCuI9tfA5+iHmUbgnS/cph7qGFV6OM0ZMr+dbBVvwvM6UZxmcVX6Vt81Twy/3
         1qRJr4XPPso6EflsPjCDs1dU7pn3Y9D7qRFDnIcndViMhBUQy2akr7iGHWV6Cizslrwi
         n1P2SS1zFOJaKOGsa7k5L0FgMne6nc5MvpJU6ffhV5pOS63sUq835OzHKRrNs3oTSPRg
         xu+se5AHRoAobjme+l15qLyELhMVOUnOqExlXXHM7Ogqei4JryFg7OQeBz191vUBUZid
         gXsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686339433; x=1688931433;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d8EDBdxkSozwL7DeA+rq9oQmF6Xdl6/gUYqsw0hxXDU=;
        b=SdmgZ/+tmcTFfpJgdD67fU8nJLr5oFg0NRoeIZuvOw4YPdsnyOVJBG2kEUqHJ0Nmv1
         EbhmlFEKapa+sp+KqfIBfySWgl4uu5EBdJKH9P1yDglDUd636laLbKPCpvvd64VgW8G/
         o/4a0U8HMd0ghzDCcZEuF5FP1DZUdGGiu0sn1eg++kTSaT45sfSNfOlPZP6Gzr5nf/fz
         hTzXWPbDuMEqJx/V+G/AdQyVTW8vViFgiEL+Klkd+crFtdtsJRen4zc43yMgiQ3QPuDD
         NIDt/ZbAEbZ+AUBfJUc/BQ9bhFMiv31UYmGKeoUIH++WSQwjmYKmozbzAxSHHXWlX00h
         PM9g==
X-Gm-Message-State: AC+VfDypodeBmJQqqIzrcQMFPcqiNl2euH0E13ZHfGxDRSblJJtTI164
        7T7TxnZDLRtuuGeifAMSjcfjI6p5PpSPpU0mOfU11ihL
X-Google-Smtp-Source: ACHHUZ7jzFHWGzcICm4rKPPCkFwtZYCl4epdYUGGS8mL0UiYjR6vfGSS5UqLNBB5dGVMV4XNd9B5PQk2CQT9Q9wxhFU=
X-Received: by 2002:a05:6512:547:b0:4f4:cacb:4b4b with SMTP id
 h7-20020a056512054700b004f4cacb4b4bmr1616738lfl.18.1686339432657; Fri, 09 Jun
 2023 12:37:12 -0700 (PDT)
MIME-Version: 1.0
References: <20230512110730.78672-1-cgzones@googlemail.com>
 <20230512110730.78672-3-cgzones@googlemail.com> <CAP+JOzTimAPS0jtoZPOa=Ju3Q_h+Rg54ZwttKA2OTYXMm3v11w@mail.gmail.com>
In-Reply-To: <CAP+JOzTimAPS0jtoZPOa=Ju3Q_h+Rg54ZwttKA2OTYXMm3v11w@mail.gmail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Fri, 9 Jun 2023 15:37:01 -0400
Message-ID: <CAP+JOzSNuEO19Xg+Zto76CFuyts56_s9NQ1vb1A9ZPmSKYSyjw@mail.gmail.com>
Subject: Re: [RFC PATCH 3/4] semodule_package: update
To:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Jun 9, 2023 at 3:32=E2=80=AFPM James Carter <jwcart2@gmail.com> wro=
te:
>
> On Fri, May 12, 2023 at 7:25=E2=80=AFAM Christian G=C3=B6ttsche
> <cgzones@googlemail.com> wrote:
> >
> > Drop unnecessary declarations.
> > Add missing error messages.
> > More strict command line argument parsing.
> > Check closing file for incomplete write.
> > Rework resource cleanup, so that all files and allocated memory are
> > released in all branches, useful to minimize reports while debugging
> > libsepol under valgrind(8) or sanitizers.
> >
> > Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
> > ---
> >  .../semodule_package/semodule_package.c       | 203 +++++++++++-------
> >  1 file changed, 125 insertions(+), 78 deletions(-)
> >
> > diff --git a/semodule-utils/semodule_package/semodule_package.c b/semod=
ule-utils/semodule_package/semodule_package.c
> > index bc8584b5..7485e254 100644
> > --- a/semodule-utils/semodule_package/semodule_package.c
> > +++ b/semodule-utils/semodule_package/semodule_package.c
> > @@ -19,8 +19,7 @@
> >  #include <fcntl.h>
> >  #include <errno.h>
> >
> > -char *progname =3D NULL;
> > -extern char *optarg;
> > +static const char *progname =3D NULL;

I forgot to ask if this global can be removed as well.

Thanks,
Jim

> >
> >  static __attribute__((__noreturn__)) void usage(const char *prog)
> >  {
> > @@ -37,26 +36,6 @@ static __attribute__((__noreturn__)) void usage(cons=
t char *prog)
> >         exit(1);
>
> Same comment as patch 1 about "exit(1)".
>
> >  }
> >
> > -static int file_to_policy_file(const char *filename, struct sepol_poli=
cy_file **pf,
> > -                              const char *mode)
> > -{
> > -       FILE *f;
> > -
> > -       if (sepol_policy_file_create(pf)) {
> > -               fprintf(stderr, "%s:  Out of memory\n", progname);
> > -               return -1;
> > -       }
> > -
> > -       f =3D fopen(filename, mode);
> > -       if (!f) {
> > -               fprintf(stderr, "%s:  Could not open file %s:  %s\n", p=
rogname,
> > -                       strerror(errno), filename);
> > -               return -1;
> > -       }
> > -       sepol_policy_file_set_fp(*pf, f);
> > -       return 0;
> > -}
> > -
> >  static int file_to_data(const char *path, char **data, size_t * len)
> >  {
> >         int fd;
> > @@ -94,17 +73,18 @@ static int file_to_data(const char *path, char **da=
ta, size_t * len)
> >
> >  int main(int argc, char **argv)
> >  {
> > -       struct sepol_module_package *pkg;
> > -       struct sepol_policy_file *mod, *out;
> > +       struct sepol_module_package *pkg =3D NULL;
> > +       struct sepol_policy_file *mod =3D NULL, *out =3D NULL;
> > +       FILE *fp =3D NULL;
> >         char *module =3D NULL, *file_contexts =3D NULL, *seusers =3D
> >             NULL, *user_extra =3D NULL;
> >         char *fcdata =3D NULL, *outfile =3D NULL, *seusersdata =3D
> >             NULL, *user_extradata =3D NULL;
> >         char *netfilter_contexts =3D NULL, *ncdata =3D NULL;
> >         size_t fclen =3D 0, seuserslen =3D 0, user_extralen =3D 0, ncle=
n =3D 0;
> > -       int i;
> > +       int i, ret;
> >
> > -       static struct option opts[] =3D {
> > +       const struct option opts[] =3D {
> >                 {"module", required_argument, NULL, 'm'},
> >                 {"fc", required_argument, NULL, 'f'},
> >                 {"seuser", required_argument, NULL, 's'},
> > @@ -115,11 +95,12 @@ int main(int argc, char **argv)
> >                 {NULL, 0, NULL, 0}
> >         };
> >
> > +       progname =3D argv[0];
> > +
> >         while ((i =3D getopt_long(argc, argv, "m:f:s:u:o:n:h", opts, NU=
LL)) !=3D -1) {
> >                 switch (i) {
> >                 case 'h':
> > -                       usage(argv[0]);
> > -                       exit(0);
> > +                       usage(progname);
> >                 case 'm':
> >                         if (module) {
> >                                 fprintf(stderr,
> > @@ -127,8 +108,10 @@ int main(int argc, char **argv)
> >                                 exit(1);
> >                         }
> >                         module =3D strdup(optarg);
> > -                       if (!module)
> > +                       if (!module) {
> > +                               fprintf(stderr, "%s:  Out of memory\n",=
 progname);
> >                                 exit(1);
> > +                       }
> >                         break;
> >                 case 'f':
> >                         if (file_contexts) {
> > @@ -137,8 +120,10 @@ int main(int argc, char **argv)
> >                                 exit(1);
> >                         }
> >                         file_contexts =3D strdup(optarg);
> > -                       if (!file_contexts)
> > +                       if (!file_contexts) {
> > +                               fprintf(stderr, "%s:  Out of memory\n",=
 progname);
> >                                 exit(1);
> > +                       }
> >                         break;
> >                 case 'o':
> >                         if (outfile) {
> > @@ -147,8 +132,10 @@ int main(int argc, char **argv)
> >                                 exit(1);
> >                         }
> >                         outfile =3D strdup(optarg);
> > -                       if (!outfile)
> > +                       if (!outfile) {
> > +                               fprintf(stderr, "%s:  Out of memory\n",=
 progname);
> >                                 exit(1);
> > +                       }
> >                         break;
> >                 case 's':
> >                         if (seusers) {
> > @@ -157,8 +144,10 @@ int main(int argc, char **argv)
> >                                 exit(1);
> >                         }
> >                         seusers =3D strdup(optarg);
> > -                       if (!seusers)
> > +                       if (!seusers) {
> > +                               fprintf(stderr, "%s:  Out of memory\n",=
 progname);
> >                                 exit(1);
> > +                       }
> >                         break;
> >                 case 'u':
> >                         if (user_extra) {
> > @@ -167,8 +156,10 @@ int main(int argc, char **argv)
> >                                 exit(1);
> >                         }
> >                         user_extra =3D strdup(optarg);
> > -                       if (!user_extra)
> > +                       if (!user_extra) {
> > +                               fprintf(stderr, "%s:  Out of memory\n",=
 progname);
> >                                 exit(1);
> > +                       }
> >                         break;
> >                 case 'n':
> >                         if (netfilter_contexts) {
> > @@ -177,88 +168,144 @@ int main(int argc, char **argv)
> >                                 exit(1);
> >                         }
> >                         netfilter_contexts =3D strdup(optarg);
> > -                       if (!netfilter_contexts)
> > +                       if (!netfilter_contexts) {
> > +                               fprintf(stderr, "%s:  Out of memory\n",=
 progname);
> >                                 exit(1);
> > +                       }
> >                         break;
> > +               case '?':
> > +                       usage(progname);
>
> What is this option "?" for?
>
> > +               default:
> > +                       fprintf(stderr, "%s:  Unsupported getopt return=
 code: %d\n", progname, i);
> > +                       usage(progname);
>
> Why not just default to calling usage() without the error message?
>
> >                 }
> >         }
> >
> > -       progname =3D argv[0];
> > -
> > -       if (!module || !outfile) {
> > -               usage(argv[0]);
> > -               exit(0);
> > +       if (optind < argc) {
> > +               fprintf(stderr, "%s:  Superfluous command line argument=
s: ", progname);
> > +                while (optind < argc)
> > +                        fprintf(stderr, "%s ", argv[optind++]);
> > +               fprintf(stderr, "\n");
> > +               usage(progname);
> >         }
> >
> > -       if (file_contexts) {
> > -               if (file_to_data(file_contexts, &fcdata, &fclen))
> > -                       exit(1);
> > -       }
> > +       if (!module || !outfile)
> > +               usage(progname);
> >
> > -       if (seusers) {
> > -               if (file_to_data(seusers, &seusersdata, &seuserslen))
> > -                       exit(1);
> > -       }
> > +       if (file_contexts && file_to_data(file_contexts, &fcdata, &fcle=
n))
> > +               goto failure;
> >
> > -       if (user_extra) {
> > -               if (file_to_data(user_extra, &user_extradata, &user_ext=
ralen))
> > -                       exit(1);
> > -       }
> > +       if (seusers && file_to_data(seusers, &seusersdata, &seuserslen)=
)
> > +               goto failure;
> > +
> > +       if (user_extra && file_to_data(user_extra, &user_extradata, &us=
er_extralen))
> > +               goto failure;
> >
> > -       if (netfilter_contexts) {
> > -               if (file_to_data(netfilter_contexts, &ncdata, &nclen))
> > -                       exit(1);
> > +       if (netfilter_contexts && file_to_data(netfilter_contexts, &ncd=
ata, &nclen))
> > +               goto failure;
> > +
> > +       if (sepol_policy_file_create(&mod)) {
> > +               fprintf(stderr, "%s:  Out of memory\n", progname);
> > +               goto failure;
> >         }
> >
> > -       if (file_to_policy_file(module, &mod, "r"))
> > -               exit(1);
> > +       fp =3D fopen(module, "r");
> > +       if (!fp) {
> > +               fprintf(stderr, "%s:  Could not open file %s:  %s\n", p=
rogname,
> > +                       module, strerror(errno));
> > +               goto failure;
> > +       }
> > +       sepol_policy_file_set_fp(mod, fp);
> >
> >         if (sepol_module_package_create(&pkg)) {
> >                 fprintf(stderr, "%s:  Out of memory\n", argv[0]);
> > -               exit(1);
> > +               goto failure;
> >         }
> >
> >         if (sepol_policydb_read(sepol_module_package_get_policy(pkg), m=
od)) {
> >                 fprintf(stderr,
> >                         "%s:  Error while reading policy module from %s=
\n",
> >                         argv[0], module);
> > -               exit(1);
> > +               goto failure;
> >         }
> >
> > -       if (fclen)
> > -               sepol_module_package_set_file_contexts(pkg, fcdata, fcl=
en);
> > +       fclose(fp);
> > +       fp =3D NULL;
> >
> > -       if (seuserslen)
> > -               sepol_module_package_set_seusers(pkg, seusersdata, seus=
erslen);
> > +       if (fclen && sepol_module_package_set_file_contexts(pkg, fcdata=
, fclen)) {
> > +               fprintf(stderr, "%s:  Error while setting file contexts=
\n", progname);
> > +               goto failure;
> > +       }
> >
> > -       if (user_extra)
> > -               sepol_module_package_set_user_extra(pkg, user_extradata=
,
> > -                                                   user_extralen);
> > +       if (seuserslen && sepol_module_package_set_seusers(pkg, seusers=
data, seuserslen)) {
> > +               fprintf(stderr, "%s:  Error while setting seusers\n", p=
rogname);
> > +               goto failure;
> > +       }
> >
> > -       if (nclen)
> > -               sepol_module_package_set_netfilter_contexts(pkg, ncdata=
, nclen);
> > +       if (user_extra && sepol_module_package_set_user_extra(pkg, user=
_extradata, user_extralen)) {
> > +               fprintf(stderr, "%s:  Error while setting extra users\n=
", progname);
> > +               goto failure;
> > +       }
> > +
> > +       if (nclen && sepol_module_package_set_netfilter_contexts(pkg, n=
cdata, nclen)) {
> > +               fprintf(stderr, "%s:  Error while setting netfilter con=
texts\n", progname);
> > +               goto failure;
> > +       }
> > +
> > +       if (sepol_policy_file_create(&out)) {
> > +               fprintf(stderr, "%s:  Out of memory\n", progname);
> > +               goto failure;
> > +       }
> >
> > -       if (file_to_policy_file(outfile, &out, "w"))
> > -               exit(1);
> > +       fp =3D fopen(outfile, "w");
> > +       if (!fp) {
> > +               fprintf(stderr, "%s:  Could not open file %s:  %s\n", p=
rogname,
> > +                       outfile, strerror(errno));
> > +               goto failure;
> > +       }
> > +       sepol_policy_file_set_fp(out, fp);
> >
> >         if (sepol_module_package_write(pkg, out)) {
> >                 fprintf(stderr,
> >                         "%s:  Error while writing module package to %s\=
n",
> >                         argv[0], argv[1]);
> > -               exit(1);
> > +               goto failure;
> >         }
> >
> > -       if (fclen)
> > -               munmap(fcdata, fclen);
> > +       ret =3D fclose(fp);
> > +       fp =3D NULL;
> > +       if (ret) {
> > +               fprintf(stderr, "%s:  Could not close file %s:  %s\n", =
progname,
> > +                       outfile, strerror(errno));
> > +               goto failure;
> > +       }
> > +
> > +       ret =3D EXIT_SUCCESS;
> > +
> > +cleanup:
> > +       if (fp)
> > +               fclose(fp);
> > +       sepol_policy_file_free(out);
> >         if (nclen)
> >                 munmap(ncdata, nclen);
> > -       sepol_policy_file_free(mod);
> > -       sepol_policy_file_free(out);
> > +       if (user_extradata)
> > +               munmap(user_extradata, user_extralen);
> > +       if (seuserslen)
> > +               munmap(seusersdata, seuserslen);
> > +       if (fclen)
> > +               munmap(fcdata, fclen);
> >         sepol_module_package_free(pkg);
> > -       free(file_contexts);
> > +       sepol_policy_file_free(mod);
> > +       free(netfilter_contexts);
> > +       free(user_extra);
> > +       free(seusers);
> >         free(outfile);
> > +       free(file_contexts);
> >         free(module);
> > -       free(seusers);
> > -       free(user_extra);
> > -       exit(0);
> > +
> > +       return ret;
> > +
> > +failure:
> > +       ret =3D EXIT_FAILURE;
> > +       goto cleanup;
>
> Same as the comment for patch 1 about preferring "return ret" to be at th=
e end.
>
> Thanks,
> Jim
>
> >  }
> > --
> > 2.40.1
> >
