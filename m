Return-Path: <SRS0=EhYF=QI=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C24CC282D8
	for <selinux@archiver.kernel.org>; Fri,  1 Feb 2019 16:25:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2090521726
	for <selinux@archiver.kernel.org>; Fri,  1 Feb 2019 16:25:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="fDOg0As+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729037AbfBAQZq (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 1 Feb 2019 11:25:46 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:36826 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727857AbfBAQZq (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 1 Feb 2019 11:25:46 -0500
Received: by mail-lf1-f65.google.com with SMTP id a16so5514021lfg.3
        for <selinux@vger.kernel.org>; Fri, 01 Feb 2019 08:25:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=z5XemkztwYqZp9TuMU5XTLo+6D5Lu6ccLZufiQBqPLM=;
        b=fDOg0As+PgeUBhyjK9oHcNrktVJB3WIP/9mxFTY0/m+yUx2y7YX7fredFFGaRbnJO/
         A0pr2P0nLcH2O2Bnkz8TJOeOsUypwuSM6dUVwZAGnmV6Cdd2qAmFGhn6ukMdoZuhyrdq
         ZGaystSr7wGcT1QKIRsG+WA5J4IuRsWLb2KXQrc13FF6DomIhPnawUSKFfMfgeN3EDdh
         mQzujl4hZaJiSWpQ5+06iTuD4zEAdhVh7+cWSZHTGGXioH0v7C5mN25fBU7ccuKFzCGR
         SN9j9KWsX/m6W4k/OIjWn/P3hD7FEM84RlK1p5LuchpcYNh3NPx5HRWtS27Nh1AQ7uJV
         gIkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=z5XemkztwYqZp9TuMU5XTLo+6D5Lu6ccLZufiQBqPLM=;
        b=a/r8wO0GROjQBOvSLSWly9LKaBevB6BwgukKrnqRf9XoFPw/pLqcWko0ClJKvngjF8
         ey1wmpPOWtP2hJsKt4jbQDRwJu0ooIMeQ1x0R2KwnTqM5a22rvY5ER9Rby5r9V3DAm+K
         Sg33kyWBQO3qCiIDLrJvREBvwTI2Irpy15ArbRnb+Eg3zDX85quCBu0p2WdoUrbIvoR5
         gmsS3ceRQw8bjmFutwqM+AwaepfNqnm73HafeEBPcbIAq+x69gT7SCrsHOBxNybUgPqY
         vXEgr0L9nl4gN8h/LZ5E2/0N7URjWNf8tCu23XsnyYixUkXbLaiOXQV5BFW08Z62nbLX
         DIfg==
X-Gm-Message-State: AJcUukdChQePhWdMk2TEDJLR6J4GwDdN7DKCkyjxHy4Y7pituRJenafP
        JnBBv9QB8WMSh/8yJHpE1gvdSHZPIegt1YhID7B7
X-Google-Smtp-Source: ALg8bN5Gy2/ooekQaPXlkNQguPL0fuK9sLKLjo9l3hQHfxs2wzdLDJkAXNVEBv1bt6wuXaF6Ujm0luWT/uwoDagGI6c=
X-Received: by 2002:a19:cbcc:: with SMTP id b195mr30967231lfg.117.1549038343561;
 Fri, 01 Feb 2019 08:25:43 -0800 (PST)
MIME-Version: 1.0
References: <20190127081023.21124-1-leon@kernel.org> <CAHC9VhQccU9sD7Zb+6d9sPK=fq593R1-UOhVfwgiK-6usrkbQw@mail.gmail.com>
 <b558e86b-dc56-d17a-30c0-0b640f0bf6cc@mellanox.com> <CAHC9VhQTq_UTFkBOSb0fWbde6tsb_uiNi8EHdCovKzB8KkD6XA@mail.gmail.com>
 <40feb71f-d24c-f592-58d0-fc5814307c6c@redhat.com> <CAHC9VhSzNjVFq-aiUrS2og0sMUwNB+aBwtk7ZWj9dss12xfVOQ@mail.gmail.com>
 <0ef02f27-0e16-bcf0-3c30-7c7939cc9731@redhat.com>
In-Reply-To: <0ef02f27-0e16-bcf0-3c30-7c7939cc9731@redhat.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Fri, 1 Feb 2019 11:25:32 -0500
Message-ID: <CAHC9VhQEAU8uzBHhvazUSZqH9TeQk7GqTe9V7kqSZKE0utoDgA@mail.gmail.com>
Subject: Re: [PATCH rdma-next] IB/core: Don't register MAD agents for LSM notifications
To:     Don Dutile <ddutile@redhat.com>
Cc:     Daniel Jurgens <danielj@mellanox.com>,
        Leon Romanovsky <leon@kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        "selinux@vger.kernel.org" <selinux@vger.kernel.org>,
        Leon Romanovsky <leonro@mellanox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Feb 1, 2019 at 9:21 AM Don Dutile <ddutile@redhat.com> wrote:
> On 01/29/2019 12:30 PM, Paul Moore wrote:
> > On Mon, Jan 28, 2019 at 9:57 PM Don Dutile <ddutile@redhat.com> wrote:
> >> On 01/28/2019 06:03 PM, Paul Moore wrote:
> >>> On Mon, Jan 28, 2019 at 11:57 AM Daniel Jurgens <danielj@mellanox.com=
> wrote:
> >>>> On 1/28/2019 10:37 AM, Paul Moore wrote:
> >>>>> On Sun, Jan 27, 2019 at 3:10 AM Leon Romanovsky <leon@kernel.org> w=
rote:
> >>>>>> From: Daniel Jurgens <danielj@mellanox.com>
> >>>>>>
> >>>>>> ---
> >>>>>>    drivers/infiniband/core/security.c | 34 ++++-------------------=
-------
> >>>>>>    include/rdma/ib_mad.h              |  3 ---
> >>>>>>    2 files changed, 4 insertions(+), 33 deletions(-)
> >>>>> Perhaps predictably, I'm not very excited about this change.  Have =
you
> >>>>> looked closer into the slowdown to see where the cycles are being
> >>>>> spent?  I'm wondering if the issue is that a large number of notifi=
ers
> >>>>> are being registered with the same priority causing the while loop =
in
> >>>>> notifier_chain_register() to take a significant amount of time.
> >>>>
> >>>> That's what's happening, each MAD agent is registering it's own noti=
fier. The bug reporter was creating hundreds or thousands of  short lived M=
AD agents. With IRQs disabled too long it resulted in timeouts.
> >>>>
> >>>> When I initially added the notifier mechanism I thought it was you t=
hat said it wasn't really needed, since access wasn't generally revoked in =
these types of scenarios. Given that I didn't think this would be especiall=
y controversial. It was nice to have, unfortunately it causes problems even=
 for users that don't enable SELinux.
> >>>
> >>> Revoking permission is difficult, and in some cases likely impossible=
,
> >>> but that doesn't mean we shouldn't try to make it possible when we
> >>> can.  I'd like to see if we can sort this out before we give up and
> >>> rip it out.
> >>
> >> Agree that it'd be nice to see it work, but since few (no other?) subs=
ys registered
> >> with selinux/security is doing this, can we 'release' the IB mad agent=
s from this
> >> 'imprisonment' and figure out a general solution that resolves this is=
sue, and
> >> then it can be implemented not only for ib mad packet access, but for =
other
> >> subsys using selinux/security, and wanting the same revocation support=
.
> >
> > If you scroll up, ever so slightly to my last reply (it's just a few
> > lines, I'll wait), you'll see where I said "I'd like to see if we can
> > sort this out before we give up and rip it out."
> >
> > I don't recall at the moment why the notifier approach was taken with
> > the IB hooks back when Daniel wrote the code, and I'm definitely not
> > sure what other subsystems you are using for your comparisons here,
> > but I can tell you that I am beyond sick and tired of hearing people
> > immediately jump to "rip out this security code" because of some
> > performance glitch.  I care about performance too, okay?  We've got a
>
> I didn't advocate for ripping out the security code; I advocated to elimi=
nating
> the notifier callback, not setup by many other subsystem selinux consumer=
s,
> so the notifier performance issue could be resolved.
> I see this as a notifier perf issue, not a security issue.

In the original patch Daniel posted, removing the notifier callback
resulted in the removing the security_ib_endport_manage_subnet() call,
which is removing security code.  I described one way to remove the
MAD LSM notifier entirely (basically move the LSM hook down into
ib_mad_enforce_security()) as well as one way to reduce it's usage
(group MAD agents together); it looks like Daniel is taking the latter
approach.  Either option should mitigate the locking issue we're
currently seeing while preserving the access controls of the current
code.

For the record, the IB code has a LSM notifier callback here because
it is caching an access decision (ib_mad_agent.smp_allowed) so the IB
code needs to be notified when the LSM's security policy changes so it
can update it's cached access control decision.  You don't see the
notifier used in other kernel subsystems because they don't cache
access decisions like IB does.  This is why the claim of IB being
unfairly singled out with the LSM notifier is misleading, and not
correct IMHO.

> > bunch of clever people here, let's spend some time and see if we can
> > improve what we've got before we make some knee jerk reaction and just
> > rip out the access controls.
>
> It's not knee jerk.  I spent hours hacking away at the RHEL implementatio=
n
> to skip notification registration if selinux is disabled... the short-ter=
m 'hack'
> for the impacted user(s), since the users weren't enabling selinux. :(
> *but*, I'm looking for a long-term, selinux-enabled solution.

Removing the LSM hook without making some effort at preserving the
access control made it look like a knee jerk to me, but perhaps I've
seen this stuff too often and it strikes a nerve.  Regardless, it
looks like we have some options now for a long(er) term solution which
should address both our concerns.

--=20
paul moore
www.paul-moore.com
