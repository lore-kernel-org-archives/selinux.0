Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id hB2CIjRb013577
	for <selinux@tycho.nsa.gov>; Tue, 2 Dec 2003 07:18:46 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id hB2CI5p5020526
	for <selinux@tycho.nsa.gov>; Tue, 2 Dec 2003 12:18:05 GMT
Received: from sornico (pat.zurich.ibm.com [195.176.20.45])
	by jazzswing.ncsc.mil  with ESMTP id hB2CI4t0020523
	for <selinux@tycho.nsa.gov>; Tue, 2 Dec 2003 12:18:05 GMT
Received: from [127.0.0.1] (helo=zurich.ibm.com)
	by sornico with esmtp (Exim 3.36 #1 (Debian))
	id 1AR9UA-0000Vy-00
	for <selinux@tycho.nsa.gov>; Tue, 02 Dec 2003 13:18:34 +0100
Message-ID: <3FCC831A.1070002@zurich.ibm.com>
Date: Tue, 02 Dec 2003 13:18:34 +0100
From: Chris Vanden Berghe <vbc@zurich.ibm.com>
MIME-Version: 1.0
To: SELinux Mail List <selinux@tycho.nsa.gov>
Subject: selinux-policy-default
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi,

Already mentioned this quickly on #selinux, but thought it would useful
to put it on the mailing list with some more info too.

I tried installing the new selinux version for kernel 2.6.0-test11 under
Debian.  Started by installing libselinux1 from Russells newselinux
archives, this worked just fine.  But when afterwards I tried installing
selinux-policy-default, then I got the error message below:

dpkg --install
/var/cache/apt/archives/selinux-policy-default_1%3a1.2.real-13_all.deb
(Reading database ... 112169 files and directories currently installed.)
Preparing to replace selinux-policy-default 1:1.2.real-13 (using
.../selinux-policy-default_1%3a1.2.real-13_all.deb) ...
Unpacking replacement selinux-policy-default ...
Setting up selinux-policy-default (1.2.real-13) ...
/etc/selinux does not exist, aborting!
run-parts: /etc/dpkg/postinst.d/selinux exited with return code 1
"/bin/run-parts --arg=selinux-policy-default /etc/dpkg/postinst.d"
failed: 256
dpkg: error processing selinux-policy-default (--install):
1Error running trigger postinst: No such file or directory
Errors were encountered while processing:
selinux-policy-default

Does anybody know how/when the /etc/selinux directory is supposed to be
created?

Tnx,
Chris.



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
