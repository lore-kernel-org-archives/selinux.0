Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k88JKu3C031003
	for <selinux@tycho.nsa.gov>; Fri, 8 Sep 2006 15:20:56 -0400
Received: from e2.ny.us.ibm.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id k88JKAeD009571
	for <selinux@tycho.nsa.gov>; Fri, 8 Sep 2006 19:20:10 GMT
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e2.ny.us.ibm.com (8.13.8/8.12.11) with ESMTP id k88JKuCj020497
	for <selinux@tycho.nsa.gov>; Fri, 8 Sep 2006 15:20:56 -0400
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay02.pok.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with ESMTP id k88JKu9s280962
	for <selinux@tycho.nsa.gov>; Fri, 8 Sep 2006 15:20:56 -0400
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id k88JKtQK028316
	for <selinux@tycho.nsa.gov>; Fri, 8 Sep 2006 15:20:55 -0400
Date: Fri, 8 Sep 2006 14:09:38 -0500
From: Joy Latten <latten@austin.ibm.com>
Message-Id: <200609081909.k88J9cG4013361@faith.austin.ibm.com>
To: redhat-lspp@redhat.com, selinux@tycho.nsa.gov
Subject: Which role to configure IPSec?
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I am running rawhide which I installed on Sept 5,
and it has selinux-policy-mls-2.3.11-1. I logged in 
and did a newrole -r sysadm_r, so my context is 
root:sysadm_r:sysadm_t:SystemLow-SystemHigh. I wasn't
able to configure nor run IPSec in enforcing.

I am wondering is sysadm_r the correct role to configure
IPSec? I also am just trying to run plain IPSec, with no
labels, thus it is taking the default of unlabeled_t.

So far, audit.log says I need the following rules to configure
IPSec with the setkey command and then do a ping to test the connection.

allow unlabeled_t self:association { polmatch sendto recvfrom };
allow ping_t unlabeled_t:association polmatch;
allow sysadm_t self:key_socket { create read setopt write };

The first 2 rules appear to be generally applicable.
The first one I added to kernel.te because I didn't know where else
to place it. For the second rule, I added "polmatch" to 
kernel_sendrecv_unlabeled_association interface so that other
networking utilities would also acquire the permission. Again,
I don't really know if this is the best place to put it.
But the last one is particular to sysadm_t or whoever runs
the setkey command which is used to configure IPSec. I also
tried secadm_r and got similar complaints.

I guess what I would like to know is whether sysadm_r the correct role
to configure ipsec? 

Regards,
Joy

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
