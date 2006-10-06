Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k96FBPLu028224
	for <selinux@tycho.nsa.gov>; Fri, 6 Oct 2006 11:11:25 -0400
Received: from tcsfw4.tcs-sec.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id k96FAB4o000701
	for <selinux@tycho.nsa.gov>; Fri, 6 Oct 2006 15:10:12 GMT
Message-ID: <36282A1733C57546BE392885C0618592015CFC0C@chaos.tcs.tcs-sec.com>
From: Venkat Yekkirala <vyekkirala@TrustedCS.com>
To: Joshua Brindle <jbrindle@tresys.com>,
        Venkat Yekkirala
	 <vyekkirala@TrustedCS.com>
Cc: selinux@tycho.nsa.gov
Subject: RE: Denials from newest kernel
Date: Fri, 6 Oct 2006 11:11:19 -0400 
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Joshua Brindle wrote:
> On Fri, 2006-10-06 at 10:23 -0400, Venkat Yekkirala wrote:
> > > -----Original Message-----
> > > From: Joshua Brindle [mailto:jbrindle@tresys.com]
> > > Sent: Friday, October 06, 2006 8:56 AM
> > I would have to refer you to the following discussion we had on how
> > secpoint err secmark is intended to be used thru to deciding not to
> > mess with the naming.
> > http://marc.theaimsgroup.com/?l=selinux&m=115928609916717&w=2
> 
> That peer conversation was bin/null'd though,

Stephen and others can correct me if I am wrong, but while
the naming was bin/null'd AFTER the con call, the policy was
going to be done substantially as related in the peer conversation.

> the conference 
> call we had
> indicated that the new model was going to be 
> 
> 1) domains send/recv packets

1(a). packets "carry" originating socket domains
1(b). domains "recv" from other domains the packets are "carrying".

> 2) packets flow_in and flow_out associations

2(a) Associations again merely "carry" the domain of the originating socket
     and as such are not of much relevance.
2(b) domains as carried by packets can either flow_in or flow_out of
     the security points as defined using the secmark rules.

> 3) domains polmatch spd's (which are classified as associations)

I wish the association class were renamed more like "ipsec" considering
the only 2 perms used in there are polmatch and setcontext.

> 4) domains sendto/recvfrom associations

In the compat_net case, yes. But not in the secmark world.

> 
> IMO we need to get the permissions and object classes cleared 
> up before
> merging this stuff, its very confusing and inappropriate right now.
> 

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
