Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D123C4332F
	for <selinux@archiver.kernel.org>; Fri, 16 Dec 2022 15:25:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229475AbiLPPZV (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 16 Dec 2022 10:25:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231401AbiLPPZM (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 16 Dec 2022 10:25:12 -0500
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB0FC62EA4
        for <selinux@vger.kernel.org>; Fri, 16 Dec 2022 07:25:08 -0800 (PST)
Received: by mail-yb1-xb2c.google.com with SMTP id y135so2683181yby.12
        for <selinux@vger.kernel.org>; Fri, 16 Dec 2022 07:25:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DSmNudrHyffMzMgcfu9qmkgp5+tuikp6064PMmmHEYg=;
        b=EUsUOwRMx2I1z2R6zzRdn96pA5eppesTy/TRg1ElVJ3jz2wjh3N5UKprM4d8ZTEyY9
         2F49mwanVI1By5gAtz8QYiHGGixivllM0LlpbWBtxxkxltbNxHNT3xMfH4H+EffXP977
         xsSPDiyTPd+v1/51K0YHRa+jDCaKmRDg4yC/rdVAYvsUwwf6NR/zQsGPJ4ASeqGEodKv
         1l67YOJe730NT8ztA46vNPLXk5bpGh/vER9sr+cCR93P7sKACl7cCMngUVMHNa9EdoVU
         hrcICT0ltPcXQ3gMFxAobrTF4ZbZChN+Z7HjyjNtW8XtiHyTrbFfg80GwFGPe5xsuSRo
         mhUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DSmNudrHyffMzMgcfu9qmkgp5+tuikp6064PMmmHEYg=;
        b=cNyofzMNBJlXt1IEO1ZZjVxdFpi3c4UXa5t3hyAj9afIvaarztLKdEct/LYFtqSriy
         ot7Frn15zFnw4bd5q/vtuNKDzO+QhctGxVVINYPCpEcGEEO4O8V5WGtF9tKAFTHclOYL
         YEKm0gMYO8qtWs0c2O1dU9IpDVTs8vsYLo4cInilm0zAJGZxHO5HUot+hCieqpiWxcIx
         9zftoI76MgXHvuzsCGwZoOL3z07fmNdILG4bkMQIBQo/uaNqMZZk6yLz2ulCHRhiuyEa
         2VUZS9eE/yk5EeKgupZCjy+/XddPp7IaMQbJwoYmmG3uJPXem0E8j8phzaIGaI+U75MB
         uccA==
X-Gm-Message-State: ANoB5pm3qho9Ghf65YviaT6Vy6AaTGkU6YH3dKJidxElZ/yE4mcVshp6
        /Qrh5aIc9t98vBHbapnikqNOgtgi3V3ZH3H/ynozmg==
X-Google-Smtp-Source: AA0mqf602YYPXabG9IC11VoZUdrowcXC6vXkIbNP+V/VNDHABsH9Ui1qBrv0DMcT7RtCUCEgXBL7Cd3zDu9Tq28bLC4=
X-Received: by 2002:a25:d197:0:b0:703:4bfd:3986 with SMTP id
 i145-20020a25d197000000b007034bfd3986mr14573427ybg.407.1671204307562; Fri, 16
 Dec 2022 07:25:07 -0800 (PST)
MIME-Version: 1.0
References: <114ee67a-3349-454e-9387-40f1f29cb822@me.com> <CANn89iJ42uTD+vDqzi_oPj2rPY=kxMSgtdrRd3G-xHozyi9apQ@mail.gmail.com>
In-Reply-To: <CANn89iJ42uTD+vDqzi_oPj2rPY=kxMSgtdrRd3G-xHozyi9apQ@mail.gmail.com>
From:   Eric Dumazet <edumazet@google.com>
Date:   Fri, 16 Dec 2022 16:24:56 +0100
Message-ID: <CANn89i+fjP_N5_oUTZr2BECbBhV7x8HZNMs_C=JAFE5Sf1beVw@mail.gmail.com>
Subject: Re: memory leak in inet_create
To:     =?UTF-8?B?7J207LC97ZeM?= <darklight2357@icloud.com>
Cc:     "security@kernel.org" <security@kernel.org>,
        selinux@vger.kernel.org, paul@paul-moore.com,
        stephen.smalley.work@gmail.com, eparis@parisplace.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Dec 16, 2022 at 9:55 AM Eric Dumazet <edumazet@google.com> wrote:
>
> On Fri, Dec 16, 2022 at 9:46 AM =EC=9D=B4=EC=B0=BD=ED=97=8C <darklight235=
7@icloud.com> wrote:
> >
> > Hello, I am =E2=80=9CChangheon Lee" concerned with kernel security.
> >
> >
> > A "memory leak in inet_create" was reported in Syzkaller targeting Linu=
x kernel Version 6.1 on December 15, 2022 at 18:36 (KST).
> >
> >
> > I received an email saying that an inappropriate HTML form was inserted=
 into the email and there was a problem with readability, so we are sending=
 it again.
> >
> >
> > The environment in which the bug was detected is as follows.
>
> I will take a look, thanks.

I suspect bug was added in

commit 24bcbe1cc69fa52dc4f7b5b2456678ed464724d8
Author: Jakub Kicinski <kuba@kernel.org>
Date:   Fri Oct 15 06:37:39 2021 -0700

    net: stream: don't purge sk_error_queue in sk_stream_kill_queues()

I am working on a fix (after making sure the cited commit is indeed
the bug origin)
