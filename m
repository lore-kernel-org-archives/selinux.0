Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id o6IBwaZb022847
	for <selinux@tycho.nsa.gov>; Sun, 18 Jul 2010 07:58:36 -0400
Received: from smtp.sws.net.au (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id o6IBvU16002186
	for <selinux@tycho.nsa.gov>; Sun, 18 Jul 2010 11:57:31 GMT
Received: from athena.localnet (localhost [127.0.0.1])
	by smtp.sws.net.au (Postfix) with ESMTP id 9DF401811C
	for <selinux@tycho.nsa.gov>; Sun, 18 Jul 2010 21:58:17 +1000 (EST)
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: "SE-Linux" <selinux@tycho.nsa.gov>
Subject: libsemanage/src/genhomedircon.c and sensitivity
Date: Sun, 18 Jul 2010 21:58:16 +1000
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Message-Id: <201007182158.16830.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Why don't we have a TEMPLATE_SENSITIVITY defined to "s0" and appropriate 
pattern matching to apply the sensitivity level to all files for the user home 
directory?

Currently if a user has a low level for their sensitivity label which is 
higher than s0 then the default labeling of their home directory will deny 
access if the MMCS policy is in use.  Presumably the same problem hits MLS 
users.

-- 
russell@coker.com.au
http://etbe.coker.com.au/          My Main Blog
http://doc.coker.com.au/           My Documents Blog

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
