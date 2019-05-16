Return-Path: <SRS0=VlsA=TQ=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76A0CC04E84
	for <selinux@archiver.kernel.org>; Thu, 16 May 2019 01:48:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3FC6420873
	for <selinux@archiver.kernel.org>; Thu, 16 May 2019 01:48:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QC6D8NpD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726752AbfEPBqe (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 15 May 2019 21:46:34 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:40734 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726830AbfEPAux (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 15 May 2019 20:50:53 -0400
Received: by mail-ot1-f65.google.com with SMTP id u11so1828302otq.7
        for <selinux@vger.kernel.org>; Wed, 15 May 2019 17:50:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Sphf2ZfSLFgmNKmMq+lvRE3eSboQLlHpc5OdfJw890I=;
        b=QC6D8NpDuPa9A9+3DLuwVIwu7M/GUSb99SzgEL/wJXNmlgiA+YnZxJonSHvIIWTOZQ
         KZE8c7ZYI687uzVsiqiKzqk/zgJRBYv1uci25jVXFdnZ6ANfx4heyiO2cOiL1gWm8qcA
         H8ACtuaxsQ3378o9W5NHZRnf/ce0sinDgER9wNrNH3onVjWla3C7d9M+BdiV3g1D8E9k
         GU4ATxP5ToiIhN3mGC0slQy1HIbvz/brrOSXxODzeNSHowxRxQ26eW5vaZMyIZLF/CoV
         bw3b+0Qt3kdb3BoZXBTBVnQmtlt3DhUz0kWrFMPNiouj4pWLxrHKUpzc7Z/+kQt8sXnE
         vsnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Sphf2ZfSLFgmNKmMq+lvRE3eSboQLlHpc5OdfJw890I=;
        b=E/8WmVp+C+xfRt7aBAI8pIflKuNbGla0o1ysnFxdhNq5WNsQibpy7AQ+VmAMDGNaNz
         Y+hGjiyEWI9f76j1JvO0VCiGhO/pWmZYJ+4QJD25/gEC09Q7B7QIbehvKFvnMAvMSoPn
         02t/m9BSmRdVJLs4JDzXS+bmnn1r8KA8w5vq7FZkSBlH0ihsita5vO7z3i3P3rgdk5F4
         mbOOzCUtF8Lao+L/84tVmnrmGkJC38E4jIZBv94AhdEf/XOO4JT+ShtrXJbGbERgmFJd
         GCdv50RFsKl4yd67p6rdjw98b2fyScZujCsbI8ucGcxg+oE7OE7m46UxVjTsc1+Egb7V
         EffA==
X-Gm-Message-State: APjAAAX02mtOTDax95iIm0Gzc3X7VkENGiKVQdML8L8iwiidq4nelrOa
        GVT00xSiGZLIFFB6Xmes6+iL7plFWN4EgslaxvkUwE+2lGI=
X-Google-Smtp-Source: APXvYqwbQJAUoTp3hR5OQ329Opb5wB4mV/vRen0eIfJXzoDSj54XbTzXdb7Mw3ZtMLHFXusyje3vfaYGs6tRM1lkmBo=
X-Received: by 2002:a9d:470d:: with SMTP id a13mr9113952otf.162.1557967852563;
 Wed, 15 May 2019 17:50:52 -0700 (PDT)
MIME-Version: 1.0
References: <alpine.LFD.2.21.1905110216330.19888@34-41-5D-CA-59-C7>
In-Reply-To: <alpine.LFD.2.21.1905110216330.19888@34-41-5D-CA-59-C7>
From:   William Roberts <bill.c.roberts@gmail.com>
Date:   Wed, 15 May 2019 17:50:40 -0700
Message-ID: <CAFftDdongLWHdSPcVRGXCSoJHt-i6ct87zPXMxx0gKaq4orsBA@mail.gmail.com>
Subject: Re: [PATCH] General code cleanups, sanity checks and strdup() checks
To:     =?UTF-8?B?Sm9ra2UgSMOkbcOkbMOkaW5lbg==?= 
        <jokke.hamalainen@kolttonen.fi>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, May 10, 2019 at 4:21 PM Jokke H=C3=A4m=C3=A4l=C3=A4inen
<jokke.hamalainen@kolttonen.fi> wrote:
>
>
> Needs to be analyzed for correctness.

I would split this up into a series of patches, and obviously do some
testing before you submit.

>
> ---
>  libsemanage/src/conf-parse.y | 56 ++++++++++++++++++++++++++++++++----
>  1 file changed, 51 insertions(+), 5 deletions(-)
>
> diff --git a/libsemanage/src/conf-parse.y b/libsemanage/src/conf-parse.y
> index b527e893..75a43cd2 100644
> --- a/libsemanage/src/conf-parse.y
> +++ b/libsemanage/src/conf-parse.y
> @@ -221,6 +221,9 @@ usepasswd: USEPASSWD '=3D' ARG {
>
>  ignoredirs: IGNOREDIRS '=3D' ARG {
>         current_conf->ignoredirs =3D strdup($3);
> +       if (current_conf->ignoredirs =3D=3D NULL) {
> +               yyerror("could not allocate memory for current_conf->igno=
redirs");
> +       }
>         free($3);
>   }
>
> @@ -240,7 +243,7 @@ handle_unknown: HANDLE_UNKNOWN '=3D' ARG {
>  bzip_blocksize:  BZIP_BLOCKSIZE '=3D' ARG {
>         int blocksize =3D atoi($3);
>         free($3);
> -       if (blocksize > 9)
> +       if (blocksize < 0 || blocksize > 9)

BZ2_bzWriteOpen() takes an int, for len why?... anyways not our
problem. However,
their man page says < 1 causes an error:
http://linux.math.tifr.res.in/manuals/html/manual_3.html

So that range check is wrong.

>                 yyerror("bzip-blocksize can only be in the range 0-9");
>         else
>                 current_conf->bzip_blocksize =3D blocksize;
> @@ -338,10 +341,24 @@ external_opt:   PROG_PATH '=3D' ARG  { PASSIGN(new_=
external->path, $3); }
>  static int semanage_conf_init(semanage_conf_t * conf)
>  {
>         conf->store_type =3D SEMANAGE_CON_DIRECT;
> +
>         conf->store_path =3D strdup(basename(selinux_policy_root()));
> +       if (conf->store_path =3D=3D NULL) {
> +               return -1;
> +       }
> +
>         conf->ignoredirs =3D NULL;
> +
>         conf->store_root_path =3D strdup("/var/lib/selinux");
> +       if (conf->store_root_path =3D=3D NULL) {
> +               return -1;
> +       }
> +
>         conf->compiler_directory_path =3D strdup("/usr/libexec/selinux/hl=
l");
> +       if (conf->compiler_directory_path =3D=3D NULL) {
> +               return -1;
> +       }
> +
>         conf->policyvers =3D sepol_policy_kern_vers_max();
>         conf->target_platform =3D SEPOL_TARGET_SELINUX;
>         conf->expand_check =3D 1;
> @@ -366,20 +383,24 @@ static int semanage_conf_init(semanage_conf_t * con=
f)
>         } else {
>                 conf->load_policy->path =3D strdup("/usr/sbin/load_policy=
");
>         }
> +
>         if (conf->load_policy->path =3D=3D NULL) {
>                 return -1;
>         }
> +
>         conf->load_policy->args =3D NULL;
>
>         if ((conf->setfiles =3D
>              calloc(1, sizeof(*(current_conf->setfiles)))) =3D=3D NULL) {
>                 return -1;
>         }
> +
I would separate out functional changes from style updates in different com=
mits.

>         if (access("/sbin/setfiles", X_OK) =3D=3D 0) {
>                 conf->setfiles->path =3D strdup("/sbin/setfiles");
>         } else {
>                 conf->setfiles->path =3D strdup("/usr/sbin/setfiles");
>         }
> +
>         if ((conf->setfiles->path =3D=3D NULL) ||
>             (conf->setfiles->args =3D strdup("-q -c $@ $<")) =3D=3D NULL)=
 {
>                 return -1;
> @@ -389,11 +410,13 @@ static int semanage_conf_init(semanage_conf_t * con=
f)
>              calloc(1, sizeof(*(current_conf->sefcontext_compile)))) =3D=
=3D NULL) {
>                 return -1;
>         }
> +
>         if (access("/sbin/sefcontext_compile", X_OK) =3D=3D 0) {
>                 conf->sefcontext_compile->path =3D strdup("/sbin/sefconte=
xt_compile");
>         } else {
>                 conf->sefcontext_compile->path =3D strdup("/usr/sbin/sefc=
ontext_compile");
>         }
> +
>         if ((conf->sefcontext_compile->path =3D=3D NULL) ||
>             (conf->sefcontext_compile->args =3D strdup("$@")) =3D=3D NULL=
) {
>                 return -1;
> @@ -413,24 +436,30 @@ semanage_conf_t *semanage_conf_parse(const char *co=
nfig_filename)
>         if ((current_conf =3D calloc(1, sizeof(*current_conf))) =3D=3D NU=
LL) {
>                 return NULL;
>         }
> +
>         if (semanage_conf_init(current_conf) =3D=3D -1) {
>                 goto cleanup;
>         }
> +
>         if ((semanage_in =3D fopen(config_filename, "r")) =3D=3D NULL) {
> -               /* configuration file does not exist or could not be
> -                * read.  THIS IS NOT AN ERROR.  just rely on the
> +               /* Configuration file does not exist or could not be
> +                * read.  THIS IS NOT AN ERROR.  Just rely on the
>                  * defaults. */

Its still an oddly formatted block comment the *'s don't even line up,
typically you see:
/*
 * foo
 * bar
 */
 or
/* foo
 * bar
 */

Pick the former.

>                 return current_conf;
>         }
> +
>         parse_errors =3D 0;
>         semanage_parse();
>         fclose(semanage_in);
>         semanage_lex_destroy();
> +
>         if (parse_errors !=3D 0) {
>                 goto cleanup;
>         }
> +
>         return current_conf;
> -      cleanup:
> +
> +cleanup:
>         semanage_conf_destroy(current_conf);
>         return NULL;
>  }
> @@ -489,7 +518,9 @@ static int parse_module_store(char *arg)
>         if (arg =3D=3D NULL) {
>                 return -1;
>         }
> +
>         free(current_conf->store_path);
> +
>         if (strcmp(arg, "direct") =3D=3D 0) {
>                 current_conf->store_type =3D SEMANAGE_CON_DIRECT;
>                 current_conf->store_path =3D
> @@ -515,7 +546,10 @@ static int parse_module_store(char *arg)
>                         }
>                 }
>         }
> -       return 0;
> +
> +       if (current_conf->store_path)
> +               return 0;
> +       return -3;
>  }
>
>  static int parse_store_root_path(char *arg)
> @@ -525,7 +559,12 @@ static int parse_store_root_path(char *arg)
>         }
>
>         free(current_conf->store_root_path);
> +
>         current_conf->store_root_path =3D strdup(arg);
> +       if (current_conf->store_root_path =3D=3D NULL) {
> +               return -2;
> +       }
> +
>         return 0;
>  }
>
> @@ -534,8 +573,13 @@ static int parse_compiler_path(char *arg)
>         if (arg =3D=3D NULL) {
>                 return -1;
>         }
> +
>         free(current_conf->compiler_directory_path);
> +
>         current_conf->compiler_directory_path =3D strdup(arg);
> +       if (current_conf->compiler_directory_path =3D NULL) {
> +               return -2;
> +       }
>         return 0;
>  }
>
> @@ -548,6 +592,7 @@ static int new_external_prog(external_prog_t ** chain=
)
>         if ((new_external =3D calloc(1, sizeof(*new_external))) =3D=3D NU=
LL) {
>                 return -1;
>         }
> +
>         /* hook this new external program to the end of the chain */
>         if (*chain =3D=3D NULL) {
>                 *chain =3D new_external;
> @@ -558,5 +603,6 @@ static int new_external_prog(external_prog_t ** chain=
)
>                 }
>                 prog->next =3D new_external;
>         }
> +
>         return 0;
>  }
> --
> 2.21.0
>
