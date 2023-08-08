Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FB31C41513
	for <selinux@archiver.kernel.org>; Tue,  8 Aug 2023 20:45:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234079AbjHHUpp (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 8 Aug 2023 16:45:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234049AbjHHUpd (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 8 Aug 2023 16:45:33 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8685533920
        for <selinux@vger.kernel.org>; Tue,  8 Aug 2023 09:34:16 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id 41be03b00d2f7-517ab9a4a13so4327032a12.1
        for <selinux@vger.kernel.org>; Tue, 08 Aug 2023 09:34:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691512428; x=1692117228;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XE/9U5XQqMyn/QRibeavGPD3cYH+oLlR2G3qAXNtjMo=;
        b=MVYpPwlxsqcPGYocN+lBW1OwjBI6vsc+8rYKA2bRiOYZP7O0gg+APqiVP+bcloiLFP
         xIjYgBJkm8ZQjWX0XghDZK5pCGzvVF+4n6UeESXqGjkuDD8pzkvQFlzfcEXMFIpF7Nhp
         xipHB+W1+5sp0LPyevYN9wb+8Xn5IGqFXoh/F1OwQK9VdoFZQRzGJNBH9iwYcsdai7xu
         PXNCZJBjEBdNb/I70zFAAC677mHLFZ6i03LYlOTDB6izO3/oWvmm5ORYIigkKDEeefFe
         DjM+MxMM3DNsehy91YCWSebal4Cr+4uLKn5IzhAtU8oPF/ly0wKS6kpgRvoHtq5a++md
         nT9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691512428; x=1692117228;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XE/9U5XQqMyn/QRibeavGPD3cYH+oLlR2G3qAXNtjMo=;
        b=iwK//h8BYe9NoqU2Mio4Gdof1sJ0kVNXwbNeRpo5btExdz/44Y3f/kjQLs6S0bHqWh
         Lg1nnsmg/1M15ChJE/ial8NRgNb++A/WDjV5TjrGwMOKJUyHa0OujmolZuZFdr9Rfw7M
         xDOqY+roAqdy+4w56aY5jxWI0tZKTPxBWfr1J6qSkAYQtum9wIn3JNkIqsIsYpJ73pc/
         /36hqA8SdlNW+zYz+8Koj6sY6o2h7Hymt+7bxrsuc0INEqM941rOnLkG2OynqDRYNR44
         oLg9iP5pSaZPABpNF+WMvH5f5br6bXMwOPvrybMPYFBUaeUPm2BS50MfFnuIkoxUSAIG
         dl/Q==
X-Gm-Message-State: AOJu0YyT3Ilmm5tiIv06CvIxpK4cSg7fqwlYR8WmRGnUULyoGL6qMTA5
        8ELSHZPCjKj/iLpchFqRUQKpwszt2CqUNCpdOm/ix719
X-Google-Smtp-Source: AGHT+IH9TriqlZIGNmQz5LGtfmnOX1+2R6ph0Qp3MeC63fFgD+tz3ls3JknCm9bSHLVuQ3NYX9mQvuLuKr/d5NJJ0xA=
X-Received: by 2002:a17:90a:9f95:b0:268:565f:44a with SMTP id
 o21-20020a17090a9f9500b00268565f044amr102191pjp.9.1691512428205; Tue, 08 Aug
 2023 09:33:48 -0700 (PDT)
MIME-Version: 1.0
References: <20230807180518.223481-1-cgzones@googlemail.com>
In-Reply-To: <20230807180518.223481-1-cgzones@googlemail.com>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Tue, 8 Aug 2023 12:33:37 -0400
Message-ID: <CAEjxPJ7=zm2_Bky=M9VwFPA70c6HO5bOuc3a01E_UbTmwHwpuQ@mail.gmail.com>
Subject: Re: [RFC PATCH] selinux: use GFP_KERNEL while reading binary policy
To:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Aug 7, 2023 at 2:42=E2=80=AFPM Christian G=C3=B6ttsche
<cgzones@googlemail.com> wrote:
>
> Use GFP_KERNEL instead of GFP_ATOMIC while reading a binary policy in
> sens_read() and cat_read(), similar to surrounding code.
>
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>

Congrats, you found something that appears to have been present since
before SELinux went into mainline Linux 2.6.0-test3. Going back to my
old CVS history, it looks like we switched the other allocations from
GFP_ATOMIC to GFP_KERNEL at a time when all of the MLS-related
functions were still in mls.c rather than policydb.c, but those didn't
get updated and were subsequently moved over.

Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>

> ---
>  security/selinux/ss/policydb.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/security/selinux/ss/policydb.c b/security/selinux/ss/policyd=
b.c
> index a424997c79eb..bb850b608dc6 100644
> --- a/security/selinux/ss/policydb.c
> +++ b/security/selinux/ss/policydb.c
> @@ -1597,7 +1597,7 @@ static int sens_read(struct policydb *p, struct sym=
tab *s, void *fp)
>         __le32 buf[2];
>         u32 len;
>
> -       levdatum =3D kzalloc(sizeof(*levdatum), GFP_ATOMIC);
> +       levdatum =3D kzalloc(sizeof(*levdatum), GFP_KERNEL);
>         if (!levdatum)
>                 return -ENOMEM;
>
> @@ -1608,12 +1608,12 @@ static int sens_read(struct policydb *p, struct s=
ymtab *s, void *fp)
>         len =3D le32_to_cpu(buf[0]);
>         levdatum->isalias =3D le32_to_cpu(buf[1]);
>
> -       rc =3D str_read(&key, GFP_ATOMIC, fp, len);
> +       rc =3D str_read(&key, GFP_KERNEL, fp, len);
>         if (rc)
>                 goto bad;
>
>         rc =3D -ENOMEM;
> -       levdatum->level =3D kmalloc(sizeof(*levdatum->level), GFP_ATOMIC)=
;
> +       levdatum->level =3D kmalloc(sizeof(*levdatum->level), GFP_KERNEL)=
;
>         if (!levdatum->level)
>                 goto bad;
>
> @@ -1638,7 +1638,7 @@ static int cat_read(struct policydb *p, struct symt=
ab *s, void *fp)
>         __le32 buf[3];
>         u32 len;
>
> -       catdatum =3D kzalloc(sizeof(*catdatum), GFP_ATOMIC);
> +       catdatum =3D kzalloc(sizeof(*catdatum), GFP_KERNEL);
>         if (!catdatum)
>                 return -ENOMEM;
>
> @@ -1650,7 +1650,7 @@ static int cat_read(struct policydb *p, struct symt=
ab *s, void *fp)
>         catdatum->value =3D le32_to_cpu(buf[1]);
>         catdatum->isalias =3D le32_to_cpu(buf[2]);
>
> -       rc =3D str_read(&key, GFP_ATOMIC, fp, len);
> +       rc =3D str_read(&key, GFP_KERNEL, fp, len);
>         if (rc)
>                 goto bad;
>
> --
> 2.40.1
>
