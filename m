Received: from msux-gh1-uea01.nsa.gov (msux-gh1-uea01.nsa.gov [63.239.67.1])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n7RD4QCa019361
	for <selinux@tycho.nsa.gov>; Thu, 27 Aug 2009 09:04:26 -0400
Received: from mx1.redhat.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id n7RD3oIt002338
	for <selinux@tycho.nsa.gov>; Thu, 27 Aug 2009 13:03:51 GMT
Received: from int-mx08.intmail.prod.int.phx2.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.21])
	by mx1.redhat.com (8.13.8/8.13.8) with ESMTP id n7RD4P1l003466
	for <selinux@tycho.nsa.gov>; Thu, 27 Aug 2009 09:04:25 -0400
Received: from localhost.localdomain (dhcp-100-2-12.bos.redhat.com [10.16.2.12])
	by int-mx08.intmail.prod.int.phx2.redhat.com (8.13.8/8.13.8) with ESMTP id n7RD4OMX026765
	for <selinux@tycho.nsa.gov>; Thu, 27 Aug 2009 09:04:25 -0400
Message-ID: <4A968455.3050209@redhat.com>
Date: Thu, 27 Aug 2009 09:04:21 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: SE Linux <selinux@tycho.nsa.gov>
Subject: bugzilla 518569 discusses making vsftpd SELinux aware.
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

https://bugzilla.redhat.com/show_bug.cgi?id=518569

The discussion surrounds potentially adding setcon function to vstfpd to drop level to a level appropriate the the user when he logs in.  The discussion is around using MCS for this, but I guess I could see some utilization around MLS.

Not sure MLS would go for it though since there is a potential for information leak.

Comments?

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
