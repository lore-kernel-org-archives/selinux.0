From: Paul Moore <paul.moore@hp.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Subject: Re: [RFC PATCH v8 18/18] SELinux: Add network ingress and egress control permission checks
Date: Mon, 17 Dec 2007 16:06:59 -0500
Cc: selinux@tycho.nsa.gov, linux-security-module@vger.kernel.org,
        vyekkirala@TrustedCS.com, chanson@TrustedCS.com
References: <20071214213548.10069.59135.stgit@flek.lan> <200712161147.55119.paul.moore@hp.com> <1197921937.17307.114.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1197921937.17307.114.camel@moss-spartans.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200712171606.59974.paul.moore@hp.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Monday 17 December 2007 3:05:37 pm Stephen Smalley wrote:
> On Sun, 2007-12-16 at 11:47 -0500, Paul Moore wrote:
> > On Friday 14 December 2007 4:51:29 pm Paul Moore wrote:
> > > This patch implements packet ingress/egress controls for SELinux which
> > > allow SELinux security policy to control the flow of all IPv4 and IPv6
> > > packets into and out of the system.  Currently SELinux does not have
> > > proper control over forwarded packets and this patch corrects this
> > > problem.
> > >
> > > Special thanks to Venkat Yekkirala <vyekkirala@trustedcs.com> whose
> > > earlier work on this topic eventually led to this patch.
> >
> > I've been thinking about this over the weekend and realized a few things
> > ...
> >
> > {snip}
> >
> > > +static int selinux_inet_sys_snd_skb(struct sk_buff *skb, int family)
> > > +{
> > > +	int err = 0;
> > > +
> > > +	if (!selinux_policycap_netpeer)
> > > +		return 0;
> > > +
> > > +	if (netlbl_enabled() || selinux_xfrm_enabled()) {
> > > +		u32 if_sid;
> > > +		u32 node_sid;
> > > +		u32 peer_sid;
> > > +		char *addrp;
> > > +		struct avc_audit_data ad;
> > > +
> > > +		AVC_AUDIT_DATA_INIT(&ad, NET);
> > > +		ad.u.net.netif = skb->iif;
> > > +		ad.u.net.family = family;
> > > +		err = selinux_parse_skb(skb, &ad, &addrp, 0, NULL);
> > > +		if (err)
> > > +			return err;
> > > +
> > > +		err = selinux_skb_peerlbl_sid(skb, family, &peer_sid);
> > > +		if (err)
> > > +			return err;
> >
> > I realized I made a mistake here: we should check to see if the skb has a
> > socket associated with it and if it does get the peer_sid from there
> > instead. If there is no socket to be found then do what we are already
> > going above.
>
> In what case do you expect the two SIDs to diverge?

The case of CIPSO immediately springs to mind.  If you query the packet 
directly you will get a SID similar to what you see on incoming packets: 
the "netlabel_peer_t" type plus the CIPSO MLS sensitivity label.  If you 
query the socket which originated the packet you'll get the original, native 
SELinux label/SID.  In my mind using the socket's label is a shortcut to get 
the full/true/original/etc. label quickly.

There is most likely also a performance advantage in pulling the SID from the 
socket.

> What if we later provide an API to allow a sender to send a datagram
> with a particular label rather than always requiring them to be the same
> as the sending socket?

Then we can transition from using a mix between socket and packet labels to 
just packet labels.  I don't see any _significant_ barriers to that approach 
in the ingress/egress controls as proposed.  If you do, let me know.

> > > +		err = sel_netif_sid(skb->iif, &if_sid);
> > > +		if (err)
> > > +			return err;
> > > +		err = avc_has_perm(if_sid, peer_sid,
> > > +				   SECCLASS_PEER, PEER__EGRESS, &ad);
> > > +		if (err)
> > > +			return err;
> > > +
> > > +		err = sel_netnode_sid(addrp, family, &node_sid);
> > > +		if (err)
> > > +			return err;
> > > +		err = avc_has_perm(node_sid, peer_sid,
> > > +				   SECCLASS_PEER, PEER__EGRESS, &ad);
> >
> > We should probably have different permissions for the interface and node
> > cases.  Take the example of an admin who is only interested in enforcing
> > interface controls and not node controls.  They would most likely write
> > the following policy rule to nullify the node check ...
> >
> >  allow unlabeled_t peer_t:peer egress;
> >
> > ... which would end up applying to both the interface and node checks
> > because they use the same permission.  I'm thinking we should split the
> > permissions like this:
> >
> >  allow netif_t peer_t:peer if_egress;
> >  allow netnode_t peer_t: peer node_egress;
> >
> > ... and do something similar for the ingress side.  Thoughts?
>
> That starts to sound a lot like using netif and node classes instead of
> the peer class.
> 	allow peer_t netif_t:netif egress;
> 	allow peer_t netnode_t:node egress;

I see you noticed that too :)

I've been mulling this over and over in my head for some time and I'm not sure 
which is better.  I'm leaning towards sticking with the peer object class 
just because it reinforces the decision to treat the packet as an object.  
Good or bad, that is how SELinux currently treats packets and I fear that 
using the packet's peer label as the subject here could get confusing.

-- 
paul moore
linux security @ hp

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
