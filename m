Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k94JE24P028628
	for <selinux@tycho.nsa.gov>; Wed, 4 Oct 2006 15:14:02 -0400
Received: from e5.ny.us.ibm.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k94JDQUx021122
	for <selinux@tycho.nsa.gov>; Wed, 4 Oct 2006 19:13:26 GMT
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e5.ny.us.ibm.com (8.13.8/8.12.11) with ESMTP id k94JE0lq002144
	for <selinux@tycho.nsa.gov>; Wed, 4 Oct 2006 15:14:00 -0400
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
	by d01relay02.pok.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with ESMTP id k94JDtwD282822
	for <selinux@tycho.nsa.gov>; Wed, 4 Oct 2006 15:14:00 -0400
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
	by d01av04.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id k94JDt6J001058
	for <selinux@tycho.nsa.gov>; Wed, 4 Oct 2006 15:13:55 -0400
Date: Wed, 4 Oct 2006 14:01:51 -0500
From: Joy Latten <latten@austin.ibm.com>
Message-Id: <200610041901.k94J1px0009061@faith.austin.ibm.com>
To: eparis@parisplace.org, redhat-lssp@redhat.com, selinux@tycho.nsa.gov
Subject: Re: RHEL5 Kernel with labeled networking
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

>DO NOT USE THESE KERNELS ON A PRODUCTION SYSTEM!
>
>If you go to http://people.redhat.com/eparis/RHEL5_labeled_networking/
>you should find a set of kernels based off of the Red Hat RHEL5 source
>tree.  These should include patches for 
>
>network labeling support from Venkat
>netlabel auditing
>ipsec/secmark secid reconciliation
>netlabel secid reconciliation
>
>I need a very fast response from everyone involved if these kernels
>
>A) boot
>B) run without labeled networking (very very important)
>C) run with labeled networking
>
>If you run across a problem feel free to let me or the list know.  You
>may also feel free to open a bug in bugzilla.redhat.com for the product
>choose Red Hat Enterprise Linux Public Beta and RHEL5.  If you open a
>bug for this labeled networking you can go ahead and assign it to
>eparis@redhat.com so I'm sure to see it and bug the correct people.
>
>At this time there is a known ipsec problem with these kernels.  I
>haven't looked at it closely but I believe the problem is that processes
>which intend to send over an ipsec tunnels but have certain avc denials
>will actually cause traffic to flow unencrypted.  SO PLEASE DO NOT USE
>THESE ON ANY PRODUCTION SYSTEM!!  There is work going on upstream (on
>linux-netdev not either of these lists) to fix this issue in the 2.6-net
>tree and when it is finished it will get brought back into RHEL5.  (I
>don't think you will hit this bug with relatively modern policy but it
>is there and can be a serious security flaw)
>
>Before network labeling is completed we still need some work
>implementing how we plan to audit configuration changes in ipsec
>labeling decisions.  I believe we agreed today that this auditing must
>be done in kernelspace since we do not have fine grained enough controls
>on netlink messages to allow for all of the auditing in userspace.

A stress test sending streams of tcp and udp packets completed
a 15 hour run successfully. Purpose was to regression test.

Configuration:
non-labeled ipsec, encryption and authentication, 
transport mode using racoon
selinux-policy-mls-2.3.16-2 in permissive
hardware: 2 pseries lpars

I plan to run a stress test using labels with ipsec tonight.

Regards,
Joy

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
