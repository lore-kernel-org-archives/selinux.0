Received: from zombie2.ncsc.mil (zombie2.ncsc.mil [144.51.88.133])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m78EFZNL009457
	for <selinux@tycho.nsa.gov>; Fri, 8 Aug 2008 10:15:35 -0400
Received: from g1t0029.austin.hp.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie2.ncsc.mil (8.12.10/8.12.10) with ESMTP id m78EFPYV027274
	for <selinux@tycho.nsa.gov>; Fri, 8 Aug 2008 14:15:26 GMT
From: Paul Moore <paul.moore@hp.com>
To: Matt Anderson <mra@hp.com>
Subject: Re: SELinux policy and performance impacts
Date: Fri, 8 Aug 2008 10:15:19 -0400
Cc: James Morris <jmorris@namei.org>, selinux@tycho.nsa.gov
References: <489B81A4.9050007@hp.com> <alpine.LRH.1.10.0808080955290.22387@tundra.namei.org>
In-Reply-To: <alpine.LRH.1.10.0808080955290.22387@tundra.namei.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200808081015.19599.paul.moore@hp.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thursday 07 August 2008 8:03:02 pm James Morris wrote:
> On Thu, 7 Aug 2008, Matt Anderson wrote:
> > I'm currently looking into the performance impact of SELinux.  Most
> > of what I have seen so far involve testing the system's performance
> > with file creation, open, and exec, but I was hoping to gather some
> > more data before finalizing any conclusions.
> >
> > I was wondering if anyone knows of any types of policy rules that
> > when loaded into the kernel are particularly detrimental to system
> > performance.  My understanding is that all policy rules are treated
> > equally once they've been compiled to binary, but I wanted to ask
> > here first in order to confirm that.
>
> Yes, all access rules are applied in a standard form with decisions
> cached in the AVC.  There were some network permissions which had to
> do a full policydb lookup on each packet to determine the label to
> use, but these are also now cached (although will still incur some
> overhead).

As an FYI, you'll want 2.6.26 to get the all of the cached network 
permissions; 2.6.25 added interface and node caches, 2.6.26 added port 
caches.  If you are looking at network performance as part of this you 
will want to make sure compat_net is disabled, i.e. use Secmark.  

Ideally you would also enable the new network_peer_controls policy 
capability but I don't think we have that enabled by default just yet, 
needs more testing I believe.

-- 
paul moore
linux @ hp

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
