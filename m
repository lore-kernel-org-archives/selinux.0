Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m3ANlI7U008081
	for <selinux@tycho.nsa.gov>; Thu, 10 Apr 2008 19:47:18 -0400
Received: from us.intercode.com.au (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id m3ANlHsY025356
	for <selinux@tycho.nsa.gov>; Thu, 10 Apr 2008 23:47:17 GMT
Date: Fri, 11 Apr 2008 08:04:32 +1000 (EST)
From: James Morris <jmorris@namei.org>
To: Paul Moore <paul.moore@hp.com>
cc: linux-security-module@vger.kernel.org, netdev@vger.kernel.org,
        selinux@tycho.nsa.gov
Subject: Re: [RFC PATCH v2 0/2] Labeled networking patches for 2.6.26
In-Reply-To: <200804101725.59604.paul.moore@hp.com>
Message-ID: <Xine.LNX.4.64.0804110802140.1313@us.intercode.com.au>
References: <20080409204936.26774.55254.stgit@flek.lan> <200804101725.59604.paul.moore@hp.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 10 Apr 2008, Paul Moore wrote:

> Just a quick follow-up on testing, I've run this for a few hours on two 
> Fedora systems with both labeled and unlabeled IPsec in use with SAs 
> rekeying every 5 minutes and didn't notice anything evil.
> 
> At this point I'd strip the "RFC" from the patchset and ask that they be 
> considered for inclusion in 2.6.26 assuming there are no objections.

I suggest pushing them via DaveM's tree, unless they depend on anything in 
my tree.


- James
-- 
James Morris
<jmorris@namei.org>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
