Subject: Re: Q: SECMARK controls on forwarded packets
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Paul Moore <paul.moore@hp.com>
Cc: selinux@tycho.nsa.gov, cpebenito@tresys.com, vyekkirala@TrustedCS.com,
        jmorris@namei.org
In-Reply-To: <200801090830.15611.paul.moore@hp.com>
References: <200801082330.58907.paul.moore@hp.com>
	 <1199883104.9393.206.camel@moss-spartans.epoch.ncsc.mil>
	 <200801090830.15611.paul.moore@hp.com>
Content-Type: text/plain
Date: Wed, 09 Jan 2008 08:39:41 -0500
Message-Id: <1199885981.9393.240.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Wed, 2008-01-09 at 08:30 -0500, Paul Moore wrote:
> On Wednesday 09 January 2008 7:51:44 am Stephen Smalley wrote:
> > On Tue, 2008-01-08 at 23:30 -0500, Paul Moore wrote:
> > > So, in summary, here are the SECMARK permission checks applied to locally
> > > generated or consumed traffic [this is the status quo]:
> > >
> > >  # inbound traffic
> > >  allow socket_t secmark_t:packet recv;
> > >  # outbound traffic
> > >  allow socket_t secmark_t:packet send;
> > >
> > > ... and these are the proposed SECMARK permission checks applied to
> > > forwarded traffic as it enters and exists the forwarding-host/router:
> > >
> > >  # inbound traffic to be forwarded
> > >  allow peer_t secmark_t:packet forward;
> > >  # outbound forwarded traffic
> > >  allow peer_t secmark_t:packet send;
> >
> > The problem with the last one is that it also allows the same thing to
> > happen for locally generated traffic, which might not be what the policy
> > writer wants to allow.
> 
> Fair enough.  I'll try to think of something catchy to replace the send 
> permission in the forwarding outbound case ... if anybody has any great ideas 
> I'd love to hear them.

Well, you could just go with the obvious:
# inbound traffic to be forwarded
allow peer_t secmark_t:packet forward_in;
# outbound forwarded traffic
allow peer_t secmark_t:packet forward_out;

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
