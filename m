Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k9E7agpG028647
	for <selinux@tycho.nsa.gov>; Sat, 14 Oct 2006 03:36:43 -0400
Received: from mail3.sea5.speakeasy.net (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k9E7a0UI011362
	for <selinux@tycho.nsa.gov>; Sat, 14 Oct 2006 07:36:01 GMT
Date: Sat, 14 Oct 2006 03:36:37 -0400 (EDT)
From: James Morris <jmorris@namei.org>
To: Paul Moore <paul.moore@hp.com>
cc: selinux@tycho.nsa.gov, vyekkirala@TrustedCS.com,
        "'Christopher J. PeBenito'" <cpebenito@tresys.com>,
        "'Karl MacMillan'" <kmacmillan@mentalrootkit.com>,
        Joshua Brindle <jbrindle@tresys.com>
Subject: Re: Denials from newest kernel
In-Reply-To: <45301640.4060407@hp.com>
Message-ID: <Pine.LNX.4.64.0610140332010.13740@d.namei>
References: <001501c6ee39$dd9cb8a0$cc0a010a@tcssec.com> <45301640.4060407@hp.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 13 Oct 2006, Paul Moore wrote:

> 1. The skb->secmark field should only be used for local/netfilter packet
> labeling, neither labeled IPsec or NetLabel should ever change it's value.

Yep, this may be the best way forward.  They really are different types of 
labeling.  I previously mentioned a way to _internally_ have the secmark 
field carry multiple distinct labels (assign half to external labeling 
and half to internal, and transparently perform mapping so that userland 
tools always deal with the internal label only).  Perhaps this needs to be 
part of the solution.


-- 
James Morris
<jmorris@namei.org>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
