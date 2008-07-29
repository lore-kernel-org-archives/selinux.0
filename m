Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m6T8oaoB001777
	for <selinux@tycho.nsa.gov>; Tue, 29 Jul 2008 04:50:36 -0400
Received: from nospam.sws.net.au (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id m6T8oXFO023749
	for <selinux@tycho.nsa.gov>; Tue, 29 Jul 2008 08:50:34 GMT
Received: from localhost (localhost [127.0.0.1])
	by nospam.sws.net.au (Postfix) with ESMTP id BEDD2180BC
	for <selinux@tycho.nsa.gov>; Tue, 29 Jul 2008 18:50:32 +1000 (EST)
Received: from nospam.sws.net.au ([127.0.0.1])
	by localhost (etbe.coker.com.au [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id MooInootAi-Z for <selinux@tycho.nsa.gov>;
	Tue, 29 Jul 2008 18:50:32 +1000 (EST)
Received: from aeon.coker.com.au (localhost [127.0.0.1])
	by nospam.sws.net.au (Postfix) with ESMTP id 5A9A0180AB
	for <selinux@tycho.nsa.gov>; Tue, 29 Jul 2008 18:50:32 +1000 (EST)
Received: from localhost (localhost [127.0.0.1])
	by aeon.coker.com.au (Postfix) with ESMTP id D1FD821982
	for <selinux@tycho.nsa.gov>; Tue, 29 Jul 2008 18:50:30 +1000 (EST)
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: "SE-Linux" <selinux@tycho.nsa.gov>
Subject: unconfined_t and user_home_dir_type
Date: Tue, 29 Jul 2008 18:50:28 +1000
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200807291850.30191.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Currently we have the attributes user_home_dir_type and user_home_type applied 
to the main types for the home directory of regular users in a strict policy 
configuration (this means user_t etc).

While it is possible to have unconfined_t and user_t on the same system, I 
don't expect this to be a common configuration.  In fact I expect that in 
practice they will be mutually exclusive.

Therefore when unconfined_t is used it will be desired that they can do all 
normal things, such as having a POP server read mail from their ~/Maildir.  
Allowing such access would mean adding user_home_dir_type and user_home_type 
attributes to unconfined_home_dir_t and unconfined_home_t respectively.

Is there any reason for not doing this?

-- 
russell@coker.com.au
http://etbe.coker.com.au/          My Blog

http://www.coker.com.au/sponsorship.html Sponsoring Free Software development

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
