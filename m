Received: from msux-gh1-uea02.nsa.gov (msux-gh1-uea02.nsa.gov [63.239.67.2])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n74BKL0H007255
	for <selinux@tycho.nsa.gov>; Tue, 4 Aug 2009 07:20:21 -0400
Received: from mx2.redhat.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id n74BLJRZ012935
	for <selinux@tycho.nsa.gov>; Tue, 4 Aug 2009 11:21:19 GMT
Received: from int-mx2.corp.redhat.com (int-mx2.corp.redhat.com [172.16.27.26])
	by mx2.redhat.com (8.13.8/8.13.8) with ESMTP id n74BKJGq017409
	for <selinux@tycho.nsa.gov>; Tue, 4 Aug 2009 07:20:19 -0400
Received: from ns3.rdu.redhat.com (ns3.rdu.redhat.com [10.11.255.199])
	by int-mx2.corp.redhat.com (8.13.1/8.13.1) with ESMTP id n74BKI1G015587
	for <selinux@tycho.nsa.gov>; Tue, 4 Aug 2009 07:20:19 -0400
Received: from localhost.localdomain (vpn-12-64.rdu.redhat.com [10.11.12.64])
	by ns3.rdu.redhat.com (8.13.8/8.13.8) with ESMTP id n74BKHK9012017
	for <selinux@tycho.nsa.gov>; Tue, 4 Aug 2009 07:20:18 -0400
Message-ID: <4A781970.7000106@redhat.com>
Date: Tue, 04 Aug 2009 07:20:16 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: SE Linux <selinux@tycho.nsa.gov>
Subject: Just a quick thought. 
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Now that we have labelling equivalence should we just add a 

/lib64 /lib
/usr/lib64 /usr/lib
/usr/local/lib64 /usr/local/lib

Seems we could simplify policy and prevent many mistakes.  Might speed up regex matching a little bit.


grep 64 /etc/selinux/targeted/contexts/files/file_contexts | wc
    259     735   18694


If were were more agressive

/usr/local /usr
/opt /usr




--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
