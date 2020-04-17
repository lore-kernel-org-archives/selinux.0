Return-Path: <SRS0=6dkg=6B=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12777C2D0EF
	for <selinux@archiver.kernel.org>; Fri, 17 Apr 2020 16:59:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DB56420771
	for <selinux@archiver.kernel.org>; Fri, 17 Apr 2020 16:59:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="YE8SLodB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728013AbgDQQ7Y (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 17 Apr 2020 12:59:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727913AbgDQQ7Y (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 17 Apr 2020 12:59:24 -0400
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 010ECC061A0C
        for <selinux@vger.kernel.org>; Fri, 17 Apr 2020 09:59:22 -0700 (PDT)
Received: by mail-ed1-x543.google.com with SMTP id d16so1987671edq.7
        for <selinux@vger.kernel.org>; Fri, 17 Apr 2020 09:59:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=04NkHXi+PwY9BSJltFl8mSuXJp2mIc+S/1/r3t62y+w=;
        b=YE8SLodByGOd+rm5xUZh0C0gSqL0bxPRbfdU0WS9RxReb3iIqQCYxJ/4w/js897/6u
         f1widm+GipXqhNOkCvt0l5JteWm1PkpilV7jI+Qos/4qQdHZGxt1kZyVlz4+rxpmD0oW
         +1cJ6oto0syR2PVYZBIB/Nk9LWyzHzR4bXVUmG9gOx4D5cNinoE0ogrPjywQI7PTvWdE
         G1o1M/j064YBQmNiUK9X+IXnX4aqEvYMvVumsBBLcG2EWjROf1WTCwUP+i/G4SsJ5jyf
         8C368PktpEZsWU5vsaIPMxanFpjVIxs4C9mlgBhRm8sQGHtgmvRd3pRHbuvck7wEnHsL
         5rFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=04NkHXi+PwY9BSJltFl8mSuXJp2mIc+S/1/r3t62y+w=;
        b=D2hS4masaPHl/XTVRQfAWsr4qTsfdXFsU0NQvy9kL0u+bcKpcOAdcwHj94XXIZYEmY
         aPxZ7KwtfW/dBOeeSS6tKnhs2DH0x/EvInH/GCAyM5iWKLzSz5EEMzr0w7p4IzJFl+E2
         MGXu29xCFlKOqKh/AtjpomXx8o+m/TsNSm2m0Mq3maY5DfBraULILTouUT7Ndd7MJgeC
         c+AaDUANO9X6xCmGhD7Su79ZFyI30nM5AgHvu0JXH2AbGmDQPjlGaC7y3KiClg2jDmgg
         TEFMmxBh11ZG9rmYXFm9JHn3RdrjjHCu+Ed+1xZXomNEzY9SleJXZQ583dn+fzKFi4MK
         prlg==
X-Gm-Message-State: AGi0PuaRBdAk4o+gsV+/jOobTpoEf4wC29KOU2hUee2g8EbpWZzNHFpr
        3+RAdPKncASt8ns9LCsSACcEdm7g4KEFchIi49ww
X-Google-Smtp-Source: APiQypIXLCfwICgpSyK/g0V1Gk4QDbVPh3cx9SkB08ZjMy0TQcd6CsugDzeQCPWhvb9tbm52Esiq2ol7z+/fB88qqVA=
X-Received: by 2002:aa7:c352:: with SMTP id j18mr3759570edr.196.1587142761495;
 Fri, 17 Apr 2020 09:59:21 -0700 (PDT)
MIME-Version: 1.0
References: <CAHC9VhT95GJKNTMvTtmZL35UOoVwbGH-eDWZyELb5oZ5rQU+Tw@mail.gmail.com>
 <56808ee47c8b6e184fd013b90072c6fb07ef84f2.camel@btinternet.com>
In-Reply-To: <56808ee47c8b6e184fd013b90072c6fb07ef84f2.camel@btinternet.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Fri, 17 Apr 2020 12:59:10 -0400
Message-ID: <CAHC9VhQLYNzs=uBqxwZCh=h8n-C3z-EAojQEmt6DCoJxCKL5-A@mail.gmail.com>
Subject: Re: Problem with 9ba09998baa9 ("selinux: Implement the watch_key
 security hook") in linux-next
To:     Richard Haines <richard_c_haines@btinternet.com>
Cc:     David Howells <dhowells@redhat.com>, keyrings@vger.kernel.org,
        selinux@vger.kernel.org, linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Apr 17, 2020 at 12:32 PM Richard Haines
<richard_c_haines@btinternet.com> wrote:
> On Fri, 2020-04-17 at 11:48 -0400, Paul Moore wrote:
> > I just notice that the "selinux: Implement the watch_key security
> > hook" patch made it's way into linux-next via 9ba09998baa9:
> >
> >   commit 9ba09998baa995518d94c9a32e6329b28ccb9045
> >   Author: David Howells <dhowells@redhat.com>
> >   Date:   Tue Jan 14 17:07:13 2020 +0000
> >
> >    selinux: Implement the watch_key security hook
> >
> >    Implement the watch_key security hook to make sure that a key
> > grants the
> >    caller View permission in order to set a watch on a key.
> >
> >    For the moment, the watch_devices security hook is left
> > unimplemented as
> >    it's not obvious what the object should be since the queue is
> > global and
> >    didn't previously exist.
> >
> >    Signed-off-by: David Howells <dhowells@redhat.com>
> >    Acked-by: Stephen Smalley <sds@tycho.nsa.gov>
> >
> > I'm reasonably confident that this code hasn't been tested as I
> > expect
> > it would fail, or at the very least behave in unintended ways.  The
> > problem is the selinux_watch_key(...) function, shown below:
>
> I built an selinx-testsuite test for this last year and it worked fine
> then. I'll send the test as an RFC patch as its been some time since I
> ran it. David also has a test in kernel
> samples/watch_queue/watch_test.c

See below.

> > +static int selinux_watch_key(struct key *key)
> > +{
> > +       struct key_security_struct *ksec = key->security;
> > +       u32 sid = current_sid();
> > +
> > +       return avc_has_perm(&selinux_state,
> > +                           sid, ksec->sid, SECCLASS_KEY,
> > KEY_NEED_VIEW, NULL);
> > +}
> >
> > ... in particular it is the fifth argument to avc_has_perm(),
> > "KEY_NEED_VIEW" which is a problem.  KEY_NEED_VIEW is not a SELinux
>
> True, however by magic the KEY_NEED_* perms match with the bits defined
> in classmap.h. I did some work on this during the 'keys' saga, see
> various emails in list like [1]
>
> [1]
> https://lore.kernel.org/selinux/20200220181031.156674-2-richard_c_haines@btinternet.com/

Esh, relying on the constants to line up is a recipe for disaster.  We
really need that permission translation layer.

-- 
paul moore
www.paul-moore.com
