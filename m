Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i82Fq9rT000346
	for <selinux@tycho.nsa.gov>; Thu, 2 Sep 2004 11:52:09 -0400 (EDT)
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i82FpJ3w012305
	for <selinux@tycho.nsa.gov>; Thu, 2 Sep 2004 15:51:19 GMT
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.12.10/8.12.10) with ESMTP id i82Fq8S0020070
	for <selinux@tycho.nsa.gov>; Thu, 2 Sep 2004 11:52:08 -0400
Received: from mail.boston.redhat.com (mail.boston.redhat.com [172.16.76.12])
	by int-mx1.corp.redhat.com (8.11.6/8.11.6) with ESMTP id i82Fq3328166
	for <selinux@tycho.nsa.gov>; Thu, 2 Sep 2004 11:52:03 -0400
Received: from [172.16.80.115] (celtics.boston.redhat.com [172.16.80.115])
	by mail.boston.redhat.com (8.12.8/8.12.8) with ESMTP id i82Fq3xQ032523
	for <selinux@tycho.nsa.gov>; Thu, 2 Sep 2004 11:52:03 -0400
Message-ID: <413741A3.3070305@redhat.com>
Date: Thu, 02 Sep 2004 11:52:03 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
CC: SELinux <selinux@tycho.nsa.gov>
Subject: Proposed Hardware File Context file.
References: <200408241818.40064.russell@coker.com.au>	 <41371628.2020408@redhat.com>	 <1094130607.17265.47.camel@moss-spartans.epoch.ncsc.mil>	 <200409022338.20644.russell@coker.com.au> <1094136369.17265.128.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1094136369.17265.128.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Collin and I were discussing a way to label hardware devices correctly.

One proposal would be to come up with a new file_contexts file based off 
of path and hardware type.

So we could have a file with

/dev/h

/u?dev/[shmx]d[^/]*    -b    system_u:object_r:fixed_disk_device_t
/u?dev/[shmx]d[^/]*    -b    system_u:object_r:removable_disk_device_t cdrom

Then either add a param to matchpathcon or a new function that would 
pass in the hardware type
and get the correct context.

Then tools like udev could use this to create the device with the 
correct context.

ideas??



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
