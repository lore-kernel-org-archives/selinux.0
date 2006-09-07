Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k87Jp8VN024923
	for <selinux@tycho.nsa.gov>; Thu, 7 Sep 2006 15:51:08 -0400
Received: from sccrmhc14.comcast.net (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k87JojDY001602
	for <selinux@tycho.nsa.gov>; Thu, 7 Sep 2006 19:50:45 GMT
From: andy.suchoski@comcast.net
To: selinux@tycho.nsa.gov
Subject: IPC security context
Date: Thu, 07 Sep 2006 19:52:31 +0000
Message-Id: <090720061952.1961.4500787F000360CF000007A9220702155307059C01080C9A9CD2970B020E@comcast.net>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hello,

Is there any way to see the security context of semaphores, message queues and shared memory areas? I would have expected to see a "-Z" option on the ipcs command since this command reports DAC information.

Also, are there any library routines to access the security attributes of IPC objects?

Thanks.

- Andy Suchoski

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
