Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id o67BAKTK030805
	for <selinux@tycho.nsa.gov>; Wed, 7 Jul 2010 07:10:21 -0400
Received: from smtp.sws.net.au (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id o67B9ORd024982
	for <selinux@tycho.nsa.gov>; Wed, 7 Jul 2010 11:09:25 GMT
Received: from athena.localnet (localhost [127.0.0.1])
	by smtp.sws.net.au (Postfix) with ESMTP id 7CD6818050
	for <selinux@tycho.nsa.gov>; Wed,  7 Jul 2010 21:10:14 +1000 (EST)
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: "SE-Linux" <selinux@tycho.nsa.gov>
Subject: interface_info
Date: Wed, 7 Jul 2010 21:10:12 +1000
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Message-Id: <201007072110.12862.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

It seems to me that it's a bad idea to only have one interface_info file given 
that everyone supports at least two different policies (MLS and non-MLS).

For Debian I'm thinking of using /var/lib/sepolgen/$SELINUXTYPE.interface_info 
and having sepolgen-ifgen, audit2allow, and any other tools which use it 
default to the current version of $SELINUXTYPE from /etc/selinux/config.  
sepolgen-ifgen would also use /usr/share/selinux/$SELINUXTYPE/include/ .

Is there any good reason for not doing it this way?

-- 
russell@coker.com.au
http://etbe.coker.com.au/          My Main Blog
http://doc.coker.com.au/           My Documents Blog

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
