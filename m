Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id iAKKTWIi027955
	for <selinux@tycho.nsa.gov>; Sat, 20 Nov 2004 15:29:32 -0500 (EST)
Received: from open.hands.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id iAKKS3LS026575
	for <selinux@tycho.nsa.gov>; Sat, 20 Nov 2004 20:28:03 GMT
Received: from lkcl.net (host81-153-247-118.range81-153.btcentralplus.com [81.153.247.118])
	by open.hands.com (Postfix) with ESMTP id BFC0ABF76
	for <selinux@tycho.nsa.gov>; Sat, 20 Nov 2004 20:29:28 +0000 (GMT)
Received: from lkcl by lkcl.net with local (Exim 4.24)
	id 1CVc1s-00077B-ML
	for selinux@tycho.nsa.gov; Sat, 20 Nov 2004 20:40:20 +0000
Date: Sat, 20 Nov 2004 20:40:20 +0000
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: SE-Linux <selinux@tycho.nsa.gov>
Subject: http://sf.net/projects/xen
Message-ID: <20041120204020.GB26761@lkcl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

for those people who do a lot of selinux testing, and am fed up
of having stacks of machines, and who also don't want to pay for
vmware, _and_ who also don't want the slowness or features of UML,
there is xen.

xen is NOT full pc emulation (like vmware, which even has its own
phoenix bios), instead you have to compile in half-way-house tty and
network drivers that allow communication between the first hosted guest
OS (which is given control of the hardware) and all other guest OSes
[which are given access to block devices via the first OS].

i look forward to seeing what happens over the next couple of days
in attempting to set up selinux 2.6.9 xen guest OSes
(/etc/motd: "welcome to debian gnu/linux 2.6.9-selinux1-xen1"...)

here goes nothing...

-- 
--
<a href="http://lkcl.net">http://lkcl.net</a>
--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
