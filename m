Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h3FGeQI4027217
	for <selinux@tycho.nsa.gov>; Tue, 15 Apr 2003 12:40:26 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h3FGeP7R024699
	for <selinux@tycho.nsa.gov>; Tue, 15 Apr 2003 16:40:25 GMT
Received: from moss-sooners.epoch.ncsc.mil (moss-sooners.epoch.ncsc.mil [144.51.25.14])
        by jazzband.ncsc.mil  with ESMTP id h3FGeOKP024696 for <selinux@tycho.nsa.gov>; Tue, 15 Apr 2003 16:40:24 GMT
Received: from moss-sooners.epoch.ncsc.mil (moss-sooners.epoch.ncsc.mil [127.0.0.1])
	by moss-sooners.epoch.ncsc.mil (8.12.8/8.12.8) with ESMTP id h3FGeNCo012754
	for <selinux@tycho.nsa.gov>; Tue, 15 Apr 2003 12:40:23 -0400
Received: (from hdholm@localhost)
	by moss-sooners.epoch.ncsc.mil (8.12.8/8.12.8/Submit) id h3FGeN2u012752
	for selinux@tycho.nsa.gov; Tue, 15 Apr 2003 12:40:23 -0400
Subject: Help for setools 0.8
From: Keisuke Inoue <kinoue@ecs.syr.edu>
To: "'SELinux'" <SELinux@tycho.nsa.gov>
Content-Type: text/plain
Date: 15 Apr 2003 11:49:24 -0400
Message-Id: <1050421764.13940.63.camel@vetch>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hello,

I am Keisuke Inoue, a student in Syracuse University, NY.
I am trying to use the setools 0.8, and cannot figure out what is wrong:

     # apol
     Error in StartScript (/usr/local/lib/apol//apol.tcl): 

     If APOL_INSTALL_DIR is set, make sure directory is correct

I am using 2.4 LSM based kernel, Debian unstable, with Russell Coker's
SELinux packages. Makefile was changed accordingly, but I haven't done
anything else.

    TCL_INCLUDE	= -I/usr/include/tcl8.3
    TCL_LIBINC	= -L/usr/lib/tcl8.3 
    YACC	= bison-1.35 -y 

    POLICY_SRC_DIR  = /etc/selinux

Thank you very much,

K



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
