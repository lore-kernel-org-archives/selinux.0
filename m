Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h42HGPI4017997
	for <selinux@tycho.nsa.gov>; Fri, 2 May 2003 13:16:25 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id h42HGDVf019219
	for <selinux@tycho.nsa.gov>; Fri, 2 May 2003 17:16:13 GMT
Received: from sat.sws.net.au ([202.5.161.49])
	by jazzswing.ncsc.mil  with ESMTP id h42HFs4D019210
	for <selinux@tycho.nsa.gov>; Fri, 2 May 2003 17:16:10 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: forrest whitcher <fw@fwsystems.com>
Subject: Re: Trusted Operating System?
Date: Sat, 3 May 2003 03:14:55 +1000
Cc: <selinux@tycho.nsa.gov>
References: <AED99F3E5CF6C749B320E3B51B0D14B217B52F@EMSS01M10.us.lmco.com> <20030502120209.688e3b7a.fw@fwsystems.com>
In-Reply-To: <20030502120209.688e3b7a.fw@fwsystems.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200305030314.55043.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sat, 3 May 2003 02:02, forrest whitcher wrote:
> As I've read NSA's intent and statements, SELinux (and the Flask
> implementation that's been ported to TrustedBSD) is an R&D project
> intended to demonstrate how to build assurance that is wired into

Regardless of some of the statements on the NSA web site, I consider SE Linux 
to be more than a R&D project or a demonstration.

All the computers that I run (servers for two companies I work for, my own 
servers, my laptop and the laptops and workstations I administer for other 
people) use SE Linux as part of their protection.

For me and my clients SE Linux is a standard security feature.

> For instance (Please don't rely on this statement) as near as I
> have been able to determine, the lsm/SEL kernel prevents the recent
> ptrace local-root exploit from gaining privilege.

If you configure it to deny ptrace.

If you had configured SE Linux to deny ptrace out of general paranoia then the 
discovery of the kernel bug would not have concerned you.  If you hadn't then 
the bug forced you to change the policy to deny ptrace as Steve described.

This is still significantly better than the situation with non-SE machines.  
One administrator I know was unable to compile a new kernel for his server 
(for some reason all new kernels he compiled would crash).  So he was trying 
to write a loadable module for his kernel to change the syscall table and 
deny ptrace!

With SE Linux all that is required to protect against the ptrace bug is a 
single line change to the security policy and a reload of the policy (no 
reboot required).

It is reasonable to expect that at some future time there will be other kernel 
bugs discovered which may be as easily solvable in SE Linux and as totally 
painful otherwise.


One of my clients has as their main server a machine that won't run a new 
kernel I compiled to solve the ptrace issue.  I suspect that it may be 
related to some GCC vs old hardware issue, but can't fool around with their 
server enough to track it down.  It's running with ~ptrace in the 
global_macros file, and may continue running in such a fashion until they 
purchase new hardware.  If they weren't using SE Linux then I would have to 
visit their office (inconveniant for me) and they would have to put up with 
down-time until I could solve the problem that prevents a kernel upgrade.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
