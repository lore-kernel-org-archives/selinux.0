Subject: Re: [PATCH v4 1/2] NetLabel: secid reconciliation support
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Paul Moore <paul.moore@hp.com>
Cc: Venkat Yekkirala <vyekkirala@TrustedCS.com>, selinux@tycho.nsa.gov,
        eparis@redhat.com, jmorris@namei.org
In-Reply-To: <452414A5.8060001@hp.com>
References: <36282A1733C57546BE392885C0618592015CF96F@chaos.tcs.tcs-sec.com>
	 <452414A5.8060001@hp.com>
Content-Type: text/plain
Date: Wed, 04 Oct 2006 16:27:23 -0400
Message-Id: <1159993643.19176.256.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

(also dropping netdev, as this isn't relevant there)

On Wed, 2006-10-04 at 16:08 -0400, Paul Moore wrote:
> Venkat Yekkirala wrote:
> >>On Wed, 2006-10-04 at 15:27 -0400, Paul Moore wrote:
> >>
> >>>Venkat Yekkirala wrote:
> >>>
> >>>>>* XFRM present
> >>>>>
> >>>>>  xfrm_sid = <full context from xfrm>
> >>>>>  loc_sid = SECINITSID_NETMSG
> >>>>>  nlbl_sid = SECSID_NULL/0
> >>>>>  ext_sid = xfrm_sid
> >>>>>  final skb->secmark = avc_ok : ext_sid ? unchanged
> > 
> > 
> > As noted subsequently, I actually meant to refer to the below
> > instead of the XFRM case above:
> > 
> >  * Nothing
> > 
> >    xfrm_sid = SECSID_NULL/0
> >    loc_sid = SECSID_NULL/0
> >    nlbl_sid = SECSID_NULL/0
> >    ext_sid = xfrm_sid
> >    final skb->secmark = avc_ok : ext_sid ? unchanged
> > 
> > 
> >>>>>* NetLabel present
> >>>>>
> >>>>>  xfrm_sid = SECSID_NULL/0
> >>>>>  loc_sid = SECSID_NULL/0
> >>>>>  nlbl_sid = <SECINITSID_NETMSG te ctx, netlabel mls ctx>
> >>>>>  ext_sid = nlbl_sid
> >>>>>  final skb->secmark = avc_ok : ext_sid ? unchanged
> >>>>
> >>>>I was referring to the differences in what getpeercon would
> >>>>return in the above 2 scenarios.
> >>>>
> >>>>In the xfrm case:     final skb->secmark would be 0 
> >>
> >>resulting in getpeercon
> >>
> >>>>to return EPROTONOOPT
> >>>
> >>>In the "XFRM present" case above if the access is allowed (avc_ok is
> >>>true) then the final skb->secmark value is going to be set 
> >>
> >>to the value
> >>
> >>>of ext_sid which is the xfrm_sid.  Any calls made to 
> >>
> >>getpeercon() would
> >>
> >>>return success with the context matching xfrm_sid.
> >>>
> >>>I have a hunch we are still on different pages here ...
> >>>
> >>>
> >>>>In the NetLabel case: final skb->secmark would be 
> >>
> >>network_t resulting in
> >>
> >>>>getpeercon to return network_t
> >>>
> >>>Yep, and I understand you would like to see it as 
> >>
> >>unlabeled_t.  I think
> >>
> >>>we both have valid arguments for either case and we are 
> >>
> >>just waiting to
> >>
> >>>hear from others.
> >>
> >>I don't understand the argument for network_t, and it seems to violate
> >>our goals of 1) having consistent policy regardless of 
> >>network labeling
> >>mechanism, and 2) having getpeercon() always return a subject 
> >>label that
> >>can be used as a basis for avc_has_perm() and setexeccon() calls.
> > 
> > But in the case where there's no domain info, but a cipso label,
> > getpeercon will fail (EPROTONOOPT). Do I rememember that Paul was
> > trying to use a special SID to use as a base sid in this case?
> 
> [I'm replying to both Stephen and Venkat here as the email is coming in
> faster than I can type :)]
> 
> In the current non-secid world, if the connection is NetLabel labeled,
> the sock_rcv_skb() LSM hook uses SECINITSID_NETMSG as the base_sid and
> the recvfrom permission to control access.  Calls to getpeercon() on a
> NetLabel connection use the socket's SID as the base_sid and the network
> traffic's MLS label.

So if xinetd calls getpeercon(), it gets a context with type
"xinetd_t" (from its own socket) and the MLS label of the client?

> In the latest secid world, when there is only NetLabel labeling present
> on the connection SECINITSID_NETMSG is used as the base_sid for the
> final skb->secmark value as determined by the flow_in() LSM hook with
> the MLS label being set to match the NetLabel on the packet.  Calls to
> getpeercon() will use the secmark value of the packet when the
> connection is establishes (in *all* cases) so getpeercon() in the
> NetLabel only case will succeed and return the value determined above.

So if xinetd calls getpeercon(), it gets a context with type
"network_t" (if using netmsg) or "unlabeled_t" (if using unlabeled) and
the MLS label of the client?  So what's the issue with using
SECINITSID_UNLABELED instead?  It isn't equivalent to SECSID_NULL.  Is
that the source of confusion?

Note btw that the current xinetd patch won't work well with any of the
above, e.g. ftpd shouldn't run in any of xinetd_t, network_t, or
unlabeled_t.  And if xinetd takes the alternative approach I suggested,
then the TE portion of the peer context is completely irrelevant.

Meanwhile, for e.g. a networked policy management daemon, none of these
domains is likely to get past the avc_has_perm() check.  Which is what
we'd want, since we don't know anything about the real domain of the
client.  But the first case (return local socket's domain) is a bit
frightening - I can see policy allowing a domain to act on itself, and
not expecting that to permit arbitrary clients of unknown domain to do
likewise.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
