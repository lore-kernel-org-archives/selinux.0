Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id KAA16989
	for <selinux@tycho.nsa.gov>; Mon, 8 Apr 2002 10:56:10 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id OAA11044
	for <selinux@tycho.nsa.gov>; Mon, 8 Apr 2002 14:54:36 GMT
Received: from stingray.missi.ncsc.mil (stingray.missi.ncsc.mil [144.51.50.20])
	by jazzswing.ncsc.mil  with ESMTP id OAA11040
	for <selinux@tycho.nsa.gov>; Mon, 8 Apr 2002 14:54:35 GMT
Received: from stingray.missi.ncsc.mil (root@localhost)
	by stingray.missi.ncsc.mil with ESMTP id g38Eu0A28552
	for <selinux@tycho.nsa.gov>; Mon, 8 Apr 2002 10:56:00 -0400 (EDT)
Message-ID: <200204081456.g38Eu0L28548@stingray.missi.ncsc.mil>
From: "McFarland, David M." <DMMcFa2@missi.ncsc.mil>
To: "'selinux@tycho.nsa.gov'" <selinux@tycho.nsa.gov>
Subject: SELinux in VMWare
Date: Mon, 8 Apr 2002 10:55:58 -0400 
MIME-Version: 1.0
Content-Type: text/plain;
	charset="ISO-8859-1"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hello,

	I was wondering if anyone had been successfull in getting SELinux to
run in a VMWare virtual machine(VM)? Not wanting to screw up a whole system
if I set it up wrong I tried it in a VM, make quickinstall goes fine with no
errors. Upon trying to boot to the kernel though I always get a kernel panic
stating that it can't mount the root fs. Anyone have any experience with
this?

Dave McFarland

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
