Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i3DEaMRb016622
	for <selinux@tycho.nsa.gov>; Tue, 13 Apr 2004 10:36:22 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id i3DEaLmw014549
	for <selinux@tycho.nsa.gov>; Tue, 13 Apr 2004 14:36:21 GMT
Received: from ns.sws.net.au ([61.95.69.3])
        by jazzband.ncsc.mil  with ESMTP id i3DEaJ4w014412 for <selinux@tycho.nsa.gov>; Tue, 13 Apr 2004 14:36:20 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Rogelio Serrano <rogelio@smsglobal.net>
Subject: Re: udevd domain
Date: Wed, 14 Apr 2004 00:34:55 +1000
Cc: selinux@tycho.nsa.gov
References: <5611c19c4dd1b4dfb943b46765fb5cac@debian>
In-Reply-To: <5611c19c4dd1b4dfb943b46765fb5cac@debian>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200404140034.55526.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sat, 10 Apr 2004 17:05, Rogelio Serrano <rogelio@smsglobal.net> wrote:
> What domain should udevd run in? udev_t or hotplug_t

If we are to create a new domain for udevd then it would probably be best to 
look at the devfsd policy for inspiration.

But does udev ever run as a daemon or is it always run from hotplug?  As 
hotplug already has mknod capability it seems that having udev run in it's 
context would not involve adding significant privs.  So it may be best to 
stick with hotplug_t.

I need to know more about udev to decide.  Or if you write some policy I'll 
look at it and decide what to do (I can get a good idea of what a program 
does from the policy it needs).

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
