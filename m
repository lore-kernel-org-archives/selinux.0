Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id IAA23033
	for <selinux@tycho.nsa.gov>; Wed, 9 Jan 2002 08:09:28 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id NAA04985
	for <selinux@tycho.nsa.gov>; Wed, 9 Jan 2002 13:08:39 GMT
Received: from jsmith.org (pool-141-158-43-197.phil.east.verizon.net [141.158.43.197])
	by jazzband.ncsc.mil  with ESMTP id NAA04981
	for <selinux@tycho.nsa.gov>; Wed, 9 Jan 2002 13:08:39 GMT
Subject: Odd problem with lsm-full-2001_12_10 on RH 7.2
From: Justin Smith <jsmith@mcs.drexel.edu>
To: selinux@tycho.nsa.gov
Content-Type: text/plain
Date: 09 Jan 2002 08:10:28 -0500
Message-Id: <1010581828.1483.10.camel@jsmith.org>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is an intermittent problem corrected (temporarily) by rebooting.
I don't know whether it is related to SELinux or just to the 2.4.16
kernel (or something else entirely). 

When I try to perform certain tasks (like edit the crontab), I get the
message

bash: /usr/bin/crontab: Cannot allocate memory



dmesg does not have any additional information (such as access denied
messages) --- it is blank.  I'm not even sure what the 'Cannot allocate
memory' message means since my machine has more than 300 meg of RAM, a
gigabyte of swap, and not all of the RAM is ever utilized.

Although crontab -e doesn't work, vi does (even though the crontab
program is attempting to use vi to edit the table).Several other system
functions (like installing software using rpm) also fail with the same
message.

Any ideas?
-- 
______________________________________________________________________
Time blows wildly against my door       | Justin R. Smith
Stirring discarded sorrows      	| Department of Mathematics and
Like dead leaves of summers past        |     Computer Science
Memories of forgotten lore          	| Drexel University
Making way for new tomorrows         	| Philadelphia, PA 19104
New hopes, new fears,                   |
         and new ways that last         | Office: (215) 895-1847
URL: http://vorpal.mcs.drexel.edu       | Fax:    (215) 895-1582



--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
