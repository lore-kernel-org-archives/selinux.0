Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A654C4332F
	for <selinux@archiver.kernel.org>; Thu, 10 Nov 2022 14:17:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229562AbiKJORd (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 10 Nov 2022 09:17:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229651AbiKJORc (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 10 Nov 2022 09:17:32 -0500
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0895ADE81
        for <selinux@vger.kernel.org>; Thu, 10 Nov 2022 06:17:31 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id be13so3516135lfb.4
        for <selinux@vger.kernel.org>; Thu, 10 Nov 2022 06:17:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WRDCqhowd8fE6pWQ/6ga7WqK+cH/0qQm6GV9s7snxgg=;
        b=D1ktan2OxnpEWEZEiDW7wFyhZT9l7VgOKHFFG56FH3E+/SADhF1+/1Dupv0sT8xANh
         RmZHYuHWPg344AA2uZR9mVgGJGVVzdEZl2GTiS1m1kwANe29wxJOM7F+JeW9vLoxPasT
         V+bsaluVzCl3+l++80dnDbZhS9Cx/dnoSkQRt2O3mUarbplpVtdr0tKyxFo+lChdN/We
         QsYD82U8d/aunZCC5d+iO/ol+YmCD+z/Ioxywc3872X8pEGjuXNpKqKWHGMdC8A9VI0G
         xRVtdh8NZa1MpGCy7LVh3LYgaDVi11o2e9rtmLaK4Flc25N7QAJ0u3n3LgU60MzMUs4E
         TATw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WRDCqhowd8fE6pWQ/6ga7WqK+cH/0qQm6GV9s7snxgg=;
        b=W/rcUZYIfngI75YOQVi/tKr5msnA7Cx8Su+b3HQ9zhNGmv1XMTlyjD53noDh6J+3lz
         S7Xlyh/XVPVs32JeibUiUCCwq1ESbovO7uRZvgPpo7SRsrriwQ7tJAOOKB7zDwpNFyK8
         5ZOL3bnugjgB8yVby5HrY0TaYoQ+fH0aR2IPGQ1MjEabvw773qvxRyRMPwhFj5UJhJ6J
         +Qrih9eBWt1FJs9OxdFrpnjX7li8uIuPzvfSFNGUyjTNmZBI2feWwa0PHshtUl669dRB
         QQ3ee0WJBCnqL2/HMd1kCC0PJxUp/ksjeFhCFqcGZCVYj7Len4DgcEkYjPdCcTUbByh8
         5LIg==
X-Gm-Message-State: ACrzQf2QgPXWaUvemcWmYw/FFI8c/C6lr+bTaE1Pc5gzyjPOe09+ivhQ
        2LqzDG59QqynGNXrNMIhaqNU8RMWe1nI+mgcdsUDRjzgkS0=
X-Google-Smtp-Source: AMsMyM40E5aNBAgYn2qr4z2PgR5zXLRh1rAtR8PzUPIz2LkwKUVPRzSffCrz79OGoLd1wXxxk/gAPAn6Yw4gUTANedk=
X-Received: by 2002:ac2:5bcd:0:b0:4b0:d503:9afb with SMTP id
 u13-20020ac25bcd000000b004b0d5039afbmr17139230lfn.13.1668089847903; Thu, 10
 Nov 2022 06:17:27 -0800 (PST)
MIME-Version: 1.0
References: <20221109201701.64203-1-cgzones@googlemail.com>
In-Reply-To: <20221109201701.64203-1-cgzones@googlemail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Thu, 10 Nov 2022 09:17:16 -0500
Message-ID: <CAP+JOzR=H2YujfURqnOADxZ1jv1U+A0pzd78p6H0Df-TtY9=sA@mail.gmail.com>
Subject: Re: [PATCH] libselinux: drop set but not used internal variable
To:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Nov 9, 2022 at 3:24 PM Christian G=C3=B6ttsche
<cgzones@googlemail.com> wrote:
>
> The internal variable avc_netlink_trouble is only assigned but never
> read from.
> Unused since the initial commit 13cd4c896068 ("initial import from svn
> trunk revision 2950").
>
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>

Acked-by: James Carter <jwcart2@gmail.com>

> ---
>  libselinux/src/avc_internal.c | 2 --
>  libselinux/src/avc_internal.h | 3 ---
>  libselinux/src/sestatus.c     | 1 -
>  3 files changed, 6 deletions(-)
>
> diff --git a/libselinux/src/avc_internal.c b/libselinux/src/avc_internal.=
c
> index 71a1357b..ffc663e5 100644
> --- a/libselinux/src/avc_internal.c
> +++ b/libselinux/src/avc_internal.c
> @@ -51,7 +51,6 @@ char avc_prefix[AVC_PREFIX_SIZE] =3D "uavc";
>  int avc_running =3D 0;
>  int avc_enforcing =3D 1;
>  int avc_setenforce =3D 0;
> -int avc_netlink_trouble =3D 0;
>
>  /* process setenforce events for netlink and sestatus */
>  int avc_process_setenforce(int enforcing)
> @@ -295,7 +294,6 @@ void avc_netlink_loop(void)
>
>         close(fd);
>         fd =3D -1;
> -       avc_netlink_trouble =3D 1;
>         avc_log(SELINUX_ERROR,
>                 "%s:  netlink thread: errors encountered, terminating\n",
>                 avc_prefix);
> diff --git a/libselinux/src/avc_internal.h b/libselinux/src/avc_internal.=
h
> index a9a4aa0b..54f0ce28 100644
> --- a/libselinux/src/avc_internal.h
> +++ b/libselinux/src/avc_internal.h
> @@ -180,7 +180,4 @@ int avc_ss_set_auditdeny(security_id_t ssid, security=
_id_t tsid,
>                          security_class_t tclass, access_vector_t perms,
>                          uint32_t seqno, uint32_t enable) ;
>
> -/* netlink kernel message code */
> -extern int avc_netlink_trouble ;
> -
>  #endif                         /* _SELINUX_AVC_INTERNAL_H_ */
> diff --git a/libselinux/src/sestatus.c b/libselinux/src/sestatus.c
> index 89c1f621..fbe64301 100644
> --- a/libselinux/src/sestatus.c
> +++ b/libselinux/src/sestatus.c
> @@ -343,7 +343,6 @@ error:
>                 if (avc_using_threads)
>                 {
>                         fallback_netlink_thread =3D avc_create_thread(&av=
c_netlink_loop);
> -                       avc_netlink_trouble =3D 0;
>                 }
>
>                 fallback_sequence =3D 0;
> --
> 2.38.1
>
