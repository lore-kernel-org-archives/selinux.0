Message-ID: <36282A1733C57546BE392885C0618592015CF961@chaos.tcs.tcs-sec.com>
From: Venkat Yekkirala <vyekkirala@TrustedCS.com>
To: Paul Moore <paul.moore@hp.com>,
        Venkat Yekkirala
	 <vyekkirala@TrustedCS.com>
Cc: netdev@vger.kernel.org, selinux@tycho.nsa.gov, eparis@redhat.com,
        jmorris@namei.org, sds@tycho.nsa.gov
Subject: RE: [PATCH v4 1/2] NetLabel: secid reconciliation support
Date: Wed, 4 Oct 2006 15:37:40 -0400 
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

> >> * XFRM present
> >>
> >>   xfrm_sid = <full context from xfrm>
> >>   loc_sid = SECINITSID_NETMSG
> >>   nlbl_sid = SECSID_NULL/0
> >>   ext_sid = xfrm_sid
> >>   final skb->secmark = avc_ok : ext_sid ? unchanged

Actually, I meant to cite the following instead of the above:

 * Nothing

   xfrm_sid = SECSID_NULL/0
   loc_sid = SECSID_NULL/0
   nlbl_sid = SECSID_NULL/0
   ext_sid = xfrm_sid
   final skb->secmark = avc_ok : ext_sid ? unchanged

> >>
> >> * NetLabel present
> >>
> >>   xfrm_sid = SECSID_NULL/0
> >>   loc_sid = SECSID_NULL/0
> >>   nlbl_sid = <SECINITSID_NETMSG te ctx, netlabel mls ctx>
> >>   ext_sid = nlbl_sid
> >>   final skb->secmark = avc_ok : ext_sid ? unchanged
> > 
> > I was referring to the differences in what getpeercon would
> > return in the above 2 scenarios.
> > 
> > In the xfrm case:     final skb->secmark would be 0 
> resulting in getpeercon
> > to return EPROTONOOPT
> 
> In the "XFRM present" case above if the access is allowed (avc_ok is
> true) then the final skb->secmark value is going to be set to 
> the value
> of ext_sid which is the xfrm_sid.  Any calls made to 
> getpeercon() would
> return success with the context matching xfrm_sid.

You are right, but I was actually referring to the "Nothing"
case above.

> 
> I have a hunch we are still on different pages here ...
> 
> > In the NetLabel case: final skb->secmark would be network_t 
> resulting in
> > getpeercon to return network_t
> 
> Yep, and I understand you would like to see it as 
> unlabeled_t.  I think
> we both have valid arguments for either case and we are just 
> waiting to
> hear from others.
> 
> -- 
> paul moore
> linux security @ hp
> 

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
