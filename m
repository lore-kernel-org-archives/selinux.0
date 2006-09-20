Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k8KFRWFv017077
	for <selinux@tycho.nsa.gov>; Wed, 20 Sep 2006 11:27:32 -0400
Received: from mx1.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id k8KFQXNK019267
	for <selinux@tycho.nsa.gov>; Wed, 20 Sep 2006 15:26:34 GMT
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.12.11.20060308/8.12.11) with ESMTP id k8KFRSdI007417
	for <selinux@tycho.nsa.gov>; Wed, 20 Sep 2006 11:27:28 -0400
Received: from mail.boston.redhat.com (mail.boston.redhat.com [172.16.76.12])
	by int-mx1.corp.redhat.com (8.12.11.20060308/8.12.11) with ESMTP id k8KFRNNS029401
	for <selinux@tycho.nsa.gov>; Wed, 20 Sep 2006 11:27:23 -0400
Received: from [10.11.14.147] (vpn-14-147.rdu.redhat.com [10.11.14.147])
	by mail.boston.redhat.com (8.12.8/8.12.8) with ESMTP id k8KFRMhR029362
	for <selinux@tycho.nsa.gov>; Wed, 20 Sep 2006 11:27:22 -0400
Message-ID: <45115DD9.2020603@redhat.com>
Date: Wed, 20 Sep 2006 11:27:21 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: selinux@tycho.nsa.gov
Subject: Why does SELinux treat access(file, W_OK) the same way as write(fd,
 "XYZ")?
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Shouldn't the access(file, W_OK) be treated as a getattr rather then a 
write access?

Several apps including the kernel do access checks on open file 
descriptors and we end up having to write dontaudit rules on {read write 
append} when what we really only want to allow the getattr.

Dan

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
