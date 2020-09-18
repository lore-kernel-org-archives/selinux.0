Return-Path: <SRS0=V9Cn=C3=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D67BBC43463
	for <selinux@archiver.kernel.org>; Fri, 18 Sep 2020 03:46:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8922E22208
	for <selinux@archiver.kernel.org>; Fri, 18 Sep 2020 03:46:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="akB1shQb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726343AbgIRDqA (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 17 Sep 2020 23:46:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726316AbgIRDqA (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 17 Sep 2020 23:46:00 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32614C06174A
        for <selinux@vger.kernel.org>; Thu, 17 Sep 2020 20:46:00 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id r7so6123683ejs.11
        for <selinux@vger.kernel.org>; Thu, 17 Sep 2020 20:46:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jIJ4cxFLC52kACt39ZRgISpOmrVkhBjaybmLnFD2eW0=;
        b=akB1shQbVMJmvNZaq0qqguAqAd6bj4cmmuulaK5OhawGcI+thl2+MeUJTp4kwFjDg6
         6GvRbmvd5WeH1HsjJUsd38jNIWtKremfNof53QUuPJk3cLOtz8ZQkZjfFHQrFCLRVf2Y
         ewC0zkndpA5Spp3R8On5xmwgLjzf59ZeSVjC4ICLtKQJJVEkm0sDVLIASeJ1nwiUpTUt
         PxhNcTFeVcTTTELeI5AmE9hq3+w4740WsDSXbv0f8b+QrOGB25ITX2dPH6fAU9j4cJRV
         6tODwkETBmFEcyvaEoTiVrzID+zXI98IkjlNzM6Hhs6+UHG1B0WDqTVDF9346E7dpqfI
         tOeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jIJ4cxFLC52kACt39ZRgISpOmrVkhBjaybmLnFD2eW0=;
        b=nkIphc54YYiOihyw1fvwDIFhYuR88anl9V92oe7lSkr5GC6KmBW6WTMhL2UUUabgwI
         +toc3P3RchCocdVtyXIcN6rAp20NG47SapDU58FNtFWfXrL0RaVf+MxAR4lp4JB57sZc
         6rAZT2mpfuiFYhoQUJNCq9VO9CPwAquoX2VVaiDGXe2FtEFyYKujAxjr1d16q3iZJrM/
         y9O39SODKRhI8IRs//m/awHbAKnvci3PR3N3FrpHP+Qhw+TWCp4bkA0qNaWUunzkuUTd
         rEWZCtqjboh6yqhmEsPseKAqOqXjF1PeinjuJXWfZg2uHRP05XnHuxTpZ/56qFTE9Kxg
         sYWQ==
X-Gm-Message-State: AOAM532q58//k1JmytgAktwzm3IdNWtdppKOqG/E0zSMwFGKubYPNBm9
        4IJyYECcIcG8fGwvWQtFqxT/i3xzCyMjyol1Viax
X-Google-Smtp-Source: ABdhPJysnr13iUhFK3EHdaSUAJYGM40Ajzld6tTnhrZgsy5rcyOpanKJV7Swv/pG9m0Y+Z0gLJP48Z1idiawDXk0hXc=
X-Received: by 2002:a17:906:2301:: with SMTP id l1mr16839808eja.488.1600400758564;
 Thu, 17 Sep 2020 20:45:58 -0700 (PDT)
MIME-Version: 1.0
References: <6a791504-7728-3026-17ee-c22cbff8c3d1@gmail.com>
 <d4e55b23-41da-902d-8b6d-83c9c47e7618@gmail.com> <CAEjxPJ5FXkArFZgC2Ps56Q_odPGfM5=O79puG3PEtuuYxKxU+A@mail.gmail.com>
 <d3f8d0d8-1878-1dbb-3454-ba9a0a48ccbe@gmail.com>
In-Reply-To: <d3f8d0d8-1878-1dbb-3454-ba9a0a48ccbe@gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 17 Sep 2020 23:45:47 -0400
Message-ID: <CAHC9VhQ9h4rQK8W03jCmtqgr81jRueh_jzd8XjAkjzcCvGmCmw@mail.gmail.com>
Subject: Re: [RFC PATCH] selinux: allow dontauditx rules to take effect
 without allowx
To:     bauen1 <j2468h@googlemail.com>
Cc:     Stephen Smalley <stephen.smalley.work@gmail.com>,
        SElinux list <selinux@vger.kernel.org>,
        Jeff Vander Stoep <jeffv@google.com>,
        Nick Kralevich <nnk@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Sep 14, 2020 at 2:49 PM bauen1 <j2468h@googlemail.com> wrote:
> On 9/14/20 7:51 PM, Stephen Smalley wrote:
> > On Sat, Sep 12, 2020 at 3:54 PM bauen1 <j2468h@googlemail.com> wrote:
> >>
> >> This allows for dontauditing very specific ioctls e.g. TCGETS without
> >> dontauditing every ioctl or granting additional permissions.
> >>
> >> Now either an allowx, dontauditx or auditallowx rules enables checking
> >> for extended permissions.
> >>
> >> Dontaudit rules take precedence over dontauditx rules and auditallowx
> >> rules take precedence over auditallow rules.
> >
> > I'm not following why you are providing different precedence for
> > dontauditx vs auditallowx.
>
> I selected this because I thought it is the most useful.
> I think my original take was that with dontaudit you want to be broad if necessary, but with auditallowx you want to be specific. But now I'm not sure if the precedence of auditallow in the RFC is actually good.
> At least the precedence of dontaudit/dontauditx is good because it doesn't change the behavior of dontaudit in any (unexpected) way.
> I will probably change it in a v2.

I think that (dropping the precedence changes) is a good idea at this
point.  Let's focus on the change to services_compute_xperms_drivers()
as I suspect this is the bigger issue.

> > Regardless, since this changes the semantics of such rules I'll need
> > confirmation from Android that they want this change in behavior since
> > they are the original developers of the ioctl whitelisting support and
> > its primary users to date.
>
> I've copied Jeff Vander Stoep since he submitted the original patch, I don't know anyone else involved with this but I see you also added Nick Kralevich.

We really should hear from the Android folks on this as they are
probably the biggest user of the xperms code.  I'm a little surprised
and disappointed that we haven't heard from them yet, but they may be
out of the office at the moment.  I would suggest posting a v2 patch
as you mentioned above and we'll see if we can get the attention of
the Android folks.

-- 
paul moore
www.paul-moore.com
