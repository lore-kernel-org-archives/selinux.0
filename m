Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_RED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 727D9C48BD1
	for <selinux@archiver.kernel.org>; Fri, 11 Jun 2021 01:16:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5363A61076
	for <selinux@archiver.kernel.org>; Fri, 11 Jun 2021 01:16:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230332AbhFKBSn (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 10 Jun 2021 21:18:43 -0400
Received: from mail-ej1-f51.google.com ([209.85.218.51]:35602 "EHLO
        mail-ej1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230232AbhFKBSm (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 10 Jun 2021 21:18:42 -0400
Received: by mail-ej1-f51.google.com with SMTP id h24so1973516ejy.2
        for <selinux@vger.kernel.org>; Thu, 10 Jun 2021 18:16:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QRj/l0AEwRVAqSoVJEOPnFwGQ+KdbAusCa2F2dhpq40=;
        b=kS3G4HqC1XZgwI5lS9w0vyh1F5M9I87AaPQImqoQZKzYto/gfW7VOoxTeCAfsI+CbB
         PvuNyVR4uAP8LrJ1lde9FKDnGCPKwQsF8ByJDtDEPim4BOlf7yj7IIbZS+k9+vISCorQ
         ti+IzDdm62N3v5A2exude6fhRZJxY0vApm0SaLQj4FLeEmxJoPB4auKNDXEjBwP8xevi
         xt20NWZs9OXv4elsO3imeHEj6Ep0fO/WLCDhCpcFH4cZjj4VTO/Zi1/2XWG11Q0BqCFL
         YQxs+nXtDF0ULD11uOyB8Hd40rRHqzJVKPQFwqrrs9DNlt6ibBMSfZNvXlvewP5s1JW7
         RJ8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QRj/l0AEwRVAqSoVJEOPnFwGQ+KdbAusCa2F2dhpq40=;
        b=OHhMGsipC6ffSwaY6hWDcxXyeDqY9ABChxx+UFAcXw6bqjShZFPK3mMq/HUlJy+RSE
         mCvB5SwnhHmPubmF6TvPSLZe93RbhKg/D+TSrZf86yJyanfyo0rtzGwRgSHywMNI1Jak
         5zpxEbsE5vdruwTXRzfXJU2yz/5DF3EF5FweY9Y7EOejvY277RUo0g/PKsiyU+VLRGtq
         QfNkh7pfONNKcoH9BS/iuLxd9OX+F2JpfQ2tkDs6QVbIgc1OwgtJowPArPy0f0AFTGhu
         caErvlwJaU16I1nOjId5hWJF6+x+e1UYC9cZEE4sjYCEtttaoQpyaYs/mQEtv2QhnEr3
         In8Q==
X-Gm-Message-State: AOAM533AQpz3sCxH8EBZMsTL0X8ojIM+ugKf5MdvS5+0n4LtoUnS+SaE
        G6JcSdfLH4TF58iBNWFmKsNjW+5XGKZlF9wuFAC2
X-Google-Smtp-Source: ABdhPJzEAjvM/V0QgJp83gEmaTf3sZIJulvlVdQmgrA9QgL7VpoWJNVnK8hghXR2Q1xbpOIhmiBRq/SGDgApvhRHJZU=
X-Received: by 2002:a17:907:10d8:: with SMTP id rv24mr1073324ejb.542.1623374128945;
 Thu, 10 Jun 2021 18:15:28 -0700 (PDT)
MIME-Version: 1.0
References: <20210609163717.2719253-1-minchan@kernel.org> <20210610160650.d2112a9db8130224c597bfaf@linux-foundation.org>
 <CAHC9VhTYeOmJqoyEniXLGMv3cJGBW4_BLc3LhDLBDhQCKtfp7Q@mail.gmail.com>
In-Reply-To: <CAHC9VhTYeOmJqoyEniXLGMv3cJGBW4_BLc3LhDLBDhQCKtfp7Q@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 10 Jun 2021 21:15:17 -0400
Message-ID: <CAHC9VhStg=5soOqXMJUoik_A9N1PLABMbU8pZZcZ8=k=_U_JxA@mail.gmail.com>
Subject: Re: [PATCH] selinux: use __GFP_NOWARN with GFP_NOWAIT
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Minchan Kim <minchan@kernel.org>, Michal Hocko <mhocko@suse.com>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Suren Baghdasaryan <surenb@google.com>,
        John Dias <joaodias@google.com>, selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Jun 10, 2021 at 7:13 PM Paul Moore <paul@paul-moore.com> wrote:
> On Thu, Jun 10, 2021 at 7:06 PM Andrew Morton <akpm@linux-foundation.org> wrote:
> > On Wed,  9 Jun 2021 09:37:17 -0700 Minchan Kim <minchan@kernel.org> wrote:
> >
> > > In the field, we have seen lots of allocation failure from the call path below.
> > >
> > > ...
> > >
> > > Based on [1], selinux is tolerate for failure of memory allocation.
> > > Then, use __GFP_NOWARN together.
> > >
> >
> > Thanks.  I trust that the selinux developers will process this patch.
>
> That's the plan; this is in my review queue for this evening.

Looks fine to me, merged into selinux/next - thanks!

-- 
paul moore
www.paul-moore.com
