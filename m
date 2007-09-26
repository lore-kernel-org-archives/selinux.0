From: Paul Moore <paul.moore@hp.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Subject: Re: [RFC PATCH 2/2] [SELINUX] Better integration between peer labeling subsystems
Date: Wed, 26 Sep 2007 11:46:28 -0400
Cc: selinux@tycho.nsa.gov
References: <20070925203856.13699.90782.stgit@flek.americas.hpqcorp.net> <20070925204832.13699.51638.stgit@flek.americas.hpqcorp.net> <1190810496.15779.11.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1190810496.15779.11.camel@moss-spartans.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200709261146.28708.paul.moore@hp.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wednesday 26 September 2007 8:41:36 am Stephen Smalley wrote:
> On Tue, 2007-09-25 at 16:48 -0400, Paul Moore wrote:
> > -static void selinux_skb_extlbl_sid(struct sk_buff *skb, u32 *sid)
> > +static int selinux_skb_peerlbl_sid(struct sk_buff *skb, u32 *sid)
> >  {
> >  	u32 xfrm_sid;
> >  	u32 nlbl_sid;
> >
> >  	selinux_skb_xfrm_sid(skb, &xfrm_sid);
> > -	if (selinux_netlbl_skbuff_getsid(skb,
> > -					 (xfrm_sid == SECSID_NULL ?
> > -					  SECINITSID_NETMSG : xfrm_sid),
> > -					 &nlbl_sid) != 0)
> > -		nlbl_sid = SECSID_NULL;
> > -	*sid = (nlbl_sid == SECSID_NULL ? xfrm_sid : nlbl_sid);
> > +	selinux_netlbl_skbuff_getsid(skb, SECINITSID_NETMSG, &nlbl_sid);
> > +
> > +	if (nlbl_sid != SECSID_NULL && xfrm_sid != SECSID_NULL) {
> > +		if (nlbl_sid != xfrm_sid &&
> > +		    /* XXX - not sure if we should just compare the low end of
> > +		     * the range or the whole range?  probably safest to
> > +		     * compare the entire range ... */
> > +		    security_sid_mls_cmp(nlbl_sid, xfrm_sid) != 0) {
>
> I know that this isn't the first instance of this, but the goal of the
> Flask architecture was to encapsulate the security model completely
> within the security server.  So leaking MLS specific logic out into the
> hook functions (as is also done by security_sid_mls_copy) violates that
> goal.

A reasonable request, although off the top of my head I'm not sure there is 
much we can do other than rename security_sid_mls_cmp() to something a bit 
less MLS'esque.  Perhaps security_net_peersid_cmp()?  If you have a better 
idea I'm all ears/eyes ...

Regarding security_sid_mls_copy(), as you have pointed out before, we should 
try and rework that so the newly accepted socket just takes the label of the 
peer but I think we are still a ways off from being able to do that in the 
policy.  Always something to work on ...

-- 
paul moore
linux security @ hp

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
