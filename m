Subject: Re: [PATCH 7/7] secid reconciliation-v03: Enforcement for SELinux
From: Joshua Brindle <method@gentoo.org>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: Venkat Yekkirala <vyekkirala@TrustedCS.com>, netdev@vger.kernel.org,
        selinux@tycho.nsa.gov, jmorris@namei.org, paul.moore@hp.com,
        kmacmillan@mentalrootkit.com
In-Reply-To: <1159534759.8496.1.camel@moss-spartans.epoch.ncsc.mil>
References: <451C85F4.7000406@trustedcs.com>  <451C9897.6030306@gentoo.org>
	 <1159534759.8496.1.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain
Date: Fri, 29 Sep 2006 10:00:14 -0400
Message-Id: <1159538414.3592.5.camel@twoface.columbia.tresys.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2006-09-29 at 08:59 -0400, Stephen Smalley wrote:
> On Thu, 2006-09-28 at 23:52 -0400, Joshua Brindle wrote:
> > Venkat Yekkirala wrote:
> > > <snip>
> > > +
> > > +	err = avc_has_perm(xfrm_sid, skb->secmark, SECCLASS_PACKET,
> > > +					PACKET__FLOW_IN, NULL);
> > > +	if (err)
> > > +		goto out;
> > > +
> > > +	if (xfrm_sid) {
> > > +		err = security_transition_sid(xfrm_sid, skb->secmark,
> > > +						SECCLASS_PACKET, &trans_sid);
> > > +		if (err)
> > > +			goto out;
> > > +
> > >   
> > I thought we weren't doing transitions to label packets anymore per the 
> > conference call?
> 
> No, transitions are still part of the reconciliation process.  By
> default, this just means that we end up with the xfrm_sid (which is what
> you want).  But it allows us the freedom to define transitions on the
> secmark label if desired, and those transitions can still yield subject
> labels.
> 

This is not consistent with my perception of the decision made in the
conference call. I thought that the secid was either going to be 1) the
secmark label if no external labeling is present or 2) the external
label if it is present. The flow_in permission would be checked between
the external label and the secmark label in either case (unlabeled in
the case of #1)

How is this different from the implementation before the call?


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
