Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A63CC433EF
	for <selinux@archiver.kernel.org>; Thu, 12 May 2022 17:39:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357126AbiELRjX (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 12 May 2022 13:39:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355439AbiELRjV (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 12 May 2022 13:39:21 -0400
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EDF65EBE0
        for <selinux@vger.kernel.org>; Thu, 12 May 2022 10:39:21 -0700 (PDT)
Received: by mail-oi1-x233.google.com with SMTP id w123so7290862oiw.5
        for <selinux@vger.kernel.org>; Thu, 12 May 2022 10:39:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=j4vqHnYhz1uqgWgBkI4R6EL6JwV8uIcceKi4abN28Tk=;
        b=UXhcAR2A1FGIxMv0GffdN+doY+5+QITDDImrqCLicWwiECMQHKtXvCtn25RJzmU6+N
         /ZRKWkmD3MMMJEpVZzl2SUFRHaFbhmZ/iIH1VxU8//uXeBTDd35rXOzAKG8DJ8vczALN
         uiHZiQpWH1SOE+YpgYm1WWxl7zNi5sVI3qleeFMgRGu2AXjWfU1nhKve8UP4YJMFZS+o
         fqubOazsClc7t6htgCBwSR82gXRylCph9zZiFb4oHHn13RWtasXW13eZc2aj7Z5hfB4e
         qLvZH333U97EVwQ55VARMrDwF1tghG+aWdThFG5sZE5LfcfM7c0XrnpaxW6jX+nsa8cx
         I2ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=j4vqHnYhz1uqgWgBkI4R6EL6JwV8uIcceKi4abN28Tk=;
        b=l2ZIl+RV0nXMhIIrNyptaEzgT8YGV+asDgzMEeGOEmEyted4XMesbFgLwMK2ICGBId
         uQQblDAKNx9mVDf+R0yVwGUQNOIg5t+kS/TaxrehnfeERv62LCKZZdM6fPLohBpYIAFr
         5INQ45WLn3TkIoaA2l83xJBbmLsn7DvaPYoAtrPytQFQ9WimsPJOQ/fc2Hg3xspFn8MG
         It+kMPDryTAdUQQkaC4QVCyIlP+6+ZffxCYV1goN10ZXEDf7u4VSO1BVYijW8ELfD3Gi
         OBDmHHMoZi3Vs4VYKsixItjLON7d1XwzteThmNjFTfkpqfo2yvlgLpkNPllXH6CUuNGw
         iXdQ==
X-Gm-Message-State: AOAM530xMTinHareXDXBX6kUlNiQ8vZaVtxigcrRZ/wdJ9GzFZwcqcK/
        DcAKBzML05DvRxh3ZswFB8i9kFdZBw+tbReDh0U3wi16Tz8=
X-Google-Smtp-Source: ABdhPJwXDb3z5PJ3e9EjGM/2JwYM7JTnJBcdYDLwjkTjqeYbKvPM9/cRDINJDfshIzhdPv+s8ps6kOSrO5L4qh4cHZw=
X-Received: by 2002:a05:6808:2082:b0:326:9857:840b with SMTP id
 s2-20020a056808208200b003269857840bmr520264oiw.182.1652377160502; Thu, 12 May
 2022 10:39:20 -0700 (PDT)
MIME-Version: 1.0
References: <20220505174420.24537-1-cgzones@googlemail.com>
 <20220511184225.218062-1-cgzones@googlemail.com> <20220511184225.218062-2-cgzones@googlemail.com>
In-Reply-To: <20220511184225.218062-2-cgzones@googlemail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Thu, 12 May 2022 13:39:09 -0400
Message-ID: <CAP+JOzQOhjPs+dUmAd0S3JXd4LPn67WNkSddLMc-Z9tZ8cECPw@mail.gmail.com>
Subject: Re: [RFC PATCH 3/4] libselinux: restorecon: forward error if not ENOENT
To:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, May 12, 2022 at 5:54 AM Christian G=C3=B6ttsche
<cgzones@googlemail.com> wrote:
>
> selabel_lookup_raw(3) can fail for other reasons than no corresponding
> context found, e.g. ENOMEM or EINVAL for invalid key or type.
>
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>

Acked-by: James Carter <jwcart2@gmail.com>

> ---
>  libselinux/src/selinux_restorecon.c | 14 +++++++++-----
>  1 file changed, 9 insertions(+), 5 deletions(-)
>
> diff --git a/libselinux/src/selinux_restorecon.c b/libselinux/src/selinux=
_restorecon.c
> index c158ead8..42ef30cb 100644
> --- a/libselinux/src/selinux_restorecon.c
> +++ b/libselinux/src/selinux_restorecon.c
> @@ -651,12 +651,16 @@ static int restorecon_sb(const char *pathname, cons=
t struct stat *sb,
>                                                     sb->st_mode);
>
>         if (rc < 0) {
> -               if (errno =3D=3D ENOENT && flags->warnonnomatch && first)
> -                       selinux_log(SELINUX_INFO,
> -                                   "Warning no default label for %s\n",
> -                                   lookup_path);
> +               if (errno =3D=3D ENOENT) {
> +                       if (flags->warnonnomatch && first)
> +                               selinux_log(SELINUX_INFO,
> +                                           "Warning no default label for=
 %s\n",
> +                                           lookup_path);
>
> -               return 0; /* no match, but not an error */
> +                       return 0; /* no match, but not an error */
> +               }
> +
> +               return -1;
>         }
>
>         if (flags->progress) {
> --
> 2.36.1
>
