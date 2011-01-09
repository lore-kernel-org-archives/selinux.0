Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id p095uasK030419
	for <selinux@tycho.nsa.gov>; Sun, 9 Jan 2011 00:56:36 -0500
Received: from smtp.sws.net.au (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id p095uWa0003453
	for <selinux@tycho.nsa.gov>; Sun, 9 Jan 2011 05:56:34 GMT
Received: from athena.localnet (localhost [127.0.0.1])
	by smtp.sws.net.au (Postfix) with ESMTP id 0A17718074
	for <selinux@tycho.nsa.gov>; Sun,  9 Jan 2011 16:56:24 +1100 (EST)
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: "SE-Linux" <selinux@tycho.nsa.gov>
Subject: iodine and SE Linux
Date: Sun, 9 Jan 2011 16:56:20 +1100
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Message-Id: <201101091656.21062.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I notice that iodine (IP over DNS tunnel daemon) has sample SE Linux policy 
and a SE Linux patch to the source code.

The way it works is that you give iodine a -z parameter with the context that 
you want and it then calls setcon() to get it.

What I am thinking of doing is writing policy for iodine, icmptx, and any 
other daemon that operates in a similar manner that has an automatic domain 
transition and no setcon().  I am thinking of making this tunnel_t.

What do you think?

-- 
russell@coker.com.au
http://etbe.coker.com.au/          My Main Blog
http://doc.coker.com.au/           My Documents Blog

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
