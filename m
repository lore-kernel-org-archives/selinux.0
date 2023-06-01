Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED453C7EE23
	for <selinux@archiver.kernel.org>; Thu,  1 Jun 2023 18:13:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229741AbjFASNo (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 1 Jun 2023 14:13:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229524AbjFASNn (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 1 Jun 2023 14:13:43 -0400
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com [IPv6:2607:f8b0:4864:20::112d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D4C1123
        for <selinux@vger.kernel.org>; Thu,  1 Jun 2023 11:13:42 -0700 (PDT)
Received: by mail-yw1-x112d.google.com with SMTP id 00721157ae682-568af2f6454so11965347b3.1
        for <selinux@vger.kernel.org>; Thu, 01 Jun 2023 11:13:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1685643221; x=1688235221;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RvjN8ow1TTr+uAddsXxWnHvBMIYL1A0w2JlDQS5GbnI=;
        b=fx1yrgniUa4XblA7ydMx/t/fM/JbS7QlkurJmrA/GtDHiUVC7mUbf3OX2sqjY18oUq
         CIkqwQbfN0e8I/bMMe+s46pDAiNsO0iaD3/mLS8jfwqAgWrANX0WjgekKZqDlA3wJOum
         N85jhHybp/3XjI1NjS2STYaAR8kE40szVKaQZzS0hYOjA6DjKdC7eUV666wc9GQ0Hdzd
         tHqm2wIlK/dOS6NRkfrDJVwwa48pzq9ABSUblrE3OHtz04FD+Neus/tfG5Z37akXRroz
         hFCJRN2gNoZyNyZ6ZmGRce8f6oJ7QwvCk6LppuegYyaz3wMG9a0pTIA4gDxZlZn4aqrj
         QT2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685643221; x=1688235221;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RvjN8ow1TTr+uAddsXxWnHvBMIYL1A0w2JlDQS5GbnI=;
        b=SIcDLAZSYwQg/ZOTzHFn1RUzQHuqXhvzjB2yI0V8dNzbshB8UyNyT2/x/cWQL57OQU
         wa92N3zeZDg297hT59nha691+qjeew1umIu+aTeEmSPG00Q0nkkFilryzYxvocg9Ny6v
         CVswMDjvltbM+eMCLGkXLeEesGkKPTw49Oj7S23qj6L2/z6AzIoZ1tGrbPdZSrUgDmfU
         HeXywdObY03dBFnnCxk3Cltb8kvb95oHz0/SSZrMQRJuM4k0ShPvatQ9ynK9rHzJXoCS
         FvxWVF6yoeGV1aN+aV30l98Uz29W9+d06XcDA87PkBmesl8qxOS0jeXFuWazoWcSqsVF
         7qkw==
X-Gm-Message-State: AC+VfDz0ov4gHd2I+XSVUiiyiFx6/gZOGbhNlu6IpGFLr5BWGyw5ERJX
        Nh4RwNDP+GoZHItx/Es/YDJFGhPNtkv1e18VdbcpQ526/2B9Dp0=
X-Google-Smtp-Source: ACHHUZ7V/SgCDcfAenLVD4j476bXcJFFhycUW0yzTs+tUkDDeM+g/byM2aTZ3eXYoGhMXBR2aaQladfT5dd9fZYKIJg=
X-Received: by 2002:a81:d246:0:b0:561:9051:d2d3 with SMTP id
 m6-20020a81d246000000b005619051d2d3mr9550406ywl.11.1685643221048; Thu, 01 Jun
 2023 11:13:41 -0700 (PDT)
MIME-Version: 1.0
References: <20230601180643.211112-1-paul@paul-moore.com>
In-Reply-To: <20230601180643.211112-1-paul@paul-moore.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 1 Jun 2023 14:13:30 -0400
Message-ID: <CAHC9VhQcu=tOYHE3XH3zVAjuaHcuMZu1aFJ8bTQ4u6wqqzZ80g@mail.gmail.com>
Subject: Re: [PATCH] selinux: don't use make's grouped targets feature yet
To:     selinux@vger.kernel.org
Cc:     Erwan Velu <e.velu@criteo.com>,
        Luiz Capitulino <luizcap@amazon.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Jun 1, 2023 at 2:06=E2=80=AFPM Paul Moore <paul@paul-moore.com> wro=
te:
>
> The Linux Kernel currently only requires make v3.82 while the grouped
> target functionality requires make v4.3.  Removed the grouped target
> introduced in 4ce1f694eb5d ("selinux: ensure av_permissions.h is
> built when needed") as well as the multiple header file targets in
> the make rule.  This effectively reverts the problem commit.
>
> We will revisit this change when make >=3D 4.3 is required by the rest
> of the kernel.
>
> Cc: stable@vger.kernel.org
> Fixes: 4ce1f694eb5d ("selinux: ensure av_permissions.h is built when need=
ed")
> Reported-by: Erwan Velu <e.velu@criteo.com>
> Reported-by: Luiz Capitulino <luizcap@amazon.com>
> Signed-off-by: Paul Moore <paul@paul-moore.com>
> ---
>  security/selinux/Makefile | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)

As indicated by the -stable tag above, this is intended for the
selinux/stable-6.4 branch, with backports to the affected -stable
trees expected once this hits Linus' tree.

The SELinux folks will likely note that a different patch will be
needed for selinux/next, you can expect that shortly, I just wanted to
make sure we fixed Linus' tree first.

--=20
paul-moore.com
