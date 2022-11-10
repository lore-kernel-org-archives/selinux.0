Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46C60C43217
	for <selinux@archiver.kernel.org>; Thu, 10 Nov 2022 21:28:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231675AbiKJV2U (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 10 Nov 2022 16:28:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231649AbiKJV2T (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 10 Nov 2022 16:28:19 -0500
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46A0EA3
        for <selinux@vger.kernel.org>; Thu, 10 Nov 2022 13:28:18 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id c1so5515273lfi.7
        for <selinux@vger.kernel.org>; Thu, 10 Nov 2022 13:28:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HuAkZGQxHyUCvzkUe80P/yXs3F194tpfCjAMJfaLv94=;
        b=GX/IMXwvfdiNw39PmgA8YDDZx67zwXUf7xG78wBWjc9jT3JKAVFd6wWhMMkN/LwSF+
         dvnwjnjhqPxSr6UxCa8Z2mdROVUSqcjPOGi4/EAzTyyTFAJkhQGBSccMdCibMVLJtD14
         fep1WGryXMSGDKOsH2yhUTEtLNyVfI06eoLCXseSXmJwjbD71pGYPOR//yqoQySr273U
         Zz80lmQlPabh+uy7zMpPwisVMMPdLsMzD+QR65UixKDYo0NwekmD22TQpRcQCQIGrYtp
         YZdsngW5WbNr11CG1/jV1EOe7gJV8Whqqd8ulrrQX4GnP6Gzwz8s/6nckE8wLN/fW+/m
         nL+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HuAkZGQxHyUCvzkUe80P/yXs3F194tpfCjAMJfaLv94=;
        b=5hJm2D7nO53i9HCDaWzBbNran/UgCFS/dbdxgkUhIsnMPZW7xUtbeYxAxh2UIpXF7x
         H/UPOUfYLwd5vRPtIPJ/s6whW1dlZ8bEccRIZ0Xi9iyw3i0tckzu1SYstmxjPNUTrNKf
         b9ObW1BQsEnpoYpdBxh1RnNtaNCF8X27ia1hSpPyIODsXAESqqlsjZFtdXMuWsJtF0Oo
         bTIe+M55vZpFcFV7m986nZdfTzcWpthcRJl+lLzDkB2hF3ON+0EGnJFR82yE8iJZYNEn
         Iy0r4Sb6kpKFwRKEoMb0C2KIw4mQGVhKXLQy2Nk6vOJ1VrnMulQRXQXYRSyYJrbcyMyV
         2fTQ==
X-Gm-Message-State: ACrzQf1rtP8fMhQb9Q5U29sNrwU/QzLcLO2mTpTF09tqa5HqG+/9EFr8
        n+xykfnbpDDrUYwYGz4sqt5t2Hco7R2THKaac/4Ij2XfQuA=
X-Google-Smtp-Source: AMsMyM7aoiSbuOJiNNd0CvPyBH05+W5RcUeHFXjEiYNLX3R3iRnxzKd5Vi+w6EWqh3+OGTud3BAHUwdlO3SDJG82NGU=
X-Received: by 2002:a19:8c57:0:b0:4ae:2436:818c with SMTP id
 i23-20020a198c57000000b004ae2436818cmr1793608lfj.346.1668115696481; Thu, 10
 Nov 2022 13:28:16 -0800 (PST)
MIME-Version: 1.0
References: <20221109195640.60484-1-cgzones@googlemail.com> <20221109195640.60484-3-cgzones@googlemail.com>
In-Reply-To: <20221109195640.60484-3-cgzones@googlemail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Thu, 10 Nov 2022 16:28:04 -0500
Message-ID: <CAP+JOzT7PXi4z4+zcSzfAbhJJaYoDYiBGDFkyM9z5SjA+omXLA@mail.gmail.com>
Subject: Re: [PATCH 3/3] libselinux: filter arguments with path separators
To:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Nov 9, 2022 at 3:07 PM Christian G=C3=B6ttsche
<cgzones@googlemail.com> wrote:
>
> Boolean names, taken by security_get_boolean_pending(3),
> security_get_boolean_active(3) and security_set_boolean(3), as well as
> user names, taken by security_get_initial_context(3), are used in path
> constructions.  Ensure they do not contain path separators to avoid
> unwanted path traversal.
>
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
> ---
>  libselinux/src/booleans.c            | 7 ++++++-
>  libselinux/src/get_initial_context.c | 5 +++++
>  2 files changed, 11 insertions(+), 1 deletion(-)
>
> diff --git a/libselinux/src/booleans.c b/libselinux/src/booleans.c
> index 66c946f9..64248191 100644
> --- a/libselinux/src/booleans.c
> +++ b/libselinux/src/booleans.c
> @@ -152,7 +152,7 @@ static int bool_open(const char *name, int flag) {
>         int ret;
>         char *ptr;
>
> -       if (!name) {
> +       if (!name || strchr(name, '/')) {
>                 errno =3D EINVAL;
>                 return -1;
>         }
> @@ -176,6 +176,11 @@ static int bool_open(const char *name, int flag) {
>         if (!alt_name)
>                 goto out;
>
> +       if (strchr(alt_name, '/')) {
> +               errno =3D EINVAL;
> +               goto out;
> +       }
> +

I don't think that this check is needed. You have already checked name
by this point and it is reading booleans.subs_dist which is in the
/etc/selinux directory.
Besides, if it was going to be checked, it should be in the
selinux_boolean_sub() function.

Thanks,
Jim


>         /* note the 'sizeof' gets us enough room for the '\0' */
>         len =3D strlen(alt_name) + strlen(selinux_mnt) + sizeof(SELINUX_B=
OOL_DIR);
>         ptr =3D realloc(fname, len);
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
