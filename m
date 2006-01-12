Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id k0CGcXXf011142
	for <selinux@tycho.nsa.gov>; Thu, 12 Jan 2006 11:38:33 -0500 (EST)
Received: from gotham.columbia.tresys.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k0CGbR5L017071
	for <selinux@tycho.nsa.gov>; Thu, 12 Jan 2006 16:37:27 GMT
Subject: dropping pppd_script_exec_t
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: SELinux Mail List <selinux@tycho.nsa.gov>
Content-Type: text/plain
Date: Thu, 12 Jan 2006 11:39:27 -0500
Message-Id: <1137083967.29815.205.camel@sgc.columbia.tresys.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

In the ppp module there is a type pppd_script_exec_t and its only used
in one rule:

domain_auto_trans(pppd_t, pppd_script_exec_t, initrc_t)

Looking at the actual scripts, they seem similar to regular init scripts
for configuring network devices.  Since the scripts transition to
initrc_t already, it seems like they should instead be labeled
initrc_exec_t and the regular interface call for transitioning to initrc
can be used.  Then pppd_script_exec_t would be dropped (made an alias of
initrc_exec_t for compatibility).  Is there any problem with doing this?

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
