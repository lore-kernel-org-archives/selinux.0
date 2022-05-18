Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C595FC433F5
	for <selinux@archiver.kernel.org>; Wed, 18 May 2022 13:57:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238339AbiERN5O (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 18 May 2022 09:57:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238164AbiERN5O (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 18 May 2022 09:57:14 -0400
Received: from mail-oa1-x2d.google.com (mail-oa1-x2d.google.com [IPv6:2001:4860:4864:20::2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A128937A2F
        for <selinux@vger.kernel.org>; Wed, 18 May 2022 06:57:12 -0700 (PDT)
Received: by mail-oa1-x2d.google.com with SMTP id 586e51a60fabf-d39f741ba0so2689059fac.13
        for <selinux@vger.kernel.org>; Wed, 18 May 2022 06:57:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=9z9Gw4Xhj2ugmWM1/xEKtRdv/KWAbAWXDkuk+e2dYfw=;
        b=dv6dXr1zpZJdzuBVBze7ETNITwhm4a1C1rbLWNF0KcCrkOe0eb4P5nAOj/5kYxhMkD
         MChTxvaBdNhcOMvZYL89P9nUnoNhDlsivknK034G5mOCZxnBpFCyxpTOjtc/tQidVMGP
         VOnGNQXKRdzNQ+hQY0ZHxZccEDzDqSJSq1Htwl0YPo6hd/nGZI/U0W2B22ADfhd54k/H
         JukDoisE+ties+k8cy0OAd5GJX0AUWDeWOs5xVVvVKkTSMpJWTUJGKc4SfvOwRIpa5fO
         L0sevpe8adpi5ozPX8mMIDEZ3xnva3vPrjHDn47zP78uPma3JfyF6ytU1N1EoO4jN0gj
         E6IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=9z9Gw4Xhj2ugmWM1/xEKtRdv/KWAbAWXDkuk+e2dYfw=;
        b=BfjX5Cp/znYYhNAkOtDMIHSdqQLc/LGtultFMLMSIMG4+/YHQinwFkVAHG20hDQy0z
         mV0lRZFKGnDFYHhOLqtDe1EWJrqdXp3PfebwspPOBdCVrAvQ9Rx62Ohe9c9upc6iDp2/
         yQhQAh+MREWaWhfedt5Tpk6VkBJwMDEz5PdH3V6jR7A5vwAhPUvsH4UOWHSdidUl2pXB
         +SbkYKzXiW2br4Qz7DarPfPWbn6YfyoHZOr5IjwteFyWmVXs/Xxooa0fTwgwMMp+Zre0
         SIF6Fz01q+rJACrcj/2bPPq0hrnwFcaP79iwlGQ8f5t8fU2Lm8DEB0mKFFHJ6ICw4VKh
         xayQ==
X-Gm-Message-State: AOAM531tl9+vvMCSJVsqYmQ5LS+A92A2IwWwb/GbvWxRr4PldMVInPse
        JNClw9moRN46/QgxiEj2S4CGXKIyiJunrKrXkxFPuUSY
X-Google-Smtp-Source: ABdhPJxw0WlkyxbaLpveonrYIYn03kmXfBxyI8Qe23+tm47k9rxL32HtF5u9YtuY9uM/0XIdN5LpIYI2gHO1NYNblBo=
X-Received: by 2002:a05:6870:d68e:b0:e2:861:8b15 with SMTP id
 z14-20020a056870d68e00b000e208618b15mr73796oap.156.1652882231772; Wed, 18 May
 2022 06:57:11 -0700 (PDT)
MIME-Version: 1.0
References: <20220517140748.24238-1-cgzones@googlemail.com>
In-Reply-To: <20220517140748.24238-1-cgzones@googlemail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Wed, 18 May 2022 09:57:01 -0400
Message-ID: <CAP+JOzR9HgkkF6AVJCXz3YQThg4peSZytUCKiBfxmCWdatiDvw@mail.gmail.com>
Subject: Re: [PATCH 1/2] libselinux: restorecon: add fallback for pre 3.6 Linux
To:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, May 17, 2022 at 12:58 PM Christian G=C3=B6ttsche
<cgzones@googlemail.com> wrote:
>
> fstat(2) on file descriptors obtained via O_PATH is supported since
> Linux 3.6. Fallback on older systems to lstat(2).
>
> Fixes: 7e979b56 ("libselinux: restorecon: pin file to avoid TOCTOU issues=
")
>
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
> ---
>  libselinux/src/selinux_restorecon.c | 29 +++++++++++++++++++++++++----
>  1 file changed, 25 insertions(+), 4 deletions(-)
>
> diff --git a/libselinux/src/selinux_restorecon.c b/libselinux/src/selinux=
_restorecon.c
> index 9dd6be81..1a185ced 100644
> --- a/libselinux/src/selinux_restorecon.c
> +++ b/libselinux/src/selinux_restorecon.c
> @@ -89,10 +89,22 @@ struct rest_flags {
>         bool count_errors;
>  };
>
> +/* Linux version for availability tests. */
> +static struct utsname uts;
> +
>  static void restorecon_init(void)
>  {
>         struct selabel_handle *sehandle =3D NULL;
>
> +       if (uname(&uts) < 0) {
> +               /*
> +                * utsname(2) should never fail, but assume oldest suppor=
ted

Should be "uname(2) should ..."

> +                * LTS release as backup
> +                */
> +               strncpy(uts.release, "4.9", sizeof(uts.release));

I don't know. Using 4.9 seems arbitrary. I think that I would prefer
just using "3.6" and note that only behavior is only changed for
kernels prior to 3.6 or something like that.

Thanks,
Jim


> +               uts.release[sizeof(uts.release) - 1] =3D '\0';
> +       }
> +
>         if (!fc_sehandle) {
>                 sehandle =3D selinux_restorecon_default_handle();
>                 selinux_restorecon_set_sehandle(sehandle);
> @@ -238,7 +250,6 @@ static uint64_t file_system_count(const char *name)
>   */
>  static uint64_t exclude_non_seclabel_mounts(void)
>  {
> -       struct utsname uts;
>         FILE *fp;
>         size_t len;
>         int index =3D 0, found =3D 0;
> @@ -247,7 +258,7 @@ static uint64_t exclude_non_seclabel_mounts(void)
>         char *buf =3D NULL, *item;
>
>         /* Check to see if the kernel supports seclabel */
> -       if (uname(&uts) =3D=3D 0 && strverscmp(uts.release, "2.6.30") < 0=
)
> +       if (strverscmp(uts.release, "2.6.30") < 0)
>                 return 0;
>         if (is_selinux_enabled() <=3D 0)
>                 return 0;
> @@ -648,9 +659,19 @@ static int restorecon_sb(const char *pathname, struc=
t rest_flags *flags, bool fi
>         if (fd < 0)
>                 goto err;
>
> +       /*
> +        * fstat(2) on file descriptors obtained via O_PATH are supported
> +        * since Linux 3.6, see man:open(2).
> +        * Test fstat(2) first, support might have been backported.
> +        */
>         rc =3D fstat(fd, &stat_buf);
> -       if (rc < 0)
> -               goto err;
> +       if (rc < 0) {
> +               if (errno =3D=3D EBADF && strverscmp(uts.release, "3.6") =
< 0)
> +                       rc =3D lstat(pathname, &stat_buf);
> +
> +               if (rc < 0)
> +                       goto err;
> +       }
>
>         if (rootpath !=3D NULL && lookup_path[0] =3D=3D '\0')
>                 /* this is actually the root dir of the alt root. */
> --
> 2.36.1
>
