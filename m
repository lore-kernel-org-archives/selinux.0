Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h8HCjQLa024799
	for <selinux@tycho.nsa.gov>; Wed, 17 Sep 2003 08:45:26 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id h8HChjLY016153
	for <selinux@tycho.nsa.gov>; Wed, 17 Sep 2003 12:43:45 GMT
Received: from sat.sws.net.au (sat.sws.net.au [202.5.161.49])
	by jazzswing.ncsc.mil  with ESMTP id h8HChhsG016150
	for <selinux@tycho.nsa.gov>; Wed, 17 Sep 2003 12:43:44 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Dale Amon <amon@vnl.com>
Subject: Re: Boot time avc messages
Date: Wed, 17 Sep 2003 22:45:18 +1000
Cc: SELinux Mail List <selinux@tycho.nsa.gov>
References: <20030915214153.GE8988@vnl.com> <200309172014.59503.russell@coker.com.au> <20030917123747.GF8988@vnl.com>
In-Reply-To: <20030917123747.GF8988@vnl.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200309172245.18594.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 17 Sep 2003 22:37, Dale Amon wrote:
> On Wed, Sep 17, 2003 at 08:14:59PM +1000, Russell Coker wrote:
> > On Wed, 17 Sep 2003 00:53, Dale Amon wrote:
> >
> > Here's a new syslogd.te that should solve most of the problems you had.
>
> Will this work with Colin's or should I try to interpolate the two?

It will work on any recent policy tree of mine or of a NSA tree with the 
patches and revisions I have recently posted to the list.

I am not sure of what is in Colin's tree at the moment.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
