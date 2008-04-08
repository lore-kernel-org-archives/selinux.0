Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m38Dl5D8028553
	for <selinux@tycho.nsa.gov>; Tue, 8 Apr 2008 09:47:05 -0400
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id m38Dl5ff007430
	for <selinux@tycho.nsa.gov>; Tue, 8 Apr 2008 13:47:05 GMT
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.13.8/8.13.8) with ESMTP id m38Dk5mC029889
	for <selinux@tycho.nsa.gov>; Tue, 8 Apr 2008 09:46:05 -0400
Received: from pobox.stuttgart.redhat.com (pobox.stuttgart.redhat.com [172.16.2.10])
	by int-mx1.corp.redhat.com (8.13.1/8.13.1) with ESMTP id m38Dk4hK006898
	for <selinux@tycho.nsa.gov>; Tue, 8 Apr 2008 09:46:05 -0400
Received: from caladan.englab.brq.redhat.com (caladan.englab.brq.redhat.com [10.34.32.66])
	by pobox.stuttgart.redhat.com (8.13.1/8.13.1) with ESMTP id m38Dk4tn026647
	for <selinux@tycho.nsa.gov>; Tue, 8 Apr 2008 09:46:04 -0400
Message-ID: <47FB771A.50305@redhat.com>
Date: Tue, 08 Apr 2008 15:46:02 +0200
From: Marcela Maslanova <mmaslano@redhat.com>
MIME-Version: 1.0
To: selinux@tycho.nsa.gov
Subject: selinux support in cron withou system_u
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

There was a proposal to get rid off system_u from selinux support in cron.
https://bugzilla.redhat.com/show_bug.cgi?id=426704#c19

Do you have any ideas how it should be done?

-- 
Marcela Maπl·Úov·
BaseOS team Brno


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
