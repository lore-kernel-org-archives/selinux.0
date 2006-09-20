Message-ID: <36282A1733C57546BE392885C061859201573267@chaos.tcs.tcs-sec.com>
From: Venkat Yekkirala <vyekkirala@TrustedCS.com>
To: Paul Moore <paul.moore@hp.com>
Cc: netdev@vger.kernel.org, selinux@tycho.nsa.gov, jmorris@namei.org,
        sds@tycho.nsa.gov, Chad Hanson <chanson@TrustedCS.com>
Subject: RE: [PATCH 7/7] secid reconciliation-v02: Enforcement for SELinux
Date: Wed, 20 Sep 2006 17:08:54 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

> > +static int selinux_skb_policy_check(struct sk_buff *skb, 
> unsigned short
> > family) +{
> > +	u32 xfrm_sid, trans_sid;
> > +	int err;
> > +
> > +	if (selinux_compat_net)
> > +		return 1;
> > +
> > +	err = selinux_xfrm_decode_session(skb, &xfrm_sid, 0);
> > +	BUG_ON(err);
> 
> First, any reason against including the "struct sock *" in 
> the LSM hook?  At a 
> quick glance it looks like it is available at each place 
> security_skb_policy_check() is invoked?  If there are no 
> objections I would 
> like to see it included in the hook.

There's no sock available (NULL) for forward, no-sock, time-wait cases, etc.

What you are trying to accomplish with the sock here anyway?

> 
> Second, I wonder if it would be better to do a NetLabel/CIPSO 
> query here using 
> the xfrm_sid as the NetLabel "base_sid" instead of at the end 
> of the function 
> (see your comment)?  This way we wouldn't have to duplicate the 
> avc_has_perm() and security_transition_sid() calls for both xfrm and 
> NetLabel.

There's a need for an additional avc_has_perm check anyway between
the cipso label and the ipsec/transition label, to check to make sure
the cipso level falls within the range on the IPSec/transition SA.

No need for a new transition between ipsec/transition label and the cipso
label since the cipso label would be sharing the TE portion with the
ipsec/transition label (this could change in the future, when you get round
to doing entire SELinux contexts over the wire). For now, you would just
set the secmark to the cipso label if the label could come thru
(i.e. if the avc_has_perm succeeds).

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
