Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id PAA08240
	for <selinux@tycho.nsa.gov>; Tue, 5 Nov 2002 15:07:04 -0500 (EST)
From: azeredo@qmc.ufsc.br
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id UAA16756
	for <selinux@tycho.nsa.gov>; Tue, 5 Nov 2002 20:05:07 GMT
Received: from quark.qmc.ufsc.br (bohr-gw.qmc.ufsc.br [150.162.31.223])
	by jazzswing.ncsc.mil  with ESMTP id UAA16752
	for <selinux@tycho.nsa.gov>; Tue, 5 Nov 2002 20:05:05 GMT
Received: (from wwwrun@localhost)
	by quark.qmc.ufsc.br (8.11.3/8.11.3/SuSE Linux 8.11.1-0.5) id gA5KSXw15343
	for selinux@tycho.nsa.gov; Tue, 5 Nov 2002 18:28:33 -0200
Message-ID: <1036528113.3dc829f18bb9c@qmc.ufsc.br>
Date: Tue,  5 Nov 2002 18:28:33 -0200
To: selinux@tycho.nsa.gov
Subject: Selinux on RH8
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov



 Thank you guys for the help. But i still got some problems. I did

make relabel after adding the Wasterman lines for the postfix policy and reboot
and got the following messages:

Activating swap partitions
/etc/rc.d/rc.sysinit: line 318 /etc/mtab: Read-only file system
/etc/rc.d/rc.sysinit: line 324 Segmentation fault mount -f
touch: creating '/var/lock/subsys/network/ ' Read-only file system

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
