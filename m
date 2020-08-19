Return-Path: <SRS0=v2nJ=B5=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA785C433DF
	for <selinux@archiver.kernel.org>; Wed, 19 Aug 2020 15:25:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A59A8208DB
	for <selinux@archiver.kernel.org>; Wed, 19 Aug 2020 15:25:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597850705;
	bh=iaA+WNhCw4EbWjD2gy+qmbkaEwBSod04paY74NU9FSE=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=PIdqvisrieEQgEBqXY7/oSKfKU6ze1pgdLtbQKKY465pFT07psQWfPX92iWltsrpI
	 fIOavlqBam/kd4g0kBjM8WUq1h1idsEMy4CzFgZvlB6Vd/UYqGHOVNSRwoC6ch+Js9
	 N3DDLpm8sZ7npyp7x//PAjwn47rWvXWdhQVRKDkk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728145AbgHSPZF (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 19 Aug 2020 11:25:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:36158 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726636AbgHSPZD (ORCPT <rfc822;selinux@vger.kernel.org>);
        Wed, 19 Aug 2020 11:25:03 -0400
Received: from paulmck-ThinkPad-P72.home (unknown [50.45.173.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EDB3820897;
        Wed, 19 Aug 2020 15:25:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597850703;
        bh=iaA+WNhCw4EbWjD2gy+qmbkaEwBSod04paY74NU9FSE=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=tlGHsMrcjqsYXsCn13qeqzIqm4GMqqe7HEF9zyrZuRo2QEdZm8QQiEd1u3o8+wZaF
         HIViDv+8mQdTvuAYK7A0FEXWAYny3lvnskwRRnMcoOXf3Al1sdWKNII+/wmtuXIIOP
         11mIYIE20M7bggdKk2ugBBngHo1Pae+OYyFBVsUY=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id CD8DF3522728; Wed, 19 Aug 2020 08:25:02 -0700 (PDT)
Date:   Wed, 19 Aug 2020 08:25:02 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     peter enderborg <peter.enderborg@sony.com>
Cc:     Stephen Smalley <stephen.smalley.work@gmail.com>,
        paul@paul-moore.com, omosnace@redhat.com, selinux@vger.kernel.org
Subject: Re: [RFC PATCH] selinux: Use call_rcu for policydb and booleans
Message-ID: <20200819152502.GY27891@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200818221718.35655-1-stephen.smalley.work@gmail.com>
 <e9c1967d-170f-86f0-2762-7ca36ea08e40@sony.com>
 <7fe5f8e9-1fd9-2a65-4117-5b0d35c3973e@gmail.com>
 <20200819131511.GS27891@paulmck-ThinkPad-P72>
 <15a4ba37-e5ac-6247-814b-d86c4c3c85eb@sony.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <15a4ba37-e5ac-6247-814b-d86c4c3c85eb@sony.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Aug 19, 2020 at 05:05:28PM +0200, peter enderborg wrote:
> On 8/19/20 3:15 PM, Paul E. McKenney wrote:
> > On Wed, Aug 19, 2020 at 08:06:25AM -0400, Stephen Smalley wrote:
> >> On 8/19/20 4:32 AM, peter enderborg wrote:
> >>
> >>>  From 8184ea3648b18718fdb460a30dfc7f848b7bc6a2 Mon Sep 17 00:00:00 2001
> >>> From: Peter Enderborg <peter.enderborg@sony.com>
> >>> Date: Wed, 19 Aug 2020 10:20:28 +0200
> >>> Subject: [RFC PATCH] selinux: Use call_rcu for policydb and booleans
> >>>
> >>> This patch adds call_rcu that moves sycronize out
> >>> out call path. In the callback we can no call
> >>> cond_resched so they have to be remvoed.
> >> If you look at the first version of my patch, I used call_rcu() but in a
> >> manner that avoided the need to remove cond_resched() or kvfree() calls from
> >> the freeing code by having the rcu callback just schedule_work() to free it
> >> later.  That follows the pattern used for freeing user namespaces, for
> >> example.  However, in re-reading the RCU documentation, my understanding is
> >> that one should use synchronize_rcu() followed by direct freeing whenever
> >> possible and this is possible from both the policy load and setting
> >> booleans.  Neither of them are very frequent operations nor so
> >> performance-critical that the cost of synchronize_rcu() would be considered
> >> unacceptable IMHO.  Thus, I don't believe we need to do this.
> > Indeed, synchronize_rcu() avoids things like callback flooding.
> > There are nevertheless cases where synchronize_rcu() can be a problem,
> > for example due to its relatively long latency (milliseconds at best).
> > But if this is an infrequent operation, that should not be an issue.
> >
> > If there nevertheless is a reason to avoid synchronize_rcu(), then
> > queue_rcu_work() gets you directly to a sleepable workqueue context
> > where cond_resched() can be used.
> 
> From what I have seen in usage of booleans the usage is
> switch-state, do-something, switch-back. So if there is anything
> security related you want switch time to be fast. But when I measured
> it was faster with synchronize_rcu than call_rcu.  booleans  work are
> smaller than a total policy load.

That sounds to me like a good argument for synchronize_rcu(), but I at the
end of the day, I must defer to you guys given your knowledge of this code.

								Thanx, Paul
