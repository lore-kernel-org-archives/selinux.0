Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m56Bn04q005818
	for <selinux@tycho.nsa.gov>; Fri, 6 Jun 2008 07:49:01 -0400
Received: from nospam.sws.net.au (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id m56Bmq58023388
	for <selinux@tycho.nsa.gov>; Fri, 6 Jun 2008 11:48:59 GMT
Received: from localhost (localhost [127.0.0.1])
	by nospam.sws.net.au (Postfix) with ESMTP id 5B99918BE4
	for <selinux@tycho.nsa.gov>; Fri,  6 Jun 2008 21:48:49 +1000 (EST)
Received: from nospam.sws.net.au ([127.0.0.1])
	by localhost (etbe.coker.com.au [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id KPuBpSoWIUH2 for <selinux@tycho.nsa.gov>;
	Fri,  6 Jun 2008 21:48:49 +1000 (EST)
Received: from aeon.coker.com.au (localhost [127.0.0.1])
	by nospam.sws.net.au (Postfix) with ESMTP id 04B0318BDE
	for <selinux@tycho.nsa.gov>; Fri,  6 Jun 2008 21:48:48 +1000 (EST)
Received: from localhost (localhost [127.0.0.1])
	by aeon.coker.com.au (Postfix) with ESMTP id 97A6620E90
	for <selinux@tycho.nsa.gov>; Fri,  6 Jun 2008 21:48:47 +1000 (EST)
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: "SE-Linux" <selinux@tycho.nsa.gov>
Subject: SE Linux and GPG
Date: Fri, 6 Jun 2008 21:48:45 +1000
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200806062148.46818.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

http://etbe.coker.com.au/2008/06/06/se-linux-support-gpg/

After a delay of five years, we have some progress on GPG and SE Linux 
support.  The aim is to have SE Linux restrict access to the secret key.

The question that we are struggling with is when and how the secret key should 
be backed up.  Please read the above blog post, suggestions would be 
appreciated.

Werner is commenting on the post...

-- 
russell@coker.com.au
http://etbe.coker.com.au/          My Blog

http://www.coker.com.au/sponsorship.html Sponsoring Free Software development

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
