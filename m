Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3C12C4332F
	for <selinux@archiver.kernel.org>; Mon, 21 Nov 2022 21:39:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231608AbiKUVjd (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 21 Nov 2022 16:39:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231526AbiKUVjc (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 21 Nov 2022 16:39:32 -0500
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E0A158021
        for <selinux@vger.kernel.org>; Mon, 21 Nov 2022 13:39:30 -0800 (PST)
Received: by mail-ej1-x632.google.com with SMTP id vv4so22259069ejc.2
        for <selinux@vger.kernel.org>; Mon, 21 Nov 2022 13:39:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=am1XeaA94YMjClUg3XRB83I2lUl77x9ilqSCIvtM32U=;
        b=aqdXxAW0n0FSfoe4fFnYdNGI+4VX8Gr4PE5cJi0v1BkJFwkXTE1U15JllIUnNnVtEN
         KyrjlqyyibjXFlxR3EllHluvWOrHwCH+I52RcBVTXzNDhgKCyixny2V8fTJywEJrr0Qz
         ZDmdRBR5BcBhCekA74QZ6S/V6Kak/br83mIt1jJ7skTmtDtEeCHTBCHxIwzbjzEpw8TU
         x2DIpm0ywrYxH79ORArijtmA3xbPj0pKERrHvWsiW1CP+nJNJ207KIjvkecAWH+at0gg
         F6r4Sc+THDHYxlxGz4IB4HoKavH77afPt80YaliGORpOChWrsh44awfSq60L/xBqydO6
         Z/SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=am1XeaA94YMjClUg3XRB83I2lUl77x9ilqSCIvtM32U=;
        b=8BAmOJVMVO6BxHvsmMI1RReXdASlXdFeBXYYKojFYzeHQB1swnqz5slUoJxOzCX+Ah
         qy5hs5h2fg8Qu5M5SAzMk1R5hs8FVGPYJUIHYYTegZY4Jgg8ixJDElkVXtBsrs39T4tN
         gSXWrA/s8bCN632MKRxEZjCqmQJW2g66QyOqDINLbDtp1v22KeqZ1bXXJwiBeypw7bMi
         It7k2x3WiNm6eIqu6qPquvtu7i8oRnFcV+3xTKStpn8y07W0uefzg1wKUJDo8J8xOduo
         /1wmpj5OZ4PBbYMtngnS16+SGqQKnJJmHv9prlryEOeH+QObw10eZn94649qCPtjqbvg
         MAhg==
X-Gm-Message-State: ANoB5pk2otnnuFm8JTZez1iakbz1jGV6OYhAFY3dVMU7mGoXX/f2L1+i
        LXiataHjsvV+OoPgZRwMPTcA91KP2AExjFqVnNkBI9FhrsA=
X-Google-Smtp-Source: AA0mqf7aq+pNFqGLEnzVEjQ/B6Q40s25EITgT3YS+xaHzVawJ35WHe4FWLxm+l/GRSCKYqlvfDTDXJ6Jr6x7qZ/qJIA=
X-Received: by 2002:a17:906:90c9:b0:7b2:b783:f26b with SMTP id
 v9-20020a17090690c900b007b2b783f26bmr13461780ejw.406.1669066769046; Mon, 21
 Nov 2022 13:39:29 -0800 (PST)
MIME-Version: 1.0
References: <20221109195640.60484-3-cgzones@googlemail.com> <20221114193208.9413-1-cgzones@googlemail.com>
In-Reply-To: <20221114193208.9413-1-cgzones@googlemail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Mon, 21 Nov 2022 16:39:17 -0500
Message-ID: <CAP+JOzRRSqJ9HKWHY3f+ieP4dutb6OKS8FzbVhs8ejTU3i7RAQ@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] libselinux: filter arguments with path separators
To:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Nov 14, 2022 at 2:36 PM Christian G=C3=B6ttsche
<cgzones@googlemail.com> wrote:
>
> Boolean names, taken by security_get_boolean_pending(3),
> security_get_boolean_active(3) and security_set_boolean(3), as well as
> user names, taken by security_get_initial_context(3), are used in path
> constructions.  Ensure they do not contain path separators to avoid
> unwanted path traversal.
>
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>

For this series of patches (v1 for patch 1, v2 for patch 2, and this
v3 for patch 3):
Acked-by: James Carter <jwcart2@gmail.com>

> ---
> v3:
>   - move check for translated boolean name into selinux_boolean_sub()
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
> ---
>  libselinux/src/booleans.c            | 5 +++--
>  libselinux/src/get_initial_context.c | 5 +++++
>  2 files changed, 8 insertions(+), 2 deletions(-)
>
> diff --git a/libselinux/src/booleans.c b/libselinux/src/booleans.c
> index dbcccd70..e34b39ff 100644
> --- a/libselinux/src/booleans.c
> +++ b/libselinux/src/booleans.c
> @@ -131,7 +131,8 @@ char *selinux_boolean_sub(const char *name)
>                         ptr++;
>                 *ptr =3D '\0';
>
> -               sub =3D strdup(dst);
> +               if (!strchr(dst, '/'))
> +                       sub =3D strdup(dst);
>
>                 break;
>         }
> @@ -151,7 +152,7 @@ static int bool_open(const char *name, int flag) {
>         int ret;
>         char *ptr;
>
> -       if (!name) {
> +       if (!name || strchr(name, '/')) {
>                 errno =3D EINVAL;
>                 return -1;
>         }
> diff --git a/libselinux/src/get_initial_context.c b/libselinux/src/get_in=
itial_context.c
> index 87c8adfa..0f25ba3f 100644
> --- a/libselinux/src/get_initial_context.c
> +++ b/libselinux/src/get_initial_context.c
> @@ -23,6 +23,11 @@ int security_get_initial_context_raw(const char * name=
, char ** con)
>                 return -1;
>         }
>
> +       if (strchr(name, '/')) {
> +               errno =3D EINVAL;
> +               return -1;
> +       }
> +
>         ret =3D snprintf(path, sizeof path, "%s%s%s", selinux_mnt, SELINU=
X_INITCON_DIR, name);
>         if (ret < 0 || (size_t)ret >=3D sizeof path) {
>                 errno =3D EOVERFLOW;
> --
> 2.38.1
>
