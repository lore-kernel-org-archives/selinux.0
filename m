Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m2AJOv9X001019
	for <selinux@tycho.nsa.gov>; Mon, 10 Mar 2008 15:24:57 -0400
Received: from ppsw-9.csi.cam.ac.uk (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id m2AJOo0u021994
	for <selinux@tycho.nsa.gov>; Mon, 10 Mar 2008 19:24:50 GMT
Received: from mpo25.trin.private.cam.ac.uk ([172.16.113.134]:49393)
	by ppsw-9.csi.cam.ac.uk (ppsw.cam.ac.uk [131.111.8.139]:25)
	with esmtp id 1JYmQB-0003Ep-VL (Exim 4.67) for selinux@tycho.nsa.gov
	(return-path <martin@martinorr.name>); Mon, 10 Mar 2008 18:08:23 +0000
Message-ID: <47D57913.2080809@martinorr.name>
Date: Mon, 10 Mar 2008 18:08:19 +0000
From: Martin Orr <martin@martinorr.name>
MIME-Version: 1.0
To: SELinux List <selinux@tycho.nsa.gov>
CC: selinux-devel@lists.alioth.debian.org
Subject: Refpolicy quilt series for Debian
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I have published the patches I am using to reference policy, on Debian sid.
 This includes all the patches from Manoj's official Debian package, split
out into a quilt series.

You can browse the patches at
http://www.martinorr.name/selinux/patches/
or download them all at
http://www.martinorr.name/selinux/patches/patches.tar.gz

For explanation:
1* are patches ready for submission to refpolicy SVN
2* are things that need a bit more work before going to SVN
3*, 4* are from the Debian package
5* are my patches on top of the Debian package
9* are things I use locally, not intended to be merged by anyone else

Best wishes,

-- 
Martin Orr

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
