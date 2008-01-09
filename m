Subject: Re: Q: SECMARK controls on forwarded packets
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Paul Moore <paul.moore@hp.com>
Cc: selinux@tycho.nsa.gov, cpebenito@tresys.com, vyekkirala@TrustedCS.com,
        jmorris@namei.org
In-Reply-To: <200801082330.58907.paul.moore@hp.com>
References: <200801082330.58907.paul.moore@hp.com>
Content-Type: text/plain
Date: Wed, 09 Jan 2008 07:51:44 -0500
Message-Id: <1199883104.9393.206.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Tue, 2008-01-08 at 23:30 -0500, Paul Moore wrote:
> Traditionally we have always checked a packet's secmark label against the 
> receiving socket and granted access based on allow rules similar to the one 
> below:
> 
>  allow socket_t secmark_t:packet recv;
> 
> ... we performed a similar check when sending packets:
> 
>  allow socket_t secmark_t:packet send;
> 
> However, when we are dealing with forwarded traffic we do not have a sending 
> or receiving socket to compare the packet's secmark label against to perform 
> access control.  Despite the lack of a socket, I believe we can still provide 
> useful access control with secmark labels by using the packet's peer label 
> (quick refresher, the packet's peer label is taken/derived from the original 
> sending socket and "attached" to the packet via NetLabel or labeled IPsec).  
> Since the packet's peer label conveys the same label as the sending socket, 
> using the packet's peer label in place of the sending socket seems to be a 
> natural fit.
> 
> Agree?  Disagree?  Other ideas?

Agree.

> Working under the assumption that you all agree, do you think we should stick 
> with the existing "packet { send recv }" permissions for forwarded traffic?  
> The "send" permission still makes sense to me for outgoing forwarded traffic 
> but the "recv" permission is all wrong since the forwarding host isn't 
> consuming the packet like it is with the existing "recv" permission.  With 
> that in mind, I'd suggest adding a new permission, "forward", which is used 
> when checking inbound forwarded traffic.
> 
> Agree?  Disagree?  Other ideas?

Disagree with re-using send, as you then cannot distinguish in policy
between what you allow to be sent from local processes vs. what you
allow to be forwarded.

> So, in summary, here are the SECMARK permission checks applied to locally 
> generated or consumed traffic [this is the status quo]:
> 
>  # inbound traffic
>  allow socket_t secmark_t:packet recv;
>  # outbound traffic
>  allow socket_t secmark_t:packet send;
> 
> ... and these are the proposed SECMARK permission checks applied to forwarded 
> traffic as it enters and exists the forwarding-host/router:
> 
>  # inbound traffic to be forwarded
>  allow peer_t secmark_t:packet forward;
>  # outbound forwarded traffic
>  allow peer_t secmark_t:packet send;

The problem with the last one is that it also allows the same thing to
happen for locally generated traffic, which might not be what the policy
writer wants to allow.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
