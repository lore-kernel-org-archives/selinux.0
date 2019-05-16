Return-Path: <SRS0=VlsA=TQ=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 109F2C04E84
	for <selinux@archiver.kernel.org>; Thu, 16 May 2019 01:46:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD25F20843
	for <selinux@archiver.kernel.org>; Thu, 16 May 2019 01:46:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vA3dOY6X"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726979AbfEPBqf (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 15 May 2019 21:46:35 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:41501 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726841AbfEPAvw (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 15 May 2019 20:51:52 -0400
Received: by mail-ot1-f65.google.com with SMTP id g8so1825111otl.8
        for <selinux@vger.kernel.org>; Wed, 15 May 2019 17:51:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=KFYQqEW8E/bfJ0A0Qffi13TStOPNlra992nO1bt1MsY=;
        b=vA3dOY6XxYDMESc8VFXcdijJqeWolJhr+aty+JuWP/UHHqztF7DA1PD3GG+BkyvQHt
         ahpOzzaOL/bLbf6kJsHmCtGZ3DB/SafcGX/OsYEnCWDtbRWVPfrcfgspwbz0Uz7sDQiN
         /brrN+Z5kmseIm1VZmeDaj6pYh6NYq0lF78VOfxjn95z4nlqSzET2qwdOsjiWg8TyJYq
         7J390PcZVZSyhSCy0Fo7Bw0vV5rGXFg+MTpPHSW6VDHPLI9LF2+dHF8j6cTOYs+m5ZnW
         UrtWAORlunXDTU4pPtcOAC9I1ZVkKoivZErIb0udpTE1vNxEA2I9o8uA+V9aS8Ip29fr
         7wnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=KFYQqEW8E/bfJ0A0Qffi13TStOPNlra992nO1bt1MsY=;
        b=ZomyDVM5IdccX99HptysJuQ6NYWCgl7FQaDNfFBEFuTDyPVHIQp+LMc+b98HON7FEc
         IbYO0pdmy5ObpPncMq4urQI2IyH/wStMlqVgGuYJvPdMCA8UlsH0/E/X/ha9HByMs0KT
         m8N4DagZ5jXDA3amGFe8Iw+EJ5mdnmWJlJhNIgj8HlH5ZbSagzGe3og1mOuVEGzBVDQX
         Or3HGg/YmwpYs+czybYS1lfAyEYGunXU0JtLznboU1prRVT6tK7Ek1dvlIIUDwJTd8fT
         S2TQzWmjekyeJ5obddA2wk6/SehCSn0nmvGkDRkpU3TZuqlTmaMEm3WD3TopND75xcBc
         3PVw==
X-Gm-Message-State: APjAAAVy5OpaziEVdxDoPHZ+1qfXrDZDbw8/vR4rJcGas7MXb0t7kFjS
        3QtWHZYcKimpjOH4v5coitWR42F2MQUULej4CRQ=
X-Google-Smtp-Source: APXvYqzrk6SzyGVLEaXMg6Xl8SUGy/sAWp7AmwkzDtEYdWKV7J/rtQHZJdpGVEELGcuOSaruv1R3VJVg5x1yThoiyXI=
X-Received: by 2002:a9d:6b0d:: with SMTP id g13mr245920otp.91.1557967912175;
 Wed, 15 May 2019 17:51:52 -0700 (PDT)
MIME-Version: 1.0
References: <alpine.LFD.2.21.1905110105390.19034@34-41-5D-CA-59-C7>
In-Reply-To: <alpine.LFD.2.21.1905110105390.19034@34-41-5D-CA-59-C7>
From:   William Roberts <bill.c.roberts@gmail.com>
Date:   Wed, 15 May 2019 17:51:40 -0700
Message-ID: <CAFftDdqcCu--4uckf7CpB5-qK1y6sp9yt1S5PYDVgqzGjE2pRw@mail.gmail.com>
Subject: Re: [PATCH] Trivial style fixes pt2
To:     =?UTF-8?B?Sm9ra2UgSMOkbcOkbMOkaW5lbg==?= 
        <jokke.hamalainen@kolttonen.fi>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, May 10, 2019 at 3:08 PM Jokke H=C3=A4m=C3=A4l=C3=A4inen
<jokke.hamalainen@kolttonen.fi> wrote:
>
>
> ---
>  libsemanage/src/direct_api.c    | 2 +-
>  libsemanage/src/modules.c       | 2 +-
>  libsemanage/src/seusers_local.c | 2 +-
>  libsemanage/src/users_local.c   | 4 ++--
>  4 files changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/libsemanage/src/direct_api.c b/libsemanage/src/direct_api.c
> index c58961be..7e097d5f 100644
> --- a/libsemanage/src/direct_api.c
> +++ b/libsemanage/src/direct_api.c
> @@ -517,7 +517,7 @@ ssize_t bunzip(semanage_handle_t *sh, FILE *f, char *=
*data)
>         size_t  size =3D 1<<18;
>         size_t  bufsize =3D size;
>         int     bzerror;
> -       size_t  total=3D0;
> +       size_t  total =3D 0;
>         char*   uncompress =3D NULL;
>         char*   tmpalloc =3D NULL;
>         int     ret =3D -1;
> diff --git a/libsemanage/src/modules.c b/libsemanage/src/modules.c
> index 62af1018..fa84d33e 100644
> --- a/libsemanage/src/modules.c
> +++ b/libsemanage/src/modules.c
> @@ -1130,7 +1130,7 @@ int semanage_module_install_info(semanage_handle_t =
*sh,
>  int semanage_module_remove_key(semanage_handle_t *sh,
>                                const semanage_module_key_t *modkey)
>  {
> -       if (sh->funcs->remove_key=3D=3D NULL) {
> +       if (sh->funcs->remove_key =3D=3D NULL) {
>                 ERR(sh,
>                     "No remove key function defined for this connection t=
ype.");
>                 return -1;
> diff --git a/libsemanage/src/seusers_local.c b/libsemanage/src/seusers_lo=
cal.c
> index a79e2d3d..3e2761c4 100644
> --- a/libsemanage/src/seusers_local.c
> +++ b/libsemanage/src/seusers_local.c
> @@ -133,7 +133,7 @@ int semanage_seuser_modify_local(semanage_handle_t * =
handle,
>         semanage_seuser_t *new =3D NULL;
>
>         if (!sename) {
> -               errno=3DEINVAL;
> +               errno =3D EINVAL;
>                 return -1;
>         }
>         rc =3D semanage_seuser_clone(handle, data, &new);
> diff --git a/libsemanage/src/users_local.c b/libsemanage/src/users_local.=
c
> index 7aa43d44..8193476d 100644
> --- a/libsemanage/src/users_local.c
> +++ b/libsemanage/src/users_local.c
> @@ -38,7 +38,7 @@ static int lookup_seuser(semanage_handle_t * handle, co=
nst semanage_user_key_t *
>         semanage_seuser_list_local(handle,
>                                    &records,
>                                    &count);
> -       for(i=3D0; i<count; i++) {
> +       for(i =3D 0; i < count; i++) {
>                 sename =3D semanage_seuser_get_sename(records[i]);
>                 if (strcmp(name, sename) =3D=3D 0) {
>                         errno =3D EINVAL;
> @@ -47,7 +47,7 @@ static int lookup_seuser(semanage_handle_t * handle, co=
nst semanage_user_key_t *
>                         rc =3D -1;
>                 }
>         }
> -       for(i=3D0; i<count; i++)
> +       for(i =3D 0; i < count; i++)
>                 semanage_seuser_free(records[i]);
>         free(records);
>         semanage_user_free(user);
> --
> 2.21.0
>

ack, can you want to stage a PR?
