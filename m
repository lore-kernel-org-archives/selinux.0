Return-Path: <SRS0=7tXC=QF=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A79EC169C4
	for <selinux@archiver.kernel.org>; Tue, 29 Jan 2019 17:30:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D74B21473
	for <selinux@archiver.kernel.org>; Tue, 29 Jan 2019 17:30:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="0Gy1wjgd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727610AbfA2Ran (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 29 Jan 2019 12:30:43 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:43440 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727492AbfA2Ran (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 29 Jan 2019 12:30:43 -0500
Received: by mail-lj1-f193.google.com with SMTP id q2-v6so18217755lji.10
        for <selinux@vger.kernel.org>; Tue, 29 Jan 2019 09:30:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=FUUxPXYWa4oxD0y3apD/Tetop9KnCHNkej8MTTiK/qg=;
        b=0Gy1wjgd9fhSDJbvIisPcXrbBC8eBCAIUsvo/vPsJjqAACQiR2adfuulMlrxkCs/Ch
         bUr6MIej+wAUlFmvQ1HdcwR9LNLEQOc2OyJ7Ix7/YgNwO+O+7pkCpnVhXFfQ2/VYzUHD
         ni18qljCt7T5mDaHa0p/WpVNchq3c2bT/nBjG146whVniFhj+5SHw1mj7W18MJPs599l
         bb1q28ZZhnOpBfR6zAboXynhM4EYvHkhBNOxcG4+myc7CCtIrm0bZ7NzW7+ZdqfpqvXR
         mV87lfkx1ttzS/Rw8h7jl0sCljWk9F1w0fhTY8ZXnhz01+5IzyI2V7iA638zlnM6f/dT
         LyFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=FUUxPXYWa4oxD0y3apD/Tetop9KnCHNkej8MTTiK/qg=;
        b=aFl2Tgklay1qt0ElCZn4VtGWWzHDElWZzBanYB9lZi5yOQue5jcBaZblYy1puoOveD
         fnr/sYDbUn3j2Ybj88KK8WjFxkPvu5zsHT/8JJV4y2rF/p2tFNK9sTW3X1osyAIseN13
         WvyD6fg4x9RK/IuZgqbO9MXHL1UFvpHUyh8/ikTM0fabtavcaq/navymp5UJ/uSTIa9a
         HH7+y0iQZ4FRTqx5WQGx/GCKf1UAwve1iLEK3lhdjwH+LYEJQJ2egkvjjQsbaPWfPsm4
         +u7yLR781fH5oLjoFjujs7yqhwwtDyiWMDfnYVpWLJBImpZUg5k1GWoUWYZ12sxJfmY7
         yRXQ==
X-Gm-Message-State: AHQUAubOsd4yIg1HM1BxfuL2uGaW05IDeaR5A7C2XgZZbuUw933EtmTK
        CeHqUT1o1PX4O+2dEJMQZYsrzvwj39l7YIldUy5u
X-Google-Smtp-Source: AHgI3IbnY29C3Avu7XEaGbK68TPTdOlKvycfv5uWjH0MsfsWMlo75eHH+V5iDzj8yXcRfG2TyhO43eoMHpRP4Sxop3M=
X-Received: by 2002:a2e:8546:: with SMTP id u6-v6mr7204453ljj.95.1548783040375;
 Tue, 29 Jan 2019 09:30:40 -0800 (PST)
MIME-Version: 1.0
References: <20190127081023.21124-1-leon@kernel.org> <CAHC9VhQccU9sD7Zb+6d9sPK=fq593R1-UOhVfwgiK-6usrkbQw@mail.gmail.com>
 <b558e86b-dc56-d17a-30c0-0b640f0bf6cc@mellanox.com> <CAHC9VhQTq_UTFkBOSb0fWbde6tsb_uiNi8EHdCovKzB8KkD6XA@mail.gmail.com>
 <40feb71f-d24c-f592-58d0-fc5814307c6c@redhat.com>
In-Reply-To: <40feb71f-d24c-f592-58d0-fc5814307c6c@redhat.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 29 Jan 2019 12:30:27 -0500
Message-ID: <CAHC9VhSzNjVFq-aiUrS2og0sMUwNB+aBwtk7ZWj9dss12xfVOQ@mail.gmail.com>
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

On Mon, Jan 28, 2019 at 9:57 PM Don Dutile <ddutile@redhat.com> wrote:
> On 01/28/2019 06:03 PM, Paul Moore wrote:
> > On Mon, Jan 28, 2019 at 11:57 AM Daniel Jurgens <danielj@mellanox.com> =
wrote:
> >> On 1/28/2019 10:37 AM, Paul Moore wrote:
> >>> On Sun, Jan 27, 2019 at 3:10 AM Leon Romanovsky <leon@kernel.org> wro=
te:
> >>>> From: Daniel Jurgens <danielj@mellanox.com>
> >>>>
> >>>> ---
> >>>>   drivers/infiniband/core/security.c | 34 ++++----------------------=
----
> >>>>   include/rdma/ib_mad.h              |  3 ---
> >>>>   2 files changed, 4 insertions(+), 33 deletions(-)
> >>> Perhaps predictably, I'm not very excited about this change.  Have yo=
u
> >>> looked closer into the slowdown to see where the cycles are being
> >>> spent?  I'm wondering if the issue is that a large number of notifier=
s
> >>> are being registered with the same priority causing the while loop in
> >>> notifier_chain_register() to take a significant amount of time.
> >>
> >> That's what's happening, each MAD agent is registering it's own notifi=
er. The bug reporter was creating hundreds or thousands of  short lived MAD=
 agents. With IRQs disabled too long it resulted in timeouts.
> >>
> >> When I initially added the notifier mechanism I thought it was you tha=
t said it wasn't really needed, since access wasn't generally revoked in th=
ese types of scenarios. Given that I didn't think this would be especially =
controversial. It was nice to have, unfortunately it causes problems even f=
or users that don't enable SELinux.
> >
> > Revoking permission is difficult, and in some cases likely impossible,
> > but that doesn't mean we shouldn't try to make it possible when we
> > can.  I'd like to see if we can sort this out before we give up and
> > rip it out.
>
> Agree that it'd be nice to see it work, but since few (no other?) subsys =
registered
> with selinux/security is doing this, can we 'release' the IB mad agents f=
rom this
> 'imprisonment' and figure out a general solution that resolves this issue=
, and
> then it can be implemented not only for ib mad packet access, but for oth=
er
> subsys using selinux/security, and wanting the same revocation support.

If you scroll up, ever so slightly to my last reply (it's just a few
lines, I'll wait), you'll see where I said "I'd like to see if we can
sort this out before we give up and rip it out."

I don't recall at the moment why the notifier approach was taken with
the IB hooks back when Daniel wrote the code, and I'm definitely not
sure what other subsystems you are using for your comparisons here,
but I can tell you that I am beyond sick and tired of hearing people
immediately jump to "rip out this security code" because of some
performance glitch.  I care about performance too, okay?  We've got a
bunch of clever people here, let's spend some time and see if we can
improve what we've got before we make some knee jerk reaction and just
rip out the access controls.

> > I'm trying to quickly understand the MAD agent lifecycle, and it looks
> > like you have your own register/unregister routines, with locking, so
> > is it reasonable to assume that it would be possible to iterate over
> > the MAD agents in the IB code?  I wonder if it would be possible to
> > group MAD agents (per-port grouping, does that make sense?) such that
> > several agents would share a single LSM notifier registration?
> >
> one can have numerous MAD agents.  it isn't just one.

Clearly.  Daniel already mentioned hundreds of thousands of MAD agents.

> Think: you can have any number of apps scanning the fabric for various st=
ats
>         to draw node/graph pics, gather per-port packet counts, gather bw=
 numbers,
>         etc.  For IB, scanning the fabric involves 'mad pkts'.
>         In addition to scanning, one could do 'less then nice things' to =
switches,
>         not just read stats but set parameters... like routing table entr=
ies.
>         and thus, the security level addition.
>        One is highly unlikely to grant access to an app to do mad pkt gen=
eration/use,
>        then change your mind (semi-?)randomly to enable/disable it.... ge=
nerally always enabled,
>        or always disabled.
>
> Let's take this case as a catalyst to resolve a previously unknown perf i=
ssue,
> and not hold it up to a higher functional requirement then other apps tha=
t want to be secured.

See my comment above.  I don't even know what you are talking about
regarding "higher functional arguments", what other subsystems?
Seriously Don, language like this causes an extreme allergic reaction.

Anyway, let's move on to something a bit more constructive, shall we?

From what I've gathered from this thread the issue stems from the
ib_mad_agent_security_setup() where we register the
ib_mad_agent_security_change() callback with the LSM notification
mechanism.  Looking at the ib_mad_agent_security_change() function,
all it seems to do is perform a LSM permission check
(security_ib_endport_manage_subnet()) and store the result in
ib_mad_agent->smp_allowed; quickly grep'ing through the code, the only
place where I see that value used is in ib_mad_enforce_security().

Looking at ib_mad_enforce_security(), it seems to have access to the
necessary MAD agent information, via ib_mad_agent_private->agent, to
perform the LSM permission check directly in this function.  Could we
not get rid of the MAD agent LSM notification callback and simply do
the LSM access check directly in ib_mad_enforce_security()?  What am I
missing?

I do see that the SELinux implementation of the
security_ib_endport_manage_subnet() LSM hook doesn't seem to cache the
IB endport labels.  If that proves to be a performance issue we can
create a cache for that (like we do for the pkeys and a few other
objects).

I barely understand IB, so it is very possible there is a fundamental
flaw in the logic above, but let's try to work together and figure
something out.  The above may not be it, but I'm not ready to throw in
the towel.

--=20
paul moore
www.paul-moore.com
