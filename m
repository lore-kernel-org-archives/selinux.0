Received: from msux-gh1-uea02.nsa.gov (msux-gh1-uea02.nsa.gov [63.239.67.2])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n88NCbhT022464
	for <selinux@tycho.nsa.gov>; Tue, 8 Sep 2009 19:12:37 -0400
Received: from mx1.redhat.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id n88NDuxn005164
	for <selinux@tycho.nsa.gov>; Tue, 8 Sep 2009 23:13:57 GMT
Received: from int-mx03.intmail.prod.int.phx2.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.16])
	by mx1.redhat.com (8.13.8/8.13.8) with ESMTP id n88NCZuh006498
	for <selinux@tycho.nsa.gov>; Tue, 8 Sep 2009 19:12:35 -0400
Received: from localhost.localdomain (vpn-12-151.rdu.redhat.com [10.11.12.151])
	by int-mx03.intmail.prod.int.phx2.redhat.com (8.13.8/8.13.8) with ESMTP id n88NCYww032599
	for <selinux@tycho.nsa.gov>; Tue, 8 Sep 2009 19:12:35 -0400
Message-ID: <4AA6E4E2.1000303@redhat.com>
Date: Tue, 08 Sep 2009 19:12:34 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: SE Linux <selinux@tycho.nsa.gov>
Subject: setfiles leaks file descriptors
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

https://bugzilla.redhat.com/show_bug.cgi?id=521682

Patch to fix is included.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
