Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id jBFGIvMA022521
	for <selinux@tycho.nsa.gov>; Thu, 15 Dec 2005 11:18:59 -0500 (EST)
Received: from e1.ny.us.ibm.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id jBFGIssl005353
	for <selinux@tycho.nsa.gov>; Thu, 15 Dec 2005 16:18:54 GMT
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e1.ny.us.ibm.com (8.12.11/8.12.11) with ESMTP id jBFGIltP023498
	for <selinux@tycho.nsa.gov>; Thu, 15 Dec 2005 11:18:47 -0500
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay04.pok.ibm.com (8.12.10/NCO/VERS6.8) with ESMTP id jBFGIlbF117546
	for <selinux@tycho.nsa.gov>; Thu, 15 Dec 2005 11:18:47 -0500
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.12.11/8.13.3) with ESMTP id jBFGIj21026096
	for <selinux@tycho.nsa.gov>; Thu, 15 Dec 2005 11:18:46 -0500
Message-ID: <43A1975B.5080702@us.ibm.com>
Date: Thu, 15 Dec 2005 10:18:35 -0600
From: "Daniel H. Jones" <hotrats@us.ibm.com>
MIME-Version: 1.0
To: selinux@tycho.nsa.gov
Subject: ANN: Virgil 0.1 released
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

ANNOUNCEMENT

Virgil 0.1 has been released and may be downloaded from:
http://sourceforge.net/projects/sepolicy-virgil/

About Virgil
Virgil is a utility for generating SELinux policy for user domains not 
covered by the distributed policy packages. The Virgil GUI allows a 
policy creator to select options and identify file system resources, 
then generate the desired source policy files.

Purpose
The goal is Virgil is to encourage adoption of SELinux by providing a 
relatively simple mechanism for creating policy. In order to achieve 
that goal, Virgil hides much of the complexity, and therefore 
flexibility, of SELinux. This trade-off makes Virgil unsuitable for 
creating "least privilege" policies. Nevertheless, Virgil is capable of 
creating useful SELinux policy that will enhance the security of 
programs for which no policy currently exists.

For feedback please e-mail sepolicy-virgil-list@lists.sourceforge.net

-- 
Thanks,
Dan Jones
IBM Linux Technology Center, Security
hotrats@us.ibm.com


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
