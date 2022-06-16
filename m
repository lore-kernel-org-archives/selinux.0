Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A229C433EF
	for <selinux@archiver.kernel.org>; Thu, 16 Jun 2022 21:47:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378619AbiFPVr6 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 16 Jun 2022 17:47:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229901AbiFPVr6 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 16 Jun 2022 17:47:58 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1564E12A82
        for <selinux@vger.kernel.org>; Thu, 16 Jun 2022 14:47:57 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id m32-20020a05600c3b2000b0039756bb41f2so1495014wms.3
        for <selinux@vger.kernel.org>; Thu, 16 Jun 2022 14:47:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=c2iwmSxW/zurQ/hzT7KH/yGFMflQX3JQ4MQjt4RoS5Q=;
        b=3jlmS1Q08jetad3Cq6sFUbIV8WdH7mMZvOq8U5wJJ7H96dFhSZbMVHiwKtKALLYndh
         qMrFZtNw31+aketY5Zeg0UbPHW76KGatTbUp/y0QoqOIfMuDQC+3g1crwl5isyUfULoG
         /KjYyPYBbORY6WeOL2rZWpkq0cgQACHm4HsR9RnfRCjOlbWmCmgNXsUhqzdzFNDi1+zd
         vFGpg5xeaI9Y9mAKRJSgYOfojgdmO+vztA56d43eIXcJvDdUchvO64bWL5YMtXgaFARy
         kaNUXJSaT2u0uyqwEuJ6urLDCunq/l47Lda3hsyh7NLjSB158GSlQ90lhT+JYm/WAu0R
         7h8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=c2iwmSxW/zurQ/hzT7KH/yGFMflQX3JQ4MQjt4RoS5Q=;
        b=Ve/1mUdbDDQNYt9vCIOdyLaDozebN0jLwp/+pNC1hSxczl3qmPTdx8ped2suEgV4tQ
         eblLeDjxBYOfvFr+c/zOJ9Y1PEI96TWjUbWBRUI3PrukQJkUm53Zhc28F7vsg1ID3rhz
         y5PoecTDutxC+wTMi/lIJliNtj88dnqRUB1iARFms6xFw1TM+mI2bd7tcaMSaSSmi2cx
         VerxQsaKSz9uFCSP8qOykY1sXRfph6WtvY8YXl619wpK7zjSsoaMc+RJ+LABdLuBGkmK
         nA4pp9Oukw3qnzx+E9g2ZGnSvPnCM/UwTi2jgg+gzGE13reJju7r/PSegvCeBnnuI3HQ
         hZDQ==
X-Gm-Message-State: AJIora/idOQ7Vkbbs0yf4iaOkVq6tpZ4lNiRQcANANfJNrqdmhlWrEGD
        5JdtgPmv1uMhgZa/Y5jna2DAa50Lzcd0nW/DIgHo
X-Google-Smtp-Source: AGRyM1tTWflieB4dGBcrTUwLQ2Prn2DZlL6AIl1FW76esmDNIyRNnJ68SimZFRsAgjRj8RYZq6vRPIb81kIerI/aOII=
X-Received: by 2002:a05:600c:4f84:b0:39c:9897:5295 with SMTP id
 n4-20020a05600c4f8400b0039c98975295mr6904134wmq.158.1655416075578; Thu, 16
 Jun 2022 14:47:55 -0700 (PDT)
MIME-Version: 1.0
References: <CAHC9VhQa-L-_F4UdMekqvyF714xhEerVQzc9rPvuwTQJtmMd8A@mail.gmail.com>
In-Reply-To: <CAHC9VhQa-L-_F4UdMekqvyF714xhEerVQzc9rPvuwTQJtmMd8A@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 16 Jun 2022 17:47:44 -0400
Message-ID: <CAHC9VhQFi51nuyMXGaJcYcyQT89tMcizSEVGf39hDaf89QffNA@mail.gmail.com>
Subject: Re: [GIT PULL] SELinux fixes for v5.19 (#1)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     selinux@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Jun 16, 2022 at 5:44 PM Paul Moore <paul@paul-moore.com> wrote:
>
> Linus,
>
> A single SELinux patch to fix memory leaks when mounting filesystems
> with SELinux mount options.  Please merge for v5.19.
>
> Thanks,
> -Paul
>
> --
> The following changes since commit b13baccc3850ca8b8cccbf8ed9912dbaa0fdf7=
f3:
>
>  Linux 5.19-rc2 (2022-06-12 16:11:37 -0700)
>
> are available in the Git repository at:
>
>  git://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/audit.git
>    selinux-pr-20220616

... that is obviously not the SELinux tree, although it does somewhat
hint that you're also going to see an audit PR in just a moment too.
Here is the proper SELinux tree:

git://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/selinux.git
  selinux-pr-20220616

Sorry for the mixup.

> for you to fetch changes up to cad140d00899e7a9cb6fe93b282051df589e671c:
>
>  selinux: free contexts previously transferred in selinux_add_opt()
>    (2022-06-15 21:20:45 -0400)
>
> ----------------------------------------------------------------
> selinux/stable-5.19 PR 20220616
>
> ----------------------------------------------------------------
> Christian G=C3=B6ttsche (1):
>      selinux: free contexts previously transferred in selinux_add_opt()
>
> security/selinux/hooks.c | 11 ++++-------
> 1 file changed, 4 insertions(+), 7 deletions(-)

--=20
paul-moore.com
