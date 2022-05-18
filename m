Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16047C433F5
	for <selinux@archiver.kernel.org>; Wed, 18 May 2022 15:23:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239203AbiERPXD (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 18 May 2022 11:23:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbiERPXC (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 18 May 2022 11:23:02 -0400
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A036C199B21
        for <selinux@vger.kernel.org>; Wed, 18 May 2022 08:23:00 -0700 (PDT)
Received: by mail-ot1-x32c.google.com with SMTP id 31-20020a9d0822000000b00605f1807664so1579674oty.3
        for <selinux@vger.kernel.org>; Wed, 18 May 2022 08:23:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=520Px9QWzr6+tY/tAD5IO2zIItAdZRi2b9wNlHayYO4=;
        b=o12eLpjQUOhHV7rFVC3vj7y6ObcMmjgXseJ55mUbWirvJfGI4EDulqKjTJz7MNRIvZ
         +R79l63AbMJXSUY/AbI8UziSHNY9eGI/tWCt4692fvg6fNIBcJD6Pia4UPj9DKQaSlIy
         7PjFA5jPW7brIVAkQr5LkLLANMnOgF9XHirXlfjnMsQkzFmJCib3WzeZVLsNZcZ9++XU
         k77gQOBzdgCdjedsT8c9gLdY6ugnYQJEwXkoP7JeIwuBkfx6RDRzhe4lJhl8N60IdvoE
         dL4PFcQbJAEVDE1mXhGjDRIukVXd125jc2dztSzoGi1+chN7pFzWnMiWIWauFEW51tLk
         jtlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=520Px9QWzr6+tY/tAD5IO2zIItAdZRi2b9wNlHayYO4=;
        b=Z0KqOKKSoyB0KrkfjpDG/Up85lqlEG0PxumuHdcumjyZn26cZam/czXNMBqza+fB2o
         z96eOMbMUcNugEdjEwcl0TrGkF0vhoOBwYETJSOd+9hZ3IbdjUHPXQlstvFXVOt/sypb
         Bq8C9Qsx3HZcjhn8p3Kk/uZZA2/LON/ivHY3smo/TEKOO40cVMT0/Ydd/5YtZEljW/Y4
         1nq7qbQGFb2y9xo7XAeFq9/IjEPz8nXUUsLHY+HRm+y9/yUT5jm1m4CuXdKBBzvj533B
         y5bNyd0XqwvplVqAnwV0498FHPd1HY6B5jopFQ57Q+5eeL4VeTsiZEDvVM61YYO9R693
         Mx1w==
X-Gm-Message-State: AOAM530oN47IUfN2TWI5+xr/FdFdElLDzjc6oLTcuppgbK4/Ml+KD8Gw
        2QhvPUPhogR7xrDtfmdn+k4OXqKh21zVvpbLjj22Tv+xz2E=
X-Google-Smtp-Source: ABdhPJz0Z65YM5KuUr8COG72SXTwNzv3pvz+DN2vzCVHjrb1NcpSYO5KZK5opoNFwJ+3QBVJRaKdiQAhkHP9m/A5EMg=
X-Received: by 2002:a9d:12f6:0:b0:606:5f8:a407 with SMTP id
 g109-20020a9d12f6000000b0060605f8a407mr68878otg.154.1652887379992; Wed, 18
 May 2022 08:22:59 -0700 (PDT)
MIME-Version: 1.0
References: <20220510182039.28771-1-cgzones@googlemail.com>
In-Reply-To: <20220510182039.28771-1-cgzones@googlemail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Wed, 18 May 2022 11:22:49 -0400
Message-ID: <CAP+JOzSVrU+bg20mkKkT_qsVAh7ciKB_xa7s9XpEHGu0Pax_vA@mail.gmail.com>
Subject: Re: [RFC PATCH 1/4] libselinux: simplify policy path logic to avoid
 uninitialized read
To:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, May 10, 2022 at 4:53 PM Christian G=C3=B6ttsche
<cgzones@googlemail.com> wrote:
>
> In case the function __policy_init() gets called with a NULL pointer,
> the stack variable path remains uninitialized (except at its last
> index).  If parsing the binary policy fails in sepol_policydb_read() the
> error branch would access those uninitialized memory.
>
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>

For the series with v2 of patch 4:
Acked-by: James Carter <jwcart2@gmail.com>

> ---
>  libselinux/src/audit2why.c | 34 +++++++++++++---------------------
>  1 file changed, 13 insertions(+), 21 deletions(-)
>
> diff --git a/libselinux/src/audit2why.c b/libselinux/src/audit2why.c
> index ca38e13c..44a9a341 100644
> --- a/libselinux/src/audit2why.c
> +++ b/libselinux/src/audit2why.c
> @@ -192,25 +192,16 @@ static PyObject *finish(PyObject *self __attribute_=
_((unused)), PyObject *args)
>  static int __policy_init(const char *init_path)
>  {
>         FILE *fp;
> -       char path[PATH_MAX];
> +       const char *curpolicy;
>         char errormsg[PATH_MAX+1024+20];
>         struct sepol_policy_file *pf =3D NULL;
>         int rc;
>         unsigned int cnt;
>
> -       path[PATH_MAX-1] =3D '\0';
>         if (init_path) {
> -               strncpy(path, init_path, PATH_MAX-1);
> -               fp =3D fopen(path, "re");
> -               if (!fp) {
> -                       snprintf(errormsg, sizeof(errormsg),
> -                                "unable to open %s:  %m\n",
> -                                path);
> -                       PyErr_SetString( PyExc_ValueError, errormsg);
> -                       return 1;
> -               }
> +               curpolicy =3D init_path;
>         } else {
> -               const char *curpolicy =3D selinux_current_policy_path();
> +               curpolicy =3D selinux_current_policy_path();
>                 if (!curpolicy) {
>                         /* SELinux disabled, must use -p option. */
>                         snprintf(errormsg, sizeof(errormsg),
> @@ -218,14 +209,15 @@ static int __policy_init(const char *init_path)
>                         PyErr_SetString( PyExc_ValueError, errormsg);
>                         return 1;
>                 }
> -               fp =3D fopen(curpolicy, "re");
> -               if (!fp) {
> -                       snprintf(errormsg, sizeof(errormsg),
> -                                "unable to open %s:  %m\n",
> -                                curpolicy);
> -                       PyErr_SetString( PyExc_ValueError, errormsg);
> -                       return 1;
> -               }
> +       }
> +
> +       fp =3D fopen(curpolicy, "re");
> +       if (!fp) {
> +               snprintf(errormsg, sizeof(errormsg),
> +                        "unable to open %s:  %m\n",
> +                        curpolicy);
> +               PyErr_SetString( PyExc_ValueError, errormsg);
> +               return 1;
>         }
>
>         avc =3D calloc(sizeof(struct avc_t), 1);
> @@ -249,7 +241,7 @@ static int __policy_init(const char *init_path)
>         sepol_policy_file_set_fp(pf, fp);
>         if (sepol_policydb_read(avc->policydb, pf)) {
>                 snprintf(errormsg, sizeof(errormsg),
> -                        "invalid binary policy %s\n", path);
> +                        "invalid binary policy %s\n", curpolicy);
>                 PyErr_SetString( PyExc_ValueError, errormsg);
>                 fclose(fp);
>                 return 1;
> --
> 2.36.1
>
