Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id o6A0N7qE003170
	for <selinux@tycho.nsa.gov>; Fri, 9 Jul 2010 20:23:08 -0400
Received: from smtp.sws.net.au (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id o6A0MAJ2016091
	for <selinux@tycho.nsa.gov>; Sat, 10 Jul 2010 00:22:11 GMT
Received: from athena.localnet (localhost [127.0.0.1])
	by smtp.sws.net.au (Postfix) with ESMTP id 164EA180DD
	for <selinux@tycho.nsa.gov>; Sat, 10 Jul 2010 10:22:47 +1000 (EST)
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: "SE-Linux" <selinux@tycho.nsa.gov>
Subject: recommending interfaces for audit2allow
Date: Sat, 10 Jul 2010 10:22:45 +1000
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Message-Id: <201007101022.46235.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

corenet_tcp_connect_mysqld_port(foo_milter_t)

I think that we need a way for an interface file to recommend itself to have a 
higher priority for certain matches.  For example the above policy line does 
permit foo_milter_t to talk to a MySQL server on a different system.  But you 
probably want something like the following:

mysql_tcp_connect(foo_milter_t)
optional_policy(`
  mysql_stream_connect(foo_milter_t)
')

So it seems that audit2allow should know that mysql_tcp_connect() is a 
preferred option to corenet_tcp_connect_mysqld_port() and that having an 
option to connect to a Unix domain socket would be good.

Also maybe we should have a single interface with an optional section for 
MySQL client access.

-- 
russell@coker.com.au
http://etbe.coker.com.au/          My Main Blog
http://doc.coker.com.au/           My Documents Blog

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
