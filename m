Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id LAA26445
	for <selinux@tycho.nsa.gov>; Thu, 4 Jan 2001 11:38:26 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil (8.9.1/8.9.1) with ESMTP id QAA27601
	for <selinux@tycho.nsa.gov>; Thu, 4 Jan 2001 16:37:52 GMT
Received: from patan.sun.com (patan.Sun.COM [192.18.98.43])
	by jazzband.ncsc.mil (8.9.1/8.9.1) with ESMTP id QAA27597
	for <selinux@tycho.nsa.gov>; Thu, 4 Jan 2001 16:37:52 GMT
Received: from ezrh04.Swiss.Sun.COM ([129.156.52.2])
	by patan.sun.com (8.9.3+Sun/8.9.3) with ESMTP id IAA00817
	for <selinux@tycho.nsa.gov>; Thu, 4 Jan 2001 08:38:23 -0800 (PST)
Message-Id: <200101041638.RAA10295@ezrh04.Swiss.Sun.COM>
Date: Thu, 4 Jan 2001 17:38:22 +0100 (MET)
From: Harald von Fellenberg - Sun Switzerland Zurich - Technology Strategy Office <Harald.Von-Fellenberg@swiss.sun.com>
Reply-To: Harald von Fellenberg - Sun Switzerland Zurich - Technology Strategy Office <Harald.Von-Fellenberg@swiss.sun.com>
Subject: Missing header files
To: selinux@tycho.nsa.gov
Cc: Harald.Von-Fellenberg@swiss.sun.com
MIME-Version: 1.0
Content-Type: TEXT/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-ID: <selinux@tycho.nsa.gov>

Hi

Thanks for opening up your Secure Linux work to the public - a great idea to
raise interest in trusted OS's in this time.

I am trying to compile, of course. However, I seem to lack a few header files:
namely the files 
slinux/utils/pwdb-0.60/include/pwdb/pwdb_{unix,shadow,common}.h, all of which 
are called from slinux/utils/pwdb-0.60/include/pwdb/pwdb_map.h
Or did I miss something else?

BTW I like the whitepapers - excellent collateral material!

Thanks and regards, Harald

**********************************************************
 Dr. Harald von Fellenberg  
 Senior Consultant          Technology Strategy Office
 Tel:    ++41 1 908 9230    Sun Microsystems (Schweiz) AG
 Fax:    ++41 1 908 9001    Javastr. 2 
 Mobile: ++41 79 349 0393   CH-8604 Volketswil
 mailto:harald.von-fellenberg@sun.com
**********************************************************


--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
