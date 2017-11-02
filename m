Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id vA2NtETG011453
 for <selinux@tycho.nsa.gov>; Thu, 2 Nov 2017 19:55:14 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
 by UPDCF3IC01.oob.disa.mil (Postfix) with SMTP id 3ySh4875R1z1pJw8
 for <selinux@tycho.nsa.gov>; Thu,  2 Nov 2017 23:24:08 +0000 (UTC)
Received: from UPDC3CPA02.eemsg.mil (unknown [192.168.18.9])
 by UPDCF3IC01.oob.disa.mil (Postfix) with ESMTP id 3ySh486Kdrz1pJvw
 for <selinux@tycho.nsa.gov>; Thu,  2 Nov 2017 23:24:08 +0000 (UTC)
Received: by mail-lf0-f45.google.com with SMTP id r129so1137776lff.8
 for <selinux@tycho.nsa.gov>; Thu, 02 Nov 2017 15:37:30 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1509627538.4623.1.camel@tycho.nsa.gov>
References: <20171030145843.13496-1-sds@tycho.nsa.gov>
 <CAHC9VhT6b1DJ0E65syC7XoVxfSTs3RUq9-HNLuzt2H-vrj69RA@mail.gmail.com>
 <20171031230809.GD7663@breakpoint.cc>
 <CAHC9VhT7FOeoJgX=KmMPr_ACKSgJ8V9DEHNM=cnfV9-sdrHC2g@mail.gmail.com>
 <1509627538.4623.1.camel@tycho.nsa.gov>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 2 Nov 2017 18:37:27 -0400
Message-ID: <CAHC9VhR9UMzh4euR87OaqcjfqodvEAr-KBLjGYa4C+Z7zVTZ9A@mail.gmail.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: Florian Westphal <fw@strlen.de>, herbert@gondor.apana.org.au,
 netdev@vger.kernel.org, linux-security-module@vger.kernel.org,
 selinux@tycho.nsa.gov, davem@davemloft.net
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [RFC PATCH] xfrm: fix regression introduced by xdst
 pcpu cache
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Thu, Nov 2, 2017 at 8:58 AM, Stephen Smalley <sds@tycho.nsa.gov> wrote:
> On Wed, 2017-11-01 at 17:39 -0400, Paul Moore wrote:
>> On Tue, Oct 31, 2017 at 7:08 PM, Florian Westphal <fw@strlen.de>
>> wrote:
>> > Paul Moore <paul@paul-moore.com> wrote:
>> > > On Mon, Oct 30, 2017 at 10:58 AM, Stephen Smalley <sds@tycho.nsa.
>> > > gov> wrote:
>> > > > matching before (as in this patch) or after calling
>> > > > xfrm_bundle_ok()?
>> > >
>> > > I would probably make the LSM call the last check, as you've
>> > > done; but
>> > > I have to say that is just so it is consistent with the "LSM
>> > > last"
>> > > philosophy and not because of any performance related argument.
>> > >
>> > > > ... Also,
>> > > > do we need to test xfrm->sel.family before calling
>> > > > xfrm_selector_match
>> > > > (as in this patch) or not - xfrm_state_look_at() does so when
>> > > > the
>> > > > state is XFRM_STATE_VALID but not when it is _ERROR or
>> > > > _EXPIRED?
>> > >
>> > > Speaking purely from a SELinux perspective, I'm not sure it
>> > > matters:
>> > > as long as the labels match we are happy.  However, from a
>> > > general
>> > > IPsec perspective it does seem like a reasonable thing.
>> > >
>> > > Granted I'm probably missing something, but it seems a little odd
>> > > that
>> > > the code isn't already checking that the selectors match (...
>> > > what am
>> > > I missing?).  It does check the policies, maybe that is enough in
>> > > the
>> > > normal IPsec case?
>> >
>> > The assumption was that identical policies would yield the same
>> > SAs,
>> > but thats not correct.
>>
>> Well, to be fair, I think the assumption is valid for normal,
>> unlabeled IPsec.  The problem comes when SELinux starts labeling SAs
>> and now you have multiple SAs for a given policy, each differing only
>> in the SELinux/LSM label.
>
> No, it is invalid for normal, unlabeled IPSEC too, in the case where
> one has defined xfrm state selectors.  That's what my other testsuite
> patch (which is presently only on the xfrmselectortest branch) is
> exercising - matching of xfrm state selectors.  But in any event,
> Florian's patch fixes both, so I'm fine with it.  I don't know though
> how it compares performance-wise with walking the bundle and just
> calling security_xfrm_state_pol_flow_match() and xfrm_selector_match()
> on each one.
>
>> Considering that adding the SELinux/LSM label effectively adds an
>> additional selector, I'm wondering if we should simply add the
>> SELinux/LSM label matching to xfrm_selector_match()?  Looking quickly
>> at the code it seems as though we always follow xfrm_selector_match()
>> with a LSM check anyway, the one exception being in
>> __xfrm_policy_check() ... which *might* be a valid exception, as we
>> don't do our access checks for inbound traffic at that point in the
>> stack.
>
> Possibly, but that should probably be a separate patch. We should just
> fix this regression for 4.14, either via Florian's patch or by
> augmenting my patch to perform the matching calls on all of the xfrms.

I agree that v4.14 should get the smallest patch possible that fixes
the problem.  I was just looking at the patches presented so far and
thinking out loud.

-- 
paul moore
www.paul-moore.com
