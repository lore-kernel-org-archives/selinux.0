Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id LAA24475
	for <selinux@tycho.nsa.gov>; Tue, 6 Nov 2001 11:32:48 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id QAA05441
	for <selinux@tycho.nsa.gov>; Tue, 6 Nov 2001 16:32:41 GMT
Received: from odo.arl.psu.edu (safast.arl.psu.edu [146.186.247.61])
	by jazzswing.ncsc.mil  with ESMTP id QAA05437
	for <selinux@tycho.nsa.gov>; Tue, 6 Nov 2001 16:32:41 GMT
Received: from odo.arl.psu.edu (cobra.arl.psu.edu [146.186.247.39])
	by odo.arl.psu.edu (8.9.3/8.9.3) with ESMTP id GAA05179
	for <selinux@tycho.nsa.gov>; Tue, 6 Nov 2001 06:32:40 -0500
Message-ID: <3BE810A9.EAA3B410@odo.arl.psu.edu>
Date: Tue, 06 Nov 2001 11:32:41 -0500
From: "Timothy E. Kohler" <tim@odo.arl.psu.edu>
Reply-To: tim@odo.arl.psu.edu
MIME-Version: 1.0
To: "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>
Subject: New SELinux release???
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


Been trying to work with SELinux under RedHat 7.2.  I've
had compile problems with utils/fileutils-4.0.  Everything
worked fine under 7.1.  Get the following error:

make[1]: Entering directory `/usr/src/selinux/utils/fileutils-4.0'
cd . && aclocal -I m4
aclocal: m4/isc-posix.m4: 11: duplicated macro `AC_ISC_POSIX'
make[1]: *** [aclocal.m4] Error 1
make[1]: Leaving directory `/usr/src/selinux/utils/fileutils-4.0'


Anyone else observe this or is it just weirdness on my side?


-- 
___________________________________________________________________
Timothy E. Kohler
PSU Applied Research Lab
Communication Science & Technology
PO Box 30
State College, PA 16804-0030

TEL: (814) 863-6238
FAX: (814) 863-6239

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
