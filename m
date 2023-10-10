Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F408DCD8CA9
	for <selinux@archiver.kernel.org>; Tue, 10 Oct 2023 17:07:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232908AbjJJRHh (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 10 Oct 2023 13:07:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234023AbjJJRH1 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 10 Oct 2023 13:07:27 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E59B0191
        for <selinux@vger.kernel.org>; Tue, 10 Oct 2023 10:07:14 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id 2adb3069b0e04-50435ad51bbso7256061e87.2
        for <selinux@vger.kernel.org>; Tue, 10 Oct 2023 10:07:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696957633; x=1697562433; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H5X7VsCHN8fX6ZcPM3OCpyJ9hFcabnQA1p8Kr5NzU4A=;
        b=fNgQUEY5o6QTj/SbosusdyrDxPFzJZlPvNVwY8kGd7Gh/4bzESk44T6RmCsooV1z7O
         D7qBBl4G7ypo5pJ3udBh5sDBzwn6YId2AajwXBhkgB9ugT2HGsa14t0PSCfOkqcyYPRd
         QFJI2yx0SdqVCe59CDfET2SQRYRyP1BHooKphqqPpR55OEHMSVWBlExgFO9brO17rnV1
         +FvFbq+wM5UpaGTEaTPE3mmzD58cWrxSoOevvY9rXioQYY3guVBEHoJcKr49TClcwoSW
         zTcfhWB71BJgLFyMB7pNI0gHsiPdRRl/pPdAKuLVKsFAeIbZAh1FsJfWBAlSW4NcocZl
         9MEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696957633; x=1697562433;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H5X7VsCHN8fX6ZcPM3OCpyJ9hFcabnQA1p8Kr5NzU4A=;
        b=JaZJyNvYUsOyfd1rGZSiL4cxQne7bN6DPxZLGCjPXAXIQH8e2f8CQZL//WxWfE4tTI
         NgB61HLlUVlYKAJAEsbT+yCEi1FUa146sen161cYkwAdZO3nUTqODnc86uD+PwDzPgpY
         BgqouieQwsi+M6nmkSJVV/shs7flelVvp70xb//WKjjNwdQgbesHfOl35RFSEiLpAnnR
         PNrwd5iKa8c0ZGUPhf1tYhA3H8adkJtkhMfU6rP8FYOSIOzmepBg9Jwl+kXsqFEEVSIl
         wdzMVF8WYxeR2JLSUgqPIJDc5iQeyjyTv8M1/gImO0Z0ngBibcJQBYqMhIehSjd4BBeb
         YbWg==
X-Gm-Message-State: AOJu0YzkSyRTmsduspI4LOD36EcQbmnhG1HdEoldBZuc1Khx6B7ojM/U
        cKGnZCMb20BNilR+VpmSzYm6D7KNz9D9By733rvbSjBR
X-Google-Smtp-Source: AGHT+IG+6D66xgwLa3PY3cnakKZoJJ7AmAWGpeDpvQcp+o6uINP8fGPS2BByQF2gr0l9dieufPoCwkrky6lWi2Z5ygU=
X-Received: by 2002:a05:6512:2013:b0:4fa:da4f:636f with SMTP id
 a19-20020a056512201300b004fada4f636fmr13711607lfb.32.1696957632156; Tue, 10
 Oct 2023 10:07:12 -0700 (PDT)
MIME-Version: 1.0
References: <20230814132025.45364-1-cgzones@googlemail.com> <20230814132025.45364-18-cgzones@googlemail.com>
In-Reply-To: <20230814132025.45364-18-cgzones@googlemail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Tue, 10 Oct 2023 13:07:00 -0400
Message-ID: <CAP+JOzRLxX_Wg=EzihUQgTOaLBpxzWADjYPLJ+LtreN7BPtpFg@mail.gmail.com>
Subject: Re: [RFC PATCH v2 17/27] libselinux: remove SELABEL_OPT_SUBSET
 support from selabel_file(5)
To:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Aug 14, 2023 at 9:41=E2=80=AFAM Christian G=C3=B6ttsche
<cgzones@googlemail.com> wrote:
>
> The selabel_file(5) option SELABEL_OPT_SUBSET has been deprecated in
> commit 26e05da0fc2d ("libselinux: matchpathcon/selabel_file: Fix man
> pages.") for version 2.5.
>
> Drop the support to easy refactoring the selabel_file related code.
>
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
> ---
>  libselinux/include/selinux/label.h    |  2 +-
>  libselinux/include/selinux/selinux.h  |  6 +++++-
>  libselinux/src/Makefile               |  4 ++++
>  libselinux/src/label_file.c           | 19 ++++++++-----------
>  libselinux/src/label_file.h           | 13 ++-----------
>  libselinux/src/matchpathcon.c         |  4 +---
>  libselinux/utils/matchpathcon.c       | 11 ++---------
>  libselinux/utils/sefcontext_compile.c |  3 +--
>  8 files changed, 24 insertions(+), 38 deletions(-)
>
> diff --git a/libselinux/include/selinux/label.h b/libselinux/include/seli=
nux/label.h
> index ce189a3a..6cb2d782 100644
> --- a/libselinux/include/selinux/label.h
> +++ b/libselinux/include/selinux/label.h
> @@ -50,7 +50,7 @@ struct selabel_handle;
>  #define SELABEL_OPT_BASEONLY   2
>  /* specify an alternate path to use when loading backend data */
>  #define SELABEL_OPT_PATH       3
> -/* select a subset of the search space as an optimization (file backend)=
 */
> +/* Unsupported since v3.6: select a subset of the search space as an opt=
imization (file backend) */
>  #define SELABEL_OPT_SUBSET     4
>  /* require a hash calculation on spec files */
>  #define SELABEL_OPT_DIGEST     5
> diff --git a/libselinux/include/selinux/selinux.h b/libselinux/include/se=
linux/selinux.h
> index a0948853..3b23cb50 100644
> --- a/libselinux/include/selinux/selinux.h
> +++ b/libselinux/include/selinux/selinux.h
> @@ -484,7 +484,11 @@ extern int matchpathcon_init(const char *path)
>
>  /* Same as matchpathcon_init, but only load entries with
>     regexes that have stems that are prefixes of 'prefix'. */
> -extern int matchpathcon_init_prefix(const char *path, const char *prefix=
);
> +extern int matchpathcon_init_prefix(const char *path, const char *prefix=
)
> +#ifdef __GNUC__
> +   __attribute__ ((deprecated("Use selabel_open with backend SELABEL_CTX=
_FILE")))
> +#endif
> +;
>
>  /* Free the memory allocated by matchpathcon_init. */
>  extern void matchpathcon_fini(void)
> diff --git a/libselinux/src/Makefile b/libselinux/src/Makefile
> index ac656257..15d224e1 100644
> --- a/libselinux/src/Makefile
> +++ b/libselinux/src/Makefile
> @@ -144,6 +144,10 @@ ifeq ($(DISABLE_X11),y)
>  SRCS:=3D $(filter-out label_x.c, $(SRCS))
>  endif
>
> +# ignore usage of matchpathcon_init_prefix(3)
> +matchpathcon.o:  CFLAGS +=3D -Wno-deprecated -Wno-deprecated-declaration=
s
> +matchpathcon.lo: CFLAGS +=3D -Wno-deprecated -Wno-deprecated-declaration=
s
> +

"-Wno-deprecated" means do not warn about deprecated features and
seems to be about deprecated c++ features. I don't think we need it
here.

Everything else looks ok to me as long as no distro is depending on
this deprecated option.

Thanks,
Jim

>  SWIGRUBY =3D swig -Wall -ruby -o $(SWIGRUBYCOUT) -outdir ./ $(DISABLE_FL=
AGS)
>
>  all: $(LIBA) $(LIBSO) $(LIBPC)
> diff --git a/libselinux/src/label_file.c b/libselinux/src/label_file.c
> index b9be1c9d..f9f4648a 100644
> --- a/libselinux/src/label_file.c
> +++ b/libselinux/src/label_file.c
> @@ -166,7 +166,7 @@ static int nodups_specs(struct saved_data *data, cons=
t char *path)
>         return rc;
>  }
>
> -static int process_text_file(FILE *fp, const char *prefix,
> +static int process_text_file(FILE *fp,
>                              struct selabel_handle *rec, const char *path=
)
>  {
>         int rc;
> @@ -175,7 +175,7 @@ static int process_text_file(FILE *fp, const char *pr=
efix,
>         char *line_buf =3D NULL;
>
>         while (getline(&line_buf, &line_len, fp) > 0) {
> -               rc =3D process_line(rec, path, prefix, line_buf, ++lineno=
);
> +               rc =3D process_line(rec, path, line_buf, ++lineno);
>                 if (rc)
>                         goto out;
>         }
> @@ -603,7 +603,7 @@ static FILE *open_file(const char *path, const char *=
suffix,
>
>  static int process_file(const char *path, const char *suffix,
>                           struct selabel_handle *rec,
> -                         const char *prefix, struct selabel_digest *dige=
st)
> +                         struct selabel_digest *digest)
>  {
>         int rc;
>         unsigned int i;
> @@ -624,7 +624,7 @@ static int process_file(const char *path, const char =
*suffix,
>
>                 rc =3D fcontext_is_binary(fp) ?
>                                 load_mmap(fp, sb.st_size, rec, found_path=
) :
> -                               process_text_file(fp, prefix, rec, found_=
path);
> +                               process_text_file(fp, rec, found_path);
>                 if (!rc)
>                         rc =3D digest_add_specfile(digest, fp, NULL, sb.s=
t_size,
>                                 found_path);
> @@ -785,7 +785,6 @@ static int init(struct selabel_handle *rec, const str=
uct selinux_opt *opts,
>  {
>         struct saved_data *data =3D (struct saved_data *)rec->data;
>         const char *path =3D NULL;
> -       const char *prefix =3D NULL;
>         int status =3D -1, baseonly =3D 0;
>
>         /* Process arguments */
> @@ -795,7 +794,7 @@ static int init(struct selabel_handle *rec, const str=
uct selinux_opt *opts,
>                         path =3D opts[n].value;
>                         break;
>                 case SELABEL_OPT_SUBSET:
> -                       prefix =3D opts[n].value;
> +                       selinux_log(SELINUX_WARNING, "selabel_open(3): SE=
LABEL_OPT_SUBSET support has been removed, ignoring option\n");
>                         break;
>                 case SELABEL_OPT_BASEONLY:
>                         baseonly =3D !!opts[n].value;
> @@ -839,7 +838,7 @@ static int init(struct selabel_handle *rec, const str=
uct selinux_opt *opts,
>         /*
>          * The do detailed validation of the input and fill the spec arra=
y
>          */
> -       status =3D process_file(path, NULL, rec, prefix, rec->digest);
> +       status =3D process_file(path, NULL, rec, rec->digest);
>         if (status)
>                 goto finish;
>
> @@ -850,13 +849,11 @@ static int init(struct selabel_handle *rec, const s=
truct selinux_opt *opts,
>         }
>
>         if (!baseonly) {
> -               status =3D process_file(path, "homedirs", rec, prefix,
> -                                                           rec->digest);
> +               status =3D process_file(path, "homedirs", rec, rec->diges=
t);
>                 if (status && errno !=3D ENOENT)
>                         goto finish;
>
> -               status =3D process_file(path, "local", rec, prefix,
> -                                                           rec->digest);
> +               status =3D process_file(path, "local", rec, rec->digest);
>                 if (status && errno !=3D ENOENT)
>                         goto finish;
>         }
> diff --git a/libselinux/src/label_file.h b/libselinux/src/label_file.h
> index 1363c83c..56439e2d 100644
> --- a/libselinux/src/label_file.h
> +++ b/libselinux/src/label_file.h
> @@ -425,10 +425,10 @@ static inline int compile_regex(struct spec *spec, =
const char **errbuf)
>  /* This service is used by label_file.c process_file() and
>   * utils/sefcontext_compile.c */
>  static inline int process_line(struct selabel_handle *rec,
> -                       const char *path, const char *prefix,
> +                       const char *path,
>                         char *line_buf, unsigned lineno)
>  {
> -       int items, len, rc;
> +       int items, rc;
>         char *regex =3D NULL, *type =3D NULL, *context =3D NULL;
>         struct saved_data *data =3D (struct saved_data *)rec->data;
>         struct spec *spec_arr;
> @@ -466,15 +466,6 @@ static inline int process_line(struct selabel_handle=
 *rec,
>                 type =3D 0;
>         }
>
> -       len =3D get_stem_from_spec(regex);
> -       if (len && prefix && strncmp(prefix, regex, len)) {
> -               /* Stem of regex does not match requested prefix, discard=
. */
> -               free(regex);
> -               free(type);
> -               free(context);
> -               return 0;
> -       }
> -
>         rc =3D grow_specs(data);
>         if (rc)
>                 return rc;
> diff --git a/libselinux/src/matchpathcon.c b/libselinux/src/matchpathcon.=
c
> index a1c5b0cc..971ace62 100644
> --- a/libselinux/src/matchpathcon.c
> +++ b/libselinux/src/matchpathcon.c
> @@ -347,7 +347,7 @@ static void matchpathcon_init_once(void)
>                 destructor_key_initialized =3D 1;
>  }
>
> -int matchpathcon_init_prefix(const char *path, const char *subset)
> +int matchpathcon_init_prefix(const char *path, const char *prefix __attr=
ibute__((unused)))
>  {
>         if (!mycanoncon)
>                 mycanoncon =3D default_canoncon;
> @@ -355,8 +355,6 @@ int matchpathcon_init_prefix(const char *path, const =
char *subset)
>         __selinux_once(once, matchpathcon_init_once);
>         __selinux_setspecific(destructor_key, /* some valid address to pl=
ease GCC */ &selinux_page_size);
>
> -       options[SELABEL_OPT_SUBSET].type =3D SELABEL_OPT_SUBSET;
> -       options[SELABEL_OPT_SUBSET].value =3D subset;
>         options[SELABEL_OPT_PATH].type =3D SELABEL_OPT_PATH;
>         options[SELABEL_OPT_PATH].value =3D path;
>
> diff --git a/libselinux/utils/matchpathcon.c b/libselinux/utils/matchpath=
con.c
> index 1d713c01..8e1c45c1 100644
> --- a/libselinux/utils/matchpathcon.c
> +++ b/libselinux/utils/matchpathcon.c
> @@ -13,7 +13,7 @@
>  static __attribute__ ((__noreturn__)) void usage(const char *progname)
>  {
>         fprintf(stderr,
> -               "usage:  %s [-V] [-N] [-n] [-m type] [-f file_contexts_fi=
le] [-p prefix] [-P policy_root_path] filepath...\n",
> +               "usage:  %s [-V] [-N] [-n] [-m type] [-f file_contexts_fi=
le] [-P policy_root_path] filepath...\n",
>                 progname);
>         exit(1);
>  }
> @@ -83,7 +83,7 @@ int main(int argc, char **argv)
>         if (argc < 2)
>                 usage(argv[0]);
>
> -       while ((opt =3D getopt(argc, argv, "m:Nnf:P:p:Vq")) > 0) {
> +       while ((opt =3D getopt(argc, argv, "m:Nnf:P:Vq")) > 0) {
>                 switch (opt) {
>                 case 'n':
>                         header =3D 0;
> @@ -114,13 +114,6 @@ int main(int argc, char **argv)
>                                 exit(1);
>                         }
>                         break;
> -               case 'p':
> -                       // This option has been deprecated since libselin=
ux 2.5 (2016):
> -                       // https://github.com/SELinuxProject/selinux/comm=
it/26e05da0fc2d0a4bd274320968a88f8acbb3b6a6
> -                       fprintf(stderr, "Warning: using %s -p is deprecat=
ed\n", argv[0]);
> -                       options[SELABEL_OPT_SUBSET].type =3D SELABEL_OPT_=
SUBSET;
> -                       options[SELABEL_OPT_SUBSET].value =3D optarg;
> -                       break;
>                 case 'q':
>                         quiet =3D 1;
>                         break;
> diff --git a/libselinux/utils/sefcontext_compile.c b/libselinux/utils/sef=
context_compile.c
> index 6c32172d..eed6e4fd 100644
> --- a/libselinux/utils/sefcontext_compile.c
> +++ b/libselinux/utils/sefcontext_compile.c
> @@ -36,7 +36,6 @@ static int process_file(struct selabel_handle *rec, con=
st char *filename)
>         char *line_buf =3D NULL;
>         size_t line_len =3D 0;
>         FILE *context_file;
> -       const char *prefix =3D NULL;
>
>         context_file =3D fopen(filename, "r");
>         if (!context_file) {
> @@ -48,7 +47,7 @@ static int process_file(struct selabel_handle *rec, con=
st char *filename)
>         line_num =3D 0;
>         rc =3D 0;
>         while (getline(&line_buf, &line_len, context_file) > 0) {
> -               rc =3D process_line(rec, filename, prefix, line_buf, ++li=
ne_num);
> +               rc =3D process_line(rec, filename, line_buf, ++line_num);
>                 if (rc || ctx_err) {
>                         /* With -p option need to check and fail if ctx e=
rr as
>                          * process_line() context validation on Linux doe=
s not
> --
> 2.40.1
>
