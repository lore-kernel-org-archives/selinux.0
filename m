Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j11IpO53017490
	for <selinux@tycho.nsa.gov>; Tue, 1 Feb 2005 13:51:24 -0500 (EST)
Received: from orsfmr003.jf.intel.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j11IpPYB026090
	for <selinux@tycho.nsa.gov>; Tue, 1 Feb 2005 18:51:26 GMT
Received: from orsfmr101.jf.intel.com (orsfmr101.jf.intel.com [10.7.209.17])
	by orsfmr003.jf.intel.com (8.12.10/8.12.10/d: major-outer.mc,v 1.1 2004/09/17 17:50:56 root Exp $) with ESMTP id j11IpQGL010825
	for <selinux@tycho.nsa.gov>; Tue, 1 Feb 2005 18:51:26 GMT
Received: from orsmsxvs041.jf.intel.com (orsmsxvs041.jf.intel.com [192.168.65.54])
	by orsfmr101.jf.intel.com (8.12.10/8.12.10/d: major-inner.mc,v 1.2 2004/09/17 18:05:01 root Exp $) with SMTP id j11IoIEE004424
	for <selinux@tycho.nsa.gov>; Tue, 1 Feb 2005 18:51:26 GMT
Received: from orsmsx332.amr.corp.intel.com ([192.168.65.60])
 by orsmsxvs041.jf.intel.com (SAVSMTP 3.1.2.35) with SMTP id M2005020110512629499
 for <selinux@tycho.nsa.gov>; Tue, 01 Feb 2005 10:51:26 -0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: Advice on bringing up SE Linux
Date: Tue, 1 Feb 2005 10:51:24 -0800
Message-ID: <60C14C611F1DDD4198D53F2F43D8CA3B035B5359@orsmsx410>
From: "Villalovos, John L" <john.l.villalovos@intel.com>
To: <selinux@tycho.nsa.gov>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I am trying to bring up SE Linux on an Intel Xscale processor.  An
IQ80310 to be specific.

We are using a 2.6.5 kernel, since it is the last one to support the
IQ80310 :(

We have compiled up a kernel with SE Linux.  Mounted the selinuxfs on
/selinux.

Now I am trying to figure out how to enable SE Linux.  All the utilities
say the SE Linux is disabled.

When I do:

[iq80310]# cat /proc/self/attr/current
Kernel

And I think I should get something like:
[fc3]# cat /proc/self/attr/current
root:system_r:unconfined_t

I have tried compiling up a policy.15 file and then just cat >
/selinux/load

But that doesn't seem to change anything.

Any help would be greatly appreciated :)

Thanks,
John


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
