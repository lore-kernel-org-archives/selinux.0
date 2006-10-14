Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k9ECJ7SZ004437
	for <selinux@tycho.nsa.gov>; Sat, 14 Oct 2006 08:19:07 -0400
Received: from mailhub.hp.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id k9ECHmh1021177
	for <selinux@tycho.nsa.gov>; Sat, 14 Oct 2006 12:17:48 GMT
From: Paul Moore <paul.moore@hp.com>
To: James Morris <jmorris@namei.org>
Subject: Re: Denials from newest kernel
Date: Sat, 14 Oct 2006 08:18:59 -0400
Cc: selinux@tycho.nsa.gov, vyekkirala@TrustedCS.com,
        "'Christopher J. PeBenito'" <cpebenito@tresys.com>,
        "'Karl MacMillan'" <kmacmillan@mentalrootkit.com>,
        Joshua Brindle <jbrindle@tresys.com>
References: <001501c6ee39$dd9cb8a0$cc0a010a@tcssec.com> <45301640.4060407@hp.com> <Pine.LNX.4.64.0610140332010.13740@d.namei>
In-Reply-To: <Pine.LNX.4.64.0610140332010.13740@d.namei>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200610140818.59778.paul.moore@hp.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Saturday 14 October 2006 3:36 am, James Morris wrote:
> On Fri, 13 Oct 2006, Paul Moore wrote:
> > 1. The skb->secmark field should only be used for local/netfilter packet
> > labeling, neither labeled IPsec or NetLabel should ever change it's
> > value.
>
> Yep, this may be the best way forward.  They really are different types of
> labeling.  I previously mentioned a way to _internally_ have the secmark
> field carry multiple distinct labels (assign half to external labeling
> and half to internal, and transparently perform mapping so that userland
> tools always deal with the internal label only).  Perhaps this needs to be
> part of the solution.

If we had more bits in the secmark field I would agree with you (and maybe 
this is the way the community wants to go, time will tell) but I tend to 
think that 32 bits may already be a constraint at some point in the future so 
I'm hesitant to further restrict ourselves.

I think one thing to remember is that all of the external labeling mechanisms 
in use right now already have a way to carry a SID for the life of the 
sk_buff, it may just not be stored in the sk_buff struct itself.

-- 
paul moore
linux security @ hp

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
