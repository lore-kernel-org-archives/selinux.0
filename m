Return-Path: <SRS0=Zw2N=4X=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0ACD7C10DCE
	for <selinux@archiver.kernel.org>; Fri,  6 Mar 2020 17:24:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D05FF20709
	for <selinux@archiver.kernel.org>; Fri,  6 Mar 2020 17:24:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="B+DiLtFn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726185AbgCFRYk (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 6 Mar 2020 12:24:40 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:39643 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726083AbgCFRYk (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 6 Mar 2020 12:24:40 -0500
Received: by mail-ed1-f66.google.com with SMTP id m13so3392022edb.6
        for <selinux@vger.kernel.org>; Fri, 06 Mar 2020 09:24:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cM9MKe8fD8BzPq0UpNiHXcoSPyvddoL36Zhwd529f8c=;
        b=B+DiLtFnG0rNKx1bm1BjpZqxcyzo3DHiXUj4yMsB4E1Es9Ta/TDfrpfknbASHvuoR7
         m21KmoSFQAt15U5ZO6xNvDSqORyMdpVAlmPfnEveSSDO7zzh2WsRH2u9HMByJnG9HuMd
         5POmD7Wd90K6ET1158GJG3ouhw/rMkgiR6azHOmV+XOlowG/mUdBBD03HxzZG2EScv0L
         hIeV7XpORDo/LQwqgXXqenDZVi2LUixkxlzMS2WYWIgNLoPwPpnHDR0xGuFKVZN13U85
         3rfbzypcez2GDTm8bG9RECuVD7g7YArz7db5qpFeMx9aqywWgMj/lglfuAX+haJJk8l9
         jZ9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cM9MKe8fD8BzPq0UpNiHXcoSPyvddoL36Zhwd529f8c=;
        b=MWbJXfmh8EvsvjAJdNemxYchgugK0K39+iRsTA8QNH4zYZy1yGnYsb4nm74M29X3Vt
         fpse7dsnbVmrVNY3YJt14TSSJFvgnvK5fUwWWHba8nd7oymyXWsHtmWPeDJbuNSljKlt
         svVshXgn4nvCUB8pz1XWpktWALTnFAwWQ7v+KNDDt5+C5R6mUlsl8hr633iKPUfKldGm
         gACWaGjqIHTYy6utDyFUzhi+ktvnU3+NJRfmJCTMqofa5qDamLj4Y8QZKjE9sxLnnvLW
         96CeoROZ0p8P1NuFmtu1lMNNrzVxT99So2DULXkptB+JpbV77GZDqmoYT8S20BfxgyRv
         q1cQ==
X-Gm-Message-State: ANhLgQ3g39megz4rxRZDLQOyzpz6+OJuphlGPqIqU9cvmKlSMcmat6eX
        3W4zuKw8C4Gkc7853tzZED0Hr35l0lbO1siinZNuVAQ=
X-Google-Smtp-Source: ADFU+vscRfcw/g0Ovh+NOlk2iVQ46NATmXmRVydYRrBR/JtlNDo+D5gDl6Uie6rQoWS9/vcuGvfVXOIn5IMMiX+y62c=
X-Received: by 2002:a50:a7a5:: with SMTP id i34mr4431655edc.128.1583515478221;
 Fri, 06 Mar 2020 09:24:38 -0800 (PST)
MIME-Version: 1.0
References: <158343867316.158870.5386750405980710812.stgit@chester>
 <CAFqZXNuy8VjV8v8O5-zr3N7zq+Tntu6WBvaTFQ-+VUUyUqOHeQ@mail.gmail.com> <CAHC9VhTMx0CoDZJZa1CDgYNeb7QJLsK+gGjhS38v+WmKa=PW_A@mail.gmail.com>
In-Reply-To: <CAHC9VhTMx0CoDZJZa1CDgYNeb7QJLsK+gGjhS38v+WmKa=PW_A@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Fri, 6 Mar 2020 12:24:27 -0500
Message-ID: <CAHC9VhS987Ti9ufdfL5j85ZzyiT152LUVf7bQMaH-uiu+6UPew@mail.gmail.com>
Subject: Re: [PATCH] selinux: avtab_init() and cond_policydb_init() return void
To:     Ondrej Mosnacek <omosnace@redhat.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Mar 6, 2020 at 8:39 AM Paul Moore <paul@paul-moore.com> wrote:
> On Fri, Mar 6, 2020 at 5:12 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> >
> > On Thu, Mar 5, 2020 at 9:04 PM Paul Moore <paul@paul-moore.com> wrote:
> > > The avtab_init() and cond_policydb_init() functions always return
> > > zero so mark them as returning void and update the callers not to
> > > check for a return value.
> > >
> > > Suggested-by: Ondrej Mosnacek <omosnace@redhat.com>
> >
> > This was originally suggested by Stephen - you should credit him, not
> > me :) I only expressed my preference to still keep the functions,
> > since Stephen was considering removing them completely.
>
> Ooops, sorry Stephen!
>
> Fixed in my local copy, and assuming I don't hear any objections in
> the next few hours I'll go ahead and merge it.  It's a pretty trivial
> patch anyway.

Time is up.  I just merged the patch into selinux/next.

-- 
paul moore
www.paul-moore.com
