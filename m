Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i5GIhnrT005059
	for <selinux@tycho.nsa.gov>; Wed, 16 Jun 2004 14:43:49 -0400 (EDT)
Received: from smtp-bedford.mitre.org (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i5GIhkot006639
	for <selinux@tycho.nsa.gov>; Wed, 16 Jun 2004 18:43:46 GMT
Received: from smtp-bedford.mitre.org (localhost.localdomain [127.0.0.1])
	by smtp-bedford.mitre.org (8.11.6/8.11.6) with ESMTP id i5GIhli23881
	for <selinux@tycho.nsa.gov>; Wed, 16 Jun 2004 14:43:47 -0400
Received: from MAILHUB2 (mailhub2.mitre.org [129.83.221.18])
	by smtp-bedford.mitre.org (8.11.6/8.11.6) with ESMTP id i5GIhkv23853
	for <selinux@tycho.nsa.gov>; Wed, 16 Jun 2004 14:43:46 -0400
Message-Id: <200406161843.i5GIhkv23853@smtp-bedford.mitre.org>
From: "Bryan Zeigler" <bzeigler@mitre.org>
To: <selinux@tycho.nsa.gov>
Subject: Question about selinux & the new kernel crash exploit
Date: Wed, 16 Jun 2004 14:43:42 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi,
 
Based on papers I've read, I understand that one of the goals of SE Linux is
keeping processes separate.  So what happens in one domain shouldn't affect
other domains.  I was informed of a short bit of code that can crash the
kernel (at
http://reviewed.homelinux.org/news/2004-06-11_kernel_crash/index.html.en ).
When executing this code as just a normal user, it still completely crashes
the system.  Shouldn't the crash only be seen by the user that executed the
code?  It seems some people recommend SE Linux for systems that may not be
updated so often.  However, in this case, SE Linux doesn't seem to protect
much more than regular Linux.  Is there anyway to stop these types of things
using SE Linux policies (short of not allowing it to execute at all)?

Thanks



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
