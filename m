Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF4C3C433E0
	for <selinux@archiver.kernel.org>; Tue,  5 Jan 2021 14:23:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 94FDF2065C
	for <selinux@archiver.kernel.org>; Tue,  5 Jan 2021 14:23:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727036AbhAEOXS (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 5 Jan 2021 09:23:18 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:54736 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726600AbhAEOXS (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 5 Jan 2021 09:23:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1609856511;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Fyy5Be3v4INXlMATEBnRbwSv+oNMJK75sLHgTGDbPUs=;
        b=DBRoGWvusTMe+5SWTdm1DmGjDAI+A8E5o/azsJ6tUBi5QAt9QJwX5rBw4gX2KSLZWecL59
        0c9m7mQ8VmF7CqCU6VGI4wFLtIk3WJqH8kDoFYz52UB3H0VK8T1hTg/t4xhLXYdd4fQ4T5
        6FATzm3S4yB7ylFccaf9CTandmWCo+0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-376-cWu2kG3QN3SyR4dmI5GNcw-1; Tue, 05 Jan 2021 09:21:49 -0500
X-MC-Unique: cWu2kG3QN3SyR4dmI5GNcw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B829759;
        Tue,  5 Jan 2021 14:21:48 +0000 (UTC)
Received: from horse.redhat.com (ovpn-117-227.rdu2.redhat.com [10.10.117.227])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 874615D6CF;
        Tue,  5 Jan 2021 14:21:48 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id 1C219220BCF; Tue,  5 Jan 2021 09:21:48 -0500 (EST)
Date:   Tue, 5 Jan 2021 09:21:48 -0500
From:   Vivek Goyal <vgoyal@redhat.com>
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     Paul Moore <paul@paul-moore.com>, James Carter <jwcart2@gmail.com>,
        SElinux list <selinux@vger.kernel.org>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Daniel Walsh <dwalsh@redhat.com>,
        Zdenek Pytela <zpytela@redhat.com>
Subject: Re: virtiofs and its optional xattr support vs. fs_use_xattr
Message-ID: <20210105142148.GA3200@redhat.com>
References: <CAHC9VhSYt86rQJGg9JFD1ubL4N3PNmLg02sACOvRNHr94=41dg@mail.gmail.com>
 <CAP+JOzQ-s9ASgqFt7HVyY1R7JKQ85Ee-=iou0C5xRRvaSZo52Q@mail.gmail.com>
 <CAHC9VhQkSA5VteHfu8TyBp7wqDspoLCOP+sB7vaV4XCQ8vwBeA@mail.gmail.com>
 <CAFqZXNsfomoMTr+uhisdsj75c7ZdXmGCiDZBsDwtLUpkwEA76w@mail.gmail.com>
 <20201210221753.GB185111@redhat.com>
 <CAFqZXNsstwecRnQu3-Gybdo1xwJRPHmt1=ZYZqnXK-v6MT0kng@mail.gmail.com>
 <20201210223049.GC185111@redhat.com>
 <CAFqZXNu0_8__73NfNa9tR_iWiaGGqkfvhtOQts7mmnh8v9QWrA@mail.gmail.com>
 <20210104201458.GA74084@redhat.com>
 <CAFqZXNtSbFBPCTu+aOUt7JKaR_Gk1kAJ0ewgV1Ds8HhpyfafQg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFqZXNtSbFBPCTu+aOUt7JKaR_Gk1kAJ0ewgV1Ds8HhpyfafQg@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Jan 05, 2021 at 03:00:31PM +0100, Ondrej Mosnacek wrote:

[..]
> > > > > > > Okay, so I'll look into switching between use_xattr and use_genfs
> > > > > > > based on the availability of xattr support and the presence of
> > > > > > > corresponding rules in the policy. Thanks everyone for the fruitful
> > > > > > > discussion!
> > > > > >
> > > > > > Hi Ondrej,
> > > > > >
> > > > > > So this is now purely a policy change and no changes required in kernel?
> > > > > > If yes, then the patch Dan Walsh proposed, is that good enough or
> > > > > > it needs to be done in a different way.
> > > > >
> > > > > No, this needs a kernel change in SELinux to interpret the policy
> > > > > rules slightly differently *and* basically Dan's patch (modulo the
> > > > > typo in the genfscon keyword).
> > > >
> > > > Ok, thanks. Is this kernel change something you will be able to take
> > > > care of. I am afraid that I don't know enough to make this change.
> > >
> > > Yes, it's already on my todo list ;) But it might take some time as
> > > there are a lot of things competing for my attention right now...
> >
> > Hi Ondrej,
> >
> > Sorry to bother you on this. Just curious, if you got a chance to make
> > progress on this. Will like to solve the issue of SELinux blocking package
> > installation on virtiofs in VM based containers.
> 
> Hi,
> 
> I had a go at it today and I already have a tentative patch. So far
> it's passing my initial testing so I should be able to post it to the
> list soon.

Awesome. Looking forward to the final patch.

Vivek

