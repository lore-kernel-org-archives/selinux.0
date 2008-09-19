Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m8JBFng7029488
	for <selinux@tycho.nsa.gov>; Fri, 19 Sep 2008 07:15:50 -0400
Received: from etbe.coker.com.au (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id m8JBFkbr017639
	for <selinux@tycho.nsa.gov>; Fri, 19 Sep 2008 11:15:48 GMT
Received: from aeon.coker.com.au (localhost [127.0.0.1])
	by etbe.coker.com.au (Postfix) with ESMTP id 1E1151807B
	for <selinux@tycho.nsa.gov>; Fri, 19 Sep 2008 21:15:41 +1000 (EST)
Received: from localhost (localhost [127.0.0.1])
	by aeon.coker.com.au (Postfix) with ESMTP id 7CF6121FC5
	for <selinux@tycho.nsa.gov>; Fri, 19 Sep 2008 21:15:38 +1000 (EST)
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: "SE-Linux" <selinux@tycho.nsa.gov>
Subject: apol and linking
Date: Fri, 19 Sep 2008 21:15:35 +1000
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200809192115.37850.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I have a policy problem that only seems to occur in a particular modular 
configuration.  It ends up with attribute A being allowed access to attribute 
B which grants something I don't desire.

How can I determine what the attribute names are with apol?  When I use the 
policy.23 file the relevant data is gone.  Can I give it a base.pp and a set 
of modules and have it do the link itself?  If so how?

-- 
russell@coker.com.au
http://etbe.coker.com.au/          My Blog

http://www.coker.com.au/sponsorship.html Sponsoring Free Software development

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
