Return-Path: <SRS0=QxhH=2Y=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A798C2D0C2
	for <selinux@archiver.kernel.org>; Fri,  3 Jan 2020 15:55:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B734217F4
	for <selinux@archiver.kernel.org>; Fri,  3 Jan 2020 15:55:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="BKJ6jXn4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727891AbgACPzv (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 3 Jan 2020 10:55:51 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:34310 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727859AbgACPzv (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 3 Jan 2020 10:55:51 -0500
Received: by mail-lf1-f67.google.com with SMTP id l18so23967713lfc.1
        for <selinux@vger.kernel.org>; Fri, 03 Jan 2020 07:55:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ddaTtFCjjEwAEYd+PpHbtImJVfOEWlRXs7KX6+jip6k=;
        b=BKJ6jXn4pFBNgwmSInzitZT3foO/A08jxgQAVP1eDxLn1ff9NMGXThb8DVAOIAOMw3
         esbowAi6+RQOJoJke7GIYs691SWKdY/GyQsGIYDmMUiiObNodVmp3m52YWWwZ2I2ECtG
         +OgaMsjVHIzDXO4z23QIO7Qpysmk316orRm4Pk/rm/Re6ZV9l9J3I6pikJuXklIjk03s
         R1x5C58+Fyn2NEhEa2o1AGknTolAAAtKvr/vUbVNj7IFEqEWlxjOOR1zOswFmVxI8k96
         slRx/JRDm1Zxx6hpkHJTXlQbgYm8HdjV6T15dLjplHHmhOMRh7Kg4IqL8/Lqk8FgJpU6
         c83w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ddaTtFCjjEwAEYd+PpHbtImJVfOEWlRXs7KX6+jip6k=;
        b=clswU+YmG6/qNG+KjtumXvRhJUU7VbZf/kCXDPpfWwFvsvkutUYDng4mq2PJo61Fak
         quvVXAj0/v+Y7Zsp2y5S8OrzGse6hmTznwi/HGmnaoSzFzfvh/gM8fn3d1IYKIdrkiiP
         Uzg2Mj9jhU3XeAuULKxS+vOGmUo//2bnMKTcDpKcuKfkGc9WzST6435qOOpilvQcRFWL
         ukY97Ne8q991qRuuW+AjbPakCt+a15t2Qn+dr4CSwcXOX0lHsRhPy2sqevSDyMsMN4sL
         SWf+NFvkXgvWVgLvkeR7anlq/YZG1hXW3GMkotRDEl2PgVSmZDQkSztM+zQyoI9hhoet
         VHIg==
X-Gm-Message-State: APjAAAXatWLUshI7ZsCDepBPtK04WyEjgt3MEIiX9EfJXON+glXRUTFc
        2wgsP82zXjx898RyiER8YmzKFfrGxZZyPLXyK+Q+
X-Google-Smtp-Source: APXvYqwe49PA2g09iqfrXB8tsdkfqRIeC2hIHFqPDuBYrXGx1LOXXS42ZE81JkQfeWpqBE1L39HRvZYkLsdF92SiF5M=
X-Received: by 2002:ac2:5983:: with SMTP id w3mr51485506lfn.137.1578066949398;
 Fri, 03 Jan 2020 07:55:49 -0800 (PST)
MIME-Version: 1.0
References: <157678334821.158235.2125894638773393579.stgit@chester>
 <CAFqZXNvXuWx-kCJeZKOgx4NSesCvnC63kHf6-=_SrFLH4xubag@mail.gmail.com>
 <CAHC9VhTHroatmHKt3Saru18TktFY8EXjsxkx-pWvx87-RUx8HA@mail.gmail.com> <CAFqZXNubaXZtF-yN6tMBuM+AGmSy=1nTcTimFfXaok32GY3aYA@mail.gmail.com>
In-Reply-To: <CAFqZXNubaXZtF-yN6tMBuM+AGmSy=1nTcTimFfXaok32GY3aYA@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Fri, 3 Jan 2020 10:55:37 -0500
Message-ID: <CAHC9VhQzqRSfyfs74Lwz+-kJi5r_EvqBbmkzQBd2e8m2B5VDSw@mail.gmail.com>
Subject: Re: [RFC PATCH] selinux: deprecate disabling SELinux and runtime
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     SElinux list <selinux@vger.kernel.org>,
        Linux Security Module list 
        <linux-security-module@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Jan 3, 2020 at 4:32 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> On Thu, Jan 2, 2020 at 10:38 PM Paul Moore <paul@paul-moore.com> wrote:
> > On Thu, Jan 2, 2020 at 4:24 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> > > On Thu, Dec 19, 2019 at 8:22 PM Paul Moore <paul@paul-moore.com> wrote:
> > > > Deprecate the CONFIG_SECURITY_SELINUX_DISABLE functionality ...

...

> > > Looks reasonable, informal ACK from me.
> >
> > Thanks.  You want to make that a formal ACK? ;)
>
> Sure, if you find it useful :)
>
> Acked-by: Ondrej Mosnacek <omosnace@redhat.com>

Yes, it is useful, thank you.

For this patch your ACK is particularly significant because you are
representing RH here (I'm assuming you are still the RH SELinux kernel
person) and we are deprecating a feature used by Fedora.  In my
opinion it would be a mistake to merge a deprecation patch without the
ACKs of those who rely on the feature targeted for removal (although
in some cases it may need to be done regardless).

I also really dislike merging my own patches without at least one
other Acked-by/Reviewed-by tag for the simple reason that I believe
every patch should have at least two people (author and at least one
reviewer) who agree that the patch is reasonable.  Of course there are
exceptions for trivial and critical fixes, e.g. 15b590a81fcd
("selinux: ensure the policy has been loaded before reading the sidtab
stats"), but I like to keep those as the exception rather than the
rule.  Just because someone is listed in the MAINTAINERS file
shouldn't mean they are exempt from the normal review process.

Generally speaking, one of the more useful things one can do from an
upstream perspective is to review and test patches that are submitted
to the list.  We are a community driven project after all, and the
community aspect shouldn't be limited to just the development of
patches ;)

-- 
paul moore
www.paul-moore.com
