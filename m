Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id p1PJq935025558
	for <selinux@tycho.nsa.gov>; Fri, 25 Feb 2011 14:52:09 -0500
Received: from e1.ny.us.ibm.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id p1PJq8cb026734
	for <selinux@tycho.nsa.gov>; Fri, 25 Feb 2011 19:52:08 GMT
Received: from d01dlp01.pok.ibm.com (d01dlp01.pok.ibm.com [9.56.224.56])
	by e1.ny.us.ibm.com (8.14.4/8.13.1) with ESMTP id p1PJgTSK012034
	for <selinux@tycho.nsa.gov>; Fri, 25 Feb 2011 14:42:29 -0500
Received: from d01relay01.pok.ibm.com (d01relay01.pok.ibm.com [9.56.227.233])
	by d01dlp01.pok.ibm.com (Postfix) with ESMTP id 3D6A938C8036
	for <selinux@tycho.nsa.gov>; Fri, 25 Feb 2011 14:52:07 -0500 (EST)
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
	by d01relay01.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id p1PJq7Xo401572
	for <selinux@tycho.nsa.gov>; Fri, 25 Feb 2011 14:52:07 -0500
Received: from d01av01.pok.ibm.com (loopback [127.0.0.1])
	by d01av01.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id p1PJq6uP006353
	for <selinux@tycho.nsa.gov>; Fri, 25 Feb 2011 14:52:06 -0500
Subject: Re: [PATCH 05/10] selinux: selinux_xfrm_decode_session check for
 socket sid
From: Joy Latten <latten@austin.ibm.com>
Reply-To: latten@austin.ibm.com
To: Paul Moore <paul.moore@hp.com>
Cc: Steffen Klassert <steffen.klassert@secunet.com>,
        linux-security-module@vger.kernel.org, selinux@tycho.nsa.gov
In-Reply-To: <201102231616.39183.paul.moore@hp.com>
References: <20110214131651.GA15640@secunet.com>
	 <1297887085.25079.24.camel@sifl> <20110222121143.GC20852@secunet.com>
	 <201102231616.39183.paul.moore@hp.com>
Content-Type: text/plain
Date: Fri, 25 Feb 2011 13:21:05 -0600
Message-Id: <1298661665.2715.136.camel@faith.austin.ibm.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2011-02-23 at 16:16 -0500, Paul Moore wrote:
> On Tuesday, February 22, 2011 7:11:43 AM Steffen Klassert wrote:
> > On Wed, Feb 16, 2011 at 03:11:25PM -0500, Paul Moore wrote:
> > > On Mon, 2011-02-14 at 14:20 +0100, Steffen Klassert wrote:
> > > > selinux_xfrm_decode_session is used to decode the security identifyer
> > > > of the originating flow. So return the sid of the socket instead of
> > > > SECSID_NULL, if we have socket context but no secpath. This is
> > > > needed because ip_xfrm_me_harder (and selinux_xfrm_decode_session)
> > > > is invoked on outbound packets and before the xfrm transformations,
> > > > therefore we have no secpath and the sid of a labeled IPsec SA usually
> > > > does not match SECSID_NULL.
> > > > 
> > > > Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>
> > > 
> > > Granted, it has been some time since I've looked at the labeled IPsec
> > > code in some detail so I might be a little off here, but is it possible
> > > to move the xfrm_decode LSM hook to an area on the outbound processing
> > > where we do have a valid secpath?
> > 
> > No, we don't have a secpath for outbound packets. The secpath is used to
> > do a inbound policy check, check the used SA against their selectors etc.
> > With these checks we ensure that the packet is transformed back to it's
> > native form in the right way. That's not needed on outbound packets,
> > so we don't record a secpath in this case. The lack of a outbound
> > secpath was also the problem I mentioned in the introduction mail
> > of the patchset.
> 
> Be warned: most of this reply is just me tossing out ideas ...
> 
> Okay, so basically selinux_xfrm_decode_session() is a total waste of time in 
> the output path, yes?  I'm looking at the current code and it does nothing if 
> the sec_path is NULL, so I'm wondering why we even keep it around for the 
> outbound path.
> 
> > > If not, I'd rather see us split this
> > > hook so that we preserve the existing xfrm_decode_session() hook for
> > > input (I believe it is also used for input, yes?) and create a new hook
> > > which only grabs the sksec's label on output (preferably named so that
> > > it is clear this is the socket's label and not the SA's label).
> > 
> > I think that's not possible too. The security_xfrm_decode_session()
> > hook is used from within xfrm_decode_session(). This function
> > is used in codepaths that are used for both, inbound and outbound
> > processing (xfrm_lookup, xfrm_policy_check etc.).
> 
> This makes me wonder if the LSM hook is even in the right place.

I am unable to find the original email to get a full understanding of
the context of this particular patch so am responding via Paul's email.
If my comments seem incorrect due to lack of context... please let me
know.

I believe xfrm_decode_session is for inbound processing.
I could not readily find anything suggesting that xfrm_lookup()
results in __xfrm_decode_session() getting called. If I have missed
it, please let me know. I was looking at kernel code for 2.6.35.7.

The only exception I am readily aware of, is made for sending 
icmp error messages. 
RFC 4301, section 6.2 states special processing for icmp 
error messages. This special processing results in there being 
cases where Linux kernel will need to call
xfrm_decode_session_reverse(), to reverse flow's info and then call
xfrm_lookup() to get an SA with this "reversed" info, when
sending an icmp error message. Please see rfc 4301, section 6.2 if 
more info is required.

I am thinking that in this particular icmp case, when
security_xfrm_decode_session() is called, sec_path in the skb will
be empty, so nothing really happens. icmp_send then calls xfrm_lookup()
with the "reversed" info and regular outbound labeled ipsec processing
occurs with the reversed flow info. 

Please let me know if I have misunderstood context of discussion.

regards, 
Joy



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
