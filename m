Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h9LIIkWt028847
	for <selinux@tycho.nsa.gov>; Tue, 21 Oct 2003 14:18:46 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id h9LIIXIS017544
	for <selinux@tycho.nsa.gov>; Tue, 21 Oct 2003 18:18:34 GMT
Received: from extern.mail.waldi.eu.org (wavehammer.waldi.eu.org [82.139.196.55])
	by jazzswing.ncsc.mil  with ESMTP id h9LIIWDc017539
	for <selinux@tycho.nsa.gov>; Tue, 21 Oct 2003 18:18:33 GMT
Date: Tue, 21 Oct 2003 08:26:14 +0200
From: Bastian Blank <bastian@waldi.eu.org>
To: SE Linux <selinux@tycho.nsa.gov>
Subject: Re: init patch for loading policy
Message-ID: <20031021062614.GA21159@wavehammer.waldi.eu.org>
References: <200310200148.15852.russell@coker.com.au> <20031020204728.GA664@wavehammer.waldi.eu.org> <200310211057.54098.russell@coker.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200310211057.54098.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, Oct 21, 2003 at 10:57:54AM +1000, Russell Coker wrote:
> > isn't it easier to divert /sbin/init and use a script which loads the
> > policy and execs the real init after?
> 
> No.  You have all the same issues, with the additional problem that the shell 
> which is used to interpret the script might do something unexpected (like 
> closing file handle 11) and break init functionality.

This pipe is only used for reexec. The reexec uses argv[0] as
executable, which is the real one, not the script.

> Another method I considered is to have a script named /sbin/se-init which 
> loads policy and exec's /sbin/init.  Then you would configure your boot 
> loader to pass "init=/sbin/se-init" to the kernel.  I have used this for UML 
> systems and it basically works.  However I am concerned about what happens if 
> init SEGV's...

That is exactly the same because at least any sysvinit versions i know
don't rely on the real name /sbin/init.

Bastian

-- 
Ahead warp factor one, Mr. Sulu.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
