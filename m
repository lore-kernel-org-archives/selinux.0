Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id RAA15188
	for <selinux@tycho.nsa.gov>; Sun, 13 May 2001 17:30:00 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id VAA07686
	for <selinux@tycho.nsa.gov>; Sun, 13 May 2001 21:29:58 GMT
Received: from tech1comm.com (ns1.tech1comm.com [216.17.159.2])
	by jazzswing.ncsc.mil  with ESMTP id VAA07682
	for <selinux@tycho.nsa.gov>; Sun, 13 May 2001 21:29:57 GMT
Received: from localhost (jpbazemo@localhost)
	by tech1comm.com (8.11.0/8.8.7) with ESMTP id f4DLPU512681
	for <selinux@tycho.nsa.gov>; Sun, 13 May 2001 15:25:30 -0600
Date: Sun, 13 May 2001 15:25:30 -0600 (MDT)
From: Jonathan Bazemore <jpbazemo@tech1comm.com>
To: selinux@tycho.nsa.gov
Subject: selinux and freeVSD
Message-ID: <Pine.LNX.4.21.0105131524490.12617-100000@tech1comm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


FreeVSD allows multiple virtual servers on one machine that are
partitioned off from each other.  Questions:

1. can selinux be used to secure the virtual servers running under
FreeVSD?

2. it is common for FreeVSD installs to be running PHP and MySQL--if the
answer to 1. above is even a qualified yes, can I do SQL queries with
selinux installed, and would selinux protect PHP vulnerabilities and deny
footprinting?

3. nightmare: someone gets root on a freeVSD system--it's not a
friend.  What do you do?



--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
