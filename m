Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i8AJNurT021000
	for <selinux@tycho.nsa.gov>; Fri, 10 Sep 2004 15:23:57 -0400 (EDT)
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i8AJN3vo029795
	for <selinux@tycho.nsa.gov>; Fri, 10 Sep 2004 19:23:03 GMT
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.12.11/8.12.10) with ESMTP id i8AJNuUI030314
	for <selinux@tycho.nsa.gov>; Fri, 10 Sep 2004 15:23:56 -0400
Received: from mail.boston.redhat.com (mail.boston.redhat.com [172.16.76.12])
	by int-mx1.corp.redhat.com (8.11.6/8.11.6) with ESMTP id i8AJNu303549
	for <selinux@tycho.nsa.gov>; Fri, 10 Sep 2004 15:23:56 -0400
Received: from [172.16.80.115] (celtics.boston.redhat.com [172.16.80.115])
	by mail.boston.redhat.com (8.12.8/8.12.8) with ESMTP id i8AJNuiR021147
	for <selinux@tycho.nsa.gov>; Fri, 10 Sep 2004 15:23:56 -0400
Message-ID: <4141FF4C.2030602@redhat.com>
Date: Fri, 10 Sep 2004 15:23:56 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: SE Linux <selinux@tycho.nsa.gov>
Subject: Unexpected behaviour with SELinux.
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On both strict and targetd policy.

ldd /usr/sbin/named gives no output.

ldd must be starting up the daemon and transitioning to it and can not 
write output to the terminal.

Dan

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
