Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k93In853021728
	for <selinux@tycho.nsa.gov>; Tue, 3 Oct 2006 14:49:09 -0400
Received: from e34.co.us.ibm.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id k93Iluqf023384
	for <selinux@tycho.nsa.gov>; Tue, 3 Oct 2006 18:47:57 GMT
Received: from westrelay02.boulder.ibm.com (westrelay02.boulder.ibm.com [9.17.195.11])
	by e34.co.us.ibm.com (8.13.8/8.12.11) with ESMTP id k93In7ax017351
	for <selinux@tycho.nsa.gov>; Tue, 3 Oct 2006 14:49:07 -0400
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by westrelay02.boulder.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with ESMTP id k93In6EN503346
	for <selinux@tycho.nsa.gov>; Tue, 3 Oct 2006 12:49:06 -0600
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id k93In58h019480
	for <selinux@tycho.nsa.gov>; Tue, 3 Oct 2006 12:49:06 -0600
Date: Tue, 3 Oct 2006 13:37:07 -0500
From: Joy Latten <latten@austin.ibm.com>
Message-Id: <200610031837.k93Ib7cQ003247@faith.austin.ibm.com>
To: eparis@parisplace.org, redhat-lssp@redhat.com, selinux@tycho.nsa.gov
Subject: Re: RHEL5 Kernel with labeled networking
Cc: jmorris@namei.org, paul.moore@hp.com, vyekkirala@TrustedCS.com
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

>Before network labeling is completed we still need some work
>implementing how we plan to audit configuration changes in ipsec
>labeling decisions.  I believe we agreed today that this auditing must
>be done in kernelspace since we do not have fine grained enough controls
>on netlink messages to allow for all of the auditing in userspace.
>

I've talked to Klaus about what needs to be audited for ipsec and
lspp compliance. I will begin work on a patch and get this out
to the list as soon as I can. We will audit everytime a policy is 
added/removed to/from the ipsec policy database.

Regards,
Joy 

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
