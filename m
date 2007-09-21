Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l8LFfQUq003402
	for <selinux@tycho.nsa.gov>; Fri, 21 Sep 2007 11:41:26 -0400
Received: from alnrmhc15.comcast.net (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l8LFfNL2021962
	for <selinux@tycho.nsa.gov>; Fri, 21 Sep 2007 15:41:23 GMT
From: msmatsko@comcast.net (msm@gwu.edu)
To: selinux@tycho.nsa.gov
Subject: Memory and temporary file wiping
Date: Fri, 21 Sep 2007 15:41:22 +0000
Message-Id: <092120071541.15588.46F3E622000C82BA00003CE4221557511401059C9B0E039C03@comcast.net>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Dear selinux,

  I'm trying to configure a RedHat Enterprise Linux box for PL2.  Part of that requirement is that memory gets zeroed before reuse and that temporary files be wiped (bcwipe can handle this).  Perusing web resources, one gets the impression that Linux and/or SELinux do the appropriate memory wiping.  However, I cannot find any specifics.  I have tried looking at kernel memory and security documentation to no avail.  Is there a specific SELinux policy for this, or is this just a standard Linux feature?  Thank you for any assistance.

Sincerely,
Michael Matsko
Northrop Grumman/XTI

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
