Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 883C4C433EF
	for <selinux@archiver.kernel.org>; Fri,  1 Apr 2022 20:51:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233681AbiDAUxo (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 1 Apr 2022 16:53:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234080AbiDAUxn (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 1 Apr 2022 16:53:43 -0400
Received: from mail-oa1-x2a.google.com (mail-oa1-x2a.google.com [IPv6:2001:4860:4864:20::2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75B141C34B2
        for <selinux@vger.kernel.org>; Fri,  1 Apr 2022 13:51:51 -0700 (PDT)
Received: by mail-oa1-x2a.google.com with SMTP id 586e51a60fabf-de3ca1efbaso3981420fac.9
        for <selinux@vger.kernel.org>; Fri, 01 Apr 2022 13:51:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=lNDz1iPWDwCSHxWcpZ46Lq3S0CgX5qyg9vsf5W0dDJk=;
        b=dlvVC5dH4umLWQEKNWV5O7kuU4gQpF4PLsslcZ4BbBO+0vf0ZpdtK4xK5xZj3G4sNS
         EBoQXotOXHcLVQF46RE/WIvpq5RNtcuLLyldWtM8prJzKKODcvBni++yAOgXboXrgxxx
         wOOAASIoBZ+gnt9U420uxav4c6ibQ3R2KzFhudIJLYjUd2sIPbbk8v4hCm0W0o7CW9+J
         ks+ANxx822kdj4u4uOapHR+WmICTzcRynfcnsVDzbbmw2qNlaPywyoYDL76sp2v6igNd
         rI2Yq0lFl0CqiDpygprBkHhLbMv1XQLNW1z9mYTvo1CnARjVqigE8u5bKArI7a2kGBvl
         HPcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=lNDz1iPWDwCSHxWcpZ46Lq3S0CgX5qyg9vsf5W0dDJk=;
        b=yIHiYsOnb4eUDAfCYfzn8gtbf854HRVx16LwizboEYyiA5Fm/7lBenCLXKLvDGyEVR
         fy+19DIfOWbHYac1R86I3q/ejTot+Hg4u1jhCbpIzRUfkibIHiJDVCmdpfiKd+uwyCbt
         6JQqKDXx2/lc4veEouddL6Fv3Vz4mQfQeEq1uJ3g4clrA8bRSoyFyHWEO5QQd9H3aaSS
         sN4c6U/mEswtbHahq6yL1lQmKEr0CyOF+IOK6BWY8ylQZ1UjE4BcqCX+cCoksiTjjITg
         TcW0s0xhZKg2w012tZQo8uoMzGUOkr6ygeB90wa1HeRzGzbJqzhnqMXOkujY05ZocACF
         mBTA==
X-Gm-Message-State: AOAM533VST04/p18MlclP+TX7YLib7+nobQjLXDhqHFZc3mDg39+bgie
        pPmA+uSV82//xq2YpkRkm8P82c/HvLZoMMxqYg6ctzf0baw=
X-Google-Smtp-Source: ABdhPJyJ+sc+rdynKrOQUdJmP2QWgezqHA9ZKMnd6UslcflavHkgYDZCCIDU56LPlBg466N0jocy7llNsQNkTQfixmg=
X-Received: by 2002:a05:6870:f624:b0:e1:c071:121c with SMTP id
 ek36-20020a056870f62400b000e1c071121cmr1752632oab.182.1648846310770; Fri, 01
 Apr 2022 13:51:50 -0700 (PDT)
MIME-Version: 1.0
References: <20220331144752.31495-1-cgzones@googlemail.com> <20220331144752.31495-3-cgzones@googlemail.com>
In-Reply-To: <20220331144752.31495-3-cgzones@googlemail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Fri, 1 Apr 2022 16:51:40 -0400
Message-ID: <CAP+JOzTokM6k+wTVneEeSLGGhH5A2r7XayLLotiu8XuFn=GW7g@mail.gmail.com>
Subject: Re: [RFC PATCH 3/4] libsepol/cil: post process pirqcon rules
To:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Mar 31, 2022 at 3:36 PM Christian G=C3=B6ttsche
<cgzones@googlemail.com> wrote:
>
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>

Acked-by: James Carter <jwcart2@gmail.com>

> ---
>  libsepol/cil/src/cil_post.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/libsepol/cil/src/cil_post.c b/libsepol/cil/src/cil_post.c
> index 7f33cd9e..714ce227 100644
> --- a/libsepol/cil/src/cil_post.c
> +++ b/libsepol/cil/src/cil_post.c
> @@ -2434,6 +2434,12 @@ static int cil_post_db(struct cil_db *db)
>                 goto exit;
>         }
>
> +       rc =3D __cil_post_process_context_rules(db->pirqcon, cil_post_pir=
qcon_compare, cil_post_pirqcon_context_compare, db, CIL_PIRQCON, CIL_KEY_IO=
MEMCON);
> +       if (rc !=3D SEPOL_OK) {
> +               cil_log(CIL_ERR, "Problems processing pirqcon rules\n");
> +               goto exit;
> +       }
> +
>         rc =3D __cil_post_process_context_rules(db->iomemcon, cil_post_io=
memcon_compare, cil_post_iomemcon_context_compare, db, CIL_IOMEMCON, CIL_KE=
Y_IOMEMCON);
>         if (rc !=3D SEPOL_OK) {
>                 cil_log(CIL_ERR, "Problems processing iomemcon rules\n");
> --
> 2.35.1
>
