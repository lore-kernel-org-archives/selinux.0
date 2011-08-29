Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id p7TDgTbq013666
	for <selinux@tycho.nsa.gov>; Mon, 29 Aug 2011 09:42:30 -0400
Received: from smtp.sws.net.au (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id p7TDgRIS018342
	for <selinux@tycho.nsa.gov>; Mon, 29 Aug 2011 13:42:28 GMT
Received: from athena.localnet (localhost [127.0.0.1])
	by smtp.sws.net.au (Postfix) with ESMTP id A731E18022
	for <selinux@tycho.nsa.gov>; Mon, 29 Aug 2011 23:42:24 +1000 (EST)
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: "SE-Linux" <selinux@tycho.nsa.gov>
Subject: hidden_def and libselinux
Date: Mon, 29 Aug 2011 23:42:21 +1000
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Message-Id: <201108292342.22701.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

A build of libselinux 2.1.0 fails on Debian because of new symbols.

setrans_lib_destructor() and matchpathcon_lib_destructor() look like good 
candidates for hidden_def (or something similar) as it doesn't seem possible 
to call them from outside the library.  What do you think?

There are a bunch of other new symbols that just need to be added to the 
symbol list.

-- 
My Main Blog         http://etbe.coker.com.au/
My Documents Blog    http://doc.coker.com.au/

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
