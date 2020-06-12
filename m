Return-Path: <SRS0=GKMn=7Z=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F727C433E0
	for <selinux@archiver.kernel.org>; Fri, 12 Jun 2020 19:00:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E430A207F7
	for <selinux@archiver.kernel.org>; Fri, 12 Jun 2020 19:00:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="arlH+lyM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726372AbgFLTAr (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 12 Jun 2020 15:00:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726308AbgFLTAq (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 12 Jun 2020 15:00:46 -0400
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0ADE1C03E96F
        for <selinux@vger.kernel.org>; Fri, 12 Jun 2020 12:00:45 -0700 (PDT)
Received: by mail-ed1-x542.google.com with SMTP id w7so7179000edt.1
        for <selinux@vger.kernel.org>; Fri, 12 Jun 2020 12:00:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Z1eUDni4J8foMKPbnyvJWBLeCKJvOoSY3c/BShfKfxc=;
        b=arlH+lyMjtxvC6iCN4FQWMIMonxOo0Xsn/3wjn7zFqXAcoQobVVT6dIe1mSQICMBIK
         UlKYvdBKHqqIEzc3ajgRSQmjOeJGlXFHrioBsM7jd+NZ9cdUNsr7hP6gu0VhKl76/axR
         cU6GpzCXS+Bz5MaeWsxZrqkhcb1AC4JqjQGo+9R/PRReo3U2SU7tcoV4rOzsU2mlyloR
         ho4ZnOkUReDIEkQo4LzgPXqCLF1vh4vMPqyg/JG5HWFi7ECIJefV4qMg3fxQ1tpHm7mW
         A17ncxO7iRrrggc0gkXhv1lvFUUCnLFo6t0gsrfOxiAd6q/79JcQ3OjnG3KoXAxvYB26
         9P/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Z1eUDni4J8foMKPbnyvJWBLeCKJvOoSY3c/BShfKfxc=;
        b=ZPtj2FKmrxXi3TRBbMaq/JVKNaiaPuV5bhvPrxwk61EpTob4idX2kgbr3F9nP+7U6L
         Imfr+ip4IBcTBbiemddUq62etif9uLqcUp2QZT0deTSjYTDPT3gUtuv4VR+auwX+xSJT
         G1Xfgd9LjHoO1DnRNRaAs249pz4s1AXnec3LRXhqouZeWtSsaGCyqRA9oUJHGWeg1zzP
         xlShoJvoSgtwAlj4K1f4mxlzKpzxtDb7Bbzh+exRVzKyFiyAzZT7/KuAxAK5TBkml5ST
         Rxx1GkG8Na7+X2IHgXH2mu5wH+xfNjo+Mphg0IDjt0TR22Dk5mjCs9bMnOPvT82oaXaO
         L4vA==
X-Gm-Message-State: AOAM531dU+EcWIbeTUQwxupf7g0nZngQZZRNMi42egG8AKq5NMd+vMkB
        tMUCQXXNb+/pmK4u21T94w4f3ORNi15xt92C0Oci
X-Google-Smtp-Source: ABdhPJzNjUGKE6Tt16vB5CE/ZibBhd0PNStzSv7+2O4YwqB0Tcd6vFYNI9f2jnnwHMg1+pJSKQGpLMbn6ozIJKsZpQ0=
X-Received: by 2002:aa7:de08:: with SMTP id h8mr12678180edv.164.1591988444536;
 Fri, 12 Jun 2020 12:00:44 -0700 (PDT)
MIME-Version: 1.0
References: <159110207843.57260.5661475689740939480.stgit@chester>
 <CAHC9VhQacYKE4sJRbqmpudXfMyzCT8VM0SFUCi=o-MNsn4c_MA@mail.gmail.com>
 <CAEjxPJ5oGWygz87dQw1HbP2wZovc+Q7ESKSF0zBMF_cSwxRdww@mail.gmail.com>
 <CAHC9VhSsY+MtSrj17g+p3FMeaKQ-Mjjy=iXS+1TbhCKGAn_yxA@mail.gmail.com>
 <CAEjxPJ6nLAOjLvhswyLNCUO8bUuwm_h7emFp7dZXDzRjMuG2HA@mail.gmail.com>
 <CAEjxPJ47H1_PQ1HnJhqV4yWz_u1vvWR=Q6T999Xm92z04OimqQ@mail.gmail.com> <CAEjxPJ6KQAc5YmrZNHU=Wr9xZ5+v6o3BYiV4+1NRzpfMhw7BJA@mail.gmail.com>
In-Reply-To: <CAEjxPJ6KQAc5YmrZNHU=Wr9xZ5+v6o3BYiV4+1NRzpfMhw7BJA@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Fri, 12 Jun 2020 15:00:33 -0400
Message-ID: <CAHC9VhRCcFn=b=g5AqZmWSgo+Vb2ehJJwcQCHsNYWaxa3RhT-g@mail.gmail.com>
Subject: Re: [RFC PATCH] selinux: runtime disable is deprecated, add some
 ssleep() discomfort
To:     Stephen Smalley <stephen.smalley.work@gmail.com>
Cc:     Ondrej Mosnacek <omosnace@redhat.com>,
        SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Jun 10, 2020 at 10:11 AM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
> Ondrej might want to check that it doesn't break RHEL either but I
> wouldn't really expect this to get back-ported to RHEL anyway unless
> they want the additional hardening gain from being able to make the
> LSM hooks read-only after initialization.

FWIW, my opinion regarding pay-for-support distros is that while I
would prefer not to break them, if the right thing for upstream and
community distros is to do thing "X", we should do thing "X".

IBM/RH has a bunch of people who get paid to make sure RHEL keeps
working, I trust they can manage RHEL just fine ;)

-- 
paul moore
www.paul-moore.com
