Subject: Re: [PATCH v4 1/2] NetLabel: secid reconciliation support
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Paul Moore <paul.moore@hp.com>
Cc: Venkat Yekkirala <vyekkirala@TrustedCS.com>, selinux@tycho.nsa.gov,
        eparis@redhat.com, jmorris@namei.org
In-Reply-To: <45241108.5040303@hp.com>
References: <36282A1733C57546BE392885C0618592015CF961@chaos.tcs.tcs-sec.com>
	 <45241108.5040303@hp.com>
Content-Type: text/plain
Date: Wed, 04 Oct 2006 16:09:25 -0400
Message-Id: <1159992565.19176.240.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2006-10-04 at 15:52 -0400, Paul Moore wrote:
> Venkat Yekkirala wrote:
> >>>>* XFRM present
> >>>>
> >>>>  xfrm_sid = <full context from xfrm>
> >>>>  loc_sid = SECINITSID_NETMSG
> >>>>  nlbl_sid = SECSID_NULL/0
> >>>>  ext_sid = xfrm_sid
> >>>>  final skb->secmark = avc_ok : ext_sid ? unchanged
> > 
> > Actually, I meant to cite the following instead of the above:
> > 
> >  * Nothing
> > 
> >    xfrm_sid = SECSID_NULL/0
> >    loc_sid = SECSID_NULL/0
> >    nlbl_sid = SECSID_NULL/0
> >    ext_sid = xfrm_sid
> >    final skb->secmark = avc_ok : ext_sid ? unchanged
> 
> Okay, thanks, I think I understand your point now.  Let me try to
> restate just to make sure.
> 
> Take two cases: the first being no labeling at all, the second being
> only NetLabel ...
> 
>  * Nothing
> 
>    xfrm_sid = SECSID_NULL/0
>    loc_sid = SECSID_NULL/0
>    nlbl_sid = SECSID_NULL/0
>    ext_sid = xfrm_sid
>    final skb->secmark = avc_ok : ext_sid ? unchanged
> 
>  * NetLabel
> 
>   xfrm_sid = SECSID_NULL/0
>   loc_sid = SECSID_NULL/0
>   nlbl_sid = <SECINITSID_NETMSG te ctx, netlabel mls ctx>
>   ext_sid = nlbl_sid
>   final skb->secmark = avc_ok : ext_sid ? unchanged
> 
> In the "Nothing" case the final skb->secmark is set to SECSID_NULL/0;
> getpeercon() should return an error. In the "NetLabel" case the final
> skb->secmark is set using the TE portions of SECINITSID_NETMSG and the
> MLS label of the NetLabel packet; getpeercon() will succeed.

...but return a context that isn't a subject label.

> I understand in the "NetLabel" case above you think the TE portion of
> the final skb->secmark value should come from
> SECSID_NULL/SECINITSID_UNLABELED/0, but do you also want getpeercon() to
> return an error in the "NetLabel" case?  I think that's a bad idea as it
> will made it *extremely* difficult for applications to determine the MLS
> label of a connection using NetLabel.

It doesn't need to fail in that case, no.  But it should return a
subject label.  From a TE pov, the subject label is "unlabeled_t", i.e.
no labeling information available.  From the MLS pov, you have your
CIPSO label.  Why "network_t" instead?

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
