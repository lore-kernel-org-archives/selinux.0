Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n0J5p4tf011939
	for <selinux@tycho.nsa.gov>; Mon, 19 Jan 2009 00:51:04 -0500
Received: from etbe.coker.com.au (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id n0J5p0Lv025170
	for <selinux@tycho.nsa.gov>; Mon, 19 Jan 2009 05:51:02 GMT
Received: from aeon.coker.com.au (localhost [127.0.0.1])
	by etbe.coker.com.au (Postfix) with ESMTP id 4B5F018223
	for <selinux@tycho.nsa.gov>; Mon, 19 Jan 2009 16:50:53 +1100 (EST)
Received: from localhost (localhost [127.0.0.1])
	by aeon.coker.com.au (Postfix) with ESMTP id A3ADF215DB
	for <selinux@tycho.nsa.gov>; Mon, 19 Jan 2009 16:50:43 +1100 (EST)
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: "SE-Linux" <selinux@tycho.nsa.gov>
Subject: netstat -Z
Date: Sun, 18 Jan 2009 19:32:36 +1100
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200901181932.37457.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

The command "netstat -Z -t" will show two entries for a localhost connection 
and thus show the context of each end of the socket.

The command "netstat -Z -x" seems to only show a single entry for the 
connection which will be from the server end.

http://wiki.postgresql.org/wiki/SEPostgreSQL

The above wiki page mentions "netstat -Z" and my personal interpretation of 
this was that I could use "netstat -Z" to find the context of a client end of 
a socket.  But it seems that I can only get the server end.

Is this what is desired?

-- 
russell@coker.com.au
http://etbe.coker.com.au/          My Main Blog
http://doc.coker.com.au/           My Documents Blog


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
