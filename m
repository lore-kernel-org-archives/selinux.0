Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56567C433B4
	for <selinux@archiver.kernel.org>; Tue, 27 Apr 2021 14:10:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2C53061001
	for <selinux@archiver.kernel.org>; Tue, 27 Apr 2021 14:10:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236269AbhD0OLC (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 27 Apr 2021 10:11:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236226AbhD0OLC (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 27 Apr 2021 10:11:02 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74680C061574
        for <selinux@vger.kernel.org>; Tue, 27 Apr 2021 07:10:17 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id n21so13507460eji.1
        for <selinux@vger.kernel.org>; Tue, 27 Apr 2021 07:10:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=fsUKcENovv6F7snSfbw4AkJEI8bc+D0BVFwGl2051cw=;
        b=nOMWs7SycB8eUAiGxxTjzwrDZnyicSQTd0qExLGRnf1cafCz/CcjYKf8hxOKXy4szA
         FuUFrkLYq8TOXpbO6wUwQl1EM6acNGOIBPg5DEh71EaKw0c4YuvywyPCgFzKgGFOhFOy
         WkAle+FftPnb9EECmbjz0b3gf01Dl+WgTGsZR2xgR+P4kdMZ3y6iaNFq+MzStJhYlq1d
         QkwOH8Jy3mH1U6BAPitaTYeBnsmfPMajV2JFNLOG3gFCIXMQDiHAT/R9L89uj/wXWXXO
         B2GKXRxiAfoUFuxrFTlhMaqHCUsR3FJfXfMTWc/mj6QV3fvx+NzlzGsI1xQRu6PYfPTb
         Tdsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=fsUKcENovv6F7snSfbw4AkJEI8bc+D0BVFwGl2051cw=;
        b=Da1YVb7s3/L2HqTMIxo4ylROwtPrI0lZXx4nm8Tmq5bcgyMPTR73CtndcFdPP+g4TE
         9+kjDN9CedWWOM2iXdgrlCRnMwUlqslv+y5Yn0CKqqomFlvJeYo6pfSOFZ2MJlkNjoPz
         k2mCtxWD44pMXIseKsB0au+3soI8g1kW1KNerf8CFmz6lgU4jEremIbz6d+WBeyYxxTE
         o7gBeNh1ccP0+mMi9L0ydbNTFb7IC4jSltz4KjG8iBS6mrS5woHfmLmLs5048Kadgq2J
         Y8LUCqvcOsPDR3Nb4FFA8TW4OsXN8LIUns/Zg871Y7PIwJ7hA7Emb+G3LAs2CLLCd5Vt
         7Wyg==
X-Gm-Message-State: AOAM532XciSlfyrYvXDGtvwh/bT7QkZh+9ADs0KuwCRz6xcPwrIPbZYq
        tedPdUAM8Cb/QTmpfcJnwR26ifSHaued+qrO11CuXzNFgw==
X-Google-Smtp-Source: ABdhPJwrkNz0r+O2D6yizNCrsTYOf979HUZXElLXT+UoNyAHnK+prcr6ctW59hu22/feup6vQAUVitk7tpkPU9aq1Do=
X-Received: by 2002:a17:906:a006:: with SMTP id p6mr24118748ejy.350.1619532615025;
 Tue, 27 Apr 2021 07:10:15 -0700 (PDT)
MIME-Version: 1.0
References: <20210413122508.24745-1-cgzones@googlemail.com>
In-Reply-To: <20210413122508.24745-1-cgzones@googlemail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 27 Apr 2021 10:10:03 -0400
Message-ID: <CAHC9VhSomhz2O6ijJgFnP+1zF54nA8=86Xn5t+tj+k6_121vAQ@mail.gmail.com>
Subject: Re: [RFC SHADOW PATCH 0/7] SELinux modernizations
To:     selinux@vger.kernel.org
Cc:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Apr 13, 2021 at 8:25 AM Christian G=C3=B6ttsche
<cgzones@googlemail.com> wrote:
>
> Modernize SELinux parts of shadow
> (https://github.com/shadow-maint/shadow).
>
> Upstream pull request: https://github.com/shadow-maint/shadow/pull/323
>
>
> Christian G=C3=B6ttsche (7):
>   struct commonio_db[selinux]: do not use deprecated type
>     security_context_t
>   vipw[selinux]: do not use deprecated typedef and skip context
>     translation
>   selinux.c: do not use deprecated typedef and skip context translation
>   selinux.c:reset_selinux_file_context(): do not fail in permissive mode
>   selinux.c: use modern selabel interface instead of deprecated
>     matchpathcon
>   set_selinux_file_context(): prepare context for actual file type
>   selinux: only open selabel database once
>
>  lib/commonio.c    |  4 ++--
>  lib/commonio.h    |  6 +----
>  lib/prototypes.h  |  2 +-
>  lib/selinux.c     | 60 ++++++++++++++++++++++++++++++++---------------
>  libmisc/copydir.c |  8 +++----
>  src/useradd.c     |  7 ++++--
>  src/userdel.c     |  3 +++
>  src/usermod.c     |  3 +++
>  src/vipw.c        | 10 ++++----
>  9 files changed, 65 insertions(+), 38 deletions(-)

SELinux userspace folks, can someone give this patchset a quick look
to make sure it is sane?  A little birdie tells me this might get
merged soonish and I don't trust my understanding of the current
SELinux userspace to do a good enough job making sure these patches do
The Right Things :)

--=20
paul moore
www.paul-moore.com
