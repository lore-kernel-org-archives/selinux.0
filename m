Return-Path: <SRS0=7tXC=QF=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AA0EC169C4
	for <selinux@archiver.kernel.org>; Tue, 29 Jan 2019 20:51:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DED5520856
	for <selinux@archiver.kernel.org>; Tue, 29 Jan 2019 20:51:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="tHFObEEV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727686AbfA2UvP (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 29 Jan 2019 15:51:15 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:32818 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727383AbfA2UvP (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 29 Jan 2019 15:51:15 -0500
Received: by mail-lj1-f196.google.com with SMTP id v1-v6so18799419ljd.0
        for <selinux@vger.kernel.org>; Tue, 29 Jan 2019 12:51:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=PY5yvG/kczgk/nItpmfH34cdctpfGICxJDnSErcvsQ8=;
        b=tHFObEEV3Yt0jhVafrQGNNNosjmIoRhEP46MHDhQaywx/1IvZcJdLDeTIL7C5gSwLR
         oWjztI1Z3d60oEeFpJNOhyk7qxkFRDagLpjs9zZYs4ARE1AOb5qJEbE0Be34xALSJR3I
         xZjmdYiTSdRZu5zVgCOyCP8k4+v9YN7C1QWuvpC79f1T7llVxQmMcyL1y3EIS2XVjOHw
         y97cE9otafLoOM9gKEQjX8JdQUvzqIPmfVEE1wT15Ga8ObNu1vFcYtLp7/wGfjfuk3pa
         K0Lc/ptp2glNG5TC191Ay2dT+isWuMSly0VVlLLg1xeU+nNOh163KM8EacrcnZK9o9I6
         t2tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=PY5yvG/kczgk/nItpmfH34cdctpfGICxJDnSErcvsQ8=;
        b=Fpy5PIwT4IOpxGAcQ/a2J189qXGXJN9EmCRm0NTiHQ3ePakTvNU1sD8Gf8zaFckx//
         vCwIU/i8TQgEgNPcy9tRTdVTPZeGg0Udd+mhBWnxRqHl8Gebi1/ujX5rHIQGE2SYp3o3
         GriF/Ln9jk/Hf0JEk+1NC0ax/Xn6hdmxO9nw2aRUqiHrtui1+GulfZcN0XxTEc4j1ysD
         D9HdV5/hj/fXVIC6RZ56xyvjcuM+tQ+fy9Dpl/UywMJ5ueDnrz3zHlhzQp0Zn90KmjOA
         RDrD0BMhdMdMC1QIwjiXohFBLd/C1U0sObeHQr9Dfnp1l7YTysVo4qIIaqeMnFnhFMmT
         DHvQ==
X-Gm-Message-State: AJcUuketAKuGJSTUvNk7cbgvEVY96KuqAC15QuNrb7FfREf9YW9thscK
        WZ76ZESmT9X7SR1r66o22k3s7uhtKYqa8QNVydab
X-Google-Smtp-Source: ALg8bN58gso5SiJWkd/np9WoiLxfeylXVWwyFHS6EHU55vK4/j+r8R70qeKZiwpnnwZd7lmJ/dK8becU1ml9GmsVQGU=
X-Received: by 2002:a2e:9d17:: with SMTP id t23-v6mr14634482lji.57.1548795072024;
 Tue, 29 Jan 2019 12:51:12 -0800 (PST)
MIME-Version: 1.0
References: <20190127081023.21124-1-leon@kernel.org> <CAHC9VhQccU9sD7Zb+6d9sPK=fq593R1-UOhVfwgiK-6usrkbQw@mail.gmail.com>
 <b558e86b-dc56-d17a-30c0-0b640f0bf6cc@mellanox.com> <CAHC9VhQTq_UTFkBOSb0fWbde6tsb_uiNi8EHdCovKzB8KkD6XA@mail.gmail.com>
 <40feb71f-d24c-f592-58d0-fc5814307c6c@redhat.com> <CAHC9VhSzNjVFq-aiUrS2og0sMUwNB+aBwtk7ZWj9dss12xfVOQ@mail.gmail.com>
 <1859ec04-d3d2-bffe-16ca-2ae602e5bbff@mellanox.com> <325d56d9-24d9-a850-57a7-47f12baa593c@mellanox.com>
In-Reply-To: <325d56d9-24d9-a850-57a7-47f12baa593c@mellanox.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 29 Jan 2019 15:51:00 -0500
Message-ID: <CAHC9VhRWHzrR84ueJHzmBgyQviL-36-ezvDb0u-xRfQmBsBO2g@mail.gmail.com>
Subject: Re: [PATCH rdma-next] IB/core: Don't register MAD agents for LSM notifications
To:     Daniel Jurgens <danielj@mellanox.com>
Cc:     Don Dutile <ddutile@redhat.com>, Leon Romanovsky <leon@kernel.org>,
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

On Tue, Jan 29, 2019 at 1:02 PM Daniel Jurgens <danielj@mellanox.com> wrote=
:
> On 1/29/2019 11:48 AM, Daniel Jurgens wrote:
> > On 1/29/2019 11:30 AM, Paul Moore wrote:
> >> On Mon, Jan 28, 2019 at 9:57 PM Don Dutile <ddutile@redhat.com> wrote:
> >>> On 01/28/2019 06:03 PM, Paul Moore wrote:
> >>>> On Mon, Jan 28, 2019 at 11:57 AM Daniel Jurgens <danielj@mellanox.co=
m> wrote:
> >>>>> On 1/28/2019 10:37 AM, Paul Moore wrote:
> >>>>>> On Sun, Jan 27, 2019 at 3:10 AM Leon Romanovsky <leon@kernel.org> =
wrote:
> >>>>>>> From: Daniel Jurgens <danielj@mellanox.com>
> >>>>>>>
> >>>>>>> ---
> >>>>>>>   drivers/infiniband/core/security.c | 34 ++++-------------------=
-------
> >>>>>>>   include/rdma/ib_mad.h              |  3 ---
> >>>>>>>   2 files changed, 4 insertions(+), 33 deletions(-)
> >>>> I'm trying to quickly understand the MAD agent lifecycle, and it loo=
ks
> >>>> like you have your own register/unregister routines, with locking, s=
o
> >>>> is it reasonable to assume that it would be possible to iterate over
> >>>> the MAD agents in the IB code?  I wonder if it would be possible to
> >>>> group MAD agents (per-port grouping, does that make sense?) such tha=
t
> >>>> several agents would share a single LSM notifier registration?
> >>>>
> >>> one can have numerous MAD agents.  it isn't just one.
> >> Clearly.  Daniel already mentioned hundreds of thousands of MAD agents=
.
> > Just to be clear, it was hundreds to thousands, not hundreds of thousan=
ds.

Ah, sorry about that, I guess my mind multiplied it by a few orders of
magnitude.  Regardless, even a few hundred is a lot for a full list
traversal.

> >> From what I've gathered from this thread the issue stems from the
> >> ib_mad_agent_security_setup() where we register the
> >> ib_mad_agent_security_change() callback with the LSM notification
> >> mechanism.  Looking at the ib_mad_agent_security_change() function,
> >> all it seems to do is perform a LSM permission check
> >> (security_ib_endport_manage_subnet()) and store the result in
> >> ib_mad_agent->smp_allowed; quickly grep'ing through the code, the only
> >> place where I see that value used is in ib_mad_enforce_security().
> >>
> >> Looking at ib_mad_enforce_security(), it seems to have access to the
> >> necessary MAD agent information, via ib_mad_agent_private->agent, to
> >> perform the LSM permission check directly in this function.  Could we
> >> not get rid of the MAD agent LSM notification callback and simply do
> >> the LSM access check directly in ib_mad_enforce_security()?  What am I
> >> missing?
> >>
> >> I do see that the SELinux implementation of the
> >> security_ib_endport_manage_subnet() LSM hook doesn't seem to cache the
> >> IB endport labels.  If that proves to be a performance issue we can
> >> create a cache for that (like we do for the pkeys and a few other
> >> objects).
> >>
> >> I barely understand IB, so it is very possible there is a fundamental
> >> flaw in the logic above, but let's try to work together and figure
> >> something out.  The above may not be it, but I'm not ready to throw in
> >> the towel.
> > I think that's a reasonable idea, also holding agents lists in the IB l=
ayer and only registering for one notifier could work as well (it's already=
 registered for the PKeys). Jason had suggested that internally, but the pr=
oblem is I wasn't really able to reproduce the reported issue, so we're kin=
d of flying blind either way in terms of knowing if either approach address=
es the perf problem.
>
>  I guess I should clarify. Obviously if we only register for the notifier=
 once and hold the list(s) in the IB layer we won't have issues with regist=
er/unregister, but there may still be a problem lurking during a notificati=
on event. So this is less bad, at least it wouldn't affect non SElinux user=
s.

Okay, so let's attempt the change above where we just do the access
check directly.  Although I'm a little concerned that without a
reproducer we might not end up fixing the problem we're trying to fix.
Is anyone in touch with the person who originally reported the
problem?  It would be great if we could get that person to verify the
change ...

--=20
paul moore
www.paul-moore.com
