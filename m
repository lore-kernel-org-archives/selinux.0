Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m9CD779V025068
	for <selinux@tycho.nsa.gov>; Sun, 12 Oct 2008 09:07:07 -0400
Received: from mx2.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id m9CD76uZ020907
	for <selinux@tycho.nsa.gov>; Sun, 12 Oct 2008 13:07:07 GMT
Received: from int-mx2.corp.redhat.com (int-mx2.corp.redhat.com [172.16.27.26])
	by mx2.redhat.com (8.13.8/8.13.8) with ESMTP id m9CD76aT006984
	for <selinux@tycho.nsa.gov>; Sun, 12 Oct 2008 09:07:06 -0400
Received: from ns3.rdu.redhat.com (ns3.rdu.redhat.com [10.11.255.199])
	by int-mx2.corp.redhat.com (8.13.1/8.13.1) with ESMTP id m9CD75C6015583
	for <selinux@tycho.nsa.gov>; Sun, 12 Oct 2008 09:07:06 -0400
Received: from vpn-12-132.rdu.redhat.com (vpn-12-132.rdu.redhat.com [10.11.12.132])
	by ns3.rdu.redhat.com (8.13.8/8.13.8) with ESMTP id m9CD74Js005004
	for <selinux@tycho.nsa.gov>; Sun, 12 Oct 2008 09:07:05 -0400
From: Steve Grubb <sgrubb@redhat.com>
To: selinux@tycho.nsa.gov
Subject: Capabilities audit field
Date: Sun, 12 Oct 2008 09:07:07 -0400
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200810120907.07511.sgrubb@redhat.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi,

I recenetly found out that the kernel now allows more than 32 capabilities. 
This means I need to update the audit code that inteprets this value given 
from SE Linux. When I looked over the 2.6.27 kernel code, I found that SE 
Linux has not updated the capabilities code. Its still being kept as a simple 
integer in avc.h, but everywhere else I look in the kernel has moved to 
kernel_cap_t, which is an array. Are patches for moving to kernel_cap_t 
scheduled for 2.6.28? Are there security implications for not being able to 
access or control capabilities > 32?

Thanks,
-Steve

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
