Received: from goalie.tycho.ncsc.mil (goalie [144.51.31.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id r3BCVngO011432
	for <selinux@tycho.nsa.gov>; Thu, 11 Apr 2013 08:31:50 -0400
Received: from int-mx09.intmail.prod.int.phx2.redhat.com (int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id r3BCVeA4003894
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <selinux@tycho.nsa.gov>; Thu, 11 Apr 2013 08:31:40 -0400
Received: from [10.34.4.159] (unused-4-159.brq.redhat.com [10.34.4.159])
	by int-mx09.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id r3BCVcG7012622
	(version=TLSv1/SSLv3 cipher=DHE-RSA-CAMELLIA256-SHA bits=256 verify=NO)
	for <selinux@tycho.nsa.gov>; Thu, 11 Apr 2013 08:31:39 -0400
Message-ID: <5166AD29.60901@redhat.com>
Date: Thu, 11 Apr 2013 14:31:37 +0200
From: Ondrej Oprala <ooprala@redhat.com>
MIME-Version: 1.0
To: selinux@tycho.nsa.gov
Subject: ipc security context
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi,
is it possible to get/set a security context per separate IPC objects?
As far as my googling got me, it seems IPCs are the same context
as process creation, so I'm guessing I should probably be able
to get some info about a shared memory segment for example, by passing
lpid to getpidcon. Are my assumptions correct or am I completely off the 
chart?
I'd be very thankful for any clarification.

Have a nice day,
Ondrej

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
