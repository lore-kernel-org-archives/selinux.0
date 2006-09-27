Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k8RGpwYq023860
	for <selinux@tycho.nsa.gov>; Wed, 27 Sep 2006 12:51:58 -0400
Received: from kokytos.rz.ifi.lmu.de (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k8RGpOJr007297
	for <selinux@tycho.nsa.gov>; Wed, 27 Sep 2006 16:51:25 GMT
Received: from localhost.localdomain (nickel.cip.ifi.lmu.de [141.84.214.100])
	by kokytos.rz.ifi.lmu.de (Postfix) with ESMTP id 9C1AF43AD9
	for <selinux@tycho.nsa.gov>; Wed, 27 Sep 2006 18:51:56 +0200 (CEST)
Date: Wed, 27 Sep 2006 18:52:34 +0200
From: Thomas Bleher <bleher@informatik.uni-muenchen.de>
To: SELinux ML <selinux@tycho.nsa.gov>
Subject: Bug in 2.6.18: read of /proc/$PID/exe triggers ptrace check
Message-ID: <20060927165234.GA5448@warschau.cip.ifi.lmu.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

It seems like there's a bug in the linux kernel, v2.6.18.
Whenever a process wants to read the /proc/$PID/exe symlink of a process
in another domain, SELinux checks for the ptrace permission.

That's very unfortunate, as SUSE uses a program called killproc to shut
down system services, which reads this symlink before doing anything.
SUSE's mingetty also fails because of this, which means that the system
is practically unusable.
With 2.6.17 (or any earlier kernel), the system works fine.

I think this change should be reverted. The right to read this symlink
is already covered by the check on read permission; also,
/proc/$PID/cmdline contains the same information, most of the time.

Thomas


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
