Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1946EC433F5
	for <selinux@archiver.kernel.org>; Thu, 12 May 2022 15:34:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354821AbiELPeT (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 12 May 2022 11:34:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355308AbiELPeS (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 12 May 2022 11:34:18 -0400
Received: from mail-oa1-x2a.google.com (mail-oa1-x2a.google.com [IPv6:2001:4860:4864:20::2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B69F12415C7
        for <selinux@vger.kernel.org>; Thu, 12 May 2022 08:34:17 -0700 (PDT)
Received: by mail-oa1-x2a.google.com with SMTP id 586e51a60fabf-d6e29fb3d7so7061711fac.7
        for <selinux@vger.kernel.org>; Thu, 12 May 2022 08:34:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ODvOCMqXkEzNuuREfE9T6xXNl3fxN/k1vcuo7LDTDlc=;
        b=DAPXN5JaK/02RZ19T+VEatGCJ4RgANGoZSwkNwiOXpvSTDvPtoissIgnNGiTU0xtTK
         ONR1B7oNoCT5w0DuY0wDMoLa22iJeRTyVqyyHdKSWqalXQ58JhLd6Kar2sCZTEwTvoi+
         Syt5TRNRMurMlnxtHv5alkXFfE3VKp9IwwXxAamBs7TgPM+54pDG8keazub4jI4SYO+u
         xmf90ax/E28hnnImM/UiyOrwlMwyfoqB8MGpxx49sho6wYfwVIje3LE280Ycj/QkDzAA
         ugzdOnF2W6Qkpx6vSoTqU6k/CH6WDJDnQnccEJc+PuIgP5nC7WJiTwxRBgt+aFSaSmu7
         eV8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ODvOCMqXkEzNuuREfE9T6xXNl3fxN/k1vcuo7LDTDlc=;
        b=lgSbplcra69uOA+Wg36SViBeAAmJTCWXCWeCcv8j5J9Jz4raL7vkCLRxuJ1zm/wXvK
         HiTv/+1h+1LIra8+FvzPJOhkhG/0MjKYZRAiYE2liCnzjWIeEmEjK9FZftSgPDwXopUQ
         KRd2UnQTk3uOAnV/Pt9fLhKwvHyObBa5zq7h9RaKW3IfoLFT3fLibyu+g7yyWv/PnyfY
         kN4En9IVmjMcDFxzATHddQdJIxCJ9eYfJMZ1K/u7ioJjl+fgkDqUTX3e8BavjXnaoIIj
         1qHslvf6U1mcnxXoOURcYl0kQXFfRjTwjy2hFT4e9Zr79P8W1kSJUAvWcQP7877x+uPC
         g3dQ==
X-Gm-Message-State: AOAM532sVIAvRmrX8spEw+0TSoFWadyZYiqgsxeb4xFVuY/w3LOGGGxJ
        019sAtGxXXFPMiA0dA6hrfE1ktz1Pwf9VJCPpOjGc7WZkrk=
X-Google-Smtp-Source: ABdhPJyPckRl5oXak4RIYgbwCuFUPyvoGukeCIr+xvTYt4PG61b9ya6i+X4dwt+dmwY4dPTg4wy5691ip7eqNn5SOjo=
X-Received: by 2002:a05:6870:d68e:b0:e2:861:8b15 with SMTP id
 z14-20020a056870d68e00b000e208618b15mr5984838oap.156.1652369656966; Thu, 12
 May 2022 08:34:16 -0700 (PDT)
MIME-Version: 1.0
References: <20220510182039.28771-1-cgzones@googlemail.com> <20220510182039.28771-4-cgzones@googlemail.com>
In-Reply-To: <20220510182039.28771-4-cgzones@googlemail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Thu, 12 May 2022 11:34:06 -0400
Message-ID: <CAP+JOzRUWcNepZ4RRpeJNoRTezZbJ0q3k0p=SbNxE65Gbp60+A@mail.gmail.com>
Subject: Re: [RFC PATCH 4/4] libselinux: check for truncations
To:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, May 10, 2022 at 5:36 PM Christian G=C3=B6ttsche
<cgzones@googlemail.com> wrote:
>
> Check for truncations when building or copying strings involving user
> input.
>
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
> ---
>  libselinux/src/canonicalize_context.c |  6 +++++-
>  libselinux/src/compute_av.c           |  7 ++++++-
>  libselinux/src/compute_create.c       |  6 ++++++
>  libselinux/src/compute_member.c       |  7 ++++++-
>  libselinux/src/compute_relabel.c      |  7 ++++++-
>  libselinux/src/compute_user.c         |  7 ++++++-
>  libselinux/src/selinux_restorecon.c   | 11 ++++++++++-
>  libselinux/src/setrans_client.c       |  8 +++++++-
>  8 files changed, 52 insertions(+), 7 deletions(-)
>
> diff --git a/libselinux/src/canonicalize_context.c b/libselinux/src/canon=
icalize_context.c
> index faab7305..8a22a4cd 100644
> --- a/libselinux/src/canonicalize_context.c
> +++ b/libselinux/src/canonicalize_context.c
> @@ -33,7 +33,11 @@ int security_canonicalize_context_raw(const char * con=
,
>                 ret =3D -1;
>                 goto out;
>         }
> -       strncpy(buf, con, size);
> +       if (strlcpy(buf, con, size) >=3D size) {
> +               errno =3D EOVERFLOW;
> +               ret =3D -1;
> +               goto out;
> +       }
>
>         ret =3D write(fd, buf, strlen(buf) + 1);
>         if (ret < 0)
> diff --git a/libselinux/src/compute_av.c b/libselinux/src/compute_av.c
> index 9d17339d..e513be6a 100644
> --- a/libselinux/src/compute_av.c
> +++ b/libselinux/src/compute_av.c
> @@ -40,8 +40,13 @@ int security_compute_av_flags_raw(const char * scon,
>         }
>
>         kclass =3D unmap_class(tclass);
> -       snprintf(buf, len, "%s %s %hu %x", scon, tcon,
> +
> +       ret =3D snprintf(buf, len, "%s %s %hu %x", scon, tcon,
>                  kclass, unmap_perm(tclass, requested));
> +       if (ret < 0 || ret >=3D len) {

error: comparison of integer expressions of different signedness:
=E2=80=98int=E2=80=99 and =E2=80=98size_t=E2=80=99

> +               errno =3D EOVERFLOW;
> +               goto out2;
> +       }
>
>         ret =3D write(fd, buf, strlen(buf));
>         if (ret < 0)
> diff --git a/libselinux/src/compute_create.c b/libselinux/src/compute_cre=
ate.c
> index 1d75714d..4cba2d2f 100644
> --- a/libselinux/src/compute_create.c
> +++ b/libselinux/src/compute_create.c
> @@ -75,8 +75,14 @@ int security_compute_create_name_raw(const char * scon=
,
>                 ret =3D -1;
>                 goto out;
>         }
> +
>         len =3D snprintf(buf, size, "%s %s %hu",
>                        scon, tcon, unmap_class(tclass));
> +       if (len < 0 || len >=3D size) {

error: comparison of integer expressions of different signedness:
=E2=80=98int=E2=80=99 and =E2=80=98size_t=E2=80=99

> +               errno =3D EOVERFLOW;

You need ret =3D -1 here.

> +               goto out2;
> +       }
> +
>         if (objname &&
>             object_name_encode(objname, buf + len, size - len) < 0) {
>                 errno =3D ENAMETOOLONG;
> diff --git a/libselinux/src/compute_member.c b/libselinux/src/compute_mem=
ber.c
> index 16234b79..82d76080 100644
> --- a/libselinux/src/compute_member.c
> +++ b/libselinux/src/compute_member.c
> @@ -36,7 +36,12 @@ int security_compute_member_raw(const char * scon,
>                 ret =3D -1;
>                 goto out;
>         }
> -       snprintf(buf, size, "%s %s %hu", scon, tcon, unmap_class(tclass))=
;
> +
> +       ret =3D snprintf(buf, size, "%s %s %hu", scon, tcon, unmap_class(=
tclass));
> +       if (ret < 0 || ret >=3D size) {

error: comparison of integer expressions of different signedness:
=E2=80=98int=E2=80=99 and =E2=80=98size_t=E2=80=99

> +               errno =3D EOVERFLOW;
> +               goto out2;
> +       }
>
>         ret =3D write(fd, buf, strlen(buf));
>         if (ret < 0)
> diff --git a/libselinux/src/compute_relabel.c b/libselinux/src/compute_re=
label.c
> index dd20d652..96259bac 100644
> --- a/libselinux/src/compute_relabel.c
> +++ b/libselinux/src/compute_relabel.c
> @@ -36,7 +36,12 @@ int security_compute_relabel_raw(const char * scon,
>                 ret =3D -1;
>                 goto out;
>         }
> -       snprintf(buf, size, "%s %s %hu", scon, tcon, unmap_class(tclass))=
;
> +
> +       ret =3D snprintf(buf, size, "%s %s %hu", scon, tcon, unmap_class(=
tclass));
> +       if (ret < 0 || ret >=3D size) {

error: comparison of integer expressions of different signedness:
=E2=80=98int=E2=80=99 and =E2=80=98size_t=E2=80=99

> +               errno =3D EOVERFLOW;
> +               goto out2;
> +       }
>
>         ret =3D write(fd, buf, strlen(buf));
>         if (ret < 0)
> diff --git a/libselinux/src/compute_user.c b/libselinux/src/compute_user.=
c
> index ae5e7b4a..23a551e4 100644
> --- a/libselinux/src/compute_user.c
> +++ b/libselinux/src/compute_user.c
> @@ -38,7 +38,12 @@ int security_compute_user_raw(const char * scon,
>                 ret =3D -1;
>                 goto out;
>         }
> -       snprintf(buf, size, "%s %s", scon, user);
> +
> +       ret =3D snprintf(buf, size, "%s %s", scon, user);
> +       if (ret < 0 || ret >=3D size) {

error: comparison of integer expressions of different signedness:
=E2=80=98int=E2=80=99 and =E2=80=98size_t=E2=80=99

Everything else looks fine.

Thanks,
Jim

> +               errno =3D EOVERFLOW;
> +               goto out2;
> +       }
>
>         ret =3D write(fd, buf, strlen(buf));
>         if (ret < 0)
> diff --git a/libselinux/src/selinux_restorecon.c b/libselinux/src/selinux=
_restorecon.c
> index e6192912..7436dab5 100644
> --- a/libselinux/src/selinux_restorecon.c
> +++ b/libselinux/src/selinux_restorecon.c
> @@ -940,7 +940,16 @@ loop_body:
>                         }
>                         /* fall through */
>                 default:
> -                       strcpy(ent_path, ftsent->fts_path);
> +                       if (strlcpy(ent_path, ftsent->fts_path, sizeof(en=
t_path)) >=3D sizeof(ent_path)) {
> +                               selinux_log(SELINUX_ERROR,
> +                                           "Path name too long on %s.\n"=
,
> +                                           ftsent->fts_path);
> +                               errno =3D ENAMETOOLONG;
> +                               state->error =3D -1;
> +                               state->abort =3D true;
> +                               goto finish;
> +                       }
> +
>                         ent_st =3D *ftsent->fts_statp;
>                         if (state->parallel)
>                                 pthread_mutex_unlock(&state->mutex);
> diff --git a/libselinux/src/setrans_client.c b/libselinux/src/setrans_cli=
ent.c
> index faa12681..920f9032 100644
> --- a/libselinux/src/setrans_client.c
> +++ b/libselinux/src/setrans_client.c
> @@ -66,7 +66,13 @@ static int setransd_open(void)
>
>         memset(&addr, 0, sizeof(addr));
>         addr.sun_family =3D AF_UNIX;
> -       strncpy(addr.sun_path, SETRANS_UNIX_SOCKET, sizeof(addr.sun_path)=
);
> +
> +       if (strlcpy(addr.sun_path, SETRANS_UNIX_SOCKET, sizeof(addr.sun_p=
ath)) >=3D sizeof(addr.sun_path)) {
> +               close(fd);
> +               errno =3D EOVERFLOW;
> +               return -1;
> +       }
> +
>         if (connect(fd, (struct sockaddr *)&addr, sizeof(addr)) < 0) {
>                 close(fd);
>                 return -1;
> --
> 2.36.1
>
