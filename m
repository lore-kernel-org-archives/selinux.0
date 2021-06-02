Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1754C47083
	for <selinux@archiver.kernel.org>; Wed,  2 Jun 2021 23:41:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A32AF613AE
	for <selinux@archiver.kernel.org>; Wed,  2 Jun 2021 23:41:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229727AbhFBXne (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 2 Jun 2021 19:43:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229533AbhFBXne (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 2 Jun 2021 19:43:34 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCBA8C06174A;
        Wed,  2 Jun 2021 16:41:36 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id h12-20020a17090aa88cb029016400fd8ad8so2745907pjq.3;
        Wed, 02 Jun 2021 16:41:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=+toArruJ3eRIR/A2mvRnWwBK2Vc1ZfxuTnObnbkQWeM=;
        b=nwIddzopGo1lXM/ErFpAIVU2mAP8V8VYQU0HtzxOig+9z3Yv+DPQAfqpSKQGIKcCbC
         6MLTdoAuVoSHFsNLlKRmSI5X5PreVkSLfZ5e8ktnm5chxyEC/KYiQhRWdtrLo9ebMkXz
         8KLYHBFZSChX0zEfbiCO9goGiOr6HZTc7sS/K9Tj9vlo/GfSbCx+eZGuh0woDFmd2eFe
         iOKq6Am1idc3kY2gYYNikNotA1jPmY6UpZVbr268E18e4b37N0w4pLKpMshGv4zMwAkn
         F2kqQYmkGXTSx/KTIWTZR8+PwPxJzwhd+gV5+iNzGm7asFY0xmk3H2yLZAoxnXSXyksP
         qFXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=+toArruJ3eRIR/A2mvRnWwBK2Vc1ZfxuTnObnbkQWeM=;
        b=T09ff5kWaVVmfi6FSTLiHrpNeTc/otusmEigd2AN61X1wI6hgruph7akCgX+TlR0ps
         uNdgLHpOu3mpCHHDZVmke3DfFmB5MslSDu8G7NwUPj5/L8N/rWUO8stt8k69+f2zz5Z2
         fwZJG2ly0LGyOS6gi9fKCu3bObeDoLUMAGXZ+5z+8++6WV/Fw4b/ToZOBnvsn7rp+u5+
         h4qg8e/t2j2fiq+3cAgeMeVOy23FBnE9yPu1R2CqfY4WtIWU1lVM+po26+e6EEPZGdpI
         6aXzCLJ5jso4T5PmW+mT3igNnX4BAMWw9QfE9gG5Ey0dD1vwkj4xaoN5C+92yfYaW9W4
         xD8w==
X-Gm-Message-State: AOAM533aEreJ46fzRELso/RAdTTJjM/dEnNF93uHs2Owp7jaReSSg84O
        gQjrvMf357SwlpviIRwF7M26cnkwq1FZ+jAQmKc=
X-Google-Smtp-Source: ABdhPJySLCX1G+ypM9S8wQTFySJ1G3j5In5iPS3hq4FOP+dvba0eMz3Cry3yzrELiQ3V9hCI0LCcH8Afrh32AV1WekQ=
X-Received: by 2002:a17:90b:33c3:: with SMTP id lk3mr8138470pjb.33.1622677296349;
 Wed, 02 Jun 2021 16:41:36 -0700 (PDT)
MIME-Version: 1.0
References: <20210602054802.GA984@raspberrypi> <CAHC9VhQdAt2EQqP3pQM=5TifTYuXxnU1QOvOT-aFaDaGiLLJXQ@mail.gmail.com>
In-Reply-To: <CAHC9VhQdAt2EQqP3pQM=5TifTYuXxnU1QOvOT-aFaDaGiLLJXQ@mail.gmail.com>
From:   Austin Kim <austindh.kim@gmail.com>
Date:   Thu, 3 Jun 2021 08:41:27 +0900
Message-ID: <CADLLry7D8OYStDAFsP4dFzS0fwV6bM2__ZEB2py+oca+R5Zuog@mail.gmail.com>
Subject: Re: [PATCH] selinux: remove duplicated LABEL_INITIALIZED check routine
To:     Paul Moore <paul@paul-moore.com>
Cc:     Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>, selinux@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        =?UTF-8?B?6rmA64+Z7ZiE?= <austin.kim@lge.com>,
        kernel-team@lge.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

2021=EB=85=84 6=EC=9B=94 2=EC=9D=BC (=EC=88=98) =EC=98=A4=ED=9B=84 11:32, P=
aul Moore <paul@paul-moore.com>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
> On Wed, Jun 2, 2021 at 1:48 AM Austin Kim <austindh.kim@gmail.com> wrote:
> >
> > The 'isec->initialized =3D=3D LABEL_INITIALIZED' is checked twice in a =
row,
> > since selinux was mainlined from Linux-2.6.12-rc2.
> >
> > Since 'isec->initialized' is protected using spin_lock(&isec->lock)
> > within various APIs, it had better remove first exceptional routine.
> >
> > With this commit, the code look simpler, easier to read and maintain.
> >
> > Signed-off-by: Austin Kim <austindh.kim@gmail.com>
> > ---
> >  security/selinux/hooks.c | 3 ---
> >  1 file changed, 3 deletions(-)
>
> This is a common pattern when dealing with lock protected variables:
> first check the variable before taking the lock (fast path) and if
> necessary take the lock and re-check the variable when we know we have
> exclusive access.
>
> In the majority of cases the SELinux inode initialization value goes
> from LABEL_INVALID to LABEL_INITIALIZED and stays there; while there
> is an invalidation function/hook that is used by some
> network/distributed filesystems, it isn't a common case to the best of
> my knowledge.  With that understanding it makes perfect sense to do a
> quick check to first see if the inode is initialized in
> inode_doinit_with_dentry() and return quickly, without taking a lock,
> if it is already initialized.  In the case where the inode has not
> been previously initialized, or has been invalidated, we take the
> spinlock to guarantee we are not racing with another task and re-check
> the initialization value to ensure that another task hasn't
> initialized the inode and act accordingly.
>
> The existing code is correct.
>

Understood, after looking into all routines related to 'isec->initialized' =
again
where 'isec->initialized' statement is not always protected
spin_lock(&isec->lock) during initialization progress.

Thanks for valuable feedback.

> --
> paul moore
> www.paul-moore.com
