Subject: Re: [PATCH 7/9] secid reconciliation-v04: Enforcement for SELinux
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Paul Moore <paul.moore@hp.com>
Cc: Venkat Yekkirala <vyekkirala@TrustedCS.com>, netdev@vger.kernel.org,
        selinux@tycho.nsa.gov, jmorris@namei.org, eparis@redhat.com
In-Reply-To: <45213A55.8070205@hp.com>
References: <452032A6.1080306@trustedcs.com>  <45213A55.8070205@hp.com>
Content-Type: text/plain
Date: Mon, 02 Oct 2006 12:35:08 -0400
Message-Id: <1159806908.6855.58.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2006-10-02 at 12:12 -0400, Paul Moore wrote:
> Venkat Yekkirala wrote:
> > This defines SELinux enforcement of the 2 new LSM hooks as well
> > as related changes elsewhere in the SELinux code.
> > 
> > This also now keeps track of the peersid thru the establishment
> > of a connection on the server (tracking peersid on the client
> > is covered later in this patch set).
> > 
> > Signed-off-by: Venkat Yekkirala <vyekkirala@TrustedCS.com>
> > 
> > {snip}
> >
> > +static int selinux_skb_flow_in(struct sk_buff *skb, unsigned short family)
> > +{
> > +	u32 xfrm_sid;
> > +	int err;
> > +
> > +	if (selinux_compat_net)
> > +		return 1;
> > +
> > +	/*
> > +	 * loopback traffic already labeled and
> > +	 * flow-controlled on outbound. We may
> > +	 * need to flow-control on the inbound
> > +	 * as well if there's ever a use-case for it.
> > +	 */
> > +	if (skb->dev == &loopback_dev)
> > +		return 1;
> > +
> > +	err = selinux_xfrm_decode_session(skb, &xfrm_sid, 0);
> > +	BUG_ON(err);
> 
> Just a quick question that has been nagging me for awhile - any
> particular reason why this is a BUG_ON() and not an "if (err) goto out;"?

It appears that selinux_xfrm_decode_session() can only legitimately
return an error if the last argument (ckall) is non-zero.
security_skb_classify_flow() was doing the same thing prior to this
patch series.  It would be clearer if there were two separate interfaces
that internally use the same helper, with one of the functions returning
void.

> > +	err = avc_has_perm(xfrm_sid, skb->secmark, SECCLASS_PACKET,
> > +					PACKET__FLOW_IN, NULL);
> > +	if (err)
> > +		goto out;
> > +
> > +	if (xfrm_sid)
> > +		skb->secmark = xfrm_sid;
> > +
> > +	/* See if NetLabel can flow in thru the current secmark here */
> > +
> > +out:
> > +	return err ? 0 : 1;
> > +};
> 
-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
