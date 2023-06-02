Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8E2CC7EE24
	for <selinux@archiver.kernel.org>; Fri,  2 Jun 2023 14:31:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235804AbjFBOb4 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 2 Jun 2023 10:31:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235843AbjFBObx (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 2 Jun 2023 10:31:53 -0400
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com [IPv6:2607:f8b0:4864:20::112a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 621951A7
        for <selinux@vger.kernel.org>; Fri,  2 Jun 2023 07:31:52 -0700 (PDT)
Received: by mail-yw1-x112a.google.com with SMTP id 00721157ae682-565ba53f434so21265027b3.3
        for <selinux@vger.kernel.org>; Fri, 02 Jun 2023 07:31:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1685716311; x=1688308311;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=izFVSUnYkz4JCHVKr05DqHuKoM0iBLVYSPHiqkO1hVg=;
        b=WTLf9TyE2fcZ8M7Dra4jwxMFe/R+rdChWBuQfgF2XNJ4YNnmSRGrKHOQPjZruUFDTX
         Wm/ydEsEXGFeIOLIdD9ix1malc+9eOe3iLP5iW01jB75upqM9IUodsxlLOjkiOIVjbmX
         C0uU2qLZS+bUw1r6lvkrcUYaLAfaWXir8V8pazQtw5ZeM0AFxKp33eFo1cCm3Ha5KgbY
         CGAf1+JwlKdobRpQsgImq30Wiboff/SRVqV6Ry3qakf0BOlLzGWxcTwkYZ6sqJ+8K7Qy
         L5QlC0FjPVv170xHtYfEPEeq1+uY/pO4u4jS8PjzgXIoCVS6W3jLi31aV6gVRW1s/wT6
         5ekQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685716311; x=1688308311;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=izFVSUnYkz4JCHVKr05DqHuKoM0iBLVYSPHiqkO1hVg=;
        b=QQyT77pxdpsJnvz2QQ10gKjuIyfXCmkqZGYoUFii4A5A/XJOyU7Apx0o408epNXf/d
         EvlOszdYajhPc39ZDT8jE8qNRA5QTfyELyLgcWgPbR6rqgvgFhW/7mp2L4WcNUN7t+aQ
         hHbf8ni/HmRx6Pz7YBmeByR2LhaqiTcMoqY6D9SYD9p9vjqueoDG2xRERPLY2AGAwfB4
         zVxZ8TzYKLpthhctWzZyQyVCJM9YU7Dz5yk0Ucep0N6e+aRWyakwksuLWdExdDsWmcFI
         zEVfYl/eiMpYLOti9DH8Ohm3oZDMZLVw+skSmTA1/M81fC8CzOPwewOLrqt0d3LN9Xog
         AJyg==
X-Gm-Message-State: AC+VfDwxX/a3hFzQlrR3tKnCMwa9Y3Rt7aE2f6+pP/RFzcadjrOor7P7
        MPnZ3KbmuYuLjHdcxE9LB0aD8DUCWkDwRbO/kvss
X-Google-Smtp-Source: ACHHUZ6mTxV3XhBYQpP5M8X4c6jCnmvE3xWJiaLT/qwk1IkO1SUK/707ds9LqqU4h8MYCY8x6nIl0v3n/KUTm0Ci/Yo=
X-Received: by 2002:a0d:d103:0:b0:561:18c6:528c with SMTP id
 t3-20020a0dd103000000b0056118c6528cmr129167ywd.30.1685716311499; Fri, 02 Jun
 2023 07:31:51 -0700 (PDT)
MIME-Version: 1.0
References: <20230601180643.211112-1-paul@paul-moore.com> <cf70b968-bc90-a6e3-153a-013be936a1a9@criteo.com>
In-Reply-To: <cf70b968-bc90-a6e3-153a-013be936a1a9@criteo.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Fri, 2 Jun 2023 10:31:40 -0400
Message-ID: <CAHC9VhTU4u4k3vdTphA1_hMZCPDVwfMtHkPw=K+xLgqQ9G8hkA@mail.gmail.com>
Subject: Re: [PATCH] selinux: don't use make's grouped targets feature yet
To:     Erwan Velu <e.velu@criteo.com>
Cc:     selinux@vger.kernel.org, Luiz Capitulino <luizcap@amazon.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Jun 2, 2023 at 4:35=E2=80=AFAM Erwan Velu <e.velu@criteo.com> wrote=
:
> Le 01/06/2023 =C3=A0 20:06, Paul Moore a =C3=A9crit :
> > The Linux Kernel currently only requires make v3.82 while the grouped
> > target functionality requires make v4.3.  Removed the grouped target
> > introduced in 4ce1f694eb5d ("selinux: ensure av_permissions.h is
> > built when needed") as well as the multiple header file targets in
> > the make rule.  This effectively reverts the problem commit.
> >
> > We will revisit this change when make >=3D 4.3 is required by the rest
> > of the kernel.
> >
> > Cc: stable@vger.kernel.org
> > Fixes: 4ce1f694eb5d ("selinux: ensure av_permissions.h is built when ne=
eded")
> > Reported-by: Erwan Velu <e.velu@criteo.com>
> > Reported-by: Luiz Capitulino <luizcap@amazon.com>
> > Signed-off-by: Paul Moore <paul@paul-moore.com>
>
> Thanks for the patch & the quick exchange we had around this issue.

Thanks for your help with identification and testing!  I just saw that
Linus merged this into his tree, so I would expect this to start
making its way to the -stable trees soon.

--=20
paul-moore.com
