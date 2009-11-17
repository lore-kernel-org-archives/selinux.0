Received: from msux-gh1-uea01.nsa.gov (msux-gh1-uea01.nsa.gov [63.239.67.1])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id nAHDEfq4003025
	for <selinux@tycho.nsa.gov>; Tue, 17 Nov 2009 08:14:41 -0500
Received: from moss-lions.epoch.ncsc.mil (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id nAHDDdKE008187
	for <selinux@tycho.nsa.gov>; Tue, 17 Nov 2009 13:13:39 GMT
Received: from moss-lions.epoch.ncsc.mil (localhost.localdomain [127.0.0.1])
	by moss-lions.epoch.ncsc.mil (8.14.3/8.14.3) with ESMTP id nAHDDfmw005455
	for <selinux@tycho.nsa.gov>; Tue, 17 Nov 2009 08:13:41 -0500
Received: (from jwcart2@localhost)
	by moss-lions.epoch.ncsc.mil (8.14.3/8.14.3/Submit) id nAHDDffY005453
	for selinux@tycho.nsa.gov; Tue, 17 Nov 2009 08:13:41 -0500
Received: from msux-gh1-uea02.nsa.gov (msux-gh1-uea02.nsa.gov [63.239.67.2])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id nAHCEPaS027884
	for <selinux@tycho.nsa.gov>; Tue, 17 Nov 2009 07:14:25 -0500
Received: from smtp.sws.net.au (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id nAHCGRSO003547
	for <selinux@tycho.nsa.gov>; Tue, 17 Nov 2009 12:16:29 GMT
Received: from localhost (localhost [127.0.0.1])
	by smtp.sws.net.au (Postfix) with ESMTP id 2C77B1812C
	for <selinux@tycho.nsa.gov>; Tue, 17 Nov 2009 23:14:19 +1100 (EST)
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: "SE-Linux" <selinux@tycho.nsa.gov>
Subject: Debian SSH bugs
Date: Tue, 17 Nov 2009 23:14:09 +1100
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200911172314.16878.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=556644

I have just filed the above bug report against the version of openssh-server 
in Debian/Unstable (Squeeze).  It has a patch that moves the code to set the 
SE Linux context for the child process before calling chroot.  The same will 
be needed in Fedora if it's not there yet.

deb http://www.coker.com.au squeeze selinux

I've created the above APT repository for Squeeze which has a package that 
fixes this bug.

http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=498684

The above bug report has a fix for a trivial uninitialised variable bug.  Has 
this been fixed in Fedora yet?

http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=556648

Also I filed the above bug report about the internal version of sftp being 
incompatible with SE Linux (it doesn't involve an exec so the context doesn't 
change).

-- 
russell@coker.com.au
http://etbe.coker.com.au/          My Main Blog
http://doc.coker.com.au/           My Documents Blog

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
