Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CFF3C4743C
	for <selinux@archiver.kernel.org>; Mon, 21 Jun 2021 20:55:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 523F96102A
	for <selinux@archiver.kernel.org>; Mon, 21 Jun 2021 20:55:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230206AbhFUU5k (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 21 Jun 2021 16:57:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230052AbhFUU5j (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 21 Jun 2021 16:57:39 -0400
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82DB1C061574
        for <selinux@vger.kernel.org>; Mon, 21 Jun 2021 13:55:23 -0700 (PDT)
Received: by mail-ot1-x336.google.com with SMTP id n99-20020a9d206c0000b029045d4f996e62so340230ota.4
        for <selinux@vger.kernel.org>; Mon, 21 Jun 2021 13:55:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ENij7eCAATV1qVjw1B94Jz3CW9Kuh4L0Lls/0JZrR2Y=;
        b=MAtUJSk7sIKNpimgT0/Nr0MMUs0Td49YRiFbaLlLFS5wjFQoluVIcYngEuwEz8dLwB
         gH4ixyQS3yUsOTXkq8c2QxKIm0DtlXZLPGiUUuONmcgtJI/sE8C7cPBISrluV+Uu7oQR
         Lj3NA4F4ZJTSJ0G7e5/ylQeZm5fbLyv+hBsxFGzvFmzS+WRlj+/7OCW4IKYVRFnIg5IH
         CAMUyCBnY1dOUe6oBw/mJP24q7r0aYHppBW2s3O6U+lwBgZlnGMzzJnXig+C43a0T/T6
         0+MRDAgjrhTp+2Uhy0cawE42AluQpPvpisXEGq32wFmbxis0aVEg1199w94nPwyxl0eO
         vSLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ENij7eCAATV1qVjw1B94Jz3CW9Kuh4L0Lls/0JZrR2Y=;
        b=DAmtL3DeCh+NFvXpLRBmh5FWJN6q+m2Fz+/MFtRnuWgdm5LnHncf8mvbSnz3J4feBS
         sRYD5/mUxd9b5DDEOwCFEeFpYagOdSaOxKuLExFpGtc4F35wuM7IuLYUaTbB0UPdX5dV
         ymlaq4NfkWlbhIRCwIO4NvuwY4Qk0xyuIg8vNVdvzizuGC0ap8a/Ewktz4vz58sXWEeC
         is0mEcFgy4weXu6B54TaT/T0WeSuozFkvioSitadPnmr1kMmw4Y5SMcZ+HdL1sOdCjup
         KPWW0WfMd+AeKaYBt9wAEj6qGO5JN9IXIduxolwMSTAnKMnNxFTmCiVP0777PPf2a9hm
         vS6Q==
X-Gm-Message-State: AOAM531Luv6k8Qch+lPYrOELYf0kwsTs2SD35wssqRj113lISaHRsTVF
        gPug52AqDVa9glGbyoc/32DS9L7UPTCBcKXqxTU=
X-Google-Smtp-Source: ABdhPJwu8wJvWxpCbJWaJP3KD7jERfcQqd9j5I6e3lqykQfwWZCc3YkK5I8/MzZdsJt55AIg7UT37l5F7pIgR29tOTw=
X-Received: by 2002:a9d:618f:: with SMTP id g15mr9710otk.196.1624308922923;
 Mon, 21 Jun 2021 13:55:22 -0700 (PDT)
MIME-Version: 1.0
References: <20210608155912.32047-1-cgzones@googlemail.com> <20210608155912.32047-19-cgzones@googlemail.com>
In-Reply-To: <20210608155912.32047-19-cgzones@googlemail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Mon, 21 Jun 2021 16:55:12 -0400
Message-ID: <CAP+JOzRbZOdT8BbcBG12J+rL_fry8Kt0Kg+--BPXzHHJgPYYtg@mail.gmail.com>
Subject: Re: [PATCH 18/23] libsepol/cil: drop unnecessary casts
To:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Jun 8, 2021 at 12:00 PM Christian G=C3=B6ttsche
<cgzones@googlemail.com> wrote:
>
> `const_hashtab_key_t` is a typedef of `const char *`, so these casts are
> not needed.
>
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>

Acked-by: James Carter <jwcart2@gmail.com>

> ---
>  libsepol/cil/src/cil_strpool.c | 15 ++++++---------
>  1 file changed, 6 insertions(+), 9 deletions(-)
>
> diff --git a/libsepol/cil/src/cil_strpool.c b/libsepol/cil/src/cil_strpoo=
l.c
> index 70bca363..e32ee4e9 100644
> --- a/libsepol/cil/src/cil_strpool.c
> +++ b/libsepol/cil/src/cil_strpool.c
> @@ -47,14 +47,13 @@ static hashtab_t cil_strpool_tab =3D NULL;
>
>  static unsigned int cil_strpool_hash(hashtab_t h, const_hashtab_key_t ke=
y)
>  {
> -       const char *p, *keyp;
> +       const char *p;
>         size_t size;
>         unsigned int val;
>
>         val =3D 0;
> -       keyp =3D (const char*)key;
> -       size =3D strlen(keyp);
> -       for (p =3D keyp; ((size_t) (p - keyp)) < size; p++)
> +       size =3D strlen(key);
> +       for (p =3D key; ((size_t) (p - key)) < size; p++)
>                 val =3D
>                     (val << 4 | (val >> (8 * sizeof(unsigned int) - 4))) =
^ (*p);
>         return val & (h->size - 1);
> @@ -62,9 +61,7 @@ static unsigned int cil_strpool_hash(hashtab_t h, const=
_hashtab_key_t key)
>
>  static int cil_strpool_compare(hashtab_t h __attribute__ ((unused)), con=
st_hashtab_key_t key1, const_hashtab_key_t key2)
>  {
> -       const char *keyp1 =3D (const char*)key1;
> -       const char *keyp2 =3D (const char*)key2;
> -       return strcmp(keyp1, keyp2);
> +       return strcmp(key1, key2);
>  }
>
>  char *cil_strpool_add(const char *str)
> @@ -73,12 +70,12 @@ char *cil_strpool_add(const char *str)
>
>         pthread_mutex_lock(&cil_strpool_mutex);
>
> -       strpool_ref =3D hashtab_search(cil_strpool_tab, (hashtab_key_t)st=
r);
> +       strpool_ref =3D hashtab_search(cil_strpool_tab, str);
>         if (strpool_ref =3D=3D NULL) {
>                 int rc;
>                 strpool_ref =3D cil_malloc(sizeof(*strpool_ref));
>                 strpool_ref->str =3D cil_strdup(str);
> -               rc =3D hashtab_insert(cil_strpool_tab, (hashtab_key_t)str=
pool_ref->str, strpool_ref);
> +               rc =3D hashtab_insert(cil_strpool_tab, strpool_ref->str, =
strpool_ref);
>                 if (rc !=3D SEPOL_OK) {
>                         pthread_mutex_unlock(&cil_strpool_mutex);
>                         cil_log(CIL_ERR, "Failed to allocate memory\n");
> --
> 2.32.0
>
