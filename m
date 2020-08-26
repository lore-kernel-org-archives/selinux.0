Return-Path: <SRS0=r6Mn=CE=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5811C433E1
	for <selinux@archiver.kernel.org>; Wed, 26 Aug 2020 14:12:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 810A921775
	for <selinux@archiver.kernel.org>; Wed, 26 Aug 2020 14:12:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Sz0sh3ol"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730403AbgHZOMO (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 26 Aug 2020 10:12:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:27197 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726894AbgHZOMM (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 26 Aug 2020 10:12:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1598451129;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=f5id1t0HMEFa8wkDX55GDW4UR23cGLaSx9qh5ssVJgc=;
        b=Sz0sh3olH9JSC2p02yHITXt8T42OMi6muOzYmkhsG1nNXvHimMmoWSgnA7ZSdA6FhI5qiR
        vq1hB3uMx6/iRhWNRL882XLUOck0L+0my0skzA1WkKaSdeMyq/u1E6H5noiJRn2cIBObHl
        tPZrvrulXl0mtDNnyawB/eamBdh1+8o=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-134-rj3wybbxPZahxBGHQVFc1Q-1; Wed, 26 Aug 2020 10:12:07 -0400
X-MC-Unique: rj3wybbxPZahxBGHQVFc1Q-1
Received: by mail-lf1-f72.google.com with SMTP id l7so720016lfd.17
        for <selinux@vger.kernel.org>; Wed, 26 Aug 2020 07:12:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=f5id1t0HMEFa8wkDX55GDW4UR23cGLaSx9qh5ssVJgc=;
        b=eTciqJcIisT767ZCZE84XXaT9FqUGevswXYZMuCaGx4VQgjSNKJYBHNtAvbk9IYT42
         +tUUYtmRzf1VauiDZrSl5C+rQWxWUo1fY/QMPXERzQvoDd9LWj0Y0CpIGNJFJAPcsez7
         sOEDJS+kSLRbXcHAMyDwFJFfjEgYLWGg/Hh2cmEjv5r1+V5SC1UmhXgMuYYwFTjl0ihK
         pBYgl525dmwAUBem44VKvgPYj/LwSPZIIoMWQkNLHbnEsUT4ww5LspA8pNiPDuh4uM9S
         u9065+hwJn4F1VG1yVtlsWP3vuk3fwULsfiqrmqe1dUYKW7WHl/w+bjQdORVC/hS88OE
         DyHw==
X-Gm-Message-State: AOAM532kW5aEcFLMydgSmNIzK/IJdEw1RJ/RNs99H5+piMFtsqrN9/dz
        CZdhDFHqQKkEyqsJGzeDaI3BNhvShf79KRJ5zgVpRJkJVRN0EuaW2nIar5GpfFymDGFKZ3oBFzx
        8ZLH0hj2d01gBpWa23W1jkmfgXEi/gWT1AQ==
X-Received: by 2002:a2e:9550:: with SMTP id t16mr6816969ljh.372.1598451125420;
        Wed, 26 Aug 2020 07:12:05 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzl0ZGvi5iJ69ulpZx3SVETAbw6pHpK45A7uwiPuv3NutMqCF4njYVb2KH9VSG4szds1RQZbTmq4DjHj1/4Aj0=
X-Received: by 2002:a2e:9550:: with SMTP id t16mr6816956ljh.372.1598451125140;
 Wed, 26 Aug 2020 07:12:05 -0700 (PDT)
MIME-Version: 1.0
References: <20200825065953.1566718-1-omosnace@redhat.com> <20200825065953.1566718-2-omosnace@redhat.com>
 <CAEjxPJ4JKHKFgF9VobJTrMBDhaqC0EKorC=qfm=t77Krd-Npsw@mail.gmail.com>
 <CAFqZXNtOd7VXQWh9B3fnmY0MUy0HLHh75u_=6UE7UaTO2ZjYSw@mail.gmail.com>
 <CAEjxPJ7_zk63cyHEPeyrhPgDRJ_jzzx8kyQACvWiNoC3-KzLsA@mail.gmail.com> <CAHC9VhSBsTU++65fPqZvdvdT_Ja+zaj-toUSa6iVLBCt8vQOBw@mail.gmail.com>
In-Reply-To: <CAHC9VhSBsTU++65fPqZvdvdT_Ja+zaj-toUSa6iVLBCt8vQOBw@mail.gmail.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Wed, 26 Aug 2020 16:11:54 +0200
Message-ID: <CAFqZXNuvciwq4ApXWxR14nqezDZEJSunTONXy-dmfYmu84Mq6g@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] selinux: switch unnecessary GFP_ATOMIC allocs to GFP_KERNEL
To:     Paul Moore <paul@paul-moore.com>
Cc:     Stephen Smalley <stephen.smalley.work@gmail.com>,
        SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Aug 26, 2020 at 3:51 PM Paul Moore <paul@paul-moore.com> wrote:
> On Wed, Aug 26, 2020 at 9:02 AM Stephen Smalley
> <stephen.smalley.work@gmail.com> wrote:
> > Generally the core SELinux permission checking code assumes it can be
> > called from any context (including hardirq) and under any locking
> > conditions, and hooks that are for permission checking (not security
> > blob allocation/management) do the same.  This allows permission
> > checks to be performed while locks are held by the caller. and from
> > arbitrary contexts  I'd be inclined to just leave selinux_lockdown
> > unchanged given that it might be called anywhere much like capable().
>
> Agreed.  The code paths relating to policy load, etc. are good
> candidates for an ATOMIC->KERNEL conversion, assuming no other
> constraints, but I'm somewhat nervous of converting stuff in hook.c
> that doesn't have a hard sleep-ability defined.

OK, I can drop the selinux_lockdown() hunk then. The other hooks.c
hunks both have an existing GFP_KERNEL allocation in the same
function, so I'd tend to keep them for consistency. Or do you want me
to rather convert the GFP_KERNELs to GFP_ATOMICs there?

>
> The other question about this patchset is motivation: were you seeing
> problem reports relating to SELinux memory failures when the system
> was under pressure, or is this preemptive?

No, I just went over the GFP_* usage in security/selinux/ when scoping
how many GFP_ATOMIC ones could be changed to GFP_KERNEL after the
refcount patch and found these that could be switched right away.

--
Ondrej Mosnacek
Software Engineer, Platform Security - SELinux kernel
Red Hat, Inc.

