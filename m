Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id KAA07737
	for <selinux@tycho.nsa.gov>; Tue, 3 Dec 2002 10:58:31 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id PAA19808
	for <selinux@tycho.nsa.gov>; Tue, 3 Dec 2002 15:56:28 GMT
Received: from jsmith.org (pool-141-158-42-116.phil.east.verizon.net [141.158.42.116])
        by jazzband.ncsc.mil  with ESMTP id PAA19804 for <selinux@tycho.nsa.gov>; Tue, 3 Dec 2002 15:56:27 GMT
Received: from jsmith.org (jsmith.org [127.0.0.1])
	by jsmith.org (8.12.5/8.12.5) with ESMTP id gB3FuDI5002058
	for <selinux@tycho.nsa.gov>; Tue, 3 Dec 2002 10:56:13 -0500
Subject: Systrace
From: Justin Smith <jsmith@mcs.drexel.edu>
To: selinux@tycho.nsa.gov
Content-Type: text/plain
Date: 03 Dec 2002 10:56:13 -0500
Message-Id: <1038930973.2041.2.camel@jsmith.org>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I came across the Systrace site

http://www.citi.umich.edu/u/provos/systrace/

and it strikes me as somewhat similar to SELinux: although it lacks
roles, it does intercept system calls and file accesses and apply access
criteria. It seems to me that the most significant difference between
systrace and SELinux is the lack of domains for running processes. On
the other hand, one can specify which programs to monitor.
-- 



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
