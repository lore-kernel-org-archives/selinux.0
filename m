Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l87HJO4S003054
	for <selinux@tycho.nsa.gov>; Fri, 7 Sep 2007 13:19:24 -0400
Received: from fw5540.nrl.navy.mil (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id l87HJOhF001319
	for <selinux@tycho.nsa.gov>; Fri, 7 Sep 2007 17:19:24 GMT
Received: from chacs.nrl.navy.mil (sun1.fw5540.net [10.0.0.11])
	by fw5540.nrl.navy.mil (8.13.6/8.13.6) with ESMTP id l87HJOG4003322
	for <selinux@tycho.nsa.gov>; Fri, 7 Sep 2007 13:19:24 -0400 (EDT)
Received: from chacs.nrl.navy.mil (sun1 [10.0.0.11])
	by chacs.nrl.navy.mil (8.13.6/8.13.6) with SMTP id l87HJOuf002620
	for <selinux@tycho.nsa.gov>; Fri, 7 Sep 2007 13:19:24 -0400 (EDT)
Received: (from PC05 [10.0.1.195])
 by chacs.nrl.navy.mil (SMSSMTP 4.1.16.48) with SMTP id M2007090713192316350
 for <selinux@tycho.nsa.gov>; Fri, 07 Sep 2007 13:19:23 -0400
From: "Kim Lawson-Jenkins" <lawson@itd.nrl.navy.mil>
To: <selinux@tycho.nsa.gov>
References: 
Subject: Kernel panic when using refpolicy
Date: Fri, 7 Sep 2007 13:14:34 -0500
Message-ID: <000c01c7f17a$f2047130$c301000a@PC05>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
In-Reply-To: 
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


Hi,

I'm running RHEL5.  I downloaded refpolicy-20070629.tar.bz2 and
selinux-refpolicy-sources-20070629-1.noarch.rpm and installed the files for
the reference policy.  When rebooting the system there was a fatal error -
Kernel panic - not syncing: Fatal exception.

There were many unknown Boolean errors for libsepol.load.booleans and there
was the following error - 
libsepol.sepol_genbools: error while reading /etc/selinux/refpolicy/Booleans

It looks like ifconfig was running when the kernel panic occurred.  To
recover booted into single-user mode and changed the SELINUXTYPE in the file
/etc/selinux/config from refpolicy to targeted.  I can easily repeat the
problem by using the SELinux Management Tool to change the System Default
Policy Type from targeted to refpolicy and rebooting.  I've looked at all of
the documentation to see if I missed a step or downloaded an incorrect file
but I can't find anything.  Can anyone give me some insight into what the
problem may be?  Thanks in advance for a response.

Kim


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
