Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EF33C4167B
	for <selinux@archiver.kernel.org>; Thu,  2 Nov 2023 15:43:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229560AbjKBPnF (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 2 Nov 2023 11:43:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230024AbjKBPnE (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 2 Nov 2023 11:43:04 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85888187
        for <selinux@vger.kernel.org>; Thu,  2 Nov 2023 08:42:59 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id 2adb3069b0e04-507a3b8b113so1301588e87.0
        for <selinux@vger.kernel.org>; Thu, 02 Nov 2023 08:42:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698939778; x=1699544578; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GslWrczAtSluYU0uuXveV38HSR9nMTzWOHmv5I6GwzY=;
        b=XkqTglhbvahBegDH4mNEh7++kM4d4VLnZ9DA/sLh7JYzHHgxrz4aNe7x7RSXVICAwN
         Ts+9tHNq9QzZzbhqGde62At2dW04aKROp3BTJT0+J1oAsERyQByNgw+4ZCirb0Ed33Hs
         o0M3PSXOSpOGuU4nCpBfUBRQ7uTAfg+SfDHjljfarwcoLLcrjtQVTS+DV31ifBUg0mLm
         aW0Dlx/ENo3U6fq0pL0dJVNumkQOgUcCsPwWTEp/fGUj6wlVgNbh6k+2pnVazIsrmu8Y
         f7ALWqQDyZe30YEwxgE4CqVIZqVM/tzFAxrBp9tuTisinW59Z8oENOV+cxOb47G0B2cT
         yPpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698939778; x=1699544578;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GslWrczAtSluYU0uuXveV38HSR9nMTzWOHmv5I6GwzY=;
        b=nqTidSt9HUs1Kk4ivqbjxyEr6x0CyrYiI9ZEVwpb7UTRf4eA820/gEkRh/gk1EnlXt
         8DuSA2JI/GVBqcylVpicnulxDRI5/QCYxVbL8uRuMWQeFaQ/KWB0g+prq48ARoS1w0yB
         jRrQIzzm0S3/3TThB5ToQGZhpZIc3HMMwdRp7WgP6wKQLN5qvdUSOwh/aP8hNhbiTDNR
         V2uhusTvkpN1QuitCfFkXg8kzYTBP66c+1M4nG7PK8khqNT9tJjjwat/WntILJnKdpOe
         hGB3D28OPO/1fg0BZkQJ8KZ9QGL+NmGH/v4eClIRUcNkj7EOM7+whXyL7oLCSXfNmQwk
         bZMw==
X-Gm-Message-State: AOJu0YxAriaZ72TEQ6llExkZOl8Vo9I5xADmwPQhsVf3cwbQanN3oX5K
        miBI6cXVPxfumQB4XZWat67gata3PahutMoc7PJCR0iYPpg=
X-Google-Smtp-Source: AGHT+IFdFPXaBAdCyjt/CHl16T2CDg6y9nyBLwFF0dMh+JFvPkNLKvk4s4Y3Jc1HqbIYzGHsNqxEmiHLg0TsH+abI3w=
X-Received: by 2002:ac2:5182:0:b0:503:36cb:5436 with SMTP id
 u2-20020ac25182000000b0050336cb5436mr13645324lfi.9.1698939777324; Thu, 02 Nov
 2023 08:42:57 -0700 (PDT)
MIME-Version: 1.0
References: <20231101163754.177452-1-cgzones@googlemail.com>
In-Reply-To: <20231101163754.177452-1-cgzones@googlemail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Thu, 2 Nov 2023 11:42:45 -0400
Message-ID: <CAP+JOzSGwx3f4MrtnXtMWwr8AcG46RpQG3qW-A0bMVBPYapEfw@mail.gmail.com>
Subject: Re: [PATCH] libselinux/utils: update getdefaultcon
To:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Nov 1, 2023 at 12:38=E2=80=AFPM Christian G=C3=B6ttsche
<cgzones@googlemail.com> wrote:
>
> * mention -r <role> and -v command line options in usage string
> * use distinct error messages on getseuser(3) and
>   get_default_context_with_[role]level(3) failure
> * always print program name on error
> * drop unnecessary double parenthesis
>
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>

Acked-by: James Carter <jwcart2@gmail.com>

> ---
>  libselinux/utils/getdefaultcon.c | 40 ++++++++++++++++++--------------
>  1 file changed, 23 insertions(+), 17 deletions(-)
>
> diff --git a/libselinux/utils/getdefaultcon.c b/libselinux/utils/getdefau=
ltcon.c
> index 93102e5e..50f1ea91 100644
> --- a/libselinux/utils/getdefaultcon.c
> +++ b/libselinux/utils/getdefaultcon.c
> @@ -11,7 +11,7 @@
>
>  static __attribute__ ((__noreturn__)) void usage(const char *name, const=
 char *detail, int rc)
>  {
> -       fprintf(stderr, "usage:  %s [-l level] [-s service] user [fromcon=
]\n", name);
> +       fprintf(stderr, "usage:  %s [-r role] [-l level] [-s service] [-v=
] user [fromcon]\n", name);
>         if (detail)
>                 fprintf(stderr, "%s:  %s\n", name, detail);
>         exit(rc);
> @@ -60,9 +60,9 @@ int main(int argc, char **argv)
>         user =3D argv[optind];
>
>         /* If a context wasn't passed, use the current context. */
> -       if (((argc - optind) < 2)) {
> +       if ((argc - optind) < 2) {
>                 if (getcon(&cur_context) < 0) {
> -                       fprintf(stderr, "Couldn't get current context:  %=
s\n", strerror(errno));
> +                       fprintf(stderr, "%s:  couldn't get current contex=
t:  %s\n", argv[0], strerror(errno));
>                         return 2;
>                 }
>         } else
> @@ -73,23 +73,29 @@ int main(int argc, char **argv)
>                 return 3;
>         }
>
> -       if ((ret =3D getseuser(user, service, &seuser, &dlevel)) =3D=3D 0=
) {
> -               if (! level) level=3Ddlevel;
> -               if (role !=3D NULL && role[0])
> -                       ret=3Dget_default_context_with_rolelevel(seuser, =
role, level,cur_context,&usercon);
> -               else
> -                       ret=3Dget_default_context_with_level(seuser, leve=
l, cur_context,&usercon);
> +       ret =3D getseuser(user, service, &seuser, &dlevel);
> +       if (ret) {
> +               fprintf(stderr, "%s:  failed to get seuser:  %s\n", argv[=
0], strerror(errno));
> +               goto out;
>         }
> -       if (ret < 0)
> -               perror(argv[0]);
> -       else {
> -               if (verbose) {
> -                       printf("%s: %s from %s %s %s %s -> %s\n", argv[0]=
, user, cur_context, seuser, role, level, usercon);
> -               } else {
> -                       printf("%s\n", usercon);
> -               }
> +
> +       if (! level) level=3Ddlevel;
> +       if (role !=3D NULL && role[0])
> +               ret =3D get_default_context_with_rolelevel(seuser, role, =
level, cur_context, &usercon);
> +       else
> +               ret =3D get_default_context_with_level(seuser, level, cur=
_context, &usercon);
> +       if (ret) {
> +               fprintf(stderr, "%s:  failed to get default context:  %s\=
n", argv[0], strerror(errno));
> +               goto out;
> +       }
> +
> +       if (verbose) {
> +               printf("%s: %s from %s %s %s %s -> %s\n", argv[0], user, =
cur_context, seuser, role, level, usercon);
> +       } else {
> +               printf("%s\n", usercon);
>         }
>
> +out:
>         free(role);
>         free(seuser);
>         if (level !=3D dlevel) free(level);
> --
> 2.42.0
>
