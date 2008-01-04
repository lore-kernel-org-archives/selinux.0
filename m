From: Paul Moore <paul.moore@hp.com>
To: selinux@tycho.nsa.gov
Subject: Fwd: Re: [PATCH 1/2] LSM: Add inet_sys_snd_skb() LSM hook
Date: Fri, 4 Jan 2008 09:44:01 -0500
Cc: jmorris@namei.org, sds@tycho.nsa.gov, vyekkirala@TrustedCS.com
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Message-Id: <200801040944.01260.paul.moore@hp.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I forgot to CC you guys on my response to David Miller, the email is 
below.  In short, this means the flow control work, as currently 
implemented, are not acceptable upstream.  Further, it's clear to me 
that if we want to get acceptance from the networking community we need 
to stick to the netfilter hooks (which we are for everything but the 
outbound/egress check).

I just started thinking about this so I don't have any great ideas yet, 
but if anyone out there does feel free to share.  Patches are always 
nice too :)

----------  Forwarded Message  ----------

Subject: Re: [PATCH 1/2] LSM: Add inet_sys_snd_skb() LSM hook
Date: Friday 04 January 2008
From: Paul Moore <paul.moore@hp.com>
To: David Miller <davem@davemloft.net>

On Thursday 03 January 2008 11:45:49 pm David Miller wrote:
> From: Paul Moore <paul.moore@hp.com>
> Date: Thu, 03 Jan 2008 12:25:39 -0500
>
> > Add an inet_sys_snd_skb() LSM hook to allow the LSM to provide
> > packet level access control for all outbound packets.  Using the
> > existing postroute_last netfilter hook turns out to be problematic
> > as it is can be invoked multiple times for a single packet, e.g.
> > individual IPsec transforms, adding unwanted overhead and
> > complicating the security policy.
> >
> > Signed-off-by: Paul Moore <paul.moore@hp.com>
>
> I disagree with this change.
>
> The packet is different each time you see it in the postrouting hook,
> and also the new hook is thus redundant.

Well, thanks for taking a look.

> If it's a performance issue and you can classify the security early,
> mark the SKB as "seen" and then on subsequent hooks you can just
> return immediately if that flag is set.

Unfortunately, it's not quite that easy at present.  The only field we 
have in the skb where we could possibly set a flag is the secmark field 
which is already taken.  Granted, there is the possibility of 
segmenting the secmark field to some degree but that brings about a new 
set of problems involving the number of unique labels, backwards 
compatibility, etc.

Regardless, back to the drawing board.  I'll have to think a bit harder 
about a way to make the netfilter hooks work ...

-------------------------------------------------------

-- 
paul moore
linux security @ hp

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
