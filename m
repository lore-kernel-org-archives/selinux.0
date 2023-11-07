Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 850CDC4167B
	for <selinux@archiver.kernel.org>; Tue,  7 Nov 2023 21:43:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235308AbjKGVnr (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 7 Nov 2023 16:43:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235309AbjKGVnr (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 7 Nov 2023 16:43:47 -0500
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2F2B10D0
        for <selinux@vger.kernel.org>; Tue,  7 Nov 2023 13:43:44 -0800 (PST)
Received: by mail-lj1-x22c.google.com with SMTP id 38308e7fff4ca-2c509d5ab43so89327531fa.0
        for <selinux@vger.kernel.org>; Tue, 07 Nov 2023 13:43:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699393423; x=1699998223; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=crMeS/MEBe7+47lie3k0aBuhyH0ooFgCBkQZnO00yzA=;
        b=YydO13FhfgmT73hGIJyRx3yzh0jV2UL5XD7e84iebMPadz6x6khdhI7Tu4VV1+2ZcO
         ZjQTPPFnyaeh1nhHp8wq8Fgvgh5C2uzTbKDqYFxOg+5Bi2PzebN+P1RN0bokfU9wee+l
         hHSW2Rjt46UOoOD7CfG2GUUz5XFCROE6/lpEscN1bHIrvwJsuIIoDgjsI6w/7u1UDLDc
         gBRpVkxwn36VkJSGgEknaXra+WwpP1rRteeZ3++FU35qhuG6VcHNSThIfC0WMLyeMvC8
         hz4nrrgs+n5ZFwRNg2vV7PvAG2i7DSTsxQGVr/kt1HUjgsb9uTEZy9N4H398pAoszSvo
         ZREQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699393423; x=1699998223;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=crMeS/MEBe7+47lie3k0aBuhyH0ooFgCBkQZnO00yzA=;
        b=R470ZgA2ejoRvFqYFZlcHHIh305aKSsxhi2ZuwDSgCY7zzR83qj6QI2Lb+pW0+ofut
         4Er+OTLqt+jigPzAP2gAKlfPxxc+kmBxNG0TxAP+7nYxQPcYPZ3Z9mp8NJyaE06GK97t
         TlvF1nacVt90dsS+JQSRuGbCJTsvLQ/+3UZ4fWo9zJ7Wsxq80BP+eB0ChblwHxLbA4tO
         uZTBQHMhgd0oGnzvFACPbS7dDS39L9QfcJrrUUCe2y8SpCeoG6dtNtEhCjNZzuMaMuB9
         E3JIyITRqzyV0fGJSuQS16EuqOAyG3hbolxJkjn2c2Mz7+Uytz/++7jvStvjhF2/VVTE
         +KHw==
X-Gm-Message-State: AOJu0YzO9S0LR5kovsWP/FxGglkHIr+cWde040akc5AvJ9w0baWPPA0s
        4qaTLaRJddJQJuXJmFfBK1rin6qCUK7D6pzVfDA25St/
X-Google-Smtp-Source: AGHT+IF2dCH6jN7mOl9+TwIo1c3ELcpuwAWC5q4TDizSjOKjkfgAxGtFbyTCpNkdxumP03/tyMI1X25dZq3lyb3j9YA=
X-Received: by 2002:a05:6512:688:b0:507:9a13:27bd with SMTP id
 t8-20020a056512068800b005079a1327bdmr32589036lfe.7.1699393422794; Tue, 07 Nov
 2023 13:43:42 -0800 (PST)
MIME-Version: 1.0
References: <20231101165636.184983-1-cgzones@googlemail.com> <CAP+JOzRxRrU2Q-nzXohzecamB9-Qhiczj87ZBrZj=w2PxX+E2Q@mail.gmail.com>
In-Reply-To: <CAP+JOzRxRrU2Q-nzXohzecamB9-Qhiczj87ZBrZj=w2PxX+E2Q@mail.gmail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Tue, 7 Nov 2023 16:43:31 -0500
Message-ID: <CAP+JOzQGCvbO3A_zP94ORpvkmO42xsSWFE8Q2TQHmJ_FG0Su5A@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] libselinux: cast to unsigned char for character
 handling function
To:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Nov 6, 2023 at 1:28=E2=80=AFPM James Carter <jwcart2@gmail.com> wro=
te:
>
> On Wed, Nov 1, 2023 at 12:57=E2=80=AFPM Christian G=C3=B6ttsche
> <cgzones@googlemail.com> wrote:
> >
> > Character handling functions, like isspace(3), expect a value
> > representable as unsigned char or equal to EOF.  Otherwise the behavior
> > is undefined.
> >
> > See https://wiki.sei.cmu.edu/confluence/display/c/STR37-C.+Arguments+to=
+character-handling+functions+must+be+representable+as+an+unsigned+char
> >
> > Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>
> Acked-by: James Carter <jwcart2@gmail.com>
>

These two patches have been merged.
Thanks,
Jim

> > ---
> > v3:
> >   - compute_create.c: avoid cast by changing type of variable
> >   - drop RFC and split from original patch set
> > ---
> >  libselinux/src/booleans.c                        |  8 ++++----
> >  libselinux/src/compute_create.c                  |  2 +-
> >  libselinux/src/get_context_list.c                | 12 ++++++------
> >  libselinux/src/get_default_type.c                |  2 +-
> >  libselinux/src/label_file.c                      |  8 ++++----
> >  libselinux/src/label_media.c                     |  2 +-
> >  libselinux/src/label_support.c                   |  8 ++++----
> >  libselinux/src/label_x.c                         |  2 +-
> >  libselinux/src/load_policy.c                     |  2 +-
> >  libselinux/src/matchmediacon.c                   |  6 +++---
> >  libselinux/src/selinux_check_securetty_context.c |  4 ++--
> >  libselinux/src/selinux_config.c                  | 12 ++++++------
> >  libselinux/src/seusers.c                         |  6 +++---
> >  13 files changed, 37 insertions(+), 37 deletions(-)
> >
> > diff --git a/libselinux/src/booleans.c b/libselinux/src/booleans.c
> > index e34b39ff..c557df65 100644
> > --- a/libselinux/src/booleans.c
> > +++ b/libselinux/src/booleans.c
> > @@ -107,7 +107,7 @@ char *selinux_boolean_sub(const char *name)
> >                 char *ptr;
> >                 char *src =3D line_buf;
> >                 char *dst;
> > -               while (*src && isspace(*src))
> > +               while (*src && isspace((unsigned char)*src))
> >                         src++;
> >                 if (!*src)
> >                         continue;
> > @@ -115,19 +115,19 @@ char *selinux_boolean_sub(const char *name)
> >                         continue;
> >
> >                 ptr =3D src;
> > -               while (*ptr && !isspace(*ptr))
> > +               while (*ptr && !isspace((unsigned char)*ptr))
> >                         ptr++;
> >                 *ptr++ =3D '\0';
> >                 if (strcmp(src, name) !=3D 0)
> >                         continue;
> >
> >                 dst =3D ptr;
> > -               while (*dst && isspace(*dst))
> > +               while (*dst && isspace((unsigned char)*dst))
> >                         dst++;
> >                 if (!*dst)
> >                         continue;
> >                 ptr =3D dst;
> > -               while (*ptr && !isspace(*ptr))
> > +               while (*ptr && !isspace((unsigned char)*ptr))
> >                         ptr++;
> >                 *ptr =3D '\0';
> >
> > diff --git a/libselinux/src/compute_create.c b/libselinux/src/compute_c=
reate.c
> > index e9f3c96a..d19baa0b 100644
> > --- a/libselinux/src/compute_create.c
> > +++ b/libselinux/src/compute_create.c
> > @@ -13,7 +13,7 @@
> >
> >  static int object_name_encode(const char *objname, char *buffer, size_=
t buflen)
> >  {
> > -       int     code;
> > +       unsigned char code;
> >         size_t  offset =3D 0;
> >
> >         if (buflen - offset < 1)
> > diff --git a/libselinux/src/get_context_list.c b/libselinux/src/get_con=
text_list.c
> > index d774b9cf..0342823c 100644
> > --- a/libselinux/src/get_context_list.c
> > +++ b/libselinux/src/get_context_list.c
> > @@ -170,27 +170,27 @@ static int get_context_user(FILE * fp,
> >
> >                 /* Skip leading whitespace. */
> >                 start =3D line;
> > -               while (*start && isspace(*start))
> > +               while (*start && isspace((unsigned char)*start))
> >                         start++;
> >                 if (!(*start))
> >                         continue;
> >
> >                 /* Find the end of the (partial) fromcon in the line. *=
/
> >                 end =3D start;
> > -               while (*end && !isspace(*end))
> > +               while (*end && !isspace((unsigned char)*end))
> >                         end++;
> >                 if (!(*end))
> >                         continue;
> >
> >                 /* Check for a match. */
> >                 linerole =3D start;
> > -               while (*start && !isspace(*start) && *start !=3D ':')
> > +               while (*start && !isspace((unsigned char)*start) && *st=
art !=3D ':')
> >                         start++;
> >                 if (*start !=3D ':')
> >                         continue;
> >                 *start =3D 0;
> >                 linetype =3D ++start;
> > -               while (*start && !isspace(*start) && *start !=3D ':')
> > +               while (*start && !isspace((unsigned char)*start) && *st=
art !=3D ':')
> >                         start++;
> >                 if (!(*start))
> >                         continue;
> > @@ -210,14 +210,14 @@ static int get_context_user(FILE * fp,
> >         start =3D ++end;
> >         while (*start) {
> >                 /* Skip leading whitespace */
> > -               while (*start && isspace(*start))
> > +               while (*start && isspace((unsigned char)*start))
> >                         start++;
> >                 if (!(*start))
> >                         break;
> >
> >                 /* Find the end of this partial context. */
> >                 end =3D start;
> > -               while (*end && !isspace(*end))
> > +               while (*end && !isspace((unsigned char)*end))
> >                         end++;
> >                 if (*end)
> >                         *end++ =3D 0;
> > diff --git a/libselinux/src/get_default_type.c b/libselinux/src/get_def=
ault_type.c
> > index 766ea4b7..87e9c72c 100644
> > --- a/libselinux/src/get_default_type.c
> > +++ b/libselinux/src/get_default_type.c
> > @@ -42,7 +42,7 @@ static int find_default_type(FILE * fp, const char *r=
ole, char **type)
> >                         buf[strlen(buf) - 1] =3D 0;
> >
> >                 ptr =3D buf;
> > -               while (*ptr && isspace(*ptr))
> > +               while (*ptr && isspace((unsigned char)*ptr))
> >                         ptr++;
> >                 if (!(*ptr))
> >                         continue;
> > diff --git a/libselinux/src/label_file.c b/libselinux/src/label_file.c
> > index a665c9b4..4778f8f8 100644
> > --- a/libselinux/src/label_file.c
> > +++ b/libselinux/src/label_file.c
> > @@ -708,20 +708,20 @@ static int selabel_subs_init(const char *path, st=
ruct selabel_digest *digest,
> >                 char *src =3D buf;
> >                 char *dst =3D NULL;
> >
> > -               while (*src && isspace(*src))
> > +               while (*src && isspace((unsigned char)*src))
> >                         src++;
> >                 if (src[0] =3D=3D '#') continue;
> >                 ptr =3D src;
> > -               while (*ptr && ! isspace(*ptr))
> > +               while (*ptr && ! isspace((unsigned char)*ptr))
> >                         ptr++;
> >                 *ptr++ =3D '\0';
> >                 if (! *src) continue;
> >
> >                 dst =3D ptr;
> > -               while (*dst && isspace(*dst))
> > +               while (*dst && isspace((unsigned char)*dst))
> >                         dst++;
> >                 ptr =3D dst;
> > -               while (*ptr && ! isspace(*ptr))
> > +               while (*ptr && ! isspace((unsigned char)*ptr))
> >                         ptr++;
> >                 *ptr =3D '\0';
> >                 if (! *dst)
> > diff --git a/libselinux/src/label_media.c b/libselinux/src/label_media.=
c
> > index d33b614a..b3443b47 100644
> > --- a/libselinux/src/label_media.c
> > +++ b/libselinux/src/label_media.c
> > @@ -39,7 +39,7 @@ static int process_line(const char *path, char *line_=
buf, int pass,
> >         char *key, *context;
> >
> >         buf_p =3D line_buf;
> > -       while (isspace(*buf_p))
> > +       while (isspace((unsigned char)*buf_p))
> >                 buf_p++;
> >         /* Skip comment lines and empty lines. */
> >         if (*buf_p =3D=3D '#' || *buf_p =3D=3D 0)
> > diff --git a/libselinux/src/label_support.c b/libselinux/src/label_supp=
ort.c
> > index 49f72b1c..f7ab9292 100644
> > --- a/libselinux/src/label_support.c
> > +++ b/libselinux/src/label_support.c
> > @@ -26,14 +26,14 @@ static inline int read_spec_entry(char **entry, cha=
r **ptr, int *len, const char
> >         *entry =3D NULL;
> >         char *tmp_buf =3D NULL;
> >
> > -       while (isspace(**ptr) && **ptr !=3D '\0')
> > +       while (isspace((unsigned char)**ptr) && **ptr !=3D '\0')
> >                 (*ptr)++;
> >
> >         tmp_buf =3D *ptr;
> >         *len =3D 0;
> >
> > -       while (!isspace(**ptr) && **ptr !=3D '\0') {
> > -               if (!isascii(**ptr)) {
> > +       while (!isspace((unsigned char)**ptr) && **ptr !=3D '\0') {
> > +               if (!isascii((unsigned char)**ptr)) {
> >                         errno =3D EINVAL;
> >                         *errbuf =3D "Non-ASCII characters found";
> >                         return -1;
> > @@ -80,7 +80,7 @@ int  read_spec_entries(char *line_buf, const char **e=
rrbuf, int num_args, ...)
> >                 len++;
> >
> >         buf_p =3D line_buf;
> > -       while (isspace(*buf_p))
> > +       while (isspace((unsigned char)*buf_p))
> >                 buf_p++;
> >
> >         /* Skip comment lines and empty lines. */
> > diff --git a/libselinux/src/label_x.c b/libselinux/src/label_x.c
> > index 4b8f524f..e15190ca 100644
> > --- a/libselinux/src/label_x.c
> > +++ b/libselinux/src/label_x.c
> > @@ -41,7 +41,7 @@ static int process_line(const char *path, char *line_=
buf, int pass,
> >         char *type, *key, *context;
> >
> >         buf_p =3D line_buf;
> > -       while (isspace(*buf_p))
> > +       while (isspace((unsigned char)*buf_p))
> >                 buf_p++;
> >         /* Skip comment lines and empty lines. */
> >         if (*buf_p =3D=3D '#' || *buf_p =3D=3D 0)
> > diff --git a/libselinux/src/load_policy.c b/libselinux/src/load_policy.=
c
> > index 17918e8b..57d7aaef 100644
> > --- a/libselinux/src/load_policy.c
> > +++ b/libselinux/src/load_policy.c
> > @@ -252,7 +252,7 @@ int selinux_init_load_policy(int *enforce)
> >                 }
> >                 if (fgets(buf, selinux_page_size, cfg) &&
> >                     (tmp =3D strstr(buf, "enforcing=3D"))) {
> > -                       if (tmp =3D=3D buf || isspace(*(tmp - 1))) {
> > +                       if (tmp =3D=3D buf || isspace((unsigned char)*(=
tmp - 1))) {
> >                                 secmdline =3D
> >                                     atoi(tmp + sizeof("enforcing=3D") -=
 1);
> >                         }
> > diff --git a/libselinux/src/matchmediacon.c b/libselinux/src/matchmedia=
con.c
> > index d3d95043..6ba87b99 100644
> > --- a/libselinux/src/matchmediacon.c
> > +++ b/libselinux/src/matchmediacon.c
> > @@ -29,7 +29,7 @@ int matchmediacon(const char *media, char ** con)
> >                         current_line[strlen(current_line) - 1] =3D 0;
> >                 /* Skip leading whitespace before the partial context. =
*/
> >                 ptr =3D current_line;
> > -               while (*ptr && isspace(*ptr))
> > +               while (*ptr && isspace((unsigned char)*ptr))
> >                         ptr++;
> >
> >                 if (!(*ptr))
> > @@ -37,7 +37,7 @@ int matchmediacon(const char *media, char ** con)
> >
> >                 /* Find the end of the media context. */
> >                 ptr2 =3D ptr;
> > -               while (*ptr2 && !isspace(*ptr2))
> > +               while (*ptr2 && !isspace((unsigned char)*ptr2))
> >                         ptr2++;
> >                 if (!(*ptr2))
> >                         continue;
> > @@ -53,7 +53,7 @@ int matchmediacon(const char *media, char ** con)
> >                 return -1;
> >
> >         /* Skip whitespace. */
> > -       while (*ptr2 && isspace(*ptr2))
> > +       while (*ptr2 && isspace((unsigned char)*ptr2))
> >                 ptr2++;
> >         if (!(*ptr2)) {
> >                 return -1;
> > diff --git a/libselinux/src/selinux_check_securetty_context.c b/libseli=
nux/src/selinux_check_securetty_context.c
> > index c5c557fd..7609752e 100644
> > --- a/libselinux/src/selinux_check_securetty_context.c
> > +++ b/libselinux/src/selinux_check_securetty_context.c
> > @@ -26,13 +26,13 @@ int selinux_check_securetty_context(const char * tt=
y_context)
> >
> >                                 /* Skip leading whitespace. */
> >                                 start =3D line;
> > -                               while (*start && isspace(*start))
> > +                               while (*start && isspace((unsigned char=
)*start))
> >                                         start++;
> >                                 if (!(*start))
> >                                         continue;
> >
> >                                 end =3D start;
> > -                               while (*end && !isspace(*end))
> > +                               while (*end && !isspace((unsigned char)=
*end))
> >                                         end++;
> >                                 if (*end)
> >                                         *end++ =3D 0;
> > diff --git a/libselinux/src/selinux_config.c b/libselinux/src/selinux_c=
onfig.c
> > index d2e49ee1..1d8cfb71 100644
> > --- a/libselinux/src/selinux_config.c
> > +++ b/libselinux/src/selinux_config.c
> > @@ -103,7 +103,7 @@ int selinux_getenforcemode(int *enforce)
> >                         if (strncmp(buf, SELINUXTAG, len))
> >                                 continue;
> >                         tag =3D buf+len;
> > -                       while (isspace(*tag))
> > +                       while (isspace((unsigned char)*tag))
> >                                 tag++;
> >                         if (!strncasecmp
> >                             (tag, "enforcing", sizeof("enforcing") - 1)=
) {
> > @@ -173,7 +173,7 @@ static void init_selinux_config(void)
> >                         if (line_buf[len - 1] =3D=3D '\n')
> >                                 line_buf[len - 1] =3D 0;
> >                         buf_p =3D line_buf;
> > -                       while (isspace(*buf_p))
> > +                       while (isspace((unsigned char)*buf_p))
> >                                 buf_p++;
> >                         if (*buf_p =3D=3D '#' || *buf_p =3D=3D 0)
> >                                 continue;
> > @@ -181,7 +181,7 @@ static void init_selinux_config(void)
> >                         if (!strncasecmp(buf_p, SELINUXTYPETAG,
> >                                          sizeof(SELINUXTYPETAG) - 1)) {
> >                                 buf_p +=3D sizeof(SELINUXTYPETAG) - 1;
> > -                               while (isspace(*buf_p))
> > +                               while (isspace((unsigned char)*buf_p))
> >                                         buf_p++;
> >                                 type =3D strdup(buf_p);
> >                                 if (!type) {
> > @@ -191,7 +191,7 @@ static void init_selinux_config(void)
> >                                 }
> >                                 end =3D type + strlen(type) - 1;
> >                                 while ((end > type) &&
> > -                                      (isspace(*end) || iscntrl(*end))=
) {
> > +                                      (isspace((unsigned char)*end) ||=
 iscntrl((unsigned char)*end))) {
> >                                         *end =3D 0;
> >                                         end--;
> >                                 }
> > @@ -206,14 +206,14 @@ static void init_selinux_config(void)
> >                         } else if (!strncmp(buf_p, REQUIRESEUSERS,
> >                                             sizeof(REQUIRESEUSERS) - 1)=
) {
> >                                 value =3D buf_p + sizeof(REQUIRESEUSERS=
) - 1;
> > -                               while (isspace(*value))
> > +                               while (isspace((unsigned char)*value))
> >                                         value++;
> >                                 intptr =3D &require_seusers;
> >                         } else {
> >                                 continue;
> >                         }
> >
> > -                       if (isdigit(*value))
> > +                       if (isdigit((unsigned char)*value))
> >                                 *intptr =3D atoi(value);
> >                         else if (strncasecmp(value, "true", sizeof("tru=
e") - 1))
> >                                 *intptr =3D 1;
> > diff --git a/libselinux/src/seusers.c b/libselinux/src/seusers.c
> > index fff80c1a..6da8c318 100644
> > --- a/libselinux/src/seusers.c
> > +++ b/libselinux/src/seusers.c
> > @@ -25,7 +25,7 @@ static int process_seusers(const char *buffer,
> >                 goto err;
> >
> >         start =3D newbuf;
> > -       while (isspace(*start))
> > +       while (isspace((unsigned char)*start))
> >                 start++;
> >         if (*start =3D=3D '#' || *start =3D=3D 0) {
> >                 free(newbuf);
> > @@ -46,7 +46,7 @@ static int process_seusers(const char *buffer,
> >                 mls_found =3D 0;
> >
> >                 end =3D start;
> > -               while (*end && !isspace(*end))
> > +               while (*end && !isspace((unsigned char)*end))
> >                         end++;
> >         }
> >         *end =3D 0;
> > @@ -63,7 +63,7 @@ static int process_seusers(const char *buffer,
> >                 goto out;
> >
> >         start =3D ++end;
> > -       while (*end && !isspace(*end))
> > +       while (*end && !isspace((unsigned char)*end))
> >                 end++;
> >         *end =3D 0;
> >
> > --
> > 2.42.0
> >
