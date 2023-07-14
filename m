Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF7B3C0015E
	for <selinux@archiver.kernel.org>; Fri, 14 Jul 2023 17:35:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236038AbjGNRfQ (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 14 Jul 2023 13:35:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235829AbjGNRfP (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 14 Jul 2023 13:35:15 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC95835A4
        for <selinux@vger.kernel.org>; Fri, 14 Jul 2023 10:35:11 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id 38308e7fff4ca-2b700e85950so32858171fa.3
        for <selinux@vger.kernel.org>; Fri, 14 Jul 2023 10:35:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689356110; x=1691948110;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hEdwcOPZkfclJLuH4bXG5+2DmBwPm0mnO43ICxZNJWI=;
        b=m0gXPRe4SKNrDvarC31GcJerRRugbx7nhD0QtFySgdcfOI3J/d0jydcXUso5vwDO/z
         unHjT2LPugjr58Xq30m+DWRUhkzq0mKS48Sjwh/bw+wA7+ToTIpqXglo7V7NOn3I56lE
         b6unxKEFsiXevePLw0KAaa6brM3vvm4Lx+y+Zf6kurbIDdNki7lKP8qVPWNHne0TZEyE
         KBm2vOId0ezNbywz45SAw/FuMv8pzakRPiD2LHSgkVgVt8GuZlEIKD7ix1REUoUgUgiq
         0dCIvLli4iTxOmKGAcY/+3UNIHa5DOwuKS5QKy3A/qR2SfpPQ0gNCZxIwR5RmktuYHHM
         uLZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689356110; x=1691948110;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hEdwcOPZkfclJLuH4bXG5+2DmBwPm0mnO43ICxZNJWI=;
        b=BTfWfK3oA8/HU5NG0ymjaXwcsHXxtQ+31t55uAvWfJzL10D3D2vlnnVDvNFJ1wGLs8
         u93Ohz7HBI9ceOQ1V0g2j4Hdwib/HDxLgyJ53g/aCfGo/ISL59Wh6c77AhcNZbk+Skjg
         MmkZvkfc/D6Xo29tFrzjjBO/6Tkq7ZRFKtRgvGHTEyM8vSVmw3NYkPOnIRl4uwQJxt81
         9KeqH102Azmd9JMRaUU6g6IHht/YcVA90UKohCpvtf0sOGpfhT9+hoq39pP5D2q5p51H
         s4cVVem0rtsg7YTad6Aw0eqFqsFkCpIXAuJSgB4ZdH+VuXCgq+asBSwAoTWn19c32sfx
         jDNg==
X-Gm-Message-State: ABy/qLak1EDDHhFPgKwmjoNp0nK7BoPNBZC4m6AB+pNdvverpCCXzKcR
        DIbyv7GoSNse89aTxTsK8oO4hIqHx3KrOGB30j2DayK/
X-Google-Smtp-Source: APBJJlFL8fQTLCOOZJo7UPCKfRoiVZ5feqbbkVPflb2U4Nj4C6wCgmS5CDe3q+k/4mrLxZOlMXZvYMGlXIZcsLJhUh4=
X-Received: by 2002:a2e:9f48:0:b0:2b6:a841:e686 with SMTP id
 v8-20020a2e9f48000000b002b6a841e686mr4251355ljk.6.1689356109852; Fri, 14 Jul
 2023 10:35:09 -0700 (PDT)
MIME-Version: 1.0
References: <20230706162120.25610-1-cgzones@googlemail.com>
In-Reply-To: <20230706162120.25610-1-cgzones@googlemail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Fri, 14 Jul 2023 13:34:58 -0400
Message-ID: <CAP+JOzSZZOEvBF1Wu_jm0COLa8arB_x9jhMExu4Q2M6xeFDi8w@mail.gmail.com>
Subject: Re: [PATCH] checkpolicy: free role identifier in define_role_dom()
To:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Jul 6, 2023 at 12:34=E2=80=AFPM Christian G=C3=B6ttsche
<cgzones@googlemail.com> wrote:
>
> Free the role identifier in case the role has been already defined
> beforehand, since in that case the identifier is not stored via
> declare_symbol().
>
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>

The right answer here is to just remove role dominance from
checkpolicy. I've sent a patch to the list.
Thanks,
Jim

> ---
> Triggered by the checkpolicy round-trip patch in the GitHub CI.
> ---
>  checkpolicy/policy_define.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/checkpolicy/policy_define.c b/checkpolicy/policy_define.c
> index cef8f3c4..e10c92ff 100644
> --- a/checkpolicy/policy_define.c
> +++ b/checkpolicy/policy_define.c
> @@ -3045,7 +3045,11 @@ role_datum_t *define_role_dom(role_datum_t * r)
>                         yyerror("Out of memory!");
>                         goto cleanup;
>                 }
> +       } else {
> +               free(role_id);
> +               role_id =3D NULL;
>         }
> +
>         if (r) {
>                 ebitmap_t types;
>                 ebitmap_init(&types);
> --
> 2.40.1
>
