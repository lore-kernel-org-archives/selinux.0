Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i0TCBoRb011001
	for <selinux@tycho.nsa.gov>; Thu, 29 Jan 2004 07:11:52 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id i0TCAWVK027325
	for <selinux@tycho.nsa.gov>; Thu, 29 Jan 2004 12:10:32 GMT
Received: from ns.sws.net.au ([61.95.69.3])
	by jazzswing.ncsc.mil  with ESMTP id i0TCAFlx027273
	for <selinux@tycho.nsa.gov>; Thu, 29 Jan 2004 12:10:31 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: keen@internode.on.net, "keen@internode.on.net" <keen@internode.on.net>,
   selinux@tycho.nsa.gov
Subject: Re: Problem with selinux configuration
Date: Thu, 29 Jan 2004 23:10:05 +1100
References: <40186cf7.274.6f79.443726088@internode.on.net>
In-Reply-To: <40186cf7.274.6f79.443726088@internode.on.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200401292310.05430.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 29 Jan 2004 13:16, "keen@internode.on.net" <keen@internode.on.net> 
wrote:
> So does that leave me with going onto Fedora on setting it
> up? (or perhaps try it on gentoo?) What if i used the

As Steve mentioned, Dan's packages currently require rawhide.

For starting on using Fedora with SE Linux it might be easiest to wait for the 
release of FC2.  FC2 will come with full SE Linux support out of the box and 
save you from a lot of this.

> selinux-usr-2003100110.tgz package released 1 Oct 2003? It
> would be for RH9 right? Would there be any undesirable
> effects with 2.6.0 kernel? Which option would be a better
> way to get SELinux up and running?

The stock 2.6.0 and 2.6.1 kernels will run fine with SE Linux.  There are some 
new features that have been added recently, but you probably don't need them 
immediately.

If using Fedora then it's easiest to just use Arjan's 2.6.x kernel packages.  
By the time you finish your tests and are ready for a serious deployment of 
SE Linux, FC2 will be out and will have a kernel package that has all the 
patches.


What exactly are your aims?  Do you want to try out SE Linux on Red Hat or 
Fedora before running a serious server on Red Hat?  Or do you just want to 
try out SE Linux without any particular preference to distribution.

If you just want to try out SE Linux without any distribution preference then 
the Gentoo people are apparently working on a live CD image.  That will allow 
you to boot SE Linux from a CD and try it out without risk of messing with 
anything on your hard disk.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
