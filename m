Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i842Y9rT012063
	for <selinux@tycho.nsa.gov>; Fri, 3 Sep 2004 22:34:09 -0400 (EDT)
Received: from europa.lunarpages.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i842Y7UQ007681
	for <selinux@tycho.nsa.gov>; Sat, 4 Sep 2004 02:34:08 GMT
Received: from adsl-65-43-161-171.dsl.bcvloh.ameritech.net ([65.43.161.171] helo=[10.0.0.26])
	by europa.lunarpages.com with asmtp (Exim 4.34)
	id 1C3QLm-00062w-Bp
	for selinux@tycho.nsa.gov; Fri, 03 Sep 2004 19:32:22 -0700
Subject: Guide to replace root as sysadm for machine
From: Stephen torri <storri@torri.org>
To: SELinux Mail List <selinux@tycho.nsa.gov>
Content-Type: text/plain
Message-Id: <1094265263.8562.24.camel@base.torri.org>
Mime-Version: 1.0
Date: Fri, 03 Sep 2004 22:34:23 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I am stumbling my way through using a non-root user as the sysadm for
the computer. Is there any advice on this?

My goal is to have a non-root user able to do the following on my Gentoo
box:

< User: storri - in sysadm_r (or whatever is appropriate) >
- emerge rsync
- emerge -av --deep world (or any package)

< User: storri - in user_r >
- compile source code in home directory.

I figured I would start small. So far I am a bit stuck on getting the
user sorted out. I figure that have a goal, two non-root users able to
do normally 'root' actions I would be on my way to learning how to
configure selinux.

So far I have added storri to the /etc/security/selinux/src/policy/user
with the following:

user storri roles { user_r sysadm_r };

Beyond this would I need to change the normal 'user' and 'group'
ownership for those directories touched by the emerge application?

Stephen

-- 
Email: storri@torri.org


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
