Return-Path: <SRS0=6oqa=Y7=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADA6CC43331
	for <selinux@archiver.kernel.org>; Thu,  7 Nov 2019 16:44:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8046E21D7E
	for <selinux@archiver.kernel.org>; Thu,  7 Nov 2019 16:44:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573145076;
	bh=pPp4H0wjF+7am8DoET7WYe+RbyDGhUJIEGJPRzVQM0I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=XVy25hbwNESr6oBayQl1mVZz3967fcJ+E1R5bAoCU9pFRkvvqmqsMtUh9InJlcDIf
	 sEfuB58uOTfLLmq9fq+Bz0YeFjHCEOljD8EBkjCy/tzqDfej4u8FvQO27uBWYjyipl
	 GbXEIIS3FEZBVw20yv98/3H7dKeFNl7XguKZXaRs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730303AbfKGQog (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 7 Nov 2019 11:44:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:46486 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729451AbfKGQog (ORCPT <rfc822;selinux@vger.kernel.org>);
        Thu, 7 Nov 2019 11:44:36 -0500
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CEBE521D79;
        Thu,  7 Nov 2019 16:44:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573145075;
        bh=pPp4H0wjF+7am8DoET7WYe+RbyDGhUJIEGJPRzVQM0I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=zx/uVFIPTHjsY9OFpgDUOADffzx+okfQhLCdsvLZEH75ov9vZMlv/oxa2kKSMsc2i
         PjqGNUZWKVfw9nSdDMDVCtHm2zdXEKXICfIOH3kaLeByeVKOwdOV7OkdTYte8d1BdS
         DScilU7soFT8CNTUrP05S/qOuMdW21Vjd6QKXYBk=
Date:   Thu, 7 Nov 2019 16:44:30 +0000
From:   Will Deacon <will@kernel.org>
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     Jeff Vander Stoep <jeffv@google.com>,
        SElinux list <selinux@vger.kernel.org>,
        Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        Jovana Knezevic <jovanak@google.com>
Subject: Re: [PATCH v5] selinux: sidtab: reverse lookup hash table
Message-ID: <20191107164430.GA13483@willie-the-truck>
References: <20191107101743.203699-1-jeffv@google.com>
 <CAFqZXNvn4tTgNcQ3-fFE5QN7dS93h2VNznZ-D=3m2gZ26di9hA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFqZXNvn4tTgNcQ3-fFE5QN7dS93h2VNznZ-D=3m2gZ26di9hA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Nov 07, 2019 at 05:12:53PM +0100, Ondrej Mosnacek wrote:
> On Thu, Nov 7, 2019 at 11:17 AM Jeff Vander Stoep <jeffv@google.com> wrote:
> > This replaces the reverse table lookup and reverse cache with a
> > hashtable which improves cache-miss reverse-lookup times from
> > O(n) to O(1)* and maintains the same performance as a reverse
> > cache hit.
> >
> > This reduces the time needed to add a new sidtab entry from ~500us
> > to 5us on a Pixel 3 when there are ~10,000 sidtab entries.
> >
> > The implementation uses the kernel's generic hashtable API,
> > It uses the context's string represtation as the hash source,
> > and the kernels generic string hashing algorithm full_name_hash()
> > to reduce the string to a 32 bit value.
> >
> > This change also maintains the improvement introduced in
> > commit ee1a84fdfeed ("selinux: overhaul sidtab to fix bug and improve
> > performance") which removed the need to keep the current sidtab
> > locked during policy reload. It does however introduce periodic
> > locking of the target sidtab while converting the hashtable. Sidtab
> > entries are never modified or removed, so the context struct stored
> > in the sid_to_context tree can also be used for the context_to_sid
> > hashtable to reduce memory usage.
> >
> > This bug was reported by:
> > - On the selinux bug tracker.
> >   BUG: kernel softlockup due to too many SIDs/contexts #37
> >   https://github.com/SELinuxProject/selinux-kernel/issues/37
> > - Jovana Knezevic on Android's bugtracker.
> >   Bug: 140252993
> >   "During multi-user performance testing, we create and remove users
> >   many times. selinux_android_restorecon_pkgdir goes from 1ms to over
> >   20ms after about 200 user creations and removals. Accumulated over
> >   ~280 packages, that adds a significant time to user creation,
> >   making perf benchmarks unreliable."
> >
> > * Hashtable lookup is only O(1) when n < the number of buckets.
> >
> > Changes in V2:
> > -The hashtable uses sidtab_entry_leaf objects directly so these
> > objects are shared between the sid_to_context lookup tree and the
> > context_to_sid hashtable. This simplifies memory allocation and
> > was suggested by Ondrej Mosnacek.
> > -The new sidtab hash stats file in selinuxfs has been moved out of
> > the avc dir and into a new "ss" dir.
> >
> > V3:
> > -Add lock nesting notation.
> >
> > V4:
> > -Moved to *_rcu variants of the various hashtable functions
> > as suggested by Ondrej Mosnacek and Will Deacon.
> 
> I may be misunderstanding the purpose of RCU, but isn't all this RCU
> stuff a big overkill when these entries are never removed? (Well, they
> are removed when the sidtab is being destroyed, at which point however
> no other threads are accessing them any more.) In my understanding,
> RCU basically makes sure that objects that you dereference in an RCU
> critical section are not destroyed until you leave it. Yes, it also
> helps you to dereference/update them safely, but that can be achieved
> on its own in a simpler way. Instead of using RCU here, I would
> instead suggest looking into adding an equivalent of
> list_for_each_entry_lockless()* for hlist and maybe introduce some
> suitable hlist_add_something() function that ensures consistency
> w.r.t. the lockless traversal (perhaps the WRITE_ONCE() in hlist_add()
> is already sufficient, but I'm not sure...).

If you use the existing _rcu accessors you will get correctly enforced
dependency ordering on the reader side and correctly placed release
ordering on the updater side. I don't think that's a big overkill, and
you can use the RCU accessors to achieve the lockless traversal.

hlist_add() is not safe against a concurrent traversal because the
WRITE_ONCE() provides no memory ordering guarantees, allowing the readers
to see an uninitialised node.

How exactly would list_for_each_entry_lockless() and hlist_add_something()
differ from the RCU variants, assuming they're implemented correctly?

Will
