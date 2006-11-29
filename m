Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id kATKbjpU032206
	for <selinux@tycho.nsa.gov>; Wed, 29 Nov 2006 15:37:45 -0500
Received: from mx1.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id kATKa246002342
	for <selinux@tycho.nsa.gov>; Wed, 29 Nov 2006 20:36:02 GMT
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.12.11.20060308/8.12.11) with ESMTP id kATKc8eG004024
	for <selinux@tycho.nsa.gov>; Wed, 29 Nov 2006 15:38:08 -0500
Received: from pobox-2.corp.redhat.com (pobox-2.corp.redhat.com [10.11.255.15])
	by int-mx1.corp.redhat.com (8.13.1/8.13.1) with ESMTP id kATKc8YX004029
	for <selinux@tycho.nsa.gov>; Wed, 29 Nov 2006 15:38:08 -0500
Received: from [10.11.14.98] (vpn-14-98.rdu.redhat.com [10.11.14.98])
	by pobox-2.corp.redhat.com (8.13.1/8.13.1) with ESMTP id kATKc7Ld028928
	for <selinux@tycho.nsa.gov>; Wed, 29 Nov 2006 15:38:08 -0500
Message-ID: <456DEFAD.6040706@mentalrootkit.com>
Date: Wed, 29 Nov 2006 15:38:05 -0500
From: Karl MacMillan <kmacmillan@mentalrootkit.com>
MIME-Version: 1.0
To: SELinux Mail List <selinux@tycho.nsa.gov>
Subject: Recovering .te and .fc files from modules
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

We've been getting requests for a tool to extract the .te and .fc files 
from modules. Red Hat bugzilla for this at 
https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=217761.

I think this is a good idea and the dismod tool (located in 
checkpolicy/test in the sources) is a good start at this. I'm mentioning 
it here in case anyone has time or interest in creating this tool.

Thanks,

Karl

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
