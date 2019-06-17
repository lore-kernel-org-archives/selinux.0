Return-Path: <SRS0=LfCf=UQ=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DA39C31E44
	for <selinux@archiver.kernel.org>; Mon, 17 Jun 2019 04:35:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 574CE2189D
	for <selinux@archiver.kernel.org>; Mon, 17 Jun 2019 04:35:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EaIQ6FNt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725840AbfFQEfp (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 17 Jun 2019 00:35:45 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:35668 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725837AbfFQEfp (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 17 Jun 2019 00:35:45 -0400
Received: by mail-io1-f66.google.com with SMTP id m24so18405378ioo.2
        for <selinux@vger.kernel.org>; Sun, 16 Jun 2019 21:35:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ce9WL+GyQohrcN2YRfzJsxBOahOIkMw9J6H+T0Wy2Hk=;
        b=EaIQ6FNterI1jgRgpnYU3SDdL6iYXh/nhqeph7FJUHq6MBcrNeX2XxWUZ5ODNvDBLv
         tLscWiJksiwD6G5lA6naDMh7o3ffpU8DCIKUh7V0sUvPNFzuQLYcFGpo/RKSb7PY6GH1
         sStaP1bqy6ksRrBywlPT+fyo2nXLjvcCmsmBYYeSWnqsh6AMmQkqkSzXs5UuPF1FzrXB
         TGfalrdxXR1wsk8Qa9hHVvgDjMDGyeC3yZN7UJwov3u6PDCBuIsUL66I6rVSKb+6q5QO
         zvjQjmPANlubyo1EuGi89FsGN+9qYVbZL0L8DyfQkeV7yBWidfq3R4PKAe3DBTMiojSf
         0o8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ce9WL+GyQohrcN2YRfzJsxBOahOIkMw9J6H+T0Wy2Hk=;
        b=HfmIQd/N0ASa6WirpvzFAHf4VASZOp7+9zgJKyT94TtTljkfLth19R5Iyh5RWjXvV8
         kTZ3KEKqNOMgcbXL6iZkfFyQEYEmQD9l1miHP3fJVNOGwcOZLuEYKmd1N9D1O4pk4EtG
         UX4p4ROPzbQpr9IWrUuKWr8lfFgXsf6GUi1OjyIZT0KEsq8DlzpN2OJx4SN+VKsQNoK/
         2EmMqR0B6jmFfv/A77TA6qgJwGKnIo224iOCh2TdJUZxmak5Yw7/F5bi3pNts3R1r7ik
         s1mNsvTbHhm/mVSVdjoufzK4MXkirwXbcQU7iSA1U+9VX3GtOTUDt3yv1odjeBJm3qTV
         C67g==
X-Gm-Message-State: APjAAAUVI6+yBEopr8TSSWMl3gbVCSIhJlnt/Zu0LJp3GpEVm7/b7Ich
        p4Q73rKkVTtIfFw5r02pvNOQSIaomYBL6ODhSL4tq9hH2BQ=
X-Google-Smtp-Source: APXvYqw3Jbn2PBDX7h33zwcd5pd877A/362/YDMXWxEFCE8zClXtIBYjaJue4F8VBrmrlXFvtCtzs+tf412lUnlA+lg=
X-Received: by 2002:a02:a815:: with SMTP id f21mr39829974jaj.130.1560746144752;
 Sun, 16 Jun 2019 21:35:44 -0700 (PDT)
MIME-Version: 1.0
References: <alpine.LFD.2.21.1906131859430.5703@34-41-5D-CA-59-C7>
In-Reply-To: <alpine.LFD.2.21.1906131859430.5703@34-41-5D-CA-59-C7>
From:   William Roberts <bill.c.roberts@gmail.com>
Date:   Sun, 16 Jun 2019 21:35:33 -0700
Message-ID: <CAFftDdohpm=28pbnJHCVG8PkCevt9=eZvFH5DoW4tOBQ1s5U_A@mail.gmail.com>
Subject: Re: [PATCH 3/3] libsepol: remove unneeded int
To:     =?UTF-8?B?Sm9ra2UgSMOkbcOkbMOkaW5lbg==?= 
        <jokke.hamalainen@kolttonen.fi>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

ack on the series

I see these are the three staged here:
3/3 uneeded int: https://github.com/SELinuxProject/selinux/pull/154
2/3 remove redundant if clause:
https://github.com/SELinuxProject/selinux/pull/155
1/3 more accurate error message:
https://github.com/SELinuxProject/selinux/pull/156

I will pull them in on Wednesday June 19 if no one objects.

On Thu, Jun 13, 2019 at 9:01 AM Jokke H=C3=A4m=C3=A4l=C3=A4inen
<jokke.hamalainen@kolttonen.fi> wrote:
>
>
> Replace int ret with a constant 1 because it is
> only used when returning from function and is
> never modified.
>
> Signed-off-by: Unto Sten <sten.unto@gmail.com>
> ---
>  libsepol/src/context.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/libsepol/src/context.c b/libsepol/src/context.c
> index a88937fc..e81b28c6 100644
> --- a/libsepol/src/context.c
> +++ b/libsepol/src/context.c
> @@ -38,7 +38,6 @@ int context_is_valid(const policydb_t * p, const contex=
t_struct_t * c)
>         role_datum_t *role;
>         user_datum_t *usrdatum;
>         ebitmap_t types, roles;
> -       int ret =3D 1;
>
>         ebitmap_init(&types);
>         ebitmap_init(&roles);
> @@ -75,7 +74,7 @@ int context_is_valid(const policydb_t * p, const contex=
t_struct_t * c)
>         if (!mls_context_isvalid(p, c))
>                 return 0;
>
> -       return ret;
> +       return 1;
>  }
>
>  /*
> --
> 2.21.0
>
