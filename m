Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2230BC10DCE
	for <selinux@archiver.kernel.org>; Tue, 19 Jan 2021 18:27:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D5EB422AAA
	for <selinux@archiver.kernel.org>; Tue, 19 Jan 2021 18:27:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729436AbhASQ07 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 19 Jan 2021 11:26:59 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:25880 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726839AbhASQ0w (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 19 Jan 2021 11:26:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611073525;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=bV33mQ0DVBw0ilyGRibPHV9A7AdJ5Um4tNLl1kcd/zo=;
        b=HP2wV/iLadIOtjfNU/xJ6PIg03o3zojY+fBvPYh94wQ85EHEktbFmbQEIVL2kNTW0aXvm6
        eipk/01CwcDxqkA3OAlNQBLDUVGh5HKyEODYIU/zBrpnVw0wSKlksIolXBHFtjFWbCIC9v
        3maLtoz0wbn7SF5EdJfL/bNB2SP9kRQ=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-15-hMIkqXoXMcq-o1YrE9qXww-1; Tue, 19 Jan 2021 11:25:24 -0500
X-MC-Unique: hMIkqXoXMcq-o1YrE9qXww-1
Received: by mail-lj1-f200.google.com with SMTP id m16so238292ljb.20
        for <selinux@vger.kernel.org>; Tue, 19 Jan 2021 08:25:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bV33mQ0DVBw0ilyGRibPHV9A7AdJ5Um4tNLl1kcd/zo=;
        b=XsMnAHXCrkRIZ+E48KFkHtQGkWpwBWI8O/F97DbL2DXGxtC5V85Y/R2Fu3V/VzxFCy
         C6cdryvXohgD6UEsH+veuFWYczNpAyZmgSiEM8wyPwv1s7EFfw5KyEjGlLdJxZuFl8mp
         OgYRg2GG85+KvGpeje3L++z9i/J0lzUYnsQ7bvsE+HJ6t42YTquPtEpHumcDOu3LJh8r
         8W2+2TRLEbTAVKaGubACwjj+52GhVJBgwFw9FUD5N8FJ33oILiabOZRcDwZ7XWRgkY4w
         6Ith8drz60yVjv+8eSyTTgh33YSPzbKlD+sGBuJ/awkDjwDNFnt9LPxPku4vHMNBC7xk
         pLlw==
X-Gm-Message-State: AOAM533ey5jgOOxWqBZtfI0A41Dvk/T73+IJSzh211uqBkumwZFamWyj
        qbqSDpxZxkNsFpBUFLoX5cov6zm/x2XduJGpO0sVsuJD33f0xGXttfpWh3hPiJTgNCXGXXne5o6
        XIfSOfn4owLARFjjquWHyrChlV38xkAnocQ==
X-Received: by 2002:a19:8213:: with SMTP id e19mr2187222lfd.600.1611073522268;
        Tue, 19 Jan 2021 08:25:22 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyG5V0AP6fhjRntJENBJ9j3nvQGdxmpkBrkleFERmFifIMj3e4QBypHtpHDvAeAOeFonazbToRTO1pWDffIRZI=
X-Received: by 2002:a19:8213:: with SMTP id e19mr2187218lfd.600.1611073522084;
 Tue, 19 Jan 2021 08:25:22 -0800 (PST)
MIME-Version: 1.0
References: <20210119090651.321390-1-omosnace@redhat.com> <CAHC9VhQtOGREKfh2hSJGnzDzEzNdusWJTb31TkyMnM+5MM2dqg@mail.gmail.com>
In-Reply-To: <CAHC9VhQtOGREKfh2hSJGnzDzEzNdusWJTb31TkyMnM+5MM2dqg@mail.gmail.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Tue, 19 Jan 2021 17:25:10 +0100
Message-ID: <CAFqZXNtwkrtvcG_OAHOEXh2yczxMvHZ47EX_oAWzwTRA7Zowiw@mail.gmail.com>
Subject: Re: [PATCH testsuite] Makefile: unload policy when testsuite fails
To:     Paul Moore <paul@paul-moore.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Jan 19, 2021 at 5:10 PM Paul Moore <paul@paul-moore.com> wrote:
> On Tue, Jan 19, 2021 at 8:24 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> >
> > Make sure that the test policy is properly unloaded when `make test`
> > fails, to prevent it from accidentally lingering on the system after a
> > failed test.
> >
> > Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> > ---
> >  Makefile | 6 +++++-
> >  1 file changed, 5 insertions(+), 1 deletion(-)
> >
> > diff --git a/Makefile b/Makefile
> > index 9081406..8efe15c 100644
> > --- a/Makefile
> > +++ b/Makefile
> > @@ -5,7 +5,11 @@ all:
> >
> >  test:
> >         make -C policy load
> > -       make -C tests test
> > +       make -C tests test || { \
> > +               res=$$?; \
> > +               make -C policy unload; \
> > +               exit $$res; \
> > +       }
> >         make -C policy unload
>
> Why not just do '-make -C tests test' instead?

Then the exit code would be 0 regardless of whether the tests passed or failed.

-- 
Ondrej Mosnacek
Software Engineer, Platform Security - SELinux kernel
Red Hat, Inc.

