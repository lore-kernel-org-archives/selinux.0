Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id JAA20291
	for <selinux@tycho.nsa.gov>; Tue, 2 Apr 2002 09:15:19 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id OAA12793
	for <selinux@tycho.nsa.gov>; Tue, 2 Apr 2002 14:13:48 GMT
Received: from csoc-fire1.csoconline.com (csoc-mail-imc.csoconline.com [140.169.2.142])
	by jazzswing.ncsc.mil  with SMTP id OAA12783
	for <selinux@tycho.nsa.gov>; Tue, 2 Apr 2002 14:13:44 GMT
Message-ID: <72222DC86846D411ABD300A0C9EB08A10152432A@csoc-mail-box.csoconline.com>
From: "Westerman, Mark" <Mark.Westerman@csoconline.com>
To: selinux@tycho.nsa.gov
Subject: GDM
Date: Tue, 2 Apr 2002 08:15:22 -0600 
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I have created a new release for the gdm display manager.
The packages can be found at sourceforge.net/projects/selinux
The click on the download link on the GDM Redhat 7.2

gdm-2.2.3.1-20.i386.rpm			Binary rpm Installation 
gdm-2.2.3.1-20.src.rpm			Source rpm package
gdm-2.2.3.1-20.tgz			Compressed tared source


Modifications:
	1. Added support for the gdmconfig. You can turn on and 
	   off the window that allow the user to change there 
         selinux role.
	2. Added patches that were not included in the last release
		formatstrings.patch
		pamcfg.patch
		rhconfig.patch
		runningunder.patch
		sessions1.patch
		ukrainain.patch
	3. Created rpm packages. You can install the binary rpm. The
	   packages does not make any modifications to policy files.
         (We need a standard location, and a better method of integrating
          packages with policies. (i.e. I think the selinux build should
          put policy and setfiles directory in the /usr/local/selinux
directory)

Mark Westerman

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
