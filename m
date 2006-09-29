Subject: Re: [PATCH 7/7] secid reconciliation-v03: Enforcement for SELinux
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Joshua Brindle <method@gentoo.org>
Cc: Venkat Yekkirala <vyekkirala@TrustedCS.com>, netdev@vger.kernel.org,
        selinux@tycho.nsa.gov, jmorris@namei.org, paul.moore@hp.com,
        kmacmillan@mentalrootkit.com
In-Reply-To: <1159538414.3592.5.camel@twoface.columbia.tresys.com>
References: <451C85F4.7000406@trustedcs.com>  <451C9897.6030306@gentoo.org>
	 <1159534759.8496.1.camel@moss-spartans.epoch.ncsc.mil>
	 <1159538414.3592.5.camel@twoface.columbia.tresys.com>
Content-Type: text/plain
Date: Fri, 29 Sep 2006 10:28:33 -0400
Message-Id: <1159540113.8496.59.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2006-09-29 at 10:00 -0400, Joshua Brindle wrote:
> On Fri, 2006-09-29 at 08:59 -0400, Stephen Smalley wrote:
> > On Thu, 2006-09-28 at 23:52 -0400, Joshua Brindle wrote:
> > > Venkat Yekkirala wrote:
> > > > <snip>
> > > > +
> > > > +	err = avc_has_perm(xfrm_sid, skb->secmark, SECCLASS_PACKET,
> > > > +					PACKET__FLOW_IN, NULL);
> > > > +	if (err)
> > > > +		goto out;
> > > > +
> > > > +	if (xfrm_sid) {
> > > > +		err = security_transition_sid(xfrm_sid, skb->secmark,
> > > > +						SECCLASS_PACKET, &trans_sid);
> > > > +		if (err)
> > > > +			goto out;
> > > > +
> > > >   
> > > I thought we weren't doing transitions to label packets anymore per the 
> > > conference call?
> > 
> > No, transitions are still part of the reconciliation process.  By
> > default, this just means that we end up with the xfrm_sid (which is what
> > you want).  But it allows us the freedom to define transitions on the
> > secmark label if desired, and those transitions can still yield subject
> > labels.
> > 
> 
> This is not consistent with my perception of the decision made in the
> conference call. I thought that the secid was either going to be 1) the
> secmark label if no external labeling is present or 2) the external
> label if it is present. The flow_in permission would be checked between
> the external label and the secmark label in either case (unlabeled in
> the case of #1)

The behavior you describe is precisely what will happen in the absence
of any type_transition rules on packet class in the policy, given the
way in which he has defined security_transition_sid on packet class.
The only question is whether there is any value in allowing a transition
to be configured in policy (and if such a transition is configured,
whether the resulting SID requires its own separate permission check,
which is what is usually done - the transition doesn't implicitly
authorize anything).  I don't recall a particular decision on the
transition issue during the call nor do I see it in the posted notes.
However, since the transition was removed in the flow_out case, it would
be logical to remove it from the flow_in case as well, and that would
have the side benefit of less overhead.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
