Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id QAA03281
	for <selinux@tycho.nsa.gov>; Fri, 29 Nov 2002 16:25:09 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id VAA00598
	for <selinux@tycho.nsa.gov>; Fri, 29 Nov 2002 21:23:05 GMT
Received: from prserv.net (asmtp1.prserv.net [32.97.166.51])
        by jazzband.ncsc.mil  with ESMTP id VAA00594 for <selinux@tycho.nsa.gov>; Fri, 29 Nov 2002 21:23:05 GMT
Message-Id: <200211292123.VAA00594@jazzband.ncsc.mil>
Date: Fri, 29 Nov 2002 16:21:27 -0500
From: "Subba Rao" <sailorn@attglobal.net>
To: selinux <selinux@tycho.nsa.gov>
Subject: SELinux compile errors
Mime-Version: 1.0
Content-Type: text/plain;
      charset="us-ascii"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hello again

I have reinstalled Slackware 8.1 from scratch so that I have the default libraries to install SELinux.
The source tree I have used is lsm-2-4-selinux-2002102211.tgz  (option 1)  (When I extract I get "lsm-2.4" and "selinux"
directories)

The following are the sequence of steps I have followed to get compile SELinux

cd selinux/module
make insert
cd ../..

cd lsm-2.4
make menuconfig (configured my kernel)
make dep
make
make modules
make install
make modules_install

cd ../selinux
cd modules
make install

cd ../policy
vi users (deleted the example users and added my userid to the list)
make install-src install

cd ..
cd libsecure
make
make install

cd ..
cd utils
make


This is where I have stopped since I get the following error message:

--------------------------------------
make -C newrole
make[1]: Entering directory `/usr/src/selinux/utils/newrole'
cc -L/usr/local/selinux/lib -Wall -I/usr/local/selinux/include -DUSE_PAM -O3 -o newrole newrole.c -ldl -lpam -lpam_misc -lsecure
newrole.c:132: security/pam_appl.h: No such file or directory
newrole.c:133: security/pam_misc.h: No such file or directory
make[1]: *** [newrole] Error 1
make[1]: Leaving directory `/usr/src/selinux/utils/newrole'
make: *** [xnewrole] Error 2
--------------------------------------

It looks like it is looking for PAM library.

Can someone please let me know how to get over this error.  Yesterday after I installed PAM, this message went away, but then I was prompted for Kerberos and later for BSD library.  Russell did mention that there is no need for Kerberos, so this time I am stopping before having to install PAM.  I am using Slackware 8.1 distro.
 
Thank you in advance for any help.

Subba Rao
sailorn@attglobal.net
2002-11-29



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
