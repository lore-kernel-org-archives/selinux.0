Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id hAR2R0Rb022829
	for <selinux@tycho.nsa.gov>; Wed, 26 Nov 2003 21:27:00 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id hAR2QPp5003733
	for <selinux@tycho.nsa.gov>; Thu, 27 Nov 2003 02:26:25 GMT
Received: from ns.sws.net.au (ns.sws.net.au [61.95.69.3])
	by jazzswing.ncsc.mil  with ESMTP id hAR2QOt0003730
	for <selinux@tycho.nsa.gov>; Thu, 27 Nov 2003 02:26:24 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Diyab <diyab@diyab.net>, SELinux Mail List <selinux@tycho.nsa.gov>
Subject: Re: BSD Secure levels for linux
Date: Thu, 27 Nov 2003 13:26:53 +1100
References: <3FC54560.5050303@diyab.net>
In-Reply-To: <3FC54560.5050303@diyab.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200311271326.53583.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 27 Nov 2003 11:29, Diyab <diyab@diyab.net> wrote:
> Has anyone else run across the kernel patch that implements something
> similar to the BSD secure levels?  Has anyone tried to use this with
> selinux?  I'm also curious what the general thought of the idea is.
> Good idea? Bad idea?  What do you think?

The concept of secure levels is to have an option to put the system into a 
mode where module loading and various other things are denied.

You could of course have a SE Linux configuration where you have multiple 
policydb binaries, the one that loads on boot would have the current 
functionality.  Other policydb's would have limited functionality (EG prevent 
insmod_t from doing anything other than sending sigchld to init_t and 
preventing load_policy).  Then loading a new policy would give a similar 
result to changing a BSD secure level.

If someone else wants to make a start on this then I would be interested in 
merging patches into my policy tree as I think that the functionality is 
useful.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
