Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h3M1LJI4023412
	for <selinux@tycho.nsa.gov>; Mon, 21 Apr 2003 21:21:19 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h3M1LI7R022479
	for <selinux@tycho.nsa.gov>; Tue, 22 Apr 2003 01:21:18 GMT
Received: from sat.sws.net.au ([202.5.161.49])
        by jazzband.ncsc.mil  with ESMTP id h3M1L6KP022470 for <selinux@tycho.nsa.gov>; Tue, 22 Apr 2003 01:21:17 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: "david caplan" <dac@tresys.com>, <selinux@tycho.nsa.gov>
Subject: Re: kmod_t v. kernel_t
Date: Tue, 22 Apr 2003 11:20:51 +1000
References: <GBEAJBKHFOBIBBJBCGAGCEBCCMAA.dac@tresys.com>
In-Reply-To: <GBEAJBKHFOBIBBJBCGAGCEBCCMAA.dac@tresys.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200304221120.51950.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 22 Apr 2003 05:57, david caplan wrote:
> Back on March 28th, Stephen Smalley wrote:
> >The attached patch for selinux/policy folds the kmod_t domain into
> >kernel_t and removes every_domain from kernel_t.  kmod.te can then be
> >removed.  These changes have also been committed to the sourceforge CVS
> >tree.
>
> Does this mean that kmod_t should/can be replaced by kernel_t everywhere?
> If so, vmware.te and hotplug.te need to be fixed -- at least in the policy
> on the sourceforge site.

I removed them from my policy weeks ago.  hotplug.te works fine with my 
changes.  vmware.te probably won't work the way it is in my tree, as I don't 
use it and have not had any feedback from people who use it I don't know what 
needs to be done.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
