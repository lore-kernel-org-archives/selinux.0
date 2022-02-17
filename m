Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D5AAC433EF
	for <selinux@archiver.kernel.org>; Thu, 17 Feb 2022 22:27:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343859AbiBQW1l (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 17 Feb 2022 17:27:41 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:52434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343857AbiBQW1l (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 17 Feb 2022 17:27:41 -0500
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6190355BFF
        for <selinux@vger.kernel.org>; Thu, 17 Feb 2022 14:27:25 -0800 (PST)
Received: by mail-ej1-x62b.google.com with SMTP id lw4so10511587ejb.12
        for <selinux@vger.kernel.org>; Thu, 17 Feb 2022 14:27:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=dOUplOtF52+4ptESkYuYLuLN7/aJDzskLaG/dPuOL2E=;
        b=tyz6Qp+Fmi/7yVep0CvJKOEK/6J0acEN9GmzNqyRKbK2knKpyhT6G8l7dWebO8IaQa
         wWiUBQHDDMnNcsTE7k9Kmqgd0ZRqDJABDaRdOMtNv2hFZN3pWjR4cy+nb7VVDnXMvo/s
         sGkXQPMvKPeLKWiiMp4kTMxJna2RVn0i+n6aO+Y4WSlVusRULfUu5hoDMLCPNdwZJn/I
         xyxrkN3LMx1/nFu9AlLAStJTfB4+DkmhnJ8mRpcM3+dYj51+DBYdayzCGH/Wed4E+DPF
         PSAFM708zXP+Z8+3Tiz27TYsLXl2QzpFPJQLsXbp28sL0+A48U+dye2W0LGFtX7pcDsW
         eE3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=dOUplOtF52+4ptESkYuYLuLN7/aJDzskLaG/dPuOL2E=;
        b=RN5b8H1N4UQSPSvIL4T3onPpaKjs0K8d+0WaO5DxDsmLfpkSaQG8GBZpF46w6H8sU8
         b3EXWnGizDz1NMybiMyzY2vUZsQSldnoypwbVY2H9nZP5CWdZThf43sdL3VEeftE9khh
         oHCCcwy8F8WFA/hojiG7rE1yzj6mziayloRd8EY5TvrBlu22uMk4pg+jyDbNq/1Sfqel
         KirVWolcN1wTO64sWD6OM4ibmlZBM4YhqnHU5Quv5oOsvyqrGsyUyUg0Pj6djB9Lfjf1
         wMrVUDpBztZaE4buMIbfWMQ47Kt9j736dgxPYffo1adVmTC5fpPY2UywkIi8kb6zHO/1
         tDVQ==
X-Gm-Message-State: AOAM533U9LyudiQa3dPIDCLLs+ED7w7BfoHTiQQUTi5G/ycVcQL4NuNt
        D7xjMvh0h11SUGAUGdewatPi/tDWS9KpBvKyBjL424dkEU37
X-Google-Smtp-Source: ABdhPJw7EpGj8PRHM7AeikiX1WV4vhxdoltD+BcJxw6RJiTtevXzBj3yHDvAaHmjFd00igt1PmgSjgfwYHjlgW5puGE=
X-Received: by 2002:a17:907:216f:b0:6ce:d85f:35cf with SMTP id
 rl15-20020a170907216f00b006ced85f35cfmr3988130ejb.517.1645136843907; Thu, 17
 Feb 2022 14:27:23 -0800 (PST)
MIME-Version: 1.0
References: <20220217141858.71281-1-cgzones@googlemail.com>
In-Reply-To: <20220217141858.71281-1-cgzones@googlemail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 17 Feb 2022 17:27:12 -0500
Message-ID: <CAHC9VhRGtkiOMHvjPaM170FJu3kiVZq30n389_2Gg=QgOV=fUA@mail.gmail.com>
Subject: Re: [PATCH] security: declare member holding string literal const
To:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     selinux@vger.kernel.org, James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Xin Long <lucien.xin@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Ondrej Mosnacek <omosnace@redhat.com>,
        =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@linux.microsoft.com>,
        Todd Kjos <tkjos@google.com>,
        Olga Kornievskaia <kolga@netapp.com>,
        linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Feb 17, 2022 at 9:19 AM Christian G=C3=B6ttsche
<cgzones@googlemail.com> wrote:
>
> The struct security_hook_list member lsm is assigned in
> security_add_hooks() with string literals passed from the individual
> security modules.  Declare the function parameter and the struct member
> const to signal their immutability.
>
> Reported by Clang [-Wwrite-strings]:
>
>     security/selinux/hooks.c:7388:63: error: passing 'const char [8]' to =
parameter of type 'char *' discards qualifiers [-Werror,-Wincompatible-poin=
ter-types-discards-qualifiers]
>             security_add_hooks(selinux_hooks, ARRAY_SIZE(selinux_hooks), =
selinux);
>                                                                          =
^~~~~~~~~
>     ./include/linux/lsm_hooks.h:1629:11: note: passing argument to parame=
ter 'lsm' here
>                                     char *lsm);
>                                           ^
>
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
> ---
>  include/linux/lsm_hooks.h | 4 ++--
>  security/security.c       | 2 +-
>  2 files changed, 3 insertions(+), 3 deletions(-)

Thanks Christian.

Reviewed-by: Paul Moore <paul@paul-moore.com>

--=20
paul-moore.com
