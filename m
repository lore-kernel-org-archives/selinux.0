Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k8TLCP3c003965
	for <selinux@tycho.nsa.gov>; Fri, 29 Sep 2006 17:12:25 -0400
Received: from e2.ny.us.ibm.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id k8TLBI7b025256
	for <selinux@tycho.nsa.gov>; Fri, 29 Sep 2006 21:11:18 GMT
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e2.ny.us.ibm.com (8.13.8/8.12.11) with ESMTP id k8TLCP0Z001895
	for <selinux@tycho.nsa.gov>; Fri, 29 Sep 2006 17:12:25 -0400
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
	by d01relay02.pok.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with ESMTP id k8TLCPdc254426
	for <selinux@tycho.nsa.gov>; Fri, 29 Sep 2006 17:12:25 -0400
Received: from d01av01.pok.ibm.com (loopback [127.0.0.1])
	by d01av01.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id k8TLCO5R006844
	for <selinux@tycho.nsa.gov>; Fri, 29 Sep 2006 17:12:24 -0400
Received: from [127.0.0.1] (pendarric.austin.ibm.com [9.41.46.108])
	by d01av01.pok.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id k8TLCOZk006805
	for <selinux@tycho.nsa.gov>; Fri, 29 Sep 2006 17:12:24 -0400
Message-ID: <451D8C2F.9040901@us.ibm.com>
Date: Fri, 29 Sep 2006 16:12:15 -0500
From: Michael C Thompson <thompsmc@us.ibm.com>
MIME-Version: 1.0
To: SE Linux <selinux@tycho.nsa.gov>
Subject: Default Mikefile in /usr/share/selinux/devel not nice
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I just discovered a nasty surprise waiting for me in the default 
Makefile provided by selinux-policy-devel.

Basically, the Makefile produces, on an MLS system, a TYPE value of 
mls-msc (this is due to the SELINUXTYPE=mls line in 
/etc/selinux/config). This will not 'enable_mls' for the M4FLAGS, 
because the Makefile in /usr/share/selinux/devel/include/ does a 
findstring for '-mls'.

Dan Walsh has suggested a fix for the default Makefile, but I'm 
wondering why we can't just change 
/usr/share/selinux/devel/include/Makefile to do a $(findstring 
mls,$TYPE)) instead, since its not unreasonable to think that TYPE=mls 
makes sense.

Thanks,
Mike


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
