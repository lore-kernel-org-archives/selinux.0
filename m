Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id lA6LLqhc001947
	for <selinux@tycho.nsa.gov>; Tue, 6 Nov 2007 16:21:52 -0500
Received: from nospam.sws.net.au (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id lA6LLoLv007353
	for <selinux@tycho.nsa.gov>; Tue, 6 Nov 2007 21:21:51 GMT
Received: from localhost (localhost [127.0.0.1])
	by nospam.sws.net.au (Postfix) with ESMTP id D9B3C18B6C
	for <selinux@tycho.nsa.gov>; Wed,  7 Nov 2007 08:21:45 +1100 (EST)
Received: from nospam.sws.net.au ([127.0.0.1])
	by localhost (etbe.coker.com.au [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id pB4Qmiuwhvbp for <selinux@tycho.nsa.gov>;
	Wed,  7 Nov 2007 08:21:45 +1100 (EST)
Received: from aeon.coker.com.au (localhost [127.0.0.1])
	by nospam.sws.net.au (Postfix) with ESMTP id 7361918B66
	for <selinux@tycho.nsa.gov>; Wed,  7 Nov 2007 08:21:45 +1100 (EST)
Received: from localhost (localhost [127.0.0.1])
	by aeon.coker.com.au (Postfix) with ESMTP id ED163215F6
	for <selinux@tycho.nsa.gov>; Wed,  7 Nov 2007 08:21:43 +1100 (EST)
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: "SE-Linux" <selinux@tycho.nsa.gov>
Subject: removing default config entries
Date: Wed, 7 Nov 2007 08:21:41 +1100
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200711070821.43637.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

A comment was made on my previously mentioned Squid post about the apparent 
impossibility of removing default port entries via semanage, and there is a 
similar issue with removing default fcontext entries.

Are these fixed in a recent release of the libraries or planned to be fixed?  
I noticed that the same issue was recently fixed in regard to roles with 
login and user entries.

Sorry I'm busy preparing for a presentation so I didn't have time to try the 
latest code before posting.

-- 
russell@coker.com.au
http://etbe.coker.com.au/          My Blog

http://www.coker.com.au/sponsorship.html Sponsoring Free Software development

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
