Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i3FHQYRb009113
	for <selinux@tycho.nsa.gov>; Thu, 15 Apr 2004 13:26:34 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id i3FHQXmw026832
	for <selinux@tycho.nsa.gov>; Thu, 15 Apr 2004 17:26:33 GMT
Received: from smtp-4.llnl.gov (smtp-4.llnl.gov [128.115.41.84])
        by jazzband.ncsc.mil  with ESMTP id i3FHQW4w026829 for <selinux@tycho.nsa.gov>; Thu, 15 Apr 2004 17:26:32 GMT
Mime-Version: 1.0
Message-Id: <p06100505bca4727973a5@[128.115.96.64]>
Date: Thu, 15 Apr 2004 10:26:25 -0700
To: selinux@tycho.nsa.gov
From: Mark Shakespeare <mshakes@llnl.gov>
Subject: Setools 1.2.1 broken after upgrading to NSA release 2.6.5
Cc: kmacmillan@tresys.com
Content-Type: text/plain; charset="us-ascii" ; format="flowed"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I recently upgraded my kernel and packages to 2.6.5 from the NSA 
site. ( Apr 8 )

The package included Setools 1.2.1, and was installed as well.

Now only Sepcut works,  .....Apol,SeuserX,Seinfo and Seaudit complain about
bad policy files and other things.

What exact components/Libraries are needed to have this function again?

Any help would be greatly appreciated.

I currently have...

policy-1.11.2-3
policy-sources-1.11.2-3
setools-1.2-1
kernel-2.6.5-selinux1
libselinux-1.10.1
libselinux-devel-1.10-1

Thanks.


							Mark
-- 
******************************************
* Mark Shakespeare			 *
* Engineering Computer Operations Team   *
* Lawrence Livermore National Laboratory *
* 7000 East Ave		L-130            *
* Livermore,Ca 94550			 *
* 925-423-9922	      mshakes@llnl.gov   *
******************************************

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
