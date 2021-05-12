Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B13E3C433ED
	for <selinux@archiver.kernel.org>; Wed, 12 May 2021 13:52:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 73435611AC
	for <selinux@archiver.kernel.org>; Wed, 12 May 2021 13:52:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230328AbhELNx0 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 12 May 2021 09:53:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:39394 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230182AbhELNx0 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 12 May 2021 09:53:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1620827537;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=EKmL00jlrZTCMotY6CC+I+ApUnUc+XQGLREnNtyb9E4=;
        b=dZvIfNYijzhu2pF91sbTLb86fKBBLSAoTCNNyNhQ9SON0AYL0nqOw0bDVoNhPJglgNfjat
        O99sSZmKAA2o8U8fUegstxuR8KwIz6yVqp5UgYrVgWw2z7TpeUm1YxHbNqApU8ELmWrop+
        ifmlyIsrqw3BBsBQ7qSx2EdXuDLX0dE=
Received: from mail-yb1-f197.google.com (mail-yb1-f197.google.com
 [209.85.219.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-102-4SOg09J5MXSh7Ec24MAStQ-1; Wed, 12 May 2021 09:52:14 -0400
X-MC-Unique: 4SOg09J5MXSh7Ec24MAStQ-1
Received: by mail-yb1-f197.google.com with SMTP id d20-20020a25add40000b02904f8960b23e8so17965945ybe.6
        for <selinux@vger.kernel.org>; Wed, 12 May 2021 06:52:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EKmL00jlrZTCMotY6CC+I+ApUnUc+XQGLREnNtyb9E4=;
        b=Q6Z2C6JeLBpg3/iwmyVh54zFR+12sl4ahtJT2QT+HnhaHbmOcZTkF89CPbHtDsEst8
         hfwBjTK35CHC8qz+s8xxOnPLjS2qlcT0kWEKOnFVOXRjF9EkWT4jcRSgE4okIyM7YFL+
         8MOlCKRKatXcEhprz1OIAa9kGf6xdxq/bTekpg8h+2GwkANpq2bIQHnkKqqAQP7KWHAJ
         sGgl+T7l2llBa9MJyi26vVDlUwxrWXnajmIAjWxlyCPS7J0UN6wqqf7/1q8GRJskBjqW
         UaM7ztWXJmsw5Koca/szHQ1v50OJ+JfOJPdgR4A1abQDCKr8g8+tsAfANRKIZ4d0GXY4
         VHfg==
X-Gm-Message-State: AOAM533ji8pIf99IwGOnBua2rIl6IB5p3bgup6NIY15Lf3iaVIrCbrV+
        bF6psxHBvsxIEt8+J7ghbGECu197BsMxIt/s8CTn3hIhMD2WOU2YcqEZkVZy4Foznd/t0RazeG8
        y/YX588VNM27qTHsr7B+iQI0FLBc5m42bWw==
X-Received: by 2002:a25:abe2:: with SMTP id v89mr27079235ybi.26.1620827533480;
        Wed, 12 May 2021 06:52:13 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxPmgOAhXaQRv+JmkU7r7R9ISxgSaxFaZi8RG0NG27e61Xu4GPmR5aFKCewNutjP4NaLNkz0FY74t6E4VCfFXI=
X-Received: by 2002:a25:abe2:: with SMTP id v89mr27079193ybi.26.1620827533121;
 Wed, 12 May 2021 06:52:13 -0700 (PDT)
MIME-Version: 1.0
References: <20210507130445.145457-1-omosnace@redhat.com> <CAHC9VhRFT=CVTq=wCxE=Wn8VHP+g1Cyw4zc0oAtsk7Jaa5EMzQ@mail.gmail.com>
In-Reply-To: <CAHC9VhRFT=CVTq=wCxE=Wn8VHP+g1Cyw4zc0oAtsk7Jaa5EMzQ@mail.gmail.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Wed, 12 May 2021 15:52:01 +0200
Message-ID: <CAFqZXNungmX4_x=Q7H0X9xEMznASKXOHJjSVniiFapAHedBKKg@mail.gmail.com>
Subject: Re: [PATCH] selinux: use strlcpy() when copying IB device name
To:     Paul Moore <paul@paul-moore.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, May 11, 2021 at 3:56 AM Paul Moore <paul@paul-moore.com> wrote:
> On Fri, May 7, 2021 at 9:04 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> >
> > While the buffer should be large enough (IB_DEVICE_NAME_MAX) for all
> > InfiniBand device names, it's better to be defensive and ensure the
> > string will be null-terminated even if the hook happens to receive a
> > longer name.
> >
> > Found by a Coverity scan (BUFFER_SIZE warning).
> >
> > Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> > ---
> >  security/selinux/hooks.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> > index 92f909a2e8f7..ec14ed56f508 100644
> > --- a/security/selinux/hooks.c
> > +++ b/security/selinux/hooks.c
> > @@ -6864,7 +6864,7 @@ static int selinux_ib_endport_manage_subnet(void *ib_sec, const char *dev_name,
> >                 return err;
> >
> >         ad.type = LSM_AUDIT_DATA_IBENDPORT;
> > -       strncpy(ibendport.dev_name, dev_name, sizeof(ibendport.dev_name));
> > +       strlcpy(ibendport.dev_name, dev_name, sizeof(ibendport.dev_name));
>
> The kernel preference these days appears to be to use strscpy()
> instead of strlcpy(); if we are going to change it, let's change it to
> strscpy().

Good point. But now that you made me look at it again, I noticed that
we can simply turn the dev_name field to a const char * and avoid the
copy altogether. The ibendport variable goes out of scope at the end
of the function anyway, so the lifetime of the dev_name pointer will
never be shorter than that of ibendport, thus we can safely just pass
the dev_name pointer and be done with it.

So I'll update the patch to just switch to this other approach.

-- 
Ondrej Mosnacek
Software Engineer, Linux Security - SELinux kernel
Red Hat, Inc.

