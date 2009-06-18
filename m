Received: from msux-gh1-uea01.nsa.gov (msux-gh1-uea01.nsa.gov [63.239.67.1])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n5IGhnfT025593
	for <selinux@tycho.nsa.gov>; Thu, 18 Jun 2009 12:43:49 -0400
Received: from pobox.globalherald.net (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id n5IGhako003309
	for <selinux@tycho.nsa.gov>; Thu, 18 Jun 2009 16:43:37 GMT
Received: from [192.168.2.3] (unknown [192.168.2.3])
	by pobox.globalherald.net (Postfix) with ESMTP id 145001FD06E
	for <selinux@tycho.nsa.gov>; Thu, 18 Jun 2009 13:50:19 -0400 (EDT)
Date: Thu, 18 Jun 2009 13:50:19 -0400 (EDT)
From: Joshua Kramer <josh@globalherald.net>
To: selinux@tycho.nsa.gov
Subject: Setting Context of Threads
Message-ID: <alpine.LFD.2.00.0906181347120.602@home-av-server.home-av>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; format=flowed; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


Hello,

In this document, KaiGai outlines his SELinux Apache module.

http://code.google.com/p/sepgsql/wiki/Apache_SELinux_plus

Under the 'Internals' section, he notes that kernel versions > 2.6.28 have 
the capability to set an individual security context for each thread.

Has RedHat backported this capability to the 2.6.18 included with RHEL5? 
Or do we have to wait for RHEL6?

Thanks!
-Josh

-- 

-----
http://www.globalherald.net/jb01
GlobalHerald.NET, the Smarter Social Network! (tm)

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
