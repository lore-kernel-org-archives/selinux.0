Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E15FC433F5
	for <selinux@archiver.kernel.org>; Mon, 18 Oct 2021 19:55:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6198161038
	for <selinux@archiver.kernel.org>; Mon, 18 Oct 2021 19:55:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231398AbhJRT5L (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 18 Oct 2021 15:57:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230159AbhJRT5K (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 18 Oct 2021 15:57:10 -0400
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 694CEC06161C
        for <selinux@vger.kernel.org>; Mon, 18 Oct 2021 12:54:59 -0700 (PDT)
Received: by mail-ot1-x32b.google.com with SMTP id x27-20020a9d459b000000b0055303520cc4so1190381ote.13
        for <selinux@vger.kernel.org>; Mon, 18 Oct 2021 12:54:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Z7IaHMLE7PpZawobaTgnkIB2Ut2P0OwughnalZmJnHI=;
        b=IAKrIEF/TmAEmrWooxvbbugU1P1y4Qcsvyzl6TJ2+vmEHZ59TQnxVGooUJvtzRPUQf
         04+U93zHfDz5Nj6rHhz8E4bhdQOKSdarVMdYfiFDmiLs58FWqNxKzqTG/Bl29g4aC8HD
         GZeDCNxcr2Nhu4nnix+a18RBJpe+E0JfHq2tXp3M8U1GZ30WklpHETUlVilSsu89XujJ
         Mg1Yg9eqz5Wr2LOsz5o+jZTNFcr4npha5vMR25tGF78gTDOvk+Q0GsEY5C5LH2m6ppWV
         WSmrKqHt8ucfF09LyL29EW6C82r46qjixCjljY95yAVfyXJND/NvygFVRYFJruj0qOHt
         4q3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Z7IaHMLE7PpZawobaTgnkIB2Ut2P0OwughnalZmJnHI=;
        b=IWzMHjdXzkdF5pDVjOv370zBVOjQ9PjmLnb+IkjWmRjOqDA4Iytrr7GFi/zS0AQhxm
         1EKrFuQMjrcA+B8yQoUQFEkj47GhbCLxsIvlo+NbzqUzIJIJ1VBfeDmkBaaQOQGFCQ0C
         9fMVmsXA7O6xx29h6w1q4ZNWGiG2PfGkO7R+npMH6yZKEv2Yv5CTUD99TGnMGnIsWjvC
         xFjX9hp+vPFvpXE91ezAuwIhagiP6apu3bBc1uX4glLHbLD94G275C80P1TK0R1MTtnT
         frEKhsfo2GYmK+aeTL7ucCzB5CrOg+wMZ7OTMEgYfEqOImAsZqlkaDbinXmd1WlOfa9Z
         3Nsw==
X-Gm-Message-State: AOAM53202TsaAkHNDQuWJmQNW1n1sOPjdUzSU/YnZPN2BSVba3dKiYwM
        AhwcOaSwCklXs6xEOQskvYOjK3oe5NV5zt2znUQb3yp+
X-Google-Smtp-Source: ABdhPJys44rcH78BeDGVoUQCFHh3j47ky9A6wIp1GyQV6InxdMoJ8m8O/ArZSvjmESkJKkb/xqsecQRJ9szFKmvvXg4=
X-Received: by 2002:a9d:5f85:: with SMTP id g5mr1552058oti.139.1634586898816;
 Mon, 18 Oct 2021 12:54:58 -0700 (PDT)
MIME-Version: 1.0
References: <20211011162533.53404-1-cgzones@googlemail.com> <20211011162533.53404-26-cgzones@googlemail.com>
In-Reply-To: <20211011162533.53404-26-cgzones@googlemail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Mon, 18 Oct 2021 15:54:47 -0400
Message-ID: <CAP+JOzR4z=n7L00DetEKJzY8HygS17e5bqmJ+bujqh3hCVRSug@mail.gmail.com>
Subject: Re: [RFC PATCH 25/35] libsepol: validate avtab types
To:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Oct 11, 2021 at 12:41 PM Christian G=C3=B6ttsche
<cgzones@googlemail.com> wrote:
>
> Check for invalid avtab types.
>
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
> ---
>  libsepol/src/policydb_validate.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
>
> diff --git a/libsepol/src/policydb_validate.c b/libsepol/src/policydb_val=
idate.c
> index fa128794..89830ff3 100644
> --- a/libsepol/src/policydb_validate.c
> +++ b/libsepol/src/policydb_validate.c
> @@ -441,6 +441,20 @@ static int validate_avtab_key(avtab_key_t *key, vali=
date_t flavors[])
>                 goto bad;
>         if (validate_value(key->target_class, &flavors[SYM_CLASSES]))
>                 goto bad;
> +       switch (0xFFF & key->specified) {
> +       case AVTAB_ALLOWED:
> +       case AVTAB_AUDITALLOW:
> +       case AVTAB_AUDITDENY:
> +       case AVTAB_XPERMS_ALLOWED:
> +       case AVTAB_XPERMS_AUDITALLOW:
> +       case AVTAB_XPERMS_DONTAUDIT:
> +       case AVTAB_TRANSITION:
> +       case AVTAB_MEMBER:
> +       case AVTAB_CHANGE:
> +               break;
> +       default:
> +               goto bad;
> +       }
>
>         return 0;
>
> --
> 2.33.0
>

avrule_t also has a specified field that could be checked.

Thanks,
Jim
