Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id TAA01671
	for <selinux@tycho.nsa.gov>; Thu, 27 Jun 2002 19:46:02 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id XAA19673
	for <selinux@tycho.nsa.gov>; Thu, 27 Jun 2002 23:44:36 GMT
Received: from mail.ispko.com ([210.16.10.89])
        by jazzband.ncsc.mil  with ESMTP id XAA19669 for <selinux@tycho.nsa.gov>; Thu, 27 Jun 2002 23:44:34 GMT
Received: from evoworks.evoserve.com (rogelio@evoworks.evoserve.com [210.16.10.5])
	by mail.ispko.com (8.12.3/8.12.3) with ESMTP id g5RNprCM005286
	for <selinux@tycho.nsa.gov>; Fri, 28 Jun 2002 07:51:54 +0800
Message-ID: <3D1BA3B4.2030404@evoworks.evoserve.com>
Date: Fri, 28 Jun 2002 07:45:56 +0800
From: Debian User <rogelio@evoworks.evoserve.com>
MIME-Version: 1.0
To: selinux@tycho.nsa.gov
Subject: initctl create denied
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I cant boot into enforcing mode after I made the update for screen.
I used the latest debian packages. This is because init is denied access 
to initctl which has the wrong label.

Jun 28 06:29:51 coffeesaur2 kernel: avc:  denied  { create } for  pid=1 exe=/sbin/init path=/initctl 
scontext=system_u:system_r:init_t tcontext=system_u:object_r:tmpfs_t tclass=fifo_file





--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
