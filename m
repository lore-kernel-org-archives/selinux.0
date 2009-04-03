Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n33I5jxU019231
	for <selinux@tycho.nsa.gov>; Fri, 3 Apr 2009 14:05:45 -0400
Received: from manicmethod.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id n33I5ifC002455
	for <selinux@tycho.nsa.gov>; Fri, 3 Apr 2009 18:05:45 GMT
Received: from [10.1.13.45] (unknown [96.244.142.3])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by manicmethod.com (Postfix) with ESMTPSA id 0F5525C00F1
	for <selinux@tycho.nsa.gov>; Fri,  3 Apr 2009 13:05:23 -0500 (CDT)
Message-ID: <49D64FEC.3030909@manicmethod.com>
Date: Fri, 03 Apr 2009 14:05:32 -0400
From: Joshua Brindle <method@manicmethod.com>
MIME-Version: 1.0
To: SE Linux <selinux@tycho.nsa.gov>
Subject: [ANN] SELinux userspace release
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

The SELinux userspace project has updated a release. As usual you can find it at 
http://userspace.selinuxproject.org/trac/wiki/Releases.

This is primarily a bug fix release. The added features are policy module module 
compression support and AVC caching for compute_create results.

This release does not include an updated release of the stable_1_0 branch, which 
has not been updated since the last release.

For git users this release has been tagged 20090403 in the repository on 
userspace.selinuxproject.org.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
