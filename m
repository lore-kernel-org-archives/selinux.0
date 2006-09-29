Subject: Re: [PATCH 7/7] secid reconciliation-v03: Enforcement for SELinux
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Joshua Brindle <method@gentoo.org>
Cc: Venkat Yekkirala <vyekkirala@TrustedCS.com>, netdev@vger.kernel.org,
        selinux@tycho.nsa.gov, jmorris@namei.org, paul.moore@hp.com
In-Reply-To: <451C9897.6030306@gentoo.org>
References: <451C85F4.7000406@trustedcs.com>  <451C9897.6030306@gentoo.org>
Content-Type: text/plain
Date: Fri, 29 Sep 2006 08:59:19 -0400
Message-Id: <1159534759.8496.1.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2006-09-28 at 23:52 -0400, Joshua Brindle wrote:
> Venkat Yekkirala wrote:
> > <snip>
> > +
> > +	err = avc_has_perm(xfrm_sid, skb->secmark, SECCLASS_PACKET,
> > +					PACKET__FLOW_IN, NULL);
> > +	if (err)
> > +		goto out;
> > +
> > +	if (xfrm_sid) {
> > +		err = security_transition_sid(xfrm_sid, skb->secmark,
> > +						SECCLASS_PACKET, &trans_sid);
> > +		if (err)
> > +			goto out;
> > +
> >   
> I thought we weren't doing transitions to label packets anymore per the 
> conference call?

No, transitions are still part of the reconciliation process.  By
default, this just means that we end up with the xfrm_sid (which is what
you want).  But it allows us the freedom to define transitions on the
secmark label if desired, and those transitions can still yield subject
labels.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
