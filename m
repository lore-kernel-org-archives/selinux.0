Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i17CYcRb027643
	for <selinux@tycho.nsa.gov>; Sat, 7 Feb 2004 07:34:38 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id i17CYbOi007428
	for <selinux@tycho.nsa.gov>; Sat, 7 Feb 2004 12:34:37 GMT
Received: from mx1.redhat.com (mx1.redhat.com [66.187.233.31])
        by jazzband.ncsc.mil  with ESMTP id i17CYbWW007425 for <selinux@tycho.nsa.gov>; Sat, 7 Feb 2004 12:34:37 GMT
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.11.6/8.11.6) with ESMTP id i17CYab26073
	for <selinux@tycho.nsa.gov>; Sat, 7 Feb 2004 07:34:36 -0500
Received: from mail.boston.redhat.com (mail.boston.redhat.com [172.16.64.12])
	by int-mx1.corp.redhat.com (8.11.6/8.11.6) with ESMTP id i17CYaa27485
	for <selinux@tycho.nsa.gov>; Sat, 7 Feb 2004 07:34:36 -0500
Received: from redhat.com (dwalsh.cipe.redhat.com [10.0.2.138])
	by mail.boston.redhat.com (8.12.8/8.12.8) with ESMTP id i17CYZ02003431
	for <selinux@tycho.nsa.gov>; Sat, 7 Feb 2004 07:34:36 -0500
Message-ID: <4024DB5B.40407@redhat.com>
Date: Sat, 07 Feb 2004 07:34:35 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: SE Linux <selinux@tycho.nsa.gov>
Subject: A new kernel with FS patch available.
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

ftp://people.redhat.com/dwalsh/SELinux/Fedora/kernel-2.6.1-1.65.1.selinux.i686.rpm
 Fixes the file system corruption caused by extended attributes.  If you 
are running software from my sight you should upgrade to this kernel or 
do a yum update with it.   Then you should force a fcsk of your file 
system.  After it is done cleaning it up, you should relabel.

Sorry about the inconvenience.

Dan

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
