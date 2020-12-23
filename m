Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48270C433E0
	for <selinux@archiver.kernel.org>; Wed, 23 Dec 2020 15:29:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E24962332A
	for <selinux@archiver.kernel.org>; Wed, 23 Dec 2020 15:29:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726319AbgLWP3v (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 23 Dec 2020 10:29:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726207AbgLWP3v (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 23 Dec 2020 10:29:51 -0500
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3AC5C061794
        for <selinux@vger.kernel.org>; Wed, 23 Dec 2020 07:29:10 -0800 (PST)
Received: by mail-ej1-x636.google.com with SMTP id ga15so23333248ejb.4
        for <selinux@vger.kernel.org>; Wed, 23 Dec 2020 07:29:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ilqnS+go6y3VGtHK12pvSTp1wCYjHy/HsLxf7+D7FoI=;
        b=hIcM5ZdbCV2fCYDLBMSV1oNIHbfGGZA9hK7sNa8ziU+mN9OZcxt1sAmRVYv08xr4u/
         D9MO+IEYbEjt23X6C2ciGK/6R64T/vmIdHmd88wACo6d4OIq07fPar1u3jHFbnJvw4rc
         ZxPsP7E6Vb65/6fm5n5T5yVpvWZP6YP34wa6BVVoXTKwSv9F4zQHFDIeO9cDWVeEiNYK
         B3utL99d4CSOUDbrX8MEHnKpGdwWEuhEYgvFqrBI85rnDz42FaV8OT+jl0Ovo9/+EkdO
         /7hU3i7k1CMfvzk/6QCF2OPVxtQYoPOgM7LzZQUAh3VUqDPB3Y4780gT+KDIv3HajL8J
         POgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ilqnS+go6y3VGtHK12pvSTp1wCYjHy/HsLxf7+D7FoI=;
        b=lc5ofh+MQAG87ZHVxcJdV6UdYnsXXcbJYK0J9ArAMxHfbum0Zq8mhl4qTjxCDGcF5c
         fWKd6P5qEkUxMuvwkvv+PQ02AY/tvhBsKIbMXmCAaYcoDgHyjru0w7ev/sKUg80vYi0J
         QjI1dmjMTWmmsv6xJhYUXBM8U/FYKqwc+njhWCVyV2nS9qSHeW2JOXgD5PPlHTekWY+o
         /k3T+CTOODhvnDLFgwfXc9AFnddREKJ3F2xDYDWeD32VwikgNfqo40hk4suPVbshr6Bz
         gcjCYkUq2ChJ7A25wALYq97Geun4xQbvix6OYm48wOAKfY/WSBNte3DMX9w6HRNN9dMg
         vdNA==
X-Gm-Message-State: AOAM530FoegCgghIS8vc0fXpXdjHGS4bQsdRNl20PdIlRxV/VdzEY1tu
        3TD6lwmTzFmtns0jfwUGdj6E5l0gmEerilIPxYwp
X-Google-Smtp-Source: ABdhPJzkMTwRUL5i/KRE4eD4CuTghMo6naTpAE+x8n8wannLuJr29Tmz/CoLa1+kbCQkUe9yzTG/4HDPqxBKlFLlIAs=
X-Received: by 2002:a17:907:d9e:: with SMTP id go30mr23759329ejc.488.1608737349200;
 Wed, 23 Dec 2020 07:29:09 -0800 (PST)
MIME-Version: 1.0
References: <fde38edd69c998624c5eb5be072ca1fa556d312d.1608119587.git.pabeni@redhat.com>
 <CAHC9VhTUain0=AXvxu3k7e46DCnFuQtcrgQFrEsz9b0uNQnqtQ@mail.gmail.com> <8650019f70725323545e41c5ecf6b1344671b4fa.camel@redhat.com>
In-Reply-To: <8650019f70725323545e41c5ecf6b1344671b4fa.camel@redhat.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 23 Dec 2020 10:28:58 -0500
Message-ID: <CAHC9VhQxrGNMNj9FN3LYVbqt+Rwgbrv98GySzg4Tzb=jcNWN3g@mail.gmail.com>
Subject: Re: [PATCH] linux: handle MPTCP consistently with TCP
To:     Paolo Abeni <pabeni@redhat.com>
Cc:     selinux@vger.kernel.org, linux-security-module@vger.kernel.org,
        mptcp@lists.01.org,
        Stephen Smalley <stephen.smalley.work@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Dec 23, 2020 at 10:10 AM Paolo Abeni <pabeni@redhat.com> wrote:
> On Wed, 2020-12-23 at 09:53 -0500, Paul Moore wrote:
> > On Wed, Dec 16, 2020 at 6:55 AM Paolo Abeni <pabeni@redhat.com> wrote:
> > > The MPTCP protocol uses a specific protocol value, even if
> > > it's an extension to TCP. Additionally, MPTCP sockets
> > > could 'fall-back' to TCP at run-time, depending on peer MPTCP
> > > support and available resources.
> > >
> > > As a consequence of the specific protocol number, selinux
> > > applies the raw_socket class to MPTCP sockets.
> > >
> > > Existing TCP application converted to MPTCP - or forced to
> > > use MPTCP socket with user-space hacks - will need an
> > > updated policy to run successfully.
> > >
> > > This change lets selinux attach the TCP socket class to
> > > MPTCP sockets, too, so that no policy changes are needed in
> > > the above scenario.
> > >
> > > Note that the MPTCP is setting, propagating and updating the
> > > security context on all the subflows and related request
> > > socket.
> > >
> > > Link: https://lore.kernel.org/linux-security-module/CAHC9VhTaK3xx0hEGByD2zxfF7fadyPP1kb-WeWH_YCyq9X-sRg@mail.gmail.com/T/#t
> > > Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> > > ---
> > >  security/selinux/hooks.c | 3 ++-
> > >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > Based on our discussion in the previous thread, the patch below seems
> > fine, although it needs to wait until after the merge window closes.
> >
> > Paolo, it sounded like there was at least one other small MPTCP fix
> > needed, likely in the stack itself and not the LSM/SELinux code, has
> > that patch been submitted already?
>
> Yes, it's already in the Linus's tree:

Perfect, thank you.

> commit 0c14846032f2c0a3b63234e1fc2759f4155b6067
> Author: Paolo Abeni <pabeni@redhat.com>
> Date:   Wed Dec 16 12:48:32 2020 +0100
>
>     mptcp: fix security context on server socket
>
> Thanks for the feedback && happy new year;)

Thanks, you too!

-- 
paul moore
www.paul-moore.com
