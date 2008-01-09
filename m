From: Paul Moore <paul.moore@hp.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Subject: Re: Q: SECMARK controls on forwarded packets
Date: Wed, 9 Jan 2008 10:36:21 -0500
Cc: selinux@tycho.nsa.gov, cpebenito@tresys.com, vyekkirala@TrustedCS.com,
        jmorris@namei.org
References: <200801082330.58907.paul.moore@hp.com> <200801090830.15611.paul.moore@hp.com> <1199885981.9393.240.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1199885981.9393.240.camel@moss-spartans.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200801091036.22078.paul.moore@hp.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wednesday 09 January 2008 8:39:41 am Stephen Smalley wrote:
> On Wed, 2008-01-09 at 08:30 -0500, Paul Moore wrote:
> > Fair enough.  I'll try to think of something catchy to replace the
> > send permission in the forwarding outbound case ... if anybody has
> > any great ideas I'd love to hear them.
>
> Well, you could just go with the obvious:
> # inbound traffic to be forwarded
> allow peer_t secmark_t:packet forward_in;
> # outbound forwarded traffic
> allow peer_t secmark_t:packet forward_out;

'forward_in' and 'forward_out'?  I thought I said "something catchy"?

 :)

Seriously though, I can't think of anything better so { forward_in 
forward_out } it is.

-- 
paul moore
linux security @ hp

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
