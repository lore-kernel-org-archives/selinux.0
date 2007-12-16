Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id lBGGnCsr028076
	for <selinux@tycho.nsa.gov>; Sun, 16 Dec 2007 11:49:12 -0500
Received: from mailhub.hp.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id lBGGnBTe024782
	for <selinux@tycho.nsa.gov>; Sun, 16 Dec 2007 16:49:12 GMT
From: Paul Moore <paul.moore@hp.com>
To: selinux@tycho.nsa.gov
Subject: Re: [RFC PATCH v8 18/18] SELinux: Add network ingress and egress control permission checks
Date: Sun, 16 Dec 2007 11:47:54 -0500
Cc: linux-security-module@vger.kernel.org, vyekkirala@TrustedCS.com,
        chanson@TrustedCS.com
References: <20071214213548.10069.59135.stgit@flek.lan> <20071214215129.10069.75156.stgit@flek.lan>
In-Reply-To: <20071214215129.10069.75156.stgit@flek.lan>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200712161147.55119.paul.moore@hp.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Friday 14 December 2007 4:51:29 pm Paul Moore wrote:
> This patch implements packet ingress/egress controls for SELinux which
> allow SELinux security policy to control the flow of all IPv4 and IPv6
> packets into and out of the system.  Currently SELinux does not have proper
> control over forwarded packets and this patch corrects this problem.
>
> Special thanks to Venkat Yekkirala <vyekkirala@trustedcs.com> whose earlier
> work on this topic eventually led to this patch.

I've been thinking about this over the weekend and realized a few things ...

{snip}

> +static int selinux_inet_sys_snd_skb(struct sk_buff *skb, int family)
> +{
> +	int err = 0;
> +
> +	if (!selinux_policycap_netpeer)
> +		return 0;
> +
> +	if (netlbl_enabled() || selinux_xfrm_enabled()) {
> +		u32 if_sid;
> +		u32 node_sid;
> +		u32 peer_sid;
> +		char *addrp;
> +		struct avc_audit_data ad;
> +
> +		AVC_AUDIT_DATA_INIT(&ad, NET);
> +		ad.u.net.netif = skb->iif;
> +		ad.u.net.family = family;
> +		err = selinux_parse_skb(skb, &ad, &addrp, 0, NULL);
> +		if (err)
> +			return err;
> +
> +		err = selinux_skb_peerlbl_sid(skb, family, &peer_sid);
> +		if (err)
> +			return err;

I realized I made a mistake here: we should check to see if the skb has a 
socket associated with it and if it does get the peer_sid from there instead.  
If there is no socket to be found then do what we are already going above.

> +		err = sel_netif_sid(skb->iif, &if_sid);
> +		if (err)
> +			return err;
> +		err = avc_has_perm(if_sid, peer_sid,
> +				   SECCLASS_PEER, PEER__EGRESS, &ad);
> +		if (err)
> +			return err;
> +
> +		err = sel_netnode_sid(addrp, family, &node_sid);
> +		if (err)
> +			return err;
> +		err = avc_has_perm(node_sid, peer_sid,
> +				   SECCLASS_PEER, PEER__EGRESS, &ad);

We should probably have different permissions for the interface and node 
cases.  Take the example of an admin who is only interested in enforcing 
interface controls and not node controls.  They would most likely write the 
following policy rule to nullify the node check ...

 allow unlabeled_t peer_t:peer egress;

... which would end up applying to both the interface and node checks because 
they use the same permission.  I'm thinking we should split the permissions 
like this:

 allow netif_t peer_t:peer if_egress;
 allow netnode_t peer_t: peer node_egress;

... and do something similar for the ingress side.  Thoughts?

> +	}
> +
> +	return err;
> +}

-- 
paul moore
linux security @ hp

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
