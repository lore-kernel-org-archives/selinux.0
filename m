Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h8Q2gGsJ028180
	for <selinux@tycho.nsa.gov>; Thu, 25 Sep 2003 22:42:16 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id h8Q2eVZt018001
	for <selinux@tycho.nsa.gov>; Fri, 26 Sep 2003 02:40:31 GMT
Received: from sat.sws.net.au (sat.sws.net.au [202.5.161.49])
	by jazzswing.ncsc.mil  with ESMTP id h8Q2eTM3017998
	for <selinux@tycho.nsa.gov>; Fri, 26 Sep 2003 02:40:30 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Diyab <diyab@diyab.net>
Subject: Re: ssh policy hassles
Date: Fri, 26 Sep 2003 12:42:07 +1000
Cc: SELinux Mail List <selinux@tycho.nsa.gov>
References: <F5441DDE18FFD9418974338018C522B718BDB0@na1fcm61.dearborn.ford.com> <200309260247.39337.russell@coker.com.au> <3F73854B.1080408@diyab.net>
In-Reply-To: <3F73854B.1080408@diyab.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200309261242.07521.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 26 Sep 2003 10:16, Diyab wrote:
> > In my latest policy I have the privsep directory (which is under /var/run
> > in Debian) labeled as var_run_t.  In the case of sshd as a daemon it can
> > create files under that, but in the case of sshd run from inetd (which is
> > what you will be doing if you want to lock down sshd) then it gets {
> > getattr search } access.
>
> What do you get by running sshd through inetd that you don't get by
> running sshd alone?

When run from inetd the sshd can not bind to port 22, so an attacker can't 
cause the current sshd to die and take over the port.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
