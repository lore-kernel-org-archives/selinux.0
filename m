Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l8PM86jJ005916
	for <selinux@tycho.nsa.gov>; Tue, 25 Sep 2007 18:08:06 -0400
Received: from atlrel6.hp.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id l8PM84YZ010860
	for <selinux@tycho.nsa.gov>; Tue, 25 Sep 2007 22:08:04 GMT
From: Paul Moore <paul.moore@hp.com>
To: "Eric Paris" <eparis@parisplace.org>
Subject: Re: [RFC PATCH 2/2] [SELINUX] Better integration between peer labeling subsystems
Date: Tue, 25 Sep 2007 18:01:41 -0400
Cc: selinux@tycho.nsa.gov
References: <20070925203856.13699.90782.stgit@flek.americas.hpqcorp.net> <20070925204832.13699.51638.stgit@flek.americas.hpqcorp.net> <7e0fb38c0709251437k66d2de62t3391eaad71e34b51@mail.gmail.com>
In-Reply-To: <7e0fb38c0709251437k66d2de62t3391eaad71e34b51@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200709251801.41624.paul.moore@hp.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tuesday 25 September 2007 5:37:53 pm Eric Paris wrote:
> On 9/25/07, Paul Moore <paul.moore@hp.com> wrote:
> > -static void selinux_skb_extlbl_sid(struct sk_buff *skb, u32 *sid)
> > +static int selinux_skb_peerlbl_sid(struct sk_buff *skb, u32 *sid)
> >  {
> >         u32 xfrm_sid;
> >         u32 nlbl_sid;
> >
> >         selinux_skb_xfrm_sid(skb, &xfrm_sid);
> > -       if (selinux_netlbl_skbuff_getsid(skb,
> > -                                        (xfrm_sid == SECSID_NULL ?
> > -                                         SECINITSID_NETMSG : xfrm_sid),
> > -                                        &nlbl_sid) != 0)
> > -               nlbl_sid = SECSID_NULL;
> > -       *sid = (nlbl_sid == SECSID_NULL ? xfrm_sid : nlbl_sid);
> > +       selinux_netlbl_skbuff_getsid(skb, SECINITSID_NETMSG, &nlbl_sid);
> > +
> > +       if (nlbl_sid != SECSID_NULL && xfrm_sid != SECSID_NULL) {
> > +               if (nlbl_sid != xfrm_sid &&
>
> for now nlbl_sid will NEVER == xfrm_sid since netlbl_sid cannot be of
> an interesting type, correct?  So this code works.  If the mls portion
> is wrong bomb, if the mls portion is right allow.  Since that's all we
> are testing lets get that misleading nlbl_sid != xfrm_sid out of there
> they can never be the same and it implies we actually check something
> other than the mls portion.

[NOTE: pseudo code removed to protect the eyesight of anyone who happens to 
wander onto the mailing list]

Presently you are correct that is the case, I'll yank it out and we can add it 
back in later when we need it.  How about this?

static int selinux_skb_peerlbl_sid(struct sk_buff *skb, u32 *sid)
{
	u32 xfrm_sid;
	u32 nlbl_sid;

	selinux_skb_xfrm_sid(skb, &xfrm_sid);
	selinux_netlbl_skbuff_getsid(skb, SECINITSID_NETMSG, &nlbl_sid);

	if (nlbl_sid != SECSID_NULL && xfrm_sid != SECSID_NULL)
		if (security_sid_mls_cmp(nlbl_sid, xfrm_sid) != 0) {
			*sid = SECSID_NULL;
			return -EACCES;
		} else
			/* at present NetLabel SIDs/labels really only carry
			 * MLS information so if the MLS portion of the
			 * NetLabel SID matches the MLS portion of the labeled
			 * XFRM SID/label then pass along the XFRM SID as it
			 * has the most peer label information */
			*sid = xfrm_sid;
	else if (nlbl_sid != SECSID_NULL)
		*sid = nlbl_sid;
	else if (xfrm_sid != SECSID_NULL)
		*sid = xfrm_sid;
	else
		*sid = SECSID_NULL;

	return 0;
}

--
paul moore
linux security @ hp

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
