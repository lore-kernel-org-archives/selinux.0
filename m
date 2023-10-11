Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 725A8CDB475
	for <selinux@archiver.kernel.org>; Wed, 11 Oct 2023 18:51:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233087AbjJKSvB (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 11 Oct 2023 14:51:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233157AbjJKSu5 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 11 Oct 2023 14:50:57 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66AD19D
        for <selinux@vger.kernel.org>; Wed, 11 Oct 2023 11:50:54 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id 2adb3069b0e04-5041d6d8b10so248918e87.2
        for <selinux@vger.kernel.org>; Wed, 11 Oct 2023 11:50:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697050252; x=1697655052; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hFH+vTjnFLSGzsP/BDX4uRxpAw1MctmcCxeM39wP0So=;
        b=AxQ0Jxt2n2tqL616Nrby5RqFA/BgFEfeqWdy1D4N8MiL+6HDWaqxLHkKncRpquXT0p
         cfvz19y9+t3XE7qyXuTkwnXSQdLjg7v8njgTYv7aNZe/Idhzum/HMSmdnk6BQSLXnF+F
         tPW81DnIcDEujEtskEthI/8IcAcWmpQan8hHSTCj4YxUT8GFCyaIiSqeAhU+Sgl2+h9Y
         EGYQRiHcDp6wJk+bZGrVI6J+1RlUvq+M/bXhvFYC5DKNlE5NZqu6jT1aVdlXyiqbZV4k
         7c0sOgGvBhIuSA7btlpv4qu0okA3x6FRP5hpQW84BkjJJ593TPFNIyS0qZewkfGlInBA
         PevQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697050252; x=1697655052;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hFH+vTjnFLSGzsP/BDX4uRxpAw1MctmcCxeM39wP0So=;
        b=SCXi+18nqlGAHlGWOKQBqMKwl6kptU0OpkIokb9iDY173KCrPNHzj2URIuv2rqmF/2
         MiU9jyoAzyoHpSUsRvqYVhK1yvsoiCQC/p62RjmI7Hmuahg5yh0QrjPsqtuQL10CBdTM
         IV9RpIfJPq+YSTt8iaLfDxLAH0xbSH4eI1OjUqxMMHlPBgGW01/97X2Jrqe+CqUp3sk4
         FgI/l0ZjFp9lXKxTfzvPNjx25VdSvUyvjs88cFAptsqHQgBhi5RJkBYh9DeA8ECCI9I7
         zBfVS3FZktm31HqvTNRhjU+6E8G2TyUsJjw2w3PFm3ulI107jVLCvQPLHi3U74xbUdnA
         CYVQ==
X-Gm-Message-State: AOJu0YxXKFSlK2Xgn4OjhjAyySYWVBaas4WfYqLRIz9jqRP7HloQMjWs
        j7MI49pFdPrv2BIjY/NdyCp41HAef7H+7oLUXbGvG+P2AzM=
X-Google-Smtp-Source: AGHT+IGVseVbiKQbhWG2OLI1eKPIxSyWRLgHAj/e8RiHGrf2zzO820g2gcqARYoMMGNI1qTum8eVtH7oLZII4O30h5s=
X-Received: by 2002:a05:6512:6ce:b0:503:2555:d1e7 with SMTP id
 u14-20020a05651206ce00b005032555d1e7mr24381958lff.45.1697050252511; Wed, 11
 Oct 2023 11:50:52 -0700 (PDT)
MIME-Version: 1.0
References: <20230814132025.45364-1-cgzones@googlemail.com> <20230814132025.45364-25-cgzones@googlemail.com>
In-Reply-To: <20230814132025.45364-25-cgzones@googlemail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Wed, 11 Oct 2023 14:50:41 -0400
Message-ID: <CAP+JOzQqBMVBdtcyZmci2DFgdtHkhKfXBpnpgPqLXGhWbRrDPA@mail.gmail.com>
Subject: Re: [RFC PATCH v2 24/27] libselinux: set errno on label lookup failure
To:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Aug 14, 2023 at 9:42=E2=80=AFAM Christian G=C3=B6ttsche
<cgzones@googlemail.com> wrote:
>
> selabel_lookup(3) is expected to set errno on lookup failure, i.e. when
> it returns NULL.  Set errno if a regular expression failed to compile in
> compile_regex().
>
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>

Acked-by: James Carter <jwcart2@gmail.com>

> ---
> v2: add patch
> ---
>  libselinux/src/label_file.h | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/libselinux/src/label_file.h b/libselinux/src/label_file.h
> index 3827b5c0..5365086b 100644
> --- a/libselinux/src/label_file.h
> +++ b/libselinux/src/label_file.h
> @@ -407,6 +407,7 @@ static inline int compile_regex(struct spec *spec, co=
nst char **errbuf)
>                         *errbuf =3D &regex_error_format_buffer[0];
>                 }
>                 __pthread_mutex_unlock(&spec->regex_lock);
> +               errno =3D EINVAL;
>                 return -1;
>         }
>
> --
> 2.40.1
>
