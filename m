Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id KAA14885
	for <selinux@tycho.nsa.gov>; Wed, 2 Oct 2002 10:43:16 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id OAA16386
	for <selinux@tycho.nsa.gov>; Wed, 2 Oct 2002 14:41:42 GMT
Received: from epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
	by jazzswing.ncsc.mil  with ESMTP id OAA16382
	for <selinux@tycho.nsa.gov>; Wed, 2 Oct 2002 14:41:41 GMT
Received: from coalpipe.epoch.ncsc.mil (coalpipe [144.51.25.11])
	by epoch.ncsc.mil (8.9.3/8.9.3) with ESMTP id KAA23197
	for <selinux@tycho.nsa.gov>; Wed, 2 Oct 2002 10:43:12 -0400 (EDT)
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id UAA09740
	for <selinux@tycho.nsa.gov>; Tue, 1 Oct 2002 20:01:59 -0400 (EDT)
Content-Type: text/plain;
  charset="iso-8859-1"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: Tracy R Reed <treed@ultraviolet.org>, selinux@tycho.nsa.gov
Subject: Re: SE Linux on Debian
Date: Wed, 2 Oct 2002 02:01:46 +0200
References: <20021001153638.J5416@ultraviolet.org>
In-Reply-To: <20021001153638.J5416@ultraviolet.org>
MIME-Version: 1.0
Message-Id: <200210020201.46223.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2 Oct 2002 00:36, Tracy R Reed wrote:
> deb http://www.microcomaustralia.com.au/debian/ stable selinux
>
> because that is what is in the topic on the IRC channel. Is it ok to
> install these from stable even though my distro is actually testing?

Yes, but you can get my packages for unstable from:
deb http://www.coker.com.au/selinux/ ./

> Here are the debs:
>
> libselinux-dev
> selinux
> selinux-policy-default
>
> But the new ps, ls, sshd, etc. do not seem to be included here. Where do I
> get those? Are they not in a deb?

They are in coreutils, fileutils, shellutils, textutils, cron, dpkg, ssh, 
login, logrotate, procps, and psmisc packages.

> When I installed the new policy it asked a lot of questions such as:
>
> Setting up selinux-policy-default (2002082308-4.bam.1) ...
> File "domains/program/apache.te" changed.
> Copy/Ignore/Always ignore/view Diff [c/I/a/d]?
>
> I said Copy to all of them. I'm not running all of that but I will be
> playing with various different things so I want the latest policies
> installed. When it was done asking questions I got this error:
>
> /usr/sbin/checkpolicy:  loading policy configuration from
> /etc/security/selinux/src/policy.conf
>
> ERROR 'parse error' at token 'run_program' on line 71322:
> run_program(sysadm_t, sysadm_r, deb, dpkg_exec_t, dpkg_t)

It looks like you are missing the run_program_macros.te file.  It should be in 
/etc/selinux/macros/programs , you can copy it manually from 
/usr/share/selinux/policy/default/macros/program/run_program_macros.te .

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
