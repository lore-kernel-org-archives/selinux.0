Received: from msux-gh1-uea02.nsa.gov (msux-gh1-uea02.nsa.gov [63.239.67.2])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n4KJ12Ej011871
	for <selinux@tycho.nsa.gov>; Wed, 20 May 2009 15:01:02 -0400
Received: from mx2.redhat.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id n4KJ19fV027844
	for <selinux@tycho.nsa.gov>; Wed, 20 May 2009 19:01:09 GMT
Received: from int-mx2.corp.redhat.com (int-mx2.corp.redhat.com [172.16.27.26])
	by mx2.redhat.com (8.13.8/8.13.8) with ESMTP id n4KJ0uWj011801
	for <selinux@tycho.nsa.gov>; Wed, 20 May 2009 15:00:56 -0400
Received: from ns3.rdu.redhat.com (ns3.rdu.redhat.com [10.11.255.199])
	by int-mx2.corp.redhat.com (8.13.1/8.13.1) with ESMTP id n4KJ0tlZ021223
	for <selinux@tycho.nsa.gov>; Wed, 20 May 2009 15:00:56 -0400
Received: from localhost.localdomain (vpn-10-93.bos.redhat.com [10.16.10.93])
	by ns3.rdu.redhat.com (8.13.8/8.13.8) with ESMTP id n4KJ0tMh023167
	for <selinux@tycho.nsa.gov>; Wed, 20 May 2009 15:00:55 -0400
Message-ID: <4A14536A.4020402@redhat.com>
Date: Wed, 20 May 2009 15:00:58 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: SE Linux <selinux@tycho.nsa.gov>
Subject: chcat fixes
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Expansion of categores is still broken.  Here is a patch to fix.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
