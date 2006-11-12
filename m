Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id kACLQkIH029184
	for <selinux@tycho.nsa.gov>; Sun, 12 Nov 2006 16:26:46 -0500
Received: from e6.ny.us.ibm.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id kACLP8LY022572
	for <selinux@tycho.nsa.gov>; Sun, 12 Nov 2006 21:25:08 GMT
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e6.ny.us.ibm.com (8.13.8/8.12.11) with ESMTP id kACLRIxO013165
	for <selinux@tycho.nsa.gov>; Sun, 12 Nov 2006 16:27:18 -0500
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay02.pok.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with ESMTP id kACLQm2E306172
	for <selinux@tycho.nsa.gov>; Sun, 12 Nov 2006 16:26:59 -0500
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id kACLQlTd031349
	for <selinux@tycho.nsa.gov>; Sun, 12 Nov 2006 16:26:47 -0500
Received: from [127.0.0.1] (wecm-9-67-59-252.wecm.ibm.com [9.67.59.252])
	by d01av02.pok.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id kACLQkOD031323
	for <selinux@tycho.nsa.gov>; Sun, 12 Nov 2006 16:26:47 -0500
Message-ID: <4557918B.20909@us.ibm.com>
Date: Sun, 12 Nov 2006 15:26:35 -0600
From: Michael C Thompson <thompsmc@us.ibm.com>
MIME-Version: 1.0
To: SE Linux <selinux@tycho.nsa.gov>
Subject: genhomedircon bug
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I found a bug in genhomedircon:

policycoreutils.x86_64 1.32-3

# genhomedircon
libsemanage.semanage_direct_connect: could not establish direct connection
libsemanage.assert_init: A direct or server connection is needed to use 
this function - please call the corresponding connect() method
libsemanage.enter_ro: could not enter read-only section
Traceback (most recent call last):
   File "/usr/sbin/genhomedircon", line 379, in ?
     selconf = selinuxConfig(directory, type, usepwd)
   File "/usr/sbin/genhomedircon", line 140, in __init__
     (status, self.ulist) = semanage_user_list(self.semanageHandle)
TypeError: unpack non-sequence


# id
uid=0(root) gid=0(root) 
groups=0(root),1(bin),2(daemon),3(sys),4(adm),6(disk),10(wheel) 
context=staff_u:secadm_r:secadm_t:SystemLow-SystemHigh


Thanks,
Mike


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
