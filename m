Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id k0PF5PXf010093
	for <selinux@tycho.nsa.gov>; Wed, 25 Jan 2006 10:05:25 -0500 (EST)
Received: from e3.ny.us.ibm.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id k0PF5Ovt001734
	for <selinux@tycho.nsa.gov>; Wed, 25 Jan 2006 15:05:24 GMT
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e3.ny.us.ibm.com (8.12.11/8.12.11) with ESMTP id k0PF5OAO027162
	for <selinux@tycho.nsa.gov>; Wed, 25 Jan 2006 10:05:24 -0500
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
	by d01relay02.pok.ibm.com (8.12.10/NCO/VERS6.8) with ESMTP id k0PF5OvN153086
	for <selinux@tycho.nsa.gov>; Wed, 25 Jan 2006 10:05:24 -0500
Received: from d01av01.pok.ibm.com (loopback [127.0.0.1])
	by d01av01.pok.ibm.com (8.12.11/8.13.3) with ESMTP id k0PF5OoK008190
	for <selinux@tycho.nsa.gov>; Wed, 25 Jan 2006 10:05:24 -0500
Received: from [9.65.207.109] (sig-9-65-207-109.mts.ibm.com [9.65.207.109])
	by d01av01.pok.ibm.com (8.12.11/8.12.11) with ESMTP id k0PF5No7008115
	for <selinux@tycho.nsa.gov>; Wed, 25 Jan 2006 10:05:24 -0500
Message-ID: <43D7939B.3010701@us.ibm.com>
Date: Wed, 25 Jan 2006 10:04:59 -0500
From: JANAK DESAI <janak@us.ibm.com>
MIME-Version: 1.0
To: selinux@tycho.nsa.gov
Subject: password policy question
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


Hello,

I am looking at the serefpolicy-2.2.2 (downloaded this morning from 
fedora core
development SRPMS) and am trying to figure out how, in an mls 
environment, a
user logged in at anything other s0 would be able to change his/her 
password. I
expected to see a "typeattribute passwd_t mlsfilewrite" in the 
monolithic policy.conf
file that I generated. What am I missing?

I haven't installed this policy on my test machine. I just created the 
policy file for
a training class.

Thanks.

-Janak

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
