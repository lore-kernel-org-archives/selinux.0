Return-Path: <SRS0=6oqa=Y7=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C8DCC43331
	for <selinux@archiver.kernel.org>; Thu,  7 Nov 2019 18:41:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6993921D6C
	for <selinux@archiver.kernel.org>; Thu,  7 Nov 2019 18:41:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Rxa99sAe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725906AbfKGSlq (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 7 Nov 2019 13:41:46 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:40527 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725883AbfKGSlq (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 7 Nov 2019 13:41:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1573152105;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UCpKGoErVzmXyjf2TFgQMFUH2hDgQfMHnjAtuL8MS08=;
        b=Rxa99sAeaDpKTYFQW9MnTmOZ7e6Wzx/CjX/syAx/h9R2FMZJgPmruo4/XtwTRUvXLrAsjS
        1mge6aexJhJT7RrzIPDw27+nPP5EV8Nb4z9bDEW4do4pHqNTPuRBZ+JQQ0UR1i/YvKl5lY
        kebFhHvhaLMDOfhKcmifzQ0IBkAjcLc=
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com
 [209.85.167.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-59-bSHZWllnOnO5Nz3_1MUEug-1; Thu, 07 Nov 2019 13:41:43 -0500
Received: by mail-oi1-f198.google.com with SMTP id l67so2699088oih.4
        for <selinux@vger.kernel.org>; Thu, 07 Nov 2019 10:41:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=48DbZA62zyu/yWyBm1HiEotEzfpSeTWK5KCDEdznsCc=;
        b=tKfvHxqPpxfTu8pQSZB06KHDGX0jm4H40J+efGChdKsvDUqz8/r46sDKWw6TKUhMCi
         VWEl+pMety/cs574eTZDHWjrRcPMoxHfmctXt8dgL0K8kg53eedDjIChuhW3aMTyGcqO
         j1XSfPL/CxUKBXaTpzqwIY0CHfplAJlDh4waF9NuY9yU4SZpmClljnUnNbByoQlBKpTv
         sS9dAcfBIYhGmujQ9HwNBVhtdg0Owl3ivUKu3tGXwPksxUHw0yBHfn5m9E6hX7OyazF2
         eZJSmtnViEJIhs49+3TWjH6AtXcft+Z15YFNiq19j6whpkdTIKPf87NELyjPNQn0EA2b
         Lc9A==
X-Gm-Message-State: APjAAAWWzcMpHOu862//Z1AVmo4gANvqoRcj5p73hHNuriSiMcd+KBLd
        XnHMTFsdUNRZOzOSkDPbspCRv0QYvKno/FC9HvaIrOsV5yMi6JBcKURs75XO2IulJU+GtHuAE45
        b13F/RN62ip1PFewAD+9i+UIW3fiNdiXQsg==
X-Received: by 2002:a9d:7642:: with SMTP id o2mr4324166otl.66.1573152102941;
        Thu, 07 Nov 2019 10:41:42 -0800 (PST)
X-Google-Smtp-Source: APXvYqybrcbt8P8xxtV3pT9tCSdlpfpVH2zpsmumMDDz2oAPpFdhdoC8p08rq6uxbR53WlEy7Pkd7r8254NP6u0b6Rc=
X-Received: by 2002:a9d:7642:: with SMTP id o2mr4324141otl.66.1573152102631;
 Thu, 07 Nov 2019 10:41:42 -0800 (PST)
MIME-Version: 1.0
References: <20191107101743.203699-1-jeffv@google.com> <CAFqZXNvn4tTgNcQ3-fFE5QN7dS93h2VNznZ-D=3m2gZ26di9hA@mail.gmail.com>
 <20191107164430.GA13483@willie-the-truck>
In-Reply-To: <20191107164430.GA13483@willie-the-truck>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Thu, 7 Nov 2019 19:41:31 +0100
Message-ID: <CAFqZXNuCugt05+4nejHYvkAGrW+WMmwsRQv8pjKEhKxdBMDVew@mail.gmail.com>
Subject: Re: [PATCH v5] selinux: sidtab: reverse lookup hash table
To:     Will Deacon <will@kernel.org>
Cc:     Jeff Vander Stoep <jeffv@google.com>,
        SElinux list <selinux@vger.kernel.org>,
        Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        Jovana Knezevic <jovanak@google.com>
X-MC-Unique: bSHZWllnOnO5Nz3_1MUEug-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Nov 7, 2019 at 5:44 PM Will Deacon <will@kernel.org> wrote:
> On Thu, Nov 07, 2019 at 05:12:53PM +0100, Ondrej Mosnacek wrote:
> > On Thu, Nov 7, 2019 at 11:17 AM Jeff Vander Stoep <jeffv@google.com> wr=
ote:
> > > This replaces the reverse table lookup and reverse cache with a
> > > hashtable which improves cache-miss reverse-lookup times from
> > > O(n) to O(1)* and maintains the same performance as a reverse
> > > cache hit.
> > >
> > > This reduces the time needed to add a new sidtab entry from ~500us
> > > to 5us on a Pixel 3 when there are ~10,000 sidtab entries.
> > >
> > > The implementation uses the kernel's generic hashtable API,
> > > It uses the context's string represtation as the hash source,
> > > and the kernels generic string hashing algorithm full_name_hash()
> > > to reduce the string to a 32 bit value.
> > >
> > > This change also maintains the improvement introduced in
> > > commit ee1a84fdfeed ("selinux: overhaul sidtab to fix bug and improve
> > > performance") which removed the need to keep the current sidtab
> > > locked during policy reload. It does however introduce periodic
> > > locking of the target sidtab while converting the hashtable. Sidtab
> > > entries are never modified or removed, so the context struct stored
> > > in the sid_to_context tree can also be used for the context_to_sid
> > > hashtable to reduce memory usage.
> > >
> > > This bug was reported by:
> > > - On the selinux bug tracker.
> > >   BUG: kernel softlockup due to too many SIDs/contexts #37
> > >   https://github.com/SELinuxProject/selinux-kernel/issues/37
> > > - Jovana Knezevic on Android's bugtracker.
> > >   Bug: 140252993
> > >   "During multi-user performance testing, we create and remove users
> > >   many times. selinux_android_restorecon_pkgdir goes from 1ms to over
> > >   20ms after about 200 user creations and removals. Accumulated over
> > >   ~280 packages, that adds a significant time to user creation,
> > >   making perf benchmarks unreliable."
> > >
> > > * Hashtable lookup is only O(1) when n < the number of buckets.
> > >
> > > Changes in V2:
> > > -The hashtable uses sidtab_entry_leaf objects directly so these
> > > objects are shared between the sid_to_context lookup tree and the
> > > context_to_sid hashtable. This simplifies memory allocation and
> > > was suggested by Ondrej Mosnacek.
> > > -The new sidtab hash stats file in selinuxfs has been moved out of
> > > the avc dir and into a new "ss" dir.
> > >
> > > V3:
> > > -Add lock nesting notation.
> > >
> > > V4:
> > > -Moved to *_rcu variants of the various hashtable functions
> > > as suggested by Ondrej Mosnacek and Will Deacon.
> >
> > I may be misunderstanding the purpose of RCU, but isn't all this RCU
> > stuff a big overkill when these entries are never removed? (Well, they
> > are removed when the sidtab is being destroyed, at which point however
> > no other threads are accessing them any more.) In my understanding,
> > RCU basically makes sure that objects that you dereference in an RCU
> > critical section are not destroyed until you leave it. Yes, it also
> > helps you to dereference/update them safely, but that can be achieved
> > on its own in a simpler way. Instead of using RCU here, I would
> > instead suggest looking into adding an equivalent of
> > list_for_each_entry_lockless()* for hlist and maybe introduce some
> > suitable hlist_add_something() function that ensures consistency
> > w.r.t. the lockless traversal (perhaps the WRITE_ONCE() in hlist_add()
> > is already sufficient, but I'm not sure...).
>
> If you use the existing _rcu accessors you will get correctly enforced
> dependency ordering on the reader side and correctly placed release
> ordering on the updater side. I don't think that's a big overkill, and
> you can use the RCU accessors to achieve the lockless traversal.

OK, but you don't need the read_lock()/unlock(), rcu_head field in the
entries, and kfree_rcu(), right?

>
> hlist_add() is not safe against a concurrent traversal because the
> WRITE_ONCE() provides no memory ordering guarantees, allowing the readers
> to see an uninitialised node.

Right, so we would need a new function that does smp_store_release() instea=
d.

>
> How exactly would list_for_each_entry_lockless() and hlist_add_something(=
)
> differ from the RCU variants, assuming they're implemented correctly?

Looking at the implementation of rcu_dereference() and
rcu_assign_pointer(), they would probably be practically the same,
except the rcu_read_lock_held() check in rcu_dereference(). That and
they would clearly communicate that they are not doing actual RCU, but
just allow lockless traversal of an add-only hlist.

--
Ondrej Mosnacek <omosnace at redhat dot com>
Software Engineer, Security Technologies
Red Hat, Inc.

