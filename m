Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id GAA05415
	for <selinux@tycho.nsa.gov>; Thu, 4 Jul 2002 06:45:53 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id KAA16930
	for <selinux@tycho.nsa.gov>; Thu, 4 Jul 2002 10:44:26 GMT
Received: from mail.ispko.com ([210.16.10.89])
        by jazzband.ncsc.mil  with ESMTP id KAA16926 for <selinux@tycho.nsa.gov>; Thu, 4 Jul 2002 10:44:25 GMT
Received: from evoworks.evoserve.com (rogelio@evoworks.evoserve.com [210.16.10.5])
	by mail.ispko.com (8.12.3/8.12.3) with ESMTP id g64ApoCM012769
	for <selinux@tycho.nsa.gov>; Thu, 4 Jul 2002 18:51:51 +0800
Message-ID: <3D24275D.7050904@evoworks.evoserve.com>
Date: Thu, 04 Jul 2002 18:45:49 +0800
From: Debian User <rogelio@evoworks.evoserve.com>
MIME-Version: 1.0
To: selinux@tycho.nsa.gov
Subject: cramfs policy
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

It looks like i have to define a whole new cramfs based policy to make 
selinux work on a cramfs root. it is cool though.
i need to setup a complete chroot environment to develop a cramfs only 
policy.


--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
