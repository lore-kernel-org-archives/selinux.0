Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A15B2C433F5
	for <selinux@archiver.kernel.org>; Tue,  3 May 2022 18:09:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241011AbiECSMg (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 3 May 2022 14:12:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233575AbiECSMf (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 3 May 2022 14:12:35 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C7443EB80
        for <selinux@vger.kernel.org>; Tue,  3 May 2022 11:09:02 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id p189so10322942wmp.3
        for <selinux@vger.kernel.org>; Tue, 03 May 2022 11:09:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=FGUxPrzjI78BA1FDy50uQWcrTLirYMlLkUJ+7H09hDo=;
        b=DOkMy16hOEa5G+NiABpSRJI/5qnS/23Fgla038FCGDOWawxG4ToWbvMhqHO4sQYZem
         hvfVJZJbM+0LGlsFNBWMnrLa2N4B6Ci2s+3UP3iWmb0RrbDGA6glNNed8O2aQV6zhkAg
         VpFy6uUb+BUWS4gm/zinLbPtQEGd4CBX3lUasRwwAHWMuWUxuUr40Gre44slJjotkpz0
         m1dqBP3uY+3gtiWq4xGX6VZunGu040EXRhbhVzgXAeBOCoVgUftlg7kjbjw7dWHaAkEI
         EhtKavYBVAGX15veMloA4EQs+36hyBanxTLWEMqwkHwhB1Nw5mH7egvHhvoJvCJCcb1c
         2TgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=FGUxPrzjI78BA1FDy50uQWcrTLirYMlLkUJ+7H09hDo=;
        b=xyferUsqu8VWTU2K6OboYI5c6zbqforMK699g7pmUN4vhU91yEgwxABiTvYDCts8Sn
         MePjY1386vJuEPb6pnBqUa3YeQcGvEMFLv8oAFYiC9Y2RWlhCXx1JqwxQD6S1g2oQxvE
         /jS8DwoVF36rfqZSlW4oCpz+LDjpgMvW8bCABVEmzANBaUa4jgfGiIukGjviB/DeCHT2
         vzQ7Y8+dse4cPCtF0Y8XCqwKR7uJ2TQjoLuJEW9wVW05iT3Jy7ZqpbV9g6NVegGa/N4H
         yk9F0Qiu4d+cyJO8VT1xWhsglfa7rYsRECK/0izn4+RHPMqvfjNVrvsH27E2mqjMNkfk
         Nx7A==
X-Gm-Message-State: AOAM530Sh2ol2qm1WyowiXswzKJEpFH6Lpk6GVKloRR12mjw/QATgm4w
        fdCi5BdZk81lywqRJTMtL7rc/6s9j2aXUw13bv+G
X-Google-Smtp-Source: ABdhPJz8V6A4NLi3gByFCmDPUvIX7h8XeCZUuGOAA7TrZf7o8M1QoEBfUcYVZUrLW79Qy+wom7w0dKIuYr2li6iTM6E=
X-Received: by 2002:a1c:f009:0:b0:387:6fea:8ebc with SMTP id
 a9-20020a1cf009000000b003876fea8ebcmr4504416wmb.84.1651601340763; Tue, 03 May
 2022 11:09:00 -0700 (PDT)
MIME-Version: 1.0
References: <20220502141052.34413-1-cgzones@googlemail.com>
In-Reply-To: <20220502141052.34413-1-cgzones@googlemail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 3 May 2022 14:08:50 -0400
Message-ID: <CAHC9VhQEAcwWvEfV_-4cO6ZRzjGs_7cEpKi3jTXF1HJ_vp16iQ@mail.gmail.com>
Subject: Re: [PATCH] selinux: avoid extra semicolon
To:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     selinux@vger.kernel.org,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Ondrej Mosnacek <omosnace@redhat.com>,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, May 2, 2022 at 10:10 AM Christian G=C3=B6ttsche
<cgzones@googlemail.com> wrote:
>
> Wrap macro into `do { } while (0)` to avoid Clang emitting warnings
> about extra semicolons.
> Similar to userspace commit
> https://github.com/SELinuxProject/selinux/commit/9d85aa60d12e468e7fd510c2=
b5475b5299b71622
>
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
> ---
>  security/selinux/ss/avtab.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Merged into selinux/next with some whitespace tweaks.

--=20
paul-moore.com
