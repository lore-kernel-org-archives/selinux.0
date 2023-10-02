Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85200E74902
	for <selinux@archiver.kernel.org>; Mon,  2 Oct 2023 17:34:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229576AbjJBReP (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 2 Oct 2023 13:34:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231587AbjJBReP (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 2 Oct 2023 13:34:15 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D40B4DC
        for <selinux@vger.kernel.org>; Mon,  2 Oct 2023 10:34:08 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id 38308e7fff4ca-2bff936e10fso40643321fa.1
        for <selinux@vger.kernel.org>; Mon, 02 Oct 2023 10:34:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696268047; x=1696872847; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FGWPywUV10VKTO9pdyIJkuV+83XuQxGwTMbNQ+T9tGI=;
        b=aK+Y1WHK/B4jGQOXEQO8ndSYUCQn6qB5zL/G3hdcrutTw29Fo1Mcx/rmLEDnIg6dvT
         onIjK6dSHqe4kMyQjNuHodYYvGsOaFD3mMW2b2eNrKpFRVq/ZnBX08YYTPzyEPdpzhGb
         AddrwOgpqHUBE+zKlncpJBumukv5RSMXo6wfI+tHGJv91bFgvfFSYWFE6mVQZ8mN6zge
         im+1DE1z/w5gV44Vvs/bBhLVOQ1pafGESoVa+RKoBmvYOISybtNYRi8Hxtj0wI0PAfGe
         y2MWOm2Kg/loabd3Rd2G7nBda9R/iR6CvQUZFSocQjXKwWRH9r4TwWoJQyri0QR/MUrl
         MafA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696268047; x=1696872847;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FGWPywUV10VKTO9pdyIJkuV+83XuQxGwTMbNQ+T9tGI=;
        b=OzZuGsmIIXHkcJfa9q+QVlCMy1LVTpuY4duGLDtw7/EQ2ixFZXyK0xSz4Kg/Zg3jDP
         nZTd9BP8Gk2eHRB0XoM8W4DpaR1KDHKtmpND3k/oCqpjZ1pzCd72AHzdn1x7esEH9qbw
         EM+Z1mmcG2pSZOi3qPILSpSpc/s5VgYcNnBkBhvblbLpGnYQnXYp7OW0Fp9I1EunBQMt
         pvNh2FCJl948g3P4Rp8i8Uw9016RnkExZDCLH1MXeZHpKLXHfoDBWViPHmLenwC5K4VF
         wAHVrZ+gredxIPV3RXwfOHq+75Yv0J0VCbPVFg4CtGrssdtBW9bfTedHodfGdwQZJp4s
         CVpA==
X-Gm-Message-State: AOJu0YxMYPKuFF46UHyp0100LoIpyKxwCAGdiBTCQRLNETvGiE3zO66a
        8tX3f20EyIYe+bhMl6UV9RM1ImCb9NUzw4hHhG7Y0NlO
X-Google-Smtp-Source: AGHT+IFTb+PKJ9i+/x9BFwW40Kv+6YkkL29yMoYGcz6v+H+9ylpwI+SJif4yFwNUW3VMrQwZc6zZnDNoAXWpspMZbAs=
X-Received: by 2002:a05:6512:39c3:b0:504:3464:b4a1 with SMTP id
 k3-20020a05651239c300b005043464b4a1mr250436lfu.22.1696268046827; Mon, 02 Oct
 2023 10:34:06 -0700 (PDT)
MIME-Version: 1.0
References: <20230814132025.45364-1-cgzones@googlemail.com> <20230814132025.45364-7-cgzones@googlemail.com>
In-Reply-To: <20230814132025.45364-7-cgzones@googlemail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Mon, 2 Oct 2023 13:33:55 -0400
Message-ID: <CAP+JOzR+zh389M=9vwp6uQJzpr8uc2wjRaRmFnzJs-RkP5tgbA@mail.gmail.com>
Subject: Re: [RFC PATCH v2 06/27] libselinux: cast to unsigned char for
 character handling function
To:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Aug 14, 2023 at 9:42=E2=80=AFAM Christian G=C3=B6ttsche
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
> index e9f3c96a..92ee2fc3 100644
> --- a/libselinux/src/compute_create.c
> +++ b/libselinux/src/compute_create.c
> @@ -23,7 +23,7 @@ static int object_name_encode(const char *objname, char=
 *buffer, size_t buflen)
>         do {
>                 code =3D *objname++;
>
> -               if (isalnum(code) || code =3D=3D '\0' || code =3D=3D '-' =
||
> +               if (isalnum((unsigned char)code) || code =3D=3D '\0' || c=
ode =3D=3D '-' ||

The variable code is an int.
It is the assignment to code a few lines above that needs the cast.

Everything else looks fine.

Thanks,
Jim


>                     code =3D=3D '.' || code =3D=3D '_' || code =3D=3D '~'=
) {
>                         if (buflen - offset < 1)
>                                 return -1;
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
> index 3da28c45..461abc61 100644
> --- a/libselinux/src/label_file.c
> +++ b/libselinux/src/label_file.c
> @@ -697,20 +697,20 @@ static int selabel_subs_init(const char *path, stru=
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
> index 3137c18e..f09461ab 100644
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
> index df474cba..94fb6697 100644
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
> index e6e8d9f6..e80bf107 100644
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
> 2.40.1
>
