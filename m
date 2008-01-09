From: Paul Moore <paul.moore@hp.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Subject: Re: Q: SECMARK controls on forwarded packets
Date: Wed, 9 Jan 2008 08:30:15 -0500
Cc: selinux@tycho.nsa.gov, cpebenito@tresys.com, vyekkirala@TrustedCS.com,
        jmorris@namei.org
References: <200801082330.58907.paul.moore@hp.com> <1199883104.9393.206.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1199883104.9393.206.camel@moss-spartans.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200801090830.15611.paul.moore@hp.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wednesday 09 January 2008 7:51:44 am Stephen Smalley wrote:
> On Tue, 2008-01-08 at 23:30 -0500, Paul Moore wrote:
> > So, in summary, here are the SECMARK permission checks applied to locally
> > generated or consumed traffic [this is the status quo]:
> >
> >  # inbound traffic
> >  allow socket_t secmark_t:packet recv;
> >  # outbound traffic
> >  allow socket_t secmark_t:packet send;
> >
> > ... and these are the proposed SECMARK permission checks applied to
> > forwarded traffic as it enters and exists the forwarding-host/router:
> >
> >  # inbound traffic to be forwarded
> >  allow peer_t secmark_t:packet forward;
> >  # outbound forwarded traffic
> >  allow peer_t secmark_t:packet send;
>
> The problem with the last one is that it also allows the same thing to
> happen for locally generated traffic, which might not be what the policy
> writer wants to allow.

Fair enough.  I'll try to think of something catchy to replace the send 
permission in the forwarding outbound case ... if anybody has any great ideas 
I'd love to hear them.

-- 
paul moore
linux security @ hp

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
