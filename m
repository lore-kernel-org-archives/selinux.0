Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 961A2C43334
	for <selinux@archiver.kernel.org>; Fri, 10 Jun 2022 19:52:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350382AbiFJTwY (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 10 Jun 2022 15:52:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350389AbiFJTwW (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 10 Jun 2022 15:52:22 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9347A23CCF5
        for <selinux@vger.kernel.org>; Fri, 10 Jun 2022 12:52:19 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id a15so29290597wrh.2
        for <selinux@vger.kernel.org>; Fri, 10 Jun 2022 12:52:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=x81CyVir3pjK/ztFro5SKkqWERq2me/APMv8atNQetU=;
        b=y3UITEx0SBsS5g1x4ULHaE+KbdORxtcufS3I0QAPCfO7rtbWxyDxBifiPRqpMkPjus
         X0sbLUkmKgfJJrjCa5GcA1ZmTsM0uVG5p3FSerp8mgTJDqYzZ0Dd+0w8n+ZqqlZCMhFx
         gqR+XnYmehwlcDxCZ6WGP1BL5334b88RrOQmFrgNaFHzzk72zUGuTQKkEYAMCW4oqMak
         O7tp4NaIScT82Cf4oFocLCBqueORdOGv1sW98SblpZ+FIX3X+MMo/dv5P0BkfAeHVoSN
         CgYDNH6EWMFDwa3blv4+sp0n2zD09/4LQ4PJ1rb+i93BTauFioHs9iM2Nm1KavIWTw2q
         LRFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=x81CyVir3pjK/ztFro5SKkqWERq2me/APMv8atNQetU=;
        b=3CqbobpM7aF1SGsjwO73H7XBELLdO4J4zufnAZWBrD+Wud+sbDhaKtJRq18TEtuwMk
         /0YVs1ie1Rj4AYNv8/my5eViIzuQETuWVBAjhHzl+vVrw5pbBXj2qiPwmDYY92LxE/rS
         wkrw4cl6kopYwzvRpGyYWkYAAehOaSmlGY5yFUMBiMe5WSl2qTFkbpQgkT9wrVs0HJ2I
         lgausr9bq26AUJCC5tO4FM0syAdAa881D/HEezHcoyzNWZGxoiZ9hahLSWpgqpCTDohn
         mwAwGIeKjdFamkRGxH0t6EY+/QoJBPxS6/RfzgeR0jsEdI4RcXTOE265iRBgQDu2RBNU
         yPhQ==
X-Gm-Message-State: AOAM531Jlo3XA25nFxkNKq9K+d9Ya7zOrKghAs4GKSa/6PqqW2Edvqlz
        jnf4lWBh4IECSA9zOuxUpOmPP6NN4H/lBlodHbkx
X-Google-Smtp-Source: ABdhPJxM/c/b1H9ScCDVgTvg2CB9+5vuNvzZtf1lT8GASYKGK0T+lA3Wsnt70X/aY1aiYxbBDIvNYa/0m9HC35uYgEY=
X-Received: by 2002:a5d:64c7:0:b0:216:5021:687f with SMTP id
 f7-20020a5d64c7000000b002165021687fmr36417844wri.295.1654890738143; Fri, 10
 Jun 2022 12:52:18 -0700 (PDT)
MIME-Version: 1.0
References: <20220608223619.2287162-1-jolindner@gmx.de>
In-Reply-To: <20220608223619.2287162-1-jolindner@gmx.de>
From:   Paul Moore <paul@paul-moore.com>
Date:   Fri, 10 Jun 2022 15:52:07 -0400
Message-ID: <CAHC9VhRfM0_zA6TbZiOGo8nCSRoh-g_J3iZG14DemnXTxGRsoA@mail.gmail.com>
Subject: Re: [PATCH] selinux: fix typos in comments
To:     Jonas Lindner <jolindner@gmx.de>
Cc:     stephen.smalley.work@gmail.com, eparis@parisplace.org,
        trivial@kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>,
        selinux@vger.kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Jun 8, 2022 at 6:37 PM Jonas Lindner <jolindner@gmx.de> wrote:
>
> selinux: fix typos in comments
> Signed-off-by: Jonas Lindner <jolindner@gmx.de>
> ---
>  security/selinux/hooks.c         | 4 ++--
>  security/selinux/include/audit.h | 2 +-
>  2 files changed, 3 insertions(+), 3 deletions(-)

Merged into selinux/next (with the duplicated subject line removed), thanks!

-- 
paul-moore.com
