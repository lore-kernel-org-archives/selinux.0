Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h9L0vxWt023799
	for <selinux@tycho.nsa.gov>; Mon, 20 Oct 2003 20:57:59 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id h9L0vl0p018120
	for <selinux@tycho.nsa.gov>; Tue, 21 Oct 2003 00:57:47 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [61.95.69.2])
	by jazzswing.ncsc.mil  with ESMTP id h9L0vjr7018117
	for <selinux@tycho.nsa.gov>; Tue, 21 Oct 2003 00:57:46 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Bastian Blank <bastian@waldi.eu.org>, SE Linux <selinux@tycho.nsa.gov>
Subject: Re: init patch for loading policy
Date: Tue, 21 Oct 2003 10:57:54 +1000
References: <200310200148.15852.russell@coker.com.au> <20031020204728.GA664@wavehammer.waldi.eu.org>
In-Reply-To: <20031020204728.GA664@wavehammer.waldi.eu.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200310211057.54098.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 21 Oct 2003 06:47, Bastian Blank wrote:
> On Mon, Oct 20, 2003 at 01:48:15AM +1000, Russell Coker wrote:
> > I've attached a patch for /sbin/init to load the policy and set enforcing
> > mode.  Here's a quick summary of the algorithm:
>
> isn't it easier to divert /sbin/init and use a script which loads the
> policy and execs the real init after?

No.  You have all the same issues, with the additional problem that the shell 
which is used to interpret the script might do something unexpected (like 
closing file handle 11) and break init functionality.

I've tested out making a diversion for /sbin/init, it basically works, but I 
don't think it's a good solution.

Another method I considered is to have a script named /sbin/se-init which 
loads policy and exec's /sbin/init.  Then you would configure your boot 
loader to pass "init=/sbin/se-init" to the kernel.  I have used this for UML 
systems and it basically works.  However I am concerned about what happens if 
init SEGV's...

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
