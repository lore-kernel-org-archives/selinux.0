Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id GAA23030
	for <selinux@tycho.nsa.gov>; Thu, 7 Nov 2002 06:14:22 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id LAA29843
	for <selinux@tycho.nsa.gov>; Thu, 7 Nov 2002 11:12:23 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
	by jazzswing.ncsc.mil  with ESMTP id LAA29839
	for <selinux@tycho.nsa.gov>; Thu, 7 Nov 2002 11:12:21 GMT
Content-Type: text/plain;
  charset="iso-8859-1"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: "Subba Rao" <sailorn@attglobal.net>
Subject: Re: Re: SELinux and security tools?
Date: Thu, 7 Nov 2002 12:13:36 +0100
Cc: selinux <selinux@tycho.nsa.gov>
References: <20021107095823.E6B18BF1D@sat.sws.net.au>
In-Reply-To: <20021107095823.E6B18BF1D@sat.sws.net.au>
MIME-Version: 1.0
Message-Id: <200211071213.36044.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 7 Nov 2002 10:55, Subba Rao wrote:
> Thank you for replying.  In the past I would login as root to use these
> tools. My current practice is to use 'sudo' to use these security tools.  I
> will login as a regular user but use 'sudo' to use nessus or tcpdump etc.

In a default setup of SE Linux you will need to use both SUDO for "root" 
access and "newrole" for "sysadm_r" access (and newrole does not have the 
facility to allow certain commands to be run without password).

I suggest that the best mode of operation for a laptop to be used as a network 
analysis tool is to have those tools SUID root and setup such that the 
regular user domain can transition to the domains for those tools 
automatically.

My laptop is mostly a SE Linux development machine so I keep an Xterm logged 
in as sysadm_r all the time which is what I use for network sniffing etc.  
However when I get SE Linux doing most of the things I want it to do I'll 
probably cease working in this fashion and instead set it up such that I can 
use user_r or staff_r...

> One basic question about policy,  is this some configuration file that you
> develop based on your needs and then use it to compile a new kernel?

No, the policy is comprised of a set of policy files which are written with M4 
macros.  They are processed with M4 to produce a single policy.conf which is 
then compiled into a binary form that the kernel can use.  A new policy can 
be loaded into the kernel at any time.

The NSA ship a set of default policy files which do most of the things you 
will want to do, something more than a third of that is my work.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
