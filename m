Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j13M8S53003738
	for <selinux@tycho.nsa.gov>; Thu, 3 Feb 2005 17:08:28 -0500 (EST)
Received: from orsfmr004.jf.intel.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j13M8Tf1021055
	for <selinux@tycho.nsa.gov>; Thu, 3 Feb 2005 22:08:30 GMT
Received: from orsfmr101.jf.intel.com (orsfmr101.jf.intel.com [10.7.209.17])
	by orsfmr004.jf.intel.com (8.12.10/8.12.10/d: major-outer.mc,v 1.1 2004/09/17 17:50:56 root Exp $) with ESMTP id j13M8U8o011845
	for <selinux@tycho.nsa.gov>; Thu, 3 Feb 2005 22:08:30 GMT
Received: from orsmsxvs041.jf.intel.com (orsmsxvs041.jf.intel.com [192.168.65.54])
	by orsfmr101.jf.intel.com (8.12.10/8.12.10/d: major-inner.mc,v 1.2 2004/09/17 18:05:01 root Exp $) with SMTP id j13M8Ec9018373
	for <selinux@tycho.nsa.gov>; Thu, 3 Feb 2005 22:08:30 GMT
Received: from orsmsx331.amr.corp.intel.com ([192.168.65.56])
 by orsmsxvs041.jf.intel.com (SAVSMTP 3.1.2.35) with SMTP id M2005020314083011947
 for <selinux@tycho.nsa.gov>; Thu, 03 Feb 2005 14:08:30 -0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: Best way to label a filesystem for another system
Date: Thu, 3 Feb 2005 14:08:28 -0800
Message-ID: <60C14C611F1DDD4198D53F2F43D8CA3B03625283@orsmsx410>
From: "Villalovos, John L" <john.l.villalovos@intel.com>
To: "SE-Linux" <selinux@tycho.nsa.gov>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I'm trying to figure out what is the best way for me to label (set file
contexts) on a file system which will be used for an embedded system.

At the moment it is an EXT2 file system created by genext2fs.  I can
mount the file system using the loop back device.

So I was hoping that the current utilities supported a --root option or
something but they don't seem too.

Any good ideas on the best way to do this.

Also is there an easy way to parse the list of file contexts from the
policy?  Could I write a script to parse the file and then do a chcon on
each file/directory in my filesystem.

Thanks,
John


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
