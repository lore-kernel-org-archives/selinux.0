Subject: RE: [PATCH v4 1/2] NetLabel: secid reconciliation support
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Venkat Yekkirala <vyekkirala@TrustedCS.com>
Cc: Paul Moore <paul.moore@hp.com>, selinux@tycho.nsa.gov, eparis@redhat.com,
        jmorris@namei.org
In-Reply-To: <36282A1733C57546BE392885C0618592015CF96F@chaos.tcs.tcs-sec.com>
References: <36282A1733C57546BE392885C0618592015CF96F@chaos.tcs.tcs-sec.com>
Content-Type: text/plain
Date: Wed, 04 Oct 2006 16:12:30 -0400
Message-Id: <1159992750.19176.244.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2006-10-04 at 15:53 -0400, Venkat Yekkirala wrote:
> > On Wed, 2006-10-04 at 15:27 -0400, Paul Moore wrote:
> > > Venkat Yekkirala wrote:
> > > >> * XFRM present
> > > >>
> > > >>   xfrm_sid = <full context from xfrm>
> > > >>   loc_sid = SECINITSID_NETMSG
> > > >>   nlbl_sid = SECSID_NULL/0
> > > >>   ext_sid = xfrm_sid
> > > >>   final skb->secmark = avc_ok : ext_sid ? unchanged
> 
> As noted subsequently, I actually meant to refer to the below
> instead of the XFRM case above:
> 
>  * Nothing
> 
>    xfrm_sid = SECSID_NULL/0
>    loc_sid = SECSID_NULL/0
>    nlbl_sid = SECSID_NULL/0
>    ext_sid = xfrm_sid
>    final skb->secmark = avc_ok : ext_sid ? unchanged
> 
> > > >>
> > > >> * NetLabel present
> > > >>
> > > >>   xfrm_sid = SECSID_NULL/0
> > > >>   loc_sid = SECSID_NULL/0
> > > >>   nlbl_sid = <SECINITSID_NETMSG te ctx, netlabel mls ctx>
> > > >>   ext_sid = nlbl_sid
> > > >>   final skb->secmark = avc_ok : ext_sid ? unchanged
> > > > 
> > > > I was referring to the differences in what getpeercon would
> > > > return in the above 2 scenarios.
> > > > 
> > > > In the xfrm case:     final skb->secmark would be 0 
> > resulting in getpeercon
> > > > to return EPROTONOOPT
> > > 
> > > In the "XFRM present" case above if the access is allowed (avc_ok is
> > > true) then the final skb->secmark value is going to be set 
> > to the value
> > > of ext_sid which is the xfrm_sid.  Any calls made to 
> > getpeercon() would
> > > return success with the context matching xfrm_sid.
> > > 
> > > I have a hunch we are still on different pages here ...
> > > 
> > > > In the NetLabel case: final skb->secmark would be 
> > network_t resulting in
> > > > getpeercon to return network_t
> > > 
> > > Yep, and I understand you would like to see it as 
> > unlabeled_t.  I think
> > > we both have valid arguments for either case and we are 
> > just waiting to
> > > hear from others.
> > 
> > I don't understand the argument for network_t, and it seems to violate
> > our goals of 1) having consistent policy regardless of 
> > network labeling
> > mechanism, and 2) having getpeercon() always return a subject 
> > label that
> > can be used as a basis for avc_has_perm() and setexeccon() calls.
> 
> But in the case where there's no domain info, but a cipso label,
> getpeercon will fail (EPROTONOOPT). Do I rememember that Paul was
> trying to use a special SID to use as a base sid in this case?

Why does getpeercon fail in that case?  SECSID_NULL !=
SECINITSID_UNLABELED, even if they end up mapping to the same context.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
