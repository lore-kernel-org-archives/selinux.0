Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08B2BC4332F
	for <selinux@archiver.kernel.org>; Mon,  6 Nov 2023 18:28:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231800AbjKFS2c (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 6 Nov 2023 13:28:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231773AbjKFS2b (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 6 Nov 2023 13:28:31 -0500
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B249BD61
        for <selinux@vger.kernel.org>; Mon,  6 Nov 2023 10:28:27 -0800 (PST)
Received: by mail-lf1-x12b.google.com with SMTP id 2adb3069b0e04-507bd19eac8so6168402e87.0
        for <selinux@vger.kernel.org>; Mon, 06 Nov 2023 10:28:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699295306; x=1699900106; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SkMPrnwu7YEfQyOttFVl881Z/Ogi6ZUNJveVWaOK5W0=;
        b=lzecAZAayTZxcBrtWeroo59s78/vsF/4mzpmgUgVGWjs1fHntV7p8dE0BiYzKHp5Tn
         pHDXBwtA2soTVCla5SiR4OyRvAJOQnlo1A46daDBPxRDSiUYIJTjyotHlRm1quNB/CDa
         K4RJbd959H5/Sv+SRzFFvTQqsRb3KaWvEFFD1OAGFE4w9UYhtnYgpq+ev7Gnjlt84duw
         NKd9qEUVAQZuj4UHIUudEKwcEc2gQOcMVAyjqfV95NoqBovU/5uGyTIWjL8sqD5PGWS3
         nVtXs55Qk7Wyf9R8IcTNnGF3hmDZ5fH4Cs66opqCJhOZNhQoDg3Fv5KLPvXPELvD7yQb
         eiyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699295306; x=1699900106;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SkMPrnwu7YEfQyOttFVl881Z/Ogi6ZUNJveVWaOK5W0=;
        b=ZV9lZRtNmXScIDirkLZRLqHGoVzjTWa6Dkt37nGMHGF+hrNXXOMgDEwq42tjVXtUos
         XcDMJkdo0wkv93nM3JGK2VhkFI/B+xF7W2M7VYvRo3s6TXTc4aA4KdVdk+3IU35MmW91
         3BsvhidUTx/CWyS+Fet1R3ibN1wVlegR/NnTw1/Om4pHFyd3CY4ueK5Kocbp32X/E4bo
         ecuDnYbW6E4AEQ31QCljhyKWE2ImW8rRv5A9OZcrVBwEX96QUfHG+jQnIpuGamkmxeRl
         /OTDogwTvO8+jpA7q36xRDUTJILFiVmQ4Z3yzuoFyLskuC6deD23k7dxk0JxbDizdFxe
         VOeg==
X-Gm-Message-State: AOJu0Ywwph/AQLQH8+yhWBgyLPDdIwx+76D+0Q96EmsQ5NrvDTZ93xY5
        dJTbT86rFq01s7E3Wl/InoTqceKfxxDEcKWdYbuPwzddioU=
X-Google-Smtp-Source: AGHT+IF3USXKGc4vL8Iexi/I+E0+8c6WraGIRq1b5y/W+BmijfY2/Zz6aGnjpexZg3Y1N3K3UvWL/tBNfziDIoOd4Uo=
X-Received: by 2002:a05:6512:3c98:b0:509:493a:7d64 with SMTP id
 h24-20020a0565123c9800b00509493a7d64mr12794491lfv.41.1699295305547; Mon, 06
 Nov 2023 10:28:25 -0800 (PST)
MIME-Version: 1.0
References: <20231101165636.184983-1-cgzones@googlemail.com>
In-Reply-To: <20231101165636.184983-1-cgzones@googlemail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Mon, 6 Nov 2023 13:28:14 -0500
Message-ID: <CAP+JOzRxRrU2Q-nzXohzecamB9-Qhiczj87ZBrZj=w2PxX+E2Q@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] libselinux: cast to unsigned char for character
 handling function
To:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Nov 1, 2023 at 12:57=E2=80=AFPM Christian G=C3=B6ttsche
<cgzones@googlemail.com> wrote:
>
> Character handling functions, like isspace(3), expect a value
> representable as unsigned char or equal to EOF.  Otherwise the behavior
> is undefined.
>
> See https://wiki.sei.cmu.edu/confluence/display/c/STR37-C.+Arguments+to+c=
haracter-handling+functions+must+be+representable+as+an+unsigned+char
>
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>

Acked-by: James Carter <jwcart2@gmail.com>

> ---
> v3:
>   - compute_create.c: avoid cast by changing type of variable
>   - drop RFC and split from original patch set
> ---
>  libselinux/src/booleans.c                        |  8 ++++----
>  libselinux/src/compute_create.c                  |  2 +-
>  libselinux/src/get_context_list.c                | 12 ++++++------
>  libselinux/src/get_default_type.c                |  2 +-
>  libselinux/src/label_file.c                      |  8 ++++----
>  libselinux/src/label_media.c                     |  2 +-
>  libselinux/src/label_support.c                   |  8 ++++----
>  libselinux/src/label_x.c                         |  2 +-
>  libselinux/src/load_policy.c                     |  2 +-
>  libselinux/src/matchmediacon.c                   |  6 +++---
>  libselinux/src/selinux_check_securetty_context.c |  4 ++--
>  libselinux/src/selinux_config.c                  | 12 ++++++------
>  libselinux/src/seusers.c                         |  6 +++---
>  13 files changed, 37 insertions(+), 37 deletions(-)
>
> diff --git a/libselinux/src/booleans.c b/libselinux/src/booleans.c
> index e34b39ff..c557df65 100644
> --- a/libselinux/src/booleans.c
> +++ b/libselinux/src/booleans.c
> @@ -107,7 +107,7 @@ char *selinux_boolean_sub(const char *name)
>                 char *ptr;
>                 char *src =3D line_buf;
>                 char *dst;
> -               while (*src && isspace(*src))
> +               while (*src && isspace((unsigned char)*src))
>                         src++;
>                 if (!*src)
>                         continue;
> @@ -115,19 +115,19 @@ char *selinux_boolean_sub(const char *name)
>                         continue;
>
>                 ptr =3D src;
> -               while (*ptr && !isspace(*ptr))
> +               while (*ptr && !isspace((unsigned char)*ptr))
>                         ptr++;
>                 *ptr++ =3D '\0';
>                 if (strcmp(src, name) !=3D 0)
>                         continue;
>
>                 dst =3D ptr;
> -               while (*dst && isspace(*dst))
> +               while (*dst && isspace((unsigned char)*dst))
>                         dst++;
>                 if (!*dst)
>                         continue;
>                 ptr =3D dst;
> -               while (*ptr && !isspace(*ptr))
> +               while (*ptr && !isspace((unsigned char)*ptr))
>                         ptr++;
>                 *ptr =3D '\0';
>
> diff --git a/libselinux/src/compute_create.c b/libselinux/src/compute_cre=
ate.c
> index e9f3c96a..d19baa0b 100644
> --- a/libselinux/src/compute_create.c
> +++ b/libselinux/src/compute_create.c
> @@ -13,7 +13,7 @@
>
>  static int object_name_encode(const char *objname, char *buffer, size_t =
buflen)
>  {
> -       int     code;
> +       unsigned char code;
>         size_t  offset =3D 0;
>
>         if (buflen - offset < 1)
> diff --git a/libselinux/src/get_context_list.c b/libselinux/src/get_conte=
xt_list.c
> index d774b9cf..0342823c 100644
> --- a/libselinux/src/get_context_list.c
> +++ b/libselinux/src/get_context_list.c
> @@ -170,27 +170,27 @@ static int get_context_user(FILE * fp,
>
>                 /* Skip leading whitespace. */
>                 start =3D line;
> -               while (*start && isspace(*start))
> +               while (*start && isspace((unsigned char)*start))
>                         start++;
>                 if (!(*start))
>                         continue;
>
>                 /* Find the end of the (partial) fromcon in the line. */
>                 end =3D start;
> -               while (*end && !isspace(*end))
> +               while (*end && !isspace((unsigned char)*end))
>                         end++;
>                 if (!(*end))
>                         continue;
>
>                 /* Check for a match. */
>                 linerole =3D start;
> -               while (*start && !isspace(*start) && *start !=3D ':')
> +               while (*start && !isspace((unsigned char)*start) && *star=
t !=3D ':')
>                         start++;
>                 if (*start !=3D ':')
>                         continue;
>                 *start =3D 0;
>                 linetype =3D ++start;
> -               while (*start && !isspace(*start) && *start !=3D ':')
> +               while (*start && !isspace((unsigned char)*start) && *star=
t !=3D ':')
>                         start++;
>                 if (!(*start))
>                         continue;
> @@ -210,14 +210,14 @@ static int get_context_user(FILE * fp,
>         start =3D ++end;
>         while (*start) {
>                 /* Skip leading whitespace */
> -               while (*start && isspace(*start))
> +               while (*start && isspace((unsigned char)*start))
>                         start++;
>                 if (!(*start))
>                         break;
>
>                 /* Find the end of this partial context. */
>                 end =3D start;
> -               while (*end && !isspace(*end))
> +               while (*end && !isspace((unsigned char)*end))
>                         end++;
>                 if (*end)
>                         *end++ =3D 0;
> diff --git a/libselinux/src/get_default_type.c b/libselinux/src/get_defau=
lt_type.c
> index 766ea4b7..87e9c72c 100644
> --- a/libselinux/src/get_default_type.c
> +++ b/libselinux/src/get_default_type.c
> @@ -42,7 +42,7 @@ static int find_default_type(FILE * fp, const char *rol=
e, char **type)
>                         buf[strlen(buf) - 1] =3D 0;
>
>                 ptr =3D buf;
> -               while (*ptr && isspace(*ptr))
> +               while (*ptr && isspace((unsigned char)*ptr))
>                         ptr++;
>                 if (!(*ptr))
>                         continue;
> diff --git a/libselinux/src/label_file.c b/libselinux/src/label_file.c
> index a665c9b4..4778f8f8 100644
> --- a/libselinux/src/label_file.c
> +++ b/libselinux/src/label_file.c
> @@ -708,20 +708,20 @@ static int selabel_subs_init(const char *path, stru=
ct selabel_digest *digest,
>                 char *src =3D buf;
>                 char *dst =3D NULL;
>
> -               while (*src && isspace(*src))
> +               while (*src && isspace((unsigned char)*src))
>                         src++;
>                 if (src[0] =3D=3D '#') continue;
>                 ptr =3D src;
> -               while (*ptr && ! isspace(*ptr))
> +               while (*ptr && ! isspace((unsigned char)*ptr))
>                         ptr++;
>                 *ptr++ =3D '\0';
>                 if (! *src) continue;
>
>                 dst =3D ptr;
> -               while (*dst && isspace(*dst))
> +               while (*dst && isspace((unsigned char)*dst))
>                         dst++;
>                 ptr =3D dst;
> -               while (*ptr && ! isspace(*ptr))
> +               while (*ptr && ! isspace((unsigned char)*ptr))
>                         ptr++;
>                 *ptr =3D '\0';
>                 if (! *dst)
> diff --git a/libselinux/src/label_media.c b/libselinux/src/label_media.c
> index d33b614a..b3443b47 100644
> --- a/libselinux/src/label_media.c
> +++ b/libselinux/src/label_media.c
> @@ -39,7 +39,7 @@ static int process_line(const char *path, char *line_bu=
f, int pass,
>         char *key, *context;
>
>         buf_p =3D line_buf;
> -       while (isspace(*buf_p))
> +       while (isspace((unsigned char)*buf_p))
>                 buf_p++;
>         /* Skip comment lines and empty lines. */
>         if (*buf_p =3D=3D '#' || *buf_p =3D=3D 0)
> diff --git a/libselinux/src/label_support.c b/libselinux/src/label_suppor=
t.c
> index 49f72b1c..f7ab9292 100644
> --- a/libselinux/src/label_support.c
> +++ b/libselinux/src/label_support.c
> @@ -26,14 +26,14 @@ static inline int read_spec_entry(char **entry, char =
**ptr, int *len, const char
>         *entry =3D NULL;
>         char *tmp_buf =3D NULL;
>
> -       while (isspace(**ptr) && **ptr !=3D '\0')
> +       while (isspace((unsigned char)**ptr) && **ptr !=3D '\0')
>                 (*ptr)++;
>
>         tmp_buf =3D *ptr;
>         *len =3D 0;
>
> -       while (!isspace(**ptr) && **ptr !=3D '\0') {
> -               if (!isascii(**ptr)) {
> +       while (!isspace((unsigned char)**ptr) && **ptr !=3D '\0') {
> +               if (!isascii((unsigned char)**ptr)) {
>                         errno =3D EINVAL;
>                         *errbuf =3D "Non-ASCII characters found";
>                         return -1;
> @@ -80,7 +80,7 @@ int  read_spec_entries(char *line_buf, const char **err=
buf, int num_args, ...)
>                 len++;
>
>         buf_p =3D line_buf;
> -       while (isspace(*buf_p))
> +       while (isspace((unsigned char)*buf_p))
>                 buf_p++;
>
>         /* Skip comment lines and empty lines. */
> diff --git a/libselinux/src/label_x.c b/libselinux/src/label_x.c
> index 4b8f524f..e15190ca 100644
> --- a/libselinux/src/label_x.c
> +++ b/libselinux/src/label_x.c
> @@ -41,7 +41,7 @@ static int process_line(const char *path, char *line_bu=
f, int pass,
>         char *type, *key, *context;
>
>         buf_p =3D line_buf;
> -       while (isspace(*buf_p))
> +       while (isspace((unsigned char)*buf_p))
>                 buf_p++;
>         /* Skip comment lines and empty lines. */
>         if (*buf_p =3D=3D '#' || *buf_p =3D=3D 0)
> diff --git a/libselinux/src/load_policy.c b/libselinux/src/load_policy.c
> index 17918e8b..57d7aaef 100644
> --- a/libselinux/src/load_policy.c
> +++ b/libselinux/src/load_policy.c
> @@ -252,7 +252,7 @@ int selinux_init_load_policy(int *enforce)
>                 }
>                 if (fgets(buf, selinux_page_size, cfg) &&
>                     (tmp =3D strstr(buf, "enforcing=3D"))) {
> -                       if (tmp =3D=3D buf || isspace(*(tmp - 1))) {
> +                       if (tmp =3D=3D buf || isspace((unsigned char)*(tm=
p - 1))) {
>                                 secmdline =3D
>                                     atoi(tmp + sizeof("enforcing=3D") - 1=
);
>                         }
> diff --git a/libselinux/src/matchmediacon.c b/libselinux/src/matchmediaco=
n.c
> index d3d95043..6ba87b99 100644
> --- a/libselinux/src/matchmediacon.c
> +++ b/libselinux/src/matchmediacon.c
> @@ -29,7 +29,7 @@ int matchmediacon(const char *media, char ** con)
>                         current_line[strlen(current_line) - 1] =3D 0;
>                 /* Skip leading whitespace before the partial context. */
>                 ptr =3D current_line;
> -               while (*ptr && isspace(*ptr))
> +               while (*ptr && isspace((unsigned char)*ptr))
>                         ptr++;
>
>                 if (!(*ptr))
> @@ -37,7 +37,7 @@ int matchmediacon(const char *media, char ** con)
>
>                 /* Find the end of the media context. */
>                 ptr2 =3D ptr;
> -               while (*ptr2 && !isspace(*ptr2))
> +               while (*ptr2 && !isspace((unsigned char)*ptr2))
>                         ptr2++;
>                 if (!(*ptr2))
>                         continue;
> @@ -53,7 +53,7 @@ int matchmediacon(const char *media, char ** con)
>                 return -1;
>
>         /* Skip whitespace. */
> -       while (*ptr2 && isspace(*ptr2))
> +       while (*ptr2 && isspace((unsigned char)*ptr2))
>                 ptr2++;
>         if (!(*ptr2)) {
>                 return -1;
> diff --git a/libselinux/src/selinux_check_securetty_context.c b/libselinu=
x/src/selinux_check_securetty_context.c
> index c5c557fd..7609752e 100644
> --- a/libselinux/src/selinux_check_securetty_context.c
> +++ b/libselinux/src/selinux_check_securetty_context.c
> @@ -26,13 +26,13 @@ int selinux_check_securetty_context(const char * tty_=
context)
>
>                                 /* Skip leading whitespace. */
>                                 start =3D line;
> -                               while (*start && isspace(*start))
> +                               while (*start && isspace((unsigned char)*=
start))
>                                         start++;
>                                 if (!(*start))
>                                         continue;
>
>                                 end =3D start;
> -                               while (*end && !isspace(*end))
> +                               while (*end && !isspace((unsigned char)*e=
nd))
>                                         end++;
>                                 if (*end)
>                                         *end++ =3D 0;
> diff --git a/libselinux/src/selinux_config.c b/libselinux/src/selinux_con=
fig.c
> index d2e49ee1..1d8cfb71 100644
> --- a/libselinux/src/selinux_config.c
> +++ b/libselinux/src/selinux_config.c
> @@ -103,7 +103,7 @@ int selinux_getenforcemode(int *enforce)
>                         if (strncmp(buf, SELINUXTAG, len))
>                                 continue;
>                         tag =3D buf+len;
> -                       while (isspace(*tag))
> +                       while (isspace((unsigned char)*tag))
>                                 tag++;
>                         if (!strncasecmp
>                             (tag, "enforcing", sizeof("enforcing") - 1)) =
{
> @@ -173,7 +173,7 @@ static void init_selinux_config(void)
>                         if (line_buf[len - 1] =3D=3D '\n')
>                                 line_buf[len - 1] =3D 0;
>                         buf_p =3D line_buf;
> -                       while (isspace(*buf_p))
> +                       while (isspace((unsigned char)*buf_p))
>                                 buf_p++;
>                         if (*buf_p =3D=3D '#' || *buf_p =3D=3D 0)
>                                 continue;
> @@ -181,7 +181,7 @@ static void init_selinux_config(void)
>                         if (!strncasecmp(buf_p, SELINUXTYPETAG,
>                                          sizeof(SELINUXTYPETAG) - 1)) {
>                                 buf_p +=3D sizeof(SELINUXTYPETAG) - 1;
> -                               while (isspace(*buf_p))
> +                               while (isspace((unsigned char)*buf_p))
>                                         buf_p++;
>                                 type =3D strdup(buf_p);
>                                 if (!type) {
> @@ -191,7 +191,7 @@ static void init_selinux_config(void)
>                                 }
>                                 end =3D type + strlen(type) - 1;
>                                 while ((end > type) &&
> -                                      (isspace(*end) || iscntrl(*end))) =
{
> +                                      (isspace((unsigned char)*end) || i=
scntrl((unsigned char)*end))) {
>                                         *end =3D 0;
>                                         end--;
>                                 }
> @@ -206,14 +206,14 @@ static void init_selinux_config(void)
>                         } else if (!strncmp(buf_p, REQUIRESEUSERS,
>                                             sizeof(REQUIRESEUSERS) - 1)) =
{
>                                 value =3D buf_p + sizeof(REQUIRESEUSERS) =
- 1;
> -                               while (isspace(*value))
> +                               while (isspace((unsigned char)*value))
>                                         value++;
>                                 intptr =3D &require_seusers;
>                         } else {
>                                 continue;
>                         }
>
> -                       if (isdigit(*value))
> +                       if (isdigit((unsigned char)*value))
>                                 *intptr =3D atoi(value);
>                         else if (strncasecmp(value, "true", sizeof("true"=
) - 1))
>                                 *intptr =3D 1;
> diff --git a/libselinux/src/seusers.c b/libselinux/src/seusers.c
> index fff80c1a..6da8c318 100644
> --- a/libselinux/src/seusers.c
> +++ b/libselinux/src/seusers.c
> @@ -25,7 +25,7 @@ static int process_seusers(const char *buffer,
>                 goto err;
>
>         start =3D newbuf;
> -       while (isspace(*start))
> +       while (isspace((unsigned char)*start))
>                 start++;
>         if (*start =3D=3D '#' || *start =3D=3D 0) {
>                 free(newbuf);
> @@ -46,7 +46,7 @@ static int process_seusers(const char *buffer,
>                 mls_found =3D 0;
>
>                 end =3D start;
> -               while (*end && !isspace(*end))
> +               while (*end && !isspace((unsigned char)*end))
>                         end++;
>         }
>         *end =3D 0;
> @@ -63,7 +63,7 @@ static int process_seusers(const char *buffer,
>                 goto out;
>
>         start =3D ++end;
> -       while (*end && !isspace(*end))
> +       while (*end && !isspace((unsigned char)*end))
>                 end++;
>         *end =3D 0;
>
> --
> 2.42.0
>
