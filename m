Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h5DJwnI4007172
	for <selinux@tycho.nsa.gov>; Fri, 13 Jun 2003 15:58:50 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h5DJwm5e012011
	for <selinux@tycho.nsa.gov>; Fri, 13 Jun 2003 19:58:48 GMT
Received: from sat.sws.net.au ([202.5.161.49])
        by jazzband.ncsc.mil  with ESMTP id h5DJwk92012008 for <selinux@tycho.nsa.gov>; Fri, 13 Jun 2003 19:58:47 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: Stephen Smalley <sds@epoch.ncsc.mil>, Michael Lambert <mlambe7@lsu.edu>
Subject: Re: Status of selinux on IBM mainframe
Date: Sat, 14 Jun 2003 05:58:40 +1000
Cc: selinux@tycho.nsa.gov
References: <1055514931.6878.33.camel@lambert.ocs.lsu.edu> <1055526062.1039.214.camel@moss-huskers.epoch.ncsc.mil>
In-Reply-To: <1055526062.1039.214.camel@moss-huskers.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200306140558.40220.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sat, 14 Jun 2003 03:41, Stephen Smalley wrote:
> On Fri, 2003-06-13 at 10:35, Michael Lambert wrote:
> > I was wondering what the development status of selinux was for
> > architectures other than intel, particularly for linux on the IBM
> > mainframe. I've searched the list archives and found a few mentions of
> > the s/390, but nothing very descriptive. If there is a desire to port
> > selinux to mainframe linux, I may be able to lend a hand in development.
>
> There isn't much point in pursuing such a port; the overhaul of the

Unless you want to get it working before 2.6.0 is released, or 2.6.0 doesn't 
work for you for some reason.

After 2.6.0 is released I don't expect everyone to upgrade to it instantly, 
ARM/Familiar is still based on 2.4.19 with no stated plans for upgrading, and 
many people for various reasons are still on 2.2.x kernels.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
