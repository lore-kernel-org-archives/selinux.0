Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id IAA23707
	for <selinux@tycho.nsa.gov>; Fri, 21 Sep 2001 08:44:57 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id MAA18849
	for <selinux@tycho.nsa.gov>; Fri, 21 Sep 2001 12:44:30 GMT
Received: from eclipse.ncsc.mil (shuttle.eclipse.ncsc.mil [144.51.102.80])
	by jazzband.ncsc.mil  with ESMTP id MAA18845
	for <selinux@tycho.nsa.gov>; Fri, 21 Sep 2001 12:44:30 GMT
Received: from star (star [144.51.102.85])
	by eclipse.ncsc.mil (YOU_CAN/BYTE_ME) with SMTP id IAA15519
	for <selinux@tycho.nsa.gov>; Fri, 21 Sep 2001 08:46:26 -0400 (EDT)
Message-Id: <200109211246.IAA15519@eclipse.ncsc.mil>
Date: Fri, 21 Sep 2001 08:46:26 -0400 (EDT)
From: "James J." <jjohnson@eclipse.ncsc.mil>
Reply-To: "James J." <jjohnson@eclipse.ncsc.mil>
Subject: compiling LSM/SELinux fileutils
To: selinux@tycho.nsa.gov
MIME-Version: 1.0
Content-Type: TEXT/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


If this is not the proper list for a SELinux compile question please 
direct me to a better list.

I'm trying to compile the "Option 3 - Everything but Kernel Source" code 
and am running into trouble compiling in utils/fileutils-4.0.  I'm 
following the steps in the README file.  All goes well until step 6 
(Build and install the modified applications.)

I have made one deviation from the steps in the README.  The system is 
very stripped down, so logrotate, openssh, stat, and vixie-cron are not 
on the system.  I have eliminated these programs from the SUBDIRS line 
in the Makefile.
  
The first problem is that "make" fails because code in 
fileutils-4.0/aclocal.m4 is duplicated in fileutils-4.0/m4/isc-posix.m4. 
 Inserting "dnl " in front of lines 519-527 of aclocal.m4 (i.e. 
commenting out the duplicated lines) appears to fix this problem.  Is 
there a better solution?

The second problem is that "make" fails while running autoheader.  Here 
is the error message:

make[1]: Entering directory '/usr/src/selinux/utils/fileutils-4.0'
cd . && autoheader
autoheader: No template for symbol 'const'
autoheader: No template for symbol 'mode_t'
autoheader: No template for symbol 'off_t'
autoheader: No template for symbol 'size_t'
make[1]: *** [stamp-h.in] Error 1
make[1]: Leaving directory '/usr/src/selinux/utils/fileutils-4.0'
make: *** [all] Error 1

I'm not familiar with autoheader, so I'm having some difficulty 
diagnosing this problem.  Any ideas?

James



--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
