Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k3DMLBVC014916
	for <selinux@tycho.nsa.gov>; Thu, 13 Apr 2006 18:21:11 -0400
Received: from e3.ny.us.ibm.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id k3DML9Tk013002
	for <selinux@tycho.nsa.gov>; Thu, 13 Apr 2006 22:21:09 GMT
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e3.ny.us.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id k3DMKxOo008683
	for <selinux@tycho.nsa.gov>; Thu, 13 Apr 2006 18:20:59 -0400
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
	by d01relay04.pok.ibm.com (8.12.10/NCO/VER6.8) with ESMTP id k3DMKcWw148778
	for <selinux@tycho.nsa.gov>; Thu, 13 Apr 2006 18:20:38 -0400
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
	by d01av04.pok.ibm.com (8.12.11/8.13.3) with ESMTP id k3DMKclj000356
	for <selinux@tycho.nsa.gov>; Thu, 13 Apr 2006 18:20:38 -0400
Received: from austin.ibm.com (netmail1.austin.ibm.com [9.41.248.175])
	by d01av04.pok.ibm.com (8.12.11/8.12.11) with ESMTP id k3DMKcvA000341
	for <selinux@tycho.nsa.gov>; Thu, 13 Apr 2006 18:20:38 -0400
Received: from faith.austin.ibm.com (faith.austin.ibm.com [9.53.40.35])
	by austin.ibm.com (8.12.10/8.12.10) with ESMTP id k3DMKb1n008382
	for <selinux@tycho.nsa.gov>; Thu, 13 Apr 2006 17:20:37 -0500
Received: from faith.austin.ibm.com (localhost.localdomain [127.0.0.1])
	by faith.austin.ibm.com (8.13.4/8.12.8) with ESMTP id k3DMDPw7016895
	for <selinux@tycho.nsa.gov>; Thu, 13 Apr 2006 17:13:25 -0500
Received: (from jml@localhost)
	by faith.austin.ibm.com (8.13.4/8.13.4/Submit) id k3DMDPOs016894
	for selinux@tycho.nsa.gov; Thu, 13 Apr 2006 17:13:25 -0500
Subject: Selinux testsuite updated in latest LTP release
From: Joy Latten <latten@austin.ibm.com>
To: selinux@tycho.nsa.gov
Content-Type: text/plain
Date: Thu, 13 Apr 2006 17:13:25 -0500
Message-Id: <1144966405.2462.41.camel@faith.austin.ibm.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

LTP has released ltp-20060411, their April release which contains
the selinux testsuite with refpolicy!

Is there an selinux command/flag in which I can determine whether
system is running refpolicy or old monolithic policy? 
If so, I can modify testsuite such that it can run either policy. I am
unable to determine this piece of info, so currently by default, the
refpolicy gets used when running the testsuite.

Regards,
Joy 

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
