Return-Path: <SRS0=Kf9N=CD=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5ACBC433E1
	for <selinux@archiver.kernel.org>; Tue, 25 Aug 2020 17:50:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B8C2D207D3
	for <selinux@archiver.kernel.org>; Tue, 25 Aug 2020 17:50:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598377813;
	bh=DRMmvoHAahR60w6HO9LbtYVUvEGwTgZ3p45sYk+ndmw=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=O7Dy220CZgi57kt3x0tcEUo8lKqe2y6zbv5kv6d3170EXq1VtUd/mRUnKqG65sLWh
	 2bGoHHCbIoddZGIH+Wb7GjdKYqYyquFHLlZvnUFjM9cEuVb4utO4BS2UzRmhnxyD9i
	 syXD15aEh9SrC7VbiRgN0n9afKkuRQqCxRIRiddY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726187AbgHYRuM (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 25 Aug 2020 13:50:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:59728 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726090AbgHYRuM (ORCPT <rfc822;selinux@vger.kernel.org>);
        Tue, 25 Aug 2020 13:50:12 -0400
Received: from paulmck-ThinkPad-P72.home (unknown [50.45.173.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 92F1020782;
        Tue, 25 Aug 2020 17:50:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598377811;
        bh=DRMmvoHAahR60w6HO9LbtYVUvEGwTgZ3p45sYk+ndmw=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=JNl+pLZLt4DhJDIJ/ARRQrv5tjMJNw9di9rnAftriIRNxgYawiCh8LGip8GYXKwH8
         rZ+1WbP/x2ncgOMBqGO314mZGJ1eB1tmEi4LOp6uzKOtD0/TCgylYOcYL9YCkjLV/s
         rI/LUuXY/IQtjnSMJVNod2tHTZKcw9hc231yNwQQ=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 65B8035226AE; Tue, 25 Aug 2020 10:50:11 -0700 (PDT)
Date:   Tue, 25 Aug 2020 10:50:11 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Stephen Smalley <stephen.smalley.work@gmail.com>
Cc:     Ondrej Mosnacek <omosnace@redhat.com>,
        SElinux list <selinux@vger.kernel.org>,
        Paul Moore <paul@paul-moore.com>,
        Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        rcu@vger.kernel.org
Subject: Re: [RFC PATCH 3/3] selinux: track policy lifetime with refcount
Message-ID: <20200825175011.GU2855@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200825152045.1719298-1-omosnace@redhat.com>
 <20200825152045.1719298-4-omosnace@redhat.com>
 <CAEjxPJ54cS+HOPxb839UWu3UiCbv=eMRAfyRHbCy_5bAxU0a6A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEjxPJ54cS+HOPxb839UWu3UiCbv=eMRAfyRHbCy_5bAxU0a6A@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Aug 25, 2020 at 12:45:43PM -0400, Stephen Smalley wrote:
> On Tue, Aug 25, 2020 at 11:20 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> >
> > Instead of holding the RCU read lock the whole time while accessing the
> > policy, add a simple refcount mechanism to track its lifetime. After
> > this, the RCU read lock is held only for a brief time when fetching the
> > policy pointer and incrementing the refcount. The policy struct is then
> > guaranteed to stay alive until the refcount is decremented.
> >
> > Freeing of the policy remains the responsibility of the task that does
> > the policy reload. In case the refcount drops to zero in a different
> > task, the policy load task is notified via a completion.
> 
> That's an interesting pattern.  Is this approach used anywhere else in
> the kernel?  I didn't see any examples of it in the RCU documentation.

The function txopt_get() in include/net/ipv6.h uses something quite
similar.  By convention, rcu_pointer_handoff() is (sometimes) used to
indicate that the pointer is now protected by something other than RCU,
as shown in that function.  And grepping for rcu_pointer_handoff()
can find you a few more.

							Thanx, Paul

> > The advantage of this change is that the operations that access the
> > policy can now do sleeping allocations, since they don't need to hold
> > the RCU read lock anymore. This patch so far only leverages this in
> > security_read_policy() for the vmalloc_user() allocation (although this
> > function is always called under fsi->mutex and could just access the
> > policy pointer directly). The conversion of affected GFP_ATOMIC
> > allocations to GFP_KERNEL is left for a later patch, since auditing
> > which code paths may still need GFP_ATOMIC is not very easy.
> 
> Technically we don't need this patch for that purpose because
> rcu_read_lock() isn't actually needed at all in
> security_read_policy(), so I think we're better off just getting rid
> of it there and letting it use rcu_dereference_check(..., 1) or
> rcu_dereference_protected() instead.
