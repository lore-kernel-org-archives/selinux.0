Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15D1AC433B4
	for <selinux@archiver.kernel.org>; Fri,  7 May 2021 12:41:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C93FF611ED
	for <selinux@archiver.kernel.org>; Fri,  7 May 2021 12:41:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236998AbhEGMmg (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 7 May 2021 08:42:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:57945 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236827AbhEGMmd (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 7 May 2021 08:42:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1620391293;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+pizb5T4wXio4s+BKjaVq1oW2LlYLV5RKkN72d3SlPY=;
        b=cckZ1Ib//ahxUVuQY9soR+faNHz1L7JCA6Yt6hUss0V0u34i+scOiCCQtLsgUWN347O2pP
        tu84pjcIRX2uF0q9chCLm17V8u10jHuPIuKuhF2/6W4RMkBAoJZrIini6KFou4Y9WIFwWz
        UfQLwxAMGQcR7zwBFBp0cKySiXiqoOA=
Received: from mail-yb1-f198.google.com (mail-yb1-f198.google.com
 [209.85.219.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-357-zE9Yc7miNTGj1KbZuY3TZg-1; Fri, 07 May 2021 08:41:30 -0400
X-MC-Unique: zE9Yc7miNTGj1KbZuY3TZg-1
Received: by mail-yb1-f198.google.com with SMTP id u7-20020a259b470000b02904dca50820c2so9889022ybo.11
        for <selinux@vger.kernel.org>; Fri, 07 May 2021 05:41:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+pizb5T4wXio4s+BKjaVq1oW2LlYLV5RKkN72d3SlPY=;
        b=UO1cZtypTwjR7WaY5z7tQVSYzihhqi4zFIjTCn55Lyeu4bjPIvl1M/znvq4v9hQG2V
         OwYJM8QmaM0R54xaktnjNiZ7KRsy7T1QugvATL/msAyisr6OcIbv94rtSEUk0TD0M66H
         6BXbZpvqZPhYSPJYpq+gJITRu1RLxuBLWMms9LD72KKh6sX/fhLFTMzC1YG2uC3BB9Cy
         EmaTxA/h7tHODE2yYz66DylPwT3Ult8T9WGbQ0Q/SDaCdwAwCH4hF6w5I189F6c3u3v3
         cZLACdFYrNJjBxdX7nFnL6wWPYIhQfPPniC3KHDedBapEtCleFAZATMFbBjn8NOVhhnR
         svYQ==
X-Gm-Message-State: AOAM5317k9pP/MVMwBfFvFk1/ACCPv+rdSiUgQXCgkCnh9APurI3msGt
        blZegEHB5G73cVNpM196t+p8qBzl8R4VUHOjzPV8DeGYG2p7SMIxsobl+5PzLVO64aqYIS0rnGi
        sYw+UIY08VeFqTnRK8B1OztIiMrmJH1YCaQ==
X-Received: by 2002:a25:640f:: with SMTP id y15mr13170132ybb.436.1620391290263;
        Fri, 07 May 2021 05:41:30 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy22p09PEHUGb5fAA49wspHdow+4OHN0qicl6JIPF5XwcGlunbrNF+orAljsopKKKqw1oReB57xfDS4LkuZvuE=
X-Received: by 2002:a25:640f:: with SMTP id y15mr13170115ybb.436.1620391290086;
 Fri, 07 May 2021 05:41:30 -0700 (PDT)
MIME-Version: 1.0
References: <20210507114150.139102-1-omosnace@redhat.com> <YJUseJLHBdvKYEOK@kroah.com>
 <YJUuoiKFjM8Jdx6U@casper.infradead.org> <YJUvhGV5EW0tsIpP@kroah.com>
In-Reply-To: <YJUvhGV5EW0tsIpP@kroah.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Fri, 7 May 2021 14:41:16 +0200
Message-ID: <CAFqZXNv_WWQZPHVhN5oqHVYanxKcXFqu6r=S9=ZTHKf7UNsiKA@mail.gmail.com>
Subject: Re: [PATCH] debugfs: fix security_locked_down() call for SELinux
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Matthew Wilcox <willy@infradead.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        SElinux list <selinux@vger.kernel.org>,
        Linux Security Module list 
        <linux-security-module@vger.kernel.org>,
        James Morris <jmorris@namei.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, May 7, 2021 at 2:16 PM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
> On Fri, May 07, 2021 at 01:12:18PM +0100, Matthew Wilcox wrote:
> > On Fri, May 07, 2021 at 02:03:04PM +0200, Greg Kroah-Hartman wrote:
> > > On Fri, May 07, 2021 at 01:41:50PM +0200, Ondrej Mosnacek wrote:
> > > > Make sure that security_locked_down() is checked last so that a bogus
> > > > denial is not reported by SELinux when (ia->ia_valid & (ATTR_MODE |
> > > > ATTR_UID | ATTR_GID)) is zero.
> > >
> > > Why would this be "bogus"?
> >
> > I presume selinux is logging a denial ... but we don't then actually
> > deny the operation.
>
> That would be nice to note here...

Granted, I didn't do a good job of describing the issue in the patch
description... I'll send a v2 with hopefully a better description.

-- 
Ondrej Mosnacek
Software Engineer, Linux Security - SELinux kernel
Red Hat, Inc.

