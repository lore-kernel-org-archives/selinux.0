Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id LAA19823
	for <selinux@tycho.nsa.gov>; Mon, 11 Nov 2002 11:54:24 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id QAA05963
	for <selinux@tycho.nsa.gov>; Mon, 11 Nov 2002 16:52:22 GMT
Received: from pandora.snu.edu ([204.126.2.1])
	by jazzswing.ncsc.mil  with SMTP id QAA05959
	for <selinux@tycho.nsa.gov>; Mon, 11 Nov 2002 16:52:22 GMT
Message-Id: <sdcf8c41.028@atlas.snu.edu>
Date: Mon, 11 Nov 2002 10:53:11 -0600
From: "Joshua Brindle" <JBrindle@mail.snu.edu>
To: <selinux@tycho.nsa.gov>
Subject: SELinux distro building
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi, I'm trying to set up support for SELinux in Gentoo linux (a source
based distro with a ports system for installing everything). Basically
instead of delivering a prepackaged/compiled SELinux build it downloads
and compiles right then and installs. The problems are numerous though
and I kinda wanted your advice
1) it installs to /usr/local/selinux which is unacceptable, it needs to
go to /usr/selinux (thats easily taken care of by patches to the
Makefiles which i already did)
2) when compiling the selinux archive it needs libsecure to already be
installed (and to have copied the .h files from the lsm kernel) before
the policy compiler can be built. This is a problem because the ports
system wants to compile everything, install it to a fake root so that it
can enumerate the files for uninstallation, then copy them to the file
system.
3) the Makefiles do not respect INSTALLPREFIX (which i also patched
for, but it's dirty) because we *must* install to the fake root before
installing to the filesystem, otherwise the sandbox kills it for
permissions (which is it supposed to do)

it seems to me that the entire archive package desperatly needs a
configure system so that it will be a little more flexible. What is your
opinion on this?
Also, i haven't looked at the debian builds since i don't have any
debian machines but how did you handle these problems, or did you? 

Thanks for any information you can give me.


Joshua Brindle
UNIX Administrator
Southern Nazarene University

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
