Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i0SJKWRb007152
	for <selinux@tycho.nsa.gov>; Wed, 28 Jan 2004 14:20:34 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id i0SJJFVK011029
	for <selinux@tycho.nsa.gov>; Wed, 28 Jan 2004 19:19:15 GMT
Received: from smtp-4.llnl.gov (smtp-4.llnl.gov [128.115.41.84])
	by jazzswing.ncsc.mil  with ESMTP id i0SJJElx011023
	for <selinux@tycho.nsa.gov>; Wed, 28 Jan 2004 19:19:14 GMT
Received: from popcorn.llnl.gov (localhost [127.0.0.1])
	by smtp-4.llnl.gov (8.12.3p2-20030917/8.12.3/LLNL evision: 1.13 $) with ESMTP id i0SJKPcK018212
	for <selinux@tycho.nsa.gov>; Wed, 28 Jan 2004 11:20:25 -0800 (PST)
Received: from [128.115.96.64] (account shakespeare2 [128.115.96.64] verified)
  by popcorn.llnl.gov (CommuniGate Pro SMTP 4.0.6)
  with ESMTP id 32319429 for selinux@tycho.nsa.gov; Wed, 28 Jan 2004 11:20:25 -0800
Mime-Version: 1.0
Message-Id: <p06020408bc3db651f5a5@[128.115.96.64]>
Date: Wed, 28 Jan 2004 11:20:24 -0800
To: selinux@tycho.nsa.gov
From: Mark Shakespeare <mshakes@llnl.gov>
Subject: making progress...a few comments..
Content-Type: text/plain; charset="us-ascii" ; format="flowed"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Been trying to automate the build process for a Fedora/Selinux system.
I'am also aware that Fedora core release 2 is coming in April and will
have Selinux integrated in it.

I build a basic vanilla Fedora core workstation from cd's, then download
Dan Walsh's selUpgrade script from ftp://people.redhat.com/dwalsh/SELinux/

In order for this script to run...

I had to install db4-4.2.25
I downloaded setools from www.tresys.com, in order to install BWidgets.

Some setools components required TK and TCL 8.3, while setools-gui
requires TK and TCL 8.4

I forced tk and tcl8.4 using the rpm -i --force....so both are installed.

The script now completes.....and we now have a bootable selinux system...

well sort of...
vi does not work....has a libperl.so error
id -Z does not work....says it can only be used on a selinux-enabled kernel
seaudit fails...something about a bad policy.conf file...


The also appears to be no logging for selinux related events.


Any suggestions are welcome.


Thanks.

								Mark
-- 
******************************************
* Mark Shakespeare			 *
* Engineering Computer Operations Team   *
* Lawrence Livermore National Laboratory *
* 7000 East Ave		L-130            *
* Livermore,Ca 94550			 *
* 925-423-9922	      mshakes@llnl.gov   *
******************************************

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
