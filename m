Return-Path: <SRS0=ovs9=T7=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2903BC04AB6
	for <selinux@archiver.kernel.org>; Fri, 31 May 2019 15:35:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EBD0426A47
	for <selinux@archiver.kernel.org>; Fri, 31 May 2019 15:35:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dlt5FxpC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726548AbfEaPfx (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 31 May 2019 11:35:53 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:33212 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726713AbfEaPfx (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 31 May 2019 11:35:53 -0400
Received: by mail-ot1-f65.google.com with SMTP id n18so9617965otq.0
        for <selinux@vger.kernel.org>; Fri, 31 May 2019 08:35:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=6IVGAILP+UeBlut+scEz6SN1J8xFoGG2wLtabC58wCI=;
        b=Dlt5FxpCfcPQ5e+SkqI8+9yfZC+oB8Oo7j1n0wQWgPr+mldeTjHh5Fpru9KqjLvBQD
         U5O6Z7LgbwZdKr+tFns21sfUJqIe8Et/ZtRc0f6Zs/05BbfOoy02klXTrWOrUj2vFVve
         tlClluLwOiiNwXWj+9htKQ/IPAu37jeqkl/bzvxfT+onqY++B10TUwMykvHU/sS2pUmb
         2NtslaZeC93R3nNigd5/5rBoGCdMcf4hkdAjNy+7u4Ndm3gzoFgt/Qlz6TewOyo+o8/+
         NGJi7jlFJVnWJ+lD0aQxLGFfajBAtqLg3jVS4H+peipW0QDoxlPPfITIK/KG2IgCAvZz
         1IcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=6IVGAILP+UeBlut+scEz6SN1J8xFoGG2wLtabC58wCI=;
        b=qP4shy/eglgMk3Hyg6owL4zcKo2mheCzGOFA61Y0Y2WK80gZXdcLw7udawpm/5orn+
         Dd1CywMYD68GX0akY8kF7Ie0bBSvZVw3Y3qr/vRaLMopkm2bjRp97/uHucXy5ISBuLDn
         bJAJKyR5inf4SDHLpRMAGZv2CZUhpA7ZwXga0hgf776trMbuBR4w+ExwTg2aJdHoWwOo
         9VvIfXtZurTccEBIRS33q8sY3Jj22a8KtV3R3jwihDydobfp+1sxpb5sw2qHmFw4Qx0d
         S7/8q/4GrcZ1IcEO4B0RnKhf43gmo2c8siQR3Myv2QoPspXRC7p/xrW23KbzaKRwA5G0
         gFpQ==
X-Gm-Message-State: APjAAAVRpUvqLqz4Z+i0N5riujjilyiyyHluZq9k7iFcw56eIBGF7qKF
        2yFfMYniGUpL2Y++BCvQXH1BhkW8zntbMIwvL9Z1w3TZ
X-Google-Smtp-Source: APXvYqy05HvPvxGuz2lt4VCtiBEEGCw8lSERJpLDxpTnCfRTc51Jt36r/eE3MYLrLW4Tx+oqGYq2fM6b9DHqJZTKN1Y=
X-Received: by 2002:a9d:dca:: with SMTP id 68mr2370158ots.119.1559316951791;
 Fri, 31 May 2019 08:35:51 -0700 (PDT)
MIME-Version: 1.0
References: <20190531131446.9402-1-richard_c_haines@btinternet.com>
In-Reply-To: <20190531131446.9402-1-richard_c_haines@btinternet.com>
From:   William Roberts <bill.c.roberts@gmail.com>
Date:   Fri, 31 May 2019 08:35:38 -0700
Message-ID: <CAFftDdpBhc6xNKxYD7xXOZA6EViBYzmatR2BCnzvi6mXkxbxcQ@mail.gmail.com>
Subject: Re: [PATCH] selinux: Fix strncpy in libselinux and libsepol
To:     Richard Haines <richard_c_haines@btinternet.com>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, May 31, 2019 at 8:23 AM Richard Haines
<richard_c_haines@btinternet.com> wrote:
>
> When building with gcc9, get build errors such as:
>
> genbools.c:24:2: error: =E2=80=98strncpy=E2=80=99 output may be truncated=
 copying 8191
> bytes from a string of length 8191 [-Werror=3Dstringop-truncation]
>    24 |  strncpy(dest, ptr, size);
>       |  ^~~~~~~~~~~~~~~~~~~~~~~~
>
> Signed-off-by: Richard Haines <richard_c_haines@btinternet.com>
> ---
>  libselinux/src/booleans.c |  4 ++--
>  libsepol/src/genbools.c   | 20 +++++++++++---------
>  2 files changed, 13 insertions(+), 11 deletions(-)
>
> diff --git a/libselinux/src/booleans.c b/libselinux/src/booleans.c
> index ab1e0754..cdc03517 100644
> --- a/libselinux/src/booleans.c
> +++ b/libselinux/src/booleans.c
> @@ -539,7 +539,7 @@ int security_load_booleans(char *path)
>
>         __fsetlocking(boolf, FSETLOCKING_BYCALLER);
>         while (getline(&inbuf, &len, boolf) > 0) {
> -               int ret =3D process_boolean(inbuf, name, sizeof(name), &v=
al);
> +               int ret =3D process_boolean(inbuf, name, len, &val);
>                 if (ret =3D=3D -1)
>                         errors++;
>                 if (ret =3D=3D 1)
> @@ -557,7 +557,7 @@ int security_load_booleans(char *path)
>                 int ret;
>                 __fsetlocking(boolf, FSETLOCKING_BYCALLER);
>                 while (getline(&inbuf, &len, boolf) > 0) {
> -                       ret =3D process_boolean(inbuf, name, sizeof(name)=
, &val);
> +                       ret =3D process_boolean(inbuf, name, len, &val);
>                         if (ret =3D=3D -1)
>                                 errors++;
>                         if (ret =3D=3D 1)
> diff --git a/libsepol/src/genbools.c b/libsepol/src/genbools.c
> index d4a2df62..ad194ca6 100644
> --- a/libsepol/src/genbools.c
> +++ b/libsepol/src/genbools.c
> @@ -10,6 +10,8 @@
>  #include "private.h"
>  #include "dso.h"
>
> +#define FGET_BUFSIZ 255
> +
>  /* -- Deprecated -- */
>
>  static char *strtrim(char *dest, char *source, int size)
> @@ -32,7 +34,7 @@ static char *strtrim(char *dest, char *source, int size=
)
>
>  static int process_boolean(char *buffer, char *name, int namesize, int *=
val)
>  {
> -       char name1[BUFSIZ];
> +       char name1[FGET_BUFSIZ];
>         char *ptr =3D NULL;
>         char *tok;
>
> @@ -48,7 +50,7 @@ static int process_boolean(char *buffer, char *name, in=
t namesize, int *val)
>                 ERR(NULL, "illegal boolean definition %s", buffer);
>                 return -1;
>         }
> -       strncpy(name1, tok, BUFSIZ - 1);
> +       strncpy(name1, tok, FGET_BUFSIZ - 1);
>         strtrim(name, name1, namesize - 1);
>
>         tok =3D strtok_r(NULL, "\0", &ptr);
> @@ -79,8 +81,8 @@ static int load_booleans(struct policydb *policydb, con=
st char *path,
>  {
>         FILE *boolf;
>         char *buffer =3D NULL;
> -       char localbools[BUFSIZ];
> -       char name[BUFSIZ];
> +       char localbools[FGET_BUFSIZ];
> +       char name[FGET_BUFSIZ + 1];
>         int val;
>         int errors =3D 0, changes =3D 0;
>         struct cond_bool_datum *datum;
> @@ -90,12 +92,12 @@ static int load_booleans(struct policydb *policydb, c=
onst char *path,
>                 goto localbool;
>
>  #ifdef __APPLE__
> -        if ((buffer =3D (char *)malloc(255 * sizeof(char))) =3D=3D NULL)=
 {
> -          ERR(NULL, "out of memory");
> -         return -1;
> +       if ((buffer =3D (char *)malloc(FGET_BUFSIZ * sizeof(char))) =3D=
=3D NULL) {
> +               ERR(NULL, "out of memory");
> +               return -1;
>         }
>
> -        while(fgets(buffer, 255, boolf) !=3D NULL) {
> +       while (fgets(buffer, FGET_BUFSIZ, boolf) !=3D NULL) {
>  #else
>         size_t size =3D 0;
>         while (getline(&buffer, &size, boolf) > 0) {
> @@ -124,7 +126,7 @@ static int load_booleans(struct policydb *policydb, c=
onst char *path,
>
>  #ifdef __APPLE__
>
> -         while(fgets(buffer, 255, boolf) !=3D NULL) {
> +       while (fgets(buffer, FGET_BUFSIZ, boolf) !=3D NULL) {
>  #else
>
>             while (getline(&buffer, &size, boolf) > 0) {
> --
> 2.21.0
>
This seems fine to me, ack. Still running the test suite, but I don't
see why anything would break.
