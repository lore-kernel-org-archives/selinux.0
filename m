Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id p7ID02xm029125
	for <selinux@tycho.nsa.gov>; Thu, 18 Aug 2011 09:00:02 -0400
Received: from smtp.sws.net.au (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id p7ID00Hp017035
	for <selinux@tycho.nsa.gov>; Thu, 18 Aug 2011 13:00:01 GMT
Received: from athena.localnet (localhost [127.0.0.1])
	by smtp.sws.net.au (Postfix) with ESMTP id BACB518050
	for <selinux@tycho.nsa.gov>; Thu, 18 Aug 2011 22:59:52 +1000 (EST)
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: "SE-Linux" <selinux@tycho.nsa.gov>
Subject: install
Date: Thu, 18 Aug 2011 22:59:57 +1000
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Message-Id: <201108182259.58177.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=638304

I've reported a bug against coreutils regarding the SE Linux support in 
install(1).  In summary my main problem is that there is no way of using 
install to copy a file without bothering with it's SE Linux context.  For 
creating Debian packages (which can't store SE Linux contexts) I don't want to 
set the context to some specific value (which would differ depending on who 
builds it) and "preserving" the context won't always work either (EG I could 
use install(1) to copy a file to which I have read-only access).

As well as this it's not documented well enough.

-- 
My Main Blog         http://etbe.coker.com.au/
My Documents Blog    http://doc.coker.com.au/

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
