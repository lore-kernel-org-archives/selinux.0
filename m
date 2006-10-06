Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k96FHub4028597
	for <selinux@tycho.nsa.gov>; Fri, 6 Oct 2006 11:17:56 -0400
Received: from twoface.columbia.tresys.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k96FHJ03027181
	for <selinux@tycho.nsa.gov>; Fri, 6 Oct 2006 15:17:19 GMT
Subject: RE: Denials from newest kernel
From: Joshua Brindle <jbrindle@tresys.com>
To: Venkat Yekkirala <vyekkirala@TrustedCS.com>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <36282A1733C57546BE392885C0618592015CFC0C@chaos.tcs.tcs-sec.com>
References: <36282A1733C57546BE392885C0618592015CFC0C@chaos.tcs.tcs-sec.com>
Content-Type: text/plain
Date: Fri, 06 Oct 2006 11:17:57 -0400
Message-Id: <1160147877.2876.3.camel@twoface.columbia.tresys.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2006-10-06 at 11:11 -0400, Venkat Yekkirala wrote:
> Joshua Brindle wrote:
> > On Fri, 2006-10-06 at 10:23 -0400, Venkat Yekkirala wrote:
> > > > -----Original Message-----
> > > > From: Joshua Brindle [mailto:jbrindle@tresys.com]
> > > > Sent: Friday, October 06, 2006 8:56 AM
> > > I would have to refer you to the following discussion we had on how
> > > secpoint err secmark is intended to be used thru to deciding not to
> > > mess with the naming.
> > > http://marc.theaimsgroup.com/?l=selinux&m=115928609916717&w=2
> > 
> > That peer conversation was bin/null'd though,
> 
> Stephen and others can correct me if I am wrong, but while
> the naming was bin/null'd AFTER the con call, the policy was
> going to be done substantially as related in the peer conversation.
> 

maybe so but that doesn't mean they need to be fixed now :)

> > the conference 
> > call we had
> > indicated that the new model was going to be 
> > 
> > 1) domains send/recv packets
> 
> 1(a). packets "carry" originating socket domains
> 1(b). domains "recv" from other domains the packets are "carrying".
> 

fine.

> > 2) packets flow_in and flow_out associations
> 
> 2(a) Associations again merely "carry" the domain of the originating socket
>      and as such are not of much relevance.
> 2(b) domains as carried by packets can either flow_in or flow_out of
>      the security points as defined using the secmark rules.
> 

regardless of the semantics the target type *must* be the kind of object
referred to by the target object class, anything else is very confusing.

> > 3) domains polmatch spd's (which are classified as associations)
> 
> I wish the association class were renamed more like "ipsec" considering
> the only 2 perms used in there are polmatch and setcontext.

why not do it? none of this is merged yet.

> 
> > 4) domains sendto/recvfrom associations
> 
> In the compat_net case, yes. But not in the secmark world.
> 

I think we need this, in my proxy example we depend on being able to
differentiate the socket label from the domain label. The socket label
(which is the proxy client label) needs to be able to flow over the
association but the proxy client itself should not be able to, only the
proxy server should.

> > 
> > IMO we need to get the permissions and object classes cleared 
> > up before
> > merging this stuff, its very confusing and inappropriate right now.
> > 


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
