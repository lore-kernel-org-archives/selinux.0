Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k930LsGV028558
	for <selinux@tycho.nsa.gov>; Mon, 2 Oct 2006 20:21:54 -0400
Received: from mx1.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id k930KiiE010680
	for <selinux@tycho.nsa.gov>; Tue, 3 Oct 2006 00:20:44 GMT
Subject: RHEL5 Kernel with labeled networking
From: Eric Paris <eparis@parisplace.org>
To: selinux@tycho.nsa.gov, redhat-lssp@redhat.com
Cc: paul.moore@hp.com, vyekkirala@TrustedCS.com, jmorris@namei.org
Content-Type: text/plain
Date: Mon, 02 Oct 2006 20:23:18 -0400
Message-Id: <1159834998.28144.115.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

DO NOT USE THESE KERNELS ON A PRODUCTION SYSTEM!

If you go to http://people.redhat.com/eparis/RHEL5_labeled_networking/
you should find a set of kernels based off of the Red Hat RHEL5 source
tree.  These should include patches for 

network labeling support from Venkat
netlabel auditing
ipsec/secmark secid reconciliation
netlabel secid reconciliation

I need a very fast response from everyone involved if these kernels

A) boot
B) run without labeled networking (very very important)
C) run with labeled networking

If you run across a problem feel free to let me or the list know.  You
may also feel free to open a bug in bugzilla.redhat.com for the product
choose Red Hat Enterprise Linux Public Beta and RHEL5.  If you open a
bug for this labeled networking you can go ahead and assign it to
eparis@redhat.com so I'm sure to see it and bug the correct people.

At this time there is a known ipsec problem with these kernels.  I
haven't looked at it closely but I believe the problem is that processes
which intend to send over an ipsec tunnels but have certain avc denials
will actually cause traffic to flow unencrypted.  SO PLEASE DO NOT USE
THESE ON ANY PRODUCTION SYSTEM!!  There is work going on upstream (on
linux-netdev not either of these lists) to fix this issue in the 2.6-net
tree and when it is finished it will get brought back into RHEL5.  (I
don't think you will hit this bug with relatively modern policy but it
is there and can be a serious security flaw)

Before network labeling is completed we still need some work
implementing how we plan to audit configuration changes in ipsec
labeling decisions.  I believe we agreed today that this auditing must
be done in kernelspace since we do not have fine grained enough controls
on netlink messages to allow for all of the auditing in userspace.

DO NOT USE THESE KERNELS ON A PRODUCTION SYSTEM

-Eric


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
