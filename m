Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id jBHDqhXf010293
	for <selinux@tycho.nsa.gov>; Sat, 17 Dec 2005 08:52:43 -0500 (EST)
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id jBHDpo0i007762
	for <selinux@tycho.nsa.gov>; Sat, 17 Dec 2005 13:51:50 GMT
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.12.11/8.12.11) with ESMTP id jBHDqgHR008695
	for <selinux@tycho.nsa.gov>; Sat, 17 Dec 2005 08:52:42 -0500
Received: from mail.boston.redhat.com (mail.boston.redhat.com [172.16.76.12])
	by int-mx1.corp.redhat.com (8.11.6/8.11.6) with ESMTP id jBHDqf114615
	for <selinux@tycho.nsa.gov>; Sat, 17 Dec 2005 08:52:41 -0500
Received: from [172.16.50.33] (vpn50-33.rdu.redhat.com [172.16.50.33])
	by mail.boston.redhat.com (8.12.8/8.12.8) with ESMTP id jBHDqfa3027554
	for <selinux@tycho.nsa.gov>; Sat, 17 Dec 2005 08:52:41 -0500
Message-ID: <43A4182B.9000402@redhat.com>
Date: Sat, 17 Dec 2005 08:52:43 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: SE Linux <selinux@tycho.nsa.gov>
Subject: New strategy for enableaudit.
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I have added enableaudit to Rules.modular to create a base.conf without 
audit rules.

Then in the Fedora spec file I create a regulare base.pp and a 
enableaudit.pp. 

I ship both in the RPM.

Now the user can execute

semodule -b /usr/share/selinux/targeted/enableaudit.pp

To turn off the dontaudit rules.

Dan

-- 



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
