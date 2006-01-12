Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id k0CFWDXf010221
	for <selinux@tycho.nsa.gov>; Thu, 12 Jan 2006 10:32:13 -0500 (EST)
Received: from gotham.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id k0CFWBDu019817
	for <selinux@tycho.nsa.gov>; Thu, 12 Jan 2006 15:32:12 GMT
Subject: sound policy (aumix-minimal)
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: SELinux Mail List <selinux@tycho.nsa.gov>
Content-Type: text/plain
Date: Thu, 12 Jan 2006 10:33:06 -0500
Message-Id: <1137079986.29815.196.camel@sgc.columbia.tresys.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Is the sound policy (sound.te) actually needed?  It is meant
for /bin/aumix-minimal to set alsa mixer settings when booting.  Looking
at the permissions, initrc_t already has sufficient permissions to do
this.  I believe we can drop this module.  Thoughts?

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
