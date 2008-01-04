From: Paul Moore <paul.moore@hp.com>
To: selinux@tycho.nsa.gov
Subject: Re: Fwd: Re: [PATCH 1/2] LSM: Add inet_sys_snd_skb() LSM hook
Date: Fri, 4 Jan 2008 12:52:05 -0500
Cc: jmorris@namei.org, sds@tycho.nsa.gov, vyekkirala@TrustedCS.com
References: <200801040944.01260.paul.moore@hp.com>
In-Reply-To: <200801040944.01260.paul.moore@hp.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200801041252.05403.paul.moore@hp.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Friday 04 January 2008 9:44:01 am Paul Moore wrote:
> I forgot to CC you guys on my response to David Miller, the email is
> below.  In short, this means the flow control work, as currently
> implemented, are not acceptable upstream.  Further, it's clear to me
> that if we want to get acceptance from the networking community we
> need to stick to the netfilter hooks (which we are for everything but
> the outbound/egress check).
>
> I just started thinking about this so I don't have any great ideas
> yet, but if anyone out there does feel free to share.  Patches are
> always nice too :)

I think I might have a solution to the problem and it isn't _too_ ugly.

Basically, the only time we are really have to worry about multiple hits 
on the postroute hook is when IPsec is in use, all other times this 
shouldn't really be an issue.  Our problem has always been that in the 
case of IPsec we only want to perform an access check on the packet the 
_last_ time it hits the postroute hook, which has so far proven to be 
difficult.

I believe that if we simplify the problem to just IPsec causing multiple 
hits on the postroute hook we have a simple solution.  The fix is to 
only apply the new egress access checks when skb->dst->xfrm == NULL.  
All IPsec packets eventually have to make their way out of the system 
and on their final pass through the stack the skb->dst->xfrm entry is 
NULL because they have already had all their IPsec packet transforms 
applied and are now considered "normal" IP packets.  It is at this 
point that we want to apply the egress checks, and from a practical 
point of view this is not far removed from where we had placed the new 
LSM egress hook in the first place.

I'm going to start hacking something together and hopefully will have an 
updated patchset early next week.  In the meantime, if anyone can think 
of a reason why this approach is doomed for failure please speak up ...

-- 
paul moore
linux security @ hp

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
