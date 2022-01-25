Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A05F9C433F5
	for <selinux@archiver.kernel.org>; Tue, 25 Jan 2022 21:17:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232103AbiAYVRU (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 25 Jan 2022 16:17:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232080AbiAYVRT (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 25 Jan 2022 16:17:19 -0500
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB35CC06173B
        for <selinux@vger.kernel.org>; Tue, 25 Jan 2022 13:17:18 -0800 (PST)
Received: by mail-oi1-x229.google.com with SMTP id g205so33626746oif.5
        for <selinux@vger.kernel.org>; Tue, 25 Jan 2022 13:17:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=U4WlkCcPdYNINo0yx8o7VaUC+5rR3gh4H94/GZEwAMQ=;
        b=goYc7vuHEtwRp+R5ID3bUge+PJyPVAfKPnjRUMNG8ILVDMVMIrRqCjr8/GTC149et9
         h6O++k4L5/MFJRjnAoBha4gAB34R2cAF8GfS+uNH9Le0Q0TtpFAbmt1Pl+WUKykByYdJ
         /q+d+LY7MsjmZW4LUvuj0KA2O5qUdkdx3Fki9UQQiZlQkmAIrInquGyxqJN5FUwpTcK4
         EgQZ5eSZQ0AnIenVcMqmvVViXdoE4yEtF7ZuvOd/3gFaAPglsNK3lXly8Vot2ICcjKP6
         vQcgm0+EyR64la+3YXX1jEZK/AOVk6KYnh4y5OtrTEfwsyPEoi5eqck8b6PyVVdRaBp8
         vgnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=U4WlkCcPdYNINo0yx8o7VaUC+5rR3gh4H94/GZEwAMQ=;
        b=zDgA03wrp50wg4qleRK8MpADMW1YXgiq6xXtbuE1pTwzUJ9iHrVcbaSWS77Zb4OBPs
         S1u3O1wNqDCWigd8cvuBsdY8WfR+GjVaeMkSLz8o/xhxJUmxmND4anTznB2Dd7Oho4vI
         XDcfSLQ4va3ENjTY6WlAbpPxzg0usSX1eXcE80YhGs9Z5j76R/AuuXgiIAZVu2bBwc8M
         joVb2c7ymy9ez7gWOkJ0Uqu6YM5xPYF1Ql4EGYPddOOtkE/BmHgXpLwW8T2aZSfMnq7h
         m4o7tN0C7X4DizCwluHe4LGaIQQDaiStm/yzuGkqjtjJyWlxP9ZB4sRL/3k5T2rE225S
         O/9w==
X-Gm-Message-State: AOAM531fpZoPDUyZA4Oq6IbKWkIdKj5vOqV4G31eG3gT+iQ1zQCdcTHI
        hhc/XAOXSU02Shheuc6YrlB/c/cq3f2hNU2pQtcCXIWmrfY=
X-Google-Smtp-Source: ABdhPJwvlQ8XICvH7YIkfgbkulsu2hwMiIZ7Az6wXEeQYA/0THiRNqvcbawF+/iX554oFoZPXPpoTPYxI6SZ2PNYBqk=
X-Received: by 2002:a05:6808:1147:: with SMTP id u7mr1777495oiu.189.1643145438101;
 Tue, 25 Jan 2022 13:17:18 -0800 (PST)
MIME-Version: 1.0
References: <20220125135022.25513-1-cgzones@googlemail.com>
In-Reply-To: <20220125135022.25513-1-cgzones@googlemail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Tue, 25 Jan 2022 16:17:07 -0500
Message-ID: <CAP+JOzRoFHqKKVSvgFirT+hscVfZtejRKkxPdPBbAjz1nKTYGw@mail.gmail.com>
Subject: Re: [PATCH] libsepol: invert only valid range of role bitmap
To:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Jan 25, 2022 at 2:46 PM Christian G=C3=B6ttsche
<cgzones@googlemail.com> wrote:
>
> The length of an ebitmap is the current highest allocated (not set) bit
> and always a multiple of MAPTYPE (=3D 64). The role ebitmap should only
> have valid role bits set, even after inverting. The length might be
> smaller than the maximum number of defined roles leading to non defined
> role bits set afterwards.
> Only invert up to the number of roles defined instead the full ebitmap
> length, similar to type_set_expand().
>
> This also avoids timeouts on an invalid huge highbit set, since the
> ebitmap has not been validated yet, on which inverting will take
> excessive amount of memory and time, found by oss-fuzz (#43709).
>
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>

Acked-by: James Carter <jwcart2@gmail.com>

> ---
> This patch supersedes "libsepol: reject invalid roles before inverting"
> https://patchwork.kernel.org/project/selinux/patch/20220117150200.24953-1=
-cgzones@googlemail.com/
> ---
>  libsepol/src/expand.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/libsepol/src/expand.c b/libsepol/src/expand.c
> index 898e6b87..df8683ef 100644
> --- a/libsepol/src/expand.c
> +++ b/libsepol/src/expand.c
> @@ -2481,7 +2481,7 @@ int role_set_expand(role_set_t * x, ebitmap_t * r, =
policydb_t * out, policydb_t
>
>         /* if role is to be complimented, invert the entire bitmap here *=
/
>         if (x->flags & ROLE_COMP) {
> -               for (i =3D 0; i < ebitmap_length(r); i++) {
> +               for (i =3D 0; i < p->p_roles.nprim; i++) {
>                         if (ebitmap_get_bit(r, i)) {
>                                 if (ebitmap_set_bit(r, i, 0))
>                                         return -1;
> --
> 2.34.1
>
