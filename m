Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id XAA06431
	for <selinux@tycho.nsa.gov>; Sun, 10 Feb 2002 23:56:07 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id EAA08751
	for <selinux@tycho.nsa.gov>; Mon, 11 Feb 2002 04:55:11 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
        by jazzband.ncsc.mil  with ESMTP id EAA08747 for <selinux@tycho.nsa.gov>; Mon, 11 Feb 2002 04:55:10 GMT
Content-Type: text/plain;
  charset="us-ascii"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: SE Linux <selinux@tycho.nsa.gov>
Subject: SE Debian etc
Date: Mon, 11 Feb 2002 08:48:07 +1000
Cc: Debian Devel <debian-devel@lists.debian.org>
MIME-Version: 1.0
Message-Id: <20020211045647.1A06732ECEC@lyta.coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I've been updating the packages on http://www.coker.com.au/selinux/ .

I've just put on a version of the 2002_01_15 lsm-full patch for kernel 
2.4.18-pre9, it only needed a tiny change to match a change in the 
put_superblock code.

I've uploaded a new version of my kernel-patch-2.5-lsm package to Debian with 
support for kernel 2.5.3 and put it on my web site as I'm not sure if/when 
it'll get into testing.

I've put a new version of the my flask package of core SE Linux utilities 
online.  This version diverts start-stop-daemon to use run_init to set the 
security domain for daemons.  Also I have been working on making the code 
less intrusive to non-SE systems, run_init will not ask for a password if 
running on a non-SE kernel.

I've packaged a SE patched version of shellutils which adds a SE capable 
version of /usr/bin/id and a program "runas" to run a program in a different 
security domain.

I've put a new version of my SE patched stat package online which will work 
in the regular fashion on a non-SE kernel.

I've created a SE patched cron package.

So now I'm getting very close to having a working SE system (I think).  I 
think that all I need to do now is to spend a few days working on SE 
configuration and I'll be able to run avc_toggle...

I got this done sooner than I had planned because I gave a work-in-progress 
talk at linux.conf.au about SE Linux and needed more things to talk about.  
Now I am considering submitting a talk for Ottawa Linux Symposium about my SE 
Debian work.  I think it will interest people to see a presentation about 
hacking utilities and distribution scripts etc for SE support after they see 
a talk from someone from the NSA about the design of SE Linux (I presume that 
they will have a talk from an NSA employee again this year).

-- 
http://www.coker.com.au/bonnie++/     Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/       Postal SMTP/POP benchmark
http://www.coker.com.au/projects.html Projects I am working on
http://www.coker.com.au/~russell/     My home page


--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
