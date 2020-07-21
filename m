Return-Path: <SRS0=VL4G=BA=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF6C7C433DF
	for <selinux@archiver.kernel.org>; Tue, 21 Jul 2020 19:38:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A0D0D20720
	for <selinux@archiver.kernel.org>; Tue, 21 Jul 2020 19:38:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DPvhEyIQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730385AbgGUTi3 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 21 Jul 2020 15:38:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729928AbgGUTi3 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 21 Jul 2020 15:38:29 -0400
Received: from mail-oi1-x243.google.com (mail-oi1-x243.google.com [IPv6:2607:f8b0:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9E7CC061794
        for <selinux@vger.kernel.org>; Tue, 21 Jul 2020 12:38:28 -0700 (PDT)
Received: by mail-oi1-x243.google.com with SMTP id y22so18223637oie.8
        for <selinux@vger.kernel.org>; Tue, 21 Jul 2020 12:38:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xmu0YTXtyZeGfogzERYuuAEn3dvm43TDyG1wb4ZPHJU=;
        b=DPvhEyIQYp/SRITawcWw3ZMCZIPO9fS3yIh2eHKI/bSdu+cllow/EIMEjm7Sw3wvGn
         xitdx/ks2jHahEJe47PFhwurHiPfK1d96PKtv8JImUqnioVlwuWPGMfVaP0hbMVcrRkj
         1kJQww2beoZzcf9K07vyfZF4pce5I6QaqO9pTG6225d1NG7asXvWcecXrW2bOeUM2sLj
         R0+tpXm4aWH73kESk4ce8Yipi+HG0GyOWrfUerYfYHc4Dk4PKVLpzb8laFhH2fVh/vbx
         ZXtDMYPg5u0sJWvjcvx/bvnM5dAiyZhS+iHN4rBKJXzRvxIGt9gDJpNw5oT5TtVMkLlt
         mmWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xmu0YTXtyZeGfogzERYuuAEn3dvm43TDyG1wb4ZPHJU=;
        b=Y4lTeObDnCkwy+hyypJLqZOPvrHluc3eYWLGQDED8114OAJv7BMrwCIdsTk3jBPcTp
         w1GALG0JizJM8qAdRTEkSttbYJysgjoBS6UJPa69xbUg2Ov2vpgT1r6t6O/JYNanlMQu
         TYvGFjs4jm67kISzAm8n2k4Kn5kcACjnc9bmIhNseGXw7LeT4cWloiTSJUQmLOxosG4s
         XRYjBZocggBzBWKYDebom6YCYQaYJ0hBv0XAIQrp2L/V0+a4Dwj8tSwrFKriXAN/Qztc
         W8XJG9kilbkqJtWlXNqbXvBrpVQIzKaivewHDcOSZVl+Fydvr4fSDZ+309JKmfDoO27t
         Y18g==
X-Gm-Message-State: AOAM532ioi5S+TbpdrRhYW5qBQZJy3WWlMNt20wlaa3A0wwriGemHM6Q
        hDMn+RBEvJ/bsCnAKFKCJ3zqbiQq7gztGnwdc7OG7Q==
X-Google-Smtp-Source: ABdhPJzHKBJwg8ZBMQicjfUmePTryZItjDGR+uGpneNmqIVWmFlgcbTTWDtCeichYL7rsEds6zdCJNyJnaJqOTHffeU=
X-Received: by 2002:aca:ecd3:: with SMTP id k202mr2617753oih.92.1595360308330;
 Tue, 21 Jul 2020 12:38:28 -0700 (PDT)
MIME-Version: 1.0
References: <20200720145030.1743325-1-dominick.grift@defensec.nl>
In-Reply-To: <20200720145030.1743325-1-dominick.grift@defensec.nl>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Tue, 21 Jul 2020 15:38:17 -0400
Message-ID: <CAEjxPJ49qjVJi1m-bJkaBg2ufx9xx5hPa_HupXbm-6eqXc_j5Q@mail.gmail.com>
Subject: Re: [SELinux-notebook PATCH] lsm_selinux: document
 genfs_seclabel_symlinks policy capability
To:     Dominick Grift <dominick.grift@defensec.nl>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Jul 20, 2020 at 10:53 AM Dominick Grift
<dominick.grift@defensec.nl> wrote:
>
> This was added with Linux 5.7 and SELinux 3.1
>
> Signed-off-by: Dominick Grift <dominick.grift@defensec.nl>
> ---
>  src/lsm_selinux.md | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/src/lsm_selinux.md b/src/lsm_selinux.md
> index a400c36..8e6f3ad 100644
> --- a/src/lsm_selinux.md
> +++ b/src/lsm_selinux.md
> @@ -676,6 +676,11 @@ interface, it is not recommended - use the **libselinux** or **libsepol** librar
>  <td>Enables the use of separate socket security classes for all network address families rather than the generic socket class.</td>
>  </tr>
>  <tr>
> +<td>genfs_seclabel_symlinks</td>
> +<td>-r--r--r--</td>
> +<td>Symlinks on kernel filesystems will receive contexts based on genfscon statements like directories and files.</td>
> +</tr>
> +<tr>

Maybe "Enables fine-grained labeling of symlinks in pseudo filesystems
based on genfscon rules."
