Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1941BEB64DC
	for <selinux@archiver.kernel.org>; Tue, 18 Jul 2023 22:42:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229667AbjGRWm5 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 18 Jul 2023 18:42:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229562AbjGRWm4 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 18 Jul 2023 18:42:56 -0400
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F08D2198E
        for <selinux@vger.kernel.org>; Tue, 18 Jul 2023 15:42:55 -0700 (PDT)
Received: by mail-qt1-x82c.google.com with SMTP id d75a77b69052e-403a1d7d60fso48008961cf.1
        for <selinux@vger.kernel.org>; Tue, 18 Jul 2023 15:42:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1689720175; x=1692312175;
        h=in-reply-to:references:subject:cc:to:from:message-id:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=kZRLranKrVo7WxofLALhWsASs34zsVIVXA2Zl8u+PXA=;
        b=PYjwS3EyM04wlSj3yTGPKpCfaY5dPfFCVFA66Cxj3CVB/Is5ZwDvti8ZqozfOc6w3r
         houhDNitjRTQkLfvJgLO9DZWFvB6tucA7qcdrCCCganHfforNyNgkf5IUVo3lX9AlTyi
         dNP2Io3b/1KRK2xlzjiLtV95w+qyL71vaIGui1iDS2G4/sKY5XcfzQnno+vKrh4tpaOB
         rRNAYQrrHquw2GVS8o311WSGFdRhP/mgF2Lrgea4lD7BmdyblF9ciQPvqS80quWCIoyK
         QXkymXOuU6tev1tDlyGcHZqUlb8uqx3IiC7aVZilcYiFlpzouQ6EDLaLv/haWKCkYQQ9
         YXvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689720175; x=1692312175;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kZRLranKrVo7WxofLALhWsASs34zsVIVXA2Zl8u+PXA=;
        b=EJv3b4CCyfsOsmbDBI21OteFSd4jg0Og6qz9DR6Af+252Oo4oeRBl4h2YUNJ5/VtUI
         pfUIN8ku54zSyvnBzQxZLL4cLzbAxIvGsWzQsk+2d3nfGeaQRfBaTmXI6ukgaXkKzaqC
         SxVw6jk/yhcTSEKkIk9jIsgoDRROXOl7K9YsYYSQodP48Th5E6sfQIFP0ID3+GPiFAUD
         VILkNIRi9HZ4vE9PqrqBJtTPdvoKR1dCBaHrJSusgHu2nVz7OhiG1VepH+5oiLcFYfME
         edoMKWL6DzVS3LqRPgJUf1SJctDkFVuWsNtvCjHM7zu3E7WEf+EyBQmIdJlRmmPnVVfc
         Z/Uw==
X-Gm-Message-State: ABy/qLYtuoGUxaBET3LvJ11qtJgkmkIgmpytWhbDGELzksbJYpdp/fPZ
        XEI2kdYgsBE9y4pxuZsQ/t9m
X-Google-Smtp-Source: APBJJlGxlFDT3MtOk5q2Rk9iM/eG74O0ed79whpXXA2mX/c2yeVkl8q4yQQtgnTrWD7/1N+JiiEXZg==
X-Received: by 2002:a05:622a:1646:b0:403:df34:9461 with SMTP id y6-20020a05622a164600b00403df349461mr15939444qtj.14.1689720175148;
        Tue, 18 Jul 2023 15:42:55 -0700 (PDT)
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with ESMTPSA id b18-20020ac85412000000b00403af2cf825sm942265qtq.34.2023.07.18.15.42.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jul 2023 15:42:54 -0700 (PDT)
Date:   Tue, 18 Jul 2023 18:42:54 -0400
Message-ID: <f122cc40723fd29694e8d1ddc773135f.paul@paul-moore.com>
From:   Paul Moore <paul@paul-moore.com>
To:     Stephen Smalley <stephen.smalley.work@gmail.com>,
        selinux@vger.kernel.org
Cc:     omosnace@redhat.com,
        Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: Re: [PATCH] selinux: de-brand SELinux
References: <20230718171335.21591-1-stephen.smalley.work@gmail.com>
In-Reply-To: <20230718171335.21591-1-stephen.smalley.work@gmail.com>
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Jul 18, 2023 Stephen Smalley <stephen.smalley.work@gmail.com> wrote:
> 
> Change "NSA SELinux" to just "SELinux" in Kconfig help text and
> comments. While NSA was the original primary developer and continues to
> help maintain SELinux, SELinux has long since transitioned to a wide
> community of developers and maintainers. SELinux has been part of the
> mainline Linux kernel for nearly 20 years now [1] and has received
> contributions from many individuals and organizations.
> 
> [1] https://lore.kernel.org/lkml/Pine.LNX.4.44.0308082228470.1852-100000@home.osdl.org/
> 
> Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> ---
>  security/selinux/Kconfig          | 16 ++++++++--------
>  security/selinux/hooks.c          |  2 +-
>  security/selinux/include/objsec.h |  2 +-
>  security/selinux/xfrm.c           |  2 +-
>  4 files changed, 11 insertions(+), 11 deletions(-)

Merged into selinux/next, thanks!

--
paul-moore.com
