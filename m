Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id EAA05234
	for <selinux@tycho.nsa.gov>; Thu, 4 Jul 2002 04:49:13 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id IAA13907
	for <selinux@tycho.nsa.gov>; Thu, 4 Jul 2002 08:47:46 GMT
Received: from mail.ispko.com ([210.16.10.89])
        by jazzband.ncsc.mil  with ESMTP id IAA13903 for <selinux@tycho.nsa.gov>; Thu, 4 Jul 2002 08:47:45 GMT
Received: from evoworks.evoserve.com (rogelio@evoworks.evoserve.com [210.16.10.5])
	by mail.ispko.com (8.12.3/8.12.3) with ESMTP id g648t3CM012056
	for <selinux@tycho.nsa.gov>; Thu, 4 Jul 2002 16:55:04 +0800
Message-ID: <3D240BFE.4000909@evoworks.evoserve.com>
Date: Thu, 04 Jul 2002 16:49:02 +0800
From: Debian User <rogelio@evoworks.evoserve.com>
MIME-Version: 1.0
To: selinux@tycho.nsa.gov
Subject: using genfs_context and cramfs
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

i can already mount a cramfs_file and it get labeled with "cramfs_t"
i relabeled the directory where i built the cramfs from but when i mount 
it via loopback. the labels are still cramfs. How do we use the fs image 
as a root fs then?


--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
