Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id iBIBVhIi007527
	for <selinux@tycho.nsa.gov>; Sat, 18 Dec 2004 06:31:43 -0500 (EST)
Received: from gw.linuon.co.jp (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id iBIBViY6014514
	for <selinux@tycho.nsa.gov>; Sat, 18 Dec 2004 11:31:45 GMT
Received: from pc-1.linuon.co.jp (pc-1.linuon.co.jp [192.168.0.101])
	by gw.linuon.co.jp (8.13.1/8.12.11) with ESMTP id iBIBY43t006788
	for <selinux@tycho.nsa.gov>; Sat, 18 Dec 2004 20:34:04 +0900
From: Linux <linux@linuon.com>
To: SELinux ML <selinux@tycho.nsa.gov>
Subject: User Space Auditing
Date: Sat, 18 Dec 2004 20:31:43 +0900
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200412182031.43836.linux@linuon.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Dear SELinux gurus,

I have a quick question regarding auditing facility in SELinux.
It might not be really relating to SELinux, could be stupid 
question though.
What I want to do is capture SELinux audit logs directly from user space
daemon, just like netfilter's ulogd. Is there any daemon like ulogd already?
If not, are there any programs that use the audit facility that 
I can refer to?
It seems not right thing to do that porting SELinux to use ulog facility.
I looked for info about audit but there's almost no useful info available on
the internet.  I found there's Hert.org who seems to be original developer of 
linux audit facility but all related info had been removed from their server
now. Even Faith's, who is author of auditd, audit page on RedHat's site has
been removed.
If anyone out there know how to use linux audit facility then 
please enlighten me. 

Thank you,

-- Junji Kanemaru
Linuon Inc.
Tokyo Japan

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
